# Remove astropy version pinning (i.e, handled by recipe)
sed -e "s/'astropy[\!=<>].*,$/'astropy',/" setup.py > setup.py.new
mv setup.py.new setup.py

$PYTHON setup.py install
