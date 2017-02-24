FROM centos:centos7

RUN yum -y update;
RUN yum -y clean all;

# Install basic tools
RUN yum install -y  wget dialog curl sudo lsof vim axel telnet nano openssh-server openssh-clients bzip2 passwd tar bc git unzip net-tools

#Install Java
RUN yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel 
ENV JAVA_HOME /etc/alternatives/java_sdk

RUN echo root | passwd root --stdin

ENV HOME /root
WORKDIR $HOME

