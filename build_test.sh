#!/bin/bash -eux

export BASE_DIR=$(pwd);

# build python3
cd $BASE_DIR/packer-python3
./build_packer_docker_all.sh

# build pacu
cd $BASE_DIR/packer-pacu
./build_packer_docker_all.sh

# build skew
# cd $BASE_DIR/packer-skew
# ./build_packer_docker_all.sh

# build aws-inventory
# cd $BASE_DIR/packer-aws-inventory
# ./build_packer_docker_all.sh

# build cloud-custodian
# cd $BASE_DIR/packer-cloud-custodian
# ./build_packer_docker_all.sh



# build nodejs
cd ../packer-nodejs
./build_packer_docker_all.sh

# build cloudsploit
cd ../packer-cloudsploit
./build_packer_docker_all.sh



# build openjdk
cd $BASE_DIR/openjdk/openjdk-jdk
./build_packer_docker_all.sh

# build tomcat
cd cd $BASE_DIR/packer-tomcat
./build_packer_docker_all.sh



# build ruby
cd ../packer-ruby
./build_packer_docker_all.sh

exit;




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

# build elasticsearch
cd ../elasticsearch
./build_packer_docker_all.sh

# build kibana
cd ../kibana
./build_packer_docker_all.sh

# build logstash
cd ../logstash
./build_packer_docker_all.sh



# build osquery
cd ../packer-osquery
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
