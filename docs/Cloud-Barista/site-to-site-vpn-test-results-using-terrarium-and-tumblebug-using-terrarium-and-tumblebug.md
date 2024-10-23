# Site-to-site VPN test results using Terrarium and Tumblebug

This document shares the site-to-site VPN test results using Terrarium and Tumblebug

**Environment**

- Tumblebug v0.9.18
- Spider 0.9.7
- Terrarium 0.0.8

### Create MCI

: API: `POST /ns/{nsId}/mciDynamic`

: nsId: default

: Request body
```json
{
  "description": "Made in CB-TB for VPN",
  "name": "mci01",
  "vm": [
    {
      "commonImage": "ubuntu22.04",
      "commonSpec": "aws+ap-northeast-2+t3.small"
    },
    {
      "commonImage": "ubuntu22.04",
      "commonSpec": "gcp+asia-northeast3+e2-standard-4"
    },
    {
      "commonImage": "ubuntu22.04",
      "commonSpec": "azure+koreacentral+Standard_B2s"
    }
  ]
}
```

: Response body
```json
{
  "resourceType": "mci",
  "id": "mci01",
  "uid": "csce6j6osgjunknm8tj0",
  "name": "mci01",
  "status": "Running:3 (R:3/3)",
  "statusCount": {
    "countTotal": 3,
    "countCreating": 0,
    "countRunning": 3,
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
  "installMonAgent": "",
  "configureCloudAdaptiveNetwork": "",
  "label": {
    "sys.description": "Made in CB-TB for VPN",
    "sys.id": "mci01",
    "sys.labelType": "mci",
    "sys.manager": "cb-tumblebug",
    "sys.name": "mci01",
    "sys.namespace": "default",
    "sys.uid": "csce6j6osgjunknm8tj0"
  },
  "systemLabel": "",
  "systemMessage": "",
  "description": "Made in CB-TB for VPN",
  "vm": [
    {
      "resourceType": "vm",
      "id": "csce5luosgjunknm8tcg-1",
      "uid": "csce6j6osgjunknm8tk0",
      "cspResourceName": "csce6j6osgjunknm8tk0",
      "cspResourceId": "i-010b5e4f8b112fae3",
      "name": "csce5luosgjunknm8tcg-1",
      "subGroupId": "csce5luosgjunknm8tcg",
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
      "createdTime": "2024-10-23 11:52:19",
      "label": {
        "sys.connectionName": "aws-ap-northeast-2",
        "sys.createdTime": "2024-10-23 11:52:19",
        "sys.cspResourceId": "i-010b5e4f8b112fae3",
        "sys.cspResourceName": "csce6j6osgjunknm8tk0",
        "sys.id": "csce5luosgjunknm8tcg-1",
        "sys.labelType": "vm",
        "sys.manager": "cb-tumblebug",
        "sys.mciId": "mci01",
        "sys.name": "csce5luosgjunknm8tcg-1",
        "sys.namespace": "default",
        "sys.subGroupId": "csce5luosgjunknm8tcg",
        "sys.uid": "csce6j6osgjunknm8tk0"
      },
      "description": "",
      "region": {
        "Region": "ap-northeast-2",
        "Zone": "ap-northeast-2a"
      },
      "publicIP": "13.125.7.127",
      "sshPort": "22",
      "publicDNS": "",
      "privateIP": "10.4.50.42",
      "privateDNS": "ip-10-4-50-42.ap-northeast-2.compute.internal",
      "rootDiskType": "gp2",
      "rootDiskSize": "8",
      "rootDeviceName": "/dev/sda1",
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
      "specId": "aws+ap-northeast-2+t3.small",
      "cspSpecName": "t3.small",
      "imageId": "aws+ap-northeast-2+ubuntu22.04",
      "cspImageName": "ami-058165de3b7202099",
      "vNetId": "default-shared-aws-ap-northeast-2",
      "cspVNetId": "vpc-088a447966997311a",
      "subnetId": "default-shared-aws-ap-northeast-2",
      "cspSubnetId": "subnet-0359474afc09b20e6",
      "networkInterface": "eni-attach-0dbbb7821991c64d2",
      "securityGroupIds": [
        "default-shared-aws-ap-northeast-2"
      ],
      "dataDiskIds": null,
      "sshKeyId": "default-shared-aws-ap-northeast-2",
      "cspSshKeyId": "csce5leosgjunknm8tbg",
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
          "value": "vpc-088a447966997311a"
        },
        {
          "key": "SubnetId",
          "value": "subnet-0359474afc09b20e6"
        },
        {
          "key": "KeyName",
          "value": "csce5leosgjunknm8tbg"
        },
        {
          "key": "VirtualizationType",
          "value": "hvm"
        }
      ]
    },
    {
      "resourceType": "vm",
      "id": "csce6cuosgjunknm8tfg-1",
      "uid": "csce6j6osgjunknm8tl0",
      "cspResourceName": "csce6j6osgjunknm8tl0",
      "cspResourceId": "csce6j6osgjunknm8tl0",
      "name": "csce6cuosgjunknm8tfg-1",
      "subGroupId": "csce6cuosgjunknm8tfg",
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
      "createdTime": "2024-10-23 11:52:27",
      "label": {
        "sys.connectionName": "gcp-asia-northeast3",
        "sys.createdTime": "2024-10-23 11:52:27",
        "sys.cspResourceId": "csce6j6osgjunknm8tl0",
        "sys.cspResourceName": "csce6j6osgjunknm8tl0",
        "sys.id": "csce6cuosgjunknm8tfg-1",
        "sys.labelType": "vm",
        "sys.manager": "cb-tumblebug",
        "sys.mciId": "mci01",
        "sys.name": "csce6cuosgjunknm8tfg-1",
        "sys.namespace": "default",
        "sys.subGroupId": "csce6cuosgjunknm8tfg",
        "sys.uid": "csce6j6osgjunknm8tl0"
      },
      "description": "",
      "region": {
        "Region": "asia-northeast3",
        "Zone": "asia-northeast3-a"
      },
      "publicIP": "34.64.228.16",
      "sshPort": "22",
      "publicDNS": "",
      "privateIP": "10.77.0.2",
      "privateDNS": "",
      "rootDiskType": "pd-standard",
      "rootDiskSize": "10",
      "rootDeviceName": "persistent-disk-0",
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
      "specId": "gcp+asia-northeast3+e2-standard-4",
      "cspSpecName": "e2-standard-4",
      "imageId": "gcp+asia-northeast3+ubuntu22.04",
      "cspImageName": "https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20240319",
      "vNetId": "default-shared-gcp-asia-northeast3",
      "cspVNetId": "csce5luosgjunknm8td0",
      "subnetId": "default-shared-gcp-asia-northeast3",
      "cspSubnetId": "csce5luosgjunknm8tdg",
      "networkInterface": "nic0",
      "securityGroupIds": [
        "default-shared-gcp-asia-northeast3"
      ],
      "dataDiskIds": null,
      "sshKeyId": "default-shared-gcp-asia-northeast3",
      "cspSshKeyId": "csce65eosgjunknm8teg",
      "vmUserName": "cb-user",
      "addtionalDetails": [
        {
          "key": "SubNetwork",
          "value": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/regions/asia-northeast3/subnetworks/csce5luosgjunknm8tdg"
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
          "value": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/zones/asia-northeast3-a/disks/csce6j6osgjunknm8tl0"
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
    },
    {
      "resourceType": "vm",
      "id": "csce6j6osgjunknm8tig-1",
      "uid": "csce6j6osgjunknm8tm0",
      "cspResourceName": "csce6j6osgjunknm8tm0",
      "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Compute/virtualMachines/csce6j6osgjunknm8tm0",
      "name": "csce6j6osgjunknm8tig-1",
      "subGroupId": "csce6j6osgjunknm8tig",
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
      "createdTime": "2024-10-23 11:53:20",
      "label": {
        "sys.connectionName": "azure-koreacentral",
        "sys.createdTime": "2024-10-23 11:53:20",
        "sys.cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Compute/virtualMachines/csce6j6osgjunknm8tm0",
        "sys.cspResourceName": "csce6j6osgjunknm8tm0",
        "sys.id": "csce6j6osgjunknm8tig-1",
        "sys.labelType": "vm",
        "sys.manager": "cb-tumblebug",
        "sys.mciId": "mci01",
        "sys.name": "csce6j6osgjunknm8tig-1",
        "sys.namespace": "default",
        "sys.subGroupId": "csce6j6osgjunknm8tig",
        "sys.uid": "csce6j6osgjunknm8tm0"
      },
      "description": "",
      "region": {
        "Region": "koreacentral",
        "Zone": "1"
      },
      "publicIP": "52.141.26.176",
      "sshPort": "22",
      "publicDNS": "",
      "privateIP": "10.48.0.4",
      "privateDNS": "",
      "rootDiskType": "PremiumSSD",
      "rootDiskSize": "30",
      "rootDeviceName": "Not visible in Azure",
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
      "specId": "azure+koreacentral+standard_b2s",
      "cspSpecName": "Standard_B2s",
      "imageId": "azure+koreacentral+ubuntu22.04",
      "cspImageName": "Canonical:0001-com-ubuntu-server-jammy:22_04-lts:22.04.202404090",
      "vNetId": "default-shared-azure-koreacentral",
      "cspVNetId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/virtualNetworks/csce6cuosgjunknm8tg0",
      "subnetId": "default-shared-azure-koreacentral",
      "cspSubnetId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/virtualNetworks/csce6cuosgjunknm8tg0/subnets/csce6cuosgjunknm8tgg",
      "networkInterface": "csce6j6osgjunknm8tm0-78456-VNic",
      "securityGroupIds": [
        "default-shared-azure-koreacentral"
      ],
      "dataDiskIds": null,
      "sshKeyId": "default-shared-azure-koreacentral",
      "cspSshKeyId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Compute/sshPublicKeys/csce6geosgjunknm8thg",
      "vmUserName": "cb-user",
      "addtionalDetails": [
        {
          "key": "publicip",
          "value": "csce6j6osgjunknm8tm0-79161-PublicIP"
        }
      ]
    }
  ],
  "newVmList": null
}

```
### Get sites in MCI

: API: `GET /ns/{nsId}/mci/{mciId}/site`

: nsId = default

: mciId = mci01

: Response body
```json
{
  "nsId": "default",
  "mciId": "mci01",
  "count": 3,
  "sites": {
    "aws": [
      {
        "csp": "aws",
        "region": "ap-northeast-2",
        "vnet": "vpc-088a447966997311a",
        "subnet": "subnet-0374909bdc27d1368"
      }
    ],
    "azure": [
      {
        "csp": "azure",
        "region": "koreacentral",
        "vnet": "csce6cuosgjunknm8tg0",
        "gatewaySubnetCidr": "10.48.128.0/18",
        "resourceGroup": "koreacentral"
      }
    ],
    "gcp": [
      {
        "csp": "gcp",
        "region": "asia-northeast3",
        "vnet": "csce5luosgjunknm8td0"
      }
    ]
  }
}
```

### Site-to-Site VPN between GCP and AWS
#### Create VPN 

: API: `POST /stream-response/ns/{nsId}/mci/{mciId}/vpn/{vpnId}`

: nsId = default

: mciId = mci01

: vpnId = vpn01

: Request body

```json
{
  "site1": {
	"csp": "aws",
	"region": "ap-northeast-2",
	"vnet": "vpc-088a447966997311a",
	"subnet": "subnet-0374909bdc27d1368"
  },
  "site2": {
	"csp": "gcp",
	"region": "asia-northeast3",
	"vnet": "csce5luosgjunknm8td0"
  }
}
```

: Response body (JSONL, JSON lines)

```json
can't parse JSON.  Raw result:

{"message":"mc-terrarium server is ready"}
{"message":"successully created a terrarium (trId: default-mci01-vpn01)"}
{"message":"the infrastructure terrarium is successfully initialized"}
{"message":"the infracode to configure GCP to AWS VPN tunnels is Successfully created"}
{"message":"the infracode checking process is successfully completed"}
{"message":"the request (id: 1729684656685446982) is successfully accepted and still deploying resource"}
```

#### Delete VPN 

: API: `DELETE /stream-response/ns/{nsId}/mci/{mciId}/vpn/{vpnId}`

: nsId = default

: mciId = mci01

: vpnId = vpn01

: Response body (JSONL, JSON lines)

```json
can't parse JSON.  Raw result:

{"message":"mc-terrarium server is ready"}
{"message":"successully got the terrarium (trId: default-mci01-vpn01) for the enrichment (vpn/gcp-aws)"}
{"message":"the destroying process is successfully completed (trId: default-mci01-vpn01, enrichments: vpn/gcp-aws)"}
{"message":"successfully remove all in the working directory"}
{"message":"successfully erased the entire terrarium (trId: default-mci01-vpn01)"}
```


### Site-to-site VPN between GCP and Azure

#### Create VPN

: API: `POST /stream-response/ns/{nsId}/mci/{mciId}/vpn/{vpnId}`

: nsId = default

: mciId = mci01

: vpnId = vpn02

: Request body 

```json
{
  "site1": {
	"csp": "azure",
	"region": "koreacentral",
	"vnet": "csce6cuosgjunknm8tg0",
	"gatewaySubnetCidr": "10.48.128.0/18",
	"resourceGroup": "koreacentral"
  },
  "site2": {
	"csp": "gcp",
	"region": "asia-northeast3",
	"vnet": "csce5luosgjunknm8td0"
  }
}
```

: Response body (JSONL, JSON lines)

```json
can't parse JSON.  Raw result:

{"message":"mc-terrarium server is ready"}
{"message":"successully created a terrarium (trId: default-mci01-vpn02)"}
{"message":"the infrastructure terrarium is successfully initialized"}
{"message":"the infracode to configure GCP to Azure VPN tunnels is Successfully created"}
{"message":"the infracode checking process is successfully completed"}
{"message":"the request (id: 1729686451167591219) is successfully accepted and still deploying resource"}
```

#### Delete VPN

: API: `DELETE /stream-response/ns/{nsId}/mci/{mciId}/vpn/{vpnId}`

: nsId = default

: mciId = mci01

: vpnId = vpn02

: Response body (JSONL, JSON lines)

```json
can't parse JSON.  Raw result:

{"message":"mc-terrarium server is ready"}
{"message":"successully got the terrarium (trId: default-mci01-vpn02) for the enrichment (vpn/gcp-azure)"}
{"message":"the destroying process is successfully completed (trId: default-mci01-vpn02, enrichments: vpn/gcp-aws)"}
{"message":"successfully remove all in the working directory"}
{"message":"successfully erased the entire terrarium (trId: default-mci01-vpn02)"}
```

