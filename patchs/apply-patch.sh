#!/bin/bash
if [ $# -ne 1 ] ; then
 echo "usage: $0 path-to-zeppelin"
 exit 1
fi

ZEPPELIN_DIR=$1
ZEPPELIN_DEPLOY=$PWD

cd $ZEPPELIN_DIR/zeppelin-interpreter

patch <  $ZEPPELIN_DEPLOY/patchs/sisu.patch

cd $ZEPPELIN_DIR/zeppelin-web/src/components/base-url

patch <  $ZEPPELIN_DEPLOY/patchs/js.patch

