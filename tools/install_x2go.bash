#!/bin/bash -e

apt-key adv --recv-keys --keyserver keys.gnupg.net E1F958385BFE2B6E
cat > /etc/apt/sources.list.d/x2go.list  << EOF
# X2Go Repository (release builds)
deb http://packages.x2go.org/debian buster extras main
# X2Go Repository (sources of release builds)
deb-src http://packages.x2go.org/debian buster extras main

# X2Go Repository (Saimaa ESR builds)
#deb http://packages.x2go.org/debian buster extras saimaa
# X2Go Repository (sources of Saimaa ESR builds)
#deb-src http://packages.x2go.org/debian buster extras saimaa

# X2Go Repository (nightly builds)
#deb http://packages.x2go.org/debian buster extras heuler
# X2Go Repository (sources of nightly builds)
#deb-src http://packages.x2go.org/debian buster extras heuler
EOF

apt-get update
apt-get install -y x2goserver{,-xsession} xfce4
apt-get upgrade -y
