## 환경 구성
### 실행 환경
- CSP: Amazon Web Services (AWS)
- Region: Frankfurt
- OS: Ubuntu 18.04.5 LTS
- Instance Type: t2.large ([Amazon EC2 Instance Type](https://aws.amazon.com/ko/ec2/instance-types/))

### 프레임워크 버전
- CB-Spider: v0.3.8
- CB-Tumblebug: v0.3.6


**<ins>참고: 모든 과정은 root 권한으로 수행하였음</ins>**

### CB-Spider 컨테이너 구동
#### 1. Docker 설치
#### 2. CB-Spider 컨테이너 구동
  - `# docker run --rm -p 1024:1024 -v ${HOME}/cloud-barista/cb-spider/meta_db:/root/go/src/github.com/cloud-barista/cb-spider/meta_db --name cb-spider cloudbaristaorg/cb-spider:0.3.8`

### CB-Tumblebug 소스기반 구동
#### 1. Go 설치
  - 참고 - [CB-Tumblebug's Go 설치](https://github.com/cloud-barista/cb-tumblebug#%EC%86%8C%EC%8A%A4-%EA%B8%B0%EB%B0%98-%EC%84%A4%EC%B9%98--%EC%8B%A4%ED%96%89-%EC%83%81%EC%84%B8-%EC%A0%95%EB%B3%B4)

#### 2. CB-Tumblebug 소스 다운로드
  ```bash
  # go get -v github.com/cloud-barista/cb-tumblebug
  ```

#### 3. CB-Tumblebug v0.3.6 체크아웃
  ```bash
  cd ~/go/src/github.com/cloud-barista/cb-tumblebug
  git checkout tags/v0.3.6
  ```

#### 4. CB-Tumblebug 실행에 필요한 환경변수 설정
  - 환경변수 내용 확인
    ```bash
    cat ~/go/src/github.com/cloud-barista/cb-tumblebug/conf/setup.env
    ```
  - 환경변수 반영
    ```bash
    cat ~/go/src/github.com/cloud-barista/cb-tumblebug/conf/setup.env
    source setup.env
    ```
  - (필요시) cb-store 설정 - [참고](https://github.com/cloud-barista/cb-tumblebug#%EC%86%8C%EC%8A%A4-%EA%B8%B0%EB%B0%98-%EC%84%A4%EC%B9%98--%EC%8B%A4%ED%96%89-%EC%83%81%EC%84%B8-%EC%A0%95%EB%B3%B4)
  - (필요시) cb-log 설정 - [참고](https://github.com/cloud-barista/cb-tumblebug#%EC%86%8C%EC%8A%A4-%EA%B8%B0%EB%B0%98-%EC%84%A4%EC%B9%98--%EC%8B%A4%ED%96%89-%EC%83%81%EC%84%B8-%EC%A0%95%EB%B3%B4)

#### 5. CB-Tumblebug 빌드
  ```bash
  cd ~/go/src/github.com/cloud-barista/cb-tumblebug/src
  export GO111MODULE=on
  make
  ```

#### 6. CB-Tumblebug 실행
  ```bash
  make run
  ```

## 사전 작업 부터 MCIS 생성, 삭제 및 각종 테스트 까지
### 사전 작업
#### 1.`jq` 설치
```bash
apt install jq -y
```

#### 2. Credential 생성
참고 - [A step by step guide to creating credentials of each cloud service provider](https://github.com/cloud-barista/cb-coffeehouse/wiki/A-step-by-step-guide-to-creating-credentials-of-each-cloud-service-provider)

#### 3. Credential 설정
`credental.conf.example`을 복사하여 위에서 생성한 정보를 입력한다.
```bash
cp ~/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts/credentials.conf.example ~/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts/credentials.conf
```

#### 4. `testSet.env` 설정
`testSet.env`를 복사하여 원하는 환경을 설정한다. (글로 설명하기 어려운 부분)
```bash
cp ~/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts/testSet.env ~/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts/testSet1.env
```
### MCIS 생성, 삭제 및 각종 테스트
#### MCIS 한방 생성
```bash
cd ~/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts/sequentialFullTest
./create-all.sh all 1 kimyk01 ../testSet1.env
```

#### MCIS 한방 삭제
```bash
cd ~/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts/sequentialFullTest
./clean-all.sh all 1 kimyk01 ../testSet1.env
```

#### MCIS 실행 상태 조회
```bash
cd ~/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts/sequentialFullTest
cat executionStatus
```

#### sshkey 생성
```bash
cd ~/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts/sequentialFullTest
./gen-sshKey.sh all 1 kimyk01 ../testSet1.env
```

#### MCIS에 command 실행
```bash
cd ~/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts/sequentialFullTest
./command-mcis-custom.sh all 1 kimyk01 ../testSet1.env "ls -al"
```

#### MCIS에 wasvescope 배치
```bash
cd ~/go/src/github.com/cloud-barista/cb-tumblebug/src/testclient/scripts/sequentialFullTest
./deploy-weavescope-to-mcis.sh all 1 kimyk01 ../testSet1.env "ls -al"
```

#### MCIS에 Jitsi 배치
##### aws client 설치
```bash
apt install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```
##### `/update-dns-for-mcis-ip.sh` 실행
```bash
./update-dns-for-mcis-ip.sh all 1 kimyk01 ../testSet1.env
```

##### 위에서 출력된 정보를 활용하여 `/update-dns-for-mcis-ip.sh` 재 실행
```bash
./update-dns-for-mcis-ip.sh all 1 kimyk01 ../testSet1.env /hostedzone/xxxxxx xxxx.xxxx.xxxx(<-domain)
```

##### Jitsi 배치
```bash
./deploy-jitsi-to-mcis.sh all 1 kimyk01 ../testSet1.env 이메일주소 xxxx.xxxx.xxxx(위 도메인)
```