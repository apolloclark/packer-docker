#!/bin/bash -eux

docker push $DOCKER_USERNAME/auditbeat:$BEATS_VERSION;
docker push $DOCKER_USERNAME/filebeat:$BEATS_VERSION;
docker push $DOCKER_USERNAME/heartbeat:$BEATS_VERSION;
docker push $DOCKER_USERNAME/metricbeat:$BEATS_VERSION;
docker push $DOCKER_USERNAME/packetbeat:$BEATS_VERSION;
docker push $DOCKER_USERNAME/openjdk:$JAVA_VERSION;
docker push $DOCKER_USERNAME/oraclejdk:$JAVA_VERSION;
docker push $DOCKER_USERNAME/tomcat:$TOMCAT_VERSION;

docker push $DOCKER_USERNAME/auditbeat:latest;
docker push $DOCKER_USERNAME/filebeat:latest;
docker push $DOCKER_USERNAME/heartbeat:latest;
docker push $DOCKER_USERNAME/metricbeat:latest;
docker push $DOCKER_USERNAME/packetbeat:latest;
docker push $DOCKER_USERNAME/openjdk:latest;
docker push $DOCKER_USERNAME/oraclejdk:latest;
docker push $DOCKER_USERNAME/tomcat:latest;
