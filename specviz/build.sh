sed -e 's|specutils==0.2.2|specutils|' \
    -e 's|pyqt5||' < setup.cfg > setup.cfg.new
cp -a setup.cfg.new setup.cfg

$PYTHON setup.py install
