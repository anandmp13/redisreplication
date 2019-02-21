# redis

TODO: Enter the cookbook description here.

cookbook name: redis
recipes:default.rb
        master.rb
        slave.rb

default.rb: this recipe will choose the whether it shoul run master recipe or slave recipe which will defined in the node attributes

master.rb: this recipe installs the redis and configures the redis and sentinel with respect to the master configuration. Start the redis and sentinel services 

slave.rb: this recipe installs the redis and configures the redis and sentinel with respect to the slave configuration. Start the redis and sentinel services

node attributes
master.json
{
  "redis": {
      "master": "true",
      "slave": "false",
      "clustername": "mycluster",
      "masternode_name": "MasterR",
      "clusternodes": ["Slave1R","Slave2R","MasterR"]
    }
}

slave.json

{
  "redis": {
      "master": "false",
      "slave": "true",
      "clustername": "mycluster",
      "masternode_name": "MasterR",
      "clusternodes": ["Slave1R","Slave2R","MasterR"]
    }
}


default attributes

attributes/default.rb

default["redis"]["bind"]= "0.0.0.0"
default["redis"]["home"]= "/etc"
default["redis"]["appendonly"]= "yes"
default["redis"]["masterport"]= "6379"


