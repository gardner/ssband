## Android NDK

leveldown is 64bit
chloride needs to work with ndk 



		export TOOLCHAIN=$PWD/android-toolchain
		mkdir -p $TOOLCHAIN
		~/android-ndk-r11c/build/tools/make-standalone-toolchain.sh \
		    --toolchain=arm-linux-androideabi-4.9 \
		    --arch=arm \
		    --install-dir=$TOOLCHAIN \
		    --platform=android-21
		export PATH=$TOOLCHAIN/bin:$PATH
		export AR=$TOOLCHAIN/bin/arm-linux-androideabi-ar
		export CC=$TOOLCHAIN/bin/arm-linux-androideabi-gcc
		export CXX=$TOOLCHAIN/bin/arm-linux-androideabi-g++
		export LINK=$TOOLCHAIN/bin/arm-linux-androideabi-g++
		
		export TARGET_OS=OS_ANDROID_CROSSCOMPILE

		# npm install --arch=arm --dest-os=android
		# --dest-os=android
		
		npm install leveldown-mobile --arch=arm --dest-os=android



npm --save install leveldown-mobile --node_win_onecore=0 --arch=arm --dest-os=android android


# Dependencies

## libsodium

    # check out libsodium
    git clone https://github.com/  jedisct1/libsodium.git
    


# This only works on linux. I used Ubuntu 15.

install node + npm 
nvm install v5

download android sdk
download android ndk
apt-get install build-essential libssl-dev libtool -y

clone the node repo
cd node

# This adds buildable support for PIE executables. Try building tag v4.2.3 if you want ELF.
git checkout 271201fea935cdf85336736e87c06104ce185f61
./android-configure ~/android-ndk-r11c/


# On Android /data/local/tmp/ is the only place that you can write to and set executable permissions on files

adb push scuttlebot /data/local/tmp/scuttlebot
adb push node /data/local/tmp/node
adb shell
	cd /data/local/tmp/scuttlebot
	export HOME=/data/local/tmp 
	../node ./sbot.js   
	../node ./bin.js   

# At this point is was not creating a manifest so I copied mine over from my dev machine 

adb push ~/.ssb/manifest.json /data/local/tmp/.ssb/manifest.json

# Even after updating bin.js to use ../node as the binary, we're still getting:

shell@shamu:/data/local/tmp/scuttlebot $ ./bin.js server                       
error loading sodium bindings: Cannot find module 'chloridedown/build/Release/sodium'
falling back to javascript version.
Error: Could not connect to the scuttlebot server.
Use the "server" command to start it.

