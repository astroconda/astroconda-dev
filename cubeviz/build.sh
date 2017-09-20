# Replace malformed pytest requirement with something sane
pytest_pattern='s/pytest==*/pytest>=3.1.0/'
for f in setup.*
do
    sed -e ${pytest_pattern} "${f}" > "${f}.new"
    mv "${f}.new" "${f}"
done

$PYTHON setup.py install
