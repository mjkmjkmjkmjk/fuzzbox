#
# jmx example (for testing jconsole) Dockerfile
#
FROM ubuntu:latest
MAINTAINER Mike Kurtis "mkurtis@mesosphere.com"

# Get Ubuntu packages (including Java);
# 	openjdk-8-jre \
RUN apt-get update && apt-get install -y \
	openjdk-8-jdk \
	wget \
	zip \
	unzip 


WORKDIR /home

# Make port 80 available to the world outside this container
EXPOSE 9999

RUN wget https://docs.oracle.com/javase/tutorial/jmx/examples/jmx_examples.zip
RUN unzip ./jmx_examples.zip
RUN export CLASSPATH=.:./com:./com/example:./com/example/Main.class:./com/example/Main.java

RUN javac com/example/*.java
RUN export CLASSPATH=.:/home/com/example/Main.class


CMD ["java", "-Dcom.sun.management.jmxremote.rmi.port=9999", "-Dcom.sun.management.jmxremote.port=9999",  "-Dcom.sun.management.jmxremote.authenticate=false", "-Dcom.sun.management.jmxremote.ssl=false",  "com.example.Main" ]

