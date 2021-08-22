## Part 3. VPC 및 보안그룹 생성하기

**VPC(Virtual Private Cloud)란?**

- 사용자의 AWS 계정 전용 가상 네트워크

------

1. [https://console.aws.amazon.com/vpc/]로 들어가 Amazon VPC 콘솔로 접속함

![01](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 3\01.jpg)

2. 왼쪽 4가지 옵션에서 자신에게 맞는 옵션을 선택한 후 **[선택]** 버튼을 클릭함

- 프리티어에서는 **[단일 퍼블릭 서브넷이 있는 VPC]**를 사용하고 **[선택]** 버튼을 클릭함

![02](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 3\02.jpg)

3. VPC 이름과 기타 옵션을 설정한 후 우측 하단에 **[VPC 생성]** 버튼을 클릭함

![03](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 3\03.jpg)

4. VPC 생성이 완료된 모습

![04](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 3\04.jpg)

5. 보안 그룹을 생성하기 위해 대시보드 왼쪽 하단 **[네트워크 보안]** 메뉴에 있는 **[보안 그룹]** 메뉴를 선택한 후 새로운 보안 그룹을 생성하기 위해 우측 상단에 있는 **[보안 그룹 생성]** 버튼을 클릭함

![06](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 3\06.jpg)

6. 보안 그룹 정보 및 인바운드, 아웃바운드 규칙을 입력한 후 우측 하단에 **[보안 그룹 생성]** 버튼을 클릭함

![07](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 3\07.jpg)

7. 보안 그룹 생성이 완료된 모습

- 기본 보안 그룹은 생성되어 있으니 추가적인 보안 그룹 설정이 필요할 경우에만 만들면 됨

![08](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 3\08.jpg)