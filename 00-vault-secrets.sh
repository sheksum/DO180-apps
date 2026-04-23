Subject: SSSD offline incidents — update
Team,
Quick update on the SSSD backend going offline issue.
Things have quieted down quite a bit. Last incident I'm aware of was about 16 hours ago. Before that, we were getting hit multiple times a day. I've been actively monitoring the state of SSSD on plnx-admin and haven't observed any flaps in my current monitoring window.
Here's what I found and fixed on cpeg-ipareplica:
A failed pln-ipamaster install left a zombie replication agreement that kept hammering cpeg with retry attempts. That alone was generating a flood of errors every few seconds. Cleaned that up along with some orphaned RUV entries from prior install attempts.
Also found an SSSD bug that gets triggered when DNS SRV lookups fail (our corporate DNS doesn't have delegation for ipa.calix.local). The _srv_ entry in sssd.conf was poking the bug. Removed it from a test host and that eliminated one flavor of flap.
What I haven't been able to fix yet: cpeg's replication changelog has some corruption that's showing constant errors. It's probably contributing to the remaining intermittent issues, and it's blocking me from bringing up new IPA replicas (which would give us failover capacity).
Opened Red Hat case #04431394 for guidance on fixing the changelog. Waiting on them.
If anyone sees a new SSSD incident, grab the hostname and timestamp so I can cross-reference. Will keep you posted as Red Hat gets back to me.
Brian — can you share the date the Palo Alto DPI change went live? Want to cross-reference against the EOSM ticket timeline to see if there's correlation.
Thanks,
Haj
