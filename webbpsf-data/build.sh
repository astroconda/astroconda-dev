
mkdir -p $PREFIX/share
mkdir -p $PREFIX/etc/conda/activate.d
mkdir -p $PREFIX/etc/conda/deactivate.d
cp -a `pwd` $PREFIX/share/webbpsf-data

echo "
export WEBBPSF_PATH=$PREFIX/share/webbpsf-data
" > $PREFIX/etc/conda/activate.d/webbpsf-data.sh

echo "
unset WEBBPSF_PATH
" > $PREFIX/etc/conda/deactivate.d/webbpsf-data.sh