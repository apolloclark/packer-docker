#!/bin/bash -eux

docker push $DOCKER_USERNAME/auditbeat:$BEATS_VERSION;
docker push $DOCKER_USERNAME/filebeat:$BEATS_VERSION;
docker push $DOCKER_USERNAME/heartbeat:$BEATS_VERSION;
docker push $DOCKER_USERNAME/metricbeat:$BEATS_VERSION;
docker push $DOCKER_USERNAME/packetbeat:$BEATS_VERSION;
docker push $DOCKER_USERNAME/java:$JAVA_VERSION;
