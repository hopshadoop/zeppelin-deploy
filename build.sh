#!/bin/bash
./dev/change_scala_version.sh 2.11
mvn clean package -Pbuild-distr -Pspark-2.0 -Phadoop-2.6 -Pyarn -Ppyspark -Psparkr -Pscala-2.11 -DskipTests

scp 
