# progress
an outline to keep me sane

## phase 1: get BOSH working on my windows 7 OS
1. install virtualbox 5.1 (newer versions have issues w/ vagrant 1.9.6)
2. install vagrant 1.9.6 (older versions hang on windows)
   
      Some helpful commands:
      ```
      vagrant up
      vagrant ssh
      vagrant suspend
      vagrant global-status
      vagrant destroy
      ```
         
3. clone bosh-lite [repo](https://github.com/cloudfoundry/bosh-lite) and `vagrant up --provider=virtualbox` from that directory
4. `vagrant ssh` into your VM, which is ubuntu trusty tahr (you'll be at dir `/home/vagrant`)
5. install the newer bosh CLI v2 & install dependencies as follows, using your Windows cmd:
```
$ wget https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-2.0.45-linux-amd64
$ sudo chmod +x bosh-cli-2.0.45-linux-amd64
$ sudo mv bosh-cli* /usr/local/bin/bosh
$ sudo apt-get update
$ sudo apt-get install -y build-essential zlibc zlib1g-dev ruby ruby-dev openssl libxslt-dev libxml2-dev libssl-dev libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev sqlite3
$ cd /etc/sources
$ echo "deb http://download.virtualbox.org/virtualbox/debian trusty contrib" >> sources.list
$ wget https://www.virtualbox.org/download/oracle_vbox.asc
$ sudo apt-key add oracle_vbox.asc
$ apt-get update
$ apt-get install virtualbox-5.1
$ apt-get install dkms
$ apt-get install git
$ cd /home/vagrant
$ git clone https://github.com/cloudfoundry/bosh-deployment ~/workspace/bosh-deployment
$ mkdir -p ~/deployments/vbox
$ cd ~/deployments/vbox
```
   NOTE: At the end, use `bosh -v` and `VBoxManage --version` to make sure your versions are 2.x and 5.1, respectively.
   
6. to create a deployment environment
```
$ wget https://github.com/concourse/concourse/releases/download/v3.5.0/concourse-lite.yml
$ bosh create-env concourse-lite.yml
```

...and getting this error:
```
Deploying:
  Creating instance 'concourse/0':
    Creating VM:
      Creating vm with stemcell cid 'sc-ff745b3d-f2b9-49bc-685d-e2cce1e4e691':
        CPI 'create_vm' method responded with error: CmdError{"type":"Bosh::Clou
ds::CloudError","message":"Creating VM with agent ID '{{1f4ed777-2a40-4293-40fe-
acdc3fecdab9}}': Starting VM: Retried '30' times: Running command: 'VBoxManage s
tartvm vm-f893f1a4-adea-48ac-50ea-38dd13aae3f2 --type headless', stdout: 'Waitin
g for VM \"vm-f893f1a4-adea-48ac-50ea-38dd13aae3f2\" to power on...\n', stderr:
'VBoxManage: error: VT-x is not available (VERR_VMX_NO_VMX)\nVBoxManage: error:
Details: code NS_ERROR_FAILURE (0x80004005), component ConsoleWrap, interface IC
onsole\n': exit status 1","ok_to_retry":false}
```

```
$ wget https://github.com/concourse/concourse/releases/download/v3.5.0/concourse-lite.yml
$ bosh create-env concourse-lite.yml
```

## phase 2: set up AWS infrastructure if needed
## phase 3: deploy to AWS
