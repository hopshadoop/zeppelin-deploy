#!/bin/bash
if [ $# -ne 1 ] ; then
 echo "usage: $0 path-to-zeppelin"
 exit 1
fi

ZEPPELIN_DIR=$1
ZEPPELIN_DEPLOY=$PWD

cd $ZEPPELIN_DIR/zeppelin-interpreter

patch <  ../../zeppelin-deploy/sisu.patch

cd ../zeppelin-web/src/components/baseUrl

patch <  $ZEPPELIN_DEPLOY/js.patch

