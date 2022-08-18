# Distributed logging by ELK Stack
NOTE - ELK: Elasticsearch, Logstash and Kibana (see [ELK Stack](https://www.elastic.co/kr/what-is/elk-stack))

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


### Introduction to ELK Stack

분산 로깅 시스템으로 오픈소스인 ELK Stack을 선택 및 적용했습니다(CB-Larva는 비 상용). 

아래 그림과 같은 순서로 ELK Stack은 로그를 수집합니다. 간략히는, Beats(i.e., Filebeat)가 파일에 저장된 로그를 수집하여 Logstash로 전송합니다. 
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

ELK Stack 관련 문서는 아래 공식 홈페이지를 참고하시기 바랍니다.
참고: [ELK Stack](https://www.elastic.co/kr/what-is/elk-stack)


## Multi-cloud network system with distributed logging

아래 그림은 분산 로깅을 위해 ELK Stack을 멀티클라우드 네트워크 시스템(cb-network system)에 적용했을때의 구조와 흐름을 나타냅니다. 
멀티클라우드 네트워크 시스템은 다음과 같은 독립적인 컴포넌트(cb-network controller, cb-network service, cb-network admin-web, cb-network agent)로 구성되어 있습니다. 
각 컴포넌트는 cb-log라는 Cloud-Barista community에서 개발한 Go 패키지를 사용하여 로깅을 수행하고, 로그 정보는 파일에 기록합니다. 
Filebeat가 로그 파일을 읽어 추가/변경된 부분만 Logstash로 전송합니다. 
이로서 멀티클라우드 네트워크 시스템과 ELK Stack을 통합하여 분산 로깅을 할 수 있게 되었습니다.

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/185298611-44f1226d-9929-4bcc-933c-740e907c4091.png" width="80%" height="80%" >
</p>

### Logs collected from distributed nodes

Kibana를 통해 분산된 노드에서 수집한 로그를 확인해 보겠습니다. 최근 24시간 이내에 수집되었던 로그 정보를 표시하도록 하였습니다.

아래 그림에서 ELK Stack의 로그 수집 과정을 거치면서 포함된 부가 정보들을 확인 할 수 있습니다.
<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/185302612-deeb6abc-e9c1-453e-9fab-e19e51371a51.png" width="80%" height="80%" >
</p>

여기서는 멀티클라우드 네트워크 시스템의 각 컴포넌트의 로그만 확인하면 되는 상황이라, 다른 로그는 보이지 않도록 `message`를 필터로 추가하였습니다. 다음 그림은 그 결과를 나타냅니다.
<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/185302660-6e8340ad-2fb1-403f-acb1-5735b0229bc8.png" width="80%" height="80%" >
</p>


현재, 분산된 컴포넌트의 로그 수집에는 문제가 없으나 Logger Name이 동일하여 구분이 어려운 상태네요 ^^;; 개선해야겠습니다!


## A guide to download and deploy ELK Stack

ELK Stack 설치, 구동, 연동 등을 위해 참고할 수 있는 좋은 글이 많이 있습니다. 
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
```
sudo apt update
sudo apt install openjdk-11-jdk
```

On Rocky Linux
```
sudo yum update
sudo yum install java-11-openjdk
```

### ELK server setup
#### 1. Create a VM for ELK

AWS의 VM에서 Elasticsearch, Logstash, Kibana를 설치 및 배치했습니다. 

VM 스펙:
- OS: Ubuntu18.04
- vCPU: 2
- RAM: 4GB
- Storage: 100GB

참고 - 위 스펙에서 ELK를 모두 돌리면 종종 버거워 하네요 ... ㅠㅠ

VM 생성 및 접속 관련해서는 아래 글을 참고하시기 바랍니다(Cloud-Barista 커뮤니티 기여자께서 작성해주셨습니다).

참고: [A guide to creating and accessing an instance in AWS](https://github.com/cloud-barista/cb-coffeehouse/blob/main/docs/Public-Cloud/Creating%20New%20AWS%20Account%20and%20setting%20new%20VPC%20and%20VM.md)

#### 2. Download and install Elasticsearch
##### 2.1. Elasticsearch 다운로드 페이지 접속

<p align="center">
    <img src="https://user-images.githubusercontent.com/7975459/185281689-b4ff365e-d74f-4275-b622-46f574d32d65.png" width="80%" height="80%" >
</p>

##### 2.2. View past releases 이동
<p align="center">
    <img src="https://user-images.githubusercontent.com/7975459/185281939-4ad5dbab-6d02-4498-b023-91210cc97991.png" width="80%" height="80%" >
</p>

##### 2.3. Elasticsearch 8.3.0 Download 클릭
<p align="center">
    <img src="https://user-images.githubusercontent.com/7975459/185282148-618726c0-cf9d-490a-a97d-ffdd02df56a6.png" width="80%" height="80%" >
</p>

##### 2.4. 설치환경에 맞는 링크복사
마우스 우클릭하여 `DEB X86_64`의 링크를 복사함 (Debian 계열)

##### 2.5. VM에 패키지 다운로드
```
cd ~
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.3.0-amd64.deb
```

##### 2.6. 패키지 설치
```
cd ~
dpkg -i elasticsearch-8.3.0-amd64.deb
```

(중요) 메모해둘 것: ID, Password 및 가이드 등


#### 3. Download and install Logstash

Logstash를 대상으로 위 2.1 ~ 2.6 과정 수행


#### 4. Download and install Kibana

Kibana를 대상으로 위 2.1 ~ 2.6 과정 수행

#### 5. Download and install Filebeat

Filebeat는 `Ubuntu 18.04`와 `Rocky Linux 8` 환경에 설치했습니다.
참고 - cb-network agent의 실행 및 개발환경: `Ubuntu 18.04`, `Rocky Linux 8`(CentOS의 후속으로 보임)


1. Ubuntu에 Filebeat를 설치하는 경우:

Filebeat를 대상으로 위 2.1 ~ 2.6 과정 수행


2. Rocky Linux에 Filebeat를 설치하는 경우:

Filebeat를 대상으로 위 2.1 ~ 2.3 과정을 수행하고,

##### 5.4. 설치환경에 맞는 링크복사
마우스 우클릭하여 `RPM X86_64`의 링크를 복사함 (RedHat 계열)

##### 5.5. 대상 노드에 패키지 다운로드
```
cd ~
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.3.0-x86_64.rpm
```

##### 5.6. 패키지 설치
```
cd ~
rpm -i filebeat-8.3.0-x86_64.rpm
```

[TBD]
그 밖에 설정 정보들 (본래는 이 내용을 기록하기 위해 문서 작성을 시작함 ^^;; )

(보안(SSL) 관련 설정 파일 및 설정 방법 추가)

외부 접근을 위해
/etc/kibana/kibana.yml 에서
server.host: "0.0.0.0" 입력

### ELK stack configuration

#### Elasticsearch configuration

#### Logstash configuration

#### Kibana configuration

#### Filebeat configuration



### Start Elasticsearch, Logstash, Kibana on the VM
```
sudo systemctl daemon-reload
sudo systemctl start elasticsearch.service
sudo systemctl start logstash.service
sudo systemctl start kibana.service
```

### Open Kibana interface

1. 가이드를 따라 Kibana enrollment token 생성
2. Kibana 홈페이지 접속: https://xxx.xxx.xxx.xxx/5601
3. 토큰 입력
4. Verification code 확인 by /usr/share/kibana/bin/kibana-verification-code
5. Verification code 입력

끝.

