# Placeholder for real conda package
pip install --no-deps --upgrade --force sphinx-automodapi

$PYTHON setup.py build_sphinx
$PYTHON setup.py install
