rm -rf aclocal.m4 autom4te.cache
libtoolize -f -i
autoreconf -i

./configure --prefix=$PREFIX \
    --disable-static \
    --enable-mkl-gcc \
    --with-mkl-dir=$PREFIX

make -j ${CPU_COUNT} LDFLAGS=-liomp5
make install
