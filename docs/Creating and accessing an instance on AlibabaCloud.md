# A guide to creating and accessing an instance in Alibaba Cloud

## Contents

1. 알리바바 클라우드 계정 생성
- [1. 알리바바 클라우드 계정 생성](## 1. 알리바바 클라우드 계정 생성)

2. VPC 생성
3. ECS(Elastic Compute Service, VM) 생성
4. SSH Key Pairs 발급
5. ECS 접속


## 1. 알리바바 클라우드 계정 생성

- URL : [www.alibabacloud.com](http://www.alibabacloud.com)

1)  무료 계정 버튼 클릭

<p align="center">
  <img src="https://user-images.githubusercontent.com/72970232/129754492-d661b683-30ca-4fa1-8bc8-2c5f844945ee.png" width="90%" height="90%" >
</p>

2) 국가 / 이메일 / 암호 입력 후 확인 버튼 클릭

<p align="center">
  <img src="https://user-images.githubusercontent.com/72970232/129754513-e0820c23-2ac6-4bc6-871e-2937fb08fc7c.png" width="90%" height="90%" >
</p>

3) 이메일 / 전화 인증 실시

<p align="center">
  <img src="https://user-images.githubusercontent.com/72970232/129754567-b0631e1e-e374-4d49-a7f2-c212f3ac26ee.png" width="90%" height="90%" >
</p>

4) 기본정보 입력

<p align="center">
  <img src="https://user-images.githubusercontent.com/72970232/129754569-826d5f50-786d-4371-ac67-29d6c7df19b0.png" width="90%" height="90%" >
</p>

5) 결제정보 작성
<p align="center">
  <img src="https://user-images.githubusercontent.com/72970232/129754570-99fe8199-a610-4e9a-87a5-658ffa8df272.png" width="90%" height="90%" >
</p>

## 2. VPC 생성

- Network & Security 섹션에서 Virtual Private Cloud를 누르면 VPC 생성이 가능합니다.
- [Create VPC] 버튼을 클릭합니다.

<p align="center">
  <img src="https://user-images.githubusercontent.com/72970232/129754573-387af87a-4949-4c25-93f4-e3123bb0a5dd
.png" width="90%" height="90%" >
</p>

- VPC 이름과 IPv4 CIDR Block 및 vSwitch 설정이 가능합니다.

<p align="center">
  <img src="https://user-images.githubusercontent.com/72970232/129754574-f82b65df-c422-4d55-82e8-c38e063480e2.png" width="90%" height="90%" >
</p>


- 다시 Network & Security 섹션에서 Security Group에 들어가서 [Create Security Group] 버튼을 클릭합니다.

![Untitled 7](https://user-images.githubusercontent.com/72970232/129754575-f48871c3-56fd-445e-a25f-2266761c8b1c.png)

- Security Group 이름과 VPC 네트워크를 선택합니다. Access Rule에서 인바운드 및 아웃바운드 포트와 IP설정이 가능합니다. 일종의 방화벽입니다.

![Untitled 8](https://user-images.githubusercontent.com/72970232/129754576-d3d9e772-4a96-4bea-872f-5fb7aafd1f09.png)

## 3. ECS(Elastic Compute Service, VM) 생성

<ins>**참고(중요): 실습에서는 중국 본토 이외의 리전을 사용 바람.**</ins> 기본적으로 중국 리전은 outbound만 열려있고, inbound는 허가된 사람에게만 허용되기 때문. (중국 본토 리전을 사용하기 위해서는 반드시 실명 등록증을 제출해야함.)

![Untitled 9](https://user-images.githubusercontent.com/72970232/129754578-9aac16b8-9ec6-417c-bd4b-95942303a318.png)

1) 웹 콘솔 접속

- [콘솔 보기] 클릭

![Untitled 10](https://user-images.githubusercontent.com/72970232/129754581-8219ccff-eaf7-4fd9-b659-d6416b1ae339.png)

2) 세부 목록 버튼 클릭

![Untitled 11](https://user-images.githubusercontent.com/72970232/129754582-572afefd-905c-4f51-9e51-7bbb4c5e50eb.png)

3) Elastic Compute Service(ECS) 클릭


![Untitled 12](https://user-images.githubusercontent.com/72970232/129754587-5774ba0c-10ea-41d3-9e44-915fdf9e9e11.png)

4) Create ECS Instance 클릭

![Untitled 13](https://user-images.githubusercontent.com/72970232/129754588-bcc303a5-8aa8-4c54-bf9c-0628f9b66a53.png)
![Untitled 14](https://user-images.githubusercontent.com/72970232/129754593-0994d971-b42c-40d4-8f79-caa213a32e19.png)

5-1) label-simple-buy(빠른 구매)

![Untitled 15](https://user-images.githubusercontent.com/72970232/129754595-a4ad0e4b-e55d-40c1-8b86-2f24ff3e7415.png)

- 리전 : ECS를 생성할 실제 IDC 위치
- 인스턴스 유형 : vCPU, vRAM 등 인스턴스의 스펙을 결정
- 이미지 : 운영체제가 포함된 설치할 이미지 파일을 선택
- 네트워크 유형 : VPC(가상 사설 네트워크)이용
- 네트워크 청구방식
    - 대역폭 단위 과금 : 대규모 서비스와 같이 동시접속자 수가 자주 발생할 수 있을 때 대역폭이 클수록 안정적인 서비스를 제공
    - 트래픽 단위 과금 : 주로 순간적으로만 트래픽이 몰리는 서비스에서 사용시 유리함.
- 수량 : 생성할 ECS의 갯수(동일 스펙으로)
- 기간 : 청구 개월 수(사용할 기간)
    - 자동 갱신 : 이 옵션으로 구독되어 자동으로 결제함.

5-2) 인스턴스 스펙 확인

![Untitled 16](https://user-images.githubusercontent.com/72970232/129754597-7ccaf3a4-df29-45b9-83db-3c76c847f2e0.png)

6-1) 사용자 지정 구매

![Untitled 17](https://user-images.githubusercontent.com/72970232/129754598-e94aa15b-a76e-4ad3-a67b-0353dcfcecce.png)

- 청구방법 : 구독 / Pay-AS-You-Go / 스폿 인스턴스
    - 구독 : 일정 기간 사용할 인스턴스 요금을 미리 결제하는 방식
    - Pay-As-You-Go : 본인이 사용한 만큼만 요금을 내는 결제 방식 (stop시 비용 부과X)
    - 스폿 인스턴스 : 정해진 스폿 정책에 따라 탄력성을 부과하는 결제 방식
- 리전 : 실제 ECS가 설치되는 IDC 지역이며, 세부적인 가용영역(AWS개념)까지 선택 가능
- 인스턴스 유형
- 이미지 : OS를 포함한 인스턴스 이미지를 활용
- 저장소 : 시스템 디스크(=부팅 디스크), 데이터 티스크(=디스크 추가)
- 스냅숏 : 백업 주기로 자동 스냅샷 정책 생성 가능

6-2) 네트워킹 구매 설정

![Untitled 18](https://user-images.githubusercontent.com/72970232/129754600-3ab4c8f3-e56d-4499-9eb3-f6f3089f18ca.png)

6-3) 미리보기에서 선택한 구성을 확인하고 [주문 생성] 버튼 클릭합니다.

![Untitled 19](https://user-images.githubusercontent.com/72970232/129754602-1dddaa56-452e-478d-b108-d3d5b1cc41a5.png)

7) 모든 설정이 완료되면 [구매] 버튼 클릭

![Untitled 20](https://user-images.githubusercontent.com/72970232/129754603-5b055249-043a-47e9-93dc-cd9d2fb8ceac.png)


8) 인스턴스 생성 완료

![Untitled 21](https://user-images.githubusercontent.com/72970232/129754604-17a8f6a6-17b2-4ee1-8a4f-be2fe2b43c93.png)
![Untitled 22](https://user-images.githubusercontent.com/72970232/129754605-87400165-6a23-4e21-bae6-02c4631ff24f.png)

## 4. SSH Key Pairs 발급

1) Network&Security 탭에서 SSH Key Pairs를 선택합니다.

2) Create SSH Key Pairs를 선택합니다.

![Untitled 23](https://user-images.githubusercontent.com/72970232/129754607-d920a83f-557d-486b-90f7-b0b1dd34c23b.png)

3) SSH Key Pair의 이름을 입력합니다.

![Untitled 24](https://user-images.githubusercontent.com/72970232/129754608-1e3a7ded-2b1d-4a13-916c-2c80577e9973.png)

- Creation Type : Auto-create : 자동으로 암호화 키를 생성
- Import : 사용자가 직접 키 생성 스크립트를 입력

4) 키 생성시 바로 아래와 같이 pem키가 다운로드 되고, SSH Key Pairs 목록에 생성됩니다.

5) 인스턴스와 연결시킬 SSH 키의  Bind Action을 클릭합니다.

![Untitled 25](https://user-images.githubusercontent.com/72970232/129754610-b90a9f21-12d5-44b6-9c1e-5f7b656368fa.png)
![Untitled 26](https://user-images.githubusercontent.com/72970232/129754612-03fc063e-da3b-4293-aee8-3c2c9848d771.png)

6) 원하는 인스턴스를 체크하고 오른쪽 Selected로 이동시키고, OK 버튼 클릭 합니다.

![Untitled 27](https://user-images.githubusercontent.com/72970232/129754613-9b2a68b9-a8af-4e73-b6b2-49f341e74bcb.png)
![Untitled 28](https://user-images.githubusercontent.com/72970232/129754617-222046fc-e0f8-4b1e-b7e6-9f19cf6426b1.png)

7) 실제 인스턴스에 상세항목을 보면 SSH Key Pairs에 표시된 것을 확인할 수 있음

![Untitled 29](https://user-images.githubusercontent.com/72970232/129754619-b0aae0ac-3bcb-44b4-9190-0121597fbbcb.png)

## 5. ECS 접속 (SSH Key Pair / 비밀번호 설정 / 간편한 연결)

1) SSH Key Pair 방식

- 인스턴스의 Public IP Address를 통해 PuTTy로 접속이 가능합니다.
- 기본적으로 SSH Key Pairs를 이용하면 root 사용자로 비밀번호 로그인 없이 가능합니다.

![Untitled 30](https://user-images.githubusercontent.com/72970232/129754620-fb2c74ad-1b12-46f8-bd64-a5cfcd23b6c5.png)
![Untitled 31](https://user-images.githubusercontent.com/72970232/129754623-974a9958-02e4-4e27-af89-926bfce127db.png)
![Untitled 32](https://user-images.githubusercontent.com/72970232/129754626-bf2d2f4e-2706-47e4-a07e-3f8feb3f0ee2.png)
![Untitled 33](https://user-images.githubusercontent.com/72970232/129754630-ff2df597-327e-4d2c-83db-c42ef8a94264.png)

2) 비밀번호 간편 설정 방식

- 인스턴스 상세페이지에 접속한 후 [Reset Password] 버튼을 클릭합니다.
- 비밀번호를 설정하면 pem키 없이도 접속이 가능합니다.

![Untitled 34](https://user-images.githubusercontent.com/72970232/129754632-c04eed5d-632f-443a-bee6-22422281b99b.png)
![Untitled 35](https://user-images.githubusercontent.com/72970232/129754633-a79f422e-2ab9-4604-9f50-28212076f4f4.png)
![Untitled 36](https://user-images.githubusercontent.com/72970232/129754634-9759250f-1791-40f7-81a1-ee3749e1407d.png)
![Untitled 37](https://user-images.githubusercontent.com/72970232/129754637-99e1638c-ff34-4c1f-8afa-fd78df6d4e8f.png)

3) 간편한 연결

- 인스턴스 홈에서 [Connect] 버튼을 클릭합니다.
- 아래와 같은 옵션이 있습니다.

![Untitled 38](https://user-images.githubusercontent.com/72970232/129754640-da89ecaf-39ed-4b84-87ec-b79394ec2e95.png)

3-1) VNC

- 윈도우 원격 데스크톱과 같이 원격 접속이 가능한 그래픽 화면입니다.

![Untitled 39](https://user-images.githubusercontent.com/72970232/129754642-9b6b367e-24f5-4638-8a0d-6de382d7241a.png)
![Untitled 40](https://user-images.githubusercontent.com/72970232/129754644-31d31315-c88c-4aad-9fbc-13f14a537e7c.png)

6개 내로 지정해야함

![Untitled 41](https://user-images.githubusercontent.com/72970232/129754645-86c1b20c-4b15-45c3-85c7-45a19e838957.png)

3-2) send remote call 의 경우

- 원하는 인스턴스에 Shell 명령어를 보낼 수 있습니다.

![Untitled 42](https://user-images.githubusercontent.com/72970232/129754647-535560aa-4121-432f-9f9a-c15397f04075.png)


- 간단한 명령어는 확인할 수 있습니다. (ifconfig, ls 등)

![Untitled 43](https://user-images.githubusercontent.com/72970232/129754649-a3fde865-a00c-4f94-b572-f4d9e32e08d8.png)

- 다만, 패키지 설치까지는 불가능 합니다.

![Untitled 44](https://user-images.githubusercontent.com/72970232/129754654-dcc1e3fa-5608-4346-a215-63ba61af20b9.png)

3-3) send file 옵션 

- 인스턴스 상세페이지에 접속하여 [Remote Commands/Files] 탭에 들어갑니다.
- [Send File] 버튼을 클릭합니다.
- send file을 통해서 FTP 서버를 구축하지 않아도 파일을 즉시 업로드 할 수 있습니다.

![Untitled 45](https://user-images.githubusercontent.com/72970232/129754656-92159cfb-464c-4f33-93f1-b8131ab13dcd.png)

- 기본적인 파일 옵션을 전부 설정할 수 있습니다. (이름/경로/사용자/권한 등)

![Untitled 46](https://user-images.githubusercontent.com/72970232/129754558-7a16d861-77fb-4e63-897c-19e9d28d8bc0.png)


- File Sending Result에서는 파일이 전송 결과를 확인할 수 있습니다.

![Untitled 47](https://user-images.githubusercontent.com/72970232/129754562-8e0bea32-d327-4d85-89c9-50a3844f4fa5.png)


- 이상 없이 파일이 들어 온 것을 확인할 수 있습니다.

![Untitled 48](https://user-images.githubusercontent.com/72970232/129754565-df502ac0-011c-4aa7-9613-6382db8fe236.png)
