
pip install --no-deps --force --upgrade d2to1

rm -rf jwst_tools/timeconversion

for d in jwst_tools/*
do
( cd $d && python setup.py install || exit 1 )
done