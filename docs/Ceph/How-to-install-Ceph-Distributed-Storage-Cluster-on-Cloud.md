### 설치 절차
1. 설치 지원 도구 설치
2. Master Node 설치 
3. Storage Node 설치/등록
4. 상태 확인 방법
5. FS Volume 추가 및 삭제 방법
6. FS Volume Mount 방법

### 참고 자료
- https://docs.ceph.com/en/latest/install/#recommended-methods
- https://docs.ceph.com/en/latest/cephadm/install 등

### 공통 설정
- 모든 노드에 실행/설정 # 모든 VM <seoul> region
- OS: Ubuntu 20.04 LTS
- root 계정으로 설치/운영: `$ sudo su -`
- time sync: `$ apt update; apt install -y ntpdate; ntpdate ntp.ubuntu.com;`
- install docker: `$ apt install -y docker.io`
- SSH Handshaking between all nodes of cluster (root 계정)
  - root ssh 로그인 가능하도록 설정
  - 동일 Key(Keypair)를 공유
    ```
        $ echo "PermitRootLogin yes" >> /etc/ssh/sshd_config ;  # => PermitRootLogin yes  추가
        $ service ssh restart
        $ vi .ssh/authorized_keys      # Ubuntu 20.04 경우: 처음부터 "ssh-rsa" 앞까지 삭제 필요
        $ exit;   # root 빠져나옴
        $ exit;   # VM terminal 빠져나옴
        # SSH Handshaking: copy sharing private key into root/.ssh/id_rsa
            ex) $ scp -i powerkim-seoul.pem powerkim-seoul.pem  root@52.79.xxx.xxx:./.ssh/id_rsa
    ```
```   
============== 명령어만
    $ sudo su -
    $ apt update; apt install -y ntpdate; ntpdate ntp.ubuntu.com; apt install -y docker.io;
    $ echo "PermitRootLogin yes" >> /etc/ssh/sshd_config; service ssh restart;
    $ vi .ssh/authorized_keys     # Ubuntu 20.04 경우 처음부터 "ssh-rsa" 앞까지 삭제 필요
    $ exit;
    $ exit;
    $ scp -i powerkim-seoul.pem powerkim-seoul.pem  root@52.79.xxx.xxx:./.ssh/id_rsa
================
```

------
## 1. 설치 지원 도구 설치
### cephadm & bootstrap 설치 노드 => 이하 **Master 노드**
- cephadm을 설치하고, 동일한 노드에 bootstrap을 설치

#### [참고] cephadm & Ceph-Mon 노드 권장 사양
- Ceph-Mon
    ```
    Processor    2 cores minimum
    RAM           24GB+ per daemon
    Disk Space  60 GB per daemon
    ```

### 설치 사양
- AWS Seoul
    ```
    # Image: Ubuntu 20.04 LTS  <Seoul>
    # Instance Type: t2.2xlarge (vCPU:8, Mem:32GB, Disk:60GB)
    # 외부 port open시 참고: 3300, 6789, 6800-7300, 8443(dashboard port)
    ```

### 설치 지원 도구 설치
- cephadm 설치
    ```
    $ curl --silent --remote-name --location https://github.com/ceph/ceph/raw/octopus/src/cephadm/cephadm
    $ chmod +x cephadm
    ```
- test
    ```
    $ ./cephadm -h
    ```

------
## 2. Master Node 설치 
- **# IP 할당 정보**
  - **private IP: 172.31.17.253**
  - **public IP: 52.79.xxx.xxx**

- install Ceph Octopus version
    ```
    $ ./cephadm add-repo --release octopus; ./cephadm install;
    ```
- test
    ```
    $ which cephadm
      >if success: /usr/sbin/cephadm
    ```

- BOOTSTRAP A NEW CLUSTER 
    ```
    $ mkdir /etc/ceph
    $ cephadm bootstrap --mon-ip `hostname -i`  # mon-ip: cephadm 설치된 local IP, public IP: 실패
    ```

- ENABLE CEPH CLI
  - install ceph-common(ceph commands: ceph, rbd, mount.ceph, etc., ...)
      ```
      $ cephadm add-repo --release octopus
      $ cephadm install ceph-common
      ```
  - test
      ```
      $ ceph -v
      $ ceph status
      ```

- Dashboard 접속 정보
  - https://52.79.xxx.xxx:8443

------
## 3. Storage Node 설치/등록
### Storage Node(OSD Node) 설치 사양
- AWS Seoul
    ```
    # Image: Ubuntu 20.04 LTS  <Seoul>
    # t2.medium: vCPU:2, Mem:4GB, Disk:8GB
    # 172.31.12.115 
    # 외부 port open시 참고: 6800-7300
    # Volume 추가(EBS): /dev/xvdb, 30GB   (ODS 노드: device 추가용)

### OSD Node 설정 및 마스터 등록(master join)
- OSD Node에서 실행: OSD Node의 host name 이용
    ```
    $ ssh-copy-id -f -i /etc/ceph/ceph.pub root@ip-172-31-12-115
    $ ceph orch host add  ip-172-31-12-115
    $ ceph orch daemon add osd  ip-172-31-12-115:/dev/xvdb
    ```
- OSD 등록 성공시: OSD 노드에 3개 컨테이너 가동

```
$ docker ps
CONTAINER ID   IMAGE                      COMMAND                   CREATED           STATUS     PORTS                NAMES
b3648274e0d6  ceph/ceph:v15               "/usr/bin/ceph-osd -▒€▒" 19 seconds ago  Up 18 seconds  ceph-9ef3c682-5b22-11eb-a387-3b4e5d7c111c-osd.3
7ab3b7cf6d8d  prom/node-exporter:v0.18.1  "/bin/node_exporter ▒€▒" 36 seconds ago  Up 34 seconds  ceph-9ef3c682-5b22-11eb-a387-3b4e5d7c111c-node-exporter.ec2-3-36-122-189
ca9d1f39526e  ceph/ceph:v15               "/usr/bin/ceph-crash▒€▒" 44 seconds ago  Up 43 seconds  ceph-9ef3c682-5b22-11eb-a387-3b4e5d7c111c-crash.ec2-3-36-122-189
```

- Dashboard 로그인 및 OSD 현황 확인
  - https://52.79.xxx.xxx:8443

------
## 4. 상태 확인 방법
### Cluster Status
  ```
  $ ceph -s  # ceph 구성 개요
  $ ceph orch ls
  $ ceph orch ls --export
  ```

### Capacity
  ```
  $ ceph osd tree
  $ ceph osd df
  $ ceph df
  ```

### restart
  ```
  $ systemctl restart ceph.target
  ```

------
## 5. FS Volume 추가 및 삭제 방법
### FS Volume 추가 방법
  ```
  $ ceph fs volume create cephfs   # 관련 pool(cephfs.cephfs.data, cephfs.cephfs.meta) 및 mds(mds.cephfs)가 자동 생성됨
  $ ceph fs volume create powerkim_fs01  --placement="ip-172-31-12-115 ip-172-31-12-225 ip-172-31-10-47" ## 활용 대상 OSD 지정
  $ ceph fs volume create fs01 --placement="*" # 전체 OSD 지정
  ```
### FS Volume 목록 보기
  ```
  $ ceph fs volume ls
  ```
### FS Volume 삭제 방법
  ```
  $ ceph config set mon mon_allow_pool_delete true
        - deprecated(old method): $ ceph tell mon.\* injectargs '--mon-allow-pool-delete=true'
  $ ceph fs volume rm fs_name --yes-i-really-mean-it
  ```

------
## 6. FS Volume Mount 방법
- ref1) https://docs.ceph.com/en/latest/cephfs/mount-prerequisites/
- ref2) https://docs.ceph.com/en/latest/cephfs/mount-using-kernel-driver/ (Kernel 14.x 이상 방법)

### Client 준비
- Ubuntu 18.04 (또는 Kernel 14.x 이상 배포판)
- Ceph Client 설정
 - ceph 서버 설정 파일 복사: 마스터의 /etc/ceph/ceph.conf 파일 동일 위치에 복사 (ref1 참조)
 - ceph 사용자 인증 설정: 마스터의 /etc/ceph/xxx.keyring 파일 동일 위치에 복사 (ref1 참조)

### Mount Helper 설치 및 Mount
  ```
  $ apt update; apt install -y ceph-common
  $ mkdir /mnt/mycephfs
  $ mount -t ceph  172.31.17.253:/  /mnt/mycephfs -o name=admin        # 172.31.17.253 = Master Private IP
  ```

### 이하 local File System 사용과 동일
### FS Volume 외에 Block Store, Object Store 및 S3 API, NFS 제공 등 다양한 확장 기능 제공
### 다양한 분산 파일 시스템 특징 제공
