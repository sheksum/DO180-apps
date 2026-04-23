Opening (30 seconds)
"Wanted to walk you through where we are on the SSSD flapping. I've got some findings, something fixed, something blocked, and a decision I need from you."
The story (2-3 min)
What I found:
Three things were contributing. Two I've fixed:

A zombie replication agreement from an old failed install was hammering cpeg with retry attempts. Cleaned that up.
Some orphaned RUV entries on cpeg from prior install attempts. Cleaned those too.

The third is an SSSD bug I identified. When DNS SRV lookups fail — which they always do because corp DNS doesn't have delegation for ipa.calix.local — SSSD trips on a "name-less server" bug and goes offline. The _srv_ entry in every host's sssd.conf is what's triggering it.
Result so far: Frequency is way down. I've been monitoring plnx-admin actively and it's been stable.
The decision I need (main topic, 3-4 min)
Here's what I need your call on:
The right long-term fix is adding DNS delegation on corp DNS — that would make _srv_ work properly for every host. But I don't want to do that right now.
Reason: if delegation starts working, clients will dynamically discover all the IPA replicas via SRV. That includes the CentOS replicas we know have replication issues — sjc and others. Clients could end up talking to those and getting stale data.
So my recommendation is the tactical fix: Ansible run across the fleet to remove _srv_ from sssd.conf, plus clean up the stale pln-petipareplica reference that's still in there. Keeps everything pointed at cpeg explicitly. Predictable.
Once we clean up the replica topology and finish the migration, we can revisit the DNS delegation.
What I'd like from you: approval to run the Ansible. I'd canary on one host first, then maybe 5-10, then the full fleet in batches.
The blocker (if he asks)
The remaining piece is changelog corruption on cpeg. It's been there a while and it's what's blocking every replica install attempt I've tried — including pln-ipamaster. Opened a Red Hat case today, sev 3, case #04431394. Waiting on them.
The Palo Alto question
"Oh — that Palo Alto DPI thing you mentioned. Do you know when that went live? Worth checking if any of the incidents line up with it. The SIGSEGV in sssd_be from Monday is in SASL GSSAPI code, which is exactly where DPI would be inspecting packets. Could be nothing, could be something."
Closing
"That's the picture. Main thing I need is a yes or no on the Ansible, and the DPI date if you have it handy. Happy to take questions."

If conversation drifts
If he goes deep on the changelog: "Not much to do there until Red Hat engages. Worst case we reinitialize nan and ric from cpeg, but that's a last resort."
If he asks about migration timeline: "Honest answer — blocked until Red Hat. Every replica install is failing at the same step because of the changelog issue."
If he asks about CentOS replicas: "Sjc's been broken for a while, that's its own cleanup project. We should decide whether to reinitialize it or retire it. Probably a topic for another day."
If he asks how sure you are this is fixed: "The two things I cleaned up definitely helped — fleet incidents dropped noticeably. One incident last night though, so not fully resolved. The Ansible removes another class of failure, and the changelog is the remaining unknown."
