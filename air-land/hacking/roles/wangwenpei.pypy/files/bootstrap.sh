#!/usr/bin/env bash

set -e

cd

PYPY_VERSION=$1
PYPY_ARCH=$2
PYPY_BIN_PATH=$3
PYPY_HOME=$4
PYPY_MIRROR=$5
PYPY_WGET_EXTRA=$6
PYPY_BZ2_TMP=$7

test -d $PYPY_HOME || mkdir -p $PYPY_HOME
test -d $PYPY_BZ2_TMP || mkdir -p $PYPY_BZ2_TMP

cd $PYPY_BZ2_TMP && wget $PYPY_WGET_EXTRA $PYPY_MIRROR/pypy$PYPY_VERSION-$PYPY_ARCH.tar.bz2
tar -xjf $7/pypy$PYPY_VERSION-$PYPY_ARCH.tar.bz2

mv -n pypy$PYPY_VERSION-$PYPY_ARCH $PYPY_HOME/

test -d $PYPY_BIN_PATH || mkdir -p $PYPY_BIN_PATH

ln -snf $PYPY_HOME/pypy$PYPY_VERSION-$PYPY_ARCH/bin/pypy  $PYPY_BIN_PATH/python
rm -rf $7/pypy$PYPY_VERSION-$PYPY_ARCH.tar.bz2

chmod +x $PYPY_BIN_PATH/python
$PYPY_BIN_PATH/python --version




