# packer-elk-docker

Packer, Ansible, Serverspec, project to create an Elastic stack Beats Docker images.

## Requirements

- Packer
- Ansible
- Ruby, [Serverspec](https://serverspec.org/): gem install serverspec
- Ruby, Docker-Api: gem install docker-api

## Install
```shell
git clone https://github.com/apolloclark/packer-elk-docker
cd ./packer-elk-docker

# set your Docker hub username, beats version, java version
export DOCKER_USERNAME="apolloclark" # $(whoami)
export BEATS_VERSION="6.4.2"
export JAVA_VERSION="11.0.1"

# ./all.sh
./lint.sh
./build_test.sh
./push.sh



# run a specific container
docker run -it $DOCKER_USERNAME/auditbeat:$(date -u '+%Y%m%d') /bin/bash

# run auditbeat
docker run \
  --cap-add audit_control \
  --pid=host \
  --rm \
  --interactive \
  $DOCKER_USERNAME/auditbeat:$(date -u '+%Y%m%d') \
  test config -c /etc/auditbeat/auditbeat.yml

# run packetbeat
docker run \
  --cap-add net_raw \
  --cap-add net_admin \
  --rm \
  --interactive \
  $DOCKER_USERNAME/packetbeat \
  test config -c /etc/packetbeat/packetbeat.yml

# run a test suite
rake spec

# push image

# delete ALL images on your system (including non Beat images)
docker system prune -af

```