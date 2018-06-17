#
# Cookbook:: mongod_cookbook
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

  #execute package manager update.
  execute node.default['mongod_recipe']['package_update_command']
  
  #Check for platform
  case node['platform_family']
   when 'debian' # do things if platform is debian based - ubuntu

   execute'key' do
    command node.default['mongod_recipe']['key_ubuntu1604_command'] 
   end 

   execute 'update_repo' do
     command node.default['mongod_recipe']['mongopackage_ubuntu1604_command']
     not_if do
	File.exists?(node.default['mongod_recipe']['mongopackage_ubuntu1604_repo_file'])
     end
   end
   execute node.default['mongod_recipe']['package_update_command']
   
   when 'rhel' # do things if platform is rhel based
    
    template node.default['mongod_recipe']['mongo_repo_file'] do
     source 'mongod_yum.erb'
   end

  end

  #install mongod using package manager
  package node.default['mongod_recipe']['mongod_package']

  #enable and start mongod service
  service node.default['mongod_recipe']['mongod_service'] do
    action [:enable, :start]
  end
