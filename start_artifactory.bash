#!/bin/bash

NET=hive-dev-box-net
docker network create hive-dev-box-net || true
RUN_OPTS+=" --name artifactory"
RUN_OPTS+=" --network $NET"
RUN_OPTS+=" -d --restart always"
RUN_OPTS+=" -v artifactory_data:/var/opt/jfrog/"
RUN_OPTS+=" -p 8081:8081"
docker run $RUN_OPTS docker.bintray.io/jfrog/artifactory-oss:latest

