# packer-elk-docker

Packer, Ansible, Serverspec, project to create an Elastic stack Beats Docker image.


## Install
```shell

cd ./packer-elk-docker/auditbeat

# set your Docker hub username
export DOCKER_USERNAME="test"
./build_packer_docker.sh

docker run -it apolloclark/auditbeat:$(date -u '+%Y%m%d') bash
```