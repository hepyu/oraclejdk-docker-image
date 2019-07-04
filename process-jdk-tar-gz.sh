rm -rf jdk.tar.gz

tar -xzvf jdk-8u181-linux-x64.tar.gz

mkdir -p jdk/default
mv jdk1.8.0_181/* jdk/default
chmod -R 755 jdk
tar -czvf jdk.tar.gz jdk/

rm -rf jdk
rm -rf jdk1.8.0_181

chmod -R 755 jdk.tar.gz
