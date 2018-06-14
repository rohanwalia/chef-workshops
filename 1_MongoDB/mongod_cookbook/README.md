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

TODO: Enter the cookbook description here.

