Eric – Thank you!

Haji – Nice to meet you, looking forward to working with you.


From: Chan, Eric <eric.chan@ttmtech.com> 
Sent: Friday, April 24, 2026 12:46 PM
To: Himes, Jim <jim.himes@ttmtech.com>; Gardner, Glen - C <Glen.Gardner@ttmtech.com>; Suma, Alhaji - C <Alhaji.Suma@ttmtech.com>
Subject: RE: Mock CI/CD Flow

Aamhilapp83 is a windows server that we set up when trying this out.   I’ll request you to get added as an admin to the server.



From: Himes, Jim <jim.himes@ttmtech.com> 
Sent: Friday, April 24, 2026 9:44 AM
To: Gardner, Glen - C <Glen.Gardner@ttmtech.com>; Chan, Eric <eric.chan@ttmtech.com>; Suma, Alhaji - C <Alhaji.Suma@ttmtech.com>
Subject: RE: Mock CI/CD Flow

Haji meet Glen, Glen Haji

Haji set up the runners for us K8s cluster, if you would work with Haji Glen you’ll probably go faster.
Eric participate as you like please.


From: Gardner, Glen - C <Glen.Gardner@ttmtech.com> 
Sent: Friday, April 24, 2026 9:32 AM
To: Himes, Jim <jim.himes@ttmtech.com>; Chan, Eric <eric.chan@ttmtech.com>
Subject: RE: Mock CI/CD Flow

Eric – Do you happen to remember how you registered new runners on the runner machine - AAMHILAPP83? Do I have RDP/SSH or remote powershell access/authorization to register new runners?


From: Himes, Jim <jim.himes@ttmtech.com> 
Sent: Friday, April 24, 2026 9:59 AM
To: Gardner, Glen - C <Glen.Gardner@ttmtech.com>; Chan, Eric <eric.chan@ttmtech.com>
Subject: RE: Mock CI/CD Flow

Go ahead.



From: Gardner, Glen - C <Glen.Gardner@ttmtech.com> 
Sent: Friday, April 24, 2026 6:58 AM
To: Chan, Eric <eric.chan@ttmtech.com>; Himes, Jim <jim.himes@ttmtech.com>
Subject: RE: Mock CI/CD Flow

Ok, just wanted to make sure. Any objection to me creating a “test” automation project in our gdss group? This will allow me to begin to confirm some of the data I’ve gathered. I was thinking naming it CI-CD_Testing.


From: Chan, Eric <eric.chan@ttmtech.com> 
Sent: Thursday, April 23, 2026 1:31 PM
To: Gardner, Glen - C <Glen.Gardner@ttmtech.com>; Himes, Jim <jim.himes@ttmtech.com>
Subject: RE: Mock CI/CD Flow

I don’t’ think you need to be admin.  Depends on what you want to do.  
We were able to set up and connect a runner without being an administrator





From: Gardner, Glen - C <Glen.Gardner@ttmtech.com> 
Sent: Thursday, April 23, 2026 9:53 AM
To: Chan, Eric <eric.chan@ttmtech.com>; Himes, Jim <jim.himes@ttmtech.com>
Subject: RE: Mock CI/CD Flow

I looked at that project and found the relevant information.

It appears my GitLab account is provisioned as a standard user. Do I need to be configured as admin? If so, do I reach back out to Lorenzo?

Just to be clear, my intent is information gathering only for now, I do not intend to make any changes.


From: Chan, Eric <eric.chan@ttmtech.com> 
Sent: Thursday, April 23, 2026 10:21 AM
To: Gardner, Glen - C <Glen.Gardner@ttmtech.com>; Himes, Jim <jim.himes@ttmtech.com>
Subject: RE: Mock CI/CD Flow

Almost everything in the gdss group.
We started to try the automation in the IPAS project if you want to look at that one



From: Gardner, Glen - C <Glen.Gardner@ttmtech.com> 
Sent: Thursday, April 23, 2026 6:29 AM
To: Chan, Eric <eric.chan@ttmtech.com>; Himes, Jim <jim.himes@ttmtech.com>
Subject: RE: Mock CI/CD Flow

Eric - can you please provide a list of projects that need to be added to GitLab CI/CD automation to compile and copy artifacts over to IIS? I’d like to start collecting data to facilitate the implementation.


From: Chan, Eric <eric.chan@ttmtech.com> 
Sent: Monday, April 20, 2026 1:57 PM
To: Gardner, Glen - C <Glen.Gardner@ttmtech.com>; Himes, Jim <jim.himes@ttmtech.com>
Subject: RE: Mock CI/CD Flow

Maybe a longer term goal to deploy apps in Kubernetes?

Right now, just having the runner compile and copy artifacts over to IIS should be sufficient.



From: Gardner, Glen - C <Glen.Gardner@ttmtech.com> 
Sent: Monday, April 20, 2026 7:40 AM
To: Chan, Eric <eric.chan@ttmtech.com>; Himes, Jim <jim.himes@ttmtech.com>
Subject: Mock CI/CD Flow

Wanted to share the attached document describing the CI/CD flow in the Kubernetes environment I mocked-up. I think this achieves the desired functionality:
Step	Action	Where
Developer	git push origin dev	~seconds
Pipeline (dev)	compile + test + open MR	~2 minutes
Review	Admin reviews and merges MR	Manual
Pipeline (main)	compile + test + build image + deploy	~4 minutes
Kubernetes	Pull image + start pod + serve traffic	~30 seconds

