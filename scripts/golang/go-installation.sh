#!/bin/bash

echo "Go installation script"
sleep 3

echo ""
echo "1. Change direcotry to your home directory"
sleep 3
cd $HOME

echo""
echo -n "Current directory: "
echo $PWD

echo ""
echo "2. Package update"
sleep 3
sudo apt update -y

echo ""
echo "3. Package upgrade"
sleep 3
sudo apt dist-upgrade -y

echo ""
echo "4. Download Go1.15.3"
sleep 3
wget https://dl.google.com/go/go1.15.3.linux-amd64.tar.gz

echo ""
echo "5. Decompress the downloaded file"
sleep 3
tar -xvf go1.15.3.linux-amd64.tar.gz

echo ""
echo "6. Create gosrc directory"
sleep 3
mkdir $HOME/gosrc
echo -n "Current directory: "
echo $PWD

echo ""
echo "7. Set environment path"
sleep 3
echo "" >> .bashrc
echo "export GOPATH=\$HOME/gosrc;" >> .bashrc
echo "export GOROOT=\$HOME/go;" >> .bashrc
echo "export PATH=\$PATH:\$GOROOT/bin;" >> .bashrc

echo ""
echo "8. Apply the environment path"
sleep 3
. $HOME/.bashrc


echo ""
echo "9. Check Go version"
sleep 3
go version
