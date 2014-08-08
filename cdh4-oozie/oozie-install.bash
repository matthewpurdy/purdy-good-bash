#!/bin/bash

hostname=${1:-localhost}

# install binaries
yum install -y oozie > /dev/null

# install mysql server
yum install -y mysql mysql-server > /dev/null

# configure mysql server to start at boot
chkconfig mysqld on

# start mysql server
service mysqld start > /dev/null

# mysql -uroot -p to log into mysql => just hit enter for password

# create sql script
echo "create database oozie;"                                                         > /tmp/oozie_sql.sql
echo "grant all privileges on ozzie.* to 'oozie'@'localhost' identified by 'oozie';" >> /tmp/oozie_sql.sql
echo "grant all privileges on oozie.* to 'oozie'@'%' identified by 'oozie;'"         >> /tmp/oozie_sql.sql

# execute script
mysql < /tmp/oozie_sql.sql > /dev/null 2>&1

# create properties for oozie
echo "    <property>"                                               > /tmp/ozzie_properties.txt
echo "        <name>oozie.service.JPAService.jdbc.driver</name>"   >> /tmp/ozzie_properties.txt
echo "        <value>com.mysql.jdbc.Driver</value>"                >> /tmp/ozzie_properties.txt
echo "    </property>"                                             >> /tmp/ozzie_properties.txt
echo "    <property>"                                              >> /tmp/ozzie_properties.txt
echo "        <name>oozie.service.JPAService.jdbc.url</name>"      >> /tmp/ozzie_properties.txt
echo "        <value>jdbc:mysql://${hostname}:3306/oozie</value>"  >> /tmp/ozzie_properties.txt
echo "    </property>"                                             >> /tmp/ozzie_properties.txt
echo "    <property>"                                              >> /tmp/ozzie_properties.txt
echo "        <name>oozie.service.JPAService.jdbc.username</name>" >> /tmp/ozzie_properties.txt
echo "        <value>oozie</value>"                                >> /tmp/ozzie_properties.txt
echo "    </property>"                                             >> /tmp/ozzie_properties.txt
echo "    <property>"                                              >> /tmp/ozzie_properties.txt
echo "        <name>oozie.service.JPAService.jdbc.password</name>" >> /tmp/ozzie_properties.txt
echo "        <value>oozie</value>"                                >> /tmp/ozzie_properties.txt
echo "    </property>"                                             >> /tmp/ozzie_properties.txt
echo ""                                                            >> /tmp/ozzie_properties.txt

# append to oozie-site.xml within the "configuration" tag
sed -i '/^.*<\/configuration>.*$/d' /etc/oozie/conf/oozie-site.xml
cat /tmp/oozie_properties.txt >> /etc/oozie/conf/oozie-site.xml
echo '</configuration>'       >> /etc/oozie/conf/oozie-site.xml

# you will need to comment out the default properties and change JPAService.create.db.schema to true

# get mysql connector for java
cd /tmp
wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.31.tar.gz 
tar -zxf mysql-connector-java-5.1.31.tar.gz
cd mysql-connector-java-5.1.31
cp mysql-connector-java-5.1.31-bin.jar /var/lib/oozie/

# setup oozie database
sudo -u oozie /usr/lib/oozie/bin/ooziedb.sh create -run

# get ExtJs lib
cd /tmp
wget http://archive.cloudera.com/gplextras/misc/ext-2.2.zip
unzip ext-2.2.zip
mv ext-2.2 /var/lib/oozie/

# start oozie
service oozie start

# open firefox 
firefox http://localhost:11000





