#!/bin/bash
export CPU=mips
export ABI=mips
export CPU=mips
export ARCH=mips
export HOST=mipsel-linux

export PLATFORM="android-9"

export SYSROOT=$NDK/platforms/$PLATFORM/arch-$ARCH/
export TOOLCHAIN=$NDK/toolchains/$HOST-android-4.9/prebuilt/linux-x86_64
export CPREFIX=$TOOLCHAIN/bin/$HOST-android-
export ADDITIONAL_CONFIGURE_FLAG="--disable-asm"
#export OPTIMIZE_CFLAGS="-std=c99 -O3 -Wall -pipe -fpic -fasm \
#-ftree-vectorize -ffunction-sections -funwind-tables -fomit-frame-pointer -funswitch-loops \
#-finline-limit=300 -finline-functions -fpredictive-commoning -fgcse-after-reload -fipa-cp-clone \
#-Wno-psabi -Wa,--noexecstack"

export PREFIX=$PROJECT_JNI/generated/android/$CPU

function buildJNI
{

cd $PROJECT_JNI/..
mkdir -p libs/$CPU
cd $PROJECT_JNI
$NDK/ndk-build
cp -r "$PROJECT_JNI_LIBS/$ARCH" "$OUT_DIR"
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