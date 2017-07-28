#!/bin/bash
set -e

if [ $# -ne 2 ] ; then
 echo "usage: $0 path-to-zeppelin zeppelin-version"
 exit 1
fi

dir="$(dirname "$(realpath "$0")")"
ZEPPELIN_DIR=$1
version=$2
groupId='io.hops.zeppelin'
HADOOP_VERSION='2.7'
SPARK_VERSION='2.1'
SPARK_VERSION_FULL='2.1.0'
SCALA_VERSION='2.11'

cd ..
.patchs/apply-patch.sh $ZEPPELIN_DIR

cd $ZEPPELIN_DIR

./dev/change_scala_version.sh ${SCALA_VERSION}
mvn clean package -Pbuild-distr -Pspark-${SPARK_VERSION} -Phadoop-${HADOOP_VERSION} -Pyarn -Ppyspark -Psparkr -Pscala-${SCALA_VERSION} -DskipTests

scp zeppelin-distribution/target/zeppelin-${version}.tar.gz glassfish@snurran.sics.se:/var/www/hops/zeppelin-${version}-bin-spark-${SPARK_VERSION_FULL}_hadoop-${HADOOP_VERSION}.tar.gz

cd $dir

repository="repository"
repositoryId="sics-release-repository"

if [[ $version == *"SNAPSHOT"* ]]
then
  repository="snapshotrepository"
  repositoryId="sics-snapshot-repository"
fi

./deploy-kompics/mvn-deploy-pom.sh $ZEPPELIN_DIR $groupId zeppelin $version pom $repository $repositoryId
./deploy-kompics/mvn-deploy.sh $ZEPPELIN_DIR $groupId zeppelin-interpreter $version jar $repository $repositoryId
./deploy-kompics/mvn-deploy.sh $ZEPPELIN_DIR $groupId zeppelin-zengine $version jar $repository $repositoryId 
./deploy-kompics/mvn-deploy.sh $ZEPPELIN_DIR $groupId zeppelin-web $version war $repository $repositoryId
