#!/usr/bin/env bash


set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

##############################################################
#                      Parse Arguments                       #
##############################################################

function usage {
cat << EOF
usage: $0 options

This script requests AWS to generate a new key-pair 

OPTIONS:
 -r      AWS Region
 -n      Key name
EOF
}

AWS_REGION=us-east-1
KEY_NAME=
while getopts "hr:n:" OPTION
do
  case $OPTION in
    h)
      usage
      exit 1
      ;;
    r)
      KONG_VERSION=$OPTARG
      ;;
    n)
      KEY_NAME=$OPTARG
      ;;
    ?)
      usage
      exit
      ;;
  esac
done

if [[ -z $AWS_REGION ]] || [[ -z $KEY_NAME ]]; then
  usage
  exit 1
fi

aws --region $AWS_REGION ec2 create-key-pair --key-name $KEY_NAME | jq -r ".KeyMaterial" > ~/.ssh/$KEY_NAME.pem