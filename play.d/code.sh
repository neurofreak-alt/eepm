#!/bin/sh

PKGNAME=code
DESCRIPTION="Visual Studio Code from the official site"
TIPS="Run epm play code <version> to install specific version."

. $(dirname $0)/common.sh

VERSION="$2"

arch="$($DISTRVENDOR -a)"
case "$arch" in
    x86_64)
        arch=x64
        ;;
    armhf)
        ;;
    aarch64)
        arch=arm64
        ;;
    *)
        fatal "$arch arch is not supported"
        ;;
esac


pkgtype="$($DISTRVENDOR -p)"

# we have workaround for their postinstall script, so always repack rpm package
[ "$pkgtype" = "deb" ] || repack='--repack'

if [ -n "$VERSION" ] ; then
    URL="https://update.code.visualstudio.com/$VERSION/linux-$pkgtype-$arch/stable"
else
    URL="https://code.visualstudio.com/sha/download?build=stable&os=linux-$pkgtype-$arch"
fi

epm install $repack "$URL"
