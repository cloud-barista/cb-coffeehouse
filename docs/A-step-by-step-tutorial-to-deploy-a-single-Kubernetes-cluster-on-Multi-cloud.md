# A tutorial to deploy a single Kubernetes cluster across Multi-clouds

This article provides **a step by step tutorial to deploy a single Kubernetes cluster across Multi-clouds**.
(Can you imagine an interesting point? :wink:)

The figure below shows the brief concept of this tutorial. 
Public CSPs on the bottom provides virtual machines (VMs). 
Cloud-Barista provides the integrated operation and management of resources related to VMs, and also provides an overlay network.
Thus, an user could configure a single Kubernetes cluster across Multi-clouds.

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/127124490-9c66f406-e455-4ad3-91b8-0184ad055157.png" width="90%" height="90%" >
</p>


The figure below depicts the associated Cloud-Barista components from the bottom to the top in order to deploy a Kubernetes cluster across Multi-clouds.

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/127101689-333a1355-c01f-41a7-a879-4310cdc105bc.png" width="90%" height="90%" >
</p>


## 1. Deploy Cloud-Barista's components

At lease 2 nodes are recommended. I newly created 2 instances (nodes) on Amazon Web Services (AWS), and tried this tutorial to make sure it.   
In Node 1, a CB-Spider server and a CB-tumblebug server are deployed.   
In Node 2, a cb-network controller and a standalone cluster for the distributed key-value store are deployed.   
NOTE - It is possible to deploy the cb-network controller and the standalone cluster respectively.

### 1.1. Deploy a CB-Spider server in Node 1

CB-Spider is necessary to connect all the clouds with a single interface.
A CB-Spider server can be run in 3 ways, of which <ins>**I try to run the server based on container.**</ins>

**<ins> See more ideas :arrow_forward: [CB-Spider README](https://github.com/cloud-barista/cb-spider)</ins>**

#### 1.1.1. Pre-requisites
##### 1) Login root
```bash
sudo su
cd ~
```
##### 2) Install Docker
```
wget https://raw.githubusercontent.com/hermitkim1/scripts4Ubuntu/master/2.Docker-installation.sh
source 2.Docker-installation.sh
```

#### 1.1.2. Run a container for CB-Spider server 0.3.19
```bash
sudo docker run --rm -p 1024:1024 -p 2048:2048 -v ${HOME}/cloud-barista/cb-spider/meta_db:/root/go/src/github.com/cloud-barista/cb-spider/meta_db --name cb-spider cloudbaristaorg/cb-spider:0.3.19
```

### 1.2. Deploy a CB-Tumblebug server in Node 1

CB-Tumblebug is necessary to deploy and manage multi-cloud infrastructure.
A CB-Tumblebug server also can be run in 3 ways, of which <ins>**I try to run the server based on source code.**</ins>

**<ins> See more ideas :arrow_forward: [CB-Tumblebug README](https://github.com/cloud-barista/cb-tumblebug)</ins>**

#### 1.2.1. Pre-requisites
##### 1) Open another terminal of Node 1
##### 2) Login root
```bash
sudo su
cd ~
```

##### 3) Update Adavanced Packaging Tool (APT)
```bash
apt update
apt install make gcc git -y
```

##### 4) Install Go
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

#### 1.2.4. Build a CB-Tumblebug server 0.3.12
```bash
cd ${HOME}/go/src/github.com/cloud-barista/cb-tumblebug/src
make
```

#### 1.2.5. Run a CB-Tumblebug server 0.3.12
```bash
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

For remote access, `--advertise-client-urls` and `--listen-client-urls` must be setup.   
And also, replace `[PUBLIC_IP_OF_NODE_2]` with a public IP of Node 2.
```bash
./bin/etcd --advertise-client-urls http://[PUBLIC_IP_OF_NODE_2]:2379 --listen-client-urls http://0.0.0.0:2379
```
#### 1.3.4. Open another terminal of Node 2

#### 1.3.5. Check if it is running
```bash
cd ~/etcd
./bin/etcdctl version
```


### 1.4. Deploy cb-network controller in Node 2

CB-Larva tries to provide an overlay network for virtual machines (VMs) across Multi-clouds.

**<ins> See more ideas :arrow_forward: [CB-Larva README](https://github.com/cloud-barista/cb-larva)</ins>**

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
cd ${HOME}/cb-larva/poc-cb-net/configs
cp template\)config.yaml config.yaml
cp template\)log_conf.yaml log_conf.yaml
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


## 2. Prepare instances across Multi-clouds in Node 1

### 2.1. Create instances by CB-Tumblebug

Please refer to [(2) CB-Tumblebug 스크립트를 통한 테스트](https://github.com/cloud-barista/cb-tumblebug/blob/main/README.md#2-cb-tumblebug-%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%EB%A5%BC-%ED%86%B5%ED%95%9C-%ED%85%8C%EC%8A%A4%ED%8A%B8)

#### 2.1.1. Prepare credentials

##### 1) Create credentials of each CSPs

Please refer to ["A step by step guide to creating credentials of each cloud service provider"](https://github.com/cloud-barista/cb-coffeehouse/wiki/A-step-by-step-guide-to-creating-credentials-of-each-cloud-service-provider) provided by Cloud-Barista's coffeehouse (cb-coffeehouse). We hope it will be helpful for you :smile:

##### 2) Open another terminal of Node 1
##### 3) Login root
```bash
sudo su
```

##### 4) Copy `credentials.conf.example`
```bash
cd ${HOME}/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts
cp credentials.conf.example credentials.conf
```
##### 5) Replace it with your credentials

```bash
vim credentials.conf
```

#### 2.1.2. Prepare a specification to create a group of instances

`testSet.env` provides the useful, investigated information in each cloud. 
With this, it's possible to create a specification to create a group of instances (i.e., MCIS, Multi-Cloud Infra Service).

Before creating a specification, I'd like to describe several things in `testSet.env`.

You can specify the number of CSPs you consider.   
For example, if `NumbCSP=2`, 2 CSPs will be used.
```bash
## Number of CSP types and corresponding regions
NumCSP=2
```

By the `NumCSP`, the blow list will be sequantially accessed from the top.   
For example, if you want to use AWS and GCP, `IndexAWS=$((++IX))` and `IndexGCP=$((++IX))` should be located at 1st and 2nd line.
```bash
## Define sequential test order for cloud types 
# Note: you can change order by replacing lines (automatically assign continuous numbers starting from 1)
IX=0
IndexAWS=$((++IX))
IndexAzure=$((++IX))
IndexGCP=$((++IX))
IndexAlibaba=$((++IX))
IndexMock=$((++IX))
IndexOpenstack=$((++IX))
IndexNCP=$((++IX))
IndexCloudTwin=$((++IX))
IndexCloudit=$((++IX))
IndexTencent=$((++IX))
```

You can specify the number of regions in a CSP.  
For example, if `NumRegion[$IndexAWS]=2`, 2 regions will be used.
```bash
## Test setting for Regions of Cloud types 
# Note: you can change order by replacing lines (automatically assign continuous numbers starting from 1)

# AWS (Total: 21 Regions / Recommend: 20 Regions)
NumRegion[$IndexAWS]=2
```

By the `NumRegion[$IndexAWS]`, the blow list will be sequantially accessed from the top.   
For example, if you want to use `AwsApSoutheast1` and `AwsUsWest1`, `AwsApSoutheast1=$((++IY))			# Location: Asia Pacific (Singapore)` and `AwsUsWest1=$((++IY))				# Location: US West (N. California)` should be located at 1st and 2nd line.
```bash
IY=0
AwsApSoutheast1=$((++IY))                 # Location: Asia Pacific (Singapore)
AwsCaCentral1=$((++IY))                   # Location: Canada (Central)
AwsUsWest1=$((++IY))                      # Location: US West (N. California)
AwsUsEast1=$((++IY))                      # Location: US East (N. Virginia)
AwsApNortheast1=$((++IY))                 # Location: Asia Pacific (Tokyo)
AwsApSouth1=$((++IY))                     # Location: Asia Pacific (Mumbai)
AwsApSoutheast2=$((++IY))                 # Location: Asia Pacific (Sydney)
AwsEuWest2=$((++IY))                      # Location: Europe (London)
AwsUsEast2=$((++IY))                      # Location: US East (Ohio)
AwsUsWest2=$((++IY))                      # Location: US West (Oregon)
AwsApNortheast3=$((++IY))                 # Location: Asia Pacific (Osaka)
AwsEuCentral1=$((++IY))                   # Location: Europe (Frankfurt)
AwsEuWest1=$((++IY))                      # Location: Europe (Ireland)
AwsEuWest3=$((++IY))                      # Location: Europe (Paris)
AwsEuNorth1=$((++IY))                     # Location: Europe (Stockholm) - No t2.xxx Specs. t3 c5 m5 r5 .. are availble
AwsSaEast1=$((++IY))                      # Location: South America (São Paulo)
AwsApNortheast2=$((++IY))                 # Location: Asia Pacific (Seoul)
AwsApEast1=$((++IY))                      # Location: Asia Pacific (Hong Kong)  -  Opt-In required
AwsMeSouth1=$((++IY))                     # Location: Middle East (Bahrain)  -  Opt-In required
AwsAfSouth1=$((++IY))                     # Location: Africa (Cape Town)  -  Opt-In required
AwsEuSouth1=$((++IY))                     # Location: Europe (Milan)  -  Opt-In required
```

In the same manner, you can specify regions and the number of regions for the other CSPs. :smile:


From now on, I'm going to create my specification as follows:
- 1 instance, ap-southeast-1 region, Amazon Web Services (AWS),
- 1 instance, asia-east1 region, Google Cloud Platform (GCP), and
- 1 instance, West US region, Microsoft Azure (MS Azure).

##### 1) Copy `testSet.env`
```bash
cd ${HOME}/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts
cp testSet.env testSetAMG.env
```
##### 2) Modify `testSetAMG.env` as follows

<details>
<summary>Click to expand</summary>
<p>

```bash
#!/bin/bash

## MCIS name prefix text
MCISPREFIX=mcis

## MCIS monitoring agent install. [yes or no]
AgentInstallOn=no

## Number of CSP types and corresponding regions
NumCSP=3

## Define sequential test order for cloud types
# Note: you can change order by replacing lines (automatically assign continuous numbers starting from 1)
IX=0
IndexAWS=$((++IX))
IndexAzure=$((++IX))
IndexGCP=$((++IX))
IndexAlibaba=$((++IX))

IndexMock=$((++IX))
IndexOpenstack=$((++IX))
IndexNCP=$((++IX))
IndexCloudTwin=$((++IX))


## Designated strings for Cloud types
# Note: don't need to touch unless you are adding new Cloud type
CSPType[$IndexAWS]=aws
CSPType[$IndexAlibaba]=alibaba
CSPType[$IndexGCP]=gcp
CSPType[$IndexAzure]=azure
CSPType[$IndexMock]=mock
CSPType[$IndexOpenstack]=openstack
CSPType[$IndexNCP]=ncp
CSPType[$IndexCloudTwin]=cloudtwin


## Test setting for Regions of Cloud types
# Note: you can change order by replacing lines (automatically assign continuous numbers starting from 1)

# AWS (Total: 21 Regions / Recommend: 20 Regions)
NumRegion[$IndexAWS]=1

IY=0
AwsApSoutheast1=$((++IY))                 # Location: Asia Pacific (Singapore)
AwsApSoutheast2=$((++IY))                 # Location: Asia Pacific (Sydney)
AwsEuWest2=$((++IY))                      # Location: Europe (London)
AwsEuCentral1=$((++IY))                   # Location: Europe (Frankfurt)
AwsApNortheast1=$((++IY))                 # Location: Asia Pacific (Tokyo)
AwsCaCentral1=$((++IY))                   # Location: Canada (Central)
AwsUsWest1=$((++IY))                      # Location: US West (N. California)
AwsUsEast1=$((++IY))                      # Location: US East (N. Virginia)
AwsApSouth1=$((++IY))                     # Location: Asia Pacific (Mumbai)
AwsUsEast2=$((++IY))                      # Location: US East (Ohio)
AwsUsWest2=$((++IY))                      # Location: US West (Oregon)
AwsApNortheast3=$((++IY))                 # Location: Asia Pacific (Osaka)
AwsEuWest1=$((++IY))                      # Location: Europe (Ireland)
AwsEuWest3=$((++IY))                      # Location: Europe (Paris)
AwsEuNorth1=$((++IY))                     # Location: Europe (Stockholm) - No t2.xxx Specs. t3 c5 m5 r5 .. are availble
AwsSaEast1=$((++IY))                      # Location: South America (São Paulo)
AwsApNortheast2=$((++IY))                 # Location: Asia Pacific (Seoul)
AwsApEast1=$((++IY))                      # Location: Asia Pacific (Hong Kong)  -  Opt-In required
AwsMeSouth1=$((++IY))                     # Location: Middle East (Bahrain)  -  Opt-In required
AwsAfSouth1=$((++IY))                     # Location: Africa (Cape Town)  -  Opt-In required
AwsEuSouth1=$((++IY))                     # Location: Europe (Milan)  -  Opt-In required



# Alibaba (Total: 23 Regions / Recommend: 8 Regions)
NumRegion[$IndexAlibaba]=1

IY=0
AlibabaApSoutheast2=$((++IY))             # Location: Australia (Sydney) [zone:a,b]
AlibabaApNortheast1=$((++IY))             # Location: Japan (Tokyo)
AlibabaApSouth1=$((++IY))                 # Location: Mumbai Zone A
AlibabaApSoutheast1=$((++IY))             # Location: Singapore [zone:a,b,c]
AlibabaApSoutheast3=$((++IY))             # Location: Malaysia (Kuala Lumpur) [zone:a,b]
AlibabaApSoutheast5=$((++IY))             # Location: Indonesia (Jakarta) [zone:a,b]
AlibabaUsWest1=$((++IY))                  # Location: US (Silicon Valley) [zone:a,b]
AlibabaUsEast1=$((++IY))                  # Location: US (Virginia) [zone:a,b]
AlibabaEuCentral1=$((++IY))               # Location: Germany (Frankfurt) [zone:a,b] - ERR: Unable to get GetVMSpec - context deadline exceeded
AlibabaEuWest1=$((++IY))                  # Location: UK (London) [zone:a,b] - ERR: Unable to get GetVMSpec - context deadline exceeded
AlibabaMeEast1=$((++IY))                  # Location: UAE (Dubai) [zone:a] - Few VM Specs are available
AlibabaCnHongkong=$((++IY))               # Location: China (Hong Kong) [zone:b,c] - NEED TO CHECK NETWORK OUTBOUND
AlibabaCnShanghai=$((++IY))               # Location: China (Shanghai) - NEED TO CHECK NETWORK OUTBOUND
AlibabaCnBeijing=$((++IY))                # Location: China (Beijing) - NEED TO CHECK NETWORK OUTBOUND
AlibabaCnQingdao=$((++IY))                # Location: China (Qingdao) - NEED TO CHECK NETWORK OUTBOUND
AlibabaCnZhangjiakou=$((++IY))            # Location: China (Zhangjiakou) - NEED TO CHECK NETWORK OUTBOUND
AlibabaCnHuhehaote=$((++IY))              # Location: China (Hohhot) - NEED TO CHECK NETWORK OUTBOUND
AlibabaCnHangzhou=$((++IY))               # Location: China (Hangzhou) - NEED TO CHECK NETWORK OUTBOUND
AlibabaCnShenzhen=$((++IY))               # Location: China (Shenzhen) - NEED TO CHECK NETWORK OUTBOUND
AlibabaCnHeyuan=$((++IY))                 # Location: China (Heyuan) - NEED TO CHECK NETWORK OUTBOUND
AlibabaCnChengdu=$((++IY))                # Location: China (Chengdu) - NEED TO CHECK NETWORK OUTBOUND
AlibabaCnWulanchabu=$((++IY))             # Location: China (Ulanqab) - ERR: InvalidSystemDiskCategory.ValueNotSupported - NEED TO CHECK NETWORK OUTBOUND. no ecs.t5 available.
AlibabaCnGuangzhou=$((++IY))              # Location: China (Guangzhou) - NEED TO CHECK NETWORK OUTBOUND. no ecs.t5 available.



# GCP (Total: 25 Regions / Recommend: 22 Regions)
NumRegion[$IndexGCP]=1

IY=0
GcpAsiaEast1=$((++IY))                    # Location: Changhua County  Taiwan
GcpAustraliaSoutheast1=$((++IY))          # Location: Sydney  Australia
GcpEuropeWest2=$((++IY))                  # Location: London  England  UK
GcpAsiaNortheast1=$((++IY))               # Location: Tokyo  Japan
GcpEuropeWest3=$((++IY))                  # Location: Frankfurt  Germany
GcpAsiaEast2=$((++IY))                    # Location: Hong Kong
GcpAsiaNortheast2=$((++IY))               # Location: Osaka  Japan
GcpAsiaNortheast3=$((++IY))               # Location: Seoul  South Korea
GcpUsWest4=$((++IY))                      # Location: Las Vegas  Nevada  USA
GcpAsiaSoutheast1=$((++IY))               # Location: Jurong West  Singapore
GcpEuropeNorth1=$((++IY))                 # Location: Hamina  Finland
GcpEuropeWest1=$((++IY))                  # Location: St. Ghislain  Belgium
GcpEuropeWest4=$((++IY))                  # Location: Eemshaven  Netherlands
GcpEuropeWest6=$((++IY))                  # Location: Zurich  Switzerland
GcpNorthamericaNortheast1=$((++IY))       # Location: Montreal  Quebec  Canada
GcpSouthamericaEast1=$((++IY))            # Location: Osasco (Sao Paulo)  Brazil
GcpUsWest2=$((++IY))                      # Location: Los Angeles  California  USA
GcpUsCentral1=$((++IY))                   # Location: Council Bluffs  Iowa  USA
GcpUsEast1=$((++IY))                      # Location: Moncks Corner  South Carolina  USA
GcpUsEast4=$((++IY))                      # Location: Ashburn  Northern Virginia  USA
GcpUsWest1=$((++IY))                      # Location: The Dalles  Oregon  USA
GcpUsWest3=$((++IY))                      # Location: Salt Lake City  Utah  USA
GcpAsiaSouth1=$((++IY))                   # Location: Mumbai  India (zone b since zone a returns QUOTA_EXCEEDED)
GcpAsiaSoutheast2=$((++IY))               # Location: Jakarta, Indonesia, APAC
GcpEuropeCentral2=$((++IY))               # Location: Warsaw, Poland, Europe




# Azure (Total: 40 Regions / Recommend: 34 Regions)
NumRegion[$IndexAzure]=1

IY=0
AzureWestus=$((++IY))                     # Location: West US
AzureEastus=$((++IY))                     # Location: East US
AzureNortheurope=$((++IY))                # Location: North Europe
AzureWesteurope=$((++IY))                 # Location: West Europe
AzureEastasia=$((++IY))                   # Location: East Asia
AzureSoutheastasia=$((++IY))              # Location: Southeast Asia
AzureNorthcentralus=$((++IY))             # Location: North Central US
AzureSouthcentralus=$((++IY))             # Location: South Central US
AzureCentralus=$((++IY))                  # Location: Central US
AzureEastus2=$((++IY))                    # Location: East US 2
AzureJapaneast=$((++IY))                  # Location: Japan East
AzureJapanwest=$((++IY))                  # Location: Japan West
AzureBrazilsouth=$((++IY))                # Location: Brazil South
AzureAustraliaeast=$((++IY))              # Location: Australia East
AzureAustraliasoutheast=$((++IY))         # Location: Australia Southeast
AzureCentralindia=$((++IY))               # Location: Central India
AzureCanadacentral=$((++IY))              # Location: Canada Central
AzureCanadaeast=$((++IY))                 # Location: Canada East
AzureWestcentralus=$((++IY))              # Location: West Central US
AzureWestus2=$((++IY))                    # Location: West US 2
AzureUkwest=$((++IY))                     # Location: UK West
AzureUksouth=$((++IY))                    # Location: UK South
AzureKoreacentral=$((++IY))               # Location: Korea Central
AzureKoreasouth=$((++IY))                 # Location: Korea South
AzureFrancecentral=$((++IY))              # Location: France Central
AzureAustraliacentral=$((++IY))           # Location: Australia Central
AzureSouthafricanorth=$((++IY))           # Location: South Africa North
AzureUaenorth=$((++IY))                   # Location: UAE North
AzureSwitzerlandnorth=$((++IY))           # Location: Switzerland North
AzureGermanywestcentral=$((++IY))         # Location: Germany West Central
AzureNorwayeast=$((++IY))                 # Location: Norway East

AzureSouthindia=$((++IY))                 # Location: South India (not recommend) ERR: not subscribed by default
AzureWestindia=$((++IY))                  # Location: West India (not recommend) ERR: not subscribed by default
# Azurejioindiawest


AzureSouthafricawest=$((++IY))            # Location: South Africa West (not recommend)
AzureSwitzerlandwest=$((++IY))            # Location: Switzerland West (not recommend)
AzureGermanynorth=$((++IY))               # Location: Germany North (not recommend)
AzureUaecentral=$((++IY))                 # Location: UAE Central (not recommend)
AzureNorwaywest=$((++IY))                 # Location: Norway West (not recommend)
AzureFrancesouth=$((++IY))                # Location: France South (not recommend)
AzureAustraliacentral2=$((++IY))          # Location: Australia Central 2 (not recommend. not support vm service)



# Mock (Total: 1 Regions / Recommend: 1 Regions)
NumRegion[$IndexMock]=1

IY=0
MockSeoul=$((++IY))                       # Location: Korea Seoul (Virtual)



# Openstack (Total: 1 Regions / Recommend: 1 Regions)
NumRegion[$IndexOpenstack]=1

IY=0
OpenstackRegion01=$((++IY))               # Location: Korea Daejeon (Internal)



# NCP (Total: 5 Regions / Recommend: ? Regions / Not tested yet)
NumRegion[$IndexNCP]=5

IY=0
NcpKorea1=$((++IY))                       # Location: NCP Korea
NcpUsWestern=$((++IY))                    # Location: NCP US West
NcpGermany=$((++IY))                      # Location: NCP Germany
NcpSingapore=$((++IY))                    # Location: NCP Singapore
NcpJapan=$((++IY))                        # Location: NCP Japan



# Cloud-Twin (Total: 1 Regions / Recommend: 1 Regions)
NumRegion[$IndexCloudTwin]=1

IY=0
CloudTwinRegion01=$((++IY))               # Location: Korea Daejeon (Internal)

```
</p>
</details>  

#### 2.1.3 Request instances to multiple CSPs by CB-Tumblebug

<ins>**PRECONDITION: In the section 2.1.1, credentials of AWS, MS Azure, and GCP have been setup.**</ins>

##### 1) Go to `sequentialFullTest` directory
```bash
cd ${HOME}/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts/sequentialFullTest
```
##### 2) Request instances by a client test script of CB-Tumblebug
Thanks to CB-Spider and CB-Tumblebug :pray:, it's possible to test all at once, such as "cloud information registration", "namespace creation", "Multi-Cloud Infra Resource (MCIR) generation", and "Multi-Cloud Infra Service (MCIS) generation".

Meaning:
- `all`: all specified CSPs
- `1`: no meaning here (it will be updated)
- `kimyk01`: a developer name (recommend you to add an incremental number for testing)
- `../testsetAMG.env`: a specification for this trial
```bash
./create-all.sh all 1 kimyk01 ../testSetAMG.env
```

##### 3) Check if the instances are created properly
Please check the result below
```bash
    "status": "Running-3(3/3)",
```


### 2.2. Configure an overlay network by CB-Tumblebug and CB-Larva

#### 2.2.1. Prepare a script to deploy cb-network agent

#### 1) Create `deploy-cb-network-agent-in-background.sh` with the content below

<details>
<summary>Click to expand</summary>
<p>

```bash
#!/bin/bash

# Set duration timer to 0
SECONDS=0

# Install jq if the jq package doesn't exist
echo "[Check jq package (if not, install)]"
if ! dpkg-query -W -f='${Status}' jq | grep "ok installed"; then sudo apt install -y jq; fi


# tesetSet.env is default test set.
# If the 4th parameter exists, use the test set.
# Check if the one of the test sets exists or not
TestSetFile=${4:-../testSet.env}
if [ ! -f "$TestSetFile" ]; then
        echo "$TestSetFile does not exist."
        exit
fi
source $TestSetFile
source ../conf.env

echo "####################################################################"
echo "## Command (SSH) to MCIS to run cb-network agent"
echo "####################################################################"

CSP=${1}
REGION=${2:-1}
POSTFIX=${3:-developer}
ETCD_HOSTS=${5:-no}
CLADNET_ID=${6:-no}

#if [ "${ETCD_HOSTS}" == "no" ]; then
#        echo "ETCD_HOSTS parameter is needed."
#        exit
#fi

#if [ "${CLADNET_ID}" == "no" ]; then
#        echo "CLADNET_ID paramater is needed."
#        exit
#fi

source ../common-functions.sh
getCloudIndex $CSP

MCISID=${CONN_CONFIG[$INDEX,$REGION]}-${POSTFIX}

if [ "${INDEX}" == "0" ]; then
        # MCISPREFIX=avengers
        MCISID=${MCISPREFIX}-${POSTFIX}
fi

# Get MCIS information
MCISINFO=$(curl -H "${AUTH}" -sX GET http://$TumblebugServer/tumblebug/ns/$NSID/mcis/${MCISID})
# Parse VM list
VMARRAY=$(jq -r '.vm' <<<"$MCISINFO")

for row in $(echo "${VMARRAY}" | jq -r '.[] | @base64'); do
        _jq() {
                echo ${row} | base64 --decode | jq -r ${1}
        }

    VMID=$(_jq '.id')
        connectionName=$(_jq '.connectionName')
    publicIP=$(_jq '.publicIP')
    cloudType=$(_jq '.location.cloudType')

    echo "VMID: $VMID"
    echo "connectionName: $connectionName"
    echo "publicIP: $publicIP"

    getCloudIndexGeneral $cloudType

#    ChangeHostCMD="sudo hostnamectl set-hostname ${GeneralINDEX}-${connectionName}-${publicIP}; sudo hostname -f"
    BuildAndRunCBNetworkAgentCMD="wget https://raw.githubusercontent.com/cloud-barista/cb-larva/main/poc-cb-net/scripts/build-and-run-agent-in-the-background.sh -O ~/build-and-run-agent-in-the-background.sh; chmod +x ~/build-and-run-agent-in-the-background.sh; ~/build-and-run-agent-in-the-background.sh '${ETCD_HOSTS}' ${CLADNET_ID} ${VMID}"
    echo "CMD: ${BuildAndRunCBNetworkAgentCMD}"
    ./command-mcis-vm-custom.sh "${1}" "${2}" "${3}" "${4}" "${VMID}" "${BuildAndRunCBNetworkAgentCMD}" &
#VAR1=$(
#       curl -H "${AUTH}" -sX POST http://$TumblebugServer/tumblebug/ns/$NSID/cmd/mcis/$MCISID/vm/$VMID -H 'Content-Type: application/json' -d @- <<EOF
#       {
#       "command"        : "${BuildAndRunCBNetworkAgentCMD}"
#       }
#EOF
#)
#echo "${VAR1}" | jq ''

done
wait

echo "Done!"
duration=$SECONDS

printElapsed $@
echo ""

./command-mcis.sh "$@"

```
</p>
</details>  

```bash
cd ${HOME}/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts/sequentialFullTest
vim deploy-cb-network-agent-in-background.sh
```

##### 2) Change mode
```
chmod 775 deploy-cb-network-agent-in-background.sh
```

#### 2.2.2. Create a network CIDR block 
##### 1) Access the AdminWeb
```
http://[YOUR_PUBLIC_IP_ADDRESS]:[YOUR_ADMIN_WEB_PORT]
```
##### 2) Go to the section `Create you CLADNet: Cloud Adaptive Network`
##### 3) Create a CLADNet
Example: 
- Network(IPv4 CIDR block): 192.168.10.0/26 (It should be in range of private network.)
- Description: MyCLADNet01
##### 4) Get a CLADNet ID

#### 2.2.3. Deploy cb-network agent to instances in an MCIS
```bash
cd ${HOME}/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts/sequentialFullTest
```

Modify `xxx.xxx.xxx.xxx`(The endpoint of Node 2) and `xxxxxxxxxxxxxxxxxxxxx` (CLADNet ID) below
```bash
./deploy-cb-network-agent-in-background.sh all 1 kimyk01 ../testSetAMG.env '[\"xxx.xxx.xxx.xxx:2379\"]' xxxxxxxxxxxxxxxxxxxxx
```

#### 2.2.4. Check if the overlay network is configured or not on the AdminWeb
##### 1) Go to the section `The CLADNet status: connectivity and latency`
##### 2) Select the CLADNet ID and set the trial count
##### 3) Click execute button and earn the status result



## 3. Deploy a single Kubernetnes cluster across Multi-clouds
<ins>**As a user**</ins>, all scripts in `~/cb-larva/scripts/Kubernetes` directory can be run.
<ins>One reboot will be required.</ins>

Currently, all steps below can be done manually :sweat_smile: :pray:

### 3.1. Generate SSH keys of all instances by CB-Tumblebug
##### 1) Go to the CB-Tumblebug's script directory in Node 1
```bash
cd ${HOME}/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts/sequentialFullTest
```

##### 2) Check the execution status to avoid mistake
```bash
cat executionStatus
```
You could see somthing like `all 1 kimyk01 ../testSetAMG.env`. It is important.

##### 3) Generates SSH keys
```
./gen-sshKey.sh all 1 kimyk01 ../testSetAMG.env
```

### 3.2. Setup environment and tools to all nodes for Kubernetes cluster
##### 1) Access nodes by the generated keys respectively
##### 2) Get scripts from CB-Larva repository
```
cd ~
git clone https://github.com/cloud-barista/cb-larva.git
cd ~/cb-larva/scripts/Kubernetes
```
##### 3) Run a script
```
source 1.setup-environment-and-tools.sh
```
##### 4) Reboot
```
sudo reboot now
```

### 3.3. Configure the Kubernetes master
##### 1) Access to the master
##### 2) Run a script
```
cd ~/cb-larva/scripts/Kubernetes
source 2.setup-K8s-master.sh
```

##### 3) Copy a join command for the next step
For example:
```
kubeadm join 192.168.10.2:6443 --token 10no39.n7tziepyfbsfawgz \
        --discovery-token-ca-cert-hash sha256:b56ed81714c7395cc374644415a428f4ac7ce73863530a4c1e61ff829c30b805
```

### 3.4. Configure Kubernetes nodes
##### 1) Access to a Kubernetes node
##### 2) Execute the join command
NOTE - `sudo` is required.
##### 3) Repeat 1) - 2) on the other nodes

### 3.5. Check the cluster status on the Kubernetes master
```
cd ~/cb-larva/scripts/Kubernetes
source 3.check-K8s-status.sh
```

## 4. Deploy pods as an example

### 4.1. Example: Deploying PHP Guestbook application with Redis

I would like to express all my gratitude to the author and contributors :heart:

References:
- [Example: Deploying PHP Guestbook application with Redis](https://kubernetes.io/docs/tutorials/stateless-application/guestbook/)
- [예시: Redis를 사용한 PHP 방명록 애플리케이션 배포하기](https://kubernetes.io/ko/docs/tutorials/stateless-application/guestbook/)

[TBD] Figure: it's system structure

#### 4.1.1. Start up the Redis Database 
##### 1) Creating the Redis Deployment
```bash
kubectl apply -f https://k8s.io/examples/application/guestbook/redis-leader-deployment.yaml
```
##### 2) Creating the Redis leader Service
```bash
kubectl apply -f https://k8s.io/examples/application/guestbook/redis-leader-service.yaml
```
##### 3) Set up Redis followers
```bash
kubectl apply -f https://k8s.io/examples/application/guestbook/redis-follower-deployment.yaml
```
##### 4) Creating the Redis follower service 
```bash
kubectl apply -f https://k8s.io/examples/application/guestbook/redis-follower-service.yaml
```

#### 4.1.2. Set up and Expose the Guestbook Frontend 
##### 1) Creating the Guestbook Frontend Deployment
```bash
kubectl apply -f https://k8s.io/examples/application/guestbook/frontend-deployment.yaml
```
##### 2) Creating the Frontend Service 

:exclamation: <ins>**A little update is required here,**</ins> for the quick and easy test :smile:

The last line, `type: NodePort`, is added.
```yaml
# SOURCE: https://cloud.google.com/kubernetes-engine/docs/tutorials/guestbook
apiVersion: v1
kind: Service
metadata:
  name: frontend
  labels:
    app: guestbook
    tier: frontend
spec:
  # if your cluster supports it, uncomment the following to automatically create
  # an external load-balanced IP for the frontend service.
  # type: LoadBalancer
  #type: LoadBalancer
  ports:
    # the port that this service should serve on
  - port: 80
  selector:
    app: guestbook
    tier: frontend
  type: NodePort
```

Create `frontend-service-with-node-port.yaml` with the above content
```bash
vim frontend-service-with-node-port.yaml
```

```bash
kubectl apply -f frontend-service-with-node-port.yaml
```

#### 4.1.3. Check if Guestbook application is running

You can access the frontend by `http://[PUBLIC_IP_OF_A_NODE]:[PORT]`.

I'm sure you already have a list of the public IP for Kubernetes cluster.
(If not, you can find it on AdminWeb of cb-network :smile:)

You can find the port as follows:

```bash
kubectl get services
```

In here, the port is `32291`
```bash
NAME             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
frontend         NodePort    10.100.202.25    <none>        80:32291/TCP   74m
kubernetes       ClusterIP   10.96.0.1        <none>        443/TCP        154m
redis-follower   ClusterIP   10.102.170.131   <none>        6379/TCP       149m
redis-leader     ClusterIP   10.99.5.243      <none>        6379/TCP       150m
```

#### 4.1.4. Result

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/127101689-333a1355-c01f-41a7-a879-4310cdc105bc.png" width="90%" height="90%" >
</p>


### 4.2. Example: Deploying Weave Scope

xxxx

#### 4.2.1. Start up Weave Scope
##### 1) Deploy Weave Scope
```bash
kubectl apply -f 'https://cloud.weave.works/launch/k8s/weavescope.yaml?k8s-service-type=NodePort'
```

##### 2) Check if Weave Scope is running

You can access the frontend by `http://[PUBLIC_IP_OF_A_NODE]:[PORT]`.

If you don't know a public IP of a node, you can find it on AdminWeb of cb-network.

You can find the port as follows:

```bash
kubectl get service -n weave
```

In here, the port is `30439`
```bash
NAME              TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
weave-scope-app   NodePort   10.111.120.5   <none>        80:30439/TCP   18s
```

#### 4.2.2. Result

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/128309030-15042dbc-7991-4022-94e6-efa171cdbc76.png" width="90%" height="90%" >
</p>


---

## Appendix
### 1. Overall information
#### 1.1. Instances across Multi-clouds and Cloud Adaptive Network

Networking Rules for Cloud Adpative Network

|     Host ID    | Host IP CIDR Block | Host IP Address |    Public IP   |
|:--------------:|:------------------:|:---------------:|:--------------:|
|  aws-ap-se-1-0 |   192.168.10.2/28  |   192.168.10.2  |  13.212.92.36  |
| gcp-as-east1-0 |   192.168.10.3/28  |   192.168.10.3  | 35.201.166.112 |
|    az-wus-0    |   192.168.10.4/28  |   192.168.10.4  |  13.64.168.164 |

#### 1.2. Interface configuration
##### 1) aws-ap-se-1-0
```bash
ifconfig
```
<details>
<summary>Click to expand</summary>
<p>

```bash
cali20065a4bf18: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 8981
        inet6 fe80::ecee:eeff:feee:eeee  prefixlen 64  scopeid 0x20<link>
        ether ee:ee:ee:ee:ee:ee  txqueuelen 0  (Ethernet)
        RX packets 7957  bytes 673232 (673.2 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 9436  bytes 6702093 (6.7 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

cali9e3f2c2b44c: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::ecee:eeff:feee:eeee  prefixlen 64  scopeid 0x20<link>
        ether ee:ee:ee:ee:ee:ee  txqueuelen 0  (Ethernet)
        RX packets 12776  bytes 1300240 (1.3 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 13042  bytes 1283178 (1.2 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

calie2a64becc96: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::ecee:eeff:feee:eeee  prefixlen 64  scopeid 0x20<link>
        ether ee:ee:ee:ee:ee:ee  txqueuelen 0  (Ethernet)
        RX packets 12805  bytes 1304445 (1.3 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 12921  bytes 1276877 (1.2 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

cbnet0: flags=4305<UP,POINTOPOINT,RUNNING,NOARP,MULTICAST>  mtu 1300
        inet 192.168.10.2  netmask 255.255.255.240  destination 192.168.10.2
        inet6 fe80::9c40:d9c4:a862:6809  prefixlen 64  scopeid 0x20<link>
        unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  txqueuelen 500  (UNSPEC)
        RX packets 76737  bytes 17008849 (17.0 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 76582  bytes 49563213 (49.5 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:ec:92:65:b7  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 9001
        inet 192.168.2.152  netmask 255.255.255.0  broadcast 192.168.2.255
        inet6 fe80::406:c7ff:fe7b:97c4  prefixlen 64  scopeid 0x20<link>
        ether 06:06:c7:7b:97:c4  txqueuelen 1000  (Ethernet)
        RX packets 377349  bytes 439316860 (439.3 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 111593  bytes 65963448 (65.9 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 1772987  bytes 321635217 (321.6 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1772987  bytes 321635217 (321.6 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

tunl0: flags=193<UP,RUNNING,NOARP>  mtu 8981
        inet 10.77.182.64  netmask 255.255.255.255
        tunnel   txqueuelen 1000  (IPIP Tunnel)
        RX packets 35243  bytes 12245454 (12.2 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 25039  bytes 28128676 (28.1 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```
</p>
</details>

##### 2) gcp-as-east1-0
```bash
ifconfig
```
<details>
<summary>Click to expand</summary>
<p>

```bash
cali2016913df02: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1440
        inet6 fe80::ecee:eeff:feee:eeee  prefixlen 64  scopeid 0x20<link>
        ether ee:ee:ee:ee:ee:ee  txqueuelen 0  (Ethernet)
        RX packets 144  bytes 16165 (16.1 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 138  bytes 17223 (17.2 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

cali2707d9a9525: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1440
        inet6 fe80::ecee:eeff:feee:eeee  prefixlen 64  scopeid 0x20<link>
        ether ee:ee:ee:ee:ee:ee  txqueuelen 0  (Ethernet)
        RX packets 188  bytes 21788 (21.7 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 178  bytes 21001 (21.0 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

cali4b11e323c22: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1440
        inet6 fe80::ecee:eeff:feee:eeee  prefixlen 64  scopeid 0x20<link>
        ether ee:ee:ee:ee:ee:ee  txqueuelen 0  (Ethernet)
        RX packets 23327  bytes 1563383 (1.5 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 23297  bytes 2309996 (2.3 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

calic4b020815fa: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1440
        inet6 fe80::ecee:eeff:feee:eeee  prefixlen 64  scopeid 0x20<link>
        ether ee:ee:ee:ee:ee:ee  txqueuelen 0  (Ethernet)
        RX packets 70498  bytes 15537000 (15.5 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 75831  bytes 73411767 (73.4 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

cbnet0: flags=4305<UP,POINTOPOINT,RUNNING,NOARP,MULTICAST>  mtu 1300
        inet 192.168.10.3  netmask 255.255.255.240  destination 192.168.10.3
        inet6 fe80::a37e:1eb5:27f7:8681  prefixlen 64  scopeid 0x20<link>
        unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  txqueuelen 500  (UNSPEC)
        RX packets 113855  bytes 67595764 (67.5 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 108918  bytes 19134171 (19.1 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:f2:96:69:25  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens4: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1460
        inet 192.168.4.2  netmask 255.255.255.255  broadcast 0.0.0.0
        inet6 fe80::4001:c0ff:fea8:402  prefixlen 64  scopeid 0x20<link>
        ether 42:01:c0:a8:04:02  txqueuelen 1000  (Ethernet)
        RX packets 536012  bytes 667945843 (667.9 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 133298  bytes 25877743 (25.8 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 38204  bytes 2706288 (2.7 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 38204  bytes 2706288 (2.7 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

tunl0: flags=193<UP,RUNNING,NOARP>  mtu 1440
        inet 10.77.181.64  netmask 255.255.255.255
        tunnel   txqueuelen 1000  (IPIP Tunnel)
        RX packets 93070  bytes 55684440 (55.6 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 84180  bytes 15166442 (15.1 MB)
        TX errors 10  dropped 8 overruns 0  carrier 0  collisions 0
```
</p>
</details>  


##### 3) az-wus-0
```bash
ifconfig
```

<details>
<summary>Click to expand</summary>
<p>

```bash
cali2f56b640720: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1480
        inet6 fe80::ecee:eeff:feee:eeee  prefixlen 64  scopeid 0x20<link>
        ether ee:ee:ee:ee:ee:ee  txqueuelen 0  (Ethernet)
        RX packets 11855  bytes 1165515 (1.1 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 11914  bytes 795158 (795.1 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

cali5f3e9043f95: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1480
        inet6 fe80::ecee:eeff:feee:eeee  prefixlen 64  scopeid 0x20<link>
        ether ee:ee:ee:ee:ee:ee  txqueuelen 0  (Ethernet)
        RX packets 230  bytes 33246 (33.2 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 221  bytes 28575 (28.5 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

caliad0be7a2d6f: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1480
        inet6 fe80::ecee:eeff:feee:eeee  prefixlen 64  scopeid 0x20<link>
        ether ee:ee:ee:ee:ee:ee  txqueuelen 0  (Ethernet)
        RX packets 10060  bytes 4672890 (4.6 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 10896  bytes 1431047 (1.4 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

calif0e3a11c6d3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1480
        inet6 fe80::ecee:eeff:feee:eeee  prefixlen 64  scopeid 0x20<link>
        ether ee:ee:ee:ee:ee:ee  txqueuelen 0  (Ethernet)
        RX packets 11833  bytes 1164034 (1.1 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 11881  bytes 793008 (793.0 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

cbnet0: flags=4305<UP,POINTOPOINT,RUNNING,NOARP,MULTICAST>  mtu 1300
        inet 192.168.10.4  netmask 255.255.255.240  destination 192.168.10.4
        inet6 fe80::f85:38bc:7f3a:785  prefixlen 64  scopeid 0x20<link>
        unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  txqueuelen 500  (UNSPEC)
        RX packets 73779  bytes 14534138 (14.5 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 78834  bytes 29866225 (29.8 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:81:17:2f:d4  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.3.4  netmask 255.255.255.0  broadcast 192.168.3.255
        inet6 fe80::20d:3aff:fe34:f5ac  prefixlen 64  scopeid 0x20<link>
        ether 00:0d:3a:34:f5:ac  txqueuelen 1000  (Ethernet)
        RX packets 548812  bytes 640435641 (640.4 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 160685  bytes 47878370 (47.8 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 107499  bytes 7101129 (7.1 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 107499  bytes 7101129 (7.1 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

tunl0: flags=193<UP,RUNNING,NOARP>  mtu 1480
        inet 10.77.32.128  netmask 255.255.255.255
        tunnel   txqueuelen 1000  (IPIP Tunnel)
        RX packets 53552  bytes 3148208 (3.1 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 47408  bytes 26131005 (26.1 MB)
        TX errors 9  dropped 10 overruns 0  carrier 0  collisions 0
```
</p>
</details>  


#### 1.2. Kubernetes nodes
```bash
kubectl get nodes
```
```bash
NAME               STATUS   ROLES                  AGE    VERSION
az-wus-0           Ready    <none>                 172m   v1.22.0
gcp-as-east1-0     Ready    <none>                 172m   v1.22.0
ip-192-168-2-152   Ready    control-plane,master   172m   v1.22.0
```

#### 1.3. Kubernetes pods
```bash
kubectl get pods -o wide
```
```bash
NAME                             READY   STATUS    RESTARTS   AGE    IP             NODE             NOMINATED NODE READINESS GATES
frontend-85595f5bf9-77dws        1/1     Running   0          169m   10.77.181.67   gcp-as-east1-0   <none>  <none>
frontend-85595f5bf9-cpn99        1/1     Running   0          169m   10.77.181.66   gcp-as-east1-0   <none>  <none>
frontend-85595f5bf9-dr6hv        1/1     Running   0          169m   10.77.32.131   az-wus-0         <none>  <none>
redis-follower-dddfbdcc9-csd6x   1/1     Running   0          170m   10.77.32.130   az-wus-0         <none>  <none>
redis-follower-dddfbdcc9-sxhds   1/1     Running   0          170m   10.77.32.129   az-wus-0         <none>  <none>
redis-leader-fb76b4755-7kgwh     1/1     Running   0          171m   10.77.181.65   gcp-as-east1-0   <none>  <none>
```

#### 1.4. Kubernetes services 
```bash
kubectl get services
```
```bash
NAME             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
frontend         NodePort    10.100.202.25    <none>        80:32291/TCP   95m
kubernetes       ClusterIP   10.96.0.1        <none>        443/TCP        176m
redis-follower   ClusterIP   10.102.170.131   <none>        6379/TCP       171m
redis-leader     ClusterIP   10.99.5.243      <none>        6379/TCP       171m
```