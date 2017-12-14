# learnings
stuff that I learned along the way

## learning #1: I must either learn BOSH or hack around it
at the time of writing, BOSH is the only production method for deploying, upgrading, scaling Concourse to AWS. so that means I have to learn BOSH.
* womp womp BOSH doesn't work on Windows (so I can't start out by deploying from my machine to AWS, which would be nice)
* this means I'll have to configure BOSH on an linux-based EC2 instance or on a vagrant VM, then deploy from that instance to my ALB

## learning #2: BOSH CLI v2 != BOSH CLI v1
* the newer BOSH CLI v2 is a totally different animal than the older version, which is Ruby-based and doesn't follow many of the commands of v2 like sit, heel, and `create-env`. So if you're installing the `bosh_cli` rubygem you're doing it all wrong.

## learning #3: You can't deploy locally with Concourse on Windows
To avoid Windows, I tried a couple of things. First, I looked at Vagrant but honestly wanted to avoid my Windows machine altogether. So instead I tried running it all on EC2. Alas, running virtualbox on aws EC2 is a neat idea (called "cascading") but it's not possible. The reason is that virtualbox (or any modern hypervisor) is hardware-assisted meaning it needs to run on bare-metal processes and instruction sets, but AWS doesn't allow this for a couple possible reasons I can think of:
* security (letting people reach their dirty little fingers into the underlying hypervisor is dangerous)
* operational (it would be a headache for AWS to manage all the traffic coming from the x VM IP's routing through each instance)
* business (the reason that EC2 allows a gillion machine OS's is to solve this exact problem. just launch a new instance, dude), I ran into 

So I was back to Vagrant, which the BOSH website said was discouraged but still supported. So after spending an afternoon getting it set up, I ran into an error and reached out to the BOSH slack group, who collectively informed me that running Vagrant on Virtualbox then installing Virtualbox on my Vagrant VM wouldn't work. That is, you can't execute `bosh create-env concourse-lite.yml`( which uses virtualbox) on a Vagrant VM that is, itslef, running on Virtualbox. Reason? Virtualbox doesn't supported nested virtualization, they said.

So, that leaves a single option for Windows 7 users who want to try out Concourse: use Vagrant to run a VM, then deploy using BOSH to a cloud provider like AWS. Local deploys will not work because Concourse requires BOSH, and BOSH doesn't like Windows.
