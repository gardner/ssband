#!/bin/bash

cd ~
# Only download the ndk if the directory doesn't exist
if [ ! -d android-ndk-r15b-linux-x86_64 ]; then
  wget -c "https://dl.google.com/android/repository/android-ndk-r15b-linux-x86_64.zip"

  shasum android-ndk-r15b-linux-x86_64.zip | grep 2690d416e54f88f7fa52d0dcb5f539056a357b3b
  if [ 0 -ne $? ]; then
    echo "checksums don't match"
    exit 1
  fi
  unzip -q android-ndk-r15b-linux-x86_64
fi
