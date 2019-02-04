#!/bin/bash -euxo

# ensure Bash scripts are set to strict mode
find . -iname '*.sh' -exec grep -H -F '#!/bin/bash -eux' {} \;

# ensure Packer builder exists
jq ".builders[].type" ./packer_docker.json | grep "docker"

# ensure Serverspec tests exist
grep "serverspec" -r .
