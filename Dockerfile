FROM ubuntu:18.04
SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install apt-utils default-jdk tomcat9 git wget -y
WORKDIR /opt
RUN wget https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz && tar xzf apache-maven-3.8.5-bin.tar.gz && mv apache-maven-3.8.5 apachemaven
RUN printf "export JAVA_HOME=/usr/lib/jvm/default-java \n" >> /etc/profile.d/apachemaven.sh
RUN printf "export M2_HOME=/opt/apachemaven \n" >> /etc/profile.d/apachemaven.sh
RUN printf "export MAVEN_HOME=/opt/apachemaven \n" >> /etc/profile.d/apachemaven.sh
RUN printf "export PATH=\${M2_HOME}/bin:\${PATH}" >> /etc/profile.d/apachemaven.s
RUN chmod +x /etc/profile.d/apachemaven.sh
RUN source /etc/profile.d/apachemaven.sh
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR /opt/boxfuse-sample-java-war-hello
RUN mvn package
RUN cp /opt/boxfuse-sample-java-war-hello/target/hello-1.0.war /var/lib/tomcat9/webapps/
EXPOSE 8080
CMD ["/usr/share/tomcat9/bin/catalina.sh", "run"]