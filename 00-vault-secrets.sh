Hey Gene,

On OCP-AI we just use keepalived + haproxy on the control plane nodes for the API and ingress VIPs — that's what the Red Hat installer sets up by default. MetalLB L2 for everything else. No external LB, been running fine.

For RKE2 I'd just do the same. kube-vip is worth a look too if you'd rather avoid the MetalLB quirks — does both API VIP and service LB in one.

Hardware LB is a bigger conversation, probably not worth it for internal stuff at this scale.

Haj
