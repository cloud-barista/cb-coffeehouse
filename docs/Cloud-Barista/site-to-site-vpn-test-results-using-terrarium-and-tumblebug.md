
# Site-to-site VPN test results using Terrarium and Tumblebug

This document shares the site-to-site VPN test results using Terrarium and Tumblebug

**Links to the test results:**
* [Site-to-Site VPN between AWS and GCP](#site-to-site-vpn-between-aws-and-gcp)
* [Site-to-Site VPN between AWS and Azure](#site-to-site-vpn-between-aws-and-azure)
* [Site-to-Site VPN between AWS and Alibaba](#site-to-site-vpn-between-aws-and-alibaba)
* [Site-to-Site VPN between AWS and Tencent](#site-to-site-vpn-between-aws-and-tencent)
* (TBD) Site-to-Site VPN between AWS and IBM

> [!NOTE]
> Currently, there is an issue on creating vNet of IBM. It will be resolved separately.
> > cb-tumblebug       | 5:39AM ERR src/core/resource/vnet.go:664 > error="[Error from: http://cb-spider:1024/spider/vpc] Status code: 500 Internal Server Error, Message: {\"message\":\"Failed to Create VPC err = address prefix not associated with provided zone au-syd-2\"}\n"


## Test environment

- Tumblebug v0.10.6
- Spider 0.10.2
- Terrarium 0.0.21

## Precondition

An MCI is required to test a site-to-site VPN.

> [!NOTE]
> The MCI includes VMs from AWS, Azure, GCP, Alibaba, Tencent.


### Create MCI

* API: `POST /ns/{nsId}/mciDynamic`
* Params:
  - nsId: default
* Request body:   
```json
{
  "description": "Made in CB-TB",
  "installMonAgent": "no",
  "name": "mci01",
  "vm": [
    {
      "commonImage": "ubuntu22.04",
      "commonSpec": "aws+ap-northeast-2+t3a.nano"
    },
    {
      "commonImage": "ubuntu22.04",
      "commonSpec": "gcp+asia-northeast3+g1-small"
    },
    {
      "commonImage": "ubuntu22.04",
      "commonSpec": "azure+koreacentral+Standard_B1s"
    },
    {
      "commonImage": "ubuntu22.04",
      "commonSpec": "alibaba+ap-northeast-2+ecs.g6e.large"
    },
    {
      "commonImage": "ubuntu22.04",
      "commonSpec": "tencent+ap-seoul+S5.MEDIUM4"
    }
  ]
}
```

* Response body:   
```json
{
  "resourceType": "mci",
  "id": "mci01",
  "uid": "d0ekvfpivg86titl82k0",
  "name": "mci01",
  "status": "Running:5 (R:5/5)",
  "statusCount": {
    "countTotal": 5,
    "countCreating": 0,
    "countRunning": 5,
    "countFailed": 0,
    "countSuspended": 0,
    "countRebooting": 0,
    "countTerminated": 0,
    "countSuspending": 0,
    "countResuming": 0,
    "countTerminating": 0,
    "countUndefined": 0
  },
  "targetStatus": "Running",
  "targetAction": "Create",
  "installMonAgent": "no",
  "configureCloudAdaptiveNetwork": "",
  "label": {
    "sys.description": "Made in CB-TB",
    "sys.id": "mci01",
    "sys.labelType": "mci",
    "sys.manager": "cb-tumblebug",
    "sys.name": "mci01",
    "sys.namespace": "default",
    "sys.uid": "d0ekvfpivg86titl82k0"
  },
  "systemLabel": "",
  "systemMessage": "",
  "description": "Made in CB-TB",
  "vm": [
    {
      "resourceType": "vm",
      "id": "d0ekuq1ivg86titl827g-1",
      "uid": "d0ekvfpivg86titl82l0",
      "cspResourceName": "d0ekvfpivg86titl82l0",
      "cspResourceId": "i-05bcaeeb68f5a934a",
      "name": "d0ekuq1ivg86titl827g-1",
      "subGroupId": "d0ekuq1ivg86titl827g",
      "location": {
        "display": "South Korea (Seoul)",
        "latitude": 37.36,
        "longitude": 126.78
      },
      "status": "Running",
      "targetStatus": "None",
      "targetAction": "None",
      "monAgentStatus": "notInstalled",
      "networkAgentStatus": "notInstalled",
      "systemMessage": "",
      "createdTime": "2025-05-09 00:44:08",
      "label": {
        "Name": "d0ekvfpivg86titl82l0",
        "sys.connectionName": "aws-ap-northeast-2",
        "sys.createdTime": "2025-05-09 00:44:08",
        "sys.cspResourceId": "i-05bcaeeb68f5a934a",
        "sys.cspResourceName": "d0ekvfpivg86titl82l0",
        "sys.id": "d0ekuq1ivg86titl827g-1",
        "sys.labelType": "vm",
        "sys.manager": "cb-tumblebug",
        "sys.mciId": "mci01",
        "sys.name": "d0ekuq1ivg86titl827g-1",
        "sys.namespace": "default",
        "sys.subGroupId": "d0ekuq1ivg86titl827g",
        "sys.uid": "d0ekvfpivg86titl82l0"
      },
      "description": "",
      "region": {
        "Region": "ap-northeast-2",
        "Zone": "ap-northeast-2a"
      },
      "publicIP": "43.203.217.241",
      "sshPort": "22",
      "publicDNS": "",
      "privateIP": "10.32.40.134",
      "privateDNS": "ip-10-32-40-134.ap-northeast-2.compute.internal",
      "rootDiskType": "gp2",
      "rootDiskSize": "8",
      "rootDiskName": "",
      "connectionName": "aws-ap-northeast-2",
      "connectionConfig": {
        "configName": "aws-ap-northeast-2",
        "providerName": "aws",
        "driverName": "aws-driver-v1.0.so",
        "credentialName": "aws",
        "credentialHolder": "admin",
        "regionZoneInfoName": "aws-ap-northeast-2",
        "regionZoneInfo": {
          "assignedRegion": "ap-northeast-2",
          "assignedZone": "ap-northeast-2a"
        },
        "regionDetail": {
          "regionId": "ap-northeast-2",
          "regionName": "ap-northeast-2",
          "description": "Asia Pacific (Seoul)",
          "location": {
            "display": "South Korea (Seoul)",
            "latitude": 37.36,
            "longitude": 126.78
          },
          "zones": [
            "ap-northeast-2a",
            "ap-northeast-2b",
            "ap-northeast-2c",
            "ap-northeast-2d"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "specId": "aws+ap-northeast-2+t3a.nano",
      "cspSpecName": "t3a.nano",
      "imageId": "aws+ap-northeast-2+ubuntu22.04",
      "cspImageName": "ami-058165de3b7202099",
      "vNetId": "default-shared-aws-ap-northeast-2",
      "cspVNetId": "vpc-0d115018882a5c1eb",
      "subnetId": "default-shared-aws-ap-northeast-2",
      "cspSubnetId": "subnet-017e3eacec9d6ecfc",
      "networkInterface": "eni-attach-0d4ac716ef590e334",
      "securityGroupIds": [
        "default-shared-aws-ap-northeast-2"
      ],
      "dataDiskIds": null,
      "sshKeyId": "default-shared-aws-ap-northeast-2",
      "cspSshKeyId": "d0ekup9ivg86titl826g",
      "vmUserName": "cb-user",
      "addtionalDetails": [
        {
          "key": "State",
          "value": "running"
        },
        {
          "key": "Architecture",
          "value": "x86_64"
        },
        {
          "key": "VpcId",
          "value": "vpc-0d115018882a5c1eb"
        },
        {
          "key": "SubnetId",
          "value": "subnet-017e3eacec9d6ecfc"
        },
        {
          "key": "KeyName",
          "value": "d0ekup9ivg86titl826g"
        },
        {
          "key": "VirtualizationType",
          "value": "hvm"
        }
      ]
    },
    {
      "resourceType": "vm",
      "id": "d0ekurhivg86titl82f0-1",
      "uid": "d0ekvfpivg86titl82m0",
      "cspResourceName": "d0ekvfpivg86titl82m0",
      "cspResourceId": "i-mj764k3wxqy92lfmm7ez",
      "name": "d0ekurhivg86titl82f0-1",
      "subGroupId": "d0ekurhivg86titl82f0",
      "location": {
        "display": "South Korea (Seoul)",
        "latitude": 37.36,
        "longitude": 126.78
      },
      "status": "Running",
      "targetStatus": "None",
      "targetAction": "None",
      "monAgentStatus": "notInstalled",
      "networkAgentStatus": "notInstalled",
      "systemMessage": "",
      "createdTime": "2025-05-09 00:44:18",
      "label": {
        "sys.connectionName": "alibaba-ap-northeast-2",
        "sys.createdTime": "2025-05-09 00:44:18",
        "sys.cspResourceId": "i-mj764k3wxqy92lfmm7ez",
        "sys.cspResourceName": "d0ekvfpivg86titl82m0",
        "sys.id": "d0ekurhivg86titl82f0-1",
        "sys.labelType": "vm",
        "sys.manager": "cb-tumblebug",
        "sys.mciId": "mci01",
        "sys.name": "d0ekurhivg86titl82f0-1",
        "sys.namespace": "default",
        "sys.subGroupId": "d0ekurhivg86titl82f0",
        "sys.uid": "d0ekvfpivg86titl82m0"
      },
      "description": "",
      "region": {
        "Region": "ap-northeast-2",
        "Zone": "ap-northeast-2a"
      },
      "publicIP": "47.80.1.119",
      "sshPort": "22",
      "publicDNS": "",
      "privateIP": "10.2.33.29",
      "privateDNS": "",
      "rootDiskType": "cloud_essd",
      "rootDiskSize": "40",
      "rootDiskName": "",
      "connectionName": "alibaba-ap-northeast-2",
      "connectionConfig": {
        "configName": "alibaba-ap-northeast-2",
        "providerName": "alibaba",
        "driverName": "alibaba-driver-v1.0.so",
        "credentialName": "alibaba",
        "credentialHolder": "admin",
        "regionZoneInfoName": "alibaba-ap-northeast-2",
        "regionZoneInfo": {
          "assignedRegion": "ap-northeast-2",
          "assignedZone": "ap-northeast-2a"
        },
        "regionDetail": {
          "regionId": "ap-northeast-2",
          "regionName": "ap-northeast-2",
          "description": "South Korea (Seoul)",
          "location": {
            "display": "South Korea (Seoul)",
            "latitude": 37.36,
            "longitude": 126.78
          },
          "zones": [
            "ap-northeast-2a"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "specId": "alibaba+ap-northeast-2+ecs.g6e.large",
      "cspSpecName": "ecs.g6e.large",
      "imageId": "alibaba+ap-northeast-2+ubuntu22.04",
      "cspImageName": "ubuntu_22_04_x64_20G_alibase_20250415.vhd",
      "vNetId": "default-shared-alibaba-ap-northeast-2",
      "cspVNetId": "vpc-mj7cb4wwrkvekhgs7xj06",
      "subnetId": "default-shared-alibaba-ap-northeast-2",
      "cspSubnetId": "vsw-mj7p8k5wa46btvohzkwaq",
      "networkInterface": "eni-mj764k3wxqy92lfm7txh",
      "securityGroupIds": [
        "default-shared-alibaba-ap-northeast-2"
      ],
      "dataDiskIds": null,
      "sshKeyId": "default-shared-alibaba-ap-northeast-2",
      "cspSshKeyId": "d0ekur1ivg86titl82e0",
      "vmUserName": "cb-user",
      "vmUserPassword": "igevvpd1hk!A0$",
      "addtionalDetails": [
        {
          "key": "",
          "value": ""
        }
      ]
    },
    {
      "resourceType": "vm",
      "id": "d0ekv79ivg86titl82hg-1",
      "uid": "d0ekvfpivg86titl82n0",
      "cspResourceName": "d0ekvfpivg86titl82n0",
      "cspResourceId": "ins-baz78ojh",
      "name": "d0ekv79ivg86titl82hg-1",
      "subGroupId": "d0ekv79ivg86titl82hg",
      "location": {
        "display": "South Korea (Seoul)",
        "latitude": 37.566536,
        "longitude": 126.977966
      },
      "status": "Running",
      "targetStatus": "None",
      "targetAction": "None",
      "monAgentStatus": "notInstalled",
      "networkAgentStatus": "notInstalled",
      "systemMessage": "",
      "createdTime": "2025-05-09 00:44:52",
      "label": {
        "sys.connectionName": "tencent-ap-seoul",
        "sys.createdTime": "2025-05-09 00:44:52",
        "sys.cspResourceId": "ins-baz78ojh",
        "sys.cspResourceName": "d0ekvfpivg86titl82n0",
        "sys.id": "d0ekv79ivg86titl82hg-1",
        "sys.labelType": "vm",
        "sys.manager": "cb-tumblebug",
        "sys.mciId": "mci01",
        "sys.name": "d0ekv79ivg86titl82hg-1",
        "sys.namespace": "default",
        "sys.subGroupId": "d0ekv79ivg86titl82hg",
        "sys.uid": "d0ekvfpivg86titl82n0"
      },
      "description": "",
      "region": {
        "Region": "ap-seoul",
        "Zone": "ap-seoul-1"
      },
      "publicIP": "43.133.238.40",
      "sshPort": "22",
      "publicDNS": "",
      "privateIP": "10.161.0.11",
      "privateDNS": "",
      "rootDiskType": "CLOUD_PREMIUM",
      "rootDiskSize": "50",
      "rootDiskName": "",
      "connectionName": "tencent-ap-seoul",
      "connectionConfig": {
        "configName": "tencent-ap-seoul",
        "providerName": "tencent",
        "driverName": "tencent-driver-v1.0.so",
        "credentialName": "tencent",
        "credentialHolder": "admin",
        "regionZoneInfoName": "tencent-ap-seoul",
        "regionZoneInfo": {
          "assignedRegion": "ap-seoul",
          "assignedZone": "ap-seoul-1"
        },
        "regionDetail": {
          "regionId": "ap-seoul",
          "regionName": "ap-seoul",
          "description": "Seoul",
          "location": {
            "display": "South Korea (Seoul)",
            "latitude": 37.566536,
            "longitude": 126.977966
          },
          "zones": [
            "ap-seoul-1",
            "ap-seoul-2"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "specId": "tencent+ap-seoul+s5.medium4",
      "cspSpecName": "S5.MEDIUM4",
      "imageId": "tencent+ap-seoul+ubuntu22.04",
      "cspImageName": "img-487zeit5",
      "vNetId": "default-shared-tencent-ap-seoul",
      "cspVNetId": "vpc-7mz1r0o6",
      "subnetId": "default-shared-tencent-ap-seoul",
      "cspSubnetId": "subnet-g2f8dhn7",
      "networkInterface": "",
      "securityGroupIds": [
        "default-shared-tencent-ap-seoul"
      ],
      "dataDiskIds": null,
      "sshKeyId": "default-shared-tencent-ap-seoul",
      "cspSshKeyId": "skey-adz0145v",
      "vmUserName": "cb-user",
      "addtionalDetails": [
        {
          "key": "InstanceState",
          "value": "RUNNING"
        },
        {
          "key": "OsName",
          "value": "Ubuntu Server 22.04 LTS 64bit"
        },
        {
          "key": "InstanceChargeType",
          "value": "POSTPAID_BY_HOUR"
        },
        {
          "key": "SystemDiskType",
          "value": "CLOUD_PREMIUM"
        },
        {
          "key": "SystemDiskId",
          "value": "disk-879vo8vr"
        },
        {
          "key": "SystemDiskSize",
          "value": "50"
        },
        {
          "key": "InternetChargeType",
          "value": "TRAFFIC_POSTPAID_BY_HOUR"
        },
        {
          "key": "InternetMaxBandwidthOut",
          "value": "1"
        }
      ]
    },
    {
      "resourceType": "vm",
      "id": "d0ekvbhivg86titl82j0-1",
      "uid": "d0ekvfpivg86titl82o0",
      "cspResourceName": "d0ekvfpivg86titl82o0",
      "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Compute/virtualMachines/d0ekvfpivg86titl82o0",
      "name": "d0ekvbhivg86titl82j0-1",
      "subGroupId": "d0ekvbhivg86titl82j0",
      "location": {
        "display": "Korea Central",
        "latitude": 37.5665,
        "longitude": 126.978
      },
      "status": "Running",
      "targetStatus": "None",
      "targetAction": "None",
      "monAgentStatus": "notInstalled",
      "networkAgentStatus": "notInstalled",
      "systemMessage": "",
      "createdTime": "2025-05-09 00:44:18",
      "label": {
        "createdBy": "d0ekvfpivg86titl82o0",
        "keypair": "d0ekv59ivg86titl82fg",
        "publicip": "d0ekvfpivg86titl82o0-98994-PublicIP",
        "sys.connectionName": "azure-koreacentral",
        "sys.createdTime": "2025-05-09 00:44:18",
        "sys.cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Compute/virtualMachines/d0ekvfpivg86titl82o0",
        "sys.cspResourceName": "d0ekvfpivg86titl82o0",
        "sys.id": "d0ekvbhivg86titl82j0-1",
        "sys.labelType": "vm",
        "sys.manager": "cb-tumblebug",
        "sys.mciId": "mci01",
        "sys.name": "d0ekvbhivg86titl82j0-1",
        "sys.namespace": "default",
        "sys.subGroupId": "d0ekvbhivg86titl82j0",
        "sys.uid": "d0ekvfpivg86titl82o0"
      },
      "description": "",
      "region": {
        "Region": "koreacentral",
        "Zone": "1"
      },
      "publicIP": "20.196.112.73",
      "sshPort": "22",
      "publicDNS": "",
      "privateIP": "10.76.0.4",
      "privateDNS": "",
      "rootDiskType": "PremiumSSD",
      "rootDiskSize": "30",
      "rootDiskName": "",
      "connectionName": "azure-koreacentral",
      "connectionConfig": {
        "configName": "azure-koreacentral",
        "providerName": "azure",
        "driverName": "azure-driver-v1.0.so",
        "credentialName": "azure",
        "credentialHolder": "admin",
        "regionZoneInfoName": "azure-koreacentral",
        "regionZoneInfo": {
          "assignedRegion": "koreacentral",
          "assignedZone": "1"
        },
        "regionDetail": {
          "regionId": "koreacentral",
          "regionName": "koreacentral",
          "description": "Korea Central",
          "location": {
            "display": "Korea Central",
            "latitude": 37.5665,
            "longitude": 126.978
          },
          "zones": [
            "1",
            "2",
            "3"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "specId": "azure+koreacentral+standard_b1s",
      "cspSpecName": "Standard_B1s",
      "imageId": "azure+koreacentral+ubuntu22.04",
      "cspImageName": "Canonical:0001-com-ubuntu-server-jammy:22_04-lts:22.04.202404090",
      "vNetId": "default-shared-azure-koreacentral",
      "cspVNetId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/virtualNetworks/d0ekuq1ivg86titl82b0",
      "subnetId": "default-shared-azure-koreacentral",
      "cspSubnetId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/virtualNetworks/d0ekuq1ivg86titl82b0/subnets/d0ekuq1ivg86titl82bg",
      "networkInterface": "d0ekvfpivg86titl82o0-38651-VNic",
      "securityGroupIds": [
        "default-shared-azure-koreacentral"
      ],
      "dataDiskIds": null,
      "sshKeyId": "default-shared-azure-koreacentral",
      "cspSshKeyId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Compute/sshPublicKeys/d0ekv59ivg86titl82fg",
      "vmUserName": "cb-user",
      "addtionalDetails": [
        {
          "key": "publicip",
          "value": "d0ekvfpivg86titl82o0-98994-PublicIP"
        }
      ]
    },
    {
      "resourceType": "vm",
      "id": "d0ekvfpivg86titl82jg-1",
      "uid": "d0ekvfpivg86titl82p0",
      "cspResourceName": "d0ekvfpivg86titl82p0",
      "cspResourceId": "d0ekvfpivg86titl82p0",
      "name": "d0ekvfpivg86titl82jg-1",
      "subGroupId": "d0ekvfpivg86titl82jg",
      "location": {
        "display": "South Korea (Seoul)",
        "latitude": 37.2,
        "longitude": 127
      },
      "status": "Running",
      "targetStatus": "None",
      "targetAction": "None",
      "monAgentStatus": "notInstalled",
      "networkAgentStatus": "notInstalled",
      "systemMessage": "",
      "createdTime": "2025-05-09 00:44:34",
      "label": {
        "keypair": "d0ekv7hivg86titl82i0",
        "sys.connectionName": "gcp-asia-northeast3",
        "sys.createdTime": "2025-05-09 00:44:34",
        "sys.cspResourceId": "d0ekvfpivg86titl82p0",
        "sys.cspResourceName": "d0ekvfpivg86titl82p0",
        "sys.id": "d0ekvfpivg86titl82jg-1",
        "sys.labelType": "vm",
        "sys.manager": "cb-tumblebug",
        "sys.mciId": "mci01",
        "sys.name": "d0ekvfpivg86titl82jg-1",
        "sys.namespace": "default",
        "sys.subGroupId": "d0ekvfpivg86titl82jg",
        "sys.uid": "d0ekvfpivg86titl82p0"
      },
      "description": "",
      "region": {
        "Region": "asia-northeast3",
        "Zone": "asia-northeast3-a"
      },
      "publicIP": "34.22.94.67",
      "sshPort": "22",
      "publicDNS": "",
      "privateIP": "10.105.0.2",
      "privateDNS": "",
      "rootDiskType": "pd-standard",
      "rootDiskSize": "10",
      "rootDiskName": "",
      "connectionName": "gcp-asia-northeast3",
      "connectionConfig": {
        "configName": "gcp-asia-northeast3",
        "providerName": "gcp",
        "driverName": "gcp-driver-v1.0.so",
        "credentialName": "gcp",
        "credentialHolder": "admin",
        "regionZoneInfoName": "gcp-asia-northeast3",
        "regionZoneInfo": {
          "assignedRegion": "asia-northeast3",
          "assignedZone": "asia-northeast3-a"
        },
        "regionDetail": {
          "regionId": "asia-northeast3",
          "regionName": "asia-northeast3",
          "description": "Seoul South Korea",
          "location": {
            "display": "South Korea (Seoul)",
            "latitude": 37.2,
            "longitude": 127
          },
          "zones": [
            "asia-northeast3-a",
            "asia-northeast3-b",
            "asia-northeast3-c"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "specId": "gcp+asia-northeast3+g1-small",
      "cspSpecName": "g1-small",
      "imageId": "gcp+asia-northeast3+ubuntu22.04",
      "cspImageName": "https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20240319",
      "vNetId": "default-shared-gcp-asia-northeast3",
      "cspVNetId": "d0ekuq1ivg86titl829g",
      "subnetId": "default-shared-gcp-asia-northeast3",
      "cspSubnetId": "d0ekuq1ivg86titl82a0",
      "networkInterface": "nic0",
      "securityGroupIds": [
        "default-shared-gcp-asia-northeast3"
      ],
      "dataDiskIds": null,
      "sshKeyId": "default-shared-gcp-asia-northeast3",
      "cspSshKeyId": "d0ekv7hivg86titl82i0",
      "vmUserName": "cb-user",
      "addtionalDetails": [
        {
          "key": "SubNetwork",
          "value": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/regions/asia-northeast3/subnetworks/d0ekuq1ivg86titl82a0"
        },
        {
          "key": "AccessConfigName",
          "value": "External NAT"
        },
        {
          "key": "NetworkTier",
          "value": "PREMIUM"
        },
        {
          "key": "DiskDeviceName",
          "value": "persistent-disk-0"
        },
        {
          "key": "DiskName",
          "value": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/zones/asia-northeast3-a/disks/d0ekvfpivg86titl82p0"
        },
        {
          "key": "Kind",
          "value": "compute#instance"
        },
        {
          "key": "ZoneUrl",
          "value": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/zones/asia-northeast3-a"
        }
      ]
    }
  ],
  "newVmList": null,
  "postCommand": {
    "userName": "",
    "command": null
  },
  "postCommandResult": {
    "results": null
  }
}
```


### Get vNet IDs from sites in MCI

* API: `GET /ns/{nsId}/mci/{mciId}/site`
* Params: 
  - nsId: default
  - mciId: mci01
* Response body:   
```json
{
  "nsId": "default",
  "mciId": "mci01",
  "count": 5,
  "sites": {
    "aws": [
      {
        "csp": "aws",
        "region": "ap-northeast-2",
        "connectionName": "aws-ap-northeast-2",
        "vnet": "default-shared-aws-ap-northeast-2"
      }
    ],
    "azure": [
      {
        "csp": "azure",
        "region": "koreacentral",
        "connectionName": "azure-koreacentral",
        "vnet": "default-shared-azure-koreacentral",
        "gatewaySubnetCidr": "10.76.128.0/18",
        "resourceGroup": "koreacentral"
      }
    ],
    "gcp": [
      {
        "csp": "gcp",
        "region": "asia-northeast3",
        "connectionName": "gcp-asia-northeast3",
        "vnet": "default-shared-gcp-asia-northeast3"
      }
    ],
    "alibaba": [
      {
        "csp": "alibaba",
        "region": "ap-northeast-2",
        "connectionName": "alibaba-ap-northeast-2",
        "vnet": "default-shared-alibaba-ap-northeast-2"
      }
    ],
    "tencent": [
      {
        "csp": "tencent",
        "region": "ap-seoul",
        "connectionName": "tencent-ap-seoul",
        "vnet": "default-shared-tencent-ap-seoul"
      }
    ]
  }
}
```


---

## Site-to-Site VPN between AWS and GCP
### Create VPN 

* API: `POST /ns/{nsId}/mci/{mciId}/vpn`
* Params:
  - nsId: default
  - mciId: mci01
* Request body:   
```json
{
  "name": "vpn01",
  "site1": {
    "cspSpecificProperty": {
      "aws": {
        "bgpAsn": "64512"
      }
    },
    "vNetId": "default-shared-aws-ap-northeast-2"
  },
  "site2": {
    "cspSpecificProperty": {
      "gcp": {
        "bgpAsn": "65530"
      }
    },
    "vNetId": "default-shared-gcp-asia-northeast3"
  }
}
```

* Response body:    
```json
{
  "resourceType": "vpn",
  "id": "vpn01",
  "uid": "d0elsu66kj4nnv2lp2g0",
  "name": "vpn01",
  "description": "VPN between aws and gcp",
  "status": "Available",
  "vpnSites": [
    {
      "connectionName": "aws-ap-northeast-2",
      "connectionConfig": {
        "configName": "aws-ap-northeast-2",
        "providerName": "aws",
        "driverName": "aws-driver-v1.0.so",
        "credentialName": "aws",
        "credentialHolder": "admin",
        "regionZoneInfoName": "aws-ap-northeast-2",
        "regionZoneInfo": {
          "assignedRegion": "ap-northeast-2",
          "assignedZone": "ap-northeast-2a"
        },
        "regionDetail": {
          "regionId": "ap-northeast-2",
          "regionName": "ap-northeast-2",
          "description": "Asia Pacific (Seoul)",
          "location": {
            "display": "South Korea (Seoul)",
            "latitude": 37.36,
            "longitude": 126.78
          },
          "zones": [
            "ap-northeast-2a",
            "ap-northeast-2b",
            "ap-northeast-2c",
            "ap-northeast-2d"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "resourceDetails": [
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-vpn-gw",
          "cspResourceId": "vgw-0d9fec8466eb7191e",
          "cspResourceDetail": {
            "id": "vgw-0d9fec8466eb7191e",
            "name": "d0elsu66kj4nnv2lp2g0-vpn-gw",
            "resource_type": "aws_vpn_gateway",
            "vpc_id": "vpc-0d115018882a5c1eb"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-gcp-side-gw-1",
          "cspResourceId": "cgw-09a6a7db47f619ac6",
          "cspResourceDetail": {
            "bgp_asn": "65530",
            "id": "cgw-09a6a7db47f619ac6",
            "ip_address": "34.152.96.47",
            "name": "d0elsu66kj4nnv2lp2g0-gcp-side-gw-1",
            "resource_type": "aws_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-gcp-side-gw-2",
          "cspResourceId": "cgw-0a4f5beb72d515993",
          "cspResourceDetail": {
            "bgp_asn": "65530",
            "id": "cgw-0a4f5beb72d515993",
            "ip_address": "34.177.64.188",
            "name": "d0elsu66kj4nnv2lp2g0-gcp-side-gw-2",
            "resource_type": "aws_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-to-gcp-1",
          "cspResourceId": "vpn-0ac3ec98e2833dcfb",
          "cspResourceDetail": {
            "id": "vpn-0ac3ec98e2833dcfb",
            "name": "d0elsu66kj4nnv2lp2g0-to-gcp-1",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "13.124.207.44",
            "tunnel2_address": "43.202.15.86"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-to-gcp-2",
          "cspResourceId": "vpn-0e6d4e2282783b8cc",
          "cspResourceDetail": {
            "id": "vpn-0e6d4e2282783b8cc",
            "name": "d0elsu66kj4nnv2lp2g0-to-gcp-2",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "3.36.254.47",
            "tunnel2_address": "15.164.192.181"
          }
        }
      ]
    },
    {
      "connectionName": "gcp-asia-northeast3",
      "connectionConfig": {
        "configName": "gcp-asia-northeast3",
        "providerName": "gcp",
        "driverName": "gcp-driver-v1.0.so",
        "credentialName": "gcp",
        "credentialHolder": "admin",
        "regionZoneInfoName": "gcp-asia-northeast3",
        "regionZoneInfo": {
          "assignedRegion": "asia-northeast3",
          "assignedZone": "asia-northeast3-a"
        },
        "regionDetail": {
          "regionId": "asia-northeast3",
          "regionName": "asia-northeast3",
          "description": "Seoul South Korea",
          "location": {
            "display": "South Korea (Seoul)",
            "latitude": 37.2,
            "longitude": 127
          },
          "zones": [
            "asia-northeast3-a",
            "asia-northeast3-b",
            "asia-northeast3-c"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "resourceDetails": [
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-interface-1",
          "cspResourceId": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-1",
          "cspResourceDetail": {
            "id": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-1",
            "ip_range": "169.254.26.22/30",
            "name": "d0elsu66kj4nnv2lp2g0-interface-1",
            "resource_type": "google_compute_router_interface"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-interface-2",
          "cspResourceId": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-2",
          "cspResourceDetail": {
            "id": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-2",
            "ip_range": "169.254.86.14/30",
            "name": "d0elsu66kj4nnv2lp2g0-interface-2",
            "resource_type": "google_compute_router_interface"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-interface-3",
          "cspResourceId": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-3",
          "cspResourceDetail": {
            "id": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-3",
            "ip_range": "169.254.148.102/30",
            "name": "d0elsu66kj4nnv2lp2g0-interface-3",
            "resource_type": "google_compute_router_interface"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-interface-4",
          "cspResourceId": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-4",
          "cspResourceDetail": {
            "id": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-4",
            "ip_range": "169.254.201.90/30",
            "name": "d0elsu66kj4nnv2lp2g0-interface-4",
            "resource_type": "google_compute_router_interface"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-peer-1",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-1",
          "cspResourceDetail": {
            "id": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-1",
            "name": "d0elsu66kj4nnv2lp2g0-peer-1",
            "peer_asn": 64512,
            "peer_ip": "169.254.26.21",
            "resource_type": "google_compute_router_peer"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-peer-2",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-2",
          "cspResourceDetail": {
            "id": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-2",
            "name": "d0elsu66kj4nnv2lp2g0-peer-2",
            "peer_asn": 64512,
            "peer_ip": "169.254.86.13",
            "resource_type": "google_compute_router_peer"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-peer-3",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-3",
          "cspResourceDetail": {
            "id": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-3",
            "name": "d0elsu66kj4nnv2lp2g0-peer-3",
            "peer_asn": 64512,
            "peer_ip": "169.254.148.101",
            "resource_type": "google_compute_router_peer"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-peer-4",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-4",
          "cspResourceDetail": {
            "id": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-4",
            "name": "d0elsu66kj4nnv2lp2g0-peer-4",
            "peer_asn": 64512,
            "peer_ip": "169.254.201.89",
            "resource_type": "google_compute_router_peer"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-router",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router",
          "cspResourceDetail": {
            "bgp_asn": "65530",
            "id": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router",
            "name": "d0elsu66kj4nnv2lp2g0-router",
            "network": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/global/networks/d0ekuq1ivg86titl829g",
            "resource_type": "google_compute_router"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-tunnel-1",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-1",
          "cspResourceDetail": {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-1",
            "interface": 0,
            "name": "d0elsu66kj4nnv2lp2g0-tunnel-1",
            "peer_ip": "13.124.207.44",
            "resource_type": "google_compute_vpn_tunnel"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-tunnel-2",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-2",
          "cspResourceDetail": {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-2",
            "interface": 1,
            "name": "d0elsu66kj4nnv2lp2g0-tunnel-2",
            "peer_ip": "43.202.15.86",
            "resource_type": "google_compute_vpn_tunnel"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-tunnel-3",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-3",
          "cspResourceDetail": {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-3",
            "interface": 0,
            "name": "d0elsu66kj4nnv2lp2g0-tunnel-3",
            "peer_ip": "3.36.254.47",
            "resource_type": "google_compute_vpn_tunnel"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-tunnel-4",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-4",
          "cspResourceDetail": {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-4",
            "interface": 1,
            "name": "d0elsu66kj4nnv2lp2g0-tunnel-4",
            "peer_ip": "15.164.192.181",
            "resource_type": "google_compute_vpn_tunnel"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-ha-vpn-gw",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnGateways/d0elsu66kj4nnv2lp2g0-ha-vpn-gw",
          "cspResourceDetail": {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnGateways/d0elsu66kj4nnv2lp2g0-ha-vpn-gw",
            "name": "d0elsu66kj4nnv2lp2g0-ha-vpn-gw",
            "network": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/global/networks/d0ekuq1ivg86titl829g",
            "region": "asia-northeast3",
            "resource_type": "google_compute_ha_vpn_gateway"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-aws-side-vpn-gw",
          "cspResourceId": "projects/ykkim-etri/global/externalVpnGateways/d0elsu66kj4nnv2lp2g0-aws-side-vpn-gw",
          "cspResourceDetail": {
            "description": "AWS-side VPN gateway",
            "id": "projects/ykkim-etri/global/externalVpnGateways/d0elsu66kj4nnv2lp2g0-aws-side-vpn-gw",
            "interfaces": [
              {
                "id": 0,
                "ip_address": "13.124.207.44"
              },
              {
                "id": 1,
                "ip_address": "43.202.15.86"
              },
              {
                "id": 2,
                "ip_address": "3.36.254.47"
              },
              {
                "id": 3,
                "ip_address": "15.164.192.181"
              }
            ],
            "name": "d0elsu66kj4nnv2lp2g0-aws-side-vpn-gw",
            "redundancy_type": "FOUR_IPS_REDUNDANCY",
            "resource_type": "google_compute_external_vpn_gateway"
          }
        }
      ]
    }
  ]
}
```


### Get VPN 

* API: `GET /ns/{nsId}/mci/{mciId}/vpn/{vpnId}`
* Params:
  - nsId: default
  - mciId: mci01
  - vpnId: vpn01
* Response body:   
```json
{
  "resourceType": "vpn",
  "id": "vpn01",
  "uid": "d0elsu66kj4nnv2lp2g0",
  "name": "vpn01",
  "description": "VPN between aws and gcp",
  "status": "Available",
  "vpnSites": [
    {
      "connectionName": "aws-ap-northeast-2",
      "connectionConfig": {
        "configName": "aws-ap-northeast-2",
        "providerName": "aws",
        "driverName": "aws-driver-v1.0.so",
        "credentialName": "aws",
        "credentialHolder": "admin",
        "regionZoneInfoName": "aws-ap-northeast-2",
        "regionZoneInfo": {
          "assignedRegion": "ap-northeast-2",
          "assignedZone": "ap-northeast-2a"
        },
        "regionDetail": {
          "regionId": "ap-northeast-2",
          "regionName": "ap-northeast-2",
          "description": "Asia Pacific (Seoul)",
          "location": {
            "display": "South Korea (Seoul)",
            "latitude": 37.36,
            "longitude": 126.78
          },
          "zones": [
            "ap-northeast-2a",
            "ap-northeast-2b",
            "ap-northeast-2c",
            "ap-northeast-2d"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "resourceDetails": [
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-gcp-side-gw-1",
          "cspResourceId": "cgw-09a6a7db47f619ac6",
          "cspResourceDetail": {
            "bgp_asn": "65530",
            "id": "cgw-09a6a7db47f619ac6",
            "ip_address": "34.152.96.47",
            "name": "d0elsu66kj4nnv2lp2g0-gcp-side-gw-1",
            "resource_type": "aws_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-gcp-side-gw-2",
          "cspResourceId": "cgw-0a4f5beb72d515993",
          "cspResourceDetail": {
            "bgp_asn": "65530",
            "id": "cgw-0a4f5beb72d515993",
            "ip_address": "34.177.64.188",
            "name": "d0elsu66kj4nnv2lp2g0-gcp-side-gw-2",
            "resource_type": "aws_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-to-gcp-1",
          "cspResourceId": "vpn-0ac3ec98e2833dcfb",
          "cspResourceDetail": {
            "id": "vpn-0ac3ec98e2833dcfb",
            "name": "d0elsu66kj4nnv2lp2g0-to-gcp-1",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "13.124.207.44",
            "tunnel2_address": "43.202.15.86"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-to-gcp-2",
          "cspResourceId": "vpn-0e6d4e2282783b8cc",
          "cspResourceDetail": {
            "id": "vpn-0e6d4e2282783b8cc",
            "name": "d0elsu66kj4nnv2lp2g0-to-gcp-2",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "3.36.254.47",
            "tunnel2_address": "15.164.192.181"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-vpn-gw",
          "cspResourceId": "vgw-0d9fec8466eb7191e",
          "cspResourceDetail": {
            "id": "vgw-0d9fec8466eb7191e",
            "name": "d0elsu66kj4nnv2lp2g0-vpn-gw",
            "resource_type": "aws_vpn_gateway",
            "vpc_id": "vpc-0d115018882a5c1eb"
          }
        }
      ]
    },
    {
      "connectionName": "gcp-asia-northeast3",
      "connectionConfig": {
        "configName": "gcp-asia-northeast3",
        "providerName": "gcp",
        "driverName": "gcp-driver-v1.0.so",
        "credentialName": "gcp",
        "credentialHolder": "admin",
        "regionZoneInfoName": "gcp-asia-northeast3",
        "regionZoneInfo": {
          "assignedRegion": "asia-northeast3",
          "assignedZone": "asia-northeast3-a"
        },
        "regionDetail": {
          "regionId": "asia-northeast3",
          "regionName": "asia-northeast3",
          "description": "Seoul South Korea",
          "location": {
            "display": "South Korea (Seoul)",
            "latitude": 37.2,
            "longitude": 127
          },
          "zones": [
            "asia-northeast3-a",
            "asia-northeast3-b",
            "asia-northeast3-c"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "resourceDetails": [
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-aws-side-vpn-gw",
          "cspResourceId": "projects/ykkim-etri/global/externalVpnGateways/d0elsu66kj4nnv2lp2g0-aws-side-vpn-gw",
          "cspResourceDetail": {
            "description": "AWS-side VPN gateway",
            "id": "projects/ykkim-etri/global/externalVpnGateways/d0elsu66kj4nnv2lp2g0-aws-side-vpn-gw",
            "interfaces": [
              {
                "id": 0,
                "ip_address": "13.124.207.44"
              },
              {
                "id": 1,
                "ip_address": "43.202.15.86"
              },
              {
                "id": 2,
                "ip_address": "3.36.254.47"
              },
              {
                "id": 3,
                "ip_address": "15.164.192.181"
              }
            ],
            "name": "d0elsu66kj4nnv2lp2g0-aws-side-vpn-gw",
            "redundancy_type": "FOUR_IPS_REDUNDANCY",
            "resource_type": "google_compute_external_vpn_gateway"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-interface-1",
          "cspResourceId": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-1",
          "cspResourceDetail": {
            "id": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-1",
            "ip_range": "169.254.26.22/30",
            "name": "d0elsu66kj4nnv2lp2g0-interface-1",
            "resource_type": "google_compute_router_interface"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-interface-2",
          "cspResourceId": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-2",
          "cspResourceDetail": {
            "id": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-2",
            "ip_range": "169.254.86.14/30",
            "name": "d0elsu66kj4nnv2lp2g0-interface-2",
            "resource_type": "google_compute_router_interface"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-interface-3",
          "cspResourceId": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-3",
          "cspResourceDetail": {
            "id": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-3",
            "ip_range": "169.254.148.102/30",
            "name": "d0elsu66kj4nnv2lp2g0-interface-3",
            "resource_type": "google_compute_router_interface"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-interface-4",
          "cspResourceId": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-4",
          "cspResourceDetail": {
            "id": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-4",
            "ip_range": "169.254.201.90/30",
            "name": "d0elsu66kj4nnv2lp2g0-interface-4",
            "resource_type": "google_compute_router_interface"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-peer-1",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-1",
          "cspResourceDetail": {
            "id": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-1",
            "name": "d0elsu66kj4nnv2lp2g0-peer-1",
            "peer_asn": 64512,
            "peer_ip": "169.254.26.21",
            "resource_type": "google_compute_router_peer"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-peer-2",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-2",
          "cspResourceDetail": {
            "id": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-2",
            "name": "d0elsu66kj4nnv2lp2g0-peer-2",
            "peer_asn": 64512,
            "peer_ip": "169.254.86.13",
            "resource_type": "google_compute_router_peer"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-peer-3",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-3",
          "cspResourceDetail": {
            "id": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-3",
            "name": "d0elsu66kj4nnv2lp2g0-peer-3",
            "peer_asn": 64512,
            "peer_ip": "169.254.148.101",
            "resource_type": "google_compute_router_peer"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-peer-4",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-4",
          "cspResourceDetail": {
            "id": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-4",
            "name": "d0elsu66kj4nnv2lp2g0-peer-4",
            "peer_asn": 64512,
            "peer_ip": "169.254.201.89",
            "resource_type": "google_compute_router_peer"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-router",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router",
          "cspResourceDetail": {
            "bgp_asn": "65530",
            "id": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router",
            "name": "d0elsu66kj4nnv2lp2g0-router",
            "network": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/global/networks/d0ekuq1ivg86titl829g",
            "resource_type": "google_compute_router"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-tunnel-1",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-1",
          "cspResourceDetail": {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-1",
            "interface": 0,
            "name": "d0elsu66kj4nnv2lp2g0-tunnel-1",
            "peer_ip": "13.124.207.44",
            "resource_type": "google_compute_vpn_tunnel"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-tunnel-2",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-2",
          "cspResourceDetail": {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-2",
            "interface": 1,
            "name": "d0elsu66kj4nnv2lp2g0-tunnel-2",
            "peer_ip": "43.202.15.86",
            "resource_type": "google_compute_vpn_tunnel"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-tunnel-3",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-3",
          "cspResourceDetail": {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-3",
            "interface": 0,
            "name": "d0elsu66kj4nnv2lp2g0-tunnel-3",
            "peer_ip": "3.36.254.47",
            "resource_type": "google_compute_vpn_tunnel"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-tunnel-4",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-4",
          "cspResourceDetail": {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-4",
            "interface": 1,
            "name": "d0elsu66kj4nnv2lp2g0-tunnel-4",
            "peer_ip": "15.164.192.181",
            "resource_type": "google_compute_vpn_tunnel"
          }
        },
        {
          "cspResourceName": "d0elsu66kj4nnv2lp2g0-ha-vpn-gw",
          "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnGateways/d0elsu66kj4nnv2lp2g0-ha-vpn-gw",
          "cspResourceDetail": {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnGateways/d0elsu66kj4nnv2lp2g0-ha-vpn-gw",
            "name": "d0elsu66kj4nnv2lp2g0-ha-vpn-gw",
            "network": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/global/networks/d0ekuq1ivg86titl829g",
            "region": "asia-northeast3",
            "resource_type": "google_compute_ha_vpn_gateway"
          }
        }
      ]
    }
  ]
}
```


### Get all VPNs

* API: `GET /ns/{nsId}/mci/{mciId}/vpn`
* Params:
  - nsId: default
  - mciId: mci01
  - option: IdList
* Response body:   
```json
{
  "vpnIdList": [
    "vpn01"
  ]
}
```


### Get all VPNs

* API: `GET /ns/{nsId}/mci/{mciId}/vpn`
* Params:
  - nsId: default
  - mciId: mci01
  - option: InfoList
* Response body:   
```json
{
  "vpnInfoList": [
    {
      "resourceType": "vpn",
      "id": "vpn01",
      "uid": "d0elsu66kj4nnv2lp2g0",
      "name": "vpn01",
      "description": "VPN between aws and gcp",
      "status": "Available",
      "vpnSites": [
        {
          "connectionName": "aws-ap-northeast-2",
          "connectionConfig": {
            "configName": "aws-ap-northeast-2",
            "providerName": "aws",
            "driverName": "aws-driver-v1.0.so",
            "credentialName": "aws",
            "credentialHolder": "admin",
            "regionZoneInfoName": "aws-ap-northeast-2",
            "regionZoneInfo": {
              "assignedRegion": "ap-northeast-2",
              "assignedZone": "ap-northeast-2a"
            },
            "regionDetail": {
              "regionId": "ap-northeast-2",
              "regionName": "ap-northeast-2",
              "description": "Asia Pacific (Seoul)",
              "location": {
                "display": "South Korea (Seoul)",
                "latitude": 37.36,
                "longitude": 126.78
              },
              "zones": [
                "ap-northeast-2a",
                "ap-northeast-2b",
                "ap-northeast-2c",
                "ap-northeast-2d"
              ]
            },
            "regionRepresentative": true,
            "verified": true
          },
          "resourceDetails": [
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-gcp-side-gw-1",
              "cspResourceId": "cgw-09a6a7db47f619ac6",
              "cspResourceDetail": {
                "bgp_asn": "65530",
                "id": "cgw-09a6a7db47f619ac6",
                "ip_address": "34.152.96.47",
                "name": "d0elsu66kj4nnv2lp2g0-gcp-side-gw-1",
                "resource_type": "aws_customer_gateway"
              }
            },
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-gcp-side-gw-2",
              "cspResourceId": "cgw-0a4f5beb72d515993",
              "cspResourceDetail": {
                "bgp_asn": "65530",
                "id": "cgw-0a4f5beb72d515993",
                "ip_address": "34.177.64.188",
                "name": "d0elsu66kj4nnv2lp2g0-gcp-side-gw-2",
                "resource_type": "aws_customer_gateway"
              }
            },
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-to-gcp-1",
              "cspResourceId": "vpn-0ac3ec98e2833dcfb",
              "cspResourceDetail": {
                "id": "vpn-0ac3ec98e2833dcfb",
                "name": "d0elsu66kj4nnv2lp2g0-to-gcp-1",
                "resource_type": "aws_vpn_connection",
                "tunnel1_address": "13.124.207.44",
                "tunnel2_address": "43.202.15.86"
              }
            },
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-to-gcp-2",
              "cspResourceId": "vpn-0e6d4e2282783b8cc",
              "cspResourceDetail": {
                "id": "vpn-0e6d4e2282783b8cc",
                "name": "d0elsu66kj4nnv2lp2g0-to-gcp-2",
                "resource_type": "aws_vpn_connection",
                "tunnel1_address": "3.36.254.47",
                "tunnel2_address": "15.164.192.181"
              }
            },
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-vpn-gw",
              "cspResourceId": "vgw-0d9fec8466eb7191e",
              "cspResourceDetail": {
                "id": "vgw-0d9fec8466eb7191e",
                "name": "d0elsu66kj4nnv2lp2g0-vpn-gw",
                "resource_type": "aws_vpn_gateway",
                "vpc_id": "vpc-0d115018882a5c1eb"
              }
            }
          ]
        },
        {
          "connectionName": "gcp-asia-northeast3",
          "connectionConfig": {
            "configName": "gcp-asia-northeast3",
            "providerName": "gcp",
            "driverName": "gcp-driver-v1.0.so",
            "credentialName": "gcp",
            "credentialHolder": "admin",
            "regionZoneInfoName": "gcp-asia-northeast3",
            "regionZoneInfo": {
              "assignedRegion": "asia-northeast3",
              "assignedZone": "asia-northeast3-a"
            },
            "regionDetail": {
              "regionId": "asia-northeast3",
              "regionName": "asia-northeast3",
              "description": "Seoul South Korea",
              "location": {
                "display": "South Korea (Seoul)",
                "latitude": 37.2,
                "longitude": 127
              },
              "zones": [
                "asia-northeast3-a",
                "asia-northeast3-b",
                "asia-northeast3-c"
              ]
            },
            "regionRepresentative": true,
            "verified": true
          },
          "resourceDetails": [
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-aws-side-vpn-gw",
              "cspResourceId": "projects/ykkim-etri/global/externalVpnGateways/d0elsu66kj4nnv2lp2g0-aws-side-vpn-gw",
              "cspResourceDetail": {
                "description": "AWS-side VPN gateway",
                "id": "projects/ykkim-etri/global/externalVpnGateways/d0elsu66kj4nnv2lp2g0-aws-side-vpn-gw",
                "interfaces": [
                  {
                    "id": 0,
                    "ip_address": "13.124.207.44"
                  },
                  {
                    "id": 1,
                    "ip_address": "43.202.15.86"
                  },
                  {
                    "id": 2,
                    "ip_address": "3.36.254.47"
                  },
                  {
                    "id": 3,
                    "ip_address": "15.164.192.181"
                  }
                ],
                "name": "d0elsu66kj4nnv2lp2g0-aws-side-vpn-gw",
                "redundancy_type": "FOUR_IPS_REDUNDANCY",
                "resource_type": "google_compute_external_vpn_gateway"
              }
            },
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-interface-1",
              "cspResourceId": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-1",
              "cspResourceDetail": {
                "id": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-1",
                "ip_range": "169.254.26.22/30",
                "name": "d0elsu66kj4nnv2lp2g0-interface-1",
                "resource_type": "google_compute_router_interface"
              }
            },
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-interface-2",
              "cspResourceId": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-2",
              "cspResourceDetail": {
                "id": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-2",
                "ip_range": "169.254.86.14/30",
                "name": "d0elsu66kj4nnv2lp2g0-interface-2",
                "resource_type": "google_compute_router_interface"
              }
            },
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-interface-3",
              "cspResourceId": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-3",
              "cspResourceDetail": {
                "id": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-3",
                "ip_range": "169.254.148.102/30",
                "name": "d0elsu66kj4nnv2lp2g0-interface-3",
                "resource_type": "google_compute_router_interface"
              }
            },
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-interface-4",
              "cspResourceId": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-4",
              "cspResourceDetail": {
                "id": "asia-northeast3/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-interface-4",
                "ip_range": "169.254.201.90/30",
                "name": "d0elsu66kj4nnv2lp2g0-interface-4",
                "resource_type": "google_compute_router_interface"
              }
            },
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-peer-1",
              "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-1",
              "cspResourceDetail": {
                "id": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-1",
                "name": "d0elsu66kj4nnv2lp2g0-peer-1",
                "peer_asn": 64512,
                "peer_ip": "169.254.26.21",
                "resource_type": "google_compute_router_peer"
              }
            },
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-peer-2",
              "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-2",
              "cspResourceDetail": {
                "id": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-2",
                "name": "d0elsu66kj4nnv2lp2g0-peer-2",
                "peer_asn": 64512,
                "peer_ip": "169.254.86.13",
                "resource_type": "google_compute_router_peer"
              }
            },
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-peer-3",
              "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-3",
              "cspResourceDetail": {
                "id": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-3",
                "name": "d0elsu66kj4nnv2lp2g0-peer-3",
                "peer_asn": 64512,
                "peer_ip": "169.254.148.101",
                "resource_type": "google_compute_router_peer"
              }
            },
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-peer-4",
              "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-4",
              "cspResourceDetail": {
                "id": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router/d0elsu66kj4nnv2lp2g0-peer-4",
                "name": "d0elsu66kj4nnv2lp2g0-peer-4",
                "peer_asn": 64512,
                "peer_ip": "169.254.201.89",
                "resource_type": "google_compute_router_peer"
              }
            },
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-router",
              "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router",
              "cspResourceDetail": {
                "bgp_asn": "65530",
                "id": "projects/ykkim-etri/regions/asia-northeast3/routers/d0elsu66kj4nnv2lp2g0-router",
                "name": "d0elsu66kj4nnv2lp2g0-router",
                "network": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/global/networks/d0ekuq1ivg86titl829g",
                "resource_type": "google_compute_router"
              }
            },
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-tunnel-1",
              "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-1",
              "cspResourceDetail": {
                "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-1",
                "interface": 0,
                "name": "d0elsu66kj4nnv2lp2g0-tunnel-1",
                "peer_ip": "13.124.207.44",
                "resource_type": "google_compute_vpn_tunnel"
              }
            },
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-tunnel-2",
              "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-2",
              "cspResourceDetail": {
                "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-2",
                "interface": 1,
                "name": "d0elsu66kj4nnv2lp2g0-tunnel-2",
                "peer_ip": "43.202.15.86",
                "resource_type": "google_compute_vpn_tunnel"
              }
            },
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-tunnel-3",
              "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-3",
              "cspResourceDetail": {
                "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-3",
                "interface": 0,
                "name": "d0elsu66kj4nnv2lp2g0-tunnel-3",
                "peer_ip": "3.36.254.47",
                "resource_type": "google_compute_vpn_tunnel"
              }
            },
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-tunnel-4",
              "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-4",
              "cspResourceDetail": {
                "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/d0elsu66kj4nnv2lp2g0-tunnel-4",
                "interface": 1,
                "name": "d0elsu66kj4nnv2lp2g0-tunnel-4",
                "peer_ip": "15.164.192.181",
                "resource_type": "google_compute_vpn_tunnel"
              }
            },
            {
              "cspResourceName": "d0elsu66kj4nnv2lp2g0-ha-vpn-gw",
              "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnGateways/d0elsu66kj4nnv2lp2g0-ha-vpn-gw",
              "cspResourceDetail": {
                "id": "projects/ykkim-etri/regions/asia-northeast3/vpnGateways/d0elsu66kj4nnv2lp2g0-ha-vpn-gw",
                "name": "d0elsu66kj4nnv2lp2g0-ha-vpn-gw",
                "network": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/global/networks/d0ekuq1ivg86titl829g",
                "region": "asia-northeast3",
                "resource_type": "google_compute_ha_vpn_gateway"
              }
            }
          ]
        }
      ]
    }
  ]
}
```


### Ping test

> [!NOTE]
> I plan to update to use built-in functions. 

* API: `POST /ns/{nsId}/cmd/mci/{mciId}`
* Params:
  - nsId: default
  - mciId: mci01
  - vmId: d0ekuq1ivg86titl827g-1
* Request body:   
```json
{
  "command": [
    "ping 10.105.0.2 -c 1"
  ],
  "userName": "cb-user"
}
```

* Response body:   
```json
{
  "results": [
    {
      "mciId": "mci01",
      "vmId": "d0ekuq1ivg86titl827g-1",
      "vmIp": "43.203.217.241",
      "command": {
        "0": "ping 10.105.0.2 -c 1"
      },
      "stdout": {
        "0": "PING 10.105.0.2 (10.105.0.2) 56(84) bytes of data.\n64 bytes from 10.105.0.2: icmp_seq=1 ttl=63 time=5.27 ms\n\n--- 10.105.0.2 ping statistics ---\n1 packets transmitted, 1 received, 0% packet loss, time 0ms\nrtt min/avg/max/mdev = 5.265/5.265/5.265/0.000 ms\n"
      },
      "stderr": {
        "0": ""
      },
      "err": null
    }
  ]
}
```


### Delete VPN 

* API: `DELETE /ns/{nsId}/mci/{mciId}/vpn/{vpnId}`
* Params:
  - nsId: default
  - mciId: mci01
  - vpnId: vpn01
* Response body:   
```json
{
  "message": "successfully deleted the site-to-site VPN (vpn01)"
}
```


---

## Site-to-site VPN between AWS and Azure

### Create VPN 

* API: `POST /ns/{nsId}/mci/{mciId}/vpn`
* Params:
  - nsId: default
  - mciId: mci01
* Request body:   
```json
{
  "name": "vpn01",
  "site1": {
    "cspSpecificProperty": {
      "aws": {
        "bgpAsn": "64512"
      }
    },
    "vNetId": "default-shared-aws-ap-northeast-2"
  },
  "site2": {
    "cspSpecificProperty": {
      "azure": {
        "bgpAsn": "65531",
        "gatewaySubnetCidr": "",
        "vpnSku": "VpnGw1AZ"
      }
    },
    "vNetId": "default-shared-azure-koreacentral"
  }
}
```

* Response body:   
```json
{
  "resourceType": "vpn",
  "id": "vpn01",
  "uid": "d0em4rm6kj4nnv2lp2gg",
  "name": "vpn01",
  "description": "VPN between aws and azure",
  "status": "Available",
  "vpnSites": [
    {
      "connectionName": "aws-ap-northeast-2",
      "connectionConfig": {
        "configName": "aws-ap-northeast-2",
        "providerName": "aws",
        "driverName": "aws-driver-v1.0.so",
        "credentialName": "aws",
        "credentialHolder": "admin",
        "regionZoneInfoName": "aws-ap-northeast-2",
        "regionZoneInfo": {
          "assignedRegion": "ap-northeast-2",
          "assignedZone": "ap-northeast-2a"
        },
        "regionDetail": {
          "regionId": "ap-northeast-2",
          "regionName": "ap-northeast-2",
          "description": "Asia Pacific (Seoul)",
          "location": {
            "display": "South Korea (Seoul)",
            "latitude": 37.36,
            "longitude": 126.78
          },
          "zones": [
            "ap-northeast-2a",
            "ap-northeast-2b",
            "ap-northeast-2c",
            "ap-northeast-2d"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "resourceDetails": [
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-azure-side-gw-1",
          "cspResourceId": "cgw-01e3a068865dfa9b1",
          "cspResourceDetail": {
            "bgp_asn": "65531",
            "id": "cgw-01e3a068865dfa9b1",
            "ip_address": "4.217.129.45",
            "name": "d0em4rm6kj4nnv2lp2gg-azure-side-gw-1",
            "resource_type": "aws_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-azure-side-gw-2",
          "cspResourceId": "cgw-02820de46990d45e9",
          "cspResourceDetail": {
            "bgp_asn": "65531",
            "id": "cgw-02820de46990d45e9",
            "ip_address": "4.217.129.5",
            "name": "d0em4rm6kj4nnv2lp2gg-azure-side-gw-2",
            "resource_type": "aws_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-to-azure-1",
          "cspResourceId": "vpn-09bee621b6269fc82",
          "cspResourceDetail": {
            "id": "vpn-09bee621b6269fc82",
            "name": "d0em4rm6kj4nnv2lp2gg-to-azure-1",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "13.124.208.68",
            "tunnel2_address": "13.209.175.93"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-to-azure-2",
          "cspResourceId": "vpn-0ab0c6c6267423571",
          "cspResourceDetail": {
            "id": "vpn-0ab0c6c6267423571",
            "name": "d0em4rm6kj4nnv2lp2gg-to-azure-2",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "15.164.26.151",
            "tunnel2_address": "43.202.39.242"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-vpn-gw",
          "cspResourceId": "vgw-0af9a9329036bb82a",
          "cspResourceDetail": {
            "id": "vgw-0af9a9329036bb82a",
            "name": "d0em4rm6kj4nnv2lp2gg-vpn-gw",
            "resource_type": "aws_vpn_gateway",
            "vpc_id": "vpc-0d115018882a5c1eb"
          }
        }
      ]
    },
    {
      "connectionName": "azure-koreacentral",
      "connectionConfig": {
        "configName": "azure-koreacentral",
        "providerName": "azure",
        "driverName": "azure-driver-v1.0.so",
        "credentialName": "azure",
        "credentialHolder": "admin",
        "regionZoneInfoName": "azure-koreacentral",
        "regionZoneInfo": {
          "assignedRegion": "koreacentral",
          "assignedZone": "1"
        },
        "regionDetail": {
          "regionId": "koreacentral",
          "regionName": "koreacentral",
          "description": "Korea Central",
          "location": {
            "display": "Korea Central",
            "latitude": 37.5665,
            "longitude": 126.978
          },
          "zones": [
            "1",
            "2",
            "3"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "resourceDetails": [
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-to-aws-1",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-1",
          "cspResourceDetail": {
            "enable_bgp": true,
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-1",
            "name": "d0em4rm6kj4nnv2lp2gg-to-aws-1",
            "resource_type": "azurerm_virtual_network_gateway_connection",
            "type": "IPsec"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-to-aws-2",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-2",
          "cspResourceDetail": {
            "enable_bgp": true,
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-2",
            "name": "d0em4rm6kj4nnv2lp2gg-to-aws-2",
            "resource_type": "azurerm_virtual_network_gateway_connection",
            "type": "IPsec"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-to-aws-3",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-3",
          "cspResourceDetail": {
            "enable_bgp": true,
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-3",
            "name": "d0em4rm6kj4nnv2lp2gg-to-aws-3",
            "resource_type": "azurerm_virtual_network_gateway_connection",
            "type": "IPsec"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-to-aws-4",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-4",
          "cspResourceDetail": {
            "enable_bgp": true,
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-4",
            "name": "d0em4rm6kj4nnv2lp2gg-to-aws-4",
            "resource_type": "azurerm_virtual_network_gateway_connection",
            "type": "IPsec"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-aws-side-1",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-1",
          "cspResourceDetail": {
            "gateway_address": "13.124.208.68",
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-1",
            "name": "d0em4rm6kj4nnv2lp2gg-aws-side-1",
            "resource_type": "azurerm_local_network_gateway"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-aws-side-2",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-2",
          "cspResourceDetail": {
            "gateway_address": "13.209.175.93",
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-2",
            "name": "d0em4rm6kj4nnv2lp2gg-aws-side-2",
            "resource_type": "azurerm_local_network_gateway"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-aws-side-3",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-3",
          "cspResourceDetail": {
            "gateway_address": "15.164.26.151",
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-3",
            "name": "d0em4rm6kj4nnv2lp2gg-aws-side-3",
            "resource_type": "azurerm_local_network_gateway"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-aws-side-4",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-4",
          "cspResourceDetail": {
            "gateway_address": "43.202.39.242",
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-4",
            "name": "d0em4rm6kj4nnv2lp2gg-aws-side-4",
            "resource_type": "azurerm_local_network_gateway"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-vpn-ip-1",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/publicIPAddresses/d0em4rm6kj4nnv2lp2gg-vpn-ip-1",
          "cspResourceDetail": {
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/publicIPAddresses/d0em4rm6kj4nnv2lp2gg-vpn-ip-1",
            "ip_address": "4.217.129.45",
            "name": "d0em4rm6kj4nnv2lp2gg-vpn-ip-1",
            "resource_type": "azurerm_public_ip"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-vpn-ip-2",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/publicIPAddresses/d0em4rm6kj4nnv2lp2gg-vpn-ip-2",
          "cspResourceDetail": {
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/publicIPAddresses/d0em4rm6kj4nnv2lp2gg-vpn-ip-2",
            "ip_address": "4.217.129.5",
            "name": "d0em4rm6kj4nnv2lp2gg-vpn-ip-2",
            "resource_type": "azurerm_public_ip"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-vpn-gateway",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/virtualNetworkGateways/d0em4rm6kj4nnv2lp2gg-vpn-gateway",
          "cspResourceDetail": {
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/virtualNetworkGateways/d0em4rm6kj4nnv2lp2gg-vpn-gateway",
            "location": "koreacentral",
            "name": "d0em4rm6kj4nnv2lp2gg-vpn-gateway",
            "resource_type": "azurerm_virtual_network_gateway",
            "sku": "VpnGw1AZ"
          }
        }
      ]
    }
  ]
}
```


### Get VPN 

* API: `GET /ns/{nsId}/mci/{mciId}/vpn/{vpnId}`
* Params:
  - nsId: default
  - mciId: mci01
  - vpnId: vpn01
* Response body:   
```json
{
  "resourceType": "vpn",
  "id": "vpn01",
  "uid": "d0em4rm6kj4nnv2lp2gg",
  "name": "vpn01",
  "description": "VPN between aws and azure",
  "status": "Available",
  "vpnSites": [
    {
      "connectionName": "aws-ap-northeast-2",
      "connectionConfig": {
        "configName": "aws-ap-northeast-2",
        "providerName": "aws",
        "driverName": "aws-driver-v1.0.so",
        "credentialName": "aws",
        "credentialHolder": "admin",
        "regionZoneInfoName": "aws-ap-northeast-2",
        "regionZoneInfo": {
          "assignedRegion": "ap-northeast-2",
          "assignedZone": "ap-northeast-2a"
        },
        "regionDetail": {
          "regionId": "ap-northeast-2",
          "regionName": "ap-northeast-2",
          "description": "Asia Pacific (Seoul)",
          "location": {
            "display": "South Korea (Seoul)",
            "latitude": 37.36,
            "longitude": 126.78
          },
          "zones": [
            "ap-northeast-2a",
            "ap-northeast-2b",
            "ap-northeast-2c",
            "ap-northeast-2d"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "resourceDetails": [
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-azure-side-gw-1",
          "cspResourceId": "cgw-01e3a068865dfa9b1",
          "cspResourceDetail": {
            "bgp_asn": "65531",
            "id": "cgw-01e3a068865dfa9b1",
            "ip_address": "4.217.129.45",
            "name": "d0em4rm6kj4nnv2lp2gg-azure-side-gw-1",
            "resource_type": "aws_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-azure-side-gw-2",
          "cspResourceId": "cgw-02820de46990d45e9",
          "cspResourceDetail": {
            "bgp_asn": "65531",
            "id": "cgw-02820de46990d45e9",
            "ip_address": "4.217.129.5",
            "name": "d0em4rm6kj4nnv2lp2gg-azure-side-gw-2",
            "resource_type": "aws_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-to-azure-1",
          "cspResourceId": "vpn-09bee621b6269fc82",
          "cspResourceDetail": {
            "id": "vpn-09bee621b6269fc82",
            "name": "d0em4rm6kj4nnv2lp2gg-to-azure-1",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "13.124.208.68",
            "tunnel2_address": "13.209.175.93"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-to-azure-2",
          "cspResourceId": "vpn-0ab0c6c6267423571",
          "cspResourceDetail": {
            "id": "vpn-0ab0c6c6267423571",
            "name": "d0em4rm6kj4nnv2lp2gg-to-azure-2",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "15.164.26.151",
            "tunnel2_address": "43.202.39.242"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-vpn-gw",
          "cspResourceId": "vgw-0af9a9329036bb82a",
          "cspResourceDetail": {
            "id": "vgw-0af9a9329036bb82a",
            "name": "d0em4rm6kj4nnv2lp2gg-vpn-gw",
            "resource_type": "aws_vpn_gateway",
            "vpc_id": "vpc-0d115018882a5c1eb"
          }
        }
      ]
    },
    {
      "connectionName": "azure-koreacentral",
      "connectionConfig": {
        "configName": "azure-koreacentral",
        "providerName": "azure",
        "driverName": "azure-driver-v1.0.so",
        "credentialName": "azure",
        "credentialHolder": "admin",
        "regionZoneInfoName": "azure-koreacentral",
        "regionZoneInfo": {
          "assignedRegion": "koreacentral",
          "assignedZone": "1"
        },
        "regionDetail": {
          "regionId": "koreacentral",
          "regionName": "koreacentral",
          "description": "Korea Central",
          "location": {
            "display": "Korea Central",
            "latitude": 37.5665,
            "longitude": 126.978
          },
          "zones": [
            "1",
            "2",
            "3"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "resourceDetails": [
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-aws-side-1",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-1",
          "cspResourceDetail": {
            "gateway_address": "13.124.208.68",
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-1",
            "name": "d0em4rm6kj4nnv2lp2gg-aws-side-1",
            "resource_type": "azurerm_local_network_gateway"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-aws-side-2",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-2",
          "cspResourceDetail": {
            "gateway_address": "13.209.175.93",
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-2",
            "name": "d0em4rm6kj4nnv2lp2gg-aws-side-2",
            "resource_type": "azurerm_local_network_gateway"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-aws-side-3",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-3",
          "cspResourceDetail": {
            "gateway_address": "15.164.26.151",
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-3",
            "name": "d0em4rm6kj4nnv2lp2gg-aws-side-3",
            "resource_type": "azurerm_local_network_gateway"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-aws-side-4",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-4",
          "cspResourceDetail": {
            "gateway_address": "43.202.39.242",
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-4",
            "name": "d0em4rm6kj4nnv2lp2gg-aws-side-4",
            "resource_type": "azurerm_local_network_gateway"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-vpn-ip-1",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/publicIPAddresses/d0em4rm6kj4nnv2lp2gg-vpn-ip-1",
          "cspResourceDetail": {
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/publicIPAddresses/d0em4rm6kj4nnv2lp2gg-vpn-ip-1",
            "ip_address": "4.217.129.45",
            "name": "d0em4rm6kj4nnv2lp2gg-vpn-ip-1",
            "resource_type": "azurerm_public_ip"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-vpn-ip-2",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/publicIPAddresses/d0em4rm6kj4nnv2lp2gg-vpn-ip-2",
          "cspResourceDetail": {
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/publicIPAddresses/d0em4rm6kj4nnv2lp2gg-vpn-ip-2",
            "ip_address": "4.217.129.5",
            "name": "d0em4rm6kj4nnv2lp2gg-vpn-ip-2",
            "resource_type": "azurerm_public_ip"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-vpn-gateway",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/virtualNetworkGateways/d0em4rm6kj4nnv2lp2gg-vpn-gateway",
          "cspResourceDetail": {
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/virtualNetworkGateways/d0em4rm6kj4nnv2lp2gg-vpn-gateway",
            "location": "koreacentral",
            "name": "d0em4rm6kj4nnv2lp2gg-vpn-gateway",
            "resource_type": "azurerm_virtual_network_gateway",
            "sku": "VpnGw1AZ"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-to-aws-1",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-1",
          "cspResourceDetail": {
            "enable_bgp": true,
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-1",
            "name": "d0em4rm6kj4nnv2lp2gg-to-aws-1",
            "resource_type": "azurerm_virtual_network_gateway_connection",
            "type": "IPsec"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-to-aws-2",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-2",
          "cspResourceDetail": {
            "enable_bgp": true,
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-2",
            "name": "d0em4rm6kj4nnv2lp2gg-to-aws-2",
            "resource_type": "azurerm_virtual_network_gateway_connection",
            "type": "IPsec"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-to-aws-3",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-3",
          "cspResourceDetail": {
            "enable_bgp": true,
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-3",
            "name": "d0em4rm6kj4nnv2lp2gg-to-aws-3",
            "resource_type": "azurerm_virtual_network_gateway_connection",
            "type": "IPsec"
          }
        },
        {
          "cspResourceName": "d0em4rm6kj4nnv2lp2gg-to-aws-4",
          "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-4",
          "cspResourceDetail": {
            "enable_bgp": true,
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-4",
            "name": "d0em4rm6kj4nnv2lp2gg-to-aws-4",
            "resource_type": "azurerm_virtual_network_gateway_connection",
            "type": "IPsec"
          }
        }
      ]
    }
  ]
}
```


### Get all VPNs

* API: `GET /ns/{nsId}/mci/{mciId}/vpn`
* Params:
  - nsId: default
  - mciId: mci01
  - option: IdList
* Response body:   
```json
{
  "vpnIdList": [
    "vpn01"
  ]
}
```


### Get all VPNs

* API: `GET /ns/{nsId}/mci/{mciId}/vpn`
* Params:
  - nsId: default
  - mciId: mci01
  - option: InfoList
* Response body:   
```json
{
  "vpnInfoList": [
    {
      "resourceType": "vpn",
      "id": "vpn01",
      "uid": "d0em4rm6kj4nnv2lp2gg",
      "name": "vpn01",
      "description": "VPN between aws and azure",
      "status": "Available",
      "vpnSites": [
        {
          "connectionName": "aws-ap-northeast-2",
          "connectionConfig": {
            "configName": "aws-ap-northeast-2",
            "providerName": "aws",
            "driverName": "aws-driver-v1.0.so",
            "credentialName": "aws",
            "credentialHolder": "admin",
            "regionZoneInfoName": "aws-ap-northeast-2",
            "regionZoneInfo": {
              "assignedRegion": "ap-northeast-2",
              "assignedZone": "ap-northeast-2a"
            },
            "regionDetail": {
              "regionId": "ap-northeast-2",
              "regionName": "ap-northeast-2",
              "description": "Asia Pacific (Seoul)",
              "location": {
                "display": "South Korea (Seoul)",
                "latitude": 37.36,
                "longitude": 126.78
              },
              "zones": [
                "ap-northeast-2a",
                "ap-northeast-2b",
                "ap-northeast-2c",
                "ap-northeast-2d"
              ]
            },
            "regionRepresentative": true,
            "verified": true
          },
          "resourceDetails": [
            {
              "cspResourceName": "d0em4rm6kj4nnv2lp2gg-azure-side-gw-1",
              "cspResourceId": "cgw-01e3a068865dfa9b1",
              "cspResourceDetail": {
                "bgp_asn": "65531",
                "id": "cgw-01e3a068865dfa9b1",
                "ip_address": "4.217.129.45",
                "name": "d0em4rm6kj4nnv2lp2gg-azure-side-gw-1",
                "resource_type": "aws_customer_gateway"
              }
            },
            {
              "cspResourceName": "d0em4rm6kj4nnv2lp2gg-azure-side-gw-2",
              "cspResourceId": "cgw-02820de46990d45e9",
              "cspResourceDetail": {
                "bgp_asn": "65531",
                "id": "cgw-02820de46990d45e9",
                "ip_address": "4.217.129.5",
                "name": "d0em4rm6kj4nnv2lp2gg-azure-side-gw-2",
                "resource_type": "aws_customer_gateway"
              }
            },
            {
              "cspResourceName": "d0em4rm6kj4nnv2lp2gg-to-azure-1",
              "cspResourceId": "vpn-09bee621b6269fc82",
              "cspResourceDetail": {
                "id": "vpn-09bee621b6269fc82",
                "name": "d0em4rm6kj4nnv2lp2gg-to-azure-1",
                "resource_type": "aws_vpn_connection",
                "tunnel1_address": "13.124.208.68",
                "tunnel2_address": "13.209.175.93"
              }
            },
            {
              "cspResourceName": "d0em4rm6kj4nnv2lp2gg-to-azure-2",
              "cspResourceId": "vpn-0ab0c6c6267423571",
              "cspResourceDetail": {
                "id": "vpn-0ab0c6c6267423571",
                "name": "d0em4rm6kj4nnv2lp2gg-to-azure-2",
                "resource_type": "aws_vpn_connection",
                "tunnel1_address": "15.164.26.151",
                "tunnel2_address": "43.202.39.242"
              }
            },
            {
              "cspResourceName": "d0em4rm6kj4nnv2lp2gg-vpn-gw",
              "cspResourceId": "vgw-0af9a9329036bb82a",
              "cspResourceDetail": {
                "id": "vgw-0af9a9329036bb82a",
                "name": "d0em4rm6kj4nnv2lp2gg-vpn-gw",
                "resource_type": "aws_vpn_gateway",
                "vpc_id": "vpc-0d115018882a5c1eb"
              }
            }
          ]
        },
        {
          "connectionName": "azure-koreacentral",
          "connectionConfig": {
            "configName": "azure-koreacentral",
            "providerName": "azure",
            "driverName": "azure-driver-v1.0.so",
            "credentialName": "azure",
            "credentialHolder": "admin",
            "regionZoneInfoName": "azure-koreacentral",
            "regionZoneInfo": {
              "assignedRegion": "koreacentral",
              "assignedZone": "1"
            },
            "regionDetail": {
              "regionId": "koreacentral",
              "regionName": "koreacentral",
              "description": "Korea Central",
              "location": {
                "display": "Korea Central",
                "latitude": 37.5665,
                "longitude": 126.978
              },
              "zones": [
                "1",
                "2",
                "3"
              ]
            },
            "regionRepresentative": true,
            "verified": true
          },
          "resourceDetails": [
            {
              "cspResourceName": "d0em4rm6kj4nnv2lp2gg-aws-side-1",
              "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-1",
              "cspResourceDetail": {
                "gateway_address": "13.124.208.68",
                "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-1",
                "name": "d0em4rm6kj4nnv2lp2gg-aws-side-1",
                "resource_type": "azurerm_local_network_gateway"
              }
            },
            {
              "cspResourceName": "d0em4rm6kj4nnv2lp2gg-aws-side-2",
              "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-2",
              "cspResourceDetail": {
                "gateway_address": "13.209.175.93",
                "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-2",
                "name": "d0em4rm6kj4nnv2lp2gg-aws-side-2",
                "resource_type": "azurerm_local_network_gateway"
              }
            },
            {
              "cspResourceName": "d0em4rm6kj4nnv2lp2gg-aws-side-3",
              "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-3",
              "cspResourceDetail": {
                "gateway_address": "15.164.26.151",
                "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-3",
                "name": "d0em4rm6kj4nnv2lp2gg-aws-side-3",
                "resource_type": "azurerm_local_network_gateway"
              }
            },
            {
              "cspResourceName": "d0em4rm6kj4nnv2lp2gg-aws-side-4",
              "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-4",
              "cspResourceDetail": {
                "gateway_address": "43.202.39.242",
                "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/localNetworkGateways/d0em4rm6kj4nnv2lp2gg-aws-side-4",
                "name": "d0em4rm6kj4nnv2lp2gg-aws-side-4",
                "resource_type": "azurerm_local_network_gateway"
              }
            },
            {
              "cspResourceName": "d0em4rm6kj4nnv2lp2gg-vpn-ip-1",
              "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/publicIPAddresses/d0em4rm6kj4nnv2lp2gg-vpn-ip-1",
              "cspResourceDetail": {
                "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/publicIPAddresses/d0em4rm6kj4nnv2lp2gg-vpn-ip-1",
                "ip_address": "4.217.129.45",
                "name": "d0em4rm6kj4nnv2lp2gg-vpn-ip-1",
                "resource_type": "azurerm_public_ip"
              }
            },
            {
              "cspResourceName": "d0em4rm6kj4nnv2lp2gg-vpn-ip-2",
              "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/publicIPAddresses/d0em4rm6kj4nnv2lp2gg-vpn-ip-2",
              "cspResourceDetail": {
                "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/publicIPAddresses/d0em4rm6kj4nnv2lp2gg-vpn-ip-2",
                "ip_address": "4.217.129.5",
                "name": "d0em4rm6kj4nnv2lp2gg-vpn-ip-2",
                "resource_type": "azurerm_public_ip"
              }
            },
            {
              "cspResourceName": "d0em4rm6kj4nnv2lp2gg-vpn-gateway",
              "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/virtualNetworkGateways/d0em4rm6kj4nnv2lp2gg-vpn-gateway",
              "cspResourceDetail": {
                "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/virtualNetworkGateways/d0em4rm6kj4nnv2lp2gg-vpn-gateway",
                "location": "koreacentral",
                "name": "d0em4rm6kj4nnv2lp2gg-vpn-gateway",
                "resource_type": "azurerm_virtual_network_gateway",
                "sku": "VpnGw1AZ"
              }
            },
            {
              "cspResourceName": "d0em4rm6kj4nnv2lp2gg-to-aws-1",
              "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-1",
              "cspResourceDetail": {
                "enable_bgp": true,
                "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-1",
                "name": "d0em4rm6kj4nnv2lp2gg-to-aws-1",
                "resource_type": "azurerm_virtual_network_gateway_connection",
                "type": "IPsec"
              }
            },
            {
              "cspResourceName": "d0em4rm6kj4nnv2lp2gg-to-aws-2",
              "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-2",
              "cspResourceDetail": {
                "enable_bgp": true,
                "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-2",
                "name": "d0em4rm6kj4nnv2lp2gg-to-aws-2",
                "resource_type": "azurerm_virtual_network_gateway_connection",
                "type": "IPsec"
              }
            },
            {
              "cspResourceName": "d0em4rm6kj4nnv2lp2gg-to-aws-3",
              "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-3",
              "cspResourceDetail": {
                "enable_bgp": true,
                "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-3",
                "name": "d0em4rm6kj4nnv2lp2gg-to-aws-3",
                "resource_type": "azurerm_virtual_network_gateway_connection",
                "type": "IPsec"
              }
            },
            {
              "cspResourceName": "d0em4rm6kj4nnv2lp2gg-to-aws-4",
              "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-4",
              "cspResourceDetail": {
                "enable_bgp": true,
                "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/d0em4rm6kj4nnv2lp2gg-to-aws-4",
                "name": "d0em4rm6kj4nnv2lp2gg-to-aws-4",
                "resource_type": "azurerm_virtual_network_gateway_connection",
                "type": "IPsec"
              }
            }
          ]
        }
      ]
    }
  ]
}
```



### Ping test

* API: `POST /ns/{nsId}/cmd/mci/{mciId}`
* Params:
  - nsId: default
  - mciId: mci01
  - vmId: d0ekuq1ivg86titl827g-1
* Request body:   
```json
{
  "command": [
    "ping 10.76.0.4 -c 1"
  ],
  "userName": "cb-user"
}
```

* Response body:   
```json
{
  "results": [
    {
      "mciId": "mci01",
      "vmId": "d0ekuq1ivg86titl827g-1",
      "vmIp": "43.203.217.241",
      "command": {
        "0": "ping 10.76.0.4 -c 1"
      },
      "stdout": {
        "0": "PING 10.76.0.4 (10.76.0.4) 56(84) bytes of data.\n64 bytes from 10.76.0.4: icmp_seq=1 ttl=64 time=5.88 ms\n\n--- 10.76.0.4 ping statistics ---\n1 packets transmitted, 1 received, 0% packet loss, time 0ms\nrtt min/avg/max/mdev = 5.875/5.875/5.875/0.000 ms\n"
      },
      "stderr": {
        "0": ""
      },
      "err": null
    }
  ]
}
```


### Delete VPN 

* API: `DELETE /ns/{nsId}/mci/{mciId}/vpn/{vpnId}`
* Params:
  - nsId: default
  - mciId: mci01
  - vpnId: vpn01
* Response body:   
```json
{
  "message": "successfully deleted the site-to-site VPN (vpn01)"
}
```


---

## Site-to-site VPN between AWS and Alibaba

### Create VPN 

* API: `POST /ns/{nsId}/mci/{mciId}/vpn`
* Params:
  - nsId: default
  - mciId: mci01
* Request body:   
```json
{
  "name": "vpn01",
  "site1": {
    "cspSpecificProperty": {
      "aws": {
        "bgpAsn": "64512"
      }
    },
    "vNetId": "default-shared-aws-ap-northeast-2"
  },
  "site2": {
    "cspSpecificProperty": {
      "alibaba": {
        "bgpAsn": "65532"
      }
    },
    "vNetId": "default-shared-alibaba-ap-northeast-2"
  }
}
```

* Response body:   
```json
{
  "resourceType": "vpn",
  "id": "vpn01",
  "uid": "d0el13pivg86titl82s0",
  "name": "vpn01",
  "description": "VPN between aws and alibaba",
  "status": "Available",
  "vpnSites": [
    {
      "connectionName": "aws-ap-northeast-2",
      "connectionConfig": {
        "configName": "aws-ap-northeast-2",
        "providerName": "aws",
        "driverName": "aws-driver-v1.0.so",
        "credentialName": "aws",
        "credentialHolder": "admin",
        "regionZoneInfoName": "aws-ap-northeast-2",
        "regionZoneInfo": {
          "assignedRegion": "ap-northeast-2",
          "assignedZone": "ap-northeast-2a"
        },
        "regionDetail": {
          "regionId": "ap-northeast-2",
          "regionName": "ap-northeast-2",
          "description": "Asia Pacific (Seoul)",
          "location": {
            "display": "South Korea (Seoul)",
            "latitude": 37.36,
            "longitude": 126.78
          },
          "zones": [
            "ap-northeast-2a",
            "ap-northeast-2b",
            "ap-northeast-2c",
            "ap-northeast-2d"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "resourceDetails": [
        {
          "cspResourceName": "d0el13pivg86titl82s0-to-alibaba-1",
          "cspResourceId": "vpn-077f6a044c2162d1f",
          "cspResourceDetail": {
            "id": "vpn-077f6a044c2162d1f",
            "name": "d0el13pivg86titl82s0-to-alibaba-1",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "3.37.71.47",
            "tunnel2_address": "15.165.246.79"
          }
        },
        {
          "cspResourceName": "d0el13pivg86titl82s0-to-alibaba-2",
          "cspResourceId": "vpn-08d055a13c0184f67",
          "cspResourceDetail": {
            "id": "vpn-08d055a13c0184f67",
            "name": "d0el13pivg86titl82s0-to-alibaba-2",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "3.34.232.91",
            "tunnel2_address": "43.200.45.202"
          }
        },
        {
          "cspResourceName": "d0el13pivg86titl82s0-vpn-gw",
          "cspResourceId": "vgw-04f832c1dd06650da",
          "cspResourceDetail": {
            "id": "vgw-04f832c1dd06650da",
            "name": "d0el13pivg86titl82s0-vpn-gw",
            "resource_type": "aws_vpn_gateway",
            "vpc_id": "vpc-0d115018882a5c1eb"
          }
        },
        {
          "cspResourceName": "d0el13pivg86titl82s0-alibaba-side-gw-1",
          "cspResourceId": "cgw-0730fd8b60a04f853",
          "cspResourceDetail": {
            "bgp_asn": "65532",
            "id": "cgw-0730fd8b60a04f853",
            "ip_address": "47.80.3.199",
            "name": "d0el13pivg86titl82s0-alibaba-side-gw-1",
            "resource_type": "aws_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0el13pivg86titl82s0-alibaba-side-gw-2",
          "cspResourceId": "cgw-0431c30173baa1f8c",
          "cspResourceDetail": {
            "bgp_asn": "65532",
            "id": "cgw-0431c30173baa1f8c",
            "ip_address": "8.213.147.169",
            "name": "d0el13pivg86titl82s0-alibaba-side-gw-2",
            "resource_type": "aws_customer_gateway"
          }
        }
      ]
    },
    {
      "connectionName": "alibaba-ap-northeast-2",
      "connectionConfig": {
        "configName": "alibaba-ap-northeast-2",
        "providerName": "alibaba",
        "driverName": "alibaba-driver-v1.0.so",
        "credentialName": "alibaba",
        "credentialHolder": "admin",
        "regionZoneInfoName": "alibaba-ap-northeast-2",
        "regionZoneInfo": {
          "assignedRegion": "ap-northeast-2",
          "assignedZone": "ap-northeast-2a"
        },
        "regionDetail": {
          "regionId": "ap-northeast-2",
          "regionName": "ap-northeast-2",
          "description": "South Korea (Seoul)",
          "location": {
            "display": "South Korea (Seoul)",
            "latitude": 37.36,
            "longitude": 126.78
          },
          "zones": [
            "ap-northeast-2a"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "resourceDetails": null
    }
  ]
}
```


### Get VPN 

* API: `GET /ns/{nsId}/mci/{mciId}/vpn/{vpnId}`
* Params:
  - nsId: default
  - mciId: mci01
  - vpnId: vpn01
* Response body:   
```json
{
  "resourceType": "vpn",
  "id": "vpn01",
  "uid": "d0el13pivg86titl82s0",
  "name": "vpn01",
  "description": "VPN between aws and alibaba",
  "status": "Available",
  "vpnSites": [
    {
      "connectionName": "aws-ap-northeast-2",
      "connectionConfig": {
        "configName": "aws-ap-northeast-2",
        "providerName": "aws",
        "driverName": "aws-driver-v1.0.so",
        "credentialName": "aws",
        "credentialHolder": "admin",
        "regionZoneInfoName": "aws-ap-northeast-2",
        "regionZoneInfo": {
          "assignedRegion": "ap-northeast-2",
          "assignedZone": "ap-northeast-2a"
        },
        "regionDetail": {
          "regionId": "ap-northeast-2",
          "regionName": "ap-northeast-2",
          "description": "Asia Pacific (Seoul)",
          "location": {
            "display": "South Korea (Seoul)",
            "latitude": 37.36,
            "longitude": 126.78
          },
          "zones": [
            "ap-northeast-2a",
            "ap-northeast-2b",
            "ap-northeast-2c",
            "ap-northeast-2d"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "resourceDetails": [
        {
          "cspResourceName": "d0el13pivg86titl82s0-to-alibaba-1",
          "cspResourceId": "vpn-077f6a044c2162d1f",
          "cspResourceDetail": {
            "id": "vpn-077f6a044c2162d1f",
            "name": "d0el13pivg86titl82s0-to-alibaba-1",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "3.37.71.47",
            "tunnel2_address": "15.165.246.79"
          }
        },
        {
          "cspResourceName": "d0el13pivg86titl82s0-to-alibaba-2",
          "cspResourceId": "vpn-08d055a13c0184f67",
          "cspResourceDetail": {
            "id": "vpn-08d055a13c0184f67",
            "name": "d0el13pivg86titl82s0-to-alibaba-2",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "3.34.232.91",
            "tunnel2_address": "43.200.45.202"
          }
        },
        {
          "cspResourceName": "d0el13pivg86titl82s0-vpn-gw",
          "cspResourceId": "vgw-04f832c1dd06650da",
          "cspResourceDetail": {
            "id": "vgw-04f832c1dd06650da",
            "name": "d0el13pivg86titl82s0-vpn-gw",
            "resource_type": "aws_vpn_gateway",
            "vpc_id": "vpc-0d115018882a5c1eb"
          }
        },
        {
          "cspResourceName": "d0el13pivg86titl82s0-alibaba-side-gw-1",
          "cspResourceId": "cgw-0730fd8b60a04f853",
          "cspResourceDetail": {
            "bgp_asn": "65532",
            "id": "cgw-0730fd8b60a04f853",
            "ip_address": "47.80.3.199",
            "name": "d0el13pivg86titl82s0-alibaba-side-gw-1",
            "resource_type": "aws_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0el13pivg86titl82s0-alibaba-side-gw-2",
          "cspResourceId": "cgw-0431c30173baa1f8c",
          "cspResourceDetail": {
            "bgp_asn": "65532",
            "id": "cgw-0431c30173baa1f8c",
            "ip_address": "8.213.147.169",
            "name": "d0el13pivg86titl82s0-alibaba-side-gw-2",
            "resource_type": "aws_customer_gateway"
          }
        }
      ]
    },
    {
      "connectionName": "alibaba-ap-northeast-2",
      "connectionConfig": {
        "configName": "alibaba-ap-northeast-2",
        "providerName": "alibaba",
        "driverName": "alibaba-driver-v1.0.so",
        "credentialName": "alibaba",
        "credentialHolder": "admin",
        "regionZoneInfoName": "alibaba-ap-northeast-2",
        "regionZoneInfo": {
          "assignedRegion": "ap-northeast-2",
          "assignedZone": "ap-northeast-2a"
        },
        "regionDetail": {
          "regionId": "ap-northeast-2",
          "regionName": "ap-northeast-2",
          "description": "South Korea (Seoul)",
          "location": {
            "display": "South Korea (Seoul)",
            "latitude": 37.36,
            "longitude": 126.78
          },
          "zones": [
            "ap-northeast-2a"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "resourceDetails": [
        {
          "cspResourceName": "",
          "cspResourceId": "vpn-mj7o8k5awe36ay0io9pis",
          "cspResourceDetail": {
            "disaster_recovery_internet_ip": "8.213.147.169",
            "id": "vpn-mj7o8k5awe36ay0io9pis",
            "internet_ip": "47.80.3.199",
            "resource_type": "alicloud_vpn_gateway"
          }
        },
        {
          "cspResourceName": "",
          "cspResourceId": "cgw-mj7lct7peeeannk8peb95",
          "cspResourceDetail": {
            "asn": "64512",
            "id": "cgw-mj7lct7peeeannk8peb95",
            "ip_address": "3.37.71.47",
            "resource_type": "alicloud_vpn_customer_gateway"
          }
        },
        {
          "cspResourceName": "",
          "cspResourceId": "cgw-mj7aaty00ncjjrfziuyt0",
          "cspResourceDetail": {
            "asn": "64512",
            "id": "cgw-mj7aaty00ncjjrfziuyt0",
            "ip_address": "15.165.246.79",
            "resource_type": "alicloud_vpn_customer_gateway"
          }
        },
        {
          "cspResourceName": "",
          "cspResourceId": "cgw-mj7vfpa01iaezb06z17zn",
          "cspResourceDetail": {
            "asn": "64512",
            "id": "cgw-mj7vfpa01iaezb06z17zn",
            "ip_address": "3.34.232.91",
            "resource_type": "alicloud_vpn_customer_gateway"
          }
        },
        {
          "cspResourceName": "",
          "cspResourceId": "cgw-mj7wgx1hv6if9p64wowai",
          "cspResourceDetail": {
            "asn": "64512",
            "id": "cgw-mj7wgx1hv6if9p64wowai",
            "ip_address": "43.200.45.202",
            "resource_type": "alicloud_vpn_customer_gateway"
          }
        },
        {
          "cspResourceName": "",
          "cspResourceId": "vco-mj7g2ha233y494elzkn7f",
          "cspResourceDetail": {
            "bgp_status": "",
            "id": "vco-mj7g2ha233y494elzkn7f",
            "resource_type": "alicloud_vpn_connection",
            "tunnels": [
              {
                "bgp_status": "",
                "id": "tun-mj7eot3ry8kqbb0gtqem4",
                "peer_asn": "",
                "peer_bgp_ip": "",
                "resource_type": "alicloud_vpn_tunnel_options",
                "state": "active",
                "status": "ike_sa_not_established"
              },
              {
                "bgp_status": "",
                "id": "tun-mj7hpvfl52xe3ffw0i1ry",
                "peer_asn": "",
                "peer_bgp_ip": "",
                "resource_type": "alicloud_vpn_tunnel_options",
                "state": "active",
                "status": "ike_sa_not_established"
              }
            ]
          }
        },
        {
          "cspResourceName": "",
          "cspResourceId": "vco-mj7rehgqjwmg3li72vjrq",
          "cspResourceDetail": {
            "bgp_status": "",
            "id": "vco-mj7rehgqjwmg3li72vjrq",
            "resource_type": "alicloud_vpn_connection",
            "tunnels": [
              {
                "bgp_status": "",
                "id": "tun-mj7jw950t2n9meufbq8d3",
                "peer_asn": "",
                "peer_bgp_ip": "",
                "resource_type": "alicloud_vpn_tunnel_options",
                "state": "active",
                "status": "ike_sa_not_established"
              },
              {
                "bgp_status": "",
                "id": "tun-mj74oyequvubx9daykont",
                "peer_asn": "",
                "peer_bgp_ip": "",
                "resource_type": "alicloud_vpn_tunnel_options",
                "state": "active",
                "status": "ipsec_sa_established"
              }
            ]
          }
        }
      ]
    }
  ]
}
```


### Get all VPNs

* API: `GET /ns/{nsId}/mci/{mciId}/vpn`
* Params:
  - nsId: default
  - mciId: mci01
  - option: IdList
* Response body:   
```json
{
  "vpnIdList": [
    "vpn01"
  ]
}
```


### Get all VPNs

* API: `GET /ns/{nsId}/mci/{mciId}/vpn`
* Params:
  - nsId: default
  - mciId: mci01
  - option: InfoList
* Response body:   
```json
{
  "vpnInfoList": [
    {
      "resourceType": "vpn",
      "id": "vpn01",
      "uid": "d0el13pivg86titl82s0",
      "name": "vpn01",
      "description": "VPN between aws and alibaba",
      "status": "Available",
      "vpnSites": [
        {
          "connectionName": "aws-ap-northeast-2",
          "connectionConfig": {
            "configName": "aws-ap-northeast-2",
            "providerName": "aws",
            "driverName": "aws-driver-v1.0.so",
            "credentialName": "aws",
            "credentialHolder": "admin",
            "regionZoneInfoName": "aws-ap-northeast-2",
            "regionZoneInfo": {
              "assignedRegion": "ap-northeast-2",
              "assignedZone": "ap-northeast-2a"
            },
            "regionDetail": {
              "regionId": "ap-northeast-2",
              "regionName": "ap-northeast-2",
              "description": "Asia Pacific (Seoul)",
              "location": {
                "display": "South Korea (Seoul)",
                "latitude": 37.36,
                "longitude": 126.78
              },
              "zones": [
                "ap-northeast-2a",
                "ap-northeast-2b",
                "ap-northeast-2c",
                "ap-northeast-2d"
              ]
            },
            "regionRepresentative": true,
            "verified": true
          },
          "resourceDetails": [
            {
              "cspResourceName": "d0el13pivg86titl82s0-to-alibaba-1",
              "cspResourceId": "vpn-077f6a044c2162d1f",
              "cspResourceDetail": {
                "id": "vpn-077f6a044c2162d1f",
                "name": "d0el13pivg86titl82s0-to-alibaba-1",
                "resource_type": "aws_vpn_connection",
                "tunnel1_address": "3.37.71.47",
                "tunnel2_address": "15.165.246.79"
              }
            },
            {
              "cspResourceName": "d0el13pivg86titl82s0-to-alibaba-2",
              "cspResourceId": "vpn-08d055a13c0184f67",
              "cspResourceDetail": {
                "id": "vpn-08d055a13c0184f67",
                "name": "d0el13pivg86titl82s0-to-alibaba-2",
                "resource_type": "aws_vpn_connection",
                "tunnel1_address": "3.34.232.91",
                "tunnel2_address": "43.200.45.202"
              }
            },
            {
              "cspResourceName": "d0el13pivg86titl82s0-vpn-gw",
              "cspResourceId": "vgw-04f832c1dd06650da",
              "cspResourceDetail": {
                "id": "vgw-04f832c1dd06650da",
                "name": "d0el13pivg86titl82s0-vpn-gw",
                "resource_type": "aws_vpn_gateway",
                "vpc_id": "vpc-0d115018882a5c1eb"
              }
            },
            {
              "cspResourceName": "d0el13pivg86titl82s0-alibaba-side-gw-1",
              "cspResourceId": "cgw-0730fd8b60a04f853",
              "cspResourceDetail": {
                "bgp_asn": "65532",
                "id": "cgw-0730fd8b60a04f853",
                "ip_address": "47.80.3.199",
                "name": "d0el13pivg86titl82s0-alibaba-side-gw-1",
                "resource_type": "aws_customer_gateway"
              }
            },
            {
              "cspResourceName": "d0el13pivg86titl82s0-alibaba-side-gw-2",
              "cspResourceId": "cgw-0431c30173baa1f8c",
              "cspResourceDetail": {
                "bgp_asn": "65532",
                "id": "cgw-0431c30173baa1f8c",
                "ip_address": "8.213.147.169",
                "name": "d0el13pivg86titl82s0-alibaba-side-gw-2",
                "resource_type": "aws_customer_gateway"
              }
            }
          ]
        },
        {
          "connectionName": "alibaba-ap-northeast-2",
          "connectionConfig": {
            "configName": "alibaba-ap-northeast-2",
            "providerName": "alibaba",
            "driverName": "alibaba-driver-v1.0.so",
            "credentialName": "alibaba",
            "credentialHolder": "admin",
            "regionZoneInfoName": "alibaba-ap-northeast-2",
            "regionZoneInfo": {
              "assignedRegion": "ap-northeast-2",
              "assignedZone": "ap-northeast-2a"
            },
            "regionDetail": {
              "regionId": "ap-northeast-2",
              "regionName": "ap-northeast-2",
              "description": "South Korea (Seoul)",
              "location": {
                "display": "South Korea (Seoul)",
                "latitude": 37.36,
                "longitude": 126.78
              },
              "zones": [
                "ap-northeast-2a"
              ]
            },
            "regionRepresentative": true,
            "verified": true
          },
          "resourceDetails": [
            {
              "cspResourceName": "",
              "cspResourceId": "vpn-mj7o8k5awe36ay0io9pis",
              "cspResourceDetail": {
                "disaster_recovery_internet_ip": "8.213.147.169",
                "id": "vpn-mj7o8k5awe36ay0io9pis",
                "internet_ip": "47.80.3.199",
                "resource_type": "alicloud_vpn_gateway"
              }
            },
            {
              "cspResourceName": "",
              "cspResourceId": "cgw-mj7lct7peeeannk8peb95",
              "cspResourceDetail": {
                "asn": "64512",
                "id": "cgw-mj7lct7peeeannk8peb95",
                "ip_address": "3.37.71.47",
                "resource_type": "alicloud_vpn_customer_gateway"
              }
            },
            {
              "cspResourceName": "",
              "cspResourceId": "cgw-mj7aaty00ncjjrfziuyt0",
              "cspResourceDetail": {
                "asn": "64512",
                "id": "cgw-mj7aaty00ncjjrfziuyt0",
                "ip_address": "15.165.246.79",
                "resource_type": "alicloud_vpn_customer_gateway"
              }
            },
            {
              "cspResourceName": "",
              "cspResourceId": "cgw-mj7vfpa01iaezb06z17zn",
              "cspResourceDetail": {
                "asn": "64512",
                "id": "cgw-mj7vfpa01iaezb06z17zn",
                "ip_address": "3.34.232.91",
                "resource_type": "alicloud_vpn_customer_gateway"
              }
            },
            {
              "cspResourceName": "",
              "cspResourceId": "cgw-mj7wgx1hv6if9p64wowai",
              "cspResourceDetail": {
                "asn": "64512",
                "id": "cgw-mj7wgx1hv6if9p64wowai",
                "ip_address": "43.200.45.202",
                "resource_type": "alicloud_vpn_customer_gateway"
              }
            },
            {
              "cspResourceName": "",
              "cspResourceId": "vco-mj7g2ha233y494elzkn7f",
              "cspResourceDetail": {
                "bgp_status": "",
                "id": "vco-mj7g2ha233y494elzkn7f",
                "resource_type": "alicloud_vpn_connection",
                "tunnels": [
                  {
                    "bgp_status": "",
                    "id": "tun-mj7eot3ry8kqbb0gtqem4",
                    "peer_asn": "",
                    "peer_bgp_ip": "",
                    "resource_type": "alicloud_vpn_tunnel_options",
                    "state": "active",
                    "status": "ike_sa_not_established"
                  },
                  {
                    "bgp_status": "",
                    "id": "tun-mj7hpvfl52xe3ffw0i1ry",
                    "peer_asn": "",
                    "peer_bgp_ip": "",
                    "resource_type": "alicloud_vpn_tunnel_options",
                    "state": "active",
                    "status": "ike_sa_not_established"
                  }
                ]
              }
            },
            {
              "cspResourceName": "",
              "cspResourceId": "vco-mj7rehgqjwmg3li72vjrq",
              "cspResourceDetail": {
                "bgp_status": "",
                "id": "vco-mj7rehgqjwmg3li72vjrq",
                "resource_type": "alicloud_vpn_connection",
                "tunnels": [
                  {
                    "bgp_status": "",
                    "id": "tun-mj7jw950t2n9meufbq8d3",
                    "peer_asn": "",
                    "peer_bgp_ip": "",
                    "resource_type": "alicloud_vpn_tunnel_options",
                    "state": "active",
                    "status": "ike_sa_not_established"
                  },
                  {
                    "bgp_status": "",
                    "id": "tun-mj74oyequvubx9daykont",
                    "peer_asn": "",
                    "peer_bgp_ip": "",
                    "resource_type": "alicloud_vpn_tunnel_options",
                    "state": "active",
                    "status": "ipsec_sa_established"
                  }
                ]
              }
            }
          ]
        }
      ]
    }
  ]
}
```


### Ping test

* API: `POST /ns/{nsId}/cmd/mci/{mciId}`
* Params:
  - nsId: default
  - mciId: mci01
  - vmId: d0ekuq1ivg86titl827g-1
* Request body:   
```json
{
  "command": [
    "ping 10.2.33.29 -c 1"
  ],
  "userName": "cb-user"
}
```

* Response body:   
```json
{
  "results": [
    {
      "mciId": "mci01",
      "vmId": "d0ekuq1ivg86titl827g-1",
      "vmIp": "43.203.217.241",
      "command": {
        "0": "ping 10.2.33.29 -c 1"
      },
      "stdout": {
        "0": "PING 10.2.33.29 (10.2.33.29) 56(84) bytes of data.\n64 bytes from 10.2.33.29: icmp_seq=1 ttl=63 time=3.95 ms\n\n--- 10.2.33.29 ping statistics ---\n1 packets transmitted, 1 received, 0% packet loss, time 0ms\nrtt min/avg/max/mdev = 3.950/3.950/3.950/0.000 ms\n"
      },
      "stderr": {
        "0": ""
      },
      "err": null
    }
  ]
}
```


### Delete VPN 

* API: `DELETE /ns/{nsId}/mci/{mciId}/vpn/{vpnId}`
* Params:
  - nsId: default
  - mciId: mci01
  - vpnId: vpn01
* Response body:   
```json
{
  "message": "successfully deleted the site-to-site VPN (vpn01)"
}
```


---

## Site-to-site VPN between AWS and Tencent

### Create VPN 

* API: `POST /ns/{nsId}/mci/{mciId}/vpn`
* Params:
  - nsId: default
  - mciId: mci01
* Request body:   
```json
{
  "name": "vpn01",
  "site1": {
    "cspSpecificProperty": {
      "aws": {
        "bgpAsn": "64512"
      }
    },
    "vNetId": "default-shared-aws-ap-northeast-2"
  },
  "site2": {
    "vNetId": "default-shared-tencent-ap-seoul"
  }
}
```

* Response body:   
```json
{
  "resourceType": "vpn",
  "id": "vpn01",
  "uid": "d0emqn66kj4nnv2r25cg",
  "name": "vpn01",
  "description": "VPN between aws and tencent",
  "status": "Available",
  "vpnSites": [
    {
      "connectionName": "aws-ap-northeast-2",
      "connectionConfig": {
        "configName": "aws-ap-northeast-2",
        "providerName": "aws",
        "driverName": "aws-driver-v1.0.so",
        "credentialName": "aws",
        "credentialHolder": "admin",
        "regionZoneInfoName": "aws-ap-northeast-2",
        "regionZoneInfo": {
          "assignedRegion": "ap-northeast-2",
          "assignedZone": "ap-northeast-2a"
        },
        "regionDetail": {
          "regionId": "ap-northeast-2",
          "regionName": "ap-northeast-2",
          "description": "Asia Pacific (Seoul)",
          "location": {
            "display": "South Korea (Seoul)",
            "latitude": 37.36,
            "longitude": 126.78
          },
          "zones": [
            "ap-northeast-2a",
            "ap-northeast-2b",
            "ap-northeast-2c",
            "ap-northeast-2d"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "resourceDetails": [
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-tencent-side-gw-1",
          "cspResourceId": "cgw-0e3b0fa3bbbfd1306",
          "cspResourceDetail": {
            "bgp_asn": "65000",
            "id": "cgw-0e3b0fa3bbbfd1306",
            "ip_address": "43.155.211.173",
            "name": "d0emqn66kj4nnv2r25cg-tencent-side-gw-1",
            "resource_type": "aws_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-tencent-side-gw-2",
          "cspResourceId": "cgw-0bbd496d548559448",
          "cspResourceDetail": {
            "bgp_asn": "65000",
            "id": "cgw-0bbd496d548559448",
            "ip_address": "101.33.78.63",
            "name": "d0emqn66kj4nnv2r25cg-tencent-side-gw-2",
            "resource_type": "aws_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-to-tencent-1",
          "cspResourceId": "vpn-050bd10ecd6ac9e08",
          "cspResourceDetail": {
            "id": "vpn-050bd10ecd6ac9e08",
            "name": "d0emqn66kj4nnv2r25cg-to-tencent-1",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "3.37.248.251",
            "tunnel2_address": "3.38.29.14"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-to-tencent-2",
          "cspResourceId": "vpn-02bb5eb8c4badbaba",
          "cspResourceDetail": {
            "id": "vpn-02bb5eb8c4badbaba",
            "name": "d0emqn66kj4nnv2r25cg-to-tencent-2",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "43.203.75.195",
            "tunnel2_address": "52.78.65.179"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-vpn-gw",
          "cspResourceId": "vgw-00886a42bfc9892a6",
          "cspResourceDetail": {
            "id": "vgw-00886a42bfc9892a6",
            "name": "d0emqn66kj4nnv2r25cg-vpn-gw",
            "resource_type": "aws_vpn_gateway",
            "vpc_id": "vpc-0d115018882a5c1eb"
          }
        }
      ]
    },
    {
      "connectionName": "tencent-ap-seoul",
      "connectionConfig": {
        "configName": "tencent-ap-seoul",
        "providerName": "tencent",
        "driverName": "tencent-driver-v1.0.so",
        "credentialName": "tencent",
        "credentialHolder": "admin",
        "regionZoneInfoName": "tencent-ap-seoul",
        "regionZoneInfo": {
          "assignedRegion": "ap-seoul",
          "assignedZone": "ap-seoul-1"
        },
        "regionDetail": {
          "regionId": "ap-seoul",
          "regionName": "ap-seoul",
          "description": "Seoul",
          "location": {
            "display": "South Korea (Seoul)",
            "latitude": 37.566536,
            "longitude": 126.977966
          },
          "zones": [
            "ap-seoul-1",
            "ap-seoul-2"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "resourceDetails": [
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-aws-side-gw-1",
          "cspResourceId": "cgw-ym3oq807",
          "cspResourceDetail": {
            "id": "cgw-ym3oq807",
            "name": "d0emqn66kj4nnv2r25cg-aws-side-gw-1",
            "public_ip_address": "3.37.248.251",
            "resource_type": "tencentcloud_vpn_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-aws-side-gw-2",
          "cspResourceId": "cgw-hhtkqv7n",
          "cspResourceDetail": {
            "id": "cgw-hhtkqv7n",
            "name": "d0emqn66kj4nnv2r25cg-aws-side-gw-2",
            "public_ip_address": "3.38.29.14",
            "resource_type": "tencentcloud_vpn_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-aws-side-gw-3",
          "cspResourceId": "cgw-lvgd4e7j",
          "cspResourceDetail": {
            "id": "cgw-lvgd4e7j",
            "name": "d0emqn66kj4nnv2r25cg-aws-side-gw-3",
            "public_ip_address": "43.203.75.195",
            "resource_type": "tencentcloud_vpn_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-aws-side-gw-4",
          "cspResourceId": "cgw-81x7238z",
          "cspResourceDetail": {
            "id": "cgw-81x7238z",
            "name": "d0emqn66kj4nnv2r25cg-aws-side-gw-4",
            "public_ip_address": "52.78.65.179",
            "resource_type": "tencentcloud_vpn_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-to-aws-1",
          "cspResourceId": "vpnx-h0wckqgn",
          "cspResourceDetail": {
            "customer_gatway_id": "cgw-ym3oq807",
            "health_check_local_ip": "169.254.128.2",
            "health_check_remote_ip": "169.254.128.1",
            "id": "vpnx-h0wckqgn",
            "ike_local_address": "43.155.211.173",
            "ike_remote_address": "3.37.248.251",
            "name": "d0emqn66kj4nnv2r25cg-to-aws-1",
            "resource_type": "tencentcloud_vpn_connection",
            "vpc_id": "vpc-7mz1r0o6",
            "vpn_gateway_id": "vpngw-mow6qzem"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-to-aws-2",
          "cspResourceId": "vpnx-pn74e5ao",
          "cspResourceDetail": {
            "customer_gatway_id": "cgw-hhtkqv7n",
            "health_check_local_ip": "169.254.128.6",
            "health_check_remote_ip": "169.254.128.1",
            "id": "vpnx-pn74e5ao",
            "ike_local_address": "43.155.211.173",
            "ike_remote_address": "3.38.29.14",
            "name": "d0emqn66kj4nnv2r25cg-to-aws-2",
            "resource_type": "tencentcloud_vpn_connection",
            "vpc_id": "vpc-7mz1r0o6",
            "vpn_gateway_id": "vpngw-mow6qzem"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-to-aws-3",
          "cspResourceId": "vpnx-n8a25u8g",
          "cspResourceDetail": {
            "customer_gatway_id": "cgw-lvgd4e7j",
            "health_check_local_ip": "169.254.129.2",
            "health_check_remote_ip": "169.254.129.1",
            "id": "vpnx-n8a25u8g",
            "ike_local_address": "101.33.78.63",
            "ike_remote_address": "43.203.75.195",
            "name": "d0emqn66kj4nnv2r25cg-to-aws-3",
            "resource_type": "tencentcloud_vpn_connection",
            "vpc_id": "vpc-7mz1r0o6",
            "vpn_gateway_id": "vpngw-7t3puhkl"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-to-aws-4",
          "cspResourceId": "vpnx-g2u1hvq5",
          "cspResourceDetail": {
            "customer_gatway_id": "cgw-81x7238z",
            "health_check_local_ip": "169.254.129.6",
            "health_check_remote_ip": "169.254.129.1",
            "id": "vpnx-g2u1hvq5",
            "ike_local_address": "101.33.78.63",
            "ike_remote_address": "52.78.65.179",
            "name": "d0emqn66kj4nnv2r25cg-to-aws-4",
            "resource_type": "tencentcloud_vpn_connection",
            "vpc_id": "vpc-7mz1r0o6",
            "vpn_gateway_id": "vpngw-7t3puhkl"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-vpn-gw-1",
          "cspResourceId": "vpngw-mow6qzem",
          "cspResourceDetail": {
            "id": "vpngw-mow6qzem",
            "name": "d0emqn66kj4nnv2r25cg-vpn-gw-1",
            "public_ip": "43.155.211.173",
            "resource_type": "tencentcloud_vpn_gateway",
            "vpc_id": "vpc-7mz1r0o6"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-vpn-gw-2",
          "cspResourceId": "vpngw-7t3puhkl",
          "cspResourceDetail": {
            "id": "vpngw-7t3puhkl",
            "name": "d0emqn66kj4nnv2r25cg-vpn-gw-2",
            "public_ip": "101.33.78.63",
            "resource_type": "tencentcloud_vpn_gateway",
            "vpc_id": "vpc-7mz1r0o6"
          }
        }
      ]
    }
  ]
}
```


### Get VPN 

* API: `GET /ns/{nsId}/mci/{mciId}/vpn/{vpnId}`
* Params:
  - nsId: default
  - mciId: mci01
  - vpnId: vpn01
* Response body:   
```json
{
  "resourceType": "vpn",
  "id": "vpn01",
  "uid": "d0emqn66kj4nnv2r25cg",
  "name": "vpn01",
  "description": "VPN between aws and tencent",
  "status": "Available",
  "vpnSites": [
    {
      "connectionName": "aws-ap-northeast-2",
      "connectionConfig": {
        "configName": "aws-ap-northeast-2",
        "providerName": "aws",
        "driverName": "aws-driver-v1.0.so",
        "credentialName": "aws",
        "credentialHolder": "admin",
        "regionZoneInfoName": "aws-ap-northeast-2",
        "regionZoneInfo": {
          "assignedRegion": "ap-northeast-2",
          "assignedZone": "ap-northeast-2a"
        },
        "regionDetail": {
          "regionId": "ap-northeast-2",
          "regionName": "ap-northeast-2",
          "description": "Asia Pacific (Seoul)",
          "location": {
            "display": "South Korea (Seoul)",
            "latitude": 37.36,
            "longitude": 126.78
          },
          "zones": [
            "ap-northeast-2a",
            "ap-northeast-2b",
            "ap-northeast-2c",
            "ap-northeast-2d"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "resourceDetails": [
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-to-tencent-1",
          "cspResourceId": "vpn-050bd10ecd6ac9e08",
          "cspResourceDetail": {
            "id": "vpn-050bd10ecd6ac9e08",
            "name": "d0emqn66kj4nnv2r25cg-to-tencent-1",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "3.37.248.251",
            "tunnel2_address": "3.38.29.14"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-to-tencent-2",
          "cspResourceId": "vpn-02bb5eb8c4badbaba",
          "cspResourceDetail": {
            "id": "vpn-02bb5eb8c4badbaba",
            "name": "d0emqn66kj4nnv2r25cg-to-tencent-2",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "43.203.75.195",
            "tunnel2_address": "52.78.65.179"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-vpn-gw",
          "cspResourceId": "vgw-00886a42bfc9892a6",
          "cspResourceDetail": {
            "id": "vgw-00886a42bfc9892a6",
            "name": "d0emqn66kj4nnv2r25cg-vpn-gw",
            "resource_type": "aws_vpn_gateway",
            "vpc_id": "vpc-0d115018882a5c1eb"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-tencent-side-gw-1",
          "cspResourceId": "cgw-0e3b0fa3bbbfd1306",
          "cspResourceDetail": {
            "bgp_asn": "65000",
            "id": "cgw-0e3b0fa3bbbfd1306",
            "ip_address": "43.155.211.173",
            "name": "d0emqn66kj4nnv2r25cg-tencent-side-gw-1",
            "resource_type": "aws_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-tencent-side-gw-2",
          "cspResourceId": "cgw-0bbd496d548559448",
          "cspResourceDetail": {
            "bgp_asn": "65000",
            "id": "cgw-0bbd496d548559448",
            "ip_address": "101.33.78.63",
            "name": "d0emqn66kj4nnv2r25cg-tencent-side-gw-2",
            "resource_type": "aws_customer_gateway"
          }
        }
      ]
    },
    {
      "connectionName": "tencent-ap-seoul",
      "connectionConfig": {
        "configName": "tencent-ap-seoul",
        "providerName": "tencent",
        "driverName": "tencent-driver-v1.0.so",
        "credentialName": "tencent",
        "credentialHolder": "admin",
        "regionZoneInfoName": "tencent-ap-seoul",
        "regionZoneInfo": {
          "assignedRegion": "ap-seoul",
          "assignedZone": "ap-seoul-1"
        },
        "regionDetail": {
          "regionId": "ap-seoul",
          "regionName": "ap-seoul",
          "description": "Seoul",
          "location": {
            "display": "South Korea (Seoul)",
            "latitude": 37.566536,
            "longitude": 126.977966
          },
          "zones": [
            "ap-seoul-1",
            "ap-seoul-2"
          ]
        },
        "regionRepresentative": true,
        "verified": true
      },
      "resourceDetails": [
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-vpn-gw-1",
          "cspResourceId": "vpngw-mow6qzem",
          "cspResourceDetail": {
            "id": "vpngw-mow6qzem",
            "name": "d0emqn66kj4nnv2r25cg-vpn-gw-1",
            "public_ip": "43.155.211.173",
            "resource_type": "tencentcloud_vpn_gateway",
            "vpc_id": "vpc-7mz1r0o6"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-vpn-gw-2",
          "cspResourceId": "vpngw-7t3puhkl",
          "cspResourceDetail": {
            "id": "vpngw-7t3puhkl",
            "name": "d0emqn66kj4nnv2r25cg-vpn-gw-2",
            "public_ip": "101.33.78.63",
            "resource_type": "tencentcloud_vpn_gateway",
            "vpc_id": "vpc-7mz1r0o6"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-aws-side-gw-1",
          "cspResourceId": "cgw-ym3oq807",
          "cspResourceDetail": {
            "id": "cgw-ym3oq807",
            "name": "d0emqn66kj4nnv2r25cg-aws-side-gw-1",
            "public_ip_address": "3.37.248.251",
            "resource_type": "tencentcloud_vpn_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-aws-side-gw-2",
          "cspResourceId": "cgw-hhtkqv7n",
          "cspResourceDetail": {
            "id": "cgw-hhtkqv7n",
            "name": "d0emqn66kj4nnv2r25cg-aws-side-gw-2",
            "public_ip_address": "3.38.29.14",
            "resource_type": "tencentcloud_vpn_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-aws-side-gw-3",
          "cspResourceId": "cgw-lvgd4e7j",
          "cspResourceDetail": {
            "id": "cgw-lvgd4e7j",
            "name": "d0emqn66kj4nnv2r25cg-aws-side-gw-3",
            "public_ip_address": "43.203.75.195",
            "resource_type": "tencentcloud_vpn_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-aws-side-gw-4",
          "cspResourceId": "cgw-81x7238z",
          "cspResourceDetail": {
            "id": "cgw-81x7238z",
            "name": "d0emqn66kj4nnv2r25cg-aws-side-gw-4",
            "public_ip_address": "52.78.65.179",
            "resource_type": "tencentcloud_vpn_customer_gateway"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-to-aws-1",
          "cspResourceId": "vpnx-h0wckqgn",
          "cspResourceDetail": {
            "customer_gatway_id": "cgw-ym3oq807",
            "health_check_local_ip": "169.254.128.2",
            "health_check_remote_ip": "169.254.128.1",
            "id": "vpnx-h0wckqgn",
            "ike_local_address": "43.155.211.173",
            "ike_remote_address": "3.37.248.251",
            "name": "d0emqn66kj4nnv2r25cg-to-aws-1",
            "resource_type": "tencentcloud_vpn_connection",
            "vpc_id": "vpc-7mz1r0o6",
            "vpn_gateway_id": "vpngw-mow6qzem"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-to-aws-2",
          "cspResourceId": "vpnx-pn74e5ao",
          "cspResourceDetail": {
            "customer_gatway_id": "cgw-hhtkqv7n",
            "health_check_local_ip": "169.254.128.6",
            "health_check_remote_ip": "169.254.128.1",
            "id": "vpnx-pn74e5ao",
            "ike_local_address": "43.155.211.173",
            "ike_remote_address": "3.38.29.14",
            "name": "d0emqn66kj4nnv2r25cg-to-aws-2",
            "resource_type": "tencentcloud_vpn_connection",
            "vpc_id": "vpc-7mz1r0o6",
            "vpn_gateway_id": "vpngw-mow6qzem"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-to-aws-3",
          "cspResourceId": "vpnx-n8a25u8g",
          "cspResourceDetail": {
            "customer_gatway_id": "cgw-lvgd4e7j",
            "health_check_local_ip": "169.254.129.2",
            "health_check_remote_ip": "169.254.129.1",
            "id": "vpnx-n8a25u8g",
            "ike_local_address": "101.33.78.63",
            "ike_remote_address": "43.203.75.195",
            "name": "d0emqn66kj4nnv2r25cg-to-aws-3",
            "resource_type": "tencentcloud_vpn_connection",
            "vpc_id": "vpc-7mz1r0o6",
            "vpn_gateway_id": "vpngw-7t3puhkl"
          }
        },
        {
          "cspResourceName": "d0emqn66kj4nnv2r25cg-to-aws-4",
          "cspResourceId": "vpnx-g2u1hvq5",
          "cspResourceDetail": {
            "customer_gatway_id": "cgw-81x7238z",
            "health_check_local_ip": "169.254.129.6",
            "health_check_remote_ip": "169.254.129.1",
            "id": "vpnx-g2u1hvq5",
            "ike_local_address": "101.33.78.63",
            "ike_remote_address": "52.78.65.179",
            "name": "d0emqn66kj4nnv2r25cg-to-aws-4",
            "resource_type": "tencentcloud_vpn_connection",
            "vpc_id": "vpc-7mz1r0o6",
            "vpn_gateway_id": "vpngw-7t3puhkl"
          }
        }
      ]
    }
  ]
}
```


### Get all VPNs

* API: `GET /ns/{nsId}/mci/{mciId}/vpn`
* Params:
  - nsId: default
  - mciId: mci01
  - option: IdList
* Response body:   
```json
{
  "vpnIdList": [
    "vpn01"
  ]
}
```


### Get all VPNs

* API: `GET /ns/{nsId}/mci/{mciId}/vpn`
* Params:
  - nsId: default
  - mciId: mci01
  - option: InfoList
* Response body:   
```json
{
  "vpnInfoList": [
    {
      "resourceType": "vpn",
      "id": "vpn01",
      "uid": "d0emqn66kj4nnv2r25cg",
      "name": "vpn01",
      "description": "VPN between aws and tencent",
      "status": "Available",
      "vpnSites": [
        {
          "connectionName": "aws-ap-northeast-2",
          "connectionConfig": {
            "configName": "aws-ap-northeast-2",
            "providerName": "aws",
            "driverName": "aws-driver-v1.0.so",
            "credentialName": "aws",
            "credentialHolder": "admin",
            "regionZoneInfoName": "aws-ap-northeast-2",
            "regionZoneInfo": {
              "assignedRegion": "ap-northeast-2",
              "assignedZone": "ap-northeast-2a"
            },
            "regionDetail": {
              "regionId": "ap-northeast-2",
              "regionName": "ap-northeast-2",
              "description": "Asia Pacific (Seoul)",
              "location": {
                "display": "South Korea (Seoul)",
                "latitude": 37.36,
                "longitude": 126.78
              },
              "zones": [
                "ap-northeast-2a",
                "ap-northeast-2b",
                "ap-northeast-2c",
                "ap-northeast-2d"
              ]
            },
            "regionRepresentative": true,
            "verified": true
          },
          "resourceDetails": [
            {
              "cspResourceName": "d0emqn66kj4nnv2r25cg-to-tencent-1",
              "cspResourceId": "vpn-050bd10ecd6ac9e08",
              "cspResourceDetail": {
                "id": "vpn-050bd10ecd6ac9e08",
                "name": "d0emqn66kj4nnv2r25cg-to-tencent-1",
                "resource_type": "aws_vpn_connection",
                "tunnel1_address": "3.37.248.251",
                "tunnel2_address": "3.38.29.14"
              }
            },
            {
              "cspResourceName": "d0emqn66kj4nnv2r25cg-to-tencent-2",
              "cspResourceId": "vpn-02bb5eb8c4badbaba",
              "cspResourceDetail": {
                "id": "vpn-02bb5eb8c4badbaba",
                "name": "d0emqn66kj4nnv2r25cg-to-tencent-2",
                "resource_type": "aws_vpn_connection",
                "tunnel1_address": "43.203.75.195",
                "tunnel2_address": "52.78.65.179"
              }
            },
            {
              "cspResourceName": "d0emqn66kj4nnv2r25cg-vpn-gw",
              "cspResourceId": "vgw-00886a42bfc9892a6",
              "cspResourceDetail": {
                "id": "vgw-00886a42bfc9892a6",
                "name": "d0emqn66kj4nnv2r25cg-vpn-gw",
                "resource_type": "aws_vpn_gateway",
                "vpc_id": "vpc-0d115018882a5c1eb"
              }
            },
            {
              "cspResourceName": "d0emqn66kj4nnv2r25cg-tencent-side-gw-1",
              "cspResourceId": "cgw-0e3b0fa3bbbfd1306",
              "cspResourceDetail": {
                "bgp_asn": "65000",
                "id": "cgw-0e3b0fa3bbbfd1306",
                "ip_address": "43.155.211.173",
                "name": "d0emqn66kj4nnv2r25cg-tencent-side-gw-1",
                "resource_type": "aws_customer_gateway"
              }
            },
            {
              "cspResourceName": "d0emqn66kj4nnv2r25cg-tencent-side-gw-2",
              "cspResourceId": "cgw-0bbd496d548559448",
              "cspResourceDetail": {
                "bgp_asn": "65000",
                "id": "cgw-0bbd496d548559448",
                "ip_address": "101.33.78.63",
                "name": "d0emqn66kj4nnv2r25cg-tencent-side-gw-2",
                "resource_type": "aws_customer_gateway"
              }
            }
          ]
        },
        {
          "connectionName": "tencent-ap-seoul",
          "connectionConfig": {
            "configName": "tencent-ap-seoul",
            "providerName": "tencent",
            "driverName": "tencent-driver-v1.0.so",
            "credentialName": "tencent",
            "credentialHolder": "admin",
            "regionZoneInfoName": "tencent-ap-seoul",
            "regionZoneInfo": {
              "assignedRegion": "ap-seoul",
              "assignedZone": "ap-seoul-1"
            },
            "regionDetail": {
              "regionId": "ap-seoul",
              "regionName": "ap-seoul",
              "description": "Seoul",
              "location": {
                "display": "South Korea (Seoul)",
                "latitude": 37.566536,
                "longitude": 126.977966
              },
              "zones": [
                "ap-seoul-1",
                "ap-seoul-2"
              ]
            },
            "regionRepresentative": true,
            "verified": true
          },
          "resourceDetails": [
            {
              "cspResourceName": "d0emqn66kj4nnv2r25cg-vpn-gw-1",
              "cspResourceId": "vpngw-mow6qzem",
              "cspResourceDetail": {
                "id": "vpngw-mow6qzem",
                "name": "d0emqn66kj4nnv2r25cg-vpn-gw-1",
                "public_ip": "43.155.211.173",
                "resource_type": "tencentcloud_vpn_gateway",
                "vpc_id": "vpc-7mz1r0o6"
              }
            },
            {
              "cspResourceName": "d0emqn66kj4nnv2r25cg-vpn-gw-2",
              "cspResourceId": "vpngw-7t3puhkl",
              "cspResourceDetail": {
                "id": "vpngw-7t3puhkl",
                "name": "d0emqn66kj4nnv2r25cg-vpn-gw-2",
                "public_ip": "101.33.78.63",
                "resource_type": "tencentcloud_vpn_gateway",
                "vpc_id": "vpc-7mz1r0o6"
              }
            },
            {
              "cspResourceName": "d0emqn66kj4nnv2r25cg-aws-side-gw-1",
              "cspResourceId": "cgw-ym3oq807",
              "cspResourceDetail": {
                "id": "cgw-ym3oq807",
                "name": "d0emqn66kj4nnv2r25cg-aws-side-gw-1",
                "public_ip_address": "3.37.248.251",
                "resource_type": "tencentcloud_vpn_customer_gateway"
              }
            },
            {
              "cspResourceName": "d0emqn66kj4nnv2r25cg-aws-side-gw-2",
              "cspResourceId": "cgw-hhtkqv7n",
              "cspResourceDetail": {
                "id": "cgw-hhtkqv7n",
                "name": "d0emqn66kj4nnv2r25cg-aws-side-gw-2",
                "public_ip_address": "3.38.29.14",
                "resource_type": "tencentcloud_vpn_customer_gateway"
              }
            },
            {
              "cspResourceName": "d0emqn66kj4nnv2r25cg-aws-side-gw-3",
              "cspResourceId": "cgw-lvgd4e7j",
              "cspResourceDetail": {
                "id": "cgw-lvgd4e7j",
                "name": "d0emqn66kj4nnv2r25cg-aws-side-gw-3",
                "public_ip_address": "43.203.75.195",
                "resource_type": "tencentcloud_vpn_customer_gateway"
              }
            },
            {
              "cspResourceName": "d0emqn66kj4nnv2r25cg-aws-side-gw-4",
              "cspResourceId": "cgw-81x7238z",
              "cspResourceDetail": {
                "id": "cgw-81x7238z",
                "name": "d0emqn66kj4nnv2r25cg-aws-side-gw-4",
                "public_ip_address": "52.78.65.179",
                "resource_type": "tencentcloud_vpn_customer_gateway"
              }
            },
            {
              "cspResourceName": "d0emqn66kj4nnv2r25cg-to-aws-1",
              "cspResourceId": "vpnx-h0wckqgn",
              "cspResourceDetail": {
                "customer_gatway_id": "cgw-ym3oq807",
                "health_check_local_ip": "169.254.128.2",
                "health_check_remote_ip": "169.254.128.1",
                "id": "vpnx-h0wckqgn",
                "ike_local_address": "43.155.211.173",
                "ike_remote_address": "3.37.248.251",
                "name": "d0emqn66kj4nnv2r25cg-to-aws-1",
                "resource_type": "tencentcloud_vpn_connection",
                "vpc_id": "vpc-7mz1r0o6",
                "vpn_gateway_id": "vpngw-mow6qzem"
              }
            },
            {
              "cspResourceName": "d0emqn66kj4nnv2r25cg-to-aws-2",
              "cspResourceId": "vpnx-pn74e5ao",
              "cspResourceDetail": {
                "customer_gatway_id": "cgw-hhtkqv7n",
                "health_check_local_ip": "169.254.128.6",
                "health_check_remote_ip": "169.254.128.1",
                "id": "vpnx-pn74e5ao",
                "ike_local_address": "43.155.211.173",
                "ike_remote_address": "3.38.29.14",
                "name": "d0emqn66kj4nnv2r25cg-to-aws-2",
                "resource_type": "tencentcloud_vpn_connection",
                "vpc_id": "vpc-7mz1r0o6",
                "vpn_gateway_id": "vpngw-mow6qzem"
              }
            },
            {
              "cspResourceName": "d0emqn66kj4nnv2r25cg-to-aws-3",
              "cspResourceId": "vpnx-n8a25u8g",
              "cspResourceDetail": {
                "customer_gatway_id": "cgw-lvgd4e7j",
                "health_check_local_ip": "169.254.129.2",
                "health_check_remote_ip": "169.254.129.1",
                "id": "vpnx-n8a25u8g",
                "ike_local_address": "101.33.78.63",
                "ike_remote_address": "43.203.75.195",
                "name": "d0emqn66kj4nnv2r25cg-to-aws-3",
                "resource_type": "tencentcloud_vpn_connection",
                "vpc_id": "vpc-7mz1r0o6",
                "vpn_gateway_id": "vpngw-7t3puhkl"
              }
            },
            {
              "cspResourceName": "d0emqn66kj4nnv2r25cg-to-aws-4",
              "cspResourceId": "vpnx-g2u1hvq5",
              "cspResourceDetail": {
                "customer_gatway_id": "cgw-81x7238z",
                "health_check_local_ip": "169.254.129.6",
                "health_check_remote_ip": "169.254.129.1",
                "id": "vpnx-g2u1hvq5",
                "ike_local_address": "101.33.78.63",
                "ike_remote_address": "52.78.65.179",
                "name": "d0emqn66kj4nnv2r25cg-to-aws-4",
                "resource_type": "tencentcloud_vpn_connection",
                "vpc_id": "vpc-7mz1r0o6",
                "vpn_gateway_id": "vpngw-7t3puhkl"
              }
            }
          ]
        }
      ]
    }
  ]
}
```


### Ping test

* API: `POST /ns/{nsId}/cmd/mci/{mciId}`
* Params:
  - nsId: default
  - mciId: mci01
  - vmId: d0ekuq1ivg86titl827g-1
* Request body:   
```json
{
  "command": [
    "ping 10.161.0.1 -c 1"
  ],
  "userName": "cb-user"
}
```

* Response body:   
```json
{
  "results": [
    {
      "mciId": "mci01",
      "vmId": "d0ekuq1ivg86titl827g-1",
      "vmIp": "43.203.217.241",
      "command": {
        "0": "ping 10.161.0.1 -c 1"
      },
      "stdout": {
        "0": "PING 10.161.0.1 (10.161.0.1) 56(84) bytes of data.\n\n--- 10.161.0.1 ping statistics ---\n1 packets transmitted, 0 received, 100% packet loss, time 0ms\n\n"
      },
      "stderr": {
        "0": "(Process exited with status 1)\nStderr: "
      },
      "err": null
    }
  ]
}
```


### Delete VPN 

* API: `DELETE /ns/{nsId}/mci/{mciId}/vpn/{vpnId}`
* Params:
  - nsId: default
  - mciId: mci01
  - vpnId: vpn01
* Response body:   
```json
{
  "message": "successfully deleted the site-to-site VPN (vpn01)"
}
```


---

## Site-to-site VPN between AWS and IBM

> [!NOTE]
> To be tested

### Create VPN 

* API: `POST /ns/{nsId}/mci/{mciId}/vpn`
* Params:
  - nsId: default
  - mciId: mci01
* Request body:   
```json

```

* Response body:   
```json

```


### Get VPN 

* API: `GET /ns/{nsId}/mci/{mciId}/vpn/{vpnId}`
* Params:
  - nsId: default
  - mciId: mci01
  - vpnId: vpn02
* Response body:   
```json

```


### Get all VPNs

* API: `GET /ns/{nsId}/mci/{mciId}/vpn`
* Params:
  - nsId: default
  - mciId: mci01
  - option: IdList
* Response body:   
```json

```


### Get all VPNs

* API: `GET /ns/{nsId}/mci/{mciId}/vpn`
* Params:
  - nsId: default
  - mciId: mci01
  - option: InfoList
* Response body:   
```json

```


### Ping test

* API: `POST /ns/{nsId}/cmd/mci/{mciId}`
* Params:
  - nsId: default
  - mciId: mci01
* Request body:   
```json
{
  "command": [
    "echo $$Func(GetPrivateIP(target=mci01))"
  ],
  "userName": "cb-user"
}
```

* Response body:   
```json

```


### Delete VPN 

* API: `DELETE /ns/{nsId}/mci/{mciId}/vpn/{vpnId}`
* Params:
  - nsId: default
  - mciId: mci01
  - vpnId: vpn02
* Response body:   
```json

```


---

## Site-to-site VPN between AWS and ooo

### Create VPN 

* API: `POST /ns/{nsId}/mci/{mciId}/vpn`
* Params:
  - nsId: default
  - mciId: mci01
* Request body:   
```json

```

* Response body:   
```json

```


### Get VPN 

* API: `GET /ns/{nsId}/mci/{mciId}/vpn/{vpnId}`
* Params:
  - nsId: default
  - mciId: mci01
  - vpnId: vpn02
* Response body:   
```json

```


### Get all VPNs

* API: `GET /ns/{nsId}/mci/{mciId}/vpn`
* Params:
  - nsId: default
  - mciId: mci01
  - option: IdList
* Response body:   
```json

```


### Get all VPNs

* API: `GET /ns/{nsId}/mci/{mciId}/vpn`
* Params:
  - nsId: default
  - mciId: mci01
  - option: InfoList
* Response body:   
```json

```


### Ping test

* API: `POST /ns/{nsId}/cmd/mci/{mciId}`
* Params:
  - nsId: default
  - mciId: mci01
* Request body:   
```json
{
  "command": [
    "echo $$Func(GetPrivateIP(target=mci01))"
  ],
  "userName": "cb-user"
}
```

* Response body:   
```json

```


### Delete VPN 

* API: `DELETE /ns/{nsId}/mci/{mciId}/vpn/{vpnId}`
* Params:
  - nsId: default
  - mciId: mci01
  - vpnId: vpn02
* Response body:   
```json

```
