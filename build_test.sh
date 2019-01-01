#!/bin/bash -eux

# build auditbeat
cd ./auditbeat
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build filebeat
cd ../filebeat
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build heartbeat
cd ../heartbeat
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build metricbeat
cd ../metricbeat
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build packetbeat
cd ../packetbeat
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build openjdk
cd ../openjdk
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build oraclejdk
cd ../oraclejdk
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb
