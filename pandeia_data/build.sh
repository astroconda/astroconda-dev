
DATADIR="$PREFIX/share/pandeia_data"
mkdir -p $DATADIR
cp -a * $DATADIR || exit 1