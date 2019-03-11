#!/bin/bash -eux
start=`date +%s`

# ensure that ENV VARs are set
export DOCKER_BASE_IMAGE=${DOCKER_BASE_IMAGE:="apolloclark/openjdk-jre-headless:latest"}
# idealista/jdk:8u181-stretch-openjdk-headless
export DOCKER_USERNAME=${DOCKER_USERNAME:=$(whoami)}
export PACKAGE=${PACKAGE:=zookeeper}
export PACKAGE_VERSION=${PACKAGE_VERSION:=3.4.13}

# remove previously built local images
docker image rmi $DOCKER_USERNAME/$PACKAGE:$PACKAGE_VERSION -f || true
docker image rmi $DOCKER_USERNAME/$PACKAGE:$(date -u '+%Y%m%d') -f || true
docker image rmi $DOCKER_USERNAME/$PACKAGE:latest -f || true
docker container prune -f || true

docker network rm zookeeper || true
docker network create zookeeper

# run Packer
packer validate packer_docker.json
packer inspect packer_docker.json
packer build packer_docker.json

docker network rm zookeeper

end=`date +%s`
secs=$((end-start))
printf 'runtime = %02dh:%02dm:%02ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))

# test the Docker image w/ Serverspec
rspec ./spec/Dockerfile_spec.rb

end=`date +%s`
secs=$((end-start))
printf 'runtime = %02dh:%02dm:%02ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))
