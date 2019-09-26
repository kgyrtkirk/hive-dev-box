FROM debian:buster

COPY tools/install_basics.bash /tools/
RUN /tools/install_basics.bash

COPY tools/install_java_zulu.bash /tools/
RUN /tools/install_java_zulu.bash

COPY tools/install_eclipse.bash /tools/
RUN /tools/install_eclipse.bash

COPY tools/clone_references.bash /tools/
RUN /tools/clone_references.bash

#COPY bin/sw /tools/_sw
#RUN /tools/_sw tez
#RUN /tools/_sw hadoop
#RUN /tools/_sw hive

COPY tools/i_sort.bash /tools/
RUN /tools/i_sort.bash

COPY etc  /etc
COPY bin  /bin

COPY tools/install_conf.bash /tools/
RUN /tools/install_conf.bash

USER dev
WORKDIR /home/dev

COPY tools/docker_entrypoint /.entrypoint
ENTRYPOINT ["/.entrypoint"]

