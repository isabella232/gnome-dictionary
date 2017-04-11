#!/bin/sh
test -n "$srcdir" || srcdir=$1
test -n "$srcdir" || srcdir=.

cd $srcdir

PROJECT=gnome-dictionary
VERSION=$(git describe --abbrev=0)
NAME="${PROJECT}-${VERSION}"

echo "Creating git tree archive…"
git archive --prefix="${NAME}/" --format=tar HEAD > ${NAME}.tar

rm -f "${NAME}.tar"

echo "Compressing archive…"
xz -f "${NAME}.tar"
