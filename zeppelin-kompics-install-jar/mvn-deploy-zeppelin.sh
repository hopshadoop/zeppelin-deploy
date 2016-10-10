#!/bin/bash
set -e

if [ $# -ne 2 ] ; then
 echo "usage: $0 path-to-zeppelin zeppelin-version"
 exit 1
fi

dir="$(dirname "$(realpath "$0")")"
ZEPPELIN_DIR=$1
version=$2

#cd ..
#./apply-patch.sh $ZEPPELIN_DIR

cd $ZEPPELIN_DIR

./dev/change_scala_version.sh 2.11
mvn clean package -Pbuild-distr -Pspark-2.0 -Phadoop-2.4 -Pyarn -Ppyspark -Psparkr -Pscala-2.11

scp zeppelin-distribution/target/zeppelin-${version}.tar.gz glassfish@snurran.sics.se:/var/www/hops/zeppelin-${version}-bin-spark-2.0.1_hadoop-2.4.tar.gz

cd $dir

./mvn-deploy-pom.sh $ZEPPELIN_DIR zeppelin $version pom
./mvn-deploy.sh $ZEPPELIN_DIR zeppelin-interpreter $version jar
./mvn-deploy.sh $ZEPPELIN_DIR zeppelin-zengine $version jar 
./mvn-deploy.sh $ZEPPELIN_DIR zeppelin-web $version war
