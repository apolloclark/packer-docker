#!/bin/bash -eux

# build auditbeat
cd ./auditbeat
./build_packer_docker.sh

# build filebeat
cd ../filebeat
./build_packer_docker.sh

# build metricbeat
cd ../metricbeat
./build_packer_docker.sh

# build heartbeat
cd ../heartbeat
./build_packer_docker.sh

# build packetbeat
cd ../packetbeat
./build_packer_docker.sh

# build openjdk
cd ../openjdk
./build_packer_docker.sh

# build oraclejdk
cd ../oraclejdk
./build_packer_docker.sh
