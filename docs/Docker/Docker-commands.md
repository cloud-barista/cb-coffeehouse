Docker를 쓰다보면 필요하지만 생각이 나지않아 검색하게 되는 Command 입니다. 자주 사용하는 다른 Command도 여기에 업데이트 해주세요. 😄

# Daemon으로 실행된 Container 접속

```
docker exec -it [CONTAINER ID] /bin/bash
```

- Reference
   - [docker container에 접속하기](https://bluese05.tistory.com/21)(Accessed on 13 May 2020)

---

# Host, Container 간 파일 복사

## Host to container
```
docker cp [HOST_PATH] [CONTAINER_NAME or CONTAINER_ID]:[CONTAINER_PATH]
```

## Container to host
```
docker cp [CONTAINER_NAME or CONTAINER_ID]:[CONTAINER_PATH] [HOST_PATH] 
```

- Reference
   - [docker cp - 호스트 컨테이너 사이 파일 복사](https://www.leafcats.com/163)(Accessed on 13 May 2020)

---

# Use volumes
According to [Docker docs](https://docs.docker.com/storage/volumes/), ```-v``` or ```--volume```: Consists of three fields, separated by colon characters (:). 
The fields must be in the correct order, and the meaning of each field is not immediately obvious.
- In the case of named volumes, the first field is the name of the volume, and is unique on a given host machine. For anonymous volumes, the first field is omitted.
- The second field is the path where the file or directory is mounted in the container.
- The third field is optional, and is a comma-separated list of options, such as ro. These options are discussed below.

```
docker run -d --name [CONTAINER_NAME] -v [HOST_PATH]:[CONTAINER_PATH] [IMAGE_NAME]
```

---

# Docker hub에 Container 업로드하기

- Reference
   - [docker container 커밋하기](https://nicewoong.github.io/development/2018/03/06/docker-commit-container/)(Accessed on 22 May 2020)