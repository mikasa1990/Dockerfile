#Build from scratch
#I want to use latest LTS Ubuntu
FROM ubuntu:20.04
#update repository
RUN apt-get update
#Install Java
RUN apt-get install default-jdk -y
#Install maven
RUN apt-get install maven -y
#Install Apache tomcat
RUN apt-get install tomcat9 -y
#Install GIT
RUN apt-get install git -y
#Download boxfuse
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
#Go to boxfuse path
WORKDIR boxfuse-sample-java-war-hello
#Create war file
RUN mvn package
#Go to target path (it include war file)
#WORKDIR target
#Copy file to path of tomcat
COPY target/hello-1.0.war /var/lib/tomcat9/webapps/
#Forward ports
EXPOSE 8080
#RUN rm -rf /var/www/html/*
#ADD index.html /var/www/html/
CMD ["tomcat9", "-g", "daemon off;"]