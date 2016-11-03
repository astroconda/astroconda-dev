#!/bin/bash

set -e

./configure --prefix=${PREFIX} --enable-krb5
make -j${CPU_COUNT}
make install -k || true
