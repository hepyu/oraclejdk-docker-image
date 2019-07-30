rm -rf jdk.tar.gz

#jdk-8u181-linux-x64.tar.gz需要从官网下载
tar -xzvf jdk1.8.0_221.tar.gz

#image中压入的jdk的路径是/app/3rd/jdk/default，这里的jdk/default是做路径。
mkdir -p jdk/default
mv jdk1.8.0_221/* jdk/default
chmod -R 755 jdk
tar -czvf jdk.tar.gz jdk/

rm -rf jdk
rm -rf jdk1.8.0_221

chmod -R 755 jdk.tar.gz
