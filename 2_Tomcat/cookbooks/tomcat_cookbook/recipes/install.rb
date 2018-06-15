#
# Cookbook:: tomcat_cookbook
# Recipe:: install
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Install java-1.7.0-openjdk-devel - sudo yum install java-1.7.0-openjdk-devel
package 'java-1.7.0-openjdk-devel'

#Add Group tomcat
group 'tomcat'

#Add user tomcat with home directory
user 'tomcat' do
    manage_home false
    group 'tomcat'
    shell '/bin/nologin'
    home '/opt/tomcat'
  end

  #Download and extract tomcat 8 - $ wget http://apache.cs.utah.edu/tomcat/tomcat-8/v8.5.20/bin/apache-tomcat-8.5.20.tar.gz
 remote_file 'apache-tomcat-8.5.20.tar.gz' do
    source 'https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.9/bin/apache-tomcat-8.5.9.tar.gz'
 end

 #Create Directory /opt/tomcat
 directory '/opt/tomcat' do
   group 'tomcat'
   recursive true
 end

 execute 'tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'

 execute 'chmod -R g+r /opt/tomcat/conf/'
 
 execute 'chmod g+x /opt/tomcat/conf/'
 
 execute 'chown -R tomcat /opt/tomcat/'


 #Install the Systemd Unit File
  template '/etc/systemd/system/tomcat.service' do
    source 'tomcat.service.erb'
  end

  systemd_unit 'daemon' do
    action :reload
    end
  

  service 'tomcat' do
    action [:start, :enable]
  end

