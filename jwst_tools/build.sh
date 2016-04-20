
pip install --no-deps --force --upgrade d2to1

rm -rf jwst_tools/timeconversion

for d in jwst_tools/*
do
    if [[ $d == *spectools* ]]; then
        # Indentation errors in package
        continue
    fi
    ( cd $d && python setup.py install || exit 1 )
done
