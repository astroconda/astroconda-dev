if [[ `uname` == Darwin ]]; then
    export CC=`which gcc`
fi

./waf configure --prefix=$PREFIX
./waf build
./waf install
