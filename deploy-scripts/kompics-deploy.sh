#!/bin/bash
MINPARAMS=7
if [ $# -lt "$MINPARAMS" ]
then
  echo "usage: $0 <path-to-zeppelin> <groupId> <artifact-id> <version> <packaging> <repository> <repositoryId>"
  exit 1
fi
   
path="$1"
groupId="$2"
artifactId="$3"
version="$4"
packaging="$5"  
repository="$6"
repositoryId="$7"

mvn  deploy:deploy-file -Durl=scpexe://kompics.i.sics.se/home/maven/$repository \
                        -DrepositoryId=$repositoryId \
		        -Dfile=$path/$artifactId/target/$artifactId-$version.$packaging \
		        -DgroupId=$groupId \
		        -DartifactId=$artifactId \
		        -Dversion=$version \
		        -DgeneratePom=true \
		        -Dpackaging=$packaging \
		        -DpomFile=$path/$artifactId/pom.xml \
			-DgeneratePom.description="Apache $artifactId" 
