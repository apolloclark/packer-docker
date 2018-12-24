#!/bin/bash -eux


# ensure Bash scripts are set to strict mode
grep -F "#!/bin/bash -eux" -r .

# ensure Packer builder exists
jq ".builders[].type" ./packer_docker.json | grep "docker"

# ensure Serverspec tests exist
grep "serverspec" -r .
