# packer-elk-docker

Packer, Ansible, Serverspec, project to create an Elastic stack Beats Docker image.

## Requirements

- Packer
- Ansible
- aws-cli

## Install
```shell
git clone https://github.com/apolloclark/packer-elk-docker
cd ./packer-elk-docker

# set your Docker hub username
export DOCKER_USERNAME="test"

# build auditbeat
cd ./auditbeat
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build filebeat
cd ../filebeat
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build metricbeat
cd ../metricbeat
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build heartbeat
cd ../heartbeat
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build packetbeat
cd ../packetbeat
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb



docker run -it $DOCKER_USERNAME/auditbeat:$(date -u '+%Y%m%d') /bin/bash

docker run \
  --cap-add audit_control \
  --pid=host \
  --rm \
  --interactive \
  $DOCKER_USERNAME/auditbeat:$(date -u '+%Y%m%d') \
  test config -c /etc/auditbeat/auditbeat.yml
  
docker run \
  --cap-add net_raw \
  --cap-add net_admin \
  --rm \
  --interactive \
  $DOCKER_USERNAME/packetbeat \
  test config -c /etc/packetbeat/packetbeat.yml

docker run \
  --interactive \
  $DOCKER_USERNAME/filebeat:$(date -u '+%Y%m%d') \
  help

rake spec
```