# packer-elk-docker

Packer, Ansible, Serverspec, project to create an Elastic stack Beats Docker image.

## Requirements

- Packer
- Ansible
- aws-cli

## Install
```shell
git clone https://github.com/apolloclark/packer-elk-docker

cd ./packer-elk-docker/auditbeat

# set your Docker hub username
export DOCKER_USERNAME="test"
./build_packer_docker.sh

rspec ./spec/Dockerfile_spec.rb

docker run -it $DOCKER_USERNAME/auditbeat:$(date -u '+%Y%m%d') /bin/bash

docker run \
  --cap-add audit_control \
  --pid=host \
  --rm \
  --interactive \
  $DOCKER_USERNAME/auditbeat:$(date -u '+%Y%m%d') \
  help

rake spec
```