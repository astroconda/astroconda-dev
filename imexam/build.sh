
echo This d2to1 hack is deadly.
pip install --no-deps --upgrade --force d2to1 || exit 1
pip install --no-deps --upgrade --force astropy_helpers || exit 1
sed -i -e 's|find-links|#find-links|g' setup.cfg
sed -i -e 's|auto_use|#auto_use|g' setup.cfg
python setup.py install || exit 1