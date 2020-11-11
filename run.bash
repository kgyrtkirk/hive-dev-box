#!/bin/bash
set -e

if [ "$1" == "-d" ];then
    RUN_OPTS+=" -d"
    shift
else
    RUN_OPTS+=" -it"
fi

if [ "$1" != "" ];then
    RUN_OPTS+=" --name $1 --hostname $1"
    shift
fi

RUN_OPTS+=" -v hive-dev-box_work:/work"
RUN_OPTS+=" -v `pwd`:/hive-dev-box"
if [ "$TOOLBOX_SOURCES" != "" ];then
	RUN_OPTS+=" -v $TOOLBOX_SOURCES:/toolbox"
fi

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

if [ "$SSH_AUTH_SOCK" != "" ];then
    echo " * enabling SSH_AUTH_SOCK"
    RUN_OPTS+=" -v $(dirname $SSH_AUTH_SOCK):$(dirname $SSH_AUTH_SOCK) -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK"
fi

RUN_OPTS+=" -v `pwd`/settings.xml:/home/dev/.m2/settings.xml"
RUN_OPTS+=" -v $HOME/.ssh:/home/dev/.ssh"
RUN_OPTS+=" -v $HOME/.gitconfig:/home/dev/.gitconfig"
RUN_OPTS+=" -e TERM=$TERM"

[ "$HIVE_DEV_BOX_HOST_DIR" != "" ] && RUN_OPTS+=" -v $HIVE_DEV_BOX_HOST_DIR:/home/dev/host"
[ "$HIVE_SOURCES" != "" ] && RUN_OPTS+=" -v $HIVE_SOURCES:/home/dev/hive"
[ -e "$HOME/.config/asf_toolbox.yml" ] && RUN_OPTS+=" -v $HOME/.config/asf_toolbox.yml:/home/dev/.config/asf_toolbox.yml"
[ -e "$HOME/.config/srcs.dsl" ] && RUN_OPTS+=" -v $HOME/.config/srcs.dsl:/home/dev/.config/srcs.dsl"
[ -e /var/run/docker.sock ] && RUN_OPTS+=" -v /var/run/docker.sock:/var/run/docker.sock"

# link artifactory
[ "`docker ps -q -f name=artifactory`" != "" ] && RUN_OPTS+=" --link artifactory:artifactory "

NET=hive-dev-box-net
RUN_OPTS+=" --network $NET"
#RUN_OPTS+=" --shm-size 2g"
#RUN_OPTS+=" --security-opt seccomp=unconfined"
RUN_OPTS+=" --security-opt seccomp=seccomp.json"

BUILD_OPTS+=" -t hive-dev-box"
BUILD_OPTS+=" -t hive-dev-box:`date +%s`"

#docker pull debian:buster
docker build $BUILD_OPTS .
docker network create $NET || true
docker run          \
    $RUN_OPTS       \
    "$@"            \
    hive-dev-box    \
    /bin/bash

