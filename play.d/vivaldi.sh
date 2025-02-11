#!/bin/sh

DESCRIPTION="Vivaldi browser from the official site"

BRANCH=stable
if [ "$2" = "snapshot" ] || epm installed vivaldi-snapshot ; then
    BRANCH=snapshot
fi
PKGNAME=vivaldi-$BRANCH

. $(dirname $0)/common.sh


arch="$($DISTRVENDOR --debian-arch)"
case "$arch" in
    amd64|aarch64|i386|armhf)
        ;;
    *)
        fatal "Debian $arch arch is not supported"
        ;;
esac

# See also https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=vivaldi

# TODO:
# https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=vivaldi-ffmpeg-codecs

# https://repo.vivaldi.com/archive/rpm/x86_64/

# epm uses eget to download * names
#epm install "https://repo.vivaldi.com/archive/deb/pool/main/$(epm print constructname $PKGNAME "*" $arch deb)"

PKGURL="$(epm tool eget --list --latest https://vivaldi.com/ru/download "$(epm print constructname $PKGNAME "*" $arch deb)")" || fatal
epm install $PKGURL || fatal

epm play vivaldi-codecs-ffmpeg-extra $BRANCH
