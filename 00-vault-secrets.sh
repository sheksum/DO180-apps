
Billy O'Shea 
last week
Internal note


I’ve reviewed the request
Rules #1 and #2 are acceptable for Linux patch management via Red Hat Satellite. DNS usage is understood given dynamic infrastructure, but must remain scoped specifically to designated patching hosts.
Defender EDR outbound connectivity (Rule #4) should be treated as permanent, Linux‑only, and aligned with Microsoft’s documented Defender URLs.
SSH access (Rule #3) is acceptable provided it is restricted to the specified management host and not broadly exposed.
Expanding the source to the full subnet (10.172.16.0/28) is acceptable only if this VLAN is dedicated to patching/proxy infrastructure and not used for general‑purpose workloads.
Approval Preconditions (Required)
Since these Linux systems function as management and control‑plane infrastructure (patching and EDR), they must meet baseline security requirements prior to final approval or long‑term rule permanence.
1. Comprehensive CIS Benchmark Review and Baseline Definition (Required)
These systems are required to align with a CIS benchmark–based Linux baseline, with initial documentation being created in parallel by Jayway, and implementation coordinated with them.
This is not intended to be a minimum or partial implementation.
Specifically:
The entire CIS benchmark for the applicable Linux OS must be reviewed control‑by‑control.
For each CIS recommendation, the outcome must be explicitly documented as:
Implemented, or
Not Implemented — with a clear technical or operational justification.
This review must result in a documented Linux hardening baseline that is:
Explicit (no implied defaults)
Auditable
Reusable as a standard baseline for Linux infrastructure systems going forward, not just this host
The expectation is deliberate decisions, not selective adoption. Controls that are not appropriate for this environment are acceptable, but the decision must be explicit and justified. This baseline should be treated as a prerequisite (or immediate post‑deployment requirement), not an optional follow‑up.
2. Centralized Authentication and Privilege Management
We acknowledge that centralized Linux authentication is not yet universally available across the environment and that many systems currently rely on local accounts and, at times, shared credentials — which is a known gap.
For these systems:
Centralized authentication (IPA), where available, must be used.
If IPA is not immediately available:
Local account usage must be minimized
Root access must be restricted and auditable
A documented plan and timeline must exist to migrate to centralized authentication once feasible
Additionally:
No shared local accounts
No shared root credentials
Privileged access must be performed via individual user accounts with sudo, ensuring accountability and auditability
Alignment with the Jayway CIS baseline is a hard requirement and must be implemented before this request is considered finally approved or the rules treated as long‑term/permanent. A confirmation of implementation is sufficient at this stage; a full audit is not required.
With these conditions clearly noted and tracked, I’m supportive of proceeding with the CAB.

These conditions are not intended to delay the change, but to ensure that we do not introduce new persistent Linux infrastructure without aligning to the security standards we are actively trying to establish.
