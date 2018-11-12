# packer-elk-docker

Packer, Ansible, Serverspec, project to create an Elastic stack Beats Docker image.


## Install
```shell
git clone https://github.com/apolloclark/packer-elk-docker

cd ./packer-elk-docker/auditbeat

# set your Docker hub username
export DOCKER_USERNAME="test"
./build_packer_docker.sh

docker run -it $DOCKER_USERNAME/auditbeat:$(date -u '+%Y%m%d') bash
```