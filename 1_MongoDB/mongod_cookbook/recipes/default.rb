#
# Cookbook:: mongod_cookbook
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

  template '/etc/yum.repos.d/mongodb-org-3.6.repo' do
    source 'mongod_yum.erb'  
  end
    
  package 'mongodb-org'  
    service 'mongod' do
    action [:enable, :start]  
  end
