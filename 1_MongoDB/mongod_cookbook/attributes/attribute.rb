default['mongod_recipe']['mongo_repo_file'] = '/etc/yum.repos.d/mongodb-org-3.6.repo'
default['mongod_recipe']['mongod_package'] = 'mongodb-org'
default['mongod_recipe']['mongod_service'] = 'mongod'
default['mongod_recipe']['key_ubuntu1604_command'] = 'apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5'

default['mongod_recipe']['mongopackage_ubuntu1604_command'] = 'echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list'

case node['platform_family']
 when 'rhel'
 default['mongod_recipe']['package_update_command'] = 'yum -y update'

 when 'debian'
 default['mongod_recipe']['package_update_command'] = 'apt-get update'
 default['mongod_recipe']['mongopackage_ubuntu1604_repo_file'] = '/etc/apt/sources.list.d/mongodb-org-3.6.list'
end
