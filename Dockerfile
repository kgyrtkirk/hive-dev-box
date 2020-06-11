FROM debian:buster

COPY tools/build_cleanup /tools/

COPY tools/install_basics /tools/
RUN /tools/install_basics

COPY tools/install_java_zulu /tools/
RUN /tools/install_java_zulu

COPY tools/install_toolbox /tools/
RUN /tools/install_toolbox

COPY tools/i_sort /tools/
RUN /tools/i_sort

COPY etc  /etc
COPY bin  /bin

COPY tools/install_conf /tools/
RUN /tools/install_conf

USER dev
WORKDIR /home/dev

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY tools/docker_entrypoint /.entrypoint
ENTRYPOINT ["/.entrypoint"]

