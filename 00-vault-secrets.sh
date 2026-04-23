Investigation summary:
Investigation of the recurring SSSD service failures identified three contributing factors on the IPA master (cpeg-ipareplica):

Zombie replication agreement from failed replica install — A prior failed pln-ipamaster installation left an orphaned replication agreement pointing to a non-existent host. This caused cpeg's Directory Server to retry replication sessions every few seconds, generating constant error traffic. Agreement was removed.
Orphaned RUV (Replication Update Vector) entries — Replica IDs 52, 56, and 57 from prior failed installations were still present in cpeg's replication topology. Cleaned using the cleanallruv task.
SSSD _srv_ failover bug — Client sssd.conf files contained _srv_ as a failover entry. When DNS SRV lookups fail (our corporate DNS does not have delegation for ipa.calix.local), SSSD triggers an internal bug (fo_get_server_hostent — "name-less server") that causes the domain to flap between Online and Offline. Validated by removing _srv_ from a test client.

Current state:
Incident frequency has significantly decreased following recent remediation. Active monitoring on plnx-admin shows stable Online status.
Outstanding issue:
The IPA master's replication changelog shows chronic corruption errors (clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog) occurring every 2 seconds. This has not been remediated and is suspected to contribute to remaining intermittent incidents. It also blocks new IPA replica installations, which fail at wait_for_entry timeout points.
Red Hat support:
Case #04431394 opened. Awaiting guidance on:

Repairing the changelog corruption on cpeg
Safe path to complete replica installations
Assessment of whether nan-ipareplica01 and ric-ipareplica01 need reinitialization

Workaround status:
SSSD restart is no longer required for recovery on hosts where _srv_ has been removed from sssd.conf. Fleet-wide _srv_ removal via Ansible is a potential follow-up action pending decision on whether to wait for Red Hat root-cause confirmation first.
