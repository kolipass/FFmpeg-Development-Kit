#!/bin/bash
export CPU=x86_64
export ABI=x86_64
export CPU=x86_64
export ARCH=x86_64
export HOST=$ARCH-linux

export PLATFORM="android-21"

export SYSROOT=$NDK/platforms/$PLATFORM/arch-$ARCH/
export TOOLCHAIN=$NDK/toolchains/$ARCH-4.9/prebuilt/linux-x86_64
export CPREFIX=$TOOLCHAIN/bin/$ARCH-linux-android-
export OPTIMIZE_CFLAGS="-fomit-frame-pointer"

export PREFIX=$PROJECT_JNI/generated/android/$CPU

function buildJNI
{

cd $PROJECT_JNI/..
mkdir -p libs/$CPU
cd $PROJECT_JNI
$NDK/ndk-build
mkdir -p $OUT_DIR
cp -r $PROJECT_JNI_LIBS/$ARCH $OUT_DIR/$CPU
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