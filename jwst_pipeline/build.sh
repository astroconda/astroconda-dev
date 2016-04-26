
pip install --no-deps --force --upgrade d2to1
for d in jwst_pipeline/*
do
( cd $d && python setup.py install || exit 1 )
done
