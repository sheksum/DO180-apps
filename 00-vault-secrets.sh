From: Billy O'Shea <Billy.OShea@calix.com>
Date: Thursday, April 23, 2026 at 4:00 PM
To: Brian Wing <Brian.Wing@calix.com>; Manoja Kumar Barik <manoja.barik@calix.com>; Mike Jung <Mike.Jung@calix.com>; Haj Suma <haj.suma@calix.com>; Chetan Kudari <chetan.kudari@calix.com>; Deonna Thornton <deonna.thornton@calix.com>; Vinoth Kumar Sekar <vinoth.sekar@calix.com>; Anjali Kumari <ANJALI.KUMARI@calix.com>; Nathan Strong <Nathan.Strong@calix.com>; Jayway Ding <jayway.ding@calix.com>; Youtao Tang <Youtao.Tang@calix.com>; Jason Juillerat <Jason.Juillerat@calix.com>; Umair Kazim <umair.kazim@calix.com>
Cc: Kishore Kumar <kishore.kumar@calix.com>
Subject: Re: EOSM-47053 || Urgent Upgrade Required for Host pln-hoffman- CVE-2023-44487 (NGINX)
Hi Brian,

I agree that creating a baseline does not happen overnight.  Jayway is working through a first pass right now from a security perspective because we recognized that one does not exist today for use by any team.  Once that is complete and documented, it will be available for review here: (Admin) Knowledge Base - Linux Security Baseline - Security - Confluence  .  From there we will be looking for the Sys Admin teams (ITSM and EOSM) to review and approve or provide documented reasons  for each control as to why the security recommendation can't be done if that is the case.  Youtao maybe able to assist with a first pass review from an OPS perspective.  From there, once there is consensus for a baseline that can be applied broadly the teams will need to be ready to create, manage, automatically apply a script to all existing and new builds.  The script should run on cadence, for example daily, to ensure settings are enforced.  In the meantime Jayway can scan individual systems using a preloaded CIS scan from Qualys for cab requests that are urgent we can use this to ensure new systems meet standards at least for a point in time.  As this particular CAB request is security driven and also involves proxy systems It should probably wait until the baseline is available.  However, we do have this point in time audit only option available.

Thanks,

Billy O’Shea
Manager, Information Security
707-766-3344 desk
 
 
From: Brian Wing <Brian.Wing@calix.com>
Sent: Thursday, April 23, 2026 12:48 PM
To: Billy O'Shea <Billy.OShea@calix.com>; Manoja Kumar Barik <manoja.barik@calix.com>; Mike Jung <Mike.Jung@calix.com>; Haj Suma <haj.suma@calix.com>; Chetan Kudari <chetan.kudari@calix.com>; Deonna Thornton <deonna.thornton@calix.com>; Vinoth Kumar Sekar <vinoth.sekar@calix.com>; Anjali Kumari <ANJALI.KUMARI@calix.com>; Nathan Strong <Nathan.Strong@calix.com>; Jayway Ding <jayway.ding@calix.com>; Youtao Tang <Youtao.Tang@calix.com>; Jason Juillerat <Jason.Juillerat@calix.com>; Umair Kazim <umair.kazim@calix.com>
Cc: Kishore Kumar <kishore.kumar@calix.com>
Subject: RE: EOSM-47053 || Urgent Upgrade Required for Host pln-hoffman- CVE-2023-44487 (NGINX) 
 
Billy
I’d like to understand more about what your CIS baseline does to a linux system.  We’ll need to compare that and test against development and test systems to ensure there are not unintended consequences.
Thanks
Brian
 
From: Billy O'Shea <Billy.OShea@calix.com> 
Sent: Thursday, April 23, 2026 11:53 AM
To: Manoja Kumar Barik <manoja.barik@calix.com>; Mike Jung <Mike.Jung@calix.com>; Brian Wing <Brian.Wing@calix.com>; Haj Suma <haj.suma@calix.com>; Chetan Kudari <chetan.kudari@calix.com>; Deonna Thornton <deonna.thornton@calix.com>; Vinoth Kumar Sekar <vinoth.sekar@calix.com>; Anjali Kumari <ANJALI.KUMARI@calix.com>; Nathan Strong <Nathan.Strong@calix.com>; Jayway Ding <jayway.ding@calix.com>; Youtao Tang <Youtao.Tang@calix.com>; Jason Juillerat <Jason.Juillerat@calix.com>; Umair Kazim <umair.kazim@calix.com>
Cc: Kishore Kumar <kishore.kumar@calix.com>
Subject: Re: EOSM-47053 || Urgent Upgrade Required for Host pln-hoffman- CVE-2023-44487 (NGINX)
 
We need to have a CIS baseline script that deploys configurations to all Linux infrastructure systems.  It's also come to my attention that we may have windows systems that are not receiving all of our windows CIS group policy controls.  This was one of the main reasons we were excited about the merge to calix.local so that secure policies would be applied uniformly.  We need to work toward moving the inheritance block on Products Infra OU.  While windows policy is not a requirement for this specific conversation, it does highlight a gap in control requirements between the teams.  For this approval, I will be looking for Jayway to provide an CIS baseline analysis.  For future requests policy will need to be defined, scripted, and automatically applied to all windows and Linux systems that is the expectation.  
 
 
 
Thanks,
 
Billy O’Shea
Manager, Information Security
707-766-3344 desk
 
 

 
From: Manoja Kumar Barik <manoja.barik@calix.com>
Sent: Thursday, April 23, 2026 11:10 AM
To: Billy O'Shea <Billy.OShea@calix.com>; Mike Jung <Mike.Jung@calix.com>; Brian Wing <Brian.Wing@calix.com>; Haj Suma <haj.suma@calix.com>; Chetan Kudari <chetan.kudari@calix.com>; Deonna Thornton <deonna.thornton@calix.com>; Vinoth Kumar Sekar <vinoth.sekar@calix.com>; Anjali Kumari <ANJALI.KUMARI@calix.com>; Nathan Strong <Nathan.Strong@calix.com>
Cc: Kishore Kumar <kishore.kumar@calix.com>
Subject: Re: EOSM-47053 || Urgent Upgrade Required for Host pln-hoffman- CVE-2023-44487 (NGINX) 
 
Hi @Billy O’Shea
 
You are absolutely right, and we share the same goal: strengthening our infrastructure security by aligning with recognized standards such as the CIS benchmark.
Over the past two years, we have made significant progress in several key areas:
•	Patch Management – Regular cycles defined and enforced across operating systems, middleware, and applications.
•	Endpoint Monitoring & Logging – Centralized logging and monitoring established to detect anomalies and ensure visibility.
•	Authentication & Access Control – Centralized authentication, role based access control, and authorization workflows implemented.
These measures have already brought us to approximately 70–80% alignment with CIS requirements, and we continue to improve our security posture day by day. This request is part of that ongoing effort.
That said, full compliance cannot be achieved without this step. Patching, monitoring, and logging are core CIS components. While production systems will take time to cover the remaining benchmark requirements—due to the need for new setups, rollouts, and multiple approval processes—we are actively progressing. For new projects, we can immediately adopt these practices to ensure CIS compliance is built in from the outset.
Without this request, gaps will remain that prevent us from meeting the CIS benchmark. I strongly recommend moving forward to close those gaps and further strengthen our overall infrastructure security.
Thanks & regards,
Manoj.
 
From: Mike Jung <Mike.Jung@calix.com>
Date: Thursday, 16 April 2026 at 10:48 PM
To: Brian Wing <Brian.Wing@calix.com>; Haj Suma <haj.suma@calix.com>; Chetan Kudari <chetan.kudari@calix.com>; Manoja Kumar Barik <manoja.barik@calix.com>; Deonna Thornton <deonna.thornton@calix.com>; Vinoth Kumar Sekar <vinoth.sekar@calix.com>; Anjali Kumari <ANJALI.KUMARI@calix.com>; Nathan Strong <Nathan.Strong@calix.com>
Cc: Kishore Kumar <kishore.kumar@calix.com>; Billy O'Shea <Billy.OShea@calix.com>
Subject: RE: EOSM-47053 || Urgent Upgrade Required for Host pln-hoffman- CVE-2023-44487 (NGINX)
CC’ed Billy’s respond to this ticket:
 
https://calix.atlassian.net/browse/ITSM-61754
 
I have cut and pasted Billy’s response in case those on this email do not have access to the ITSM ticketing system:
 
Billy O'Shea 
April 16, 2026 at 9:52 AMInternal note
I’ve reviewed the request
•	Rules #1 and #2 are acceptable for Linux patch management via Red Hat Satellite. DNS usage is understood given dynamic infrastructure, but must remain scoped specifically to designated patching hosts.
•	Defender EDR outbound connectivity (Rule #4) should be treated as permanent, Linux only, and aligned with Microsoft’s documented Defender URLs.
•	SSH access (Rule #3) is acceptable provided it is restricted to the specified management host and not broadly exposed.
•	Expanding the source to the full subnet (10.172.16.0/28) is acceptable only if this VLAN is dedicated to patching/proxy infrastructure and not used for general purpose workloads.
 
Approval Preconditions (Required)
Since these Linux systems function as management and control plane infrastructure (patching and EDR), they must meet baseline security requirements prior to final approval or long term rule permanence.
1. Comprehensive CIS Benchmark Review and Baseline Definition (Required)
These systems are required to align with a CIS benchmark–based Linux baseline, with initial documentation being created in parallel by Jayway, and implementation coordinated with them.
This is not intended to be a minimum or partial implementation.
Specifically:
•	The entire CIS benchmark for the applicable Linux OS must be reviewed control by control.
•	For each CIS recommendation, the outcome must be explicitly documented as:
o	Implemented, or
o	Not Implemented — with a clear technical or operational justification.
This review must result in a documented Linux hardening baseline that is:
•	Explicit (no implied defaults)
•	Auditable
•	Reusable as a standard baseline for Linux infrastructure systems going forward, not just this host
The expectation is deliberate decisions, not selective adoption. Controls that are not appropriate for this environment are acceptable, but the decision must be explicit and justified. This baseline should be treated as a prerequisite (or immediate post deployment requirement), not an optional follow up.
2. Centralized Authentication and Privilege Management
We acknowledge that centralized Linux authentication is not yet universally available across the environment and that many systems currently rely on local accounts and, at times, shared credentials — which is a known gap.
For these systems:
•	Centralized authentication (IPA), where available, must be used.
•	If IPA is not immediately available:
o	Local account usage must be minimized
o	Root access must be restricted and auditable
o	A documented plan and timeline must exist to migrate to centralized authentication once feasible
Additionally:
•	No shared local accounts
•	No shared root credentials
•	Privileged access must be performed via individual user accounts with sudo, ensuring accountability and auditability
 
Alignment with the Jayway CIS baseline is a hard requirement and must be implemented before this request is considered finally approved or the rules treated as long term/permanent. A confirmation of implementation is sufficient at this stage; a full audit is not required.
With these conditions clearly noted and tracked, I’m supportive of proceeding with the CAB.

These conditions are not intended to delay the change, but to ensure that we do not introduce new persistent Linux infrastructure without aligning to the security standards we are actively trying to establish.
 
 
From: Brian Wing <Brian.Wing@calix.com>
Sent: Thursday, April 16, 2026 10:13 AM
To: Haj Suma <haj.suma@calix.com>; Chetan Kudari <chetan.kudari@calix.com>; Manoja Kumar Barik <manoja.barik@calix.com>; Deonna Thornton <deonna.thornton@calix.com>; Vinoth Kumar Sekar <vinoth.sekar@calix.com>; Anjali Kumari <ANJALI.KUMARI@calix.com>; Mike Jung <Mike.Jung@calix.com>; Nathan Strong <Nathan.Strong@calix.com>
Cc: Kishore Kumar <kishore.kumar@calix.com>
Subject: RE: EOSM-47053 || Urgent Upgrade Required for Host pln-hoffman- CVE-2023-44487 (NGINX)
 
@Mike Jung or @Nathan Strong Please advise.
 
From: Haj Suma <haj.suma@calix.com>
Sent: Thursday, April 16, 2026 6:47 AM
To: Brian Wing <Brian.Wing@calix.com>; Chetan Kudari <chetan.kudari@calix.com>; Manoja Kumar Barik <manoja.barik@calix.com>; Deonna Thornton <deonna.thornton@calix.com>; Vinoth Kumar Sekar <vinoth.sekar@calix.com>; Anjali Kumari <ANJALI.KUMARI@calix.com>
Cc: Kishore Kumar <kishore.kumar@calix.com>
Subject: Re: EOSM-47053 || Urgent Upgrade Required for Host pln-hoffman- CVE-2023-44487 (NGINX)
 
Hi Brian
 
Thanks for the update @Chetan Kudari
 
Just to clarify on the port 9090 point - DMZ content hosts don't actually need port 9090. That port is used exclusively for Satellite Server to communicate with the Capsule for management purposes. For content hosts like the Atlassian proxy servers, they only need port 443 to the capsule for package registration and updates.
 
I intentionally left Port 9090 not open on the capsule firewall  this is by design.
 
The real blocker right now is that the firewall rules between the DMZ hosts and the capsule haven't been opened yet. Once we get those in place, the proxy servers should be able to reach the capsule on port 443 and patching can proceed.
 
For reference, the rules needed are:
- 10.172.16.0/28 → 10.172.16.10 port 443
- 10.172.16.10 → 10.172.249.103 port 443
- 10.172.16.10 → 10.172.249.103 port 5646
 
Haj
