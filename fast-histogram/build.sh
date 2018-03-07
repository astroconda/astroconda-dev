# conda-build does not guarantee LANG will be defined.
# This avoids a UnicodeDecodeError while ingesting README.rst during setup
export LANG=UTF-8

$PYTHON setup.py install
