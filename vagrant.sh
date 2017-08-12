#!/usr/bin/env bash

export DEBIAN_FRONTEND="noninteractive"

apt-get update
apt-get upgrade -y
apt-get install screen vim htop git gnupg zip curl \
 				flex bison gperf build-essential libgl1-mesa-dev libxml2-utils \
 				zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 python unzip wget \
 				x11proto-core-dev libx11-dev lib32z-dev ccache libbz2-dev \
				lib32ncurses5-dev xsltproc -y

cat << EOF >> /home/vagrant/.bashrc
echo "\n\n"
echo To build node for Android please run the following scripts in order:
echo /vagrant/01_download_android_ndk.sh
echo /vagrant/02_clone_node_repo.sh
echo /vagrant/03_build_node_for_android.sh
echo "\nPlease inspect 03_build_node_for_android.sh for more options."
echo "\n\n"

EOF
