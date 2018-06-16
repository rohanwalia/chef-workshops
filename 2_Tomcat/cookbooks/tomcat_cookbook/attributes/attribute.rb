default['tomcat_recipe']['java_package'] = 'java-1.7.0-openjdk-devel'
default['tomcat_recipe']['tomcat_group'] = 'tomcat'
default['tomcat_recipe']['tomcat_group'] = 'tomcat'
default['tomcat_recipe']['tomcat_user'] = 'tomcat'
default['tomcat_recipe']['tomcat_dir'] = '/opt/tomcat'
default['tomcat_recipe']['tomcat_conf_dir'] = '/opt/tomcat/conf'
default['tomcat_recipe']['tomcat_service_unit'] = '/etc/systemd/system/tomcat.service'
default['tomcat_recipe']['tomcat_repo_source'] = 'https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.9/bin/apache-tomcat-8.5.9.tar.gz'
default['tomcat_recipe']['tomcat_service_unit_template'] = 'tomcat.service.erb'
