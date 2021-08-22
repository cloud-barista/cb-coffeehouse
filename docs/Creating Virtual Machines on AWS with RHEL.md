## Part 2. AWS를 이용하여 가상 머신 생성하기 - 리눅스(RHEL)

1. 화면 우측 상단 **[콘솔에 로그인]** 버튼을 클릭함

![01](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\01.jpg)

2. **[솔루션 구축]** 탭에서 **[가상 머신 시작]** 버튼을 클릭함

![02](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\02.jpg)

3. AMI를 선택하는 단계에서 **[Red Hat Enterprise Linux 8]** 항목 오른쪽에서 **[64비트(x86)]** 을 체크한 후 **[선택]** 버튼을 클릭함

![03](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\03.jpg)

4. 기본 선택 옵션을 그대로 두고, **[검토 및 시작]** 버튼을 클릭함

- 프리티어의 경우 **[t2.micro]** 옵션만 사용이 가능함

![04](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\04.jpg)

5. 기본 선택 옵션을 그대로 두고, 화면 우측 하단 **[시작하기]** 버튼을 클릭함

![05](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\05.jpg)

6. **[기존 키 페어 선택]** 항목을 클릭함

- 키 페어란? SSH를 통한 서버 접속 시 필요한 인증 수단으로 키 페어 파일은 별도로 백업하여 보관할 것

![07](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\07.jpg)

7. **[키 페어 이름]**을 입력한 후, **[키 페어 다운로드]** 버튼을 클릭함

- **[Key pair type]**은 **[RSA]** 항목 그대로 둠

![08](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\08.jpg)

8. 키 페어 다운로드가 완료되면 **[인스턴스 시작]** 버튼을 클릭함

![09](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\09.jpg)

9. 인스턴스 생성 및 시작 과정이 진행되고 있는 모습

![10](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\10.jpg)

10. 인스턴스 시작 중이라는 화면이 확인 되면 화면 우측 하단 **[인스턴스 보기]** 버튼을 클릭함

![11](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\11.jpg)

11. 대시보드를 통해 생성한 인스턴스를 확인할 수 있음

![12](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\12.jpg)

12. 인스턴스 접속을 위해 putty를 다운로드 하여 실행함

- 다운로드 링크 : https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html
- 자신의 OS 환경에 맞게 msi 파일을 다운로드 받음

![13](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\13.jpg)

13. Putty Key Generator를 실행함

- PuTTYgen이라는 파일명으로 되어 있음
- 7~8번 과정에서 생성한 키 페어 파일을 putty에서 사용할 ppk로 변환 과정을 거치기 위함

![14](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\14.jpg)

14. 하단 **[Type of key to generate]** 항목에서 **[RSA]**를 선택하고, 화면 우측 하단 **[Load]** 버튼을 클릭함

![15](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\15.jpg)

15. 우측 하단에 파일 확장자를 **[All Files]**로 바꿔주고, 7~8번 과정에서 만들어진 키 페어 파일을 불러옴

![16](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\16.jpg)

16. 화면 우측 하단 **[Save private Key]** 버튼을 클릭하여 변환된 ppk 파일을 저장함

- **[Successfully imported foreign key~]** 메시지가 뜨면 **[확인]** 버튼을 클릭하면 됨
- **[Are you sure you want to~]** 메시지가 뜨면 **[예]** 버튼을 클릭하면 됨

![17](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\17.jpg)

17. putty를 실행시킨 후 **[Host Name]** 부분에 대시보드에 적혀있는 **[퍼블릭 IPv4]** 항목에 나온 IP 주소를 입력함

- 포트는 22번으로 그대로 둘 것

![18](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\18.jpg)

18. 왼쪽 **[category]** 부분에서 **[Connection] - [SSH] - [Auth]** 항목을 차례대로 선택하여 **[Browse]** 버튼을 클릭한 후 16번 과정에서 변환한 ppk 파일을 불러온 후 **[Open]** 버튼을 클릭함

![19](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\19.jpg)

19. **[login as]** 부분에 **[ec2-user]**라고 입력하면 접속까지 최종 완료됨

- ppk 파일이 비밀번호 역할을 해주기 때문에 별도의 비밀번호 입력 없이 접속이 가능함

![20](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\20.jpg)

20. 만약, 인스턴스를 사용하지 않을 경우 대시보드 우측 상단 **[인스턴스 상태]** 버튼을 클릭한 후, **[인스턴스 중지]** 버튼을 차례로 클릭하여 중지시켜놔야 추가 과금이 일어나지 않음

![21](D:\03-Project\Cloud-Barista\210821_1st Action Item\스크린샷\Part 2\21.jpg)

