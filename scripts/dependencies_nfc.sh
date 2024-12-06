#!/bin/bash


sudo apt-get install -y libbluetooth-dev

sudo apt-get install -y bluez

sudo apt-get install  bluez-tools -y

#aarch64-linux-android21-clang++

bluetoothctl

cd ~/Downloads

wget https://dl.google.com/android/repository/android-ndk-r25c-linux.zip

unzip android-ndk-r25c-linux.zip -d ~/android-ndk

export PATH=$PATH:~/android-ndk/android-ndk-r25c/toolchains/llvm/prebuilt/linux-x86_64/bin

aarch64-linux-android21-clang++ --version

adb push main /data/local/tmp/

adb shell chmod +x /data/local/tmp/main

adb shell /data/local/tmp/main

