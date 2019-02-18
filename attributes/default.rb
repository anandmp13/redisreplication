#master
default["redis"]["bind"]= "0.0.0.0"
#default["redis"]["ip"]= "172.31.17.182"
#default["redis"]["master"]["bindport"]= "6379"
default["redis"]["home"]= "/etc"
default["redis"]["appendonly"]= "yes"

#sentinel
#default["redis"]["master"]["sentinelbindaddress"]= "127.0.0.1"



#slave1
#default["redis"]["slave"]["bindaddress"]= "127.0.0.1"
#default["redis"]["slave"]["bindport"]= "6380"
#default["redis"]["masterip"]= "172.31.17.182"
default["redis"]["masterport"]= "6379"

#sentinelslave
#default["redis"]["slave"]["sentinelbindaddress"]= "127.0.0.1"
#default["redis"]["slave"]["sentinelbindport"]= 26380
