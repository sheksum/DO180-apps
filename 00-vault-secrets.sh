PAN DPI hasn’t been implemented yet in Petaluma, and site-to-site traffic is supposed to be excluded from DPI.
 
Regarding delegation of DNS for ipa.calix.local, talk to me more about this.  What would you suggest be done for that?
 
Thanks



Thanks Brian —
Ruling out PAN DPI is helpful.
On the DNS delegation for ipa.calix.local:
What it is today:
Our corporate DNS (plnwdc19a) is authoritative for calix.local but has no delegation for the ipa.calix.local subdomain. IPA has its own DNS servers (cpeg, nan, ric) that are authoritative for ipa.calix.local, but corporate DNS doesn't know to ask them.
What's broken because of it:
When any SSSD client queries its configured DNS server for _ldap._tcp.ipa.calix.local to find an IPA server, corp DNS returns NXDOMAIN. SSSD's _srv_ failover entry in sssd.conf then triggers an internal bug ("name-less server") that causes the domain to go offline. This is one of the contributing causes of the flapping we've been seeing.
The fix:
Add delegation records in corp DNS's calix.local zone:
ipa                     NS    cpeg-ipareplica.ipa.calix.local.
ipa                     NS    nan-ipareplica01.ipa.calix.local.
ipa                     NS    ric-ipareplica01.ipa.calix.local.
cpeg-ipareplica.ipa     A     172.23.49.10
nan-ipareplica01.ipa    A     <nan IP>
ric-ipareplica01.ipa    A     <ric IP>
The NS records tell corp DNS "for anything under ipa.calix.local, delegate to these servers." The A records are glue entries needed because the NS hostnames are themselves under the delegated zone.
Why I'm NOT recommending we do this right now:
If delegation starts working, SSSD's _srv_ lookups will succeed and start returning ALL our IPA replicas. That includes sjc-ipareplica01 (CentOS 7, broken replication) and any others with topology issues. Clients could end up talking to replicas serving stale data, which is worse than what we have today.
What I am recommending:
Short-term — run an Ansible playbook to remove _srv_ (and the stale pln-petipareplica reference) from sssd.conf across the fleet. Eliminates the SRV-lookup bug without the risk of exposing broken replicas.
Long-term — after we've cleaned up the replica topology (fix/retire sjc, finish the pln-ipamaster migration, confirm nan and ric are healthy) then add the DNS delegation as the proper fix.
Happy to walk through this on a call if easier.
Thanks,
Haj

Right now if any host on the corporate network asks corp DNS where to find an IPA server, corp DNS says 'I don't know.' Because ipa.calix.local is its own subdomain and corp DNS was never told that IPA's DNS servers are authoritative for it.
Delegation just means adding a few records in corp DNS that say 'for anything under ipa.calix.local, go ask these specific servers.' It's a pointer."
