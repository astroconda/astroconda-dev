#!/bin/bash

set -e

if [ $ARCH -gt 32 ]; then
    if [[ `uname` == Linux ]]; then
        export LDFLAGS="-L/usr/lib64"
    fi
fi

./configure --prefix=${PREFIX} --enable-krb5
make -j${CPU_COUNT}
make install -k || true
