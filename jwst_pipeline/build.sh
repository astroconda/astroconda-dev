
pip install --no-deps --force --upgrade d2to1

rm -rf jwst_pipeline/timeconversion

for d in jwst_pipeline/*
do
( cd $d && python setup.py install || exit 1 )
done