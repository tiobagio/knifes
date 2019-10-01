#!bin/sh

#	|n| puts n.run_list.remove("role[bca_role]"); \
#	n.run_list << "role[base]";  \
#	|n| n.run_list([]); \

knife exec -E 'nodes.find("name:bca*") { \
	|n| n.run_list << "role[base]"; \
	n.run_list << "role[audit]"; \
	puts n.name; \
	n.save \
}'
