FROM debian:buster

COPY tools/install_basics.bash /tools/
RUN /tools/install_basics.bash

COPY tools/install_sdk.bash /tools/
RUN /tools/install_sdk.bash

COPY tools/install_hadoop.bash /tools/
RUN /tools/install_hadoop.bash

COPY tools/install_hive.bash /tools/
RUN /tools/install_hive.bash

COPY tools/install_tez.bash /tools/
RUN /tools/install_tez.bash

COPY tools/install_conf.bash /tools/
RUN /tools/install_conf.bash

COPY conf /etc
COPY bin  /bin

USER dev
WORKDIR /home/dev
