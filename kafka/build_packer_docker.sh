#!/bin/bash -eux
start=`date +%s`

# ensure that ENV VARs are set
export DOCKER_BASE_IMAGE=${DOCKER_BASE_IMAGE:="apolloclark/openjdk-jre-headless:latest"}
export DOCKER_USERNAME=${DOCKER_USERNAME:=$(whoami)}
export PACKAGE=${PACKAGE:=kafka}
export PACKAGE_VERSION=${PACKAGE_VERSION:=2.1.1}

# remove previously built local images
docker image rmi $DOCKER_USERNAME/$PACKAGE:$PACKAGE_VERSION -f  || true
docker image rmi $DOCKER_USERNAME/$PACKAGE:$(date -u '+%Y%m%d') -f  || true
docker image rmi $DOCKER_USERNAME/$PACKAGE:latest -f  || true

# run Packer
packer validate packer_docker.json
packer inspect packer_docker.json
packer build packer_docker.json

end=`date +%s`
secs=$((end-start))
printf 'runtime = %02dh:%02dm:%02ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))

# test the Docker image w/ Serverspec
rspec ./spec/Dockerfile_$DOCKER_BASE_IMAGE.rb

end=`date +%s`
secs=$((end-start))
printf 'runtime = %02dh:%02dm:%02ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))
