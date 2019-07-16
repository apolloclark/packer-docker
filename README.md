# packer-docker

I rebuild my Docker images every week. You should too! 🧐

Packer, Ansible, Serverspec, project to create Docker images.

## Requirements

- Packer
- Ansible
- Ruby, [Serverspec](https://serverspec.org/): gem install serverspec
- Ruby, Docker-Api: gem install docker-api

## Install
```shell
git clone --recurse-submodules https://github.com/apolloclark/packer-docker
cd ./packer-elk-docker

# add submodules
git submodule add https://github.com/apolloclark/gradle-build
git submodule add https://github.com/apolloclark/packer-build

# update submodules
git submodule init
git submodule update --recursive --remote

# set your Docker hub username, beats version, java version
export DOCKER_USERNAME="apolloclark" # $(whoami)
export BEATS_VERSION="6.5.4"   # https://github.com/elastic/beats/releases
export JAVA_VERSION="11.0.1"   # https://launchpad.net/~openjdk-r/+archive/ubuntu/ppa?field.series_filter=xenial
export TOMCAT_VERSION="9.0.14" # https://archive.apache.org/dist/tomcat/tomcat-9/

# ./all.sh
./lint.sh
./build_test.sh
./push.sh




# run a specific container
docker run -it $DOCKER_USERNAME/auditbeat:$(date -u '+%Y%m%d') /bin/bash

# run auditbeat, with necessary privs
docker run \
  --cap-add audit_control \
  --pid=host \
  --rm \
  --interactive \
  $DOCKER_USERNAME/auditbeat:$(date -u '+%Y%m%d') \
  test config -c /etc/auditbeat/auditbeat.yml

# run packetbeat, with necessary privs
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
Beats, 6.5.4, 2018-12-19
https://github.com/elastic/beats/releases

Java, 11.0.1, 2018-10-17
https://en.wikipedia.org/wiki/Java_version_history
https://launchpad.net/~linuxuprising/+archive/ubuntu/java
https://launchpad.net/~openjdk-r/+archive/ubuntu/ppa/+packages?field.name_filter=&field.status_filter=published&field.series_filter=xenial

Tomcat, 9.0.14, 2018-12-06
https://github.com/docker-library/tomcat/blob/master/9.0/jre11/Dockerfile
https://tomcat.apache.org/tomcat-9.0-doc/changelog.html
http://tomcat.apache.org/whichversion.html

Zookeeper, 3.4.13, 2018-06-15
https://zookeeper.apache.org/releases.html

Kafka, 2.1.1, 2019-02-15
https://kafka.apache.org/downloads

https://github.com/idealista/java-role
https://github.com/idealista/tomcat-role
https://github.com/idealista/zookeeper-role
https://github.com/idealista/kafka-role

https://github.com/elastic/elasticsearch-docker/tree/master/.tedi/template
https://molecule.readthedocs.io/en/latest/index.html


```
