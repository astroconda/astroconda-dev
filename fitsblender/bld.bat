
pip install --no-deps --upgrade --force d2to1
if errorlevel 1 exit 1

python setup.py install
if errorlevel 1 exit 1