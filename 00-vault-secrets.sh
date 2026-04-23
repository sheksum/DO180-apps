F5 or Citrix Netscaler are ones that I’m familiar with.  But basic L4 with health monitoring,   hosting a VIP that would balance tcp traffic to control plane nodes. 



From: Brian Wing <Brian.Wing@calix.com>
Date: Thursday, April 23, 2026 at 12:52 PM
To: Gene Siepka <gene.siepka@calix.com>, Haj Suma <haj.suma@calix.com>, Deonna Thornton <deonna.thornton@calix.com>, Vinoth Kumar Sekar <vinoth.sekar@calix.com>
Cc: Kishore Kumar <kishore.kumar@calix.com>
Subject: RE: 3 Blades for RKE2/Rancher

We don’t have any hardware load balancer today.
 
What are some of the typical configurations you see, or you know about.  Are there some that we should be considering for the future?
 
From: Gene Siepka <gene.siepka@calix.com>
Sent: Thursday, April 23, 2026 9:50 AM
To: Brian Wing <Brian.Wing@calix.com>; Haj Suma <haj.suma@calix.com>; Deonna Thornton <deonna.thornton@calix.com>; Vinoth Kumar Sekar <vinoth.sekar@calix.com>
Cc: Kishore Kumar <kishore.kumar@calix.com>
Subject: Re: 3 Blades for RKE2/Rancher
 
I think I know the answer here but I’ll ask anyway..  Do we have any type of LoadBalancer available to use for externalizing the k8s API and Ingress endpoints? 
 
In my opinion it would simplify the cluster configuration. I know in-cluster MetalLB is an option instead but it does add some complexity.  
 
 
 
From: Brian Wing <Brian.Wing@calix.com>
Date: Wednesday, April 22, 2026 at 2:20 PM
To: Haj Suma <haj.suma@calix.com>, Deonna Thornton <deonna.thornton@calix.com>, Vinoth Kumar Sekar <vinoth.sekar@calix.com>, Gene Siepka <gene.siepka@calix.com>
Cc: Kishore Kumar <kishore.kumar@calix.com>
Subject: RE: 3 Blades for RKE2/Rancher

Thanks for the input Haj.  Definitely looking to expand the cluster as we start onboarding workloads from the pln-vcentervsi (vmware) cluster currently hosting builders.
 
These are the first likely candidates to be onboarded, as we onboard builders, and reduce the load on the vmware cluster, we can peel off hosts from VMWare and expand the K8S cluster.
