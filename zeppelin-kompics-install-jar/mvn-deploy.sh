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

repository="repository"
repositoryId="sics-release-repository"

if [[ $version == *"SNAPSHOT"* ]]
then
  echo "Adding $artifactId to snapshot repository!";
  repository="snapshotrepository"
  repositoryId="sics-snapshot-repository"
fi

sed -i -e "s/##artifactId##/$artifactId/g" ./pom.xml
sed -i -e "s/##version##/$version/g" ./pom.xml
sed -i -e "s/##packaging##/$packaging/g" ./pom.xml

mvn  deploy:deploy-file -Durl=scpexe://kompics.i.sics.se/home/maven/$repository \
                        -DrepositoryId=$repositoryId \
		        -Dfile=$path/$artifactId/target/$artifactId-$version.$packaging \
		        -DgroupId=org.apache.zeppelin \
		        -DartifactId=$artifactId \
		        -Dversion=$version \
		        -DgeneratePom=true \
		        -Dpackaging=$packaging \
		        -DpomFile=$path/$artifactId/pom.xml \
			-DgeneratePom.description="Apache $artifactId" 
