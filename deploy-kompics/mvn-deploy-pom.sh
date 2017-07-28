#!/bin/bash
MINPARAMS=7
if [ $# -lt "$MINPARAMS" ]
then
  echo "usage: $0 <path-to-zeppelin> <artifact-id> <version> <packaging>"
  exit 1
fi
  
path="$1"
groupId="$2"
artifactId="$3"
version="$4"
packaging="$5"  
repository="$6"
repositoryId="$7"

cp $path/pom.xml $path/$artifactId-$version.$packaging

sed -i -e "s/##groupId##/$groupId/g" ./pom.xml
sed -i -e "s/##artifactId##/$artifactId/g" ./pom.xml
sed -i -e "s/##version##/$version/g" ./pom.xml
sed -i -e "s/##packaging##/$packaging/g" ./pom.xml

mvn  deploy:deploy-file -Durl=scpexe://kompics.i.sics.se/home/maven/$repository \
                        -DrepositoryId=$repositoryId \
		   	-Dfile=$path/$artifactId-$version.$packaging \
		   	-DgroupId=$groupId \
		   	-DartifactId=$artifactId \
		   	-Dversion=$version \
		   	-Dpackaging=$packaging \
		   	-DpomFile=$path/pom.xml \
			-DgeneratePom.description="Apache $artifactId"
