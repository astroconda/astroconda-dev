autoreconf -i
./configure --prefix=$PREFIX \
    --disable-static \
    --enable-mkl-gcc \
    --with-mkl-dir=$PREFIX

make -j ${CPU_COUNT}
make install
