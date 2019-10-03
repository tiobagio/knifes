#!bin/sh

#	|n| puts n.run_list.remove("role[bca_role]"); \
#	n.run_list << "role[base]";  \
#	|n| n.run_list([]); \

knife exec -E 'nodes.find("name:bca*oracle76") { \
	|n| n.run_list(["role[base]", "recipe[cis-oracle]", "role[audit]"]) ;\
	puts n.name; \
	n.save \
}'

knife exec -E 'nodes.find("name:bca*rhel75") { \
	|n| n.run_list(["role[base]", "recipe[cis-rhel]", "role[audit]"]) ;\
	puts n.name; \
	n.save \
}'

