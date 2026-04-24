Cool.  First priority for Gitlab is runner/images/tools/security.   I’ll be sure to invite

From: Grider, Ben <ben.grider@ttmtech.com> 
Sent: Friday, April 24, 2026 6:33 AM
To: Himes, Jim <jim.himes@ttmtech.com>; Suma, Alhaji - C <Alhaji.Suma@ttmtech.com>
Subject: RE: Restricted kindo-ai cluster review - findings attached

Not yet,  We’ve had Haji pretty busy so he has not had a chance to build the other instances yet.  It is on the list though once he gets his head above water.  We still need to build out the Commercial and SSZ instances which are next on his list.

-Ben

From: Himes, Jim <jim.himes@ttmtech.com> 
Sent: Friday, April 24, 2026 8:28 AM
To: Grider, Ben <ben.grider@ttmtech.com>; Suma, Alhaji - C <Alhaji.Suma@ttmtech.com>
Subject: RE: Restricted kindo-ai cluster review - findings attached

Well the corp.local instance of Gitlab is a given as of last week.  Adam will be allowed to use it under specific conditions, the issue of being push etc to domains. 

What we are going to have to do is coordinate gitlab instance connections to runners in alternate domains.

Do we have a K8s in corp.local?

From: Grider, Ben <ben.grider@ttmtech.com> 
Sent: Friday, April 24, 2026 5:50 AM
To: Suma, Alhaji - C <Alhaji.Suma@ttmtech.com>; Himes, Jim <jim.himes@ttmtech.com>
Subject: RE: Restricted kindo-ai cluster review - findings attached

I was about to say the same thing,  please include us in the meetings and we will assist for sure.  I am going to start leveraging Gitlab on more Infrastructure projects and I would like to stay involved in how we have it setup and the options available to us.  I am also going to be working with the Windows and Network teams to start getting them more involved in version control with Gitlab as I am sure it will help them as well.

Have you discussed Gitlab with Adam at all for the Oracle side of things?  They are currently using subversion in the SSZ as the code is shared between both commercial and restricted and I would love to put a GitLab instance in the SSZ to mirror what we have in Restricted so we could retire SVN for a Gitlab standard version control across all TTM environments.

Thanks!

--Ben

From: Suma, Alhaji - C <Alhaji.Suma@ttmtech.com> 
Sent: Friday, April 24, 2026 7:47 AM
To: Himes, Jim <jim.himes@ttmtech.com>
Cc: Grider, Ben <ben.grider@ttmtech.com>
Subject: RE: Restricted kindo-ai cluster review - findings attached

Sure Jim  – I  can help with that 

From: Himes, Jim <jim.himes@ttmtech.com> 
Sent: Thursday, April 23, 2026 4:43 PM
To: Suma, Alhaji - C <Alhaji.Suma@ttmtech.com>
Cc: Grider, Ben <ben.grider@ttmtech.com>
Subject: RE: Restricted kindo-ai cluster review - findings attached

Thanks Haji – I’ll start reviewing with Vation and pull you in when needed.

FYI – Signed up for some consulting from Gitlab and starting the project within the next two weeks at most, would love to have you both for the first planning call and introduce Glen who will be running the project.  We’ve got some security , runner and image requirements for containers in the cluster so the runners have tools to work with. 
What I’m hoping is you all can help with the runner/image/worker deployments in the project.

Thanks
Jim


From: Suma, Alhaji - C <Alhaji.Suma@ttmtech.com> 
Sent: Thursday, April 23, 2026 1:22 PM
To: Himes, Jim <jim.himes@ttmtech.com>
Cc: Grider, Ben <ben.grider@ttmtech.com>
Subject: Restricted kindo-ai cluster review - findings attached

Hi Jim,

I've wrapped up the review of the kindo-ai cluster at the restricted environment. The findings are in the attached document.

Nothing was changed on the cluster during the review. Fourteen items are called out, grouped by area in the attachment.

I'll begin review of the commercial environment tomorrow.

Thanks,
Haji
