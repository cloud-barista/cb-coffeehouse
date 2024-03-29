#!/bin/bash

GOLANG_VERSION=${1:-no}

if [ "${GOLANG_VERSION}" == "no" ]; then
  GOLANG_VERSION=1.19
fi

echo "Go installation script"
sleep 3

# echo "Step 1: Package update"
# sleep 3
# sudo apt update -y

# echo "Step 2: Package upgrade"
# sleep 3
# sudo apt dist-upgrade -y

echo "Step 1: Download and setup Golang ${GOLANG_VERSION}"
# Install Go
if [ ! -d /usr/local/go ]; then
  wget https://dl.google.com/go/go${GOLANG_VERSION}.linux-amd64.tar.gz
  sudo tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz
  # Set Go env (for next interactive shell)
  echo "export PATH=\${PATH}:/usr/local/go/bin" >> ${HOME}/.bashrc
  echo "export GOPATH=\${HOME}/go" >> ${HOME}/.bashrc
fi

# Set Go env (for current shell)
export PATH=${PATH}:/usr/local/go/bin
export GOPATH=${HOME}/go

echo "Step 2: Check Go version"
go version

echo "Step 3: Clean up materials"
if [ -f ~/go${GOLANG_VERSION}.linux-amd64.tar.gz ]; then
  sudo rm -rf ~/go${GOLANG_VERSION}.linux-amd64.tar.gz
fi
