#!/bin/bash

echo "Go uninstallation script"
sleep 2

echo "Step 1: Remove go directory"
sleep 2
sudo rm -rf /usr/local/go

echo "Step 2: Backup .bashrc"
sleep 2
cp .bashrc .bashrc.backup
ls -al

echo "Step 3: Reset environment path"
sleep 2
sed -i '/export PATH=\${PATH}:\/usr\/local\/go\/bin/d' .bashrc
sed -i '/export GOPATH=\${HOME}\/go/d' .bashrc

echo "Step 4: Apply the environment path"
sleep 2
. ${HOME}/.bashrc


echo "Step 5: Check if Go is successfully uninstalled or not"
sleep 2
go version

echo "Step 6: Remove gosrc directory (optional)"
sleep 2
# sudo rm -rf ${HOME}/go
