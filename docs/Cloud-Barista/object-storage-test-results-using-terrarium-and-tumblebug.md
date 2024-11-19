# Object Storage test results using Terrarium and Tumblebug

This document shares the Object Storage test results using Terrarium and Tumblebug

**Environment**
- Tumblebug v0.10.1 + @ (recommend v0.10.2 or later)
- Terrarium 0.0.17

## AWS

### Create Object Storage

* API: `POST /ns/{nsId}/resources/objectStorage`
* nsId: default
* Request body:
```json
{
  "connectionName": "aws-ap-northeast-2",
  "csp": "aws",
  "name": "objectstorage01",
  "region": "ap-northeast-2"
}
```

* Response body:
```json
{
  "resourceType": "objectStorage",
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
  "id": "objectstorage01",
  "uid": "csu8n5mstdrk9icm4e1g",
  "name": "objectstorage01",
  "cspResourceName": "csu8n5mstdrk9icm4e1g-bucket",
  "status": "Available",
  "description": "Object Storage at ap-northeast-2 in aws",
  "details": {
    "https_only": true,
    "location": "ap-northeast-2",
    "primary_endpoint": "csu8n5mstdrk9icm4e1g-bucket.s3.amazonaws.com",
    "provider_specific_detail": {
      "bucket_arn": "arn:aws:s3:::csu8n5mstdrk9icm4e1g-bucket",
      "bucket_name": "csu8n5mstdrk9icm4e1g-bucket",
      "bucket_region": "ap-northeast-2",
      "provider": "aws",
      "public_access_config": {
        "block_public_acls": true,
        "block_public_policy": true,
        "ignore_public_acls": true,
        "restrict_public_buckets": true
      },
      "regional_domain_name": "csu8n5mstdrk9icm4e1g-bucket.s3.ap-northeast-2.amazonaws.com",
      "versioning_enabled": false
    },
    "public_access_enabled": false,
    "storage_name": "csu8n5mstdrk9icm4e1g-bucket",
    "tags": {
      "Name": "csu8n5mstdrk9icm4e1g-bucket"
    }
  }
}
```

### Get Object Storage

* API: `GET /ns/{nsId}/resources/objectStorage/{objectStorageId}`
* nsId: default
* objectStorageId: objectstorage01
* Query param: detail=refined
* Response body:
```json
{
  "resourceType": "objectStorage",
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
  "id": "objectstorage01",
  "uid": "csu8n5mstdrk9icm4e1g",
  "name": "objectstorage01",
  "cspResourceName": "csu8n5mstdrk9icm4e1g-bucket",
  "status": "Available",
  "description": "Object Storage at ap-northeast-2 in aws",
  "details": {
    "https_only": true,
    "location": "ap-northeast-2",
    "primary_endpoint": "csu8n5mstdrk9icm4e1g-bucket.s3.amazonaws.com",
    "provider_specific_detail": {
      "bucket_arn": "arn:aws:s3:::csu8n5mstdrk9icm4e1g-bucket",
      "bucket_name": "csu8n5mstdrk9icm4e1g-bucket",
      "bucket_region": "ap-northeast-2",
      "provider": "aws",
      "public_access_config": {
        "block_public_acls": true,
        "block_public_policy": true,
        "ignore_public_acls": true,
        "restrict_public_buckets": true
      },
      "regional_domain_name": "csu8n5mstdrk9icm4e1g-bucket.s3.ap-northeast-2.amazonaws.com",
      "versioning_enabled": false
    },
    "public_access_enabled": false,
    "storage_name": "csu8n5mstdrk9icm4e1g-bucket",
    "tags": {
      "Name": "csu8n5mstdrk9icm4e1g-bucket"
    }
  }
}
```

### Delete Object Storage
* API: `DELETE /ns/{nsId}/resources/objectStorage/{objectStorageId}`
* nsId: default
* objectStorageId: objectstorage01
* Response body:

```json
{
  "message": "successfully erased the entire terrarium (trId: csu8n5mstdrk9icm4e1g)"
}
```



## Azure

### Create Object Storage

* API: `POST /ns/{nsId}/resources/objectStorage`
* nsId: default
* Request body:
```json
{
  "connectionName": "azure-koreacentral",
  "csp": "azure",
  "name": "objectstorage01",
  "region": "koreacentral",
  "requiredCSPResource": {
    "azure": {
      "resourceGroup": "koreacentral"
    }
  }
}
```

* Response body:
```json
{
  "resourceType": "objectStorage",
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
  "id": "objectstorage01",
  "uid": "csu8p5mstdrk9icm4e20",
  "name": "objectstorage01",
  "cspResourceName": "csu8p5mstdrk9icm4e20",
  "status": "Available",
  "description": "Object Storage at koreacentral in azure",
  "details": {
    "https_only": true,
    "location": "koreacentral",
    "primary_endpoint": "https://csu8p5mstdrk9icm4e20.blob.core.windows.net/",
    "provider_specific_detail": {
      "access_tier": "Hot",
      "account_tier": "Standard",
      "endpoints": {
        "blob": "https://csu8p5mstdrk9icm4e20.blob.core.windows.net/",
        "blob_host": "csu8p5mstdrk9icm4e20.blob.core.windows.net",
        "dfs": "https://csu8p5mstdrk9icm4e20.dfs.core.windows.net/",
        "web": "https://csu8p5mstdrk9icm4e20.z12.web.core.windows.net/"
      },
      "network_rules": {
        "bypass": [
          "AzureServices"
        ],
        "default_action": "Allow"
      },
      "provider": "azure",
      "replication_type": "LRS",
      "resource_group": "koreacentral",
      "storage_account_name": "csu8p5mstdrk9icm4e20"
    },
    "public_access_enabled": true,
    "storage_name": "csu8p5mstdrk9icm4e20",
    "tags": null
  }
}
```

### Get Object Storage

* API: `GET /ns/{nsId}/resources/objectStorage/{objectStorageId}`
* nsId: default
* objectStorageId: objectstorage01
* Query param: detail=refined
* Response body:
```json
{
  "resourceType": "objectStorage",
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
  "id": "objectstorage01",
  "uid": "csu8p5mstdrk9icm4e20",
  "name": "objectstorage01",
  "cspResourceName": "csu8p5mstdrk9icm4e20",
  "status": "Available",
  "description": "Object Storage at koreacentral in azure",
  "details": {
    "https_only": true,
    "location": "koreacentral",
    "primary_endpoint": "https://csu8p5mstdrk9icm4e20.blob.core.windows.net/",
    "provider_specific_detail": {
      "access_tier": "Hot",
      "account_tier": "Standard",
      "endpoints": {
        "blob": "https://csu8p5mstdrk9icm4e20.blob.core.windows.net/",
        "blob_host": "csu8p5mstdrk9icm4e20.blob.core.windows.net",
        "dfs": "https://csu8p5mstdrk9icm4e20.dfs.core.windows.net/",
        "web": "https://csu8p5mstdrk9icm4e20.z12.web.core.windows.net/"
      },
      "network_rules": {
        "bypass": [
          "AzureServices"
        ],
        "default_action": "Allow"
      },
      "provider": "azure",
      "replication_type": "LRS",
      "resource_group": "koreacentral",
      "storage_account_name": "csu8p5mstdrk9icm4e20"
    },
    "public_access_enabled": true,
    "storage_name": "csu8p5mstdrk9icm4e20",
    "tags": null
  }
}
```

### Delete Object Storage
* API: `DELETE /ns/{nsId}/resources/objectStorage/{objectStorageId}`
* nsId: default
* objectStorageId: objectstorage01
* Response body:

```json
{
  "message": "successfully erased the entire terrarium (trId: csu8p5mstdrk9icm4e20)"
}
```

