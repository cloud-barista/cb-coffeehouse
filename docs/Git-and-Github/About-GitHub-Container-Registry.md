# About GitHub Container Registry
GitHub Container Registry (for short GHCR)에 대하여 설명합니다. GHCR 이전에 GitHub Package Registry도 공개 되었고, 저는 처음에 이둘이 혼란스러웠기에 다른점도 함께 설명하고자 합니다.

GitHub Blog에서 GitHub Container Registry와 GitHub Package Registry를 모두 소개 하고 있습니다.
- [Introducing GitHub Container Registry](https://github.blog/2020-09-01-introducing-github-container-registry/) - published in September 1st, 2020
- [Introducing GitHub Package Registry](https://github.blog/2019-05-10-introducing-github-package-registry/) - published in May 10th, 2019


## Overview of GitHub Container Registry
Kayla Ngan에 따르면, 2019년 5월 10일부터 배포된 GitHub Packages를 통해 수억개의 패키지가 GitHub에서 다운로드 되었고, Docker 패키지가 두번째로 큰 생태계를 구성하였습니다(가장 큰 생태계는 npm). 한편 GitHub은 GitHub Packages가 이미 소프트웨어 개발 및 배포에 대한 우수한 추적성을 보여주고 있음에도 **개발자에게 제공하는 경험과 성능을 개선하기 위해 GitHub Container Registry 제공하고, 여기에 새로운 기능을 추가하고 있습니다.**

### Introducing GitHub Container Registry
**GHCR은 공개 이미지에 대해 무료** 입니다(베타 기간동안 비공개 이미지도 무료). GHCR은 GitHub Packages 내에서 컨테이너를 처리하는 방법을 개선하고 있으며, GitHub Actions와 함께 활용하면 보다 높은 시너지 효과를 나타낼 것으로 보입니다.

### The difference between GHCR and GitHub Packages Docker registry
GHCR 공개 1년 4개월 전에 GitHub Packages에서는 이미 Docker registry를 지원하고 있었고, 아래와 같은 상황으로 둘을 구분하여 이해하기 어려웠습니다.내용으로 인해 혼란스러웠습니다. 그래서, 둘의 차이를 간단히 보이고자 합니다.
- GitHub Packages 내에서 Docker registry를 지원함 (아래 그림1 참고)
- "GitHub Packages Docker registry"를 줄여 "Docker package registry"라고 하는 경우가 있음
- GHCR에 저장된 Container images를 개인 계정 또는 조직 계정의 Packages에서 확인 가능 (아래 그림2 참고)

| 그림 1   | 그림 2   |
|:--------:|:--------:|
| ![image](https://user-images.githubusercontent.com/7975459/95932099-df5d6f80-0e05-11eb-9a92-e36382456915.png) | ![image](https://user-images.githubusercontent.com/7975459/95932805-c5bd2780-0e07-11eb-9fc4-728108db9a0e.png) |


#### The difference of registry domain
| Registry                        | Host                  | Example URL                                       |
|:-------------------------------:|:--------------------: |:-------------------------------------------------:|
| GitHub Packages Docker registry | docker.pkg.github.com | docker.pkg.github.com/OWNER/REPOSITORY/IMAGE_NAME |
| GitHub Container Registry       | ghcr.io               | ghcr.io/OWNER/IMAGE_NAME                          |

From [Domain changes](https://docs.github.com/en/free-pro-team@latest/packages/getting-started-with-github-container-registry/migrating-to-github-container-registry-for-docker-images#domain-changes)


#### The difference in relation/position of registries

두 레지스트리는 아래와 같은 차이가 존재합니다.

- Packages registry: 패키지 레지스트리는 깃허브 저장소에 속함
- Container registry: 컨테이너 레지스트리는 개인 계정이나 조직(Organization)에 속함

따라서, GHCR은 Docker Hub를 이용할 때와 유사하게 저장소와 무관한 이미지 푸시가 가능합니다. 기능만 조금 추가 된다면 GHCR이 Docker Hub를 대체하는 서비스로서 자리매김 할지도 모릅니다.

**<ins>다음글 :arrow_forward: [Getting started with GitHub Container Registry](https://github.com/cb-contributhon/cb-coffeehouse/wiki/Getting-started-with-GitHub-Container-Registry)</ins>**