#!/bin/bash

##############################################################################################
echo "Step 1: Install Elasticsearch, Logstash, and Kibana"

## Detect OS ID (ubuntu, centos, and etc.) without double quote sign
OS_ID=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release | tr -d \")

SYSTEMD_PATH=""

echo "OS ID: ${OS_ID}"
case "${OS_ID}" in
  ubuntu* | debian*) 

  echo "OS ID like: debian-like"
  # Prerequisites
  sudo DEBIAN_FRONTEND=noninteractive apt-get update -qq
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq -y openjdk-11-jdk < /dev/null > /dev/null

  # Download Elasticsearch, Logstash, and Kibana 8.3.0
  cd ~ 
  sudo wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.3.0-amd64.deb
  sudo wget https://artifacts.elastic.co/downloads/logstash/logstash-8.3.0-amd64.deb
  sudo wget https://artifacts.elastic.co/downloads/kibana/kibana-8.3.0-amd64.deb

  # Install Elasticsearch, Logstash, and Kibana by dpkg
  cd ~
  sudo dpkg -i elasticsearch-8.3.0-amd64.deb > /dev/null 2>&1
  sudo dpkg -i logstash-8.3.0-amd64.deb > /dev/null 2>&1
  sudo dpkg -i kibana-8.3.0-amd64.deb > /dev/null 2>&1


  # SYSTEMD_PATH="/lib/systemd/system/cb-network-agent.service"
  ;;

  centos* | rocky* | rhel* | fedora*)    
  
  echo "OS ID like: debian-like"
  # Prerequisites
  sudo yum -q -y update
  sudo yum -q -y install java-11-openjdk

  # Download Elasticsearch, Logstash, and Kibana 8.3.0
  cd ~
  sudo wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.3.0-x86_64.rpm
  sudo wget https://artifacts.elastic.co/downloads/logstash/logstash-8.3.0-x86_64.rpm
  sudo wget https://artifacts.elastic.co/downloads/kibana/kibana-8.3.0-x86_64.rpm

  # Install Elasticsearch, Logstash, and Kibana by rpm
  cd ~
  sudo rpm -i elasticsearch-8.3.0-x86_64.rpm > /dev/null 2>&1
  sudo rpm -i logstash-8.3.0-x86_64.rpm > /dev/null 2>&1
  sudo rpm -i kibana-8.3.0-x86_64.rpm > /dev/null 2>&1


  # SYSTEMD_PATH="/usr/lib/systemd/system/cb-network-agent.service"
  ;;

  *)
  echo "unknown: ${OS_ID}" 
  ;;
esac

echo "Please, configure and start ELK"
echo ""
echo "- Note - "
echo "Configuration files:"
echo "/etc/elasticsearch/elasticsearch.yml"
echo "/etc/logstash/logstash.yml"
echo "/etc/kibana/kibana.yml"
echo ""
echo "Start commands:"
echo "sudo systemctl start elasticsearch.service"
echo "sudo systemctl start logstash.service"
echo "sudo systemctl start kinaba.service"

##############################################################################################
# echo "Step 2: Set configuration of Elasticsearch, Logstash, and Kibana"
# # Backup the existing filebeat.yaml
# cd /etc/filebeat/
# sudo mv filebeat.yml filebeat.yml.backup
# # Change mode
# sudo chmod 600 filebeat.yml.backup

# # Download filebeat.yml
# # NOTICE: Please use your filebeat.yaml download link.
# cd /etc/filebeat/
# echo "NOTICE: Please use your filebeat.yaml download link :)"
# LINK="http://alvin-mini.iptime.org:18000/elk-stack/filebeat/filebeat.yml"
# sudo wget -q --no-cache ${LINK} -O filebeat.yml
# #sudo cat filebeat.yml
# # Change mode
# sudo chmod 600 filebeat.yml

##############################################################################################
# echo "Step 3: Start Elasticsearch, Logstash, and Kibana services"
# sudo systemctl start elasticsearch.service
# sudo systemctl start logstash.service
# sudo systemctl start kinaba.service

# echo "Step 4: (Optional) Set up start-on-boot"
#sudo systemctl enable elasticsearch.service
#sudo systemctl enable logstash.service
#sudo systemctl enable kinaba.service
