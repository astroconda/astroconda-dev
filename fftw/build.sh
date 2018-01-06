set -e
export modes="--enable-single --enable-long-double"
export FFTW_CONFIGURE="./configure --prefix=$PREFIX --disable-static --enable-shared --enable-threads "

function fftw_build
{
    $FFTW_CONFIGURE "$@"
    make -j$CPU_COUNT
    make install
}

fftw_build

for mode in $modes; do fftw_build $mode; done
