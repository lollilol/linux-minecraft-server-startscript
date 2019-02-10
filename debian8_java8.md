## Just paste this in your ssh: 

### Debian 8
##### Add it to your repositorys
+ echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
+ apt-get update && apt-get install oracle-java8-installer

### Debian 9
+ apt-get install default-jre
