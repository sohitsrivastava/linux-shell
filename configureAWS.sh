#!/bin/bash

key="/home/sohit/gocd.pem"
IP="13.235.67.247"
war="/home/sohit/warfiles"

# Creating a War File folder in the instance
ssh -i ${key} ec2-user@${IP} '
cd /;
sudo mkdir warfiles;
sudo chown ec2-user:ec2-user warfiles;
exit;
'

#Copying the war File to the warfilesfolder in instance
scp -i ${key} ${war}/*.war ec2-user@${IP}:/warfiles


ssh -i ${key} ec2-user@${IP} '
sudo yum update -y;
sudo yum install java-1.8.0-openjdk.x86_64 -y;
df -h;
cd /opt;
sudo wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.46/bin/apache-tomcat-8.5.46.tar.gz;
sudo gunzip apache-tomcat-8.5.46.tar.gz;
sudo tar -xvf apache-tomcat-8.5.46.tar;
sudo mv apache-tomcat-8.5.46 tomcat;
sudo scp /warfiles/*.war /opt/tomcat/webapps;
sudo sh /opt/tomcat/bin/startup.sh;
'
echo "Was it Successful : ${?}"
