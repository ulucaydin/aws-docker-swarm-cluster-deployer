#!/usr/bin/env bash


set -o errexit
# set -o xtrace

LAUNCHER_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
AWS_REGION="`echo \"$LAUNCHER_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"

function usage {
cat << EOF

Please set all required environment variables before running the script  

AWS_ACCESS_KEY_ID ( required )
AWS_SECRET_ACCESS_KEY ( required )
EBS_VOLUME_SIZE ( optional )
INATANCE_TYPE ( optional )
MINION_CLUSTER_SIZE ( optional )
MASTER_CLUSTER_SIZE ( optional )
KAY_NAME ( required )
VPC_AVAILABILITY_ZONES ( optional )
ALLOW_SSH_FROM ( optional )
CERT_ARN ( required )

EOF
}

if [[ -z $AWS_REGION ]] || [[ -z $KEY_NAME ]] || [[ -z $AWS_ACCESS_KEY_ID ]] || [[ -z $AWS_SECRET_ACCESS_KEY ]] || [[ -z $CERT_ARN ]]; then
  usage
  exit 1
fi


##############################################################
#                      create key-pair                       #
##############################################################

bash generate_key.sh -r $AWS_REGION -n $KEY_NAME

##############################################################
#                      stack up cluster                      #
##############################################################
# load template parameter
# ansible-playbook aws_create_swarm_cluster.yml --extra-vars "cf_stack_name=mashape-enterprise-swarm"
# get elb_dns
# export DOCKER_HOST=tcp://{{ elb_dns }}:4000

##############################################################
#                      deploy all apps                       #
##############################################################
# bash deployer.sh
