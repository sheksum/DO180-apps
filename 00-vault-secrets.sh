Hey team, hoping most of you can make this.  I want to have a discussion about what our future K8S builds should look like.  Need some domain knowledge on what we do today for server builds and networking etc.  From the below I think we can come up with a list of stories/tasks for our build-out.  

If tomorrow is too early we can push to next week. 

Rough agenda of things I think we should decide on:

Network connectivity : 
Primary VLAN
Storage VLAN
HA/Bond
???
Operating System for K8S nodes
RHEL / Ubuntu / others? (Assuming Ubuntu unless there's something better)
LVM? 
PXE / Kickstart or any build standards?
Node name standards
IPA needed on k8s nodes? 
K8S install
Assuming RKE2 via Rancher
Cluster name? plnx-k8s-01.  plnx-rke2-01?
From scratch RKE2 or Generate Manifest from existing Rancher? 
Move existing Rancher config to new cluster?
RBAC and Authentication with IPA
K8s Addons
ArgoCD or Rancher Fleet? 
Trident Netapp plugin
NMState ??
 
Logging / Monitoring 
MetalLB?
Cert-manager
Ngnix Ingress is now deprecated. Traefik with GatewayAPI or something else
External Secrets Operator 
System Upgrade Controller
First K8s Apps?
Hashicorp Vault ?
Netbox? 
???
