#!/bin/sh

PKGNAME=Autodesk_EAGLE
DESCRIPTION="EAGLE (EDA software) from the official site"

. $(dirname $0)/common.sh


[ "$($DISTRVENDOR -a)" != "x86_64" ] && echo "Only x86_64 is supported" && exit 1

VERSION=9.6.2
IPFSHASH=Qmd38jJnTnUMUeJuKSDBGesqXF3SxEahUVZc6NUPyMKgj1
PKGURL="https://trial2.autodesk.com/NET17SWDLD/2017/EGLPRM/ESD/Autodesk_EAGLE_${VERSION}_English_Linux_64bit.tar.gz"

PKGDIR="$(mktemp -d)"
cd $PKGDIR || fatal
if ! epm tool eget $PKGURL ; then
    echo "It is possible you are blocked from USA, trying get from IPFS ..."
    pkgname=$(basename $PKGURL)
    epm tool eget -O $pkgname http://dhash.ru/ipfs/$IPFSHASH || fatal "Can't get $pkgname from IPFS."
fi

epm install --repack *.tar.gz
RES=$?

rm -rfv $PKGDIR

echo
echo "
Run via
$ eagle
"
