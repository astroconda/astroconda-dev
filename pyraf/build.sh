# XQuartz or no-go
if [[ `uname -s` == "Darwin" ]]; then
    export CFLAGS="-I/opt/X11/include"
    export LDFLAGS="-L/opt/X11/lib"
fi

if [[ $PY3K > 0 ]]; then
set +e
    2to3 -w .
fi

python setup.py install || exit 1
