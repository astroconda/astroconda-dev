case "$(uname)" in
    Darwin)
        export CFLAGS="$CFLAGS -D_POSIX_C_SOURCE=200112L"
    ;;
esac
./configure --prefix=$PREFIX --enable-reentrant
make shared
make install
