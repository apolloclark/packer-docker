#!/bin/bash -eux


# ensure Packer build
jq ".builders[].type" ./packer_docker.json | grep "docker"

# ensure Serverspec tests
grep "serverspec" -r .
