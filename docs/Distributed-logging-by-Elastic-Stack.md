# Distributed logging by ELK Stack
NOTE - ELK: Elasticsearch, Logstash and Kibana (see [Elastic Stack](https://www.elastic.co/kr/what-is/elk-stack))

간단한 적용기를 남기고자 글을 작성합니다 ^^


## Overview
### Background

CB-Larva에서는 멀티클라우드를 위한 네트워크 기술 및 시스템을 연구 개발하고 있습니다.
마이크로서비스 아키텍처를 지향하고 있어 각 서비스/프로세스를 목적에 따라 독립적으로 구동할 수 있도록 개발했는데요(아래 그림 참고). 
그런데, 분산된 서비스를 디버깅 하는 것이 꽤 어려웠습니다.
앞으로 기능이 추가되면 디버깅이 더욱 더 어려워질 것이 예상하여, 분산 로깅 시스템을 적용하였습니다.

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/185275337-5eb92a58-a482-42fe-9ba6-ce4a627cb81f.png" width="80%" height="80%" >
</p>


### Introduction to Elastic Stack

분산 로깅 시스템으로 오픈소스인 Elastic Stack을 선택 및 적용했습니다(CB-Larva는 비 상용). 

아래 그림과 같은 순서로 Elastic Stack은 로그를 수집합니다. 간략히는, Beats(i.e., Filebeat)가 파일에 저장된 로그를 수집하여 Logstash로 전송합니다. 
Logstash는 전송받은 로그 데이터를 처리하고 Elasticsearch에 전송합니다. 
Elasticsearch는 전송받은 로그를 저장합니다. Kibana는 Elasticsearch에 저장된 로그를 읽어 시각화 합니다. 
(약간 더 자세하게) 각각은 아래와 같은 작업을 수행합니다.
- Elasticsearch: Store, Search, and Analyze
- Kibana: Explore, Visualize, and Share
- Logstash: Collect, Enrich, and Transport
- Beats: Collect, Parse, and Ship

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/185298255-c0928cef-c5b1-47d1-8d9c-9023b3959a0a.png" width="80%" height="80%" >
</p>

Elasic Stack 관련 문서는 아래 공식 홈페이지를 참고하시기 바랍니다.
참고: [Elastic Stack](https://www.elastic.co/kr/what-is/elk-stack)


## Multi-cloud network system with distributed logging

아래 그림은 분산 로깅을 위해 Elastic Stack을 멀티클라우드 네트워크 시스템(cb-network system)에 적용했을때의 구조와 흐름을 나타냅니다. 
멀티클라우드 네트워크 시스템은 다음과 같은 독립적인 컴포넌트(cb-network controller, cb-network service, cb-network admin-web, cb-network agent)로 구성되어 있습니다. 
각 컴포넌트는 cb-log라는 Cloud-Barista community에서 개발한 Go 패키지를 사용하여 로깅을 수행하고, 로그 정보를 파일에 기록합니다. 
Filebeat가 로그 파일을 읽어 추가/변경된 부분만 Logstash로 전송합니다. 
이로서 멀티클라우드 네트워크 시스템과 Elastic Stack을 통합하여 분산 로깅을 할 수 있게 되었습니다 :sunglasses:

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/185298611-44f1226d-9929-4bcc-933c-740e907c4091.png" width="90%" height="90%" >
</p>

### Logs collected from distributed nodes

Kibana를 통해 분산된 노드에서 수집한 로그를 확인해 보겠습니다. 최근 24시간 이내에 수집되었던 로그 정보를 표시하도록 하였습니다.

아래 그림에서 Elastic Stack의 로그 수집 과정을 거치면서 포함된 부가 정보들을 확인 할 수 있습니다.
<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/185302612-deeb6abc-e9c1-453e-9fab-e19e51371a51.png" width="100%" height="100%" >
</p>

여기서는 멀티클라우드 네트워크 시스템의 각 컴포넌트의 로그만 확인하면 되는 상황이라, 다른 로그는 보이지 않도록 `message`를 필터로 추가하였습니다. 다음 그림은 그 결과를 나타냅니다.
<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/185302660-6e8340ad-2fb1-403f-acb1-5735b0229bc8.png" width="100%" height="100%" >
</p>


현재, 분산된 컴포넌트의 로그 수집에는 문제가 없으나 Logger Name이 동일하여 구분이 어려운 상태네요 ^^;; 개선해야겠습니다!

---

## A guide to download and deploy Elastic Stack

Elastic Stack 설치, 구동, 연동 등을 위해 참고할 수 있는 좋은 글이 많이 있습니다. 
그럼에도 불구하고 설치 및 배치 가이드를 남기는 이유는 다음과 같습니다.
1. 버전을 선택하여 설치할 때 참고 (제 경우 8.3.0 설치)
2. OS별로 설치 방법 참고 (제 경우 Debian, RedHat 계열에 설치)
3. 설정 파일 위치 및 방법 참고 (제 경우 보안 미적용)

기본적으로 공식 홈페이지를 참고했고, 
분산 로깅을 위해서 Elasticsearch, Kibana, Logstash, Filebeat를 설치 및 활용했습니다(버전은 8.3.0으로 통일).

참고: [Official website](https://www.elastic.co/downloads/)
<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/185279871-e001e959-d5c2-4533-8c40-b394464bb3a4.png" width="80%" height="80%" >
</p>

### Prerequisites
#### Install Java Development Kit (JDK) 
Elasticsearch, Kibana, Logstash, Filebeat는 JVM 상에서 구동됩니다. 따라서 OpenJDK 1.8+을 설치해야합니다.

참고 - [Support Matrix](https://www.elastic.co/support/matrix)

On Ubuntu 18.04
```bash
sudo apt update
sudo apt install openjdk-11-jdk
```

On Rocky Linux
```bash
sudo yum update
sudo yum install java-11-openjdk
```

### Setup ELK on a server
#### Create a virtual machine for ELK

AWS의 가상머신(VM, virtual machine)에서 Elasticsearch, Logstash, Kibana를 설치 및 배치했습니다. 

VM 스펙:
- OS: Ubuntu 18.04
- vCPU: 2
- RAM: 4GB
- Storage: 100GB

위 스펙에서 ELK를 모두 돌리면 종종 버거워 하네요 ... :sob:

각 CSP에서 VM 생성 및 접속 관련해서는 아래 글을 참고하시기 바랍니다. Cloud-Barista 커뮤니티 기여자분들께서 작성해주셨습니다. :thumbsup:

참고: 
- [A guide to creating and accessing an instance in AWS](https://github.com/cloud-barista/cb-coffeehouse/blob/main/docs/Public-Cloud/Creating%20New%20AWS%20Account%20and%20setting%20new%20VPC%20and%20VM.md)
- [A guide to creating and accessing an instance in MS Azure](https://github.com/cloud-barista/cb-coffeehouse/blob/main/docs/Public-Cloud/Creating-and-accessing-an-instance-on-MS-Azure-Platform.md)
- [A guide to creating and accessing an instance in GCP](https://github.com/cloud-barista/cb-coffeehouse/blob/main/docs/Public-Cloud/Creating-and-accessing-an-instance-on-GCP.md)
- [A guide to creating and accessing an instance in Alibaba Cloud](https://github.com/cloud-barista/cb-coffeehouse/blob/main/docs/Public-Cloud/Creating%20and%20accessing%20an%20instance%20on%20AlibabaCloud.md)

Mini PC에 재 구축 했습니다.

Mini PC 스펙:
- OS: Ubuntu 20.04.4 LTS
- Processor: Intel(R) Core(TM) i5-4670 CPU @ 3.40GHz
- RAM: 12GB
- Storage: 128GB - SAMSUNG SSD 830, 500GB - Seagate ST500LM021-1KJ15


#### Download and install Elasticsearch
##### 1. Elasticsearch 다운로드 페이지 접속
##### 2. View past releases 이동
<p align="center">
    <img src="https://user-images.githubusercontent.com/7975459/185281689-b4ff365e-d74f-4275-b622-46f574d32d65.png" width="70%" height="70%" >
</p>

##### 3. Elasticsearch 8.3.0 Download 클릭
<p align="center">
    <img src="https://user-images.githubusercontent.com/7975459/185281939-4ad5dbab-6d02-4498-b023-91210cc97991.png" width="70%" height="70%" >
</p>

##### 4. 설치환경에 맞는 링크복사
마우스 우클릭하여 `DEB X86_64`의 링크를 복사함 (저는 Debian 계열)

<p align="center">
    <img src="https://user-images.githubusercontent.com/7975459/185282148-618726c0-cf9d-490a-a97d-ffdd02df56a6.png" width="70%" height="70%" >
</p>

##### 5. VM에 패키지 다운로드
```bash
cd ~
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.3.0-amd64.deb
```

##### 6. 패키지 설치
```bash
cd ~
sudo dpkg -i elasticsearch-8.3.0-amd64.deb
```

<ins>**!!!중요!!!**</ins>
- 메모해둘 것: ID (e.g., elastic), Password (e.g., PASSPASSPASSPASS), 및 가이드 등
- Kibana interface 접속할 때 필요함

```bash
--------------------------- Security autoconfiguration information ------------------------------

Authentication and authorization are enabled.
TLS for the transport and HTTP layers is enabled and configured.

The generated password for the elastic built-in superuser is : PASSPASSPASSPASS

If this node should join an existing cluster, you can reconfigure this with
'/usr/share/elasticsearch/bin/elasticsearch-reconfigure-node --enrollment-token <token-here>'
after creating an enrollment token on your existing cluster.

You can complete the following actions at any time:

Reset the password of the elastic built-in superuser with
'/usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic'.

Generate an enrollment token for Kibana instances with
 '/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana'.

Generate an enrollment token for Elasticsearch nodes with
'/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s node'.

-------------------------------------------------------------------------------------------------
### NOT starting on installation, please execute the following statements to configure elasticsearch service to start automatically using systemd
 sudo systemctl daemon-reload
 sudo systemctl enable elasticsearch.service
### You can start elasticsearch service by executing
 sudo systemctl start elasticsearch.service
```

#### Download and install Logstash

Logstash를 대상으로 위 Elasticsearch의 1 ~ 6 과정 수행

참고 - Debian 계열을 위한 Logstash 8.3.0 설치 파일
```
cd ~ 
wget https://artifacts.elastic.co/downloads/logstash/logstash-8.3.0-amd64.deb
```

#### Download and install Kibana

Kibana를 대상으로 위 Elasticsearch의 1 ~ 6 과정 수행

참고 - Debian 계열을 위한 Kibana 8.3.0 설치 파일
```
cd ~ 
wget https://artifacts.elastic.co/downloads/kibana/kibana-8.3.0-amd64.deb
```

### Setup Filebeat on nodes to log
제 환경의 Nodes to log: cb-network controller(s), cb-network service, cb-network admin-web, cb-network agent(s)가 동작하는 노드

#### Download and install Filebeat

Filebeat는 `Ubuntu 18.04`와 `Rocky Linux 8` 환경에 설치했습니다.

참고 - cb-network agent의 실행 및 개발환경: `Ubuntu 18.04`, `Rocky Linux 8`(CentOS의 후속으로 보임)

1. Ubuntu(Debian 계열)에 Filebeat를 설치하는 경우:

Filebeat를 대상으로 위 Elasticsearch의 1 ~ 6 과정 수행

참고 - Debian 계열을 위한 Filebeat 8.3.0 설치 파일
```
cd ~ 
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.3.0-amd64.deb
```


2. Rocky Linux(RedHat 계열)에 Filebeat를 설치하는 경우:

Filebeat를 대상으로 위 Elasticsearch 1 ~ 3 과정을 수행하시고,

##### 4. 설치환경에 맞는 링크복사
마우스 우클릭하여 `RPM X86_64`의 링크를 복사함 (RedHat 계열)

##### 5. 대상 노드에 패키지 다운로드
```bash
cd ~
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.3.0-x86_64.rpm
```

##### 6. 패키지 설치
```bash
cd ~
sudo rpm -i filebeat-8.3.0-x86_64.rpm
```


### Elastic Stack configuration

본래는 이 내용을 기록해 놓기 위해 문서 작성을 시작했습니다. ^^;;

보안(SSL) 관련 설정을 모두 Disable 하는 설정을 적용 하였습니다.
cb-network agent는 멀티클라우드에서 동적으로 생성/삭제되는 VM 상에 설치됩니다.
이 경우, 보안 관련 설정 활성화를 위해 각 VM에 PEM 키 배포 방안을 마련해야 합니다.
따라서, 필요한 시점에 PEM 키 배포 방안을 마련 및 적용하고, 보안 관련 설정을 Enable 하려고 합니다.

보안 설정 관련 참고자료 - [Elastic Stack - SSL, TLS, HTTPS 보안 구성하기](https://backtony.github.io/elk/2021-09-11-elk-3/)

#### Elasticsearch configuration

편집기로 Elasticsearch의 설정파일(`elasticsearch.yml`)을 오픈합니다.

```bash
sudo vim /etc/elasticsearch/elasticsearch.yml
```

아래와 관련된 부분을 수정합니다.
```yaml
# Enable security features
xpack.security.enabled: false

xpack.security.enrollment.enabled: false

# Enable encryption for HTTP API client connections, such as Kibana, Logstash, and Agents
xpack.security.http.ssl:
  enabled: false
  keystore.path: certs/http.p12

# Enable encryption and mutual authentication between cluster nodes
xpack.security.transport.ssl:
  enabled: false
  verification_mode: certificate
  keystore.path: certs/transport.p12
  truststore.path: certs/transport.p12
# Create a new cluster with the current node only
# Additional nodes can still join the cluster later
cluster.initial_master_nodes: ["ip-172-31-1-133"]

# Allow HTTP API connections from anywhere
# Connections are encrypted and require user authentication
http.host: 0.0.0.0
```

#### Logstash configuration

Logstash의 설정파일(`logstash.yaml`)은 수정하지 않았습니다. 
필요하시면 아래 경로에서 수정하시기 바랍니다.

```bash
sudo vim /etc/logstash/logstash.yml
```

Beats -> Logstash -> Elasticsearch 파이프라인 생성을 위한 Logstash 설정을 추가합니다.
(새로운 파일 생성됨)

```bash
sudo vim /etc/logstash/conf.d/logstash-filebeat.conf
```

```conf
# Sample Logstash configuration for creating a simple
# Beats -> Logstash -> Elasticsearch pipeline.

input {
  beats {
    port => 5044
    host => "0.0.0.0"
  }
}

output {
  elasticsearch {
    hosts => ["http://localhost:9200"]
    index => "%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}"
    #user => "elastic"
    #password => "changeme"
  }
}
```

#### Kibana configuration

편집기로 Kibana의 설정파일(`kibana.yml`)을 오픈합니다.

```bash
sudo vim /etc/kibana/kibana.yml
```

아래와 관련된 부분을 수정합니다.
1. 외부 접근을 위한 host 정보 변경
2. HTTP 접근
```yaml
# Specifies the address to which the Kibana server will bind. IP addresses and host names are both valid values.
# The default is 'localhost', which usually means remote machines will not be able to connect.
# To allow connections from remote users, set this parameter to a non-loopback address.
#server.host: "localhost"
server.host: "0.0.0.0"


# This section was automatically generated during setup.
elasticsearch.hosts: ['http://192.168.0.12:9200']
elasticsearch.serviceAccountToken: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
elasticsearch.ssl.certificateAuthorities: [/var/lib/kibana/ca_1661150449391.crt]
xpack.fleet.outputs: [{id: fleet-default-output, name: default, is_default: true, is_default_monitoring: true, type: elasticsearch, hosts: ['http://192.168.0.12:9200'], ca_trusted_fingerprint: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}]
```

#### Filebeat configuration

편집기로 Filebeat의 설정파일(`filebeat.yml`)을 오픈합니다.

```bash
sudo vim /etc/filebeat/filebeat.yml
```

아래와 관련된 부분을 수정합니다.
1. 수집할 로그 파일 관련 설정, <ins>**!!!중요!!! 응용의 로그 파일 경로와 일치해야함**</ins>
2. Elastiicseach 주석처리
3. Logstash 관련 설정

```yaml
# Each - is an input. Most options can be set at the input level, so
# you can use different inputs for various configurations.
# Below are the input specific configurations.

# filestream is an input for collecting log messages from files.
- type: log

  # Unique ID among all inputs, an ID is required.
  #id: my-filestream-id

  # Change to true to enable this input configuration.
  enabled: true

  # Paths that should be crawled and fetched. Glob based paths.
  paths:
    - /var/log/cblogs.log
      #- /var/log/*.log
    #- c:\programdata\elasticsearch\logs\*


# ---------------------------- Elasticsearch Output ----------------------------
#output.elasticsearch:
  # Array of hosts to connect to.
  #hosts: ["localhost:9200"] 


# ------------------------------ Logstash Output -------------------------------
output.logstash:
  # The Logstash hosts
  hosts: ["xxx.xxx.xxx.xxx:5044"]
```



### Start Elasticsearch, Logstash, Kibana on the VM
```bash
sudo systemctl daemon-reload
sudo systemctl start elasticsearch.service
sudo systemctl start logstash.service
sudo systemctl start kibana.service
```

(optional) for start on boot
```bash
sudo systemctl enable elasticsearch.service
sudo systemctl enable logstash.service
sudo systemctl enable kibana.service
```

#### Monitor Elasticsearch, Logstash, Kibana status

정상 동작하지 않을 경우 활용하시기 바랍니다 :wink:

Elasticsearch의 상태를 실시간 모니터링 합니다.
```
sudo tail -f /var/log/elasticsearch/elasticsearch.log
```

Logstash의 상태를 실시간 모니터링 합니다.
```
sudo tail -f /var/log/logstash/logstash-plain.log
```

Kibana의 상태를 실시간 모니터링 합니다.
```
sudo tail -f /var/log/kibana/kibana.log
```


### Start Filebeat on the nodes to log

```bash
sudo systemctl daemon-reload
sudo systemctl start filebeat.service
```

(optional) for start on boot
```bash
sudo systemctl enable filebeat.service
```

#### Monitor Filebeat operation status

정상 동작하지 않을 경우 활용하시기 바랍니다 :wink:

로그 파일 목록을 확인합니다. (형식: filebeat-yyyyMMdd.ndjson 또는 filebeat-yyyyMMdd-number.ndjson)
```
sudo ls -al /var/log/filebeat/
```

Filebeat의 상태를 실시간 모니터링 합니다 (가장 최근의 로그파일 활용).
```
sudo sudo tail -f [YOUR_LOG_FILE]
```

### Open Kibana interface

#### 1. Visit Kibana interface

아래와 같은 주소로 Kibana interface에 처음 접속하면 Enrollment token 입력 창이 뜹니다.

```
http://xxx.xxx.xxx.xxx/5601
```

<p align="center">
    <img src="https://user-images.githubusercontent.com/7975459/185854269-cd96ee13-a171-4aaf-87b8-252418ad2739.png" width="40%" height="40%" >
</p>

#### 2. Create and input an enrollment token

아래 명령어로 Kibana 등록 토큰을 생성하여 입력한 후 "Configure Elastic"을 클릭합니다.

```bash
sudo /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana
```

#### 3. Get and input a verification code

이번에는 "Verification code"를 물어 봅니다.

<p align="center">
    <img src="https://user-images.githubusercontent.com/7975459/185855063-d035bbef-3c93-4ea5-b48c-6d244b344030.png" width="40%" height="40%" >
</p>


아래 명령어를 실행하여 얻은 "Verification code"를 입력하고, "Verify"를 클릭합니다.

```bash
sudo /usr/share/kibana/bin/kibana-verification-code
```

#### 4. Input ID and password

마지막으로, Elasticsearch 설치 후 메모해 놓은 ID와 Password를 입력합니다.

<p align="center">
    <img src="https://user-images.githubusercontent.com/7975459/185855654-79898477-42cb-47cb-8a8c-8eb06763e0cc.png" width="40%" height="40%" >
</p>

만약 메모해 놓지 못하셨다면, 아래 명령어로 `reset`후 입력하시면 됩니다 ^^

```bash
sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic
```

#### 5. Explore the Kibana interface
<p align="center">
    <img src="https://user-images.githubusercontent.com/7975459/185856456-8aefaa2f-3a02-471b-abbd-ccc80f6f56c2.png" width="80%" height="80%" >
</p>

이상 적용기를 마칩니다. 필요하신 분들께 조금이나마 도움이 되기를 희망합니다.
