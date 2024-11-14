# SQL DB test results using Terrarium and Tumblebug

This document shares the SQL DB test results using Terrarium and Tumblebug

**Environment**
- Tumblebug v0.10.0 + @ (recommend v0.10.1 or later)
- Terrarium 0.0.16

## AWS

> [!IMPORTANT]
> * MySQL 버전 참고: [Amazon RDS의 MySQL 버전](https://docs.aws.amazon.com/ko_kr/AmazonRDS/latest/UserGuide/MySQL.Concepts.VersionMgmt.html)
> * DB instance spec 참고: [Amazon RDS 인스턴스 유형](https://aws.amazon.com/ko/rds/instance-types/)

### Create SQL DB

* API: `POST /ns/{nsId}/resources/sqlDb`
* nsId: default
* Request body:
```json
{
  "connectionName": "aws-ap-northeast-2",
  "csp": "aws",
  "dbAdminPassword": "Password1234!",
  "dbAdminUsername": "mydbadmin",
  "dbEnginePort": 3306,
  "dbEngineVersion": "8.0.39",
  "dbInstanceSpec": "db.t3.micro",
  "name": "sqldb01",
  "region": "ap-northeast-2",
  "requiredCSPResource": {
    "aws": {
      "subnet1ID": "subnet-01d5a43064d86573b",
      "subnet2ID": "subnet-054e2ae6cdb5ba314",
      "vNetID": "vpc-0c6130f1517e875fe"
    }
  }
}
```

* Response body: 
```json
{
  "resourceType": "sqlDb",
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
  "id": "sqldb01",
  "uid": "csqurr4lndqmeupp67r0",
  "name": "sqldb01",
  "cspResourceName": "csqurr4lndqmeupp67r0-db-instance",
  "cspResourceId": "db-55DAM3KN5BZRFR6CKNUF52MTPQ",
  "status": "Available",
  "description": "SQL DB at ap-northeast-2 in aws",
  "details": {
    "admin_username": "mydbadmin",
    "connection_endpoint": "csqurr4lndqmeupp67r0-db-instance.chrkjg2ktom1.ap-northeast-2.rds.amazonaws.com:3306",
    "connection_host": "csqurr4lndqmeupp67r0-db-instance.chrkjg2ktom1.ap-northeast-2.rds.amazonaws.com",
    "connection_port": 3306,
    "engine_name": "mysql",
    "engine_version": "8.0.39",
    "instance_name": "csqurr4lndqmeupp67r0-db-instance",
    "instance_resource_id": "db-55DAM3KN5BZRFR6CKNUF52MTPQ",
    "instance_spec": "db.t3.micro",
    "location": "ap-northeast-2a",
    "provider_specific_detail": {
      "dns_zone_id": "ZLA2NUCOLGUUR",
      "provider": "aws",
      "region": "ap-northeast-2",
      "resource_identifier": "arn:aws:rds:ap-northeast-2:635484366616:db:csqurr4lndqmeupp67r0-db-instance",
      "security_group_ids": [
        "sg-02613696e80bb636a"
      ],
      "status": "available",
      "subnet_group_name": "csqurr4lndqmeupp67r0-rds",
      "zone": "ap-northeast-2a"
    },
    "public_access_enabled": true,
    "storage_size": 20,
    "storage_type": "gp2",
    "tags": {
      "Name": "csqurr4lndqmeupp67r0-db-instance"
    }
  }
}
```


### Get SQL DB

* API: `GET /ns/{nsId}/resources/sqlDb/{sqlDbId}`
* nsId: default
* sqlDbId: sqldb01
* Query param: detail=refined
* Response body:
```json
{
  "resourceType": "sqlDb",
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
  "id": "sqldb01",
  "uid": "csqurr4lndqmeupp67r0",
  "name": "sqldb01",
  "cspResourceName": "csqurr4lndqmeupp67r0-db-instance",
  "cspResourceId": "db-55DAM3KN5BZRFR6CKNUF52MTPQ",
  "status": "Available",
  "description": "SQL DB at ap-northeast-2 in aws",
  "details": {
    "admin_username": "mydbadmin",
    "connection_endpoint": "csqurr4lndqmeupp67r0-db-instance.chrkjg2ktom1.ap-northeast-2.rds.amazonaws.com:3306",
    "connection_host": "csqurr4lndqmeupp67r0-db-instance.chrkjg2ktom1.ap-northeast-2.rds.amazonaws.com",
    "connection_port": 3306,
    "engine_name": "mysql",
    "engine_version": "8.0.39",
    "instance_name": "csqurr4lndqmeupp67r0-db-instance",
    "instance_resource_id": "db-55DAM3KN5BZRFR6CKNUF52MTPQ",
    "instance_spec": "db.t3.micro",
    "location": "ap-northeast-2a",
    "provider_specific_detail": {
      "dns_zone_id": "ZLA2NUCOLGUUR",
      "provider": "aws",
      "region": "ap-northeast-2",
      "resource_identifier": "arn:aws:rds:ap-northeast-2:635484366616:db:csqurr4lndqmeupp67r0-db-instance",
      "security_group_ids": [
        "sg-02613696e80bb636a"
      ],
      "status": "available",
      "subnet_group_name": "csqurr4lndqmeupp67r0-rds",
      "zone": "ap-northeast-2a"
    },
    "public_access_enabled": true,
    "storage_size": 20,
    "storage_type": "gp2",
    "tags": {
      "Name": "csqurr4lndqmeupp67r0-db-instance"
    }
  }
}
```


### Delete SQL DB

* API: `DELETE /ns/{nsId}/resources/sqlDb/{sqlDbId}`
* nsId: default
* sqlDbId: sqldb01
* Response body:
```json
{
  "message": "successfully erased the entire terrarium (trId: csqurr4lndqmeupp67r0)"
}
```


## Azure

> [!IMPORTANT]
> * MySQL 버전 참고: [`version` in Terraform azurerm_mysql_flexible_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server#version-1)
> * DB instance spec 참고: [Azure Database for MySQL - 유연한 서버 서비스 계층](https://learn.microsoft.com/ko-kr/azure/mysql/flexible-server/concepts-service-tiers-storage)

### Create SQL DB

* API: `POST /ns/{nsId}/resources/sqlDb`
* nsId: default
* Request body:
```json
{
  "connectionName": "azure-koreacentral",
  "csp": "azure",
  "dbAdminPassword": "Password1234!",
  "dbAdminUsername": "mydbadmin",
  "dbEnginePort": 3306,
  "dbEngineVersion": "8.0.21",
  "dbInstanceSpec": "B_Standard_B2s",
  "name": "sqldb01",
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
  "resourceType": "sqlDb",
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
  "id": "sqldb01",
  "uid": "csr0muupcfm5tvpuhjrg",
  "name": "sqldb01",
  "cspResourceName": "csr0muupcfm5tvpuhjrg-db-instance",
  "cspResourceId": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxx/resourceGroups/koreacentral/providers/Microsoft.DBforMySQL/flexibleServers/csr0muupcfm5tvpuhjrg-db-instance",
  "status": "Available",
  "description": "SQL DB at koreacentral in azure",
  "details": {
    "admin_username": "mydbadmin",
    "connection_endpoint": "csr0muupcfm5tvpuhjrg-db-instance.mysql.database.azure.com:3306",
    "connection_host": "csr0muupcfm5tvpuhjrg-db-instance.mysql.database.azure.com",
    "connection_port": 3306,
    "engine_name": "mysql",
    "engine_version": "8.0.21",
    "instance_name": "csr0muupcfm5tvpuhjrg-db-instance",
    "instance_resource_id": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxx/resourceGroups/koreacentral/providers/Microsoft.DBforMySQL/flexibleServers/csr0muupcfm5tvpuhjrg-db-instance",
    "instance_spec": "B_Standard_B2s",
    "location": "koreacentral",
    "provider_specific_detail": {
      "backup_retention_days": 7,
      "charset": "utf8mb3",
      "collation": "utf8mb3_general_ci",
      "database_name": "csr0muupcfm5tvpuhjrg-db-engine",
      "provider": "azure",
      "region": "koreacentral",
      "replica_capacity": 10,
      "replication_role": "None",
      "resource_group_name": "koreacentral",
      "resource_identifier": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxx/resourceGroups/koreacentral/providers/Microsoft.DBforMySQL/flexibleServers/csr0muupcfm5tvpuhjrg-db-instance",
      "storage_autogrow_enabled": true,
      "zone": "2"
    },
    "public_access_enabled": true,
    "storage_size": 20,
    "storage_type": "Premium_LRS"
  }
}
```


### Get SQL DB

* API: `GET /ns/{nsId}/resources/sqlDb/{sqlDbId}`
* nsId: default
* sqlDbId: sqldb01
* Query param: detail=refined
* Response body:
```json
{
  "resourceType": "sqlDb",
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
  "id": "sqldb01",
  "uid": "csr0muupcfm5tvpuhjrg",
  "name": "sqldb01",
  "cspResourceName": "csr0muupcfm5tvpuhjrg-db-instance",
  "cspResourceId": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxx/resourceGroups/koreacentral/providers/Microsoft.DBforMySQL/flexibleServers/csr0muupcfm5tvpuhjrg-db-instance",
  "status": "Available",
  "description": "SQL DB at koreacentral in azure",
  "details": {
    "admin_username": "mydbadmin",
    "connection_endpoint": "csr0muupcfm5tvpuhjrg-db-instance.mysql.database.azure.com:3306",
    "connection_host": "csr0muupcfm5tvpuhjrg-db-instance.mysql.database.azure.com",
    "connection_port": 3306,
    "engine_name": "mysql",
    "engine_version": "8.0.21",
    "instance_name": "csr0muupcfm5tvpuhjrg-db-instance",
    "instance_resource_id": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxx/resourceGroups/koreacentral/providers/Microsoft.DBforMySQL/flexibleServers/csr0muupcfm5tvpuhjrg-db-instance",
    "instance_spec": "B_Standard_B2s",
    "location": "koreacentral",
    "provider_specific_detail": {
      "backup_retention_days": 7,
      "charset": "utf8mb3",
      "collation": "utf8mb3_general_ci",
      "database_name": "csr0muupcfm5tvpuhjrg-db-engine",
      "provider": "azure",
      "region": "koreacentral",
      "replica_capacity": 10,
      "replication_role": "None",
      "resource_group_name": "koreacentral",
      "resource_identifier": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxx/resourceGroups/koreacentral/providers/Microsoft.DBforMySQL/flexibleServers/csr0muupcfm5tvpuhjrg-db-instance",
      "storage_autogrow_enabled": true,
      "zone": "2"
    },
    "public_access_enabled": true,
    "storage_size": 20,
    "storage_type": "Premium_LRS"
  }
}
```


### Delete SQL DB

* API: `DELETE /ns/{nsId}/resources/sqlDb/{sqlDbId}`
* nsId: default
* sqlDbId: sqldb01
* Response body:
```json
{
  "message": "successfully erased the entire terrarium (trId: csr0muupcfm5tvpuhjrg)"
}
```


## GCP

> [!IMPORTANT]
> * MySQL 버전 참고: [`database_version` in Terraform google_sql_database_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance#database_version-1)
> * DB instance spec 참고: [머신 유형 in 인스턴스 설정 정보](https://cloud.google.com/sql/docs/mysql/instance-settings?hl=ko#machine-type-2ndgen)

### Create SQL DB

* API: `POST /ns/{nsId}/resources/sqlDb`
* nsId: default
* Request body:
```json
{
  "connectionName": "gcp-asia-northeast3",
  "csp": "gcp",
  "dbAdminPassword": "Password1234!",
  "dbAdminUsername": "mydbadmin",
  "dbEnginePort": 3306,
  "dbEngineVersion": "MYSQL_8_0",
  "dbInstanceSpec": "db-n1-standard-2",
  "name": "sqldb01",
  "region": "asia-northeast3"
}
```

* Response body: 
```json
{
  "resourceType": "sqlDb",
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
  "id": "sqldb01",
  "uid": "csr0tmepcfm5tvpuhjs0",
  "name": "sqldb01",
  "cspResourceName": "csr0tmepcfm5tvpuhjs0-db-instance",
  "cspResourceId": "csr0tmepcfm5tvpuhjs0-db-instance",
  "status": "Available",
  "description": "SQL DB at asia-northeast3 in gcp",
  "details": {
    "admin_username": "mydbadmin",
    "connection_endpoint": "34.47.112.138:3306",
    "connection_host": "34.47.112.138",
    "connection_port": 3306,
    "engine_name": "mysql",
    "engine_version": "MYSQL_8_0",
    "instance_name": "csr0tmepcfm5tvpuhjs0-db-instance",
    "instance_resource_id": "csr0tmepcfm5tvpuhjs0-db-instance",
    "instance_spec": "db-n1-standard-2",
    "location": "asia-northeast3-a",
    "provider_specific_detail": {
      "availability_type": "ZONAL",
      "project": "ykkim-etri",
      "provider": "gcp",
      "region": "asia-northeast3",
      "resource_identifier": "https://sqladmin.googleapis.com/sql/v1beta4/projects/xxxxxxxx/instances/csr0tmepcfm5tvpuhjs0-db-instance",
      "zone": "asia-northeast3-a"
    },
    "public_access_enabled": true,
    "storage_size": 10,
    "storage_type": "PD_SSD"
  }
}
```


### Get SQL DB

* API: `GET /ns/{nsId}/resources/sqlDb/{sqlDbId}`
* nsId: default
* sqlDbId: sqldb01
* Query param: detail=refined
* Response body:
```json
{
  "resourceType": "sqlDb",
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
  "id": "sqldb01",
  "uid": "csr0tmepcfm5tvpuhjs0",
  "name": "sqldb01",
  "cspResourceName": "csr0tmepcfm5tvpuhjs0-db-instance",
  "cspResourceId": "csr0tmepcfm5tvpuhjs0-db-instance",
  "status": "Available",
  "description": "SQL DB at asia-northeast3 in gcp",
  "details": {
    "admin_username": "mydbadmin",
    "connection_endpoint": "34.47.112.138:3306",
    "connection_host": "34.47.112.138",
    "connection_port": 3306,
    "engine_name": "mysql",
    "engine_version": "MYSQL_8_0",
    "instance_name": "csr0tmepcfm5tvpuhjs0-db-instance",
    "instance_resource_id": "csr0tmepcfm5tvpuhjs0-db-instance",
    "instance_spec": "db-n1-standard-2",
    "location": "asia-northeast3-a",
    "provider_specific_detail": {
      "availability_type": "ZONAL",
      "project": "ykkim-etri",
      "provider": "gcp",
      "region": "asia-northeast3",
      "resource_identifier": "https://sqladmin.googleapis.com/sql/v1beta4/projects/xxxxxxxx/instances/csr0tmepcfm5tvpuhjs0-db-instance",
      "zone": "asia-northeast3-a"
    },
    "public_access_enabled": true,
    "storage_size": 10,
    "storage_type": "PD_SSD"
  }
}
```


### Delete SQL DB

* API: `DELETE /ns/{nsId}/resources/sqlDb/{sqlDbId}`
* nsId: default
* sqlDbId: sqldb01
* Response body:
```json
{
  "message": "successfully erased the entire terrarium (trId: csr0tmepcfm5tvpuhjs0)"
}
```


## NCP


> [!INOTE]
> * Unable to set MySQL version
> * Unable to set DB instance spec

### Create SQL DB

* API: `POST /ns/{nsId}/resources/sqlDb`
* nsId: default
* Request body:
```json
{
  "connectionName": "ncpvpc-kr",
  "csp": "ncp",
  "dbAdminPassword": "Password1234!",
  "dbAdminUsername": "mydbadmin",
  "name": "sqldb01",
  "region": "kr",
  "requiredCSPResource": {
    "ncp": {
      "subnetID": "185923"
    }
  }
}
```

* Response body: 
```json
{
  "resourceType": "sqlDb",
  "connectionName": "ncpvpc-kr",
  "connectionConfig": {
    "configName": "ncpvpc-kr",
    "providerName": "ncpvpc",
    "driverName": "ncpvpc-driver-v1.0.so",
    "credentialName": "ncpvpc",
    "credentialHolder": "admin",
    "regionZoneInfoName": "ncpvpc-kr",
    "regionZoneInfo": {
      "assignedRegion": "KR",
      "assignedZone": "KR-1"
    },
    "regionDetail": {
      "regionId": "KR",
      "regionName": "kr",
      "description": "Korea 1",
      "location": {
        "display": "Seoul(Gasan) / Pyeongchon (South Korea)",
        "latitude": 37.4754,
        "longitude": 126.8831
      },
      "zones": [
        "KR-1",
        "KR-2"
      ]
    },
    "regionRepresentative": true,
    "verified": true
  },
  "id": "sqldb01",
  "uid": "csr2n5fnm5nds72sni40",
  "name": "sqldb01",
  "cspResourceName": "csr2n5fnm5nds72sni40-svc",
  "cspResourceId": "100461110",
  "status": "Available",
  "description": "SQL DB at kr in ncp",
  "details": {
    "admin_username": "mydbadmin",
    "connection_endpoint": "db-2vpqho.vpc-cdb.ntruss.com:3306",
    "connection_host": "db-2vpqho.vpc-cdb.ntruss.com",
    "connection_port": 3306,
    "engine_name": "mysql",
    "engine_version": "MYSQL8.0.36",
    "instance_name": "csr2n5fnm5nds72sni40-svc",
    "instance_resource_id": "100461110",
    "instance_spec": "SW.VMYSL.OS.LNX64.ROCKY.0810.MYSQL.B050",
    "location": "KR",
    "provider_specific_detail": {
      "access_control_group_no_list": [
        "218353"
      ],
      "backup_enabled": true,
      "backup_file_retention_period": 1,
      "backup_time": "12:00",
      "host_ip": "%",
      "provider": "ncp",
      "resource_identifier": "100461110",
      "server_instances": [
        {
          "cpu_count": 2,
          "create_date": "2024-11-15T01:55:56+0900",
          "memory_size": 4294967296,
          "name": "svr-name-prefix-001-61y1",
          "role": "M",
          "server_instance_no": "100461112",
          "uptime": "2024-11-15T02:00:29+0900"
        },
        {
          "cpu_count": 2,
          "create_date": "2024-11-15T01:55:56+0900",
          "memory_size": 4294967296,
          "name": "svr-name-prefix-002-61y2",
          "role": "H",
          "server_instance_no": "100461118",
          "uptime": "2024-11-15T01:59:51+0900"
        }
      ],
      "server_name_prefix": "svr-name-prefix",
      "subnet_no": "185923",
      "vpc_no": "82850"
    },
    "public_access_enabled": true,
    "storage_size": 10,
    "storage_type": "SSD"
  }
}
```


### Get SQL DB

* API: `GET /ns/{nsId}/resources/sqlDb/{sqlDbId}`
* nsId: default
* sqlDbId: sqldb01
* Query param: detail=refined
* Response body:
```json
{
  "resourceType": "sqlDb",
  "connectionName": "ncpvpc-kr",
  "connectionConfig": {
    "configName": "ncpvpc-kr",
    "providerName": "ncpvpc",
    "driverName": "ncpvpc-driver-v1.0.so",
    "credentialName": "ncpvpc",
    "credentialHolder": "admin",
    "regionZoneInfoName": "ncpvpc-kr",
    "regionZoneInfo": {
      "assignedRegion": "KR",
      "assignedZone": "KR-1"
    },
    "regionDetail": {
      "regionId": "KR",
      "regionName": "kr",
      "description": "Korea 1",
      "location": {
        "display": "Seoul(Gasan) / Pyeongchon (South Korea)",
        "latitude": 37.4754,
        "longitude": 126.8831
      },
      "zones": [
        "KR-1",
        "KR-2"
      ]
    },
    "regionRepresentative": true,
    "verified": true
  },
  "id": "sqldb01",
  "uid": "csr2n5fnm5nds72sni40",
  "name": "sqldb01",
  "cspResourceName": "csr2n5fnm5nds72sni40-svc",
  "cspResourceId": "100461110",
  "status": "Available",
  "description": "SQL DB at kr in ncp",
  "details": {
    "admin_username": "mydbadmin",
    "connection_endpoint": "db-2vpqho.vpc-cdb.ntruss.com:3306",
    "connection_host": "db-2vpqho.vpc-cdb.ntruss.com",
    "connection_port": 3306,
    "engine_name": "mysql",
    "engine_version": "MYSQL8.0.36",
    "instance_name": "csr2n5fnm5nds72sni40-svc",
    "instance_resource_id": "100461110",
    "instance_spec": "SW.VMYSL.OS.LNX64.ROCKY.0810.MYSQL.B050",
    "location": "KR",
    "provider_specific_detail": {
      "access_control_group_no_list": [
        "218353"
      ],
      "backup_enabled": true,
      "backup_file_retention_period": 1,
      "backup_time": "12:00",
      "host_ip": "%",
      "provider": "ncp",
      "resource_identifier": "100461110",
      "server_instances": [
        {
          "cpu_count": 2,
          "create_date": "2024-11-15T01:55:56+0900",
          "memory_size": 4294967296,
          "name": "svr-name-prefix-001-61y1",
          "role": "M",
          "server_instance_no": "100461112",
          "uptime": "2024-11-15T02:00:29+0900"
        },
        {
          "cpu_count": 2,
          "create_date": "2024-11-15T01:55:56+0900",
          "memory_size": 4294967296,
          "name": "svr-name-prefix-002-61y2",
          "role": "H",
          "server_instance_no": "100461118",
          "uptime": "2024-11-15T01:59:51+0900"
        }
      ],
      "server_name_prefix": "svr-name-prefix",
      "subnet_no": "185923",
      "vpc_no": "82850"
    },
    "public_access_enabled": true,
    "storage_size": 10,
    "storage_type": "SSD"
  }
}
```


### Delete SQL DB

* API: `DELETE /ns/{nsId}/resources/sqlDb/{sqlDbId}`
* nsId: default
* sqlDbId: sqldb01
* Response body:
```json
{
  "message": "successfully erased the entire terrarium (trId: csr2n5fnm5nds72sni40)"
}
```
