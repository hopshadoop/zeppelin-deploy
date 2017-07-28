# Deploy zeppelin

##Deploy zeppelin to sics repository

1.  Copy settings.xml to ~/.m2 
2.  Clone zeppelin
3.  cd zeppelin-deploy/zeppelin-kompics-install-jar
4.  Apply the patch 'sisu.patch' on the zepplin project. See 'apply-patch.sh' for how to do that. 
5.  run ./mvn-deploy-zeppelin.sh <path-to-zeppelin> <version>

This will build zeppelin and copy the distribution tar to snurran.sics.se. Then add  zeppelin-interpreter.jar, zeppelin-zengine.jar, and zeppelin-web.war to 
kompics snapshot or release repository depending on the version of zeppelin. 

##Deploy zeppelin to local .m2 repository.(for testing)  

1.  Copy settings.xml to ~/.m2 
2.  Clone zeppelin
3.  cd deploy-zeppelin/zeppelin-local-install-jar
4.  run ./m2-install-zeppelin.sh <path-to-zeppelin> <version>
