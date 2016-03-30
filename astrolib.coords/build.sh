
test -f README.md && ln -s README.md README.txt
python setup.py install || exit 1