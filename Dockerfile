FROM debian:buster

COPY tools/install_basics.bash /tools/
RUN /tools/install_basics.bash

COPY tools/install_sdk.bash /tools/
RUN /tools/install_sdk.bash

COPY tools/install_hadoop.bash /tools/
RUN /tools/install_hadoop.bash

COPY tools/install_hive.bash /tools/
RUN /tools/install_hive.bash

