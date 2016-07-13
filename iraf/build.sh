
set -x

export IRAFARCH=''
export target=`uname`.32
export PLATFORM=
case "$target" in
Linux.32)
export IRAFARCH='linux'
export CFLAGS="-m32"
export LDFLAGS="-m32"
export PLATFORM='linux'
;;
Darwin.32)
export IRAFARCH='macosx'
export CFLAGS="-m32 -arch i386"
export LDFLAGS="-m32 -arch i386"
export PLATFORM='osx'
;;
*)
echo "UNSUPPORTED ARCHITECTURE (64-bit disabled, by the way...)"
exit 1
;;
esac


VARIANTS=http://ssb.stsci.edu/stripped/$PLATFORM/variants.tar.gz
curl -O $VARIANTS
tar xf variants.tar.gz -C $PREFIX
rm -f variants.tar.gz

mkdir -p $PREFIX/bin \
$PREFIX/share/man

for binary in $PREFIX/variants/common/bin/*.e
do
( cd $PREFIX/bin && ln -s -f $binary )
done

X11IRAF=http://ssb.stsci.edu/stripped/$PLATFORM/x11iraf.tar.gz
curl -O $X11IRAF
tar xf x11iraf.tar.gz
rm -f x11iraf.tar.gz

rsync -aH x11iraf/bin/ $PREFIX/bin
rsync -aH x11iraf/man/ $PREFIX/share/man
rm -rf x11iraf

export TERM=xterm
if [[ $PLATFORM == "osx" ]]; then
test -d /sw && export PATH=`purge_path /sw`
fi
export iraf=$PREFIX/iraf/

echo "Fixing c headers..."
find . -type f -name "*.h" | xargs sed -i -e "s|/iraf/iraf/|$iraf|"

echo "Fixing c sources..."
find . -type f -name "*.c" | xargs sed -i -e "s|/iraf/iraf/|$iraf|"

mkdir -p $iraf
rsync -aH `pwd`/ $iraf

cd $iraf

rm -rf bin_directory
rm -rf $iraf/vo/bin.generic/bin.macosx



( cd $PREFIX/bin && \
ln -s -f $iraf/unix/hlib/cl.sh cl && \
ln -s -f $iraf/unix/hlib/mkiraf.sh mkiraf && \
ln -s -f $iraf/unix/hlib/mkmlist.csh mkmlist && \
ln -s -f $iraf/unix/bin.$IRAFARCH/generic.e generic && \
ln -s -f $iraf/unix/bin.$IRAFARCH/mkpkg.e mkpkg && \
ln -s -f $iraf/unix/bin.$IRAFARCH/rmbin.e rmbin && \
ln -s -f $iraf/unix/bin.$IRAFARCH/rmfiles.e rmfiles && \
ln -s -f $iraf/unix/bin.$IRAFARCH/rpp.e rpp && \
ln -s -f $iraf/unix/bin.$IRAFARCH/rtar.e rtar &&\
ln -s -f $iraf/unix/bin.$IRAFARCH/sgidispatch.e sgidispatch && \
ln -s -f $iraf/unix/bin.$IRAFARCH/wtar.e wtar && \
ln -s -f $iraf/unix/bin.$IRAFARCH/xc.e xc && \
ln -s -f $iraf/unix/bin.$IRAFARCH/xpp.e && \
ln -s -f $iraf/unix/bin.$IRAFARCH/xyacc.e xyacc )

UR_BUILTIN=/Users/Shared/ureka.iraf/ur_work/iraf
find . -lname "$UR_BUILTIN/*" \
-exec sh -c 'echo Re-linking builtin paths "$0" ;\
ln -snf "$(readlink "$0" \
| sed -e "s|$UR_BUILTIN|../..|" -e "s|/as/|/as.$IRAFARCH/|")" "$0"' {} \;

find . -lname '/iraf/iraf/*' \
-exec sh -c 'echo Re-linking "$0" ;\
ln -snf "$(readlink "$0" \
| sed -e "s|/iraf/iraf|../..|" -e "s|/as/|/as.$IRAFARCH/|")" "$0"' {} \;


echo "Removing dead symlinks..."
find $iraf $iraf/../variants -type l | xargs -n 1 -I'{}' \
sh -c 'file {} | grep broken | cut -f 1 -d :' | xargs rm -f



mkdir -p $PREFIX/etc/conda/{activate.d,deactivate.d}

echo "
# Workaround for conda >4.1.2
if [[ -n \$CONDA_PREFIX ]]; then
    export CONDA_ENV_PATH=\$CONDA_PREFIX
fi
export IRAFARCH=$IRAFARCH
export iraf=\$CONDA_ENV_PATH/iraf/
export MACH=\$IRAFARCH
export hostid=unix
export host=\$iraf/\$hostid/
export hbin=\$host/bin.\$IRAFARCH/
export IMTOOLRC=\$iraf/dev/imtoolrc
export tmp=/tmp/

export CC=gcc
export F2C=\$hbin/f2c.e
export F77=\$hbin/f77.sh
export RANLIB=ranlib

case "\$IRAFARCH" in
macosx)
export HSI_CF=\"-I\$iraf/include -O -DMACOSX -w -Wunused -arch i386 -m32 -mmacosx-version-min=10.4\"
export HSI_XF=\"-I\$iraf/include -Inolibc -/DMACOSX -w -/Wunused -/m32 -/arch -//i386 -/mmacosx-version-min=10.4\"
export HSI_FF=\"-I\$iraf/include -O -arch i386 -m32 -DBLD_KERNEL -mmacosx-version-min=10.4\"
export HSI_LF=\"-I\$iraf/include -arch i386 -m32 -mmacosx-version-min=10.4\"
;;

linux)
export HSI_CF=\"-I\$iraf/include -O -DLINUX -DREDHAT -DPOSIX -DSYSV -w -m32 -Wunused\"
export HSI_FF=\"-I\$iraf/include -O -DBLD_KERNEL -m32\"
export HSI_LF=\"-I\$iraf/include -m32\"
export HSI_XF=\"-I\$iraf/include -Inolibc -w -/Wunused -/m32\"
;;

*)
echo "Unknown IRAFARCH. This is not supposed to happen."
;;

esac

export HSI_F77LIBS=
export HSI_LIBS=\"\$iraf/unix/hlib/libboot.a \$iraf/lib/libsys.a \$iraf/lib/libvops.a \$iraf/unix/hlib/libos.a\"
export HSI_OSLIBS=

export UR_BITS=64
export UR_CPU=x86_64
export UR_DIR=\$CONDA_ENV_PATH
export UR_VARIANT=common
export UR_OS=$PLATFORM
export UR_TMP=/tmp
export UR_DIR_PKG=\$UR_DIR/variants/\$UR_VARIANT/
" > $PREFIX/etc/conda/activate.d/iraf.sh
chmod 755 $PREFIX/etc/conda/activate.d/iraf.sh

echo '
if [[ -n \$CONDA_PREFIX ]]; then
    unset CONDA_ENV_PATH
fi

unset iraf
unset IRAFARCH
unset IMTOOLRC
unset F2C
unset F77
unset hbin
unset hlib
unset host
unset CC
unset CC_f2c
unset HSI_CF
unset HSI_F77LIBS
unset HSI_FF
unset HSI_LF
unset HSI_LFLAGS
unset HSI_LIBS
unset HSI_OSLIBS
unset HSI_XF
unset MACH
unset OS_MACH
unset RANLIB
unset hostid
unset tmp
unset UR_BITS
unset UR_CPU
unset UR_DIR
unset UR_VARIANT
unset UR_OS
unset UR_TMP
unset UR_DIR_PKG
' > $PREFIX/etc/conda/deactivate.d/iraf.sh
chmod 755 $PREFIX/etc/conda/deactivate.d/iraf.sh

