FROM debian:buster

COPY tools/build_cleanup /tools/

COPY tools/install_basics /tools/
RUN /tools/install_basics

COPY tools/install_toolbox /tools/
RUN /tools/install_toolbox

COPY tools/i_sort /tools/
RUN /tools/i_sort

COPY etc  /etc
COPY bin  /bin

COPY tools/install_conf /tools/
RUN /tools/install_conf

RUN apt-get install -q -y binutils openjdk-11-jdk-headless
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/

ENV MAVEN_OPTS=-Xmx2g
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV HADOOP_LOG_DIR=/data/log
ENV HADOOP_CLASSPATH=/etc/tez/:/active/tez/lib/*:/active/tez/*:/apps/lib/*
ENV HIVE_CONF_DIR=/etc/hive/

ENV PATH "$PATH:/active/hive/bin:/active/hadoop/bin:/active/eclipse/:/active/maven/bin/:/active/protobuf/bin:/active/visualvm/bin:/active/kubebuilder/bin:/active/idea/bin"

USER dev
WORKDIR /home/dev

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY tools/docker_entrypoint /.entrypoint
ENTRYPOINT ["/.entrypoint"]

