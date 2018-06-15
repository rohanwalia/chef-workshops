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

Below is the content of `.kitchen.yml` file in tomcat_cookbook : 

```sh
---
driver:
  name: ec2
  aws_ssh_key_id: awsplayground_ohio
  region: us-east-2
  availability_zone: b
  subnet_id: subnet-f113ac8b
  instance_type: t2.micro
  image_id: ami-03291866
  security_group_ids: ["sg-0cb8d1612fb977743"]
  retryable_tries: 120

provisioner:
  name: chef_zero

verifier:
  name: inspec

transport:
  ssh_key: /home/vagrant/workplace/aws_playground.pem

platforms:
  - name: RHEL-7.5

suites:
  - name: default
    run_list:
      - recipe[tomcat_cookbook::install]
    verifier:
      inspec_tests:
        - test/smoke/default
    attributes:
```
Replace aws_ssh_key_id : to the name of key in your aws account which is used to create instances
Replace ssh_key : to the path of `private_key.pem`

Run below command to create an Instance from tomcat_cookbook directory. This will create a EC2 instance in AWS according to paramteres defined in `.kitchen.yml` file

```sh
$ kitchen create
```
Once instance is created successfully, run below command to Converge the cookbook and apply to the instance.
```sh
$ kitchen converge
```
Successful completion of this command shows that cookbooks have been applied to the test instance.

You can verify by ssh into the instance.

You can delete and clean up the test instance by following command
```sh
$ kitchen destroy
```





TODO: Enter the cookbook description here.

