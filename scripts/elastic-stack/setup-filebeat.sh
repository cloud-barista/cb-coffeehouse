#!/bin/bash

##############################################################################################
echo "Step 1: Install Filebeat"

## Detect OS ID (ubuntu, centos, and etc.) without double quote sign
OS_ID=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release | tr -d \")

SYSTEMD_PATH=""

echo "OS ID: ${OS_ID}"
case "${OS_ID}" in
  ubuntu* | debian*) 

  echo "OS ID like: debian-like"
  # Prerequisites
  sudo apt update
  sudo apt install -y openjdk-11-jdk

  # Download Filebeat 8.3.0
  cd ~ 
  wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.3.0-amd64.deb

  # Install Filebeat by dpkg
  cd ~
  sudo dpkg -i filebeat-8.3.0-amd64.deb


  # SYSTEMD_PATH="/lib/systemd/system/cb-network-agent.service"
  ;;

  centos* | rocky* | rhel* | fedora*)    
  
  echo "OS ID like: debian-like"
  # Prerequisites
  sudo yum update
  sudo yum -y install java-11-openjdk

  # Download Filebeat
  cd ~
  wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.3.0-x86_64.rpm

  # Install Filebeat by rpm
  cd ~
  sudo rpm -i filebeat-8.3.0-x86_64.rpm  

  # SYSTEMD_PATH="/usr/lib/systemd/system/cb-network-agent.service"
  ;;

  *)
  echo "unknown: ${OS_ID}" 
  ;;
esac

##############################################################################################
echo "Step 2: Set Filebeat configuration"
# Backup the existing filebeat.yaml
cd /etc/filebeat/
sudo mv filebeat.yml filebeat.yml.backup
# Change mode
sudo chmod 600 filebeat.yml.backup

# Download filebeat.yml
# NOTICE: Please use your filebeat.yaml download link.
cd /etc/filebeat/
echo "NOTICE: Please use your filebeat.yaml download link :)"
LINK="http://alvin-mini.iptime.org:18000/elk-stack/filebeat/filebeat.yml"
sudo wget -q --no-cache ${LINK} -O filebeat.yml
#sudo cat filebeat.yml
# Change mode
sudo chmod 600 filebeat.yml

##############################################################################################
echo "Step 3: Start Filebeat service"
sudo systemctl start filebeat.service