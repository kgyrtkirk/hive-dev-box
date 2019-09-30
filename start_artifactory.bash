#!/bin/bash

docker run --name artifactory -d --restart always \
        -v artifactory_data:/var/opt/jfrog/ \
        -p 8081:8081 docker.bintray.io/jfrog/artifactory-oss:latest

