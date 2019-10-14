## 微信技术公众号：千里行走

<img src="https://github.com/hepyu/k8s-app-config/blob/master/images/%E5%8D%83%E9%87%8C%E8%A1%8C%E8%B5%B0.jpg" width="25%">

## 实战交流群

<img src="https://github.com/hepyu/saf/blob/master/images/k8s.png" width="25%">

笔者生产实践中使用/制作的jdk官方镜像。

# (1).oraclejdk镜像制作步骤

顺次执行shell脚本：

1.sh process-jdk-tar-gz.sh
用于修改下载的官方jdk压缩包为合适的文件路径，具体可以查看shell脚本。

2.sh docker.build.sh
进行镜像制作，将步骤1的jdk压入镜像。

本工程使用的是oracle-jdk8u181版本，可以根据自己需要更换版本，本工程包含JDK（太大无法上传到github）。

# (2).Dockerfile重点配置详解

#基础镜像

FROM centos

#前期准备，比如创建运行用户，相关目录，相关的基础命令如telnet等通过yum安装到镜像中。

RUN useradd inc \
;mkdir -p /app/3rd\
;mkdir  -p /app/inc/apps  \
;mkdir -p /data/inc/logs/tomcat \
;chown -R inc:inc /app/inc/ /data/inc \
;ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime && /usr/bin/yum -y install net-tools  telnet tcpdump iproute  && /usr/bin/yum clean all && ln -s /app/3rd/mysql/default/bin/mysql /usr/bin/mysql && ln -s /app/3rd/redis/default/bin/redis-cli /usr/bin/redis-cli && echo 'alias log="cd /data/inc/logs/$HOSTNAME"' >> ~/.bashrc

#将oraclejdk压入镜像；由于源文件是个归档文件（压缩文件），则docker会自动帮解压；需要注意：jdk.tar.gz解压后的目录要和后边的ENV JAVA_HOME的配置相匹配，否则运行容器后找不到java命令。

ADD jdk.tar.gz /app/3rd/

#默认将mysql和redis-cli压入镜像，很多情况下都要用到。

COPY mysql /app/3rd/mysql/default/bin/
COPY redis-cli /app/3rd/redis/default/bin/

#配置环境变量，注意路径和前边的ADD命令中解压后的路径要匹配。

ENV JAVA_HOME /app/3rd/jdk/default
ENV PATH $PATH:/$JAVA_HOME/bin
ENV LANG en_US.UTF-8

# (3).oraclejdk-image验证命令

docker run --rm oraclejdk-linux-64:8u181 java -version

如果镜像制作成功，打印如下信息：
![image](https://github.com/hepyu/oraclejdk-docker-image/blob/master/images/oraclejdk-1.png)

## 实战交流群

![image](https://github.com/hepyu/saf/blob/master/images/k8s.png)
