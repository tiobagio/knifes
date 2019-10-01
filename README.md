From https://gist.github.com/ipedrazas/aadbaeb808f5ace5d3ce
# knife cheat

## Search Examples

	knife search "name:ip*" 
	knife search "platform:ubuntu*"
	knife search "platform:*" -a macaddress
	knife search "platform:ubuntu*" -a uptime
	knife search "platform:ubuntu*" -a virtualization.system
	knife search "platform:ubuntu*" -a network.default_gateway
	knife search "platform:*" -a languages.ruby.version
	knife search "platform:*" -a kernel.machine
	knife search users "groups:admin" -i
	knife role list

## SSH Examples

	knife ssh "name:arlo*" -x root -P PASSWORD uptime
	knife ssh "NOT platform:win*" -P PASSWORD ls
	knife ssh "chef_environment:Helix-Uptime-VM and NOT platform:win*" \
		-x root -P PASSWORD uptime

##Chef Client

How do I automatically bootstrap a linux box?

	knife bootstrap 10.0.0.2 -N www.racter.com -x root -P PASSWORD

How do I make the chef client run so it will apply my new recipes?

	knife winrm "platform:windows" -P PASSWORD chef-client
	knife ssh "NOT platform:win*" -x root -P PASSWORD chef-client

How do I make sure the chef client on the nodes is calling home?

	knife cookbook site install chef-client
	knife cookbook upload chef-client
	knife node run_list add NODENAME 'recipe[chef-client]'

##Cookbooks

How do I create a new cookbook?

	cd ~/chef-repo
	rake new_cookbook COOKBOOK=MyNew-Controller

How do I upload my new cookbook to the chef server so I can use it?

	knife cookbook upload <cookbookname> –include-dependencies

How do I download existing recipes from the Chef Community?

	knife cookbook site install awsclient

How do I add a new recipe to every node?

	knife exec -E "nodes.transform(“chef_environment:dev“) \
		{|n| puts n.run_list.remove(“recipe[chef-client::upgrade]“); n.save }"

 

	knife exec -E "nodes.find(“role:web_server”) \
		{|n| n.run_list.remove(“role[web_server]“); }"
	knife exec -E "nodes.find(“name:test*”) \
		{|n| n.chef_environment(“dev”);n.save }"

 

How do I download the recipes, environments, nodes and everything that is already uploaded to the chef server?

	knife download /

##EC2

How do I launch a new server into the amazon cloud?

	knife ec2 server create -I ami-d0f89fb9 -x ubuntu \
		-E My-PreProduction-Env -r “role[BuildServer]” -g sg-d5d417be

How do I shut down a old server in the amazon cloud?

	knife ec2 server delete i-234a334 –purge

 

###Nodes

How do I move nodes between environments?

	#Move all the nodes in _default environment to the production-VM environment

	knife exec -E "nodes.transform(“chef_environment:_default”) \
		{ |n| n.chef_environment(“production-VM”) }"

Remove a recipe from all nodes in an Environment

	knife exec -E "nodes.transform(“chef_environment:dev”) \ 
		{|n| puts n.run_list.remove(“recipe[chef-client::upgrade]“); n.save }"

 

#Roles

How do I add a Linux role to all the boxes that are not window?

	knife exec -E "nodes.transform(“NOT platform:win*“) \
		{|n| puts n.run_list << “role[linux]“; n.save }"

How do I remove a Linux role from all the boxes that are not windows?

	knife exec -E "nodes.transform(“NOT platform:win*“) \
		{|n| puts n.run_list.remove(“role[linux]“); n.save }"

Remove all nodes from a given role

	knife exec -E "nodes.find(“role:web_server”) \
		{|n| n.run_list.remove(“role[web_server]“); n.save}"

 

How do I add a role to an environment?

	knife exec -E 'nodes.transform("chef_environment:my-production-env") \
		{|n| puts n.run_list << "role[hosts_file]"; n.save }'
