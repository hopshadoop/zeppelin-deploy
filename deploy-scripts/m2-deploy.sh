#!/bin/bash
MINPARAMS=5
if [ $# -lt "$MINPARAMS" ]
then
  echo "usage: $0 <path-to-zeppelin> <groupId> <artifact-id> <version> <packaging>"
  exit 1
fi 

path="$1"
groupId="$2"
artifactId="$3"
version="$4"
packaging="$5"

mvn install:install-file \
   -Dfile=$path/$artifactId/target/$artifactId-$version.$packaging \
   -DgroupId=$groupId \
   -DartifactId=$artifactId \
   -Dversion=$version \
   -DgeneratePom=true \
   -Dpackaging=$packaging \
   -DpomFile=$path/$artifactId/pom.xml  
