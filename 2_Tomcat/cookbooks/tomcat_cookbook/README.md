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

## Knife Set Up
Download knife.rb and rsa key files from https://manage.chef.io. Create a directory `.chef` at the home directory and place `knife.rb` and `rsa key` files in `.chef` directory. You would also need access to `private_key.pem` whose corresponding public key was used to create EC2 target node.
Verify for knife connection to Chef Server.
```sh
$ knife ssl check
```
Show node that has been associated with Chef Server
```sh
$ knife node list
```
```sh
$ knife cookbook upload tomcat_cookbook
```
> Make sure  `cookbook_path` in knife.rb resolves the `chef-workshops/2_Tomcat/cookbooks` folder.

Run Chef-Client on the target node so that pulls down the cookbook form Chef Server and Executes the runlist cookbooks.
```sh
$ knife ssh 'name:node1-rhel' 'sudo chef-client' --ssh-user ec2-user -i <path_to_private_key> --attribute cloud.public_hostname
```

# Run using TEST KITCHEN
This cookbook can be tested using Test Kitchen Took/Framework. 
`.kitchen.yml` file is configured to create RHEL EC2 instance on AWS. To use kitchen commands to create instance on AWS and converge cookbooks, you need to create `.aws/credentials` file in home directory with contents having below :
```sh
$ vi .aws/credentials
[default]
aws_access_key_id = <aws_access_key_id>
aws_secret_access_key = <aws_secret_access_key>
```
You would also need access to private_key.pem whose corresponding public key was used to create EC2 target node.




TODO: Enter the cookbook description here.

