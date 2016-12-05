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
 -k      AWS Access ID
 -s      AWS Secret Key
EOF
}

AWS_REGION=us-east-1
KEY_NAME=
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=

while getopts "hr:n:k:s:" OPTION
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
    k)
      AWS_ACCESS_KEY_ID=$OPTARG
      ;;
    s)
      AWS_SECRET_ACCESS_KEY=$OPTARG
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

if [[ -n $AWS_ACCESS_KEY_ID ]]; then
  export AWS_ACCESS_KEY_ID
fi

if [[ -n $AWS_SECRET_ACCESS_KEY ]]; then
  export AWS_SECRET_ACCESS_KEY
fi

aws --region $AWS_REGION ec2 create-key-pair --key-name $KEY_NAME | jq -r ".KeyMaterial" > ~/.ssh/$KEY_NAME.pem