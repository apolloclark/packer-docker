#!/bin/bash -eux

# set your Docker hub username
export DOCKER_USERNAME="apolloclark"

# test auditbeat
cd ./auditbeat
rspec ./spec/Dockerfile_spec.rb

# test filebeat
cd ../filebeat
rspec ./spec/Dockerfile_spec.rb

# test metricbeat
cd ../metricbeat
rspec ./spec/Dockerfile_spec.rb

# test heartbeat
cd ../heartbeat
rspec ./spec/Dockerfile_spec.rb

# test packetbeat
cd ../packetbeat
rspec ./spec/Dockerfile_spec.rb
