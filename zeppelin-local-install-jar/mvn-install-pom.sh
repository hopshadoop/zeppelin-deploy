#!/bin/bash
MINPARAMS=3
if [ $# -lt "$MINPARAMS" ]
then
  echo "usage: $0 <path-to-zeppelin> <artifact-id> <version> <packaging>"
  exit 1
fi
  
path="$1"
artifactId="$2"
version="$3"
packaging="$4" 

cp $path/pom.xml $path/$artifactId-$version.$packaging

mvn install:install-file \
   -Dfile=$path/$artifactId-$version.$packaging \
   -DgroupId=org.apache.zeppelin \
   -DartifactId=$artifactId \
   -Dversion=$version \
   -Dpackaging=$packaging \
   -DpomFile=$path/pom.xml
