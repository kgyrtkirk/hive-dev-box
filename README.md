# hive-dev-box


## getting started

```shell
# build the machine; it will install some version of hadoop+tez+hive combo
vagrant up
# log in to the machine
vagrant ssh
# now that you are in; rebuild metastore schema
reinit_metastore
# launch everything RM/NM/HS2/BL
hive_launch
# exit with CTRL+A CTRL+\ to kill all processes
```



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

## use a development version of Hive

```shell
# make sure to build a dist in hive:
mvn install -Pdist -DskipTests
# build the machine with HIVE_SOURCES set
HIVE_SOURCES=/path/to/my/hive vagrant up
# ..or if you already have the box built; a refresh might also work
HIVE_SOURCES=/path/to/my/hive vagrant refresh
# inside the machine switch to your development
vagrant ssh
sw hive-dev
# if you are switching between versions; don't forget
reinit_metastore
hive_launch
# et voila you have your in-development hive in operation
```

