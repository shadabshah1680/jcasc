FROM jenkins/jenkins:latest as builderzero
# FROM adoptopenjdk/openjdk11:debian as builder
# RUN apt-get update \
#     && apt-get upgrade -y \
#     && apt-get install wget -y \
#     && apt-get install -y git \
#     && apt-get install -y curl \
#     && curl - https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
#     && apt-get install -y git-lfs unzip && git lfs install && rm -rf /var/lib/apt/lists/* 
# ENV JENKINS_HOME /var/jenkins_home
# RUN mkdir -p $JENKINS_HOME \
#     && chown ${uid}:${gid} $JENKINS_HOME \
#     && groupadd g ${gid} ${group}
# RUN  
# ENTRYPOINT ["/sbin/tini", "--". "/usr/local/bin/jenkins.sh"] 
# #jenkins/jenkins:2.222.4
FROM builderzero
COPY plugins.txt /usr/share/jenkins/ref/plugins_extra.txt
ARG JAVA_OPTS
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"
# RUN rm -rf /var/lib/dpkg/lock-frontend
WORKDIR /usr/share/jenkins/ref
COPY jenkins-plugin-manager-2.12.8.jar  /usr/share/jenkins/ref
RUN java -jar jenkins-plugin-manager-2.12.8.jar --war /usr/lib/jenkins/jenkins.war --verbose
RUN java -jar jenkins-plugin-manager-2.12.8.jar --war /usr/lib/jenkins/jenkins.war --plugin-download-directory /var/lib/jenkins/plugins --verbose
RUN java -jar jenkins-plugin-manager-2.12.8.jar --war /usr/lib/jenkins/jenkins.war --plugin-download-directory /var/lib/jenkins/plugins --jenkins-update-center http://mirror.xmission.com/jenkins/updates/update-center.json --verbose
RUN export JENKINS_UC_DOWNLOAD=http://mirror.xmission.com/jenkins/
RUN java -jar jenkins-plugin-manager-2.12.8.jar  --war /usr/lib/jenkins/jenkins.war  -f /usr/share/jenkins/ref/plugins_extra.txt 