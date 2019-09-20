#!/bin/bash -e

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9
apt-get install -y software-properties-common
apt-add-repository 'deb http://repos.azulsystems.com/debian stable main'
apt-get update
apt-get install -y zulu-8
