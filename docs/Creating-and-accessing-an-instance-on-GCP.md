# A guide to creating and accessing an instance in GCP

### Table of contents

- [1. Overview](#1-overview)

- [2. Create Project](#2-create-project)

- [3. Create VPC](#3-create-vpc)

- [4. Create and Access Virtual Machine](#4-create-and-access-virtual-machine)

## 1. Overview

#### 각 CSP의 웹 콘솔 또는 포털에서 가상머신(VM, Virtual Machine) 생성 및 접속 연습
- VM 생성 과정 중 VPC, Security Group 등을 생성하시면서 의미를 파악
- [cb-coffeehouse](https://github.com/cloud-barista/cb-coffeehouse/wiki) 에서 참고 가능

## 2. Create Project

#### 상단의 My First Project 를 클릭합니다

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210816092613251.png?raw=true" width="90%" height="90%" >
</p>

#### 우측 상단의 `새 프로젝트`를 선택합니다.

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210816092645594.png?raw=true" width="90%" height="90%" >
</p>

#### 주의: 프로젝트 이름은 변경할 수 있지만 프로젝트 ID 는 변경할 수 없습니다.

#### gcloud sdk를 활용할 때 식별할 수 있도록 알아보기 쉽고 unique한 값을 입력합니다.
- 프로젝트 이름 제약사항 : 이름은 4~30자(영문 기준) 사이
- 입력가능한 특수문자 : 문자, 숫자, 작은따옴표, 하이픈, 공백 또는 느낌표

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210816092707741.png?raw=true" width="90%" height="90%" >
</p>

#### `만들기` 버튼을 누르면 프로젝트 초기 화면으로 리디렉션 됩니다.

#### 생성한 프로젝트에 대한 내용을 확인하고 싶다면 좌측 네비게이션 메뉴에서 IAM - 설정을 클릭합니다.

#### 프로젝트 이름과 프로젝트 ID, 그리고 프로젝트 번호를 확인할 수 있습니다. 

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210816093108328.png?raw=true" width="90%" height="90%" >
</p>

## 3. Create VPC

#### 가상 머신을 만들기 위해서는 사전작업이 필요합니다. 바로 네트워크와 방화벽을 구성하는 것입니다.

#### Cloud VPC를 통해서 가용역영을 분리하고 VPN 토폴로지를 커스텀 설정할 수 있습니다. 

#### VPC 네트워크를 생성하지 않으면 기본 네트워크로 잡히게 됩니다. 기본 VPN 게이트 웨이에는 인터페이스 한개, 외부 주소 한개가 있으며 동적 또는 정적 라우팅을 사용하는 터널을 지원하게 됩니다. 

#### VPC 네트워크에서 네트워크 만들기를 설정하고 구분할 수 있는 VPC 네트워크와 서브넷을 생성합니다.

#### 필요한 VPC의 리전과 public subnet을 구성하고, 대역을 지정합니다.

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818204404124.png?raw=true" width="90%" height="90%" >
</p>

### VPC와 서브넷이 생성되었음을 확인할 수 있습니다.

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818204546459.png?raw=true" width="90%" height="90%" >
</p>

## 4. Create and Access Virtual Machine

#### Compute Engine - VM 인스턴스로 이동합니다.

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818204713847.png?raw=true" width="90%" height="90%" >
</p>

#### 상단에 위치한 `인스턴스 만들기` 를 클릭합니다.

#### 인스턴스 생성에는 4개의 옵션이 제공됩니다.
- 새 VM 인스턴스 : 공개된 OS 이미지 또는 커스텀 이미지에서 VM을 생성합니다.
- 템플릿에서 VM 인스턴스 만들기 : 구글에서 제공하는 
- 머신 이미지의 새 VM 인스턴스
- Market Place

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818204837145.png?raw=true" width="90%" height="90%" >
</p>

#### 주의: 인스턴스의 이름, 리전 그리고 영역은 변경할 수 없으므로 신중하게 결정해야합니다.

#### 머신 구성은 일반용도로 설정하고, vCPU와 메모리를 선택합니다. 물론 상황에 맞게 커스텀 머신을 설정할 수도 있습니다. 

#### 머신의 시리즈는 다음과 같습니다.
- 일반용도 : 일반적인 작업 부하에 적합한 머신 유형이며 가격 및 유연성을 위해 최적화
  - E2 : 가용성 기반 CPU 플랫폼
  - N2 : Cascade LAke CPU 플랫폼
  - N1 : Intel Skylake 플랫폼 또는 이전 버전
- 컴퓨팅 최적화 : 컴퓨팅 집약적인 작업 부하에 맞는 고성능 머신 
  - C1 : Intel Cascade Lake CPU 플랫폼에서 제공

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818205637876.png?raw=true" width="90%" height="90%" >
</p>

#### 다음으로는 부팅디스크를 설정합니다. 공개된 이미지를 선택할 수도 있으며, 맞춤이미지를 활용할 수 있습니다. 기존에 운영하던 머신이 있다면 스냅샷을 이용하거나 기존 디스크를 선택할 수 있습니다. 저는 여기서 Ubuntu 21.04 이미지를 선택해보겠습니다. 

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818205807045.png?raw=true" width="90%" height="90%" >
</p>

#### 이제 추가적인 설정들이 남았습니다. 위에서 생성한 VPC를 활용하여 네트워크 인터페이스를 붙여줄 예정입니다.

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818210121433.png?raw=true" width="90%" height="90%" >
</p>

#### 물론 이 작업을 하지 않아도 머신을 생성하는데에는 문제가 없습니다. 다만 실제 서비스를 운영한다면 VPC 와 서브넷을 분리하여 운영하고, 각각의 서브넷에 정책을 적용하여 보안을 강화하는 것이 좋습니다.


<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818210244232.png?raw=true" width="90%" height="90%" >
</p>

#### 생성된 머신을 확인합니다. 상태 란의 초록색 체크 표시가 보이면 머신이 정상적으로 작동하고 있다는 것을 의미합니다.

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818210428816.png?raw=true" width="90%" height="90%" >
</p>

#### 머신에 접속하는 방법은 여러가지가 있습니다. `PuTTY` 등의 클라이언트를 사용할 수도 있고, shell로 접근할 수도 있습니다. 여기에서는 GCP에서 제공하는 연결 방법을 이용해보겠습니다. 


#### `연결 - SSH`  좌측의 화살표를 클릭하여 `브라우저 창에서 열기`를 선택합니다.

<p align="center">
  <img src="https://github.com/eeeclipse/2021CA/blob/main/figure/image-20210818211854844-16292891353561.png?raw=true" width="90%" height="90%" >
</p>

## 주의할 점

#### [Naver Whale](https://user-images.githubusercontent.com/47745785/130347062-f053037b-7090-4f0f-a102-cede2c85564c.png) 사용시에 GCP VM 인스턴스 웹 콘솔로 접근이 안되는 현상 발생. 구글 크롬 브라우저를 사용하는 것이 좋음. 


## Reference

1. [GCP Compute Engine 문서](https://cloud.google.com/compute/docs?hl=ko) 
2. [Virtual Private Cloud(VPC) 문서](https://cloud.google.com/vpc?hl=ko)

