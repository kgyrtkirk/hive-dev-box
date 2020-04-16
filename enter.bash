#!/bin/bash -e
[ "$1" == "" ] && echo "usage: $0 <container name>" && exit 1

DOCKER=docker
function isContainerRunning() {
    [ "`$DOCKER ps -q -f name=$1`" != "" ]
}

# FIXME: make this cleaner
if [ "$DISPLAY" != "" ];then
    echo " * enabling X forward..."
    if [ "`which sw_vers`" != "" ] ; then
        # MacOSX assumed
        xhost + 127.0.0.1
        RUN_OPTS+=" -e DISPLAY=host.docker.internal:0"
    else
        XSOCK=/tmp/.X11-unix
        XAUTH=/tmp/.docker.xauth
        touch $XAUTH
        xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
        RUN_OPTS+=" -e DISPLAY -e XAUTHORITY=$XAUTH -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH"
    fi
fi

isContainerRunning "$1" || docker start "$1"

docker exec -it "$1" /bin/bash -login

