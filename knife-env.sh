#!bin/sh

#	|n| puts n.run_list.remove("role[bca_role]"); \
#	n.run_list << "role[base]";  \
#	|n| n.run_list([]); \

knife exec -E 'nodes.find("name:bca1*") { \
	|n| n.chef_environment("sit"); \
	puts n.name; \
	n.save \
}'

knife exec -E 'nodes.find("name:bca2*") { \
	|n| n.chef_environment("prod"); \
	puts n.name; \
	n.save \
}'

