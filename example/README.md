Support Portal Onboarding & Ticketing System Overview
- Reviewed ticketing system and test ticket submission methods.
- Planned onboarding for Carrington and Chris to Vox for large file sharing.
- Discussed RK2 migration status and environment updates for Chris and Carrington.
- Mentioned 17 people added to support portal; some not yet registered.
- Outlined support contract usage by operations and engineering teams.



Ticketing System Details, File Sharing, and Test Procedures
- Email invites sent for portal access; setup required upon receipt.
- Support tickets can be submitted via portal, email (support@365platforms.com), or 24/7 phone line.
- Email tickets require support@365platforms.com in 'To' line; subject becomes ticket header; body is ticket description.
- Portal allows file uploads up to 50 MB per ticket; engineers can be added for access as needed.
- Portal does not display user access list; admin holds access list and can share upon request.



Platform Migration, Cluster Status, and Resource Utilization
- Migration scheduled for completion end of month; RKE2 to be fully phased out.
- Post-migration environment uses vanilla upstream Kubernetes managed by cluster API providers.
- Three production clusters currently run 90+ internal VeriSign applications; customer-facing products planned for 2026.
- Rancher used only for visualization and RBAC proxying; no lifecycle management functions used.
- Current CPU utilization at 10%; requested utilization in 30–40% range; capacity management and resource enforcement are ongoing challenges.



Capacity Management, Chargeback Models, and Observability
- Collected metrics include usage, requested resources, and governance enforcement.
- VM to container migration presents challenges in resource translation and workload profiling.
- Lack of direct chargeback on bare metal leads to hardware oversubscription; cloud models have direct user costs.
- Dashboards and efficiency factors identify top consumers; applications often use only 10% of reserved resources.
- Support and consulting available for architectural analysis and allocation adjustments via upkeep work requests.



Professional Services: MatureIQ, Upkeep, and Consulting Offerings
- VeriSign support and ticketing process confirmed as understood and operational.
- Collateral with product/service overview sent in June; available for review again.
- Mature IQ product included in subscription; assesses company maturity using proprietary rubrics across technology, process, compliance, staffing, and funding.
- Upkeep product offers subscription-based professional services for ongoing platform improvements; activities range from 12 hours to 2 weeks per task.
- Trial access to Upkeep available; success measured by maturity improvement and useful for management reporting.



Security Review, Scanning Tools, and Data Exchange
- Company offers full upgrade management, including procedures, staging, and sequencing.
- Support includes platform transformations (e.g., RKE 1 to 2, Rancher) and architect-level analysis.
- Upkeep services cover capacity issues, platform releases, and can be delegated as needed.
- MatureIQ platform supports post-migration vetting, configuration checks, and security certifications (e.g., SOC 2).
- Next steps: internal discussion before scheduling meetings; dashboard expected in ~1 month.



Scheduling, Next Steps, and Meeting Wrap-up
- Security review required for open-source cluster configuration scans (Trivi, Polaris, CubeScape).
- Tony to facilitate contact with security team for feedback and review process.
- Engineering team likely to submit review request; coordination ongoing.
- Biweekly 15-minute WebEx meetings to review tickets and status; scheduling in progress.
- No proprietary data involved in scan reports; only configuration and vulnerability information collected.
