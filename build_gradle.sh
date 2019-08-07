#!/bin/bash -eux
start=`date +%s`

./clean_packer_docker.sh

# stop any existing Gradle instances
sudo killall -9 java || true

gradle testBaseImages --parallel --rerun-tasks
docker images | tail -n +2 | sort
gradle pushBaseImages

# sleep 60s
# mkdir -p ~/.packer.d/tmp
# chmod 0777 ~/.packer.d/tmp
gradle testChildImages --parallel --rerun-tasks

docker ps
docker container ls --all
docker images | tail -n +2 | sort

gradle pushChildImages

end=`date +%s`
secs=$((end-start))
printf 'runtime = %02dh:%02dm:%02ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))
