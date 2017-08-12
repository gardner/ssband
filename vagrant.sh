#!/usr/bin/env bash

export DEBIAN_FRONTEND="noninteractive"

apt-get update && apt-get upgrade && apt-get install screen vim htop wget -y
apt-get install git-core gnupg flex bison gperf build-essential \
zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 python \
lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache libbz2-dev \
libgl1-mesa-dev libxml2-utils xsltproc unzip -y


wget "https://dl.google.com/android/repository/android-ndk-r15b-linux-x86_64.zip"
unzip android-ndk-r15b-linux-x86_64

git clone https://github.com/nodejs/node.git && cd node
git checkout boron || git checkout v6.11.1
make clean

export ANDROID_NDK_NAME=android-ndk-r15b
export ANDROID_NDK_HOME=~/$ANDROID_NDK_NAME/
export TOOLCHAIN=$PWD/android-toolchain
rm -rf $TOOLCHAIN
~/$ANDROID_NDK_NAME/build/tools/make-standalone-toolchain.sh --toolchain=arm-linux-androideabi-4.9 --arch=arm --install-dir=$TOOLCHAIN --platform=android-21
export PATH=$TOOLCHAIN/bin:$PATH
export AR=$TOOLCHAIN/bin/arm-linux-androideabi-ar
export CC=$TOOLCHAIN/bin/arm-linux-androideabi-gcc
export CXX=$TOOLCHAIN/bin/arm-linux-androideabi-g++
export LINK=$TOOLCHAIN/bin/arm-linux-androideabi-g++


source android-configure $ANDROID_NDK_HOME

./configure \
	--dest-cpu=arm \
	--dest-os=android \
	--without-snapshot \
	--without-inspector \
	--without-intl \
	--without-dtrace \
	--without-etw \
	--without-perfctr \
	--openssl-no-asm

