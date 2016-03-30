
test -f setup.cfg && sed -i -e '/astrolib\.coords.*/d' setup.cfg
python setup.py install || exit 1