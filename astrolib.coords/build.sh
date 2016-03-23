
pip install --no-deps --upgrade --force d2to1 || exit 1
test -f README.md && ln -s README.md README.txt
python setup.py install || exit 1