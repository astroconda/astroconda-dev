
test -f setup.cfg && sed -i -e '/astrolib\.coords.*/d' setup.cfg
$PYTHON setup.py install
