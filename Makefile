create_docker_swarm:
	ansible-playbook aws_create_swarm_cluster.yml

destroy_docker_swarm:
	ansible-playbook aws_destroy_swarm_cluster.yml
