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
cd $BASE_DIR/packer-nodejs
./build_packer_docker_all.sh

# build cloudsploit
cd $BASE_DIR/packer-cloudsploit
./build_packer_docker_all.sh



# build openjdk
cd $BASE_DIR/openjdk/openjdk-jdk
./build_packer_docker_all.sh

# build tomcat
cd cd $BASE_DIR/packer-tomcat
./build_packer_docker_all.sh



# build ruby
cd $BASE_DIR/packer-ruby
./build_packer_docker_all.sh

exit;




# build zookeeper
cd $BASE_DIR/zookeeper
./build_packer_docker_all.sh

# build kafka
cd $BASE_DIR/kafka
./build_packer_docker_all.sh

# build jenkins
cd $BASE_DIR/jenkins
./build_packer_docker_all.sh

# build jmeter
cd $BASE_DIR/jenkins
./build_packer_docker_all.sh

# build elasticsearch
cd $BASE_DIR/elasticsearch
./build_packer_docker_all.sh

# build kibana
cd $BASE_DIR/kibana
./build_packer_docker_all.sh

# build logstash
cd $BASE_DIR/logstash
./build_packer_docker_all.sh



# build osquery
cd $BASE_DIR/packer-osquery
./build_packer_docker_all.sh

# build auditbeat
cd ./auditbeat
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build filebeat
cd $BASE_DIR/filebeat
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build heartbeat
cd $BASE_DIR/heartbeat
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build metricbeat
cd $BASE_DIR/metricbeat
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb

# build packetbeat
cd $BASE_DIR/packetbeat
./build_packer_docker.sh
rspec ./spec/Dockerfile_spec.rb
