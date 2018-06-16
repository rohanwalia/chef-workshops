default['tomcat_recipe']['tomcat_group'] = 'tomcat'
default['tomcat_recipe']['tomcat_group'] = 'tomcat'
default['tomcat_recipe']['tomcat_user'] = 'tomcat'
default['tomcat_recipe']['tomcat_dir'] = '/opt/tomcat'
default['tomcat_recipe']['tomcat_conf_dir'] = '/opt/tomcat/conf/'
default['tomcat_recipe']['tomcat_service_unit'] = '/etc/systemd/system/tomcat.service'
default['tomcat_recipe']['tomcat_repo_source'] = 'https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.9/bin/apache-tomcat-8.5.9.tar.gz'
default['tomcat_recipe']['tomcat_service'] = 'tomcat'
default['tomcat_recipe']['tomcat_service_daemon'] = 'daemon'
default['tomcat_recipe']['nologin_shell'] = '/bin/nologin'
default['tomcat_recipe']['remote_file'] = '/tmp/apache-tomcat-8.5.9.tar.gz'
default['tomcat_recipe']['tar_dir'] = '/tmp/apache-tomcat-8.5.9'
default['tomcat_recipe']['webapp_dir'] = '/opt/tomcat/webapps'

case node['platform_family']

 when 'rhel'
  default['tomcat_recipe']['package_update_command'] = 'yum -y update'
  default['tomcat_recipe']['java_package'] = 'java-1.7.0-openjdk-devel'
  default['tomcat_recipe']['tomcat_service_unit_template'] = 'tomcat.service.erb'
 when 'debian'
  default['tomcat_recipe']['package_update_command'] = 'apt-get update'
  default['tomcat_recipe']['java_package'] = 'default-jdk'
  default['tomcat_recipe']['tomcat_service_unit_template'] = 'tomcat.service.ubuntu16.erb'
end


