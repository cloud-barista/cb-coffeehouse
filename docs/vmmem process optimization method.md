# vmmem 프로세스 메모리 과점유


Cloud-barista를 widnwos 환경에서 작업시 wsl2나 docker desktop을 설치해서 진행하게 됩니다.

위의 두 프로그램을 실행할 경우 vmmem이라는 프로세스가 동작하게 되고 이 프로세스가 메모리를 과도하게 잡아 먹기에 별도의 작업이 필요합니다.

![vmmem1](https://user-images.githubusercontent.com/46340193/131523590-1434df10-fc74-4927-b58f-56d35aa9d5cf.PNG)


이 vmmem 프로세스는 작업 관리자로도 종료가 불가합니다. 

![image](https://user-images.githubusercontent.com/46340193/131523795-73ce7e87-21fa-492d-872f-cfb8be0cef33.png)



# 최적화 하기

wsl2와 docker desktop을 종료 후 터미널을 열고 .wslconfig 파일을 작성 

```
notepad “$env:USERPROFILE/.wslconfig”
```

![image](https://user-images.githubusercontent.com/46340193/131524432-882edee3-e1c7-4443-a105-f86a91070199.png)

구축할 환경에 맞게 .wslconfig 작성 


# 기존과 환경 비교


최적화 전 할당된 자원 

![image](https://user-images.githubusercontent.com/46340193/131524774-73609351-ba4d-46d9-9108-ac4ea7c781c5.png)

최적화 후 할당된 자원 

![image](https://user-images.githubusercontent.com/46340193/131524993-164250f2-79c1-4b4c-b74a-d7e9bf4e2637.png)

최적화 후 작업관리자로 할당 자원 확인 

![image](https://user-images.githubusercontent.com/46340193/131525061-b3afc554-0d9b-4604-ae3f-792d4bb0815f.png)

## 해당 환경으로 실행 후 자원을 추가하거나 줄여 최적의 환경을 찾으면 됩니다.


# Docker desktop 환경 설정

Docker desktop 설치 시 기본적으로 컴퓨터가 재시작을 하면 자동 실행되도록 설정이 되어있습니다.

체크를 해재하여 필요할 때만 사용하도록 합니다.

![image](https://user-images.githubusercontent.com/46340193/131526170-0d18d874-d488-4111-b77d-99c7868830a7.png)


# 그 외 


vmmem프로세스 강제 종료를 위해선 작업관리자가 아닌 터미널에서 명령어를 통해 종료 가능 

```
wsl --shutdown
```








