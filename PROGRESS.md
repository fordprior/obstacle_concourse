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
...and then I sat on this error for like 3 months with no progress. ¯\_(ツ)_/¯

 ## phase 1.2: throw my Windows machine in the trash and try on a Mac
 Yep, you heard that right. I got a Mac with OSX 10.13.4, which has VirtualBox 5.2.8, and Docker 18.03.0-ce. So far, everything has been stupid easy:
 ### 1. First, I followed the instructions from the [Bosh website](https://bosh.io/docs/cli-v2#install) to get the deployment environment working:
   ```
   wget -O ~/Downloads https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-3.0.1-darwin-amd64
   chmod +x ~/Downloads/bosh-cli-*
   sudo mv ~/Downloads/bosh-cli-* /usr/local/bin/bosh
   ```
 ...and after running `bosh -v` to make sure version 3.0-something was installed, I created my environment:
  ```
  bosh create-env ~/workspace/bosh-deployment/bosh.yml \
  --state state.json \
  --vars-store ./creds.yml \
  -o ~/workspace/bosh-deployment/virtualbox/cpi.yml \
  -o ~/workspace/bosh-deployment/virtualbox/outbound-network.yml \
  -o ~/workspace/bosh-deployment/bosh-lite.yml \
  -o ~/workspace/bosh-deployment/jumpbox-user.yml \
  -v director_name=vbox \
  -v internal_ip=192.168.56.6 \
  -v internal_gw=192.168.56.1 \
  -v internal_cidr=192.168.56.0/24 \
  -v network_name=vboxnet0 \
  -v outbound_network_name=NatNetwork
  ```
  * Note: I don't think this last step did anything? Anyways I moved on to a different tutorial; I shouldn't have done it in the first place.
 
 ### 2. Next, I went to the [Concourse site](https://concourse-ci.org/) and started following their instructions:
 1. start my CI service locally:
    ```
    wget https://concourse-ci.org/docker-compose.yml
    docker-compose up
    ```
    * note1: I did a `docker ps` and saw that it created two containers, PostgresSQL (db) and councourse/councourse (web)
    * note2: I just left open this window, because it'll show the traffic coming into my CI service
 2. The web app was served at `127.0.0.1:8080`, where I clicked a Mac icon to download the "CLI tools" (not sure what this entailed, but it gave me a `fly` file which I `chmod +x`'d and placed in my PATH)
 3. To "authenticate my target" I used the `fly login` command:
   ```
   fly -t tutorial login -c http://127.0.0.1:8080
   ```
   note: Concourse is primarily driven from the command-line (there is no GUI config wizard) using this `fly` CLI.

 
 ### 3. At this point, it said to hit up [this tutorial](https://concoursetutorial.com/basics/task-hello-world/) to "kick the tires":
Get the repo for this task and use the CI service I created in Step 1 to actually run the `fly execute` command: 
    ```
    git clone https://github.com/starkandwayne/concourse-tutorial
    cd concourse-tutorial/tutorials/basic/task-hello-world
    fly -t tutorial execute -c task_hello_world.yml
    ```
    * Note:
 
 


## phase 2: set up AWS infrastructure if needed
## phase 3: deploy to AWS
