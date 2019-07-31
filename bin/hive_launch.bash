#!/bin/bash


set -e
cat > /tmp/screenrc1 << EOF
screen -t term
screen -t RM   1	yarn resourcemanager
screen -t NM   2	yarn nodemanager
screen -t HS2  3        hs2_debug.bash
EOF

screen -c /tmp/screenrc1
