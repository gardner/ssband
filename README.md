# Building Node for Android
This repo uses a VM to build the node source code. To make use of the automatic
features please install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/docs/installation/) and then from the repo
root simply execute `vagrant up`. You can then build node for Android by
shelling into the VM with `vagrant ssh` and running the included script:
`./build_node_for_android.sh`

The binary is built for Android on a Debian system using the android ndk to cross
compile the code. By inspecting the `./build_node_for_android.sh` we can see one
of the most important steps is to create a toolchain using the node provided
script `android-configure` like so:

    # Download the android ndk
    wget "https://dl.google.com/android/repository/android-ndk-r15b-linux-x86_64.zip"
    unzip android-ndk-r15b-linux-x86_64

    # Get the node repo
    git clone https://github.com/nodejs/node.git && cd node
    git checkout boron || git checkout v6.11.2
    make clean

    # Setup the build environment for cross-compiling
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

    # This script may prompt you to delete an existing directory.
    # Say yes to delete it.
    source android-configure $ANDROID_NDK_HOME

After this toolchain has been created then all the configure and build scripts
from node will use it to build for Android from the Debian VM. The following
configure call will setup the source to build node as a binary for Android.
This is where you w

    ./configure \
    	--dest-cpu=arm \
    	--dest-os=android \
    	--without-snapshot \
    	--without-inspector \
    	--without-intl \
    	--without-dtrace \
    	--without-etw \
    	--without-perfctr \
    	--openssl-no-asm \
      --shared # Leave this option off for an executable binary instead of .so

You can find more options in the official node configure script:
https://github.com/nodejs/node/blob/master/configure

To compile node as a shared library you need to add `--shared` to the above
configure script.

Then you can make the files with:

    make -j4

# scuttlebot on android

## Setting target architecture for npm
Native npm modules require cross-compiling as well. We can instruct npm to target
a specific architecture using `npm config set arch=arm`


You need ADB to push this to your device: http://developer.android.com/sdk/installing/

You need to push the tar file to the device and then unarchive it. This preserves symbolic links. My android only supports tar and not bz2 so I had to decompress the bz2 on my mac, then adb push the tar file, and untar the file from within adb shell.

Download scuttlebot.tar.bz2

    bzip2 -d scuttlebot.tar.bz2
    adb push scuttlebot.tar /data/local/tmp/scuttlebot.tar
    adb shell

Then on the device:

    export HOME=/data/local/tmp
    cd $HOME
    tar xf scuttlebot.tar
    cd scuttlebot
    ./node ./sbot.js server
