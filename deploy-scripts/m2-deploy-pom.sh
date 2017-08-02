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

cp $path/pom.xml $path/$artifactId-$version.$packaging

sed -i -e "s/##groupId##/$groupId/g" ./pom.xml
sed -i -e "s/##artifactId##/$artifactId/g" ./pom.xml
sed -i -e "s/##version##/$version/g" ./pom.xml
sed -i -e "s/##packaging##/$packaging/g" ./pom.xml

mvn install:install-file \
   -Dfile=$path/$artifactId-$version.$packaging \
   -DgroupId=$groupId \
   -DartifactId=$artifactId \
   -Dversion=$version \
   -Dpackaging=$packaging \
   -DpomFile=$path/pom.xml
