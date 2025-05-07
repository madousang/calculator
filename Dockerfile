FROM openjdk:17-jdk-slim

RUN apt-get update && apt-get install -y wget && \
    wget https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-linux-amd64-v0.6.1.tar.gz && \
    tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.6.1.tar.gz

COPY build/libs/calculator-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["dockerize", "-wait", "tcp://redis:6379", "-timeout", "30s", "java", "-jar", "app.jar"]
