#!/bin/bash
set -e
. setdevkitpath.sh
cd freetype-$BUILD_FREETYPE_VERSION

echo "Building Freetype"

export PATH=$TOOLCHAIN/bin:$PATH
./configure \
  --host=$TARGET \
  --prefix=${PWD}/build_android-${TARGET_SHORT} \
  --without-zlib \
  --with-brotli=no \
  --with-png=no \
  --with-harfbuzz=no $EXTRA_ARGS \
  || error_code=$?

if [[ "$error_code" -ne 0 ]]; then
  echo "\n\nCONFIGURE ERROR $error_code , config.log:"
  cat ${PWD}/builds/unix/config.log
  exit $error_code
fi

export CFLAGS="-fno-rtti -Xclang "-target-feature" -Xclang "+v8.2a" -Xclang "-target-feature" -Xclang "+crc" -Xclang "-target-feature" -Xclang "+fp-armv8" -Xclang "-target-feature" -Xclang "+lse" -Xclang "-target-feature" -Xclang "+neon" -Xclang "-target-feature" -Xclang "+ras" -Xclang "-target-feature" -Xclang "+rdm" -Xclang "-target-feature" -Xclang "+fix-cortex-a53-835769" -Xclang "-target-feature" -Xclang "+fp" -Xclang "-target-feature" -Xclang "+simd" -Xclang "-target-abi" -Xclang "aapcs" -mcpu=cortex-a78"
export CXXFLAGS="-fno-rtti -Xclang "-target-feature" -Xclang "+v8.2a" -Xclang "-target-feature" -Xclang "+crc" -Xclang "-target-feature" -Xclang "+fp-armv8" -Xclang "-target-feature" -Xclang "+lse" -Xclang "-target-feature" -Xclang "+neon" -Xclang "-target-feature" -Xclang "+ras" -Xclang "-target-feature" -Xclang "+rdm" -Xclang "-target-feature" -Xclang "+fix-cortex-a53-835769" -Xclang "-target-feature" -Xclang "+fp" -Xclang "-target-feature" -Xclang "+simd" -Xclang "-target-abi" -Xclang "aapcs" -mcpu=cortex-a78"
make -j4
make install
