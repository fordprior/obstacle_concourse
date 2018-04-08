# progress
an outline to keep me sane

## phase 1: get BOSH working on my windows 7 OS
1. ...and get this error:
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
...and then sit on this error for like 3 months with no progress. ¯\_(ツ)_/¯

 ## phase 1.2: throw my Windows machine in the trash and try on a Mac
 Yep, you heard that right. I got a Mac with OSX 10.13.4, which has VirtualBox 5.2.8, and Docker 18.03.0-ce. So far, everything has been stupid easy:
 ### 1. First, I followed the instructions from the [Bosh website](https://bosh.io/docs/cli-v2#install) to get the deployment environment working:
   ```
   wget -O ~/Downloads https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-3.0.1-darwin-amd64
   chmod +x ~/Downloads/bosh-cli-*
   sudo mv ~/Downloads/bosh-cli-* /usr/local/bin/bosh
   ```
 
 ### 2. Next, I went to the [Concourse site](https://concourse-ci.org/) and started following their instructions:
 1. start my CI service locally:
    ```
    wget https://concourse-ci.org/docker-compose.yml
    docker-compose up
    ```
    * note1: I did a `docker ps` and saw that it created two containers, PostgresSQL (db) and councourse/councourse (web)
    * note2: I just left open this window, because it'll show the traffic coming into my CI service
    
    The web app was served at `127.0.0.1:8080`:
 ![screenshot](https://assets.digitalocean.com/articles/concourseci_install_1604/placeholder_interface.png)
 
 2. I clicked a Mac icon to download the "CLI tools", `chmod +x`'d the `fly` file it gave me and placed it in my PATH)
 3. To "authenticate my target" I used the `fly login` command:
   ```
   fly -t tutorial login -c http://127.0.0.1:8080
   ```
   note: Concourse is primarily driven from the command-line (there is no GUI config wizard) using this `fly` CLI.

 
 ### 3. At this point, it said to hit up [this tutorial](https://concoursetutorial.com/basics/task-hello-world/) to "kick the tires":
Get the repo for this task and use the CI service I created in Step 1 to actually run the `fly execute` command: 
   
    git clone https://github.com/starkandwayne/concourse-tutorial
    cd concourse-tutorial/tutorials/basic/task-hello-world
    fly -t tutorial execute -c task_hello_world.yml
    
   * Note: I can open up the UI and click on build/1 and see the following output:
    ![screenshot](https://concoursetutorial.com/images/build-output-hello-world.png)
    
   * Yay! Super cool. Now `docker-compose down` to stop my CI service for now while I focus on Ruby app stuff.

## phase 2: get a Ruby app working
   
  ### 1. First, I found a good Ruby/CentOS base image [here](https://hub.docker.com/r/centos/ruby-24-centos7/) and tried it out:
  ```
   brew install source-to-image
   s2i build https://github.com/sclorg/s2i-ruby-container.git --context-dir=2.4/test/puma-test-app/ centos/ruby-24-centos7 ruby-sample-app
   docker run -p 8080:8080 ruby-sample-app
   curl 127.0.0.1:8080
   ```
   OK, so that works. Great.
   ### 2. Fork this [parent repo](https://github.com/sclorg/s2i-ruby-container) for the Ruby/CentOS image so I can modify it for my specs
   To start, I made the following changes:
      
      1. I renamed it so people wouldn't get confused
      2. I slimmed it down to focus on CentOS and Ruby v24
      3. I added some Concourse stuff
      
      
      
   
   


set up AWS infrastructure if needed
## phase 3: deploy to AWS
