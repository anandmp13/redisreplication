#
# Cookbook:: redis
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#

HOME = node["redis"]["home"]

%w(epel-release redis).each do |pkg|
 package pkg do
   action :install
 end
end

temp = search(:node,"name:#{node['redis']['masternode_name']}")
puts temp[0]['ipaddress']

template "#{HOME}/redis.conf" do
  source "slave.conf.erb"
  variables ({
     "append" => node["redis"]["appendonly"],
     "bind" => node["redis"]["bind"],
     "masterip" => "#{temp[0]['ipaddress']}",
     "masterport" => node["redis"]["masterport"]
   })
  action :create
  notifies :restart, 'service[redis]', :delayed
end

template "#{HOME}/redis-sentinel.conf" do
  source "slave-sentinel.conf.erb"
  variables ({
     "local" => node["redis"]["local"],
     "masterip" => "#{temp[0]['ipaddress']}",
     "masterport" => node["redis"]["masterport"]
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
