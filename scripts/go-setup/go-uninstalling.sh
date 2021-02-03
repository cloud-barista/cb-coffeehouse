#!/bin/bash

echo "Go uninstalling script"
sleep 2

echo ""
echo "1. Change direcotry to your home directory"
sleep 2
cd $HOME

echo""
echo -n "Current directory: "
echo $PWD

echo""
echo "2. Remove go1.15.3.linux-amd64.tar.gz"
sudo rm go1.15.3.linux-amd64.tar.gz

echo ""
echo "3. Remove go directory"
sleep 2
sudo rm -rf $HOME/go

echo ""
echo "4. Remove gosrc directory"
sleep 2
sudo rm -rf $HOME/gosrc

echo ""
echo "5. Backup .bashrc"
sleep 2
cp .bashrc .bashrc.backup
ls -al

echo ""
echo "6. Reset environment path"
sleep 2
sed -i '/export GOPATH=\$HOME\/gosrc;/d' .bashrc
sed -i '/export GOROOT=\$HOME\/go;/d' .bashrc
sed -i '/export PATH=\$PATH:\$GOROOT\/bin;/d' .bashrc

echo ""
echo "7. Apply the environment path"
sleep 2
. $HOME/.bashrc


echo ""
echo "8. Check if Go is successfully uninstalled or not"
sleep 2
go version
