#Build from scratch
#I want to use latest LTS Ubuntu
FROM ubuntu:20.04
#update repository, install soft, download boxfuse
RUN apt-get update && apt-get install default-jdk -y && apt-get install maven -y && apt-get install tomcat9 -y && apt-get install git -y &&  git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
#Go to boxfuse path
WORKDIR boxfuse-sample-java-war-hello
#Create war file
RUN mvn package
#Copy file to path of tomcat
RUN cp target/hello-1.0.war /var/lib/tomcat9/webapps/
#Forward ports
EXPOSE 8080
    #CMD ["tomcat", "-g", "daemon off;"]
    #CMD ["/usr/share/tomcat9/bin/catalina.sh", "run"]
    #CMD ["/usr/share/tomcat9/bin/catalina.sh", "run", "daemon off;"]