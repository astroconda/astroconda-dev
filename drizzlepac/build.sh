
echo This d2to1 hack is deadly.
pip install --no-deps --upgrade --force d2to1 || exit 1
test -f setup.cfg && sed -i -e '/astrolib\.coords.*/d' setup.cfg
python setup.py install || exit 1