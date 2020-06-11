FROM debian:buster

COPY tools/build_cleanup /tool/

COPY tools/install_basics.bash /tools/
RUN /tools/install_basics.bash

COPY tools/install_java_zulu.bash /tools/
RUN /tools/install_java_zulu.bash

COPY tools/install_toolbox.bash /tools/
RUN /tools/install_toolbox.bash

COPY tools/i_sort.bash /tools/
RUN /tools/i_sort.bash

COPY etc  /etc
COPY bin  /bin

COPY tools/install_conf.bash /tools/
RUN /tools/install_conf.bash

USER dev
WORKDIR /home/dev

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY tools/docker_entrypoint /.entrypoint
ENTRYPOINT ["/.entrypoint"]

