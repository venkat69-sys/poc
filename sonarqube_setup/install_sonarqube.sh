#!/bin/bash

# Install Java
# sudo dnf install -y java-17-openjdk-devel unzip wget

# Create SonarQube user
sudo useradd -r -s /bin/false sonarqube

# Download SonarQube
cd /opt
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.4.1.88267.zip
sudo unzip sonarqube-*.zip
sudo mv sonarqube-* sonarqube
sudo chown -R sonarqube:sonarqube /opt/sonarqube

# Copy custom sonar.properties if available
if [ -f sonar.properties ]; then
    sudo cp sonar.properties /opt/sonarqube/conf/sonar.properties
    sudo chown sonarqube:sonarqube /opt/sonarqube/conf/sonar.properties
fi
