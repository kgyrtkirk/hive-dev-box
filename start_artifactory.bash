#!/bin/bash

IMAGE=docker.bintray.io/jfrog/artifactory-oss:6.18.0

docker pull $IMAGE

NET=hive-dev-box-net
docker network create hive-dev-box-net || true
RUN_OPTS+=" --name artifactory"
RUN_OPTS+=" --network $NET"
RUN_OPTS+=" -d --restart always"
RUN_OPTS+=" -v artifactory_data:/var/opt/jfrog/artifactory"
RUN_OPTS+=" -p 127.0.0.1:8081:8081"
docker run $RUN_OPTS $IMAGE
