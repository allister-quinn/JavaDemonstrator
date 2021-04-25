#!/bin/bash

echo "Starting SonarQube"
docker pull sonarqube
docker run -d --name sonarqube --rm --network jenkins -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true -p 9000:9000 sonarqube:latest
# manual steps:
# - setup username / password (starter creds are admin/admin)
# - generate security key ca690640925f1c0ce58968bcb044445796e895c6

echo "Starting Jenkins"
docker image pull docker:dind
docker run \
  --name jenkins-dind \
  --rm \
  --detach \
  --privileged \
  --network jenkins \
  --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 3000:3000 \
  --publish 2376:2376 \
  docker:dind \
  --storage-driver overlay2
  
docker pull jenkins/jenkins:lts-jdk11
echo 'FROM jenkins/jenkins:lts-jdk11
USER root
RUN apt-get update && apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean sonar docker-plugin docker-workflow git"' > Dockerfile

docker build -t jenkins-docker .
docker run \
  --name jenkins-docker \
  --rm \
  --detach \
  --network jenkins \
  --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client \
  --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 \
  --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  --volume "$HOME":/home \
  jenkins-docker
  
# manual steps:
# - enter security key
# - setup username / password
# - setup SonarQube servers (Name = SonarQube, Server URL = http://sonarqube-working:9000, add Secret Text security key)
  

echo "Starting PostgreSQL"
docker pull postgres
docker run --name postgres --rm --network jenkins -e POSTGRES_PASSWORD=password -e POSTGRES_DB=registration -d -p 5432:5432 postgres

echo "Starting email server"
docker pull maildev/maildev
docker run --name maildev --rm --network jenkins -p 1080:80 -p 1025:25 -d maildev/maildev
