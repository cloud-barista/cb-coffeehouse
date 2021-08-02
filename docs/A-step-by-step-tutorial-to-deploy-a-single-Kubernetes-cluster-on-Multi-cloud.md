# A tutorial to deploy a single Kubernetes cluster across Multi-clouds

This article provides **a step by step tutorial to deploy a single Kubernetes cluster across Multi-clouds**.
(Can you imagine an interesting point? :wink:)

The figure below shows the brief concept of this tutorial. 
Public CSPs on the bottom provides virtual machines (VMs). 
Cloud-Barista provides the integrated operation and management of resources related to VMs, and also provides an overlay network.
Thus, an user could configure a single Kubernetes cluster across Multi-clouds.

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/127124490-9c66f406-e455-4ad3-91b8-0184ad055157.png" width="80%" height="80%" >
</p>


The figure below depicts the associated Cloud-Barista components from the bottom to the top in order to deploy a Kubernetes cluster across Multi-clouds.

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/127101689-333a1355-c01f-41a7-a879-4310cdc105bc.png" width="80%" height="80%" >
</p>


## 1. Deploy Cloud-Barista's components

At lease 2 nodes are needed.   
In Node 1, a CB-Spider server and a CB-tumblebug server are deployed.   
In Node 2, a cb-network controller and a standalone cluster for the distributed key-value store are deployed.   
NOTE - It is possible to deploy the cb-network controller and the standalone cluster respectively.

### 1.1. Deploy a CB-Spider server in Node 1

CB-Spider is necessary to connect all the clouds with a single interface.
A CB-Spider server can be run in [3 ways](https://github.com/cloud-barista/cb-spider#2-%EC%8B%A4%ED%96%89-%EB%B0%A9%EB%B2%95), of which <ins>**I try to run the server based on container.**</ins>
    
#### 1.1.1. Run a container for CB-Spider server 0.3.19
```bash
sudo su
```
```bash
sudo docker run --rm -p 1024:1024 -p 2048:2048 -v ${HOME}/cloud-barista/cb-spider/meta_db:/root/go/src/github.com/cloud-barista/cb-spider/meta_db --name cb-spider cloudbaristaorg/cb-spider:0.3.19
```

### 1.2. Deploy a CB-Tumblebug server in Node 1

CB-Tumblebug is necessary to deploy and manage multi-cloud infrastructure.
A CB-Tumblebug server also can be run in [3 ways](https://github.com/cloud-barista/cb-tumblebug#cb-tumblebug-%EC%86%8C%EC%8A%A4-%EB%B9%8C%EB%93%9C-%EB%B0%8F-%EC%8B%A4%ED%96%89-%EB%B0%A9%EB%B2%95-%EC%83%81%EC%84%B8), of which <ins>**I try to run the server based on source code.**</ins>

#### 1.2.1. Pre-requisites
##### 1) Login root
```bash
sudo su
```

##### 2) Update Adavanced Packaging Tool (APT)
```bash
apt update
apt install make gcc git
```

##### 3) Install Go
```bash
wget https://raw.githubusercontent.com/cloud-barista/cb-coffeehouse/master/scripts/golang/go-installation.sh
source go-installation.sh
```

#### 1.2.2. Download CB-Tumblebug source code and checkout 0.3.12
```bash
git clone https://github.com/cloud-barista/cb-tumblebug.git ${HOME}/go/src/github.com/cloud-barista/cb-tumblebug
cd ${HOME}/go/src/github.com/cloud-barista/cb-tumblebug
git checkout tags/v0.3.12 -b v0.3.12
```    

#### 1.2.3. Setup environment variables
```bash
cd ${HOME}/go/src/github.com/cloud-barista/cb-tumblebug/conf
source ./setup.env
```

#### 1.2.4. Run a CB-Tumblebug server 0.3.12
```bash
cd ${HOME}/go/src/github.com/cloud-barista/cb-tumblebug/src
make run
```


### 1.3. Deploy a standalone cluster for the distributed key-value store in Node 2

As the pre-requisites of cb-network system, a cluster for the distributed key-value store is needed. 

**A standalone cluster for the distributed key-value store is used for the quick test, <ins>but I recommend you to deploy a multi-member cluster for the distributed key-value store.</ins>** (Scripts for multi-member cluster will be updated later :grin:)

NOTE - **A public IP address** will be needed to access the standalone cluster remotely.       
NOTE - **Port 2379, 2380** must be opened on your firewall setting.

#### 1.3.1. Install Go (You can skip this if you have Go version 1.13+)
```bash
wget https://raw.githubusercontent.com/cloud-barista/cb-coffeehouse/master/scripts/golang/go-installation.sh
source go-installation.sh
```

#### 1.3.2. Download and build etcd
```bash
git clone https://github.com/etcd-io/etcd.git
cd etcd
./build
```

#### 1.3.3. Start etcd
```bash
./bin/etcd
```

#### 1.3.4. Test
```bash
./bin/etcdctl version
```


### 1.4 Deploy cb-network controller in Node 2

CB-Larva tries to provide an overlay network for virtual machines (VMs) across Multi-clouds.

#### 1.4.1. Download CB-Larva source code and checkout 0.0.4
```bash
cd ${HOME}
git clone https://github.com/cloud-barista/cb-larva.git
cd ${HOME}/cb-larva
git checkout tags/v0.0.4 -b v0.0.4
```

#### 1.4.2. Copy and setup configurations ONLY for the cb-network controller

##### 1) Copy templates
```bash
cd ${HOME}/cb-larva/poc-cb-net/config
cp template)config.yaml config.yaml
cp template)log_conf.yaml log_conf.yaml
```

##### 2) Replace "xxx" with your values on `config.yaml`
```yaml
# configs for the both cb-network controller and agent as follows:
etcd_cluster:
endpoints: [ "xxx.xxx.xxx:xxxx" ]

# configs for the cb-network controller as follows:
admin_web:
  host: "xxx" # e.g.) "localhost"
  port: "xxx" # e.g.) "9999"
# configs for the cb-network agent as follows:
cb_network:
  cladnet_id: "ooo"
  host_id: "ooo"

demo_app:
  is_run: false
```

##### 3) (Be able to) use log_conf.yaml as it is
```yaml
#### Config for CB-Log Lib. ####

cblog:
  ## true | false
  loopcheck: true # This temp method for development is busy wait. cf) cblogger.go:levelSetupLoop().

  ## debug | info | warn | error
  loglevel: debug # If loopcheck is true, You can set this online.

  ## true | false
  logfile: false

## Config for File Output ##
logfileinfo:
  filename: ./log/cblogs.log
  #  filename: $CBLOG_ROOT/log/cblogs.log
  maxsize: 10 # megabytes
  maxbackups: 50
  maxage: 31 # days
```

#### 1.4.3. Run cb-network controller (currenly server)
```bash
cd ${HOME}/cb-larva/poc-cb-net/cmd/server
go build server.go
sudo ./server
```

#### 1.4.4. Visit AdminWeb
```
http://[YOUR_PUBLIC_IP_ADDRESS]:[YOUR_ADMIN_WEB_PORT]
```


## 2. Prepare instances across Multi-clouds

### 2.1. Create instances by CB-Tumblebug

Please refer to [(2) CB-Tumblebug 스크립트를 통한 테스트](https://github.com/cloud-barista/cb-tumblebug/blob/main/README.md#2-cb-tumblebug-%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%EB%A5%BC-%ED%86%B5%ED%95%9C-%ED%85%8C%EC%8A%A4%ED%8A%B8)

#### 2.1.1.Prepare credentials

Please refer to ["A step by step guide to creating credentials of each cloud service provider"](https://github.com/cloud-barista/cb-coffeehouse/wiki/A-step-by-step-guide-to-creating-credentials-of-each-cloud-service-provider) provided by Cloud-Barista's coffeehouse (cb-coffeehouse). We hope it will be helpful for you :smile:

##### 1) Copy `credentials.conf.example
```bash
cd ${HOME}/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts
cp credentials.conf.example credentials.conf
```
##### 2) Replace it with your credentials

```bash
vim credentials.conf
```

#### 2.1.2. Prepare a specification to create MCIS

#### 2.1.3 Request a Multi-Cloud Infra Service (MCIS)

### 2.2 Configure an overlay network by CB-Tumblebug and CB-Larva


## 3. deploy a single Kubernetnes cluster across Multi-clouds
### 3.1. Configure a master of Kubernetes

### 3.2. Configure nodes of Kuberentes and then join to the master

### 3.3. Deploy pods as an example