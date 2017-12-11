# progress
an outline to keep me sane

### learning #1
at the time of writing, BOSH is the only production method for deploying, upgrading, scaling Concourse to AWS. so that means I have to learn BOSH.
* womp womp BOSH doesn't work on Windows (so I can't start out by deploying from my machine to AWS, which would be nice)
* this means I'll have to configure BOSH on an linux-based EC2 instance or on a vagrant VM, then deploy from that instance to my ALB

### learning #2
vagrant is kind of a pain in the neck, at least from what I learned after hacking at it for an hour (e.g. some of the unix-based BOSH commands didn't work on my cygwin wrapper but _did_ on my windows cmd, which was chaos). So i tried Ubuntu trusty, which was kind of difficult due to the lack of specific instructions for installing linux binaries (which I eventually figured out). along the way I learned that the newer BOSH CLI v2 is a totally different animal than the older version, which is Ruby-based and doesn't follow many of the commands of v2.

## phase 1: get EC2 working w/ BOSH

1. launch ubuntu trusty ec2 instance
2. ssh into the instance (I used PuTTY) and run the following:
```
$ sudo apt-get update
$ wget https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-2.0.28-linux-amd64
$ sudo mv bosh-cli-* /usr/local/bin/bosh
$ sudo chmod +x /usr/local/bin/bosh
$ bosh -v
```
Note: the last command should return something that says `version 2.0...` instead of `BOSH 1.0...`.

3. git clone https://github.com/cloudfoundry/bosh-deployment ~/workspace/bosh-deployment

## phase 2: set up AWS infrastructure if needed
## phase 3: deploy to AWS
