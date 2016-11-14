#!/bin/bash

./configure --prefix=$PREFIX \
    --enable-threads \
    --enable-readline \
    --enable-ltdl-install \
    --enable-drivers \
    --enable-drivers-conf
    
make -j${CPU_COUNT}
make install
