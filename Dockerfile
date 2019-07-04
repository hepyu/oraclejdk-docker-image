#基础镜像
FROM centos
MAINTAINER      hpy253215039@163.com

#前期准备，比如创建运行用户，相关目录，相关的基础命令如telnet, mysql, redis-cli等。
RUN useradd inc \
;mkdir -p /app/3rd\
;mkdir  -p /app/inc/apps  \
;mkdir -p /data/inc/logs/tomcat \
;chown -R inc:inc /app/inc/ /data/inc \
;ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime && /usr/bin/yum -y install net-tools  telnet tcpdump iproute  && /usr/bin/yum clean all && ln -s /app/3rd/mysql/default/bin/mysql /usr/bin/mysql && ln -s /app/3rd/redis/default/bin/redis-cli /usr/bin/redis-cli && echo 'alias log="cd /data/inc/logs/$HOSTNAME"' >> ~/.bashrc

#将oraclejdk压入镜像
#ADD命令含义：
#1、如果源路径是个文件，且目标路径是以 / 结尾， 则docker会把目标路径当作一个目录，会把源文件拷贝到该目录下。
#   如果目标路径不存在，则会自动创建目标路径。
#2、如果源路径是个文件，且目标路径是不是以 / 结尾，则docker会把目标路径当作一个文件。
#   如果目标路径不存在，会以目标路径为名创建一个文件，内容同源文件；
#   如果目标文件是个存在的文件，会用源文件覆盖它，当然只是内容覆盖，文件名还是目标文件名。
#   如果目标文件实际是个存在的目录，则会源文件拷贝到该目录下。 注意，这种情况下，最好显示的以 / 结尾，以避免混淆。
#3、如果源路径是个目录，且目标路径不存在，则docker会自动以目标路径创建一个目录，把源路径目录下的文件拷贝进来。
#   如果目标路径是个已经存在的目录，则docker会把源路径目录下的文件拷贝到该目录下。
#4、如果源文件是个归档文件（压缩文件），则docker会自动帮解压。
#
#需要注意：
#   jdk.tar.gz解压后的目录要和后边的ENV JAVA_HOME的配置相匹配，否则运行容器后找不到java命令。
ADD jdk.tar.gz /app/3rd/

#默认将mysql和redis-cli压入镜像，很多情况下都要用到。
COPY mysql /app/3rd/mysql/default/bin/
COPY redis-cli /app/3rd/redis/default/bin/

#配置环境变量
ENV JAVA_HOME /app/3rd/jdk/default
ENV PATH $PATH:/$JAVA_HOME/bin
ENV LANG en_US.UTF-8
