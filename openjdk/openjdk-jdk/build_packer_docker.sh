#!/bin/bash -eux
start=`date +%s`

# set defaults
export DOCKER_USERNAME=${DOCKER_USERNAME:=$(whoami)}
export PACKAGE=${PACKAGE:=openjdk}
export PACKAGE_VERSION=${PACKAGE_VERSION:="11.0.1"}
export BASE_IMAGE=${BASE_IMAGE:="ubuntu:16.04"}
export IMAGE_NAME=${IMAGE_NAME:="ubuntu16.04"}

# remove previously built local images
docker image rmi $DOCKER_USERNAME/$PACKAGE:$PACKAGE_VERSION-$IMAGE_NAME-$(date -u '+%Y%m%d') -f  || true
docker image rmi $DOCKER_USERNAME/$PACKAGE:$PACKAGE_VERSION-$IMAGE_NAME -f  || true
docker container rm $PACKAGE_VERSION-$IMAGE_NAME -f || true



# run Packer
packer validate packer_docker.json
packer inspect packer_docker.json
packer build packer_docker.json

end=`date +%s`
secs=$((end-start))
printf 'runtime = %02dh:%02dm:%02ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))



# test the Docker image w/ Serverspec
rspec ./spec/Dockerfile_$IMAGE_NAME.rb

# push images
docker push $DOCKER_USERNAME/$PACKAGE:$PACKAGE_VERSION-$IMAGE_NAME-$(date -u '+%Y%m%d');
docker push $DOCKER_USERNAME/$PACKAGE:$PACKAGE_VERSION-$IMAGE_NAME;

end=`date +%s`
secs=$((end-start))
printf 'runtime = %02dh:%02dm:%02ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))
