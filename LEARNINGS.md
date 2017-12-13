# learnings
stuff that I learned along the way

## learning #1
at the time of writing, BOSH is the only production method for deploying, upgrading, scaling Concourse to AWS. so that means I have to learn BOSH.
* womp womp BOSH doesn't work on Windows (so I can't start out by deploying from my machine to AWS, which would be nice)
* this means I'll have to configure BOSH on an linux-based EC2 instance or on a vagrant VM, then deploy from that instance to my ALB

## learning #3.1
I know some people :heart: it but vagrant is kind of a pain in the neck, at least from what I learned after hacking at it for an hour. why?
* some of the unix-based BOSH commands didn't work on my cygwin wrapper but did on my windows cmd, and then some other way around (chaos)
* I would have to install vagrant+virtualbox, then spawn BOSH+virtualbox deploys from a vagrant environment, which sounded complicated

## learning 3.2
So, running virtualbox on aws EC2 is a neat idea (called "cascading"), but it's not possible. The reason is that virtualbox (or any modern hypervisor) is hardware-assisted meaning it needs to run on bare-metal processes and instruction sets, but AWS doesn't allow this for a couple possible reasons I can think of:
* security (letting people reach their dirty little fingers into the underlying hypervisor is dangerous)
* operational (it would be a headache for AWS to manage all the traffic coming from the x VM IP's routing through each instance)
* business (the reason that EC2 allows a gillion machine OS's is to solve this exact problem. just launch a new instance, dude)

doesn't people Xen hypervisor to spwan VM's from the host environemnt, but my host is already running on Xen via AWS, and AWS doesn't want people reaching their dirty little hands dow. Apparently virtualbox Xen's processor instructions and state 

## learning #3
* the newer BOSH CLI v2 is a totally different animal than the older version, which is Ruby-based and doesn't follow many of the commands of v2 like sit, heel, and `create-env`. So if you're installing the `bosh_cli` rubygem you're doing it all wrong.
