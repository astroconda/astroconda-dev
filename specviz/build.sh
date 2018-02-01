sed 's|specutils==0.2.2|specutils|' < setup.cfg > setup.cfg.new
cp setup.cfg.new setup.cfg

$PYTHON setup.py install
