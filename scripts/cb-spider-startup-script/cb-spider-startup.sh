#!/bin/bash

echo 
echo ==========================================================
echo == NOTICE: This script will run in 5 sec.
echo ==========================================================
echo == If you want to specify a certain version of the image, 
echo == press control + C and modify this file.
echo ==========================================================


# Delete metadata
echo 
echo ==========================================================
echo == Delete metadata
echo ==========================================================
sleep 2
sudo rm -rf /tmp/meta_db/*

# Download CB-Spider container image
echo 
echo ==========================================================
echo == Download CB-Spider container image
echo ==========================================================
sleep 2
# If you want to download a certain version of the image, 
# you can specify the version.
sudo docker pull cloudbaristaorg/cb-spider:latest

# Stop and remove running cotainer
echo 
echo ==========================================================
echo == Stop and remove running cotainer
echo ==========================================================
sleep 2
# Because of --rm option when running cb-spider container, 
# the container will be naturally deleted when stop.
sudo docker stop cb-spider

# Run the CB-Spider container
echo 
echo =================================================
echo == Run the CB-Spider container
echo =================================================
sleep 2
# If you want to download a certain version of the image, 
# you can specify the version.
sudo docker run --rm -p 1024:1024 -p 2048:2048  -v /tmp/meta_db:/root/go/src/github.com/cloud-barista/cb-spider/meta_db --name cb-spider cloudbaristaorg/cb-spider:latest
