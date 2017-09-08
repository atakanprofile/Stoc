#!/bin/bash

P_DIR=$(pwd)
DIST_DIR=dist

#clean
rm -rf dist

mkdir -p $DIST_DIR/$BUILD_DIR
cd $DIST_DIR/$BUILD_DIR

#build
$QTDIR/bin/qmake -spec linux-g++ "CONFIG+=release" $P_DIR/Stacer.pro && make -j $(nproc)

cd $P_DIR/$DIST_DIR/stacer-core && make -j $(nproc)
cd $P_DIR/$DIST_DIR/stacer && make -j $(nproc)

mkdir $P_DIR/$DIST_DIR/stacer/lib

cp $P_DIR/$DIST_DIR/stacer-core/libstacer-core.so.1.0.0 $P_DIR/$DIST_DIR/stacer/lib/libstacer-core.so.1

cd $P_DIR
lrelease stacer/stacer.pro

mkdir $P_DIR/$DIST_DIR/stacer/translations

mv $P_DIR/translations/*.qm $P_DIR/$DIST_DIR/stacer/translations

rm -rf $P_DIR/$DIST_DIR/stacer-core

find $P_DIR/$DIST_DIR/stacer \( -name "moc_*" -or -name "*.o" -or -name "qrc_*" -or -name "Makefile*" -or -name "*.a" -or -name "*.h" \) -exec rm {} \;

cd $P_DIR/$DIST_DIR/stacer &&
cp $P_DIR/stacer/static/logo.png stacer.png &&
cp $P_DIR/stacer.desktop stacer.desktop

cd $P_DIR
