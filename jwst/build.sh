case `uname` in
    Darwin)
    export LDFLAGS="${LDFLAGS} -headerpad_max_install_names"
    ;;
    Linux)
    export CFLAGS="${CFLAGS} -Wl,-headerpad_max_install_names"
    ;;
    *)
    ;;
esac

$PYTHON setup.py install
