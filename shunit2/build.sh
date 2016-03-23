
mkdir -p $PREFIX/bin \
$PREFIX/share/doc/shunit2
chmod +x src/shell/shunit2
cp -a src/shell/shunit2 $PREFIX/bin
cp doc/* $PREFIX/share/doc/shunit2