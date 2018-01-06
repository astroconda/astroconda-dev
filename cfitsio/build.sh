case "$(uname)" in
    Darwin)
        export CFLAGS="$CFLAGS -D_POSIX_C_SOURCE=200112L"
        ;;
esac
./configure --prefix=$PREFIX --disable-static --enable-reentrant
make -j $CPU_COUNT shared
make install
