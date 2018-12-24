#!/bin/bash -eux

docker image rmi $DOCKER_USERNAME/auditbeat:$BEATS_VERSION -f  || true
docker image rmi $DOCKER_USERNAME/auditbeat:$(date -u '+%Y%m%d') -f  || true
docker image rmi $DOCKER_USERNAME/auditbeat:latest -f  || true

docker image rmi $DOCKER_USERNAME/filebeat:$BEATS_VERSION -f  || true
docker image rmi $DOCKER_USERNAME/filebeat:$(date -u '+%Y%m%d') -f  || true
docker image rmi $DOCKER_USERNAME/filebeat:latest -f  || true

docker image rmi $DOCKER_USERNAME/heartbeat:$BEATS_VERSION -f  || true
docker image rmi $DOCKER_USERNAME/heartbeat:$(date -u '+%Y%m%d') -f  || true
docker image rmi $DOCKER_USERNAME/heartbeat:latest -f  || true

docker image rmi $DOCKER_USERNAME/metricbeat:$BEATS_VERSION -f  || true
docker image rmi $DOCKER_USERNAME/metricbeat:$(date -u '+%Y%m%d') -f  || true
docker image rmi $DOCKER_USERNAME/metricbeat:latest -f  || true

docker image rmi $DOCKER_USERNAME/packetbeat:$BEATS_VERSION -f  || true
docker image rmi $DOCKER_USERNAME/packetbeat:$(date -u '+%Y%m%d') -f  || true
docker image rmi $DOCKER_USERNAME/packetbeat:latest -f  || true

docker image rmi $DOCKER_USERNAME/java:$JAVA_VERSION -f  || true
docker image rmi $DOCKER_USERNAME/java:$(date -u '+%Y%m%d') -f  || true
docker image rmi $DOCKER_USERNAME/java:latest -f  || true
