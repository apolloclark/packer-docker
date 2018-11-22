#!/bin/bash -eux
start=`date +%s`

# remove previously built local images
docker image rmi $DOCKER_USERNAME/packetbeat:$(date -u '+%Y%m%d') -f  || true
docker image rmi $DOCKER_USERNAME/packetbeat:latest -f  || true

docker container rm default -f || true

# run Packer
packer validate packer_docker.json

packer inspect packer_docker.json

packer build packer_docker.json


end=`date +%s`
secs=$((end-start))
printf 'runtime = %02dh:%02dm:%02ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))
