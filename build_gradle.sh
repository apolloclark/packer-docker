#!/bin/bash -eux
start=`date +%s`

./clean_packer_docker.sh

gradle testBaseImages --parallel --rerun-tasks
gradle testChildImages --parallel --rerun-tasks
docker ps
docker images | tail -n +2 | sort

end=`date +%s`
secs=$((end-start))
printf 'runtime = %02dh:%02dm:%02ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))
