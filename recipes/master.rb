#
# Cookbook:: redis
# Recipe:: dmeefault
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#

#include_recipe "redis::slave"

HOME = node["redis"]["home"]

rpm_package 'epel-release-latest-7.noarch.rpm' do
    source 'http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm'
    action :install
end

#%w(redis).each do |pkg|
# package pkg do
#   action :install
# end
#end

package "redis"

file '/etc/sysctl.conf' do
  content 'vm.overcommit_memory = 1'
end

temp = search(:node,"name:#{node['redis']['masternode_name']}")
puts temp[0]['ipaddress']


template "#{HOME}/redis.conf" do
  source "master.conf.erb"
  variables ({
     "append" => node["redis"]["appendonly"],
     "bind" => node["redis"]["bind"]  
#     "ip" => "#{temp[0]['ipaddress']}"
   })
  action :create
 notifies :restart, 'service[redis]', :delayed
end

template "#{HOME}/redis-sentinel.conf" do
  source "master-sentinel.conf.erb"
  variables ({
     "ip" => "#{temp[0]['ipaddress']}"
   })
  action :create
 notifies :restart, 'service[redis]', :delayed
end

execute "run sentinel" do
  cwd "#{HOME}/"
  command "sudo redis-server redis-sentinel.conf --sentinel &"
  only_if "[[ -z $(sudo netstat -tulpn | grep 26379) ]]"
end

service "redis" do
  supports :restart => true, :start => true, :stop => true
  action [:enable, :start]
end
