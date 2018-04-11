%PYTHON% setup.py build build_ext --inplace -- build_sphinx
if errorlevel 1 exit 1

%PYTHON% setup.py install
