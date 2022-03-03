#!/bin/bash

set -e

DOCKER=docker
function isContainerRunning() {
    [ "`$DOCKER ps -q -f name=$1`" != "" ]
}


if isContainerRunning artifactory; then
	echo "you already have a container named artifactory"
	echo "docker rm -f artifactory"
	echo "docker volume rm artifactory_data"
	exit 1
fi

IMAGE=docker.bintray.io/jfrog/artifactory-oss:6.23.41

docker pull $IMAGE


NET=hive-dev-box-net
docker network create hive-dev-box-net || true
RUN_OPTS+=" --name artifactory"
RUN_OPTS+=" --network $NET"
RUN_OPTS+=" -d --restart always"
RUN_OPTS+=" -v artifactory_data:/var/opt/jfrog/artifactory"
RUN_OPTS+=" -p 127.0.0.1:8081:8081"
docker run $RUN_OPTS $IMAGE

docker cp artifactory_backup.zip artifactory:/tmp/backup.zip
echo "@@@ artifactory should be running"

cat << EOF
===
To load remote repos/etc you will need to run below command after it have started up:

docker exec -it artifactory /bin/bash
curl -X POST -u admin:password -H "Content-type: application/json" http://localhost:8081/artifactory/ui/artifactimport/system \
  -d '{ "path":"/tmp/backup.zip","excludeContent":false,"excludeMetadata":false,"verbose":false,"zip":true,"action":"system"}'

===
EOF

#
#curl -X POST -u admin:password1 -H "Content-type: application/json" -d '{ "userName" : "admin", "oldPassword" : "password1", "newPassword1" : "password", "newPassword2" : "password" }' http://localhost:8081/artifactory/api/security/users/authorization/changePassword
#

