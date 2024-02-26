# A guide to creating and accessing an instance in GCP

### Table of contents

- [1. Overview](#1-overview)

- [2. Create Project](#2-create-project)

- [3. Create VPC](#3-create-vpc)

- [4. Create and Access Virtual Machine](#4-create-and-access-virtual-machine)

- [5. How to use GCP CLI command](#5-how-to-use-gcp-cli-command)

## 1. Overview

#### 각 CSP의 웹 콘솔 또는 포털에서 가상머신(VM, Virtual Machine) 생성 및 접속 연습
- VM 생성 과정 중 VPC, Security Group 등을 생성하시면서 의미를 파악
- [cb-coffeehouse](../README.md) 에서 참고 가능

## 2. Create Project

### 2.1. 상단의 My First Project 를 클릭

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210816092613251.png?raw=true" width="90%" height="90%" >
</p>

### 2.2. 우측 상단의 `새 프로젝트`를 선택

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210816092645594.png?raw=true" width="90%" height="90%" >
</p>

<ins>**주의: 프로젝트 이름은 변경할 수 있지만 프로젝트 ID 는 변경할 수 없습니다.**</ins>
<ins>**gcloud sdk를 활용할 때 식별할 수 있도록 알아보기 쉽고 unique한 값을 입력합니다.**</ins>
- 프로젝트 이름 제약사항 : 이름은 4~30자(영문 기준) 사이
- 입력가능한 특수문자 : 문자, 숫자, 작은따옴표, 하이픈, 공백 또는 느낌표

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210816092707741.png?raw=true" width="90%" height="90%" >
</p>

`만들기` 버튼을 누르면 프로젝트 초기 화면으로 리디렉션 됩니다.

### 2.3. 생성한 프로젝트 확인

생성한 프로젝트에 대한 내용을 확인하고 싶다면 좌측 네비게이션 메뉴에서 IAM - 설정을 클릭합니다.
프로젝트 이름과 프로젝트 ID, 그리고 프로젝트 번호를 확인할 수 있습니다. 

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210816093108328.png?raw=true" width="90%" height="90%" >
</p>

## 3. Create VPC Network

가상 머신을 만들기 위해서는 사전작업이 필요합니다. 바로 네트워크와 방화벽을 구성하는 것입니다.
Cloud VPC를 통해서 가용역영을 분리하고 VPN 토폴로지를 커스텀 설정할 수 있습니다. 
VPC 네트워크를 생성하지 않으면 기본 네트워크로 잡히게 됩니다. 기본 VPN 게이트 웨이에는 인터페이스 한개, 외부 주소 한개가 있으며 동적 또는 정적 라우팅을 사용하는 터널을 지원하게 됩니다. 

### 3.1. VPC Network 생성

VPC 네트워크에서 네트워크 만들기를 설정하고 구분할 수 있는 VPC 네트워크와 서브넷을 생성합니다.
필요한 VPC의 리전과 public subnet을 구성하고, 대역을 지정합니다.

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818204404124.png?raw=true" width="90%" height="90%" >
</p>

### 3.2. VPC와 서브넷이 생성되었음을 확인

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818204546459.png?raw=true" width="90%" height="90%" >
</p>

## 4. Create and Access Virtual Machine

### 4.1. Compute Engine - VM 인스턴스로 이동

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818204713847.png?raw=true" width="90%" height="90%" >
</p>

### 4.2. 상단에 위치한 `인스턴스 만들기` 클릭

인스턴스 생성에는 4개의 옵션:
- 새 VM 인스턴스 : 공개된 OS 이미지 또는 커스텀 이미지에서 VM을 생성합니다.
- 템플릿에서 VM 인스턴스 만들기 : 구글에서 제공하는 
- 머신 이미지의 새 VM 인스턴스
- Market Place

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818204837145.png?raw=true" width="90%" height="90%" >
</p>

<ins>**주의: 인스턴스의 이름, 리전 그리고 영역은 변경할 수 없으므로 신중하게 결정해야합니다.**</ins>

머신 구성은 일반용도로 설정하고, vCPU와 메모리를 선택합니다. 물론 상황에 맞게 커스텀 머신을 설정할 수도 있습니다. 

머신의 시리즈:
- 일반용도 : 일반적인 작업 부하에 적합한 머신 유형이며 가격 및 유연성을 위해 최적화
  - E2 : 가용성 기반 CPU 플랫폼
  - N2 : Cascade LAke CPU 플랫폼
  - N1 : Intel Skylake 플랫폼 또는 이전 버전
- 컴퓨팅 최적화 : 컴퓨팅 집약적인 작업 부하에 맞는 고성능 머신 
  - C1 : Intel Cascade Lake CPU 플랫폼에서 제공

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818205637876.png?raw=true" width="90%" height="90%" >
</p>

### 4.3. 부팅디스크를 설정

공개된 이미지를 선택할 수도 있으며, 맞춤이미지를 활용할 수 있습니다. 기존에 운영하던 머신이 있다면 스냅샷을 이용하거나 기존 디스크를 선택할 수 있습니다. 저는 여기서 Ubuntu 21.04 이미지를 선택해보겠습니다. 

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818205807045.png?raw=true" width="90%" height="90%" >
</p>

### 4.4 생성한 VPC Network 할당

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818210121433.png?raw=true" width="90%" height="90%" >
</p>

물론 이 작업을 하지 않아도 머신을 생성하는데에는 문제가 없습니다. 다만 실제 서비스를 운영한다면 VPC 와 서브넷을 분리하여 운영하고, 각각의 서브넷에 정책을 적용하여 보안을 강화하는 것이 좋습니다.


<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818210244232.png?raw=true" width="90%" height="90%" >
</p>

#### 생성된 머신을 확인합니다. 상태 란의 초록색 체크 표시가 보이면 머신이 정상적으로 작동하고 있다는 것을 의미합니다.

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818210428816.png?raw=true" width="90%" height="90%" >
</p>

머신에 접속하는 방법은 여러가지가 있습니다. `PuTTY` 등의 클라이언트를 사용할 수도 있고, shell로 접근할 수도 있습니다. 

여기에서는 GCP에서 제공하는 연결 방법과 터미널 접속을 이용해보겠습니다. 

#### 4.4.1 GCP에서 제공하는 연결 방법

`연결 - SSH`  좌측의 화살표를 클릭하여 `브라우저 창에서 열기`를 선택합니다.

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818211854844-16292891353561.png?raw=true" width="90%" height="90%" >
</p>


#### 4.4.2 SSH 키 생성 후 Terminal을 통해 접속하는 방법 [Mac OS 환경]

아래 명령어를 통해 로컬에서 ssh 키를 만든다.

 ```ssh-keygen -t rsa -f ~/.ssh/[키 파일 이름] -C [UserName]```

GCP 콘솔의 Compute Engine > 메타데이터 > SSH 키 에서 생성한 SSH 키를 추가한다. 

![](https://images.velog.io/images/kyungkoh/post/88ec52ea-14e0-4127-b1e2-e89bba054ecd/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202021-08-24%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%204.59.10.png)

아래 명령어를 통해 터미널에서 VM에 접속한다 
```ssh -i ~/.ssh/[ssh key fileName] [UserName@IP주소]```

정상적으로 접속 된 모습을 아래와 같이 확인 할 수 있습니다. 

![](https://images.velog.io/images/kyungkoh/post/3028cf6b-39c3-46ef-b583-4fe0407db9aa/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202021-08-17%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%2010.57.28.png)


## 5. How to use GCP CLI command

### 5.1. Install GCP CLI
Please, refer to [Install GCP CLI](https://cloud.google.com/sdk/docs/quickstart?hl=ko#windows)

### 5.2. Step to create a virtual machine

NOTE - Please, refer to 2.2.8. Parameter Description. (It will be helpful for you in following some steps.)

#### 5.2.1. Setting GCP Cloud
```
gcloud init
```
Google 사용자 계정을 사용하여 로그인하는 옵션을 수락합니다.
```
To continue, you must log in. Would you like to log in (Y/n)? Y
```
브라우저에서 메시지가 표시되면 Google 사용자 계정에 로그인하고 허용을 클릭하여 Google Cloud 리소스에 액세스할 수 있는 권한을 부여합니다.

명령 프롬프트에서 소유자, 편집자 또는 뷰어 권한이 있는 프로젝트 목록의 Google Cloud 프로젝트를 선택합니다.
```
Pick cloud project to use:
[1] [my-project-1]
[2] [my-project-2]
...
Please enter your numeric choice:
```
- 참고: 
  - 프로젝트가 하나만 있는 경우 gcloud init가 프로젝트를 선택합니다.
  - 200개가 넘는 프로젝트에 액세스할 수 있는 경우 프로젝트 ID를 입력하거나 새 프로젝트를 만들거나 프로젝트를 나열하라는 메시지가 표시됩니다.

Google Compute Engine API를 사용 설정한 경우 gcloud init을 사용하여 기본 Compute Engine 영역을 선택할 수 있습니다.
```
Which compute zone would you like to use as project default?
 [1] [asia-east1-a]
 [2] [asia-east1-b]
 ...
 [14] Do not use default zone
 Please enter your numeric choice:
```

#### 5.2.2. Login
```
gcloud auth login
```

#### 5.2.3. Get available VM list
gcloud compute images list 프로젝트의 모든 Google Compute Engine 이미지를 표시합니다.
```
gcloud compute images list
```

<p align="center">
<img src="https://user-images.githubusercontent.com/33706689/130573413-7d6aa5ba-bd93-4592-81c1-cc589f428ade.png" width="90%" height="90%">
</p>

#### 5.2.4. Create a virtual machine
```
gcloud compute instances create %VM_NAME% --image-family=%VM_FAMILY% --image-project=%VM_PROJECT% --zone=%VM_LOCATION%
```

#### 5.2.5. Attach disk
```
//가상 머신에 붙일 디스크 생성
gcloud compute disks create %VM_DISK_NAME% --zone=%ZONE% --size=%VM_DISK_SIZE%

//가상 머신에 디스크를 붙임
gcloud compute instances attach-disk %VM_NAME% --disk %VM_DISK_NAME%
```

#### 5.2.8. Parameter Description
// Resource_Group을 새로 생성
- VM_NAME : 사용할 VM 이름
- VM_FAMILY : 부팅 디스크를 초기화할 운영 체제의 이미지 계열
- VM_PROJECT : 모든 이미지 및 이미지 계열 참조가 확인되는 GCP 프로젝트
- VM_LOCATION : VM을 생성할 지역
- ZONE : 생성할 영역
```
//영역 목록을 가져옴
gcloud compute zones list
```

## 주의할 점

<ins>**[Naver Whale](https://user-images.githubusercontent.com/47745785/130347062-f053037b-7090-4f0f-a102-cede2c85564c.png) 사용시에 GCP VM 인스턴스 웹 콘솔로 접근이 안되는 현상 발생. 구글 크롬 브라우저를 사용하는 것이 좋음.**</ins>


## Reference

1. [GCP Compute Engine 문서](https://cloud.google.com/compute/docs?hl=ko) 
2. [Virtual Private Cloud(VPC) 문서](https://cloud.google.com/vpc?hl=ko)

