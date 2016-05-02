
pip install --no-deps --force --upgrade d2to1
for d in jwst_lib/*
do
    case "$d" in
        # Append deprecated packages here to disable them
        */modeling) continue ;;
        */wcs) continue ;;
        *) echo "Processing package: $d" ;;
    esac
    ( cd $d && python setup.py install || exit 1 )
done
