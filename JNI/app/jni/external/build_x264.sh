#!/bin/bash
PATH="$PATH:$TOOLCHAIN/bin"

pushd x264

echo $TOOLCHAIN
echo $PREFIX
echo $SYSROOT

function config {
./configure \
    --prefix=$PREFIX \
    --bindir=$NDK/sources/bin \
    --enable-static \
    --host=$HOST \
    --enable-pic \
    --sysroot=$SYSROOT \
    --cross-prefix=$CPREFIX \
    --enable-shared \
    --extra-cflags="-Os -fpic $ADDI_CFLAGS" \
    --extra-ldflags="$OPTIMIZE_CFLAGS" \
    $ADDITIONAL_CONFIGURE_FLAG || exit 1
}
config
make clean && make -j${NUMBER_OF_CORES} && make install || exit 1

popd