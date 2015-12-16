# Ansible Cloud Formation automation for creating Docker Swarm clusters

If a Stack already exist with the given stack name, it will update. Otherwise creates a new stack from scratch.

Here is the basic command to run the automation:
``` shell
ansible-playbook aws_create_swarm_cluster.yml  --extra-vars "cf_stack_name=<clusters name> cf_cluster_size=<cluster size>"
```
