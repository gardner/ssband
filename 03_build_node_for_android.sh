#!/bin/bash

cd ~/node
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

make -j4
