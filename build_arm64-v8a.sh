#!/bin/bash
export CPU="arm64-v8a"
export ABI="arm64-v8a"
export ARCH="arm64"
export HOST="aarch64-linux"

export PLATFORM="android-21"

export SYSROOT=$NDK/platforms/$PLATFORM/arch-$ARCH/
export TOOLCHAIN=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64
export CPREFIX=$TOOLCHAIN/bin/$HOST-android-
export OPTIMIZE_CFLAGS=

export PREFIX=$PROJECT_JNI/generated/android/$CPU

function buildJNI
{
cd $PROJECT_JNI/..
mkdir -p libs/$ABI
cd $PROJECT_JNI
$NDK/ndk-build
mkdir -p $OUT_DIR
cp -r $PROJECT_JNI_LIBS/$CPU $OUT_DIR/$CPU
cd $DIR
}

pushd $PROJECT_JNI_EXTERNAL
#make x264
./build_x264.sh || exit 1

#make ffmpeg
./build_ffmpeg.sh || exit 1

cp Android.mk $PREFIX/Android.mk
popd

buildJNI || exit 1