#!/bin/bash
set -e

if [ $# -ne 1 ] ; then
 echo "usage: $0 path-to-zeppelin zeppelin-version"
 exit 1
fi

dir="$(dirname "$(realpath "$0")")"
ZEPPELIN_DIR=$1
version=$2

cd $ZEPPELIN_DIR
mvn clean package -Pbuild-distr -Pspark-1.6 -Phadoop-2.4 -Pyarn -Ppyspark -Dspark.version=1.6.1 -Psparkr
#scp zeppelin-distribution/target/zeppelin-${version}.tar.gz glassfish@snurran.sics.se:/var/www/hops
scp zeppelin-distribution/target/zeppelin-${version}-bin-spark-1.6.1_hadoop-2.4.tar.gz glassfish@snurran.sics.se:/var/www/hops

cd $dir
./mvn-install-pom.sh $ZEPPELIN_DIR zeppelin $version pom
./mvn-install-local.sh $ZEPPELIN_DIR zeppelin-interpreter $version jar
./mvn-install-local.sh $ZEPPELIN_DIR zeppelin-zengine $version jar 
./mvn-install-local.sh $ZEPPELIN_DIR zeppelin-web $version war
