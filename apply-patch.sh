#!/bin/bash

cd ../zeppelin
cp ../deploy-zeppelin/sisu.patch .
patch <  sisu.patch
