#!/bin/bash

# this script compiles the libraries and bluetooth modules to be able to use aptX and LDAC codecs via bluetooth
# on debian buster (10)

####
# 
# Based on the great projects of EHfive (https://github.com/EHfive):
# https://github.com/EHfive/pulseaudio-modules-bt
# https://github.com/EHfive/ldacBT
#
####



# install preqisites on normal debian buster (10) install

sudo apt install bluez-hcidump pkg-config cmake fdkaac libtool libpulse-dev libdbus-1-dev libsbc-dev libbluetooth-dev git

temp_compile_dir=$(mktemp -d)

cd "$temp_compile_dir"


# compile libldac
git clone https://github.com/EHfive/ldacBT.git
cd ldacBT/
git submodule update --init
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DINSTALL_LIBDIR=/usr/lib -DLDAC_SOFT_FLOAT=OFF ../
cd ..
sudo make DESTDIR=$DEST_DIR install

# backup original libraries
MODDIR=`pkg-config --variable=modlibexecdir libpulse`

sudo find $MODDIR -regex ".*\(bluez5\|bluetooth\).*\.so" -exec cp {} {}.bak \;



# compile pulseaudio-modules-bt
cd "$temp_compile_dir"

git clone https://github.com/EHfive/pulseaudio-modules-bt.git
cd pulseaudio-modules-bt
git submodule update --init
git -C pa/ checkout v`pkg-config libpulse --modversion|sed 's/[^0-9.]*\([0-9.]*\).*/\1/'`
mkdir build
cd build
cmake ..
make
sudo make install



# configure pulseaudio to use LDAC in high quality
read -p "Do you want to force using LDAC-codec in high quality? y/n [n] " answer
if [ "$answer" = "y" ]
then 
    sudo sed -i.bak 's/^load-module module-bluetooth-discover$/load-module module-bluetooth-discover a2dp_config="ldac_eqmid=hq ldac_fmt=f32"/g' /etc/pulse/default.pa
fi
 


# restart pulseaudio and bluetooth service
pulseaudio -k

sudo systemctl restart bluetooth.service



# User messages and infos
echo ''
echo '#################################'
echo '#################################'
echo -E "To test which codec is used for your device, disconnect your device, start this command: sudo hcidump | grep -A 10 -B 10 'Set config', then reconnect your device."
echo -E "Check the line with 'Media Codec - non-A2DP (xyz)' below 'Set config'"
echo -E "To configure the codec manually check the options for /etc/pulse/default.pa here: https://github.com/EHfive/pulseaudio-modules-bt#configure"


sudo rm -R "$temp_compile_dir"
