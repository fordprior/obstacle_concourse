# progress
an outline to keep me sane

### learning #1
at the time of writing, BOSH is the only production method for deploying, upgrading, scaling Concourse to AWS
* womp womp, b/c BOSH doesn't work on Windows (so I can't start out by deploying from my machine to AWS, which would be nice)
* this means I'll have to configure BOSH on an linux-based EC2 instance or on a vagrant VM, then deploy from that instance to my ALB

## phase 1: get EC2 working w/ BOSH

1. launch ubuntu ec2 instance
2. apt-get install virtualbox virtualbox-ext
3. apt-get install vagrant
4. git clone https://github.com/cloudfoundry/bosh-deployment ~/workspace/bosh-deployment

## phase 2: set up AWS infrastructure if needed
## phase 3: deploy to AWS
