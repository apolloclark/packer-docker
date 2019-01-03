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
export TOMCAT_VERSION="9.0.14"

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

## Build Details

```shell
Beats, 6.4.2, 2018-10-02
https://github.com/elastic/beats/releases

Java, 11.0.1, 2018-10-17
https://en.wikipedia.org/wiki/Java_version_history
https://launchpad.net/~linuxuprising/+archive/ubuntu/java

Tomcat, 9.0.14, 2018-12-06
https://tomcat.apache.org/tomcat-9.0-doc/changelog.html
http://tomcat.apache.org/whichversion.html


https://github.com/idealista/java-role
https://github.com/idealista/tomcat-role
https://github.com/idealista/zookeeper-role
https://github.com/idealista/kafka-role

https://github.com/elastic/elasticsearch-docker/tree/master/.tedi/template
https://molecule.readthedocs.io/en/latest/index.html


```