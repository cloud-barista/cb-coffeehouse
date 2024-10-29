# Site-to-site VPN test results using Terrarium and Tumblebug

This document shares the site-to-site VPN test results using Terrarium and Tumblebug

**Environment**

- Tumblebug v0.9.20
- Spider 0.9.8
- Terrarium 0.0.10

## Create MCI

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
  "uid": "csg4l6v53da4lnhs5kcg",
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
  "targetStatus": "None",
  "targetAction": "None",
  "installMonAgent": "",
  "configureCloudAdaptiveNetwork": "",
  "label": {
    "sys.description": "Made in CB-TB for VPN",
    "sys.id": "mci01",
    "sys.labelType": "mci",
    "sys.manager": "cb-tumblebug",
    "sys.name": "mci01",
    "sys.namespace": "default",
    "sys.uid": "csg4l6v53da4lnhs5kcg"
  },
  "systemLabel": "",
  "systemMessage": "",
  "description": "Made in CB-TB for VPN",
  "vm": [
    {
      "resourceType": "vm",
      "id": "csg4l6v53da4lnhs5kb0-1",
      "uid": "csg4l6v53da4lnhs5kdg",
      "cspResourceName": "csg4l6v53da4lnhs5kdg",
      "cspResourceId": "i-0a0f46e08b1feb673",
      "name": "csg4l6v53da4lnhs5kb0-1",
      "subGroupId": "csg4l6v53da4lnhs5kb0",
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
      "createdTime": "2024-10-29 02:38:46",
      "label": {
        "sys.connectionName": "aws-ap-northeast-2",
        "sys.createdTime": "2024-10-29 02:38:46",
        "sys.cspResourceId": "i-0a0f46e08b1feb673",
        "sys.cspResourceName": "csg4l6v53da4lnhs5kdg",
        "sys.id": "csg4l6v53da4lnhs5kb0-1",
        "sys.labelType": "vm",
        "sys.manager": "cb-tumblebug",
        "sys.mciId": "mci01",
        "sys.name": "csg4l6v53da4lnhs5kb0-1",
        "sys.namespace": "default",
        "sys.subGroupId": "csg4l6v53da4lnhs5kb0",
        "sys.uid": "csg4l6v53da4lnhs5kdg"
      },
      "description": "",
      "region": {
        "Region": "ap-northeast-2",
        "Zone": "ap-northeast-2a"
      },
      "publicIP": "43.203.254.142",
      "sshPort": "22",
      "publicDNS": "",
      "privateIP": "10.4.45.154",
      "privateDNS": "ip-10-4-45-154.ap-northeast-2.compute.internal",
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
      "networkInterface": "eni-attach-03f6181b91a37cd8f",
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
      "id": "csg4l6v53da4lnhs5kbg-1",
      "uid": "csg4l6v53da4lnhs5keg",
      "cspResourceName": "csg4l6v53da4lnhs5keg",
      "cspResourceId": "csg4l6v53da4lnhs5keg",
      "name": "csg4l6v53da4lnhs5kbg-1",
      "subGroupId": "csg4l6v53da4lnhs5kbg",
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
      "createdTime": "2024-10-29 02:39:19",
      "label": {
        "sys.connectionName": "gcp-asia-northeast3",
        "sys.createdTime": "2024-10-29 02:39:19",
        "sys.cspResourceId": "csg4l6v53da4lnhs5keg",
        "sys.cspResourceName": "csg4l6v53da4lnhs5keg",
        "sys.id": "csg4l6v53da4lnhs5kbg-1",
        "sys.labelType": "vm",
        "sys.manager": "cb-tumblebug",
        "sys.mciId": "mci01",
        "sys.name": "csg4l6v53da4lnhs5kbg-1",
        "sys.namespace": "default",
        "sys.subGroupId": "csg4l6v53da4lnhs5kbg",
        "sys.uid": "csg4l6v53da4lnhs5keg"
      },
      "description": "",
      "region": {
        "Region": "asia-northeast3",
        "Zone": "asia-northeast3-a"
      },
      "publicIP": "34.64.60.208",
      "sshPort": "22",
      "publicDNS": "",
      "privateIP": "10.77.0.4",
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
          "value": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/zones/asia-northeast3-a/disks/csg4l6v53da4lnhs5keg"
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
      "id": "csg4l6v53da4lnhs5kc0-1",
      "uid": "csg4l6v53da4lnhs5kfg",
      "cspResourceName": "csg4l6v53da4lnhs5kfg",
      "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Compute/virtualMachines/csg4l6v53da4lnhs5kfg",
      "name": "csg4l6v53da4lnhs5kc0-1",
      "subGroupId": "csg4l6v53da4lnhs5kc0",
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
      "createdTime": "2024-10-29 02:39:29",
      "label": {
        "sys.connectionName": "azure-koreacentral",
        "sys.createdTime": "2024-10-29 02:39:29",
        "sys.cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Compute/virtualMachines/csg4l6v53da4lnhs5kfg",
        "sys.cspResourceName": "csg4l6v53da4lnhs5kfg",
        "sys.id": "csg4l6v53da4lnhs5kc0-1",
        "sys.labelType": "vm",
        "sys.manager": "cb-tumblebug",
        "sys.mciId": "mci01",
        "sys.name": "csg4l6v53da4lnhs5kc0-1",
        "sys.namespace": "default",
        "sys.subGroupId": "csg4l6v53da4lnhs5kc0",
        "sys.uid": "csg4l6v53da4lnhs5kfg"
      },
      "description": "",
      "region": {
        "Region": "koreacentral",
        "Zone": "1"
      },
      "publicIP": "52.231.106.130",
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
      "networkInterface": "csg4l6v53da4lnhs5kfg-50817-VNic",
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
          "value": "csg4l6v53da4lnhs5kfg-14791-PublicIP"
        }
      ]
    }
  ],
  "newVmList": null
}

```
## Get sites in MCI

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
        "connectionName": "aws-ap-northeast-2",
        "vnet": "vpc-088a447966997311a",
        "subnet": "subnet-0374909bdc27d1368"
      }
    ],
    "azure": [
      {
        "csp": "azure",
        "region": "koreacentral",
        "connectionName": "azure-koreacentral",
        "vnet": "csce6cuosgjunknm8tg0",
        "gatewaySubnetCidr": "10.48.128.0/18",
        "resourceGroup": "koreacentral"
      }
    ],
    "gcp": [
      {
        "csp": "gcp",
        "region": "asia-northeast3",
        "connectionName": "gcp-asia-northeast3",
        "vnet": "csce5luosgjunknm8td0"
      }
    ]
  }
}
```

## Site-to-Site VPN between GCP and AWS
### Create VPN 

: API: `POST /ns/{nsId}/mci/{mciId}/vpn`

: nsId = default

: mciId = mci01

: Request body

```json
{
  "name": "vpn02",
  "site1": {
        "csp": "aws",
        "region": "ap-northeast-2",
        "connectionName": "aws-ap-northeast-2",
        "vnet": "vpc-088a447966997311a",
        "subnet": "subnet-0374909bdc27d1368"
	},
  "site2": {
        "csp": "gcp",
        "region": "asia-northeast3",
        "connectionName": "gcp-asia-northeast3",
        "vnet": "csce5luosgjunknm8td0"
	}
}
```

: Response body

```json
{
  "resourceType": "vpn",
  "id": "vpn02",
  "uid": "csgfju1c6ncf42irj7bg",
  "name": "vpn02",
  "description": "VPN between aws and gcp",
  "status": "Available",
  "vpnGatewayInfo": [
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
      "cspResourceName": "csgfju1c6ncf42irj7bg-vpn-gw",
      "cspResourceId": "vgw-039070840f7ff7bb9",
      "status": "",
      "description": "",
      "details": {
        "customer_gateways": [
          {
            "bgp_asn": "65530",
            "id": "cgw-03ade8dbc888600e2",
            "ip_address": "34.64.64.90",
            "name": "csgfju1c6ncf42irj7bg-gcp-side-gw-1",
            "resource_type": "aws_customer_gateway"
          },
          {
            "bgp_asn": "65530",
            "id": "cgw-0a67dacda8bc41cfd",
            "ip_address": "34.64.131.160",
            "name": "csgfju1c6ncf42irj7bg-gcp-side-gw-2",
            "resource_type": "aws_customer_gateway"
          }
        ],
        "vpn_connections": [
          {
            "id": "vpn-04d6aff1c06e7ceac",
            "name": "csgfju1c6ncf42irj7bg-cnx-1",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "3.38.20.63",
            "tunnel2_address": "3.39.63.243"
          },
          {
            "id": "vpn-0cee0e6ad3a1300db",
            "name": "csgfju1c6ncf42irj7bg-cnx-2",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "3.34.88.66",
            "tunnel2_address": "15.164.89.221"
          }
        ],
        "vpn_gateway": {
          "id": "vgw-039070840f7ff7bb9",
          "name": "csgfju1c6ncf42irj7bg-vpn-gw",
          "resource_type": "aws_vpn_gateway",
          "vpc_id": "vpc-088a447966997311a"
        }
      }
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
      "cspResourceName": "csgfju1c6ncf42irj7bg-ha-vpn-gw-1",
      "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnGateways/csgfju1c6ncf42irj7bg-ha-vpn-gw-1",
      "status": "",
      "description": "",
      "details": {
        "ha_vpn_gateway": {
          "id": "projects/ykkim-etri/regions/asia-northeast3/vpnGateways/csgfju1c6ncf42irj7bg-ha-vpn-gw-1",
          "ip_addresses": [
            "34.64.64.90",
            "34.64.131.160"
          ],
          "name": "csgfju1c6ncf42irj7bg-ha-vpn-gw-1",
          "network": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/global/networks/csce5luosgjunknm8td0",
          "resource_type": "google_compute_ha_vpn_gateway"
        },
        "router": {
          "bgp_asn": 65530,
          "id": "projects/ykkim-etri/regions/asia-northeast3/routers/csgfju1c6ncf42irj7bg-router-1",
          "name": "csgfju1c6ncf42irj7bg-router-1",
          "network": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/global/networks/csce5luosgjunknm8td0",
          "resource_type": "google_compute_router"
        },
        "vpn_tunnels": [
          {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/csgfju1c6ncf42irj7bg-vpn-tunnel-1",
            "ike_version": 2,
            "interface": 0,
            "name": "csgfju1c6ncf42irj7bg-vpn-tunnel-1",
            "resource_type": "google_compute_vpn_tunnel"
          },
          {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/csgfju1c6ncf42irj7bg-vpn-tunnel-2",
            "ike_version": 2,
            "interface": 1,
            "name": "csgfju1c6ncf42irj7bg-vpn-tunnel-2",
            "resource_type": "google_compute_vpn_tunnel"
          },
          {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/csgfju1c6ncf42irj7bg-vpn-tunnel-3",
            "ike_version": 2,
            "interface": 0,
            "name": "csgfju1c6ncf42irj7bg-vpn-tunnel-3",
            "resource_type": "google_compute_vpn_tunnel"
          },
          {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/csgfju1c6ncf42irj7bg-vpn-tunnel-4",
            "ike_version": 2,
            "interface": 1,
            "name": "csgfju1c6ncf42irj7bg-vpn-tunnel-4",
            "resource_type": "google_compute_vpn_tunnel"
          }
        ]
      }
    }
  ]
}
```

### Get VPN 

: API: `GET /ns/{nsId}/mci/{mciId}/vpn/{vpnId}`

: nsId = default

: mciId = mci01

: vpnId = vpn01

: Response body

```json
{
  "resourceType": "vpn",
  "id": "vpn02",
  "uid": "csgfju1c6ncf42irj7bg",
  "name": "vpn02",
  "description": "VPN between aws and gcp",
  "status": "Available",
  "vpnGatewayInfo": [
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
      "cspResourceName": "csgfju1c6ncf42irj7bg-vpn-gw",
      "cspResourceId": "vgw-039070840f7ff7bb9",
      "status": "",
      "description": "",
      "details": {
        "customer_gateways": [
          {
            "bgp_asn": "65530",
            "id": "cgw-03ade8dbc888600e2",
            "ip_address": "34.64.64.90",
            "name": "csgfju1c6ncf42irj7bg-gcp-side-gw-1",
            "resource_type": "aws_customer_gateway"
          },
          {
            "bgp_asn": "65530",
            "id": "cgw-0a67dacda8bc41cfd",
            "ip_address": "34.64.131.160",
            "name": "csgfju1c6ncf42irj7bg-gcp-side-gw-2",
            "resource_type": "aws_customer_gateway"
          }
        ],
        "vpn_connections": [
          {
            "id": "vpn-04d6aff1c06e7ceac",
            "name": "csgfju1c6ncf42irj7bg-cnx-1",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "3.38.20.63",
            "tunnel2_address": "3.39.63.243"
          },
          {
            "id": "vpn-0cee0e6ad3a1300db",
            "name": "csgfju1c6ncf42irj7bg-cnx-2",
            "resource_type": "aws_vpn_connection",
            "tunnel1_address": "3.34.88.66",
            "tunnel2_address": "15.164.89.221"
          }
        ],
        "vpn_gateway": {
          "id": "vgw-039070840f7ff7bb9",
          "name": "csgfju1c6ncf42irj7bg-vpn-gw",
          "resource_type": "aws_vpn_gateway",
          "vpc_id": "vpc-088a447966997311a"
        }
      }
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
      "cspResourceName": "csgfju1c6ncf42irj7bg-ha-vpn-gw-1",
      "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnGateways/csgfju1c6ncf42irj7bg-ha-vpn-gw-1",
      "status": "",
      "description": "",
      "details": {
        "ha_vpn_gateway": {
          "id": "projects/ykkim-etri/regions/asia-northeast3/vpnGateways/csgfju1c6ncf42irj7bg-ha-vpn-gw-1",
          "ip_addresses": [
            "34.64.64.90",
            "34.64.131.160"
          ],
          "name": "csgfju1c6ncf42irj7bg-ha-vpn-gw-1",
          "network": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/global/networks/csce5luosgjunknm8td0",
          "resource_type": "google_compute_ha_vpn_gateway"
        },
        "router": {
          "bgp_asn": 65530,
          "id": "projects/ykkim-etri/regions/asia-northeast3/routers/csgfju1c6ncf42irj7bg-router-1",
          "name": "csgfju1c6ncf42irj7bg-router-1",
          "network": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/global/networks/csce5luosgjunknm8td0",
          "resource_type": "google_compute_router"
        },
        "vpn_tunnels": [
          {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/csgfju1c6ncf42irj7bg-vpn-tunnel-1",
            "ike_version": 2,
            "interface": 0,
            "name": "csgfju1c6ncf42irj7bg-vpn-tunnel-1",
            "resource_type": "google_compute_vpn_tunnel"
          },
          {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/csgfju1c6ncf42irj7bg-vpn-tunnel-2",
            "ike_version": 2,
            "interface": 1,
            "name": "csgfju1c6ncf42irj7bg-vpn-tunnel-2",
            "resource_type": "google_compute_vpn_tunnel"
          },
          {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/csgfju1c6ncf42irj7bg-vpn-tunnel-3",
            "ike_version": 2,
            "interface": 0,
            "name": "csgfju1c6ncf42irj7bg-vpn-tunnel-3",
            "resource_type": "google_compute_vpn_tunnel"
          },
          {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/csgfju1c6ncf42irj7bg-vpn-tunnel-4",
            "ike_version": 2,
            "interface": 1,
            "name": "csgfju1c6ncf42irj7bg-vpn-tunnel-4",
            "resource_type": "google_compute_vpn_tunnel"
          }
        ]
      }
    }
  ]
}
```

### Delete VPN 

: API: `DELETE /ns/{nsId}/mci/{mciId}/vpn/{vpnId}`

: nsId = default

: mciId = mci01

: vpnId = vpn02

: Response body

```json
{
  "message": "successfully erased the entire terrarium (trId: csgfju1c6ncf42irj7bg)"
}
```

## Site-to-site VPN between GCP and Azure

### Create VPN 

: API: `POST /ns/{nsId}/mci/{mciId}/vpn`

: nsId = default

: mciId = mci01

: Request body

```json
{
  "name": "vpn01",
  "site1": {
        "csp": "azure",
        "region": "koreacentral",
        "connectionName": "azure-koreacentral",
        "vnet": "csce6cuosgjunknm8tg0",
        "gatewaySubnetCidr": "10.48.128.0/18",
        "resourceGroup": "koreacentral"
      },
  "site2": {
        "csp": "gcp",
        "region": "asia-northeast3",
        "connectionName": "gcp-asia-northeast3",
        "vnet": "csce5luosgjunknm8td0"
      }
}
```

: Response body

```json
{
  "resourceType": "vpn",
  "id": "vpn01",
  "uid": "csgfkv9c6ncf42irj7c0",
  "name": "vpn01",
  "description": "VPN between azure and gcp",
  "status": "Available",
  "vpnGatewayInfo": [
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
      "cspResourceName": "csgfkv9c6ncf42irj7c0-vpn-gw-1",
      "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/virtualNetworkGateways/csgfkv9c6ncf42irj7c0-vpn-gw-1",
      "status": "",
      "description": "",
      "details": {
        "connections": [
          {
            "enable_bgp": true,
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/csgfkv9c6ncf42irj7c0-connection-1",
            "name": "csgfkv9c6ncf42irj7c0-connection-1",
            "resource_type": "azurerm_virtual_network_gateway_connection",
            "type": "IPsec"
          },
          {
            "enable_bgp": true,
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/csgfkv9c6ncf42irj7c0-connection-2",
            "name": "csgfkv9c6ncf42irj7c0-connection-2",
            "resource_type": "azurerm_virtual_network_gateway_connection",
            "type": "IPsec"
          }
        ],
        "public_ips": {
          "ip1": {
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/publicIPAddresses/csgfkv9c6ncf42irj7c0-vpn-gw-pub-ip-1",
            "ip_address": "4.218.18.121",
            "name": "csgfkv9c6ncf42irj7c0-vpn-gw-pub-ip-1",
            "resource_type": "azurerm_public_ip"
          },
          "ip2": {
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/publicIPAddresses/csgfkv9c6ncf42irj7c0-vpn-gw-pub-ip-2",
            "ip_address": "4.218.18.227",
            "name": "csgfkv9c6ncf42irj7c0-vpn-gw-pub-ip-2",
            "resource_type": "azurerm_public_ip"
          }
        },
        "virtual_network_gateway": {
          "bgp_settings": {
            "asn": 65515,
            "peering_addresses": [
              {
                "address": "169.254.21.1",
                "ip_configuration": "csgfkv9c6ncf42irj7c0-vnetGatewayConfig1"
              },
              {
                "address": "169.254.22.1",
                "ip_configuration": "csgfkv9c6ncf42irj7c0-vnetGatewayConfig2"
              }
            ]
          },
          "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/virtualNetworkGateways/csgfkv9c6ncf42irj7c0-vpn-gw-1",
          "location": "koreacentral",
          "name": "csgfkv9c6ncf42irj7c0-vpn-gw-1",
          "resource_type": "azurerm_virtual_network_gateway",
          "sku": "VpnGw1",
          "vpn_type": "RouteBased"
        }
      }
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
      "cspResourceName": "csgfkv9c6ncf42irj7c0-ha-vpn-gw-1",
      "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnGateways/csgfkv9c6ncf42irj7c0-ha-vpn-gw-1",
      "status": "",
      "description": "",
      "details": {
        "bgp_peers": [
          {
            "interface_name": "csgfkv9c6ncf42irj7c0-interface-1",
            "name": "csgfkv9c6ncf42irj7c0-peer-1",
            "peer_asn": 65515,
            "peer_ip": "169.254.21.1",
            "resource_type": "google_compute_router_peer"
          },
          {
            "interface_name": "csgfkv9c6ncf42irj7c0-interface-2",
            "name": "csgfkv9c6ncf42irj7c0-peer-2",
            "peer_asn": 65515,
            "peer_ip": "169.254.22.1",
            "resource_type": "google_compute_router_peer"
          }
        ],
        "ha_vpn_gateway": {
          "id": "projects/ykkim-etri/regions/asia-northeast3/vpnGateways/csgfkv9c6ncf42irj7c0-ha-vpn-gw-1",
          "interfaces": [
            {},
            {}
          ],
          "name": "csgfkv9c6ncf42irj7c0-ha-vpn-gw-1",
          "network": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/global/networks/csce5luosgjunknm8td0",
          "resource_type": "google_compute_ha_vpn_gateway"
        },
        "router": {
          "bgp": {
            "advertise_mode": "CUSTOM",
            "asn": 65534
          },
          "id": "projects/ykkim-etri/regions/asia-northeast3/routers/csgfkv9c6ncf42irj7c0-router-1",
          "name": "csgfkv9c6ncf42irj7c0-router-1",
          "network": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/global/networks/csce5luosgjunknm8td0",
          "resource_type": "google_compute_router"
        },
        "vpn_tunnels": [
          {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/csgfkv9c6ncf42irj7c0-vpn-tunnel-1",
            "interface": 0,
            "name": "csgfkv9c6ncf42irj7c0-vpn-tunnel-1",
            "resource_type": "google_compute_vpn_tunnel",
            "router": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/regions/asia-northeast3/routers/csgfkv9c6ncf42irj7c0-router-1"
          },
          {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/csgfkv9c6ncf42irj7c0-vpn-tunnel-2",
            "interface": 1,
            "name": "csgfkv9c6ncf42irj7c0-vpn-tunnel-2",
            "resource_type": "google_compute_vpn_tunnel",
            "router": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/regions/asia-northeast3/routers/csgfkv9c6ncf42irj7c0-router-1"
          }
        ]
      }
    }
  ]
}
```

#### Get VPN 

: API: `GET /ns/{nsId}/mci/{mciId}/vpn/{vpnId}`

: nsId = default

: mciId = mci01

: vpnId = vpn01

: Response body

```json
{
  "resourceType": "vpn",
  "id": "vpn01",
  "uid": "csgfkv9c6ncf42irj7c0",
  "name": "vpn01",
  "description": "VPN between azure and gcp",
  "status": "Available",
  "vpnGatewayInfo": [
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
      "cspResourceName": "csgfkv9c6ncf42irj7c0-vpn-gw-1",
      "cspResourceId": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/virtualNetworkGateways/csgfkv9c6ncf42irj7c0-vpn-gw-1",
      "status": "",
      "description": "",
      "details": {
        "connections": [
          {
            "enable_bgp": true,
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/csgfkv9c6ncf42irj7c0-connection-1",
            "name": "csgfkv9c6ncf42irj7c0-connection-1",
            "resource_type": "azurerm_virtual_network_gateway_connection",
            "type": "IPsec"
          },
          {
            "enable_bgp": true,
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/connections/csgfkv9c6ncf42irj7c0-connection-2",
            "name": "csgfkv9c6ncf42irj7c0-connection-2",
            "resource_type": "azurerm_virtual_network_gateway_connection",
            "type": "IPsec"
          }
        ],
        "public_ips": {
          "ip1": {
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/publicIPAddresses/csgfkv9c6ncf42irj7c0-vpn-gw-pub-ip-1",
            "ip_address": "4.218.18.121",
            "name": "csgfkv9c6ncf42irj7c0-vpn-gw-pub-ip-1",
            "resource_type": "azurerm_public_ip"
          },
          "ip2": {
            "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/publicIPAddresses/csgfkv9c6ncf42irj7c0-vpn-gw-pub-ip-2",
            "ip_address": "4.218.18.227",
            "name": "csgfkv9c6ncf42irj7c0-vpn-gw-pub-ip-2",
            "resource_type": "azurerm_public_ip"
          }
        },
        "virtual_network_gateway": {
          "bgp_settings": {
            "asn": 65515,
            "peering_addresses": [
              {
                "address": "169.254.21.1",
                "ip_configuration": "csgfkv9c6ncf42irj7c0-vnetGatewayConfig1"
              },
              {
                "address": "169.254.22.1",
                "ip_configuration": "csgfkv9c6ncf42irj7c0-vnetGatewayConfig2"
              }
            ]
          },
          "id": "/subscriptions/a20fed83-96bd-4480-92a9-140b8e3b7c3a/resourceGroups/koreacentral/providers/Microsoft.Network/virtualNetworkGateways/csgfkv9c6ncf42irj7c0-vpn-gw-1",
          "location": "koreacentral",
          "name": "csgfkv9c6ncf42irj7c0-vpn-gw-1",
          "resource_type": "azurerm_virtual_network_gateway",
          "sku": "VpnGw1",
          "vpn_type": "RouteBased"
        }
      }
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
      "cspResourceName": "csgfkv9c6ncf42irj7c0-ha-vpn-gw-1",
      "cspResourceId": "projects/ykkim-etri/regions/asia-northeast3/vpnGateways/csgfkv9c6ncf42irj7c0-ha-vpn-gw-1",
      "status": "",
      "description": "",
      "details": {
        "bgp_peers": [
          {
            "interface_name": "csgfkv9c6ncf42irj7c0-interface-1",
            "name": "csgfkv9c6ncf42irj7c0-peer-1",
            "peer_asn": 65515,
            "peer_ip": "169.254.21.1",
            "resource_type": "google_compute_router_peer"
          },
          {
            "interface_name": "csgfkv9c6ncf42irj7c0-interface-2",
            "name": "csgfkv9c6ncf42irj7c0-peer-2",
            "peer_asn": 65515,
            "peer_ip": "169.254.22.1",
            "resource_type": "google_compute_router_peer"
          }
        ],
        "ha_vpn_gateway": {
          "id": "projects/ykkim-etri/regions/asia-northeast3/vpnGateways/csgfkv9c6ncf42irj7c0-ha-vpn-gw-1",
          "interfaces": [
            {},
            {}
          ],
          "name": "csgfkv9c6ncf42irj7c0-ha-vpn-gw-1",
          "network": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/global/networks/csce5luosgjunknm8td0",
          "resource_type": "google_compute_ha_vpn_gateway"
        },
        "router": {
          "bgp": {
            "advertise_mode": "CUSTOM",
            "asn": 65534
          },
          "id": "projects/ykkim-etri/regions/asia-northeast3/routers/csgfkv9c6ncf42irj7c0-router-1",
          "name": "csgfkv9c6ncf42irj7c0-router-1",
          "network": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/global/networks/csce5luosgjunknm8td0",
          "resource_type": "google_compute_router"
        },
        "vpn_tunnels": [
          {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/csgfkv9c6ncf42irj7c0-vpn-tunnel-1",
            "interface": 0,
            "name": "csgfkv9c6ncf42irj7c0-vpn-tunnel-1",
            "resource_type": "google_compute_vpn_tunnel",
            "router": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/regions/asia-northeast3/routers/csgfkv9c6ncf42irj7c0-router-1"
          },
          {
            "id": "projects/ykkim-etri/regions/asia-northeast3/vpnTunnels/csgfkv9c6ncf42irj7c0-vpn-tunnel-2",
            "interface": 1,
            "name": "csgfkv9c6ncf42irj7c0-vpn-tunnel-2",
            "resource_type": "google_compute_vpn_tunnel",
            "router": "https://www.googleapis.com/compute/v1/projects/ykkim-etri/regions/asia-northeast3/routers/csgfkv9c6ncf42irj7c0-router-1"
          }
        ]
      }
    }
  ]
}
```


#### Delete VPN

: API: `DELETE /ns/{nsId}/mci/{mciId}/vpn/{vpnId}`

: nsId = default

: mciId = mci01

: vpnId = vpn01

: Response body 

```json
{
  "message": "successfully erased the entire terrarium (trId: csgfkv9c6ncf42irj7c0)"
}
```

