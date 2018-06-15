# tomcat_cookbook
This cookbook installs and configure TOMCAT 8.5.9 RHEL based VM's/Instance.

# Contents of Cookbook
- recipies/install.rb : Recipie to install and configure MONGO DB.
- templates/tomcat.service.erb : tomcat.service unit file template. Reffered in install.rb
- .kitchen.yml : Test Kitchen config to Create new EC2 instance on AWS and Converge install.rb.

# RUN INSTRUCTIONS
Below are instructions to run and test this Cookbook.
## Run Locally on a RHEL Instance / VM
- Create a Instance or VM with RHEL OS
- Install GIT & WGET on the Instance
- Install [CHEFDK](https://downloads.chef.io/chefdk#el) on VM/Instance
- Clone repo from GITHUB

```sh
$ git clone https://github.com/rohanwalia/chef-workshops.git
```
```sh
$ cd chef-workshops/2_Tomcat/cookbooks
```
```sh
$  sudo chef-client --local-mode --runlist 'recipe[tomcat_cookbook::install]'
```
# Run using Knife through Chef Server
Chef Manage @ https://manage.chef.io is being used as Chef Server to Manage Nodes. 
There is one Node on EC2 : node1-rhel that has been bootstrapped and converged. Organization Name is : chefplayground
TODO: Enter the cookbook description here.

