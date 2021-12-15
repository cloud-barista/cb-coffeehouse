# A guide to the development environment setup for Cloud-Barista

Cloud-Barista 컨트리뷰션을 위한 공식 환경 정보:
- Operating System (OS): Ubuntu 18.04
- Container: Docker 19.03
- Build: Go 1.16


Contributions are welcome :blush:

## 1. Windows 10에서 Cloud-Barista 개발 환경 구성하기

Windows 10에서 Windows Subsystem for Linux (WSL) 2를 통해 Ubuntu 18.04를 구축 및 연동하는 개발 환경 구성 가이드 입니다.
(인터넷 자료를 최대한 활용하였습니다.)

### 1.1. Windows 10에서 Ubuntu 환경 구성하기

출처: [WSL2 설치 및 사용 방법](https://www.44bits.io/ko/post/wsl2-install-and-basic-usage)

위 링크를 참고하여 아래 과정을 수행:
1. Windows Terminal 설치
2. WSL2 활성화를 위한 DISM (Deployment Image Servicing and Management) 명령어 실행
3. Microsoft Store에서 우분투(Ubuntu) 18.04 설치 (배포판을 설치하면 20.04가 설치됨)
4. WSL2 리눅스 커널 업데이트 및 배포판에서 2 버전 활성화 하기
5. WSL2에서 우분투(Ubuntu) 시작하기
6. WSL2에서 도커 데스크탑(Docker Desktop for Windows) 설치 
7. Nginx 컨테이너 실행을 통해 테스트 진행 (생략 가능)


**참고: 리눅스 배포판 18.04 설치중 에러(0x8024500C) 발생할 경우, [Linux용 Windows 하위 시스템 배포판 패키지를 수동으로 다운로드](https://docs.microsoft.com/ko-kr/windows/wsl/install-manual) 참고

예제 - PowerShell을 사용하여 다운로드:
```
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile Ubuntu.appx -UseBasicParsing
```

### 1.2. Ubuntu 18.04에 Golang 설치하기

참고: [cb-coffeehouse/scripts/golang](https://github.com/cloud-barista/cb-coffeehouse/tree/main/scripts/golang)

CB-Spider, CB-Tumblebug 등은 root 계정으로 구동합니다. 이에, root에 Go를 설치 합니다.

root 권한 획득
```
sudo su
```

Golang 설치
```
wget https://raw.githubusercontent.com/cloud-barista/cb-coffeehouse/master/scripts/golang/go-installation.sh
source go-installation.sh
```

## 2. CB-Spider Server 실행

### 2.1. Windows Terminal 실행
### 2.2. 탭에서 Ubuntu 18.04 선택
### 2.3. root 권한 획득
CB-Spider, CB-Tumblebug 등은 root 계정으로 구동 합니다.
```
sudo su
```

### 2.4. CB-Spider 소스 기반 실행
참고: [Quick Start Guide](https://github.com/cloud-barista/cb-spider/wiki/Quick-Start-Guide)

CB-Spider Server 실행에 성공 했다면, 이제 개발을 위해 VS Code를 연동할 단계 입니다.

물론, GoLand, vi 등 다른 도구 활용 가능합니다 ^^

## 3. VS Code에 WSL 연동하기

### 3.1. VS Code 설치 및 Go Extentions 설치

출처: [VS Code](https://code.visualstudio.com/)

1. VS Code 다운로드 및 설치
2. Go Extensions 설치 (Highlight, Go to definition 등 활용을 위해)

### 3.2. VS Code와 WSL 연동

출처: [Visual Studio Code와 Windows Subsystem for Linux 연동하기](https://evandde.github.io/vscode-wsl/)

아래 두가지 방법이 있으니 편한 방법으로 진행하시면 되겠습니다.
- WSL 터미널에서 실행
- VSCode에서 실행

## 4. (Option) SourceTree 설치

개인적으로 IDE와 Git Client를 분리해서 사용하기 때문에 Source Tree는 선택적으로 설치하여 활용하시기 바랍니다.

여러 관련 툴(e.g., GitHub Desktop, Git Bash, 등)을 사용하셔도 무방합니다.
