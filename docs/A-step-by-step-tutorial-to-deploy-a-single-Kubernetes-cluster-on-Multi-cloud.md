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


## 2. Prepare instances across Multi-clouds in Node 1

### 2.1. Create instances by CB-Tumblebug

Please refer to [(2) CB-Tumblebug 스크립트를 통한 테스트](https://github.com/cloud-barista/cb-tumblebug/blob/main/README.md#2-cb-tumblebug-%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%EB%A5%BC-%ED%86%B5%ED%95%9C-%ED%85%8C%EC%8A%A4%ED%8A%B8)

#### 2.1.1. Prepare credentials

Please refer to ["A step by step guide to creating credentials of each cloud service provider"](https://github.com/cloud-barista/cb-coffeehouse/wiki/A-step-by-step-guide-to-creating-credentials-of-each-cloud-service-provider) provided by Cloud-Barista's coffeehouse (cb-coffeehouse). We hope it will be helpful for you :smile:

##### 1) Copy `credentials.conf.example`
```bash
cd ${HOME}/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts
cp credentials.conf.example credentials.conf
```
##### 2) Replace it with your credentials

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
AwsApSoutheast1=$((++IY))     # Location: Asia Pacific (Singapore)
AwsCaCentral1=$((++IY))				# Location: Canada (Central)
AwsUsWest1=$((++IY))				  # Location: US West (N. California)
AwsUsEast1=$((++IY))				  # Location: US East (N. Virginia)
AwsApNortheast1=$((++IY))			# Location: Asia Pacific (Tokyo)
AwsApSouth1=$((++IY))				  # Location: Asia Pacific (Mumbai)
AwsApSoutheast2=$((++IY))			# Location: Asia Pacific (Sydney)
AwsEuWest2=$((++IY))				  # Location: Europe (London)
AwsUsEast2=$((++IY))				  # Location: US East (Ohio)
AwsUsWest2=$((++IY))				  # Location: US West (Oregon)
AwsApNortheast3=$((++IY))			# Location: Asia Pacific (Osaka)
AwsEuCentral1=$((++IY))				# Location: Europe (Frankfurt)
AwsEuWest1=$((++IY))				  # Location: Europe (Ireland)
AwsEuWest3=$((++IY))				  # Location: Europe (Paris)
AwsEuNorth1=$((++IY))				  # Location: Europe (Stockholm) - No t2.xxx Specs. t3 c5 m5 r5 .. are availble
AwsSaEast1=$((++IY))				  # Location: South America (São Paulo)
AwsApNortheast2=$((++IY))			# Location: Asia Pacific (Seoul)
AwsApEast1=$((++IY))			    # Location: Asia Pacific (Hong Kong)  -  Opt-In required
AwsMeSouth1=$((++IY))			    # Location: Middle East (Bahrain)  -  Opt-In required
AwsAfSouth1=$((++IY))			    # Location: Africa (Cape Town)  -  Opt-In required
AwsEuSouth1=$((++IY))				  # Location: Europe (Milan)  -  Opt-In required
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
AwsApSoutheast1=$((++IY))                       # Location: Asia Pacific (Singapore)
AwsApSoutheast2=$((++IY))                       # Location: Asia Pacific (Sydney)
AwsEuWest2=$((++IY))                            # Location: Europe (London)
AwsEuCentral1=$((++IY))                         # Location: Europe (Frankfurt)
AwsApNortheast1=$((++IY))                       # Location: Asia Pacific (Tokyo)
AwsCaCentral1=$((++IY))                         # Location: Canada (Central)
AwsUsWest1=$((++IY))                            # Location: US West (N. California)
AwsUsEast1=$((++IY))                            # Location: US East (N. Virginia)
AwsApSouth1=$((++IY))                           # Location: Asia Pacific (Mumbai)
AwsUsEast2=$((++IY))                            # Location: US East (Ohio)
AwsUsWest2=$((++IY))                            # Location: US West (Oregon)
AwsApNortheast3=$((++IY))                       # Location: Asia Pacific (Osaka)
AwsEuWest1=$((++IY))                            # Location: Europe (Ireland)
AwsEuWest3=$((++IY))                            # Location: Europe (Paris)
AwsEuNorth1=$((++IY))                           # Location: Europe (Stockholm) - No t2.xxx Specs. t3 c5 m5 r5 .. are availble
AwsSaEast1=$((++IY))                            # Location: South America (São Paulo)
AwsApNortheast2=$((++IY))                       # Location: Asia Pacific (Seoul)
AwsApEast1=$((++IY))                            # Location: Asia Pacific (Hong Kong)  -  Opt-In required
AwsMeSouth1=$((++IY))                           # Location: Middle East (Bahrain)  -  Opt-In required
AwsAfSouth1=$((++IY))                           # Location: Africa (Cape Town)  -  Opt-In required
AwsEuSouth1=$((++IY))                           # Location: Europe (Milan)  -  Opt-In required



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

#### 2.1.3 Request instances to multiple CSPs

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

### 2.2 Configure an overlay network by CB-Tumblebug and CB-Larva

#### 2.2.1 Prepare a script to deploy cb-network agent

#### 1) Create `deploy-cb-network-agent.sh` with the content below

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
    BuildAndRunCBNetworkAgentCMD="wget https://raw.githubusercontent.com/cloud-barista/cb-larva/develop/poc-cb-net/scripts/build-and-run-agent.sh -O ~/build-and-run-agent.sh; chmod +x ~/build-and-run-agent.sh; ~/build-and-run-agent.sh '${ETCD_HOSTS}' ${CLADNET_ID} ${VMID}"
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

<br/>   

```bash
cd ${HOME}/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts/sequentialFullTest
vim deploy-cb-network-agent.sh
```

##### 2) Change mode
```
chmod 775 deploy-cb-network-agent.sh
```

#### 2.2.2. Create a network CIDR block 
##### 1) Access the AdminWeb
```

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

Modify `xxx.xxx.xxx.xxx`(The endpoint of a distributed key-value store) and `xxxxxxxxxxxxxxxxxxxxx` (CLADNet ID) below
```bash
./deploy-cb-network-agent-in-background.sh all 1 kimyk01 ../testSetAMG.env '[\"xxx.xxx.xxx.xxx:2379\"]' xxxxxxxxxxxxxxxxxxxxx
```

#### 2.2.4. Check if cb-network is running or not on the AdminWeb
##### 1) Go to the section `The CLADNet status: connectivity and latency`
##### 2) Select the CLADNet and set the trial count
##### 3) Click execute and get the status

## 3. Deploy a single Kubernetnes cluster across Multi-clouds
### 3.1. Configure a master of Kubernetes

### 3.2. Configure nodes of Kuberentes and then join to the master

### 3.3. Deploy pods as an example