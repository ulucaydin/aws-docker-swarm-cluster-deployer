# Ansible Cloud Formation automation for creating Docker Swarm clusters

Scalable Docker Swarm cluster deployment using the combination of AWS CloudFormation to create resources (such as EC2, VPC, AutoScaling etc..) and Ansible to automate the process with a single command.

If a Stack already exist with the given stack name, it will update. Otherwise creates a new stack from scratch.

#### Quickstart Guide:

1. Install Docker and Ansible on your local and clone this repo.

2. Edit `group_vars/all/credentials.yml.example` and change it as `group_vars/all/credentials.yml`

3. Edit `group_vars/all/common.yml` as it fits your needs.

4. Make sure to create a keypair in AWS IAM.

5. Crete the CloudFront Stack using Ansible
``` shell
ansible-playbook aws_create_swarm_cluster.yml  --extra-vars "cf_stack_name=<clusters name> cf_cluster_size=<cluster size>"
```

6. Once the Stack creation is complete, Ansible will out provide the output of Swarm Master as related information. You can also view your CloudFormation site and view the "Outputs" of your created stack.

7. Optional: If you are using boot2docker, you may want to disable tsl on your local via `unset DOCKER_TLS_VERIFY`.

8. From your local, connecto Swarm Master and see info: `docker -H tcp://<MasterPublicIP>:2375 info`

9. An example deployment to all nodes from your local: `docker -H tcp://<MasterPublicIP>:2375 run -d -p 80:80 nginx`

#### TODO list:
- Make CoreOS file flexible instead of baked into the template.
- Add 1.9 networking to the 9th step as an example.
