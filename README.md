# scuttlebot on android

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

