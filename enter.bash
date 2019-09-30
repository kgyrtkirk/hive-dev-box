#!/bin/bash -e
[ "$1" == "" ] && echo "usage: $0 <container name>" && exit 1
docker exec -it "$1" /bin/bash -login

