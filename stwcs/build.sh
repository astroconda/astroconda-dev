
function get_py_version() {
python --version 2>&1| awk '{sub(/-.*/,"",$2);print $2}'
}
export -f get_py_version

function set_py3k() {
version=`get_py_version`
major=`echo $version | cut -d '.' -f 1`
minor=`echo $version | cut -d '.' -f 2`
hotfix=`echo $version | cut -d '.' -f 3`
if (( major > 2 )); then
export PY3K=1
else
export PY3K=0
fi
}
export -f set_py3k

set_py3k



sed -i -e "s|use_2to3=True|use_2to3=False|" setup.py
if [ $PY3K -ne 0 ] ; then
fi

python setup.py install || exit 1