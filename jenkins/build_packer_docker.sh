#!/bin/bash -eux
start=`date +%s`

# set vars to defaults, if not defined
export DOCKER_USERNAME=${DOCKER_USERNAME:=$(whoami)}
export PACKAGE_VERSION=${JENKINS_VERSION:="2.151.2"}
export PACKAGE="jenkins"

# remove previously built local images
docker image rmi $DOCKER_USERNAME/$PACKAGE:$PACKAGE_VERSION -f  || true
docker image rmi $DOCKER_USERNAME/$PACKAGE:$(date -u '+%Y%m%d') -f  || true
docker image rmi $DOCKER_USERNAME/$PACKAGE:latest -f  || true

docker container rm default -f || true

# run Packer
packer validate packer_docker.json

packer inspect packer_docker.json

packer build packer_docker.json


end=`date +%s`
secs=$((end-start))
printf 'runtime = %02dh:%02dm:%02ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))
