#!/bin/bash

docker run --name artifactory -d --restart always \
        -v artifactory_data:/var/opt/jfrog/artifactory     \
	-v `pwd`/conf/artifactory.config.latest.xml:/var/opt/jfrog/artifactory/etc/artifactory.config.latest.xml \
        -p 8081:8081 docker.bintray.io/jfrog/artifactory-oss:latest

