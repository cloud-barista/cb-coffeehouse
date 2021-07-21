# CB-Spider container 시작 절차

<ins>**주의!!** 아직 테스트 전입니다 ㅠ</ins>

## 1. 메타정보 삭제
```
sudo rm -rf /tmp/meta_db/*
```

# 2. CB-Spider image 다운로드
```
sudo docker pull cloudbaristaorg/cb-spider:v0.2.0-20200821
```

# 3. 기존 CB-Spider container 정지 및 삭제
```
sudo docker stop cb-spider
```
기존 CB-Spider run시 `--rm` 옵션를 추가하였기 때문에 정지하면 자동 삭제됨(4번 참고)

`--rm` **옵션에 대한 설명을 추가해주세요** 😃 

# 4. CB-Spider 컨테이너 구동
```
sudo docker run --rm -p 1024:1024 -p 2048:2048  -v /tmp/meta_db:/root/go/src/github.com/cloud-barista/cb-spider/meta_db --name cb-spider cloudbaristaorg/cb-spider:v0.2.0-20200821
```
`-v` 옵션 설명은 [<ins>여기</ins>](https://github.com/cb-contributhon/cb-coffeehouse/wiki/Docker-commands#use-volumes)참고

---
# * Reference
- [latest Guide](https://github.com/cloud-barista/cb-spider/wiki/Docker-based-Start-Guide)
