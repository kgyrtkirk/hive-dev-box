#!/bin/bash

# FIXME: partially duplicated from sokol

set -e

apt-get install -y zip unzip 
export SDKMAN_DIR="/usr/local/sdkman"

curl -s "https://get.sdkman.io" | bash
source "$SDKMAN_DIR/bin/sdkman-init.sh"

#sdk install java 7.0.222-zulu
#sdk install java 8.0.222-zulu
sdk install java 11.0.7-open
#sdk install maven 3.6.1

cat > /etc/bashrc.d << EOF

export SDKMAN_DIR="/usr/local/sdkman"
#source "$HOME/.sdkman/bin/sdkman-init.sh"
source "$SDKMAN_DIR/bin/sdkman-init.sh"

function sw_j7() {
        sdk use java 7.0.222-zulu
}

function sw_j8() {
        sdk use java 8.0.212-zulu
}

EOF
