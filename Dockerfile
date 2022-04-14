FROM ubuntu:20.04
RUN apt-get update && apt-get install default-jdk -y && apt-get install tomcat9 -y && apt-get install git -y
WORKDIR /opt
RUN wget https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz && tar xzf apache-maven-3.8.5-bin.tar.gz && mv apache-maven-3.8.5 apachemaven && printf "export JAVA_HOME=/usr/lib/jvm/default-java \n" >> /etc/profile.d/apachemaven.sh && printf "export M2_HOME=/opt/apachemaven \n" >> /etc/profile.d/apachemaven.sh && printf "export MAVEN_HOME=/opt/apachemaven \n" >> /etc/profile.d/apachemaven.sh && printf "export PATH=\${M2_HOME}/bin:\${PATH}" >> /etc/profile.d/apachemaven.s && chmod +x /etc/profile.d/apachemaven.sh && source /etc/profile.d/apachemaven.sh && git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR boxfuse-sample-java-war-hello
RUN mvn package && cp target/hello-1.0.war /var/lib/tomcat9/webapps/
EXPOSE 8080
CMD ["/usr/share/tomcat9/bin/catalina.sh", "run"]









