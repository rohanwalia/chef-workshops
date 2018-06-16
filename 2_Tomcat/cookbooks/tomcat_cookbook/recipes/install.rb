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
nologin_shell = node.default['tomcat_recipe']['nologin_shell']
remote_file = node.default['tomcat_recipe']['remote_file']


#Add Group tomcat
group "#{group}"

#Add user tomcat with home directory
  user "#{user}" do
    manage_home false
    group "#{group}"
    shell '/bin/nologin'
    home "#{tomcat_dir}"
  end

 #Download remote file tomcat tar.gz based on repo_resource file. No need to download if file alredy exist. Improves performance. Condition checked by guard - not_if.
 remote_file "#{remote_file}" do
    source "#{repo_source}"
     not_if do
       File.exists?("#{remote_file}")			
   end
 end

 #Create Directory /opt/tomcat
 directory "#{tomcat_dir}" do
   group "#{group}"
   recursive true
 end

 #extract tomcat tar.gz. Skip it if tomcat has WEBAPP directory. Assumption is there might be existing applications deployed in WEBAPPS directory. ***This can be changed according to requirements
 execute 'extract_file' do
   command "tar xvf #{remote_file} -C #{tomcat_dir} --strip-components=1"
   not_if do
     File.directory?(node.default['tomcat_recipe']['webapp_dir']) 
   end
 end

 execute 'permission_r' do
   command "chmod -R g+r #{tomcat_conf_dir}"
 end 

 execute 'permission_x' do
  command "chmod g+x #{tomcat_conf_dir}"
 end

 execute 'owner_tomcat' do
   command "chown -R tomcat #{tomcat_dir}"
 end

 #Install the Systemd Unit File
  template node.default['tomcat_recipe']['tomcat_service_unit'] do
    source node.default['tomcat_recipe']['tomcat_service_unit_template']
  end

  systemd_unit node.default['tomcat_recipe']['tomcat_service_daemon'] do
    action :reload
    end
  

  service node.default['tomcat_recipe']['tomcat_service'] do
    action [:start, :enable]
  end

