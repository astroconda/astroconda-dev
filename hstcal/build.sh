if [[ `uname` == Darwin ]]; then
    export CC=`which gcc`
fi

./waf configure --prefix=$PREFIX --release-with-symbols
./waf build
./waf install
