#!/bin/bash

# Force regeneration of this since we patched out
# the usage of `DBVERSION_80` in src/_mssql.pyx
test -f _mssql.c && rm _mssql.c
$PYTHON setup.py build_ext -I ${PREFIX}/include -L ${PREFIX}/lib
$PYTHON setup.py install --single-version-externally-managed --record=record.txt
