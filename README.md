# Deploy zeppelin

##Deploy zeppelin to sics repository

1.  Copy settings.xml to ~/.m2 
2.  Clone zeppelin
and add exclusions for **sisu-inject-plexus** and **sisu-inject-bean**
```xml
    <dependency>
      <groupId>org.sonatype.aether</groupId>
      <artifactId>aether-connector-wagon</artifactId>
      <version>1.12</version>
      <exclusions>
        <exclusion>
          <groupId>org.apache.maven.wagon</groupId>
          <artifactId>wagon-provider-api</artifactId>
        </exclusion>
	<exclusion>
          <groupId>org.sonatype.sisu</groupId>
          <artifactId>sisu-inject-plexus</artifactId>
        </exclusion>
        <exclusion>
          <groupId>org.sonatype.sisu</groupId>
          <artifactId>sisu-inject-bean</artifactId>
        </exclusion>   
      </exclusions>
    </dependency>
```
3.  cd deploy-zeppelin/zeppelin-kompics-install-jar
4.  Apply the patch 'sisu.patch' on the zepplin project. See 'apply-patch.sh' for how to do that. 
5.  run ./mvn-deploy-zeppelin.sh <path-to-zeppelin> <version>

This will build zeppelin and copy the distribution tar to snurran.sics.se. Then add  zeppelin-interpreter.jar, zeppelin-zengine.jar, and zeppelin-web.war to 
kompics snapshot or release repository depending on the version of zeppelin. 

##Deploy zeppelin to local .m2 repository.(for testing)  

1.  Copy settings.xml to ~/.m2 
2.  Clone zeppelin
3.  cd deploy-zeppelin/zeppelin-local-install-jar
4.  run ./m2-install-zeppelin.sh <path-to-zeppelin> <version>
