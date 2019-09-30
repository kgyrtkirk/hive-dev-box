# hive-dev-box

## why?

To make some easily accessible environment to run and develop Hive.

### Testability aspect

There are sometimes bugreports agains earlier releases; but testing these out sometimes is problematic - running/switching between versions is kinda problematic. I was using some vagrant based box which was usefull doing this...

### patch development processes

I'm working on Hive and sometimes on other projects in the last couple years - and since QA runs may come after 8-12 hours; I work on multiple patches simultaneously.
However; working on several patches simultaniously has its own problems:

I go thru all the approaches I was using ealier:

* basic approach: use a single workspace - and switch the branch...
    * unquestionably this is the most simple
    * after switching the branch - a full rebuild is neccessary
* 1 for each: use multiple copies of hive - with have isolated maven caches
    * pro:
        * capability to run maven commands simultaneuously on multiple patches
    * con:
        * one of the patches have to be "active" to make an IDE able to use it
        * it falls short when it comes to working on patch simultaneous in multiple projects (hive+tez+hadoop)
        * after some time it eats up space...
* dockerized/virtualized development environment
    * pro:
        * everything is isolated
        * because I'm not anymore bound to my natural environment: I may change a lot of things without interfering with anything else
        * easier to "cleanup" at the end of submitting the patch (just delete the container)
        * ability to have IDEs running for multiple patches at the same time
    * con:
        * isolated environment; configuration changes might get lost
        * may waste disk space...

## What's the goal of this?

The aim of this project is to provide an easier way to test-drive hive releases

* running releases:
    * upstream apache releases
    * HDP/CDP/CDH releases
    * in-development builds
* provide an evironment for developing hive patches

## Getting started - with running off shelf releases

```shell
# build and launch the hive-dev-box container
./run.bash 
# after building the container you will get a prompt inside it
# initialize the metastore with
reinit_metastore
# everything should be ready to launch hive
hive_launch
# exit with CTRL+A CTRL+\ to kill all processes
```

## Getting started - with patch development

### make X11 forwarding work (once)

* on linux based systems you are already running an xserver
* MacOSX users should follow: https://medium.com/@mreichelt/how-to-show-x11-windows-within-docker-on-mac-50759f4b65cb

### artifactory cache (once)

Every container will be reaching out to almost the same artifacts; so employing an artifact cache "makes sense" in this case :D

```shell
# start artifactory instance
./start_artifactory.bash
```

You will have to manually configure this instance (once)

it will be available at https://127.0.0.1:8081/
use admin/password to login

* enable security / unauthorized connections
* add some remote repositories like maven central or a caching mirror site if you know one
* add a virtual repository named "wonder"  and add the remotes to it

This instance will be linked to the running development environment automatically

### set properties (once)(optional)

add an export to your .bashrc or similar; like:

```shell
export HIVE_DEV_BOX_HOST_DIR=$HOME/hive-dev-box
export GITHUB_USER=kgyrtkirk
```

The dev environment will assume that you are working on upstream patches; and will always open a new branch forked from master
If you skip this; things may not work - you will be left to do these things; in case you are using HIVE_SOURCES env variable you might not need to set it anyway.

```shell
# make sure to load the new env variables for bash
. .bashrc
# and also create the host dir beforehand
mkdir $HIVE_DEV_BOX_HOST_DIR
```

### launch - with sources stored inside container

```shell
# invoking with an argument names the container and will also be the preffered name for the ws and the development branch
./run.bash HIVE-12121-asd
# when the terminal comes up
# issuing the following command will
#   * either creates or checks out the `hostname` named branch
#   * builds hive
#   * builds an eclipse workspace for it
hive_patch_development
# open eclipse
dev_eclipse
```

## filesystem layout

beyond the "obvious" `/bin` and `/lib` folders there are some which might make it more clear how this works:

* `/work`
    * used to store downloaded and expanded artifacts
    * if you switch to say apache hive 3.1.1 and then to some other version you shouldn't need to wait for the download and expansion of it..
    * this is mounted as a docker volume; and shared between the containers
    * files under `/work` are not changed
* `/active`
    * the `/work` folder may contain a number versions of the same component
    * symbolic links point to actually used versions
    * at any point doing an `ls -l /active` gives a brief overview about the active components
* `/home/dev`
    * this is the development home
* `/home/dev/hive`
    * the Hive sources; in case `HIVE_SOURCES` is set at launch time; this folder will be mapped to that directory on the host
* `/home/dev/host`
    * this is a directory shared with the host; can be used to exchange files (something.patch)
    * will also contain the workspace "template"
    * `bin` directory under this folder will be linked as `/home/dev/bin` so that scripts can be shared between containers and the host

## sw - switch between versions of things

```shell
# use hadoop 3.1.0
sw hadoop 3.1.0
# use hive 2.3.5
sw hive 2.3.5
# use tez 0.8.4
sw tez 0.8.4
```

## reinit_metastore [type]

* optionally switch to a different metastore implementation
* wipe it clean
* populate schema and load sysdb

```
reinit_metastore [derby|postgres|mysql]
```
