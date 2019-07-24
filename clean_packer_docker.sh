#!/bin/bash -eux
start=`date +%s`

# ensure that ENV VARs are set
export DOCKER_USERNAME=${DOCKER_USERNAME:=$(whoami)}


# remove previously built local images
docker system prune -f

docker images -a | grep -v "ubi" | grep -F "$DOCKER_USERNAME" | awk '{print $3}' | xargs docker rmi -f

end=`date +%s`
secs=$((end-start))
printf 'runtime = %02dh:%02dm:%02ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))
