Title: IPA replica installation fails with wait_for_entry timeout; changelog CSN corruption on master

Severity: 2 (production - cannot install new replicas, blocks DR/HA plans)

Product: Red Hat Enterprise Linux 8 / Identity Management

Environment:
- Master: cpeg-ipareplica.ipa.calix.local (RHEL 8, IPA 4.9.13, 389-ds-base 1.4.3.39)
- Existing replicas: nan-ipareplica01, ric-ipareplica01 (appear green), sjc-ipareplica01 (broken)
- Attempted replica: pln-petipareplica.ipa.calix.local (RHEL 8, IPA 4.9.13)
- Fleet size: ~2000 SSSD clients
- History: migrated from CentOS master (pet-ipamaster) to current RHEL master (cpeg-ipareplica) some time ago

Issue Description:

ipa-replica-install consistently fails with wait_for_entry timeout on entries created on the master during install.

Attempt 1 (April 17, pln-ipamaster.ipa.calix.local):
- Failed at step 10/22 "setting up httpd keytab"
- Error: ipa-getkeytab returned non-zero exit status 11: 'Failed to add key to the keytab'

Attempt 2 (April 23, pln-petipareplica.ipa.calix.local):
- Pre-created host and HTTP service on cpeg before install
- Got past step 10/22 successfully
- Failed later with: wait_for_entry timeout on ldap://cpeg-ipareplica.ipa.calix.local:389 for cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
- Installer waited 300 seconds for the KDC master entry (created by installer on cpeg) to replicate back to pln-petipareplica's local DS. Entry never arrived.

Underlying Condition on cpeg:

DS error log shows constant repeating errors (every 2 seconds):
clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog (DB rc=-30988). If replication stops, the consumer may need to be reinitialized.

These errors appear for ALL replication agreements on cpeg. CSN ffffffff6f0b00140000 is missing from cpeg's changelog despite being expected by peer replicas.

Replication agreements show green status (Error (0) Replica acquired successfully: Incremental update started) but new entries created on cpeg do not propagate to new replicas in acceptable time windows.

What We Have Tried:
1. Removed orphaned pln-ipamaster replication agreement that was spamming cpeg
2. Cleaned zombie RUV entries (replica IDs 52, 56, 57) using cleanallruv task - succeeded
3. Full uninstall of pln-petipareplica between attempts
4. Pre-created host entry and HTTP service on cpeg before install (got past step 10 this time)
5. Verified network connectivity, DNS resolution, time sync between pln-petipareplica and cpeg

Current State of Failed Install:
- pln-petipareplica has partial install (DS, krb5kdc, kadmin, httpd all running, web UI loads)
- Web UI login fails: kinit: Pre-authentication failed: Cannot open file '/var/kerberos/krb5kdc/kdc.crt' (KDC cert from install step not present)
- ipa CLI fails: Minor code may provide more information, Minor (2529638926): KDC has no support for encryption type
- KDC log shows CLIENT_NOT_FOUND for legitimate client hosts that exist on cpeg (confirming replication drift)
- Host is registered in cpeg's topology

Additional Context:
Corporate network team recently enabled Palo Alto deep packet inspection. Timing correlation with replication issues is being investigated but not confirmed.

What We Need:
1. Guidance on repairing cpeg's changelog (missing CSN ffffffff6f0b00140000)
2. Safe path to complete pln-petipareplica replica install
3. Whether nan-ipareplica01 and ric-ipareplica01 need re-initialization
4. Whether existing topology health can be restored without destructive action

Attachments:
- sosreport from cpeg
- sosreport from pln-petipareplica
- /var/log/ipareplica-install.log from pln-petipareplica
- Recent /var/log/dirsrv/slapd-IPA-CALIX-LOCAL/errors from cpeg (last 24 hours)
