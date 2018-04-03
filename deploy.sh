#!/bin/bash
set -e

if [ $# -ne 3 ] ; then
 echo "usage: $0 path-to-zeppelin zeppelin-version [local|kompics]"
 exit 1
fi

dir="$(dirname "$(realpath "$0")")"
ZEPPELIN_DIR=$1
version=$2
option=$3
groupId='io.hops.zeppelin'
HADOOP_VERSION='2.7'
SPARK_VERSION='2.3'
SPARK_VERSION_FULL='2.3.0'
SCALA_VERSION='2.11'

#npm install -g yarn # uncomment if mvn Failed to run task: 'yarn run build:dist'.

cd $ZEPPELIN_DIR

#export MAVEN_OPTS="-Xmx512m -XX:MaxPermSize=128m" #uncomment if java.lang.OutOfMemoryError: PermGen space
./dev/change_scala_version.sh ${SCALA_VERSION}
mvn clean package -Pbuild-distr -Pspark-${SPARK_VERSION} -Phadoop-${HADOOP_VERSION} -Pr -Pscala-${SCALA_VERSION} -Dpy4j.version=0.10.6 -DskipTests

scp zeppelin-distribution/target/zeppelin-${version}.tar.gz glassfish@snurran.sics.se:/var/www/hops/zeppelin-${version}-bin-spark-${SPARK_VERSION_FULL}_hadoop-${HADOOP_VERSION}.tar.gz

cd $dir

repository="repository"
repositoryId="sics-release-repository"

if [[ $version == *"SNAPSHOT"* ]]
then
  repository="snapshotrepository"
  repositoryId="sics-snapshot-repository"
fi

if [[ $option == "kompics" ]]
then
  ./deploy-scripts/kompics-deploy-pom.sh $ZEPPELIN_DIR $groupId zeppelin $version pom $repository $repositoryId
  ./deploy-scripts/kompics-deploy.sh $ZEPPELIN_DIR $groupId zeppelin-interpreter $version jar $repository $repositoryId
  ./deploy-scripts/kompics-deploy.sh $ZEPPELIN_DIR $groupId zeppelin-zengine $version jar $repository $repositoryId 
  ./deploy-scripts/kompics-deploy.sh $ZEPPELIN_DIR $groupId zeppelin-web $version war $repository $repositoryId
  ./deploy-scripts/kompics-deploy-pom.sh $ZEPPELIN_DIR org.apache.zeppelin zeppelin $version pom $repository $repositoryId
else
  ./deploy-scripts/m2-deploy-pom.sh $ZEPPELIN_DIR $groupId zeppelin $version pom
  ./deploy-scripts/m2-deploy.sh $ZEPPELIN_DIR $groupId zeppelin-interpreter $version jar
  ./deploy-scripts/m2-deploy.sh $ZEPPELIN_DIR $groupId zeppelin-zengine $version jar 
  ./deploy-scripts/m2-deploy.sh $ZEPPELIN_DIR $groupId zeppelin-web $version war
  ./deploy-scripts/m2-deploy-pom.sh $ZEPPELIN_DIR org.apache.zeppelin zeppelin $version pom
fi
