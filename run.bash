#!/bin/bash
set -e
if [ "$GITHUB_USER" != "" ];then
	RUN_OPTS+=" -e GITHUB_USER=$GITHUB_USER"
	BUILD_OPTS+=" --build-arg GITHUB_USER=$GITHUB_USER"
else
	echo " * warning: you should set GITHUB_USER to your github account"
fi

docker build $BUILD_OPTS -t hive-dev-box .

if [ "$1" == "-d" ];then
    #RUN_OPTS+=" --restart always"
    RUN_OPTS+=" -d"
    shift
else
    RUN_OPTS+=" -it"
fi

if [ "$1" != "" ];then
    RUN_OPTS+=" --name $1 --hostname $1"
    shift
fi

#RUN_OPTS+=" --name hdb "
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
        RUN_OPTS+=" -e DISPLAY -v $DISPLAY:$DISPLAY"
    else
        XSOCK=/tmp/.X11-unix
        XAUTH=/tmp/.docker.xauth
        touch $XAUTH
        xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
        RUN_OPTS+=" -e DISPLAY -e XAUTHORITY=$XAUTH -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH"
    fi
fi

# FIXME: do this right..
RUN_OPTS+=" -v `pwd`/settings.xml:/home/dev/.m2/settings.xml"
RUN_OPTS+=" -v $HOME/.ssh:/home/dev/.ssh"
RUN_OPTS+=" -v $HOME/.gitconfig:/home/dev/.gitconfig"
RUN_OPTS+=" -e TERM=$TERM"

[ "$HIVE_DEV_BOX_HOST_DIR" != "" ] && RUN_OPTS+=" -v $HIVE_DEV_BOX_HOST_DIR:/home/dev/host"

# link artifactory
[ "`docker ps -q -f name=artifactory`" != "" ] && RUN_OPTS+=" --link artifactory:artifactory "

docker run          \
    $RUN_OPTS       \
    "$@"            \
    hive-dev-box    \
    /bin/bash

