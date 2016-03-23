
export CFLAGS="`pkg-config --cflags fftw3`"
export LDFLAGS="`pkg-config --libs fftw3`"
python setup.py install || exit 1