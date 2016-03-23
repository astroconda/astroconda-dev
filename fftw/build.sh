
export modes="--enable-single --enable-long-double"
export FFTW_CONFIGURE="./configure --prefix=$PREFIX --disable-static --enable-shared --enable-threads "

function fftw_build
{
$FFTW_CONFIGURE "$@" || exit 1
make -j$CPU_COUNT || exit 1
make install || exit 1
}

fftw_build

for mode in $modes; do fftw_build $mode; done