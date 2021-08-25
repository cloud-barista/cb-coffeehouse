## **Part 1. AWS 계정 생성하기**

1. [https://aws.amazon.com/ko/]에 접속함

2. 화면 우측 상단 **[콘솔에 로그인]** 버튼을 클릭함

![01](https://i.imgur.com/0TrIFt7.jpg)

3. 화면 왼쪽 하단 **[AWS 계정 새로 만들기]** 버튼을 클릭함

![02](https://i.imgur.com/QeLs9fo.jpg)

4. 아이디, 비밀번호, 계정 이름을 입력함

- 단, 계정 이름은 영문으로 입력해야 함 (본인의 영어 닉네임을 적는 것을 추천!)

![03](https://i.imgur.com/Na8IX5h.jpg)

5. **[AWS를 어떻게 사용할 계획인가요?]** 항목에는 **[개인]**에 체크한 후, 상세 정보를 전부 입력함

![04](https://i.imgur.com/ey4jYVq.jpg)

6. 카드 결제 정보를 입력함

- 결제하고자 하는 카드는 Visa, Master, UnionPay 등 해외 결제가 가능한 계좌여야 함
- 연동된 카드에는 1달러(1100원) 이상 잔액이 기본적으로 있어야 함
  - 프리티어라고 해도 최초로 한번의 결제 과정이 필요함

![05](https://i.imgur.com/0PuzIWD.jpg)

7. 비밀번호 및 생년월일, 동의 절차를 추가적으로 진행함

![06](https://i.imgur.com/hqHcchU.jpg)

8. 본인 명의의 휴대전화 번호를 입력한 후 본인 인증 절차를 거침

- 핸드폰 번호는 5번 항목에 입력한 번호와 동일한 번호를 입력해야 함

![07](https://i.imgur.com/gB0T2qD.jpg)

9. 지불 정보에 문제가 있다고 오류가 뜰 경우, 표시 된 부분에 있는 **[계정에 로그인]** 버튼을 클릭하여 우선적으로 로그인 과정을 진행함

- 이 오류가 나지 않을 경우 17번 과정부터 진행함

![08](https://i.imgur.com/5EhEQbX.jpg)

10. **[루트 사용자]**를 체크한 후 **[루트 사용자 이메일 주소]**에 작성했던 이메일 주소를 입력한 후 **[다음]** 버튼을 클릭하여 로그인 과정을 진행함

![09](https://i.imgur.com/f7LHYIe.jpg)

11. **[보안 문자]**를 입력한 후 **[제출]** 버튼을 클릭함

![10](https://i.imgur.com/n5Vng3e.jpg)

12. 비밀번호를 입력한 후 **[로그인]** 버튼을 클릭함

![11](https://i.imgur.com/JD903wy.jpg)

13. 카드 등록이 정상적으로 완료된 것을 확인하면 왼쪽 상단 로고 버튼을 클릭하여 메인화면으로 이동함

![12](https://i.imgur.com/j9FFhEg.jpg)

14. **[가상 머신 시작]** 버튼을 클릭하여 현재 계정 상태를 다시 확인함

![13](https://i.imgur.com/sIkBvRs.jpg)

15. 아래와 같은 화면이 뜨면 1~2시간 정도 대기 후 표시된 부분에 있는 **[AWS 등록을 완료하십시오]** 버튼을 클릭함

- 1~2시간이 지나고 나서도 안되면 익일에 다시 재시도 할 것

![14](https://i.imgur.com/yVolCGP.jpg)

16. 9번 과정을 다시 재시도함

![07](https://i.imgur.com/5EhEQbX.jpg)

17. 인증 코드를 입력하고 **[계속]** 버튼을 클릭하여 다음 단계로 이동함

![15](https://i.imgur.com/EeLEMtQ.jpg)

18. **[기본 지원 - 무료]** 플랜을 선택한 후, **[가입 완료]** 버튼을 클릭함

![16](https://i.imgur.com/ZymsP6t.jpg)

19. 계정 생성이 최종적으로 완료된 화면

![17](https://i.imgur.com/bfqJMnx.jpg)





## Part 2. AWS를 이용하여 가상 머신 생성하기 - 리눅스(RHEL)

1. 화면 우측 상단 **[콘솔에 로그인]** 버튼을 클릭함

![01](https://i.imgur.com/P6QPqGj.jpg)

2. **[솔루션 구축]** 탭에서 **[가상 머신 시작]** 버튼을 클릭함

![02](https://i.imgur.com/WV5sDWv.jpg)

3. AMI를 선택하는 단계에서 **[Red Hat Enterprise Linux 8]** 항목 오른쪽에서 **[64비트(x86)]** 을 체크한 후 **[선택]** 버튼을 클릭함

![03](https://i.imgur.com/ikqha9F.jpg)

4. 기본 선택 옵션을 그대로 두고, **[검토 및 시작]** 버튼을 클릭함

- 프리티어의 경우 **[t2.micro]** 옵션만 사용이 가능함

![04](https://i.imgur.com/ez3RI5p.jpg)

5. 기본 선택 옵션을 그대로 두고, 화면 우측 하단 **[시작하기]** 버튼을 클릭함

![05](https://i.imgur.com/H9bjXq2.jpg)

6. **[기존 키 페어 선택]** 항목을 클릭함

- 키 페어란? SSH를 통한 서버 접속 시 필요한 인증 수단으로 키 페어 파일은 별도로 백업하여 보관할 것

![07](https://i.imgur.com/zOxSWZp.jpg)

7. **[새 키 페어 생성]** 항목을 선택함

![](https://i.imgur.com/PX1Opyu.jpg)

8. **[키 페어 이름]**을 입력한 후, **[키 페어 다운로드]** 버튼을 클릭함

- **[Key pair type]**은 **[RSA]** 항목 그대로 둠

![08](https://i.imgur.com/GYxtR9O.jpg)

8. 키 페어 다운로드가 완료되면 **[인스턴스 시작]** 버튼을 클릭함

![09](https://i.imgur.com/Sh8kXka.jpg)

9. 인스턴스 생성 및 시작 과정이 진행되고 있는 모습

![10](https://i.imgur.com/bUODxb9.jpg)

10. 인스턴스 시작 중이라는 화면이 확인 되면 화면 우측 하단 **[인스턴스 보기]** 버튼을 클릭함

![11](https://i.imgur.com/UWMO447.jpg)

11. 대시보드를 통해 생성한 인스턴스를 확인할 수 있음

![12](https://i.imgur.com/36eUkIx.jpg)

12. 인스턴스 접속을 위해 putty를 다운로드 하여 실행함

- 다운로드 링크 : https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html
- 자신의 OS 환경에 맞게 msi 파일을 다운로드 받음

![13](https://i.imgur.com/RMn1MaK.jpg)

13. Putty Key Generator를 실행함

- PuTTYgen이라는 파일명으로 되어 있음
- 7~8번 과정에서 생성한 키 페어 파일을 putty에서 사용할 ppk로 변환 과정을 거치기 위함

![14](https://i.imgur.com/Uuv5sgH.jpg)

14. 하단 **[Type of key to generate]** 항목에서 **[RSA]**를 선택하고, 화면 우측 하단 **[Load]** 버튼을 클릭함

![15](https://i.imgur.com/j0BJem2.jpg)

15. 우측 하단에 파일 확장자를 **[All Files]**로 바꿔주고, 7~8번 과정에서 만들어진 키 페어 파일을 불러옴

![16](https://i.imgur.com/41c0iXs.jpg)

16. 화면 우측 하단 **[Save private Key]** 버튼을 클릭하여 변환된 ppk 파일을 저장함

- **[Successfully imported foreign key~]** 메시지가 뜨면 **[확인]** 버튼을 클릭하면 됨
- **[Are you sure you want to~]** 메시지가 뜨면 **[예]** 버튼을 클릭하면 됨

![17](https://i.imgur.com/DUc0Qch.jpg)

17. putty를 실행시킨 후 **[Host Name]** 부분에 대시보드에 적혀있는 **[퍼블릭 IPv4]** 항목에 나온 IP 주소를 입력함

- 포트는 22번으로 그대로 둘 것

![18](https://i.imgur.com/fJWAplf.jpg)

18. 왼쪽 **[category]** 부분에서 **[Connection] - [SSH] - [Auth]** 항목을 차례대로 선택하여 **[Browse]** 버튼을 클릭한 후 16번 과정에서 변환한 ppk 파일을 불러온 후 **[Open]** 버튼을 클릭함

![19](https://i.imgur.com/kj6X7Jm.jpg)

19. **[login as]** 부분에 **[ec2-user]**라고 입력하면 접속까지 최종 완료됨

- ppk 파일이 비밀번호 역할을 해주기 때문에 별도의 비밀번호 입력 없이 접속이 가능함

![20](https://i.imgur.com/WDjPIzY.jpg)

20. 만약, 인스턴스를 사용하지 않을 경우 대시보드 우측 상단 **[인스턴스 상태]** 버튼을 클릭한 후, **[인스턴스 중지]** 버튼을 차례로 클릭하여 중지시켜놔야 추가 과금이 일어나지 않음

![21](https://i.imgur.com/ofyMKCO.jpg)



## Part 3. VPC 및 보안그룹 생성하기

**VPC(Virtual Private Cloud)란?**

- 사용자의 AWS 계정 전용 가상 네트워크

------

1. [https://console.aws.amazon.com/vpc/]로 들어가 Amazon VPC 콘솔로 접속함

![01](https://i.imgur.com/1SustsL.jpg)

2. 왼쪽 4가지 옵션에서 자신에게 맞는 옵션을 선택한 후 **[선택]** 버튼을 클릭함

- 프리티어에서는 **[단일 퍼블릭 서브넷이 있는 VPC]**를 사용하고 **[선택]** 버튼을 클릭함

![02](https://i.imgur.com/3NJseF5.jpg)

3. VPC 이름과 기타 옵션을 설정한 후 우측 하단에 **[VPC 생성]** 버튼을 클릭함

![03](https://i.imgur.com/acFYMNb.jpg)

4. VPC 생성이 완료된 모습

![04](https://i.imgur.com/wL6a5j6.jpg)

5. 보안 그룹을 생성하기 위해 대시보드 왼쪽 하단 **[네트워크 보안]** 메뉴에 있는 **[보안 그룹]** 메뉴를 선택한 후 새로운 보안 그룹을 생성하기 위해 우측 상단에 있는 **[보안 그룹 생성]** 버튼을 클릭함

![06](https://i.imgur.com/mnfax9c.jpg)

6. 보안 그룹 정보 및 인바운드, 아웃바운드 규칙을 입력한 후 우측 하단에 **[보안 그룹 생성]** 버튼을 클릭함

![07](https://i.imgur.com/KSKfDUl.jpg)

7. 보안 그룹 생성이 완료된 모습

- 기본 보안 그룹은 생성되어 있으니 추가적인 보안 그룹 설정이 필요할 경우에만 만들면 됨

![08](https://i.imgur.com/r5SFWJO.jpg)