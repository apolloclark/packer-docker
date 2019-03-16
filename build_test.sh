#!/bin/bash -eux

# build openjdk
cd ./openjdk

# build openjdk-jdk
cd ./openjdk-jdk
./build_packer_docker_all.sh
cd ../



# build tomcat
cd ../packer-tomcat
./build_packer_docker_all.sh

# build elasticsearch
cd ../elasticsearch
./build_packer_docker_all.sh



# build osquery
cd ../packer-osquery
./build_packer_docker_all.sh

# build ruby
cd ../packer-ruby
./build_packer_docker_all.sh

# build nodejs
cd ../packer-nodejs
./build_packer_docker_all.sh

# build cloudsploit
cd ../packer-cloudsploit
./build_packer_docker_all.sh

exit 0;



# build kibana
cd ../kibana
./build_packer_docker_all.sh

# build logstash
cd ../logstash
./build_packer_docker_all.sh

# build zookeeper
cd ../zookeeper
./build_packer_docker_all.sh

# build kafka
cd ../kafka
./build_packer_docker_all.sh

# build jenkins
cd ../jenkins
./build_packer_docker_all.sh

# build jmeter
cd ../jenkins
./build_packer_docker_all.sh



# build postgres
cd ../postgres
./build_packer_docker_all.sh

# build redis
cd ../kafka
./build_packer_docker_all.sh



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

