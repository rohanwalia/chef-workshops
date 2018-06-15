#
# Cookbook:: mongod_cookbook
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

  execute node.default['mongod_recipe']['package_update_command']
 

  template node.default['mongod_recipe']['mongo_repo_file'] do
    source 'mongod_yum.erb'
  end

  package node.default['mongod_recipe']['mongod_package']

  service node.default['mongod_recipe']['mongod_service'] do
    action [:enable, :start]
  end
