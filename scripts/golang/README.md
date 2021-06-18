![go-version](https://img.shields.io/badge/go-v1.16.4-informational) ![aws-passing](https://img.shields.io/badge/aws-passing-success) ![gcp-passing](https://img.shields.io/badge/gcp-passing-success)

# Go scripts

Linux에서 Go 설치 및 삭제 그리고 이와 관련있는 환경 설정을 수행하는 스크립트 입니다. VM 생성할때마다 수동으로 설정하기 번거로워서 만들었습니다.

참고: 

- **Go version: 1.16.4** (다른 버전 설치를 원하시면 스크립트 내용을 변경해주세요.)

- **OS: Linux**

- **Arch: x86-64**



사용방법 1 - Go installation

```bash
wget https://raw.githubusercontent.com/cloud-barista/cb-coffeehouse/master/scripts/golang/go-installation.sh
source go-installation.sh
```



사용방법 2 - Go uninstallation

```bash
wget https://raw.githubusercontent.com/cloud-barista/cb-coffeehouse/master/scripts/golang/go-uninstallation.sh
source go-uninstallation.sh
```



쉘 스크립트 실행시 source와 bash로 실행하는 것의 차이를 설명한 링크

- [source, . (점): 셸 스크립트 파일 실행](https://www.bangseongbeom.com/source-dot.html)
