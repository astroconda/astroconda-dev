
ATLAS=/usr
LIBDIR=lib
case $(uname) in
Linux)
if [[ $(uname -m) == *x86_64* ]]; then
LIBDIR=lib64/atlas
else
LIBDIR=lib/atlas
fi
;;
Darwin)
ATLAS=/usr/local/atlas
;;
*)
;;
esac

./configure --prefix=$PREFIX \
--with-fftw-libdir=$PREFIX/lib \
--with-fftw-incdir=$PREFIX/include \
--with-atlas-libdir="$ATLAS/$LIBDIR" \
--with-atlas-incdir="$ATLAS/include"

make -j ${CPU_COUNT}
make install