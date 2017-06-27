#!/bin/bash
pushd ffmpeg
rm -f $(pwd)/compat/strtod.o

export ADDI_CFLAGS="$OPTIMIZE_CFLAGS -fPIC  -I/x264 -I${PREFIX}/include -L${PREFIX}/lib -DANDROID -I${NDK}/sources/cxx-stl/system/include"
export ADDI_LDFLAGS="-Wl,-z,defs -L${PREFIX}/lib"

function config
{
./configure \
    --prefix=$PREFIX    \
    --enable-shared     \
    --enable-cross-compile     \
    --disable-static     \
    --disable-programs     \
    --disable-doc     \
    --enable-protocol=file     \
    --enable-pic     \
    --enable-small     \
    --cross-prefix=$CPREFIX \
    --target-os=linux   \
    --arch=$ARCH      \
    --disable-postproc        \
    --enable-gpl        \
    --enable-libx264    \
    --sysroot=$SYSROOT  \
    --extra-cflags="$ADDI_CFLAGS" \
    --extra-ldflags="$ADDI_LDFLAGS" \
    $ADDITIONAL_CONFIGURE_FLAG || exit 1

}
config
make clean && make -j${NUMBER_OF_CORES} && make install || exit 1

echo ffmpeg compiled
date "+%F %T"
popd