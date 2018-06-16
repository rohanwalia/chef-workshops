#
# Cookbook:: tomcat_cookbook
# Recipe:: install
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Install java-1.7.0-openjdk-devel - sudo yum install java-1.7.0-openjdk-devel
package node.default['tomcat_recipe']['java_package']

## Variable assignments
user = node.default['tomcat_recipe']['tomcat_user']
group = node.default['tomcat_recipe']['tomcat_group']
tomcat_dir = node.default['tomcat_recipe']['tomcat_dir']
tomcat_conf_dir = node.default['tomcat_recipe']['tomcat_conf_dir']
repo_source = node.default['tomcat_recipe']['tomcat_repo_source']


#Add Group tomcat
group "#{group}"

#Add user tomcat with home directory
user "#{user}" do
    manage_home false
    group "#{group}"
    shell '/bin/nologin'
    home "#{tomcat_dir}"
  end

  #Download and extract tomcat 8 - $ wget http://apache.cs.utah.edu/tomcat/tomcat-8/v8.5.20/bin/apache-tomcat-8.5.20.tar.gz
 remote_file 'apache-tomcat-8.5.20.tar.gz' do
    source "#{repo_source}"
 end

 #Create Directory /opt/tomcat
 directory "#{tomcat_dir}" do
   group "#{group}"
   recursive true
 end

 execute 'tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'

 execute 'chmod -R g+r /opt/tomcat/conf/'
 
 execute 'chmod g+x /opt/tomcat/conf/'
 
 execute 'chown -R tomcat /opt/tomcat/'


 #Install the Systemd Unit File
  template node.default['tomcat_recipe']['tomcat_service_unit'] do
    source node.default['tomcat_recipe']['tomcat_service_unit_template']
  end

  systemd_unit 'daemon' do
    action :reload
    end
  

  service 'tomcat' do
    action [:start, :enable]
  end

