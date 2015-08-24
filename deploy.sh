#!/bin/bash

if [ $# -ne 1 ] ; then
 echo "usage: $0 zeppelin-version"
 echo "example: $0 0.5.0-incubating"
 exit 1
fi


version=$1
mvn  deploy:deploy-file -Durl=scpexe://kompics.i.sics.se/home/maven/repository \
                       -DrepositoryId=sics-release-repository \
                       -Dfile=./zeppelin-web-$version.war \
                       -DgroupId=org.apache.zeppelin \
                       -DartifactId=zeppelin-web \
                       -Dversion=$version \
                       -Dpackaging=war \
                       -DpomFile=./pom.xml \
                       -DgeneratePom.description="Apache Zeppelin Web App"
