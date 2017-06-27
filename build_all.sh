#!/bin/bash
export DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT="$(dirname "${DIR}")"
export NDK=$HOME/Android/Sdk/ndk-bundle
export NDK_MODULE_PATH=$DIR
export PATH="$PATH:$NDK"

export LIBS=$DIR/libs
export PROJECT_JNI=$DIR/JNI/app/jni
export PROJECT_JNI_EXTERNAL=$DIR/JNI/app/jni/external
export PROJECT_JNI_LIBS=$DIR/JNI/app/libs
export OUT_DIR=$DIR/out

export NUMBER_OF_CORES=$(nproc)

echo $LIBS

if [ "$NDK" = "" ] || [ ! -d $NDK ]; then
    echo "NDK variable not set or path to NDK is invalid, exiting..."
    exit 1
fi

#./build_armeabi.sh || exit 1
./build_armeabi-v7a.sh || exit 1
./build_arm64-v8a.sh || exit 1
./build_x86.sh || exit 1
./build_x86_64.sh || exit 1
#./build_mips.sh || exit 1