This cookbook installs and configure MONGO DB on RHEL based VM's/Instance.
# Contents of Cookbook
- recipies/install.rb : Recipie to install and configure MONGO DB.
- templates/mongod_yum.erb : yum config details for MONGO Package. Reffered in install.rb
- .kitchen.yml : Test Kitchen config to Create new EC2 instance on AWS and Converge install.rb.

# RUN INSTRUCTIONS
Below are instructions to run and test this Cookbook.
## Run Locally on a RHEL Instance / VM
- Create a Instance or VM with RHEL OS
- Install GIT & WGET on the Instance
- Install [CHEFDK](https://downloads.chef.io/chefdk#el) on VM/Instance
- Clone repo from GITHUB
- Follow steps below

```sh
$ git clone https://github.com/rohanwalia/chef-workshops.git
```
```sh
$ cd chef-workshops/1_MongoDB/
```
```sh
$ mkdir cookbooks
```
```sh
$ cp -R mongod_cookbook cookbooks/
```
```sh
$ cd cookbooks
```
```sh
$  sudo chef-client --local-mode --runlist 'recipe[mongod_cookbook::install]'
```

## Run using Knife through Chef Server
Chef Manage @ https://manage.chef.io is being used as Chef Server to Manage Nodes. 
There is one Node on EC2 : node1-rhel that has been bootstrapped and converged. Organization Name is : chefplayground

# Knife Set Up
Download knife.rb and rsa key files from https://manage.chef.io. Create a directory .chef at the home directory and place knife.rb and rsa key files in .chef directory.
Verify for knife connection to Chef Server.
```sh
$ knife ssl check
```
Show node that has been associated with Chef Server
```sh
$ knife node list
```
```sh
$ knife cookbook upload mongod_cookbook
```
Run Chef-Client on the target node so that pulls down the cookbook form Chef Server and Executes the runlist cookbooks.
```sh
$ knife ssh 'name:node1-rhel' 'sudo chef-client' --ssh-user ec2-user -i <path_to_private_key> --attribute cloud.public_hostname
```
## Run using TEST KITCHEN


TODO: Enter the cookbook description here.

