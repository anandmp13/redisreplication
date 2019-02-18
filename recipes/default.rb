#ip = search(:node,"#{node['redis']['redismaster']}")
#puts ip[0]['ipaddress']

if node['redis']['master'] == "true"
include_recipe 'redis::master'
elsif node['redis']['slave'] == "true"
include_recipe 'redis::slave'
end
