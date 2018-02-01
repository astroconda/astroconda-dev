sed 's|specutils==0.2.2|specutils|' < setup.cfg > setup.cfg.new
cp setup.cfg.new setup.cfg

# Remove reference to glueviz from setup script, since this breaks the build
# as there is no file containing 'glueviz' produced for that package since
# glueviz has become a metapackage.
sed -i -e "/'glueviz.*',$/d" setup.py
$PYTHON setup.py install
