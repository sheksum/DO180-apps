

Subject: BGP Peering and Calico Felix Readiness Failure

Hi Tigera Support,

We’re experiencing an issue where Calico BGP peering intermittently resets. Logs show the following readiness probe failure:

This occurred shortly after a general network “blip” around 3 PM. BFD and BGP sessions dropped and have since recovered, but one node is currently only peered with one ToR instead of both.

Please advise on how we can further investigate or resolve this issue