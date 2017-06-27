#!/bin/bash
export CPU="arm"
export ABI="armeabi"
export ARCH="arm"
export HOST=$ARCH-linux

export PLATFORM="android-9"

export SYSROOT=$NDK/platforms/$PLATFORM/arch-$ARCH/
export TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64
export CPREFIX=$TOOLCHAIN/bin/arm-linux-androideabi-
export OPTIMIZE_CFLAGS="-marm"

export PREFIX=$PROJECT_JNI/generated/android/$CPU

function buildJNI
{
cd $PROJECT_JNI/..
mkdir -p libs/$ABI
cd $PROJECT_JNI
$NDK/ndk-build || exit 1
mkdir -p $OUT_DIR
cp -r  $PROJECT_JNI_LIBS/$CPU $OUT_DIR
cd $DIR
}

pushd $PROJECT_JNI_EXTERNAL
#make x264
./build_x264.sh ||  exit 1

#make ffmpeg
./build_ffmpeg.sh || exit 1

cp Android.mk $PREFIX/Android.mk
popd

buildJNI || exit 1