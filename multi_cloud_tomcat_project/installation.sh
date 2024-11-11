#!/bin/bash

set -x

# Installing Maven
sudo apt update
sudo apt install maven -y

echo "Checking installation of Maven"
mvn -version
sleep 2

# Installing OpenJDK
sudo apt install openjdk-11-jdk -y

echo "OpenJDK installed. If you see the version displayed below, the installation was successful."
java -version
sleep 2 

# Create a tomcat user without a home directory for security reasons
sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat

# Downloading the Tomcat binary
wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.65/bin/apache-tomcat-9.0.65.tar.gz
sudo mkdir /opt/tomcat
sudo tar -xvzf apache-tomcat-9.0.65.tar.gz -C /opt/tomcat --strip-components=1

# Setting permissions for Tomcat
sudo chown -R tomcat: /opt/tomcat
sudo chmod -R 755 /opt/tomcat

# Create the systemd service file for Tomcat
cat <<EOF | sudo tee /etc/systemd/system/tomcat.service > /dev/null
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64"
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
Environment="CATALINA_HOME=/opt/tomcat"
Environment="CATALINA_BASE=/opt/tomcat"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd to recognize the new service
sudo systemctl daemon-reload

# Start and enable Tomcat
sudo systemctl start tomcat
sudo systemctl enable tomcat

