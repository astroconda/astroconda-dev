# Replace malformed pytest requirement with something sane
sed -i .bad -e 's/pytest==*/pytest>=3.1.0/' setup.py setup.cfg
$PYTHON setup.py install
