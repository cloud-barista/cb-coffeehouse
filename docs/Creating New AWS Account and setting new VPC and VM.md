# A guide to creating and accessing an instance in AWS

### Table of contents

- [1. Create AWS account](#1-create-aws-account)

- [2. Create a Virtual Machine Using AWS - Linux](#2-create-a-virtual-machine-using-aws---linux)

- [3. Access Virtual Machine](#3-access-virtual-machine)

- [4. Create VPC and Security Groups](#4-create-vpc-and-security-groups)

## 1. Create AWS account

### 1.1. [https://aws.amazon.com/ko/]에 접속

### 1.2. **콘솔에 로그인** 버튼을 클릭

<p align="center">
  <img src="https://i.imgur.com/0TrIFt7.jpg" width="90%" height="90%" >
</p>

### 1.3. **AWS 계정 새로 만들기** 버튼을 클릭

<p align="center">
  <img src="https://i.imgur.com/QeLs9fo.jpg" width="90%" height="90%" >
</p>

### 1.4. 아이디, 비밀번호, 계정 이름 입력

<ins>**주의: 계정 이름은 영문으로 입력해야 합니다. (본인의 영어 닉네임을 적는 것을 추천!)**</ins>

<p align="center">
  <img src="https://i.imgur.com/Na8IX5h.jpg" width="90%" height="90%" >
</p>

### 1.5. 부가적인 정보 입력

**AWS를 어떻게 사용할 계획인가요?** 항목에는 **개인-자체 프로젝트의 경우**에 체크 후, 상세 정보를 전부 입력

<p align="center">
  <img src="https://i.imgur.com/ey4jYVq.jpg" width="90%" height="90%" >
</p>

### 1.6. 카드 결제 정보를 입력

결제하고자 하는 카드는 Visa, Master, UnionPay 등 해외 결제가 가능한 계좌여야 합니다.
연동된 카드에는 1달러(1100원) 이상 잔액이 기본적으로 있어야 합니다.
  - 프리티어라고 해도 최초로 한번의 결제 과정이 필요합니다.

<p align="center">
  <img src="https://i.imgur.com/0PuzIWD.jpg" width="90%" height="90%" >
</p>

카드 번호, 카드 비밀번호 및 생년월일, 동의 절차를 추가적으로 진행

<p align="center">
  <img src="https://i.imgur.com/hqHcchU.jpg" width="90%" height="90%" >
</p>

### 1.7. AWS 가입 자격 증명 확인

<ins>**주의: 핸드폰 번호는 5번 항목에 입력한 번호와 동일한 번호를 입력해야 합니다.**</ins>

<p align="center">
  <img src="https://i.imgur.com/gB0T2qD.jpg" width="90%" height="90%" >
</p>

### 1.8. 카드 지불 정보에 오류가 있을 경우

<ins>**이 오류가 나지 않을 경우 1.10.과정 진행함**</ins>

지불 정보에 문제가 있다고 오류가 뜰 경우, 표시 된 부분에 있는 **계정에 로그인** 버튼을 클릭하여 우선적으로 로그인 과정을 진행

<p align="center">
  <img src="https://i.imgur.com/5EhEQbX.jpg" width="90%" height="90%" >
</p>

#### 1.9.1 AWS 지불 카드 등록 오류

**루트 사용자**를 체크 후, 로그인 진행

<p align="center">
  <img src="https://i.imgur.com/f7LHYIe.jpg" width="90%" height="90%" >
</p>

카드 등록이 정상적으로 완료 확인 후, 메인화면으로 이동

<p align="center">
  <img src="https://i.imgur.com/j9FFhEg.jpg" width="90%" height="90%" >
</p>

**가상 머신 시작** 버튼을 클릭, 현재 계정 상태를 다시 확인

<p align="center">
  <img src="https://i.imgur.com/sIkBvRs.jpg" width="90%" height="90%" >
</p>

<ins>**아래와 같은 화면이 나오면 1~2시간 정도 대기 후 표시된 부분에 있는 (AWS 등록을 완료하십시오) 버튼을 클릭합니다. 1~2시간이 지나고 안될 경우, 익일에 다시 재시도**</ins>

<p align="center">
  <img src="https://i.imgur.com/yVolCGP.jpg" width="90%" height="90%" >
</p>

#### 1.9.2. 1.9.과정을 다시 재시도

<p align="center">
  <img src="https://i.imgur.com/5EhEQbX.jpg" width="90%" height="90%" >
</p>

### 1.9. AWS 가입 자격 증명 확인

인증 코드를 입력 후, **계속** 버튼을 클릭

<p align="center">
  <img src="https://i.imgur.com/EeLEMtQ.jpg" width="90%" height="90%" >
</p>

### 1.10. **기본 지원 - 무료** 플랜을 선택 후, **가입 완료** 버튼을 클릭

<p align="center">
  <img src="https://i.imgur.com/ZymsP6t.jpg" width="90%" height="90%" >
</p>

### 1.11. 계정 생성 완료

<p align="center">
  <img src="https://i.imgur.com/bfqJMnx.jpg" width="90%" height="90%" >
</p>

## 2. Create a Virtual Machine Using AWS - Linux

### 2.1. Create Virtual Machine

**솔루션 구축** 탭에서 **가상 머신 시작** 버튼을 클릭합니다.

<p align="center">
  <img src="https://i.imgur.com/WV5sDWv.jpg" width="90%" height="90%" >
</p>

### 2.2. Select OS image

AMI를 선택하는 단계에서 **Red Hat Enterprise Linux 8** 항목 오른쪽에서 **64비트(x86)** 을 체크한 후 **선택** 버튼을 클릭합니다.

<p align="center">
  <img src="https://i.imgur.com/ikqha9F.jpg" width="90%" height="90%" >
</p>

### 2.3. Select VM Size

기본 선택 옵션을 그대로 두고, **검토 및 시작** 버튼을 클릭합니다.
- 프리티어의 경우 **[t2.micro]** 옵션만 사용이 가능합니다.

<p align="center">
  <img src="https://i.imgur.com/ikqha9F.jpg" width="90%" height="90%" >
</p>

### 2.4. Check Virtual Machine information

기본 선택 옵션을 그대로 두고, 화면 우측 하단 **[시작하기]** 버튼을 클릭합니다.

<p align="center">
  <img src="https://i.imgur.com/H9bjXq2.jpg" width="90%" height="90%" >
</p>

### 2.5. Select Key Pair

**기존 키 페어 선택** 항목을 클릭합니다. (있다면 2.6단계로, 없다면 생성 2.5.1단계로)

키 페어: SSH를 통한 서버 접속 시 필요한 인증 수단으로 키 페어 파일은 별도로 백업하여 보관해야 됩니다.

<p align="center">
  <img src="https://i.imgur.com/zOxSWZp.jpg" width="90%" height="90%" >
</p>

#### 2.5.1. Create a new Key pair

**새 키 페어 생성** 항목을 선택합니다.

<p align="center">
  <img src="https://i.imgur.com/PX1Opyu.jpg" width="90%" height="90%" >
</p>

#### 2.5.2. Enter a new Key pair name

**키 페어 이름**을 입력한 후, **키 페어 다운로드** 버튼을 클릭합니다.

<ins>**주의: Key pair type은 RSA 항목 그대로 둡니다.**</ins>

<p align="center">
  <img src="https://i.imgur.com/GYxtR9O.jpg" width="90%" height="90%" >
</p>

### 2.6. Start Virtual Machine

**인스턴스 시작** 버튼을 클릭합니다.

<p align="center">
  <img src="https://i.imgur.com/Sh8kXka.jpg" width="90%" height="90%" >
</p>

### 2.7. View Virtual Machine

인스턴스 시작 중이라는 화면이 확인 되면 화면 우측 하단 **인스턴스 보기** 버튼을 클릭합니다.

<p align="center">
  <img src="https://i.imgur.com/UWMO447.jpg" width="90%" height="90%" >
</p>

대시보드를 통해 생성한 인스턴스를 확인할 수 있음

<p align="center">
  <img src="https://i.imgur.com/36eUkIx.jpg" width="90%" height="90%" >
</p>

## 3. Access Virtual Machine

### 3.1. DownLoad putty

인스턴스 접속을 위해 putty를 다운로드 하여 실행합니다.

<ins>**다운로드 링크 : https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html**</ins>
<ins>자신의 OS 환경에 맞게 msi 파일을 다운로드 받습니다.**</ins>

<p align="center">
  <img src="https://i.imgur.com/RMn1MaK.jpg" width="90%" height="90%" >
</p>

### 3.2. Putty Key Generator를 실행

PuTTYgen이라는 파일명으로 되어 있습니다.
생성한 키 페어 파일을 putty에서 사용할 ppk로 변환 과정을 거치기 위함입니다.

<p align="center">
  <img src="https://i.imgur.com/Uuv5sgH.jpg" width="90%" height="90%" >
</p>

### 3.3. Change pem to ppk

하단 **Type of key to generate** 항목에서 **RSA**를 선택하고, 화면 우측 하단 **Load** 버튼을 클릭합니다.

<p align="center">
  <img src="https://i.imgur.com/j0BJem2.jpg" width="90%" height="90%" >
</p>

우측 하단에 파일 확장자를 **All Files**로 바꿔주고, VM을 만들 때 생성한 키 페어 파일을 불러옵니다.

<p align="center">
  <img src="https://i.imgur.com/41c0iXs.jpg" width="90%" height="90%" >
</p>

화면 우측 하단 **Save private Key** 버튼을 클릭하여 변환된 ppk 파일을 저장합니다.

**[Successfully imported foreign key~]** 메시지가 뜨면 **[확인]** 버튼을 클릭하면 됩니다.
**[Are you sure you want to~]** 메시지가 뜨면 **[예]** 버튼을 클릭하면 됩니다.

<p align="center">
  <img src="https://i.imgur.com/DUc0Qch.jpg" width="90%" height="90%" >
</p>

### 3.4. Access Virtual Machine

putty를 실행시킨 후 **Host Name** 부분에 대시보드에 적혀있는 **퍼블릭 IPv4** 항목에 나온 IP 주소를 입력합니다.

<ins>**주의: 포트는 22번으로 그대로 둘 것**</ins>

<p align="center">
  <img src="https://i.imgur.com/fJWAplf.jpg" width="90%" height="90%" >
</p>

왼쪽 **category** 부분에서 **Connection - SSH - Auth** 항목을 차례대로 선택하여 **Browse** 버튼을 클릭한 후 16번 과정에서 변환한 ppk 파일을 불러온 후 **Open** 버튼을 클릭합니다.

<p align="center">
  <img src="https://i.imgur.com/kj6X7Jm.jpg" width="90%" height="90%" >
</p>

### 3.5 Login Virtual Machine

**login as** 부분에 **ec2-user**라고 입력하면 접속까지 최종 완료됩니다.

ppk 파일이 비밀번호 역할을 해주기 때문에 별도의 비밀번호 입력 없이 접속이 가능함

<p align="center">
  <img src="https://i.imgur.com/WDjPIzY.jpg" width="90%" height="90%" >
</p>

### 3.6 Remove Virtual Machine

만약, 인스턴스를 사용하지 않을 경우 대시보드 우측 상단 **인스턴스 상태** 버튼을 클릭한 후, **인스턴스 중지** 버튼을 차례로 클릭하여 중지시켜놔야 추가 과금이 일어나지 않음

<p align="center">
  <img src="https://i.imgur.com/ofyMKCO.jpg" width="90%" height="90%" >
</p>

## 4. Create VPC and Security Groups

**VPC(Virtual Private Cloud):** 사용자의 AWS 계정 전용 가상 네트워크

### 4.1 Access AWS VPC

[https://console.aws.amazon.com/vpc/]로 들어가 Amazon VPC 콘솔로 접속합니다.

<p align="center">
  <img src="https://i.imgur.com/1SustsL.jpg" width="90%" height="90%" >
</p>

### 4.2. Select Option

왼쪽 4가지 옵션에서 자신에게 맞는 옵션을 선택한 후 **선택** 버튼을 클릭합니다.

<ins>**주의: 프리티어에서는 **단일 퍼블릭 서브넷이 있는 VPC**를 사용하고 **선택** 버튼을 클릭합니다.**</ins>

<p align="center">
  <img src="https://i.imgur.com/3NJseF5.jpg" width="90%" height="90%" >
</p>

### 4.3. Create VPC
 
VPC 이름과 기타 옵션을 설정한 후 우측 하단에 **VPC 생성** 버튼을 클릭합니다.

<p align="center">
  <img src="https://i.imgur.com/acFYMNb.jpg" width="90%" height="90%" >
</p>

### 4.4. VPC 생성 완료

<p align="center">
  <img src="https://i.imgur.com/wL6a5j6.jpg" width="90%" height="90%" >
</p>

### 4.5. Create Security Group

보안 그룹을 생성하기 위해 대시보드 왼쪽 하단 **네트워크 보안** 메뉴에 있는 **보안 그룹** 메뉴를 선택한 후 새로운 보안 그룹을 생성하기 위해 우측 상단에 있는 **보안 그룹 생성** 버튼을 클릭합니다.

<p align="center">
  <img src="https://i.imgur.com/mnfax9c.jpg" width="90%" height="90%" >
</p>

### 4.6. Enter Inbound, Outbound rule

보안 그룹 정보 및 인바운드, 아웃바운드 규칙을 입력한 후 우측 하단에 **보안 그룹 생성** 버튼을 클릭합니다.

<p align="center">
  <img src="https://i.imgur.com/KSKfDUl.jpg" width="90%" height="90%" >
</p>

### 4.7. Security Group 생성 완료

기본 보안 그룹은 생성되어 있으니 추가적인 보안 그룹 설정이 필요할 경우에만 만들면 됩니다.

<p align="center">
  <img src="https://i.imgur.com/r5SFWJO.jpg" width="90%" height="90%" >
</p>