#!/bin/bash


set -e
cat > /tmp/screenrc1 << EOF
screen -t term
screen -t RM   1	spawn_shell_after yarn resourcemanager
screen -t NM   2	spawn_shell_after yarn nodemanager
screen -t HS2  3        spawn_shell_after hs2_debug.bash
EOF

screen -c /tmp/screenrc1
