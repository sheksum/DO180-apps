Hey Gene,

On OCP-AI we just use keepalived + haproxy on the control plane nodes for the API and ingress VIPs — that's what the Red Hat installer sets up by default. MetalLB L2 for everything else. No external LB, been running fine.

Could also do containerized haproxy on a couple of VMs outside the cluster if you wanted the LB layer separated out, but honestly I'd just follow the same approach as OCP-AI — keeps things consistent and we already know it works.

Haj
