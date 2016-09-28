#!/bin/bash
MINPARAMS=4
if [ $# -lt "$MINPARAMS" ]
then
  echo "usage: $0 <path-to-zeppelin> <artifact-id> <version> <packaging>"
  exit 1
fi
  
path="$1"
artifactId="$2"
version="$3"
packaging="$4" 

mvn install:install-file \
   -Dfile=$path/$artifactId/target/$artifactId-$version.$packaging \
   -DgroupId=org.apache.zeppelin \
   -DartifactId=$artifactId \
   -Dversion=$version \
   -DgeneratePom=true \
   -Dpackaging=$packaging \
   -DpomFile=$path/$artifactId/pom.xml  
