#!/bin/bash -eux

if [ -x "$(command -v apt-get)" ]; then
	apt-get update
	apt-get upgrade -y
    apt-get install -y aptitude python-minimal nano curl wget git apt-transport-https
fi

if [ -x "$(command -v yum)" ]; then
	yum update -y
	yum install -y sudo which nano curl wget git
fi
