# 1. Full sosreport (big, covers everything)
sudo sos report --batch --tmp-dir=/tmp

# 2. DS errors log (last 24 hours is fine, or copy the whole thing)
sudo cp /var/log/dirsrv/slapd-IPA-CALIX-LOCAL/errors /tmp/cpeg-ds-errors-$(date +%F).log

# 3. DS access log (compressed since it's huge)
sudo tar czf /tmp/cpeg-ds-access-$(date +%F).tgz /var/log/dirsrv/slapd-IPA-CALIX-LOCAL/access*


# 1. Full sosreport
sudo sos report --batch --tmp-dir=/tmp

# 2. The install log (this is what Red Hat most wants)
sudo cp /var/log/ipareplica-install.log /tmp/pln-petipareplica-install-$(date +%F).log

# 3. Also grab this if it exists
sudo cp /var/log/ipareplica-ca-install.log /tmp/pln-petipareplica-ca-install-$(date +%F).log 2>/dev/null


# From your laptop/jump box
scp cpeg-ipareplica:/tmp/sosreport-*.tar.xz ./
scp cpeg-ipareplica:/tmp/cpeg-*.log ./
scp cpeg-ipareplica:/tmp/cpeg-*.tgz ./

scp pln-petipareplica:/tmp/sosreport-*.tar.xz ./
scp pln-petipareplica:/tmp/pln-petipareplica-install*.log ./

scp sjcx-admin-old:/tmp/sosreport-*.tar.xz ./
scp sjcx-admin-old:/tmp/sjcx-abrt-*.tgz ./

redhat-support-tool addattachment -c <case_number> /tmp/sosreport-cpeg-*.tar.xz



Title: SSSD fleet-wide instability and replica install failures - IPA replication health issues on master

Severity: 3 (fleet stability significantly improved after recent remediation, occasional incidents still occurring - latest ticket 16 hours before case open)

Product: Red Hat Enterprise Linux 8 / Identity Management

Previous Related Case: #04408743 (closed) - earlier phases of this migration

Business Impact:
Fleet of ~2000 SSSD clients configured against cpeg. Multiple hosts experience 
periodic SSSD offline events causing "PAM account management error" and developer 
productivity loss. 15+ related incident tickets tracked under EOSM-55341, 55569, 
55635, 55679, 55696, 55707, 55902, 56147, 56149, 56300, 56320, 46372. Pattern 
continues as of April 23 (latest incident 16 hours ago). Exact number of affected 
hosts not yet quantified. Frequency has decreased significantly after recent 
remediation work.

Environment:
- Master: cpeg-ipareplica.ipa.calix.local (RHEL 8, IPA 4.9.13, 389-ds-base 1.4.3.39)
- Existing replicas: nan-ipareplica01, ric-ipareplica01 (appear green), sjc-ipareplica01 (broken)
- Fleet: ~2000 SSSD clients configured against cpeg
- History: migrated from CentOS master (pet-ipamaster) to RHEL master (cpeg-ipareplica)

Migration Context:

We are in the middle of migrating the IPA master role from cpeg-ipareplica 
(RHEL 8, IPA 4.9.13) to a new master pln-ipamaster (RHEL 9.3, IPA 4.12.2) 
as part of a datacenter consolidation from Petaluma to Plano. This migration 
has been in progress for several months and has encountered multiple install 
failures on pln-ipamaster.

Previous Red Hat case #04408743 (Cesar Goslawski, Ryan Burres) addressed 
earlier phases of this migration and is now closed. Today's issues are 
encountered in the continuation of that work.

Replica install attempts (pln-ipamaster, then pln-petipareplica as a simpler 
test) all fail at wait_for_entry timeout points in the install, consistent 
with replication propagation failures from cpeg. This is blocking both the 
master migration and any attempt to add replication capacity to help with 
the fleet SSSD flapping issue.

Root Cause Investigation:
Initial diagnosis identified multiple contributing factors:

1. Zombie replication agreement from failed pln-ipamaster install attempts was 
   spamming cpeg with replication retry attempts, generating permission-denied 
   errors every few seconds. Removed on April 17 - reduced flap frequency 
   significantly but did not eliminate.

2. SSSD client config had _srv_ failover entry that triggered fo_get_server_hostent 
   "name-less server" bug when corporate DNS SRV lookups failed (no delegation for 
   ipa.calix.local on corp DNS). Removing _srv_ from test client eliminated one 
   class of flap but not all.

3. Chronic changelog corruption on cpeg: DS error log shows constant errors every 
   2 seconds:
   clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog 
   (DB rc=-30988). If replication stops, the consumer may need to be reinitialized.

   These errors appear on ALL replication agreements. Suspected to be causing 
   periodic DS listener unresponsiveness that manifests as client SSSD offline 
   events.

Evidence of Ongoing Issue:
- Latest fleet incident: approximately 16 hours before this case (April 22/23)
- Replica install attempts fail with wait_for_entry timeouts consistent with 
  replication drift
- Attempted pln-petipareplica install today (April 23) failed at cn=KDC entry 
  replication timeout despite pre-creating required entries on cpeg

Failed Install Details:

Attempt 1 (April 17, pln-ipamaster.ipa.calix.local):
- Failed at step 10/22 "setting up httpd keytab"
- Error: ipa-getkeytab returned non-zero exit status 11: 'Failed to add key to the keytab'

Attempt 2 (April 23, pln-petipareplica.ipa.calix.local):
- Pre-created host and HTTP service on cpeg before install
- Got past step 10/22 successfully
- Failed with: wait_for_entry timeout for cn=KDC,cn=pln-petipareplica.ipa.calix.local,
  cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local (300 second timeout)

What We Have Tried:
1. Removed orphaned pln-ipamaster replication agreement (reduced load on cpeg)
2. Cleaned zombie RUV entries (replica IDs 52, 56, 57) using cleanallruv task
3. Full uninstall of pln-petipareplica between attempts
4. Pre-created host entry and HTTP service on cpeg before install
5. Verified network connectivity, DNS resolution, time sync
6. Removed _srv_ from test client sssd.conf (reduced flapping)

Current State of Failed Install (pln-petipareplica):
- DS, krb5kdc, kadmin, httpd all running (partial install)
- Web UI login fails: kinit Pre-authentication failed, missing /var/kerberos/krb5kdc/kdc.crt
- ipa CLI fails with "KDC has no support for encryption type"
- KDC log shows CLIENT_NOT_FOUND for legitimate client hosts that exist on cpeg 
  (confirming replication drift)

Additional Context:
Corporate network team recently enabled Palo Alto deep packet inspection. Timing 
correlation with incident pattern is being investigated. SIGSEGV crash observed 
in sssd_be on a SJC client host (CentOS 7) in sasl_gss_encode (libgssapiv2.so) 
on April 22 - may be related to DPI interfering with SASL GSSAPI wrapped packets.

What We Need:
1. Identification of root cause of fleet SSSD flapping - is the changelog 
   CSN corruption the source, or a symptom of something deeper?
2. Guidance on repairing cpeg's changelog (missing CSN ffffffff6f0b00140000)
3. Whether nan-ipareplica01 and ric-ipareplica01 need re-initialization
4. Safe path to complete pln-petipareplica/pln-ipamaster replica install - this 
   is blocking the in-progress master migration from cpeg to pln-ipamaster
5. Assessment of whether Palo Alto DPI on SASL/GSSAPI traffic could be 
   contributing to SSSD segfaults

Attachments:
- sosreport from cpeg
- sosreport from pln-petipareplica
- /var/log/ipareplica-install.log from pln-petipareplica
- /var/log/dirsrv/slapd-IPA-CALIX-LOCAL/errors from cpeg (last 24 hours)
- sosreport from sjcx-admin-old (SIGSEGV crash, April 22)
