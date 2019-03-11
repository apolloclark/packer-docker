#!/bin/bash -eux

# build openjdk
cd ./openjdk

# build openjdk-jdk
cd ./openjdk-jdk
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build openjdk-jdk-headless
cd ../openjdk-jdk-headless
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build openjdk-jre
cd ../openjdk-jre
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build openjdk-jre-headless
cd ../openjdk-jre-headless
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build oraclejdk
cd ../oraclejdk
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb



# build tomcat
cd ../tomcat
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build kafka
cd ../kafka
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb



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
