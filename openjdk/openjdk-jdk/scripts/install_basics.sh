#!/bin/bash -eux

if [ -x "$(command -v apt-get)" ]; then
	apt-get update
	apt-get upgrade -y
    apt-get install -y aptitude python-minimal apt-transport-https ca-certificates-java git bzip2 unzip xz-utils
fi

if [ -x "$(command -v yum)" ]; then
	yum update -y
	yum install -y which nano curl wget git initscripts
fi
