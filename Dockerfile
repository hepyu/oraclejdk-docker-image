FROM centos
MAINTAINER      hpy253215039@163.com

RUN useradd inc \
;mkdir -p /app/3rd\
;mkdir  -p /app/inc/apps  \
;mkdir -p /data/inc/logs/tomcat \
;chown -R inc:inc /app/inc/ /data/inc \
;ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime && /usr/bin/yum -y install net-tools  telnet tcpdump iproute  && /usr/bin/yum clean all && ln -s /app/3rd/mysql/default/bin/mysql /usr/bin/mysql && ln -s /app/3rd/redis/default/bin/redis-cli /usr/bin/redis-cli && echo 'alias log="cd /data/inc/logs/$HOSTNAME"' >> ~/.bashrc

ADD jdk-8u181-linux-x64.tar.gz /app/3rd/

COPY mysql /app/3rd/mysql/default/bin/
COPY redis-cli /app/3rd/redis/default/bin/

ENV JAVA_HOME /app/3rd/jdk/default
ENV PATH $PATH:/$JAVA_HOME/bin
ENV LANG en_US.UTF-8

EXPOSE 8080
EXPOSE 8000
