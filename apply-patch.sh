#!/bin/bash
if [ $# -ne 1 ] ; then
 echo "usage: $0 path-to-zeppelin"
 exit 1
fi

ZEPPELIN_DIR=$1

cd $ZEPPELIN_DIR/zeppelin-interpreter

patch <  ../../deploy-zeppelin/sisu.patch

