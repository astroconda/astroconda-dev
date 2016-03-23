
pip install --no-deps --upgrade --force d2to1
if errorlevel 1 exit 1
pip install --no-deps --upgrade --force astropy_helpers || exit 1
if errorlevel 1 exit 1
python setup.py install --offline
if errorlevel 1 exit 1