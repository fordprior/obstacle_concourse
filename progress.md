# progress
an outline to keep me sane

## phase 1: get BOSH working
1. install virtualbox 5.1 (newer versions have issues w/ vagrant 1.9.6)
2. install vagrant 1.9.6 (older versions hang on windows)
3. use repo for windows and bosh-lite and `vagrant up` from that directory
4. `vagrant ssh` into your VM, which is ubuntu trusty tahr (woot!)
5. install the newer bosh CLI v2 & install dependencies as follows:
```
$ wget https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-2.0.45-linux-amd64
$ chmod +x ~/Downloads/bosh-cli-*
$ sudo mv ~/Downloads/bosh-cli-* /usr/local/bin/bosh
$ sudo apt-get update
$ sudo apt-get install -y build-essential zlibc zlib1g-dev ruby ruby-dev openssl libxslt-dev libxml2-dev libssl-dev libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev sqlite3
```
6. now you

## phase 2: set up AWS infrastructure if needed
## phase 3: deploy to AWS
