# Git branching and releasing strategy
Git을 활용한 프로젝트를 보면 `master`브랜치 하나만 있는 경우도 있고, `master` 브랜치, `develop` 브랜치 등 2개 이상의 브랜치를 운영하고 있는 경우도 있습니다. Distributed Version Control Systems (DVCS)인 Git을 활용하면 여러 사람이 동시에 개발할 수 있고, 협업의 효율을 높이기 위해 브랜치를 나누는 것입니다.

예를 들어, 개발팀에서 여러 사람이 협력하여 기술을 개발하기 위한 `develop` 브랜치와 `feature` 브랜치가 있고, 테스트 팀에서 배포를 준비하기 위한 `release` 브랜치가 있습니다. 이렇게 나눠 놓으면 테스트 팀에서 `release` 브랜치에서 배포를 위한 준비(테스트, 디버그 등)를 하고 있는 동안에도 개발팀은 계속 개발을 진행할 수 있습니다. (한 가지 예시로 디테일한 부분은 각 사, 각 프로젝트마다 다를 것 입니다 😄)

**이처럼, Git branching model이라고 불리는 <ins>Git 분기 전략과 배포 관리는 중요한 부분</ins> 입니다. 하지만, 정답이 있는것이 아니고 상황에 맞추어 적절히 수정가능 하기 때문에 처음 접하면 혼란 스럽기도 합니다. 그래서, 이를 간략히 설명하고자 합니다.**

<br>

## Branching strategy
2010년에 쓰여진 [A successful Git branching model](https://nvie.com/posts/a-successful-git-branching-model/)은 Git branching model에 있어 여전히 유명한 포스트 입니다. 포스트에 따르면, 브랜치의 종류를 크게 **주요 브랜치(Main branches)** 와 **보조 브랜치(Supporting branches)** 로 분류 하고 있습니다.

세부 브랜치를 우아한형제들의 나동호님께서 깔끔하게 잘 정리해주셨네요. 👍 
- `master` : 제품으로 출시될 수 있는 브랜치
- `develop` : 다음 출시 버전을 개발하는 브랜치
- `feature` : 기능을 개발하는 브랜치
- `release` : 이번 출시 버전을 준비하는 브랜치
- `hotfix` : 출시 버전에서 발생한 버그를 수정 하는 브랜치

추가로, Vincent Driessen가 남긴 메모(2020년 3월)가 중요하여 조금만 언급하고 넘어가겠습니다.

**요약: 10년이 지나고 소프트웨어 개발 패러다임이 빨라졌으니 상황에 맞추어 적절히 적용하는 것을 권장함**

Vicent는 제안한 git-flow를 많은 소프트웨어 팀에서 일종의 표준처럼 취급하기 시작하면서 인기를 얻었지만 만병통치약 처럼 사용하는데 안타까워 했습니다. 글을 쓴 이후로 10년이 지난 지금, 소프트웨어의 종류도 많이 달라졌기 떄문에 팀이 소프트웨어의 Continuous Delivery 제공하는 경우 git-flow를 적용하는 대신 훨씬 더 간단한 워크플로우 (like GitHub flow)를 채택하는 것이 좋다고 이야기 합니다. 그러나, 명시적으로 버전이 지정된 소프트웨어를 빌드하거나 여러 버전의 소프트웨어를 지원해야하는 경우 git-flow는 여전히 팀에 적합하다고도 합니다. 결론적으로 만병 통치약은 존재하지 않는 것과 자신의 상황을 고려하는 것을 항상 기억해야 한다고 합니다. 불편해하지 마시고, 스스로 결정하십시오.

<p align="center">
  <img src="https://nvie.com/img/git-model@2x.png" width="70%" height="70%">
</p>

출처: [Vincent Driessen, A successful Git branching model, 2010](https://nvie.com/posts/a-successful-git-branching-model/)

지금부터, 각 브랜치에 대하여 설명하겠습니다.

### 주요 브랜치(Main branches)
`master` 브랜치와 `develop` 브랜치는 저장소 존재하는 주요 브랜치 이고, **<ins>수명이 무한합니다.</ins>**

#### `master`
`master` 브랜치는 항상 배포 가능 상태(*Production-ready* state)인 소스 코드를 저장 및 관리하는 브랜치 입니다.

#### `develop`
`develop` 브랜치는 개발을 진행하는 브랜치로 최신 개발 변경 사항을 적용한 소스코드를 저장 및 관리하는 브랜치 입니다.


### 보조 브랜치(Supporting branches)
`feature` 브랜치, `release` 브랜치, `hotfix` 브랜치는 "팀 구성원 간의 병렬 개발", "기능 분기를 쉽게 추적", "배포 준비", "배포 후 문제 신속 해결"할 수 있도록 지원합니다. 주요 브랜치와 달리 이 브랜치는 **<ins>유한한 수명을 갖습니다.</ins>**

#### `feature` 
`feature` 브랜치(`topic` 브랜치라고도 함)는  새로운 기능 개발 또는 버그 수정을 위해 `develop` 브랜치에서 분기하는 브랜치 입니다. 개발이 완료 후 `develop` 브랜치로 병합(merge) 합니다.

#### `release`
`release` 브랜치는 배포를 준비하는 브랜치로 모든 기능이 정상적으로 동작하는지 확인합니다.   

**Branch naming convention: 주로 `release-*`을 따르며 `*`에는 버전 정보를 기입함** (버전에 관한 자세한 사항은 [Sementic Versioning](https://semver.org/)을 참고 바랍니다.)

> `release` 브랜치와 별개로 `develop` 브랜치에서 개발을 계속 진행합니다.

#### `hotfix`
`hotfix` 브랜치는 배포한 버전에 문제가 생겨 긴급한 수정이 필요할 떄, `master` 브랜치에서 분기하는 브랜치입니다.   

**Branch naming convention: 주로 `hotfix-`을 따름**

> 배포한 버전에서 매우 큰 문제가 발생하였는데, `develop` 브랜치에서 개발을 진행하고 있습니다. 이런때 `hotfix` 브랜치를 활용하여 빠르게 버그를 수정하고, `master` 브랜치에 병합(merge) 합니다. 이 변경사항은 `develop` 브랜치에도 병합(merge) 합니다.

<br>

## Releasing strategy
### 1. 배포 준비를 위한 브랜치 생성
아래 Branch naming convention을 준수하여 배포 준비를 위한 `release` 브랜치를 생성합니다. <ins>버전은 배포할 버전으로 설정 합니다.</ins>
- Branch naming convention: **`release-vMAJOR.MINOR.PATCH`** (예, `release-v0.0.1`, `release-v0.0.1`)

예를 들어, 이전 배포 버전이 v0.0.6(master branch의 tag 기준)이었고, 이번에 v0.1.0을 배포할 것이라면, `release-v0.1.0` 브랜치를 생성합니다.

### 2. 생성한 `release` 브랜치에서 배포 준비작업 수행
`release` 브랜치에서는 **오직 Bugfixes만을 수행**합니다. ***<ins>신규 기능을 개발하지 않습니다.</ins>***

Bugfixes는 지속적으로 `develop` 브랜치로 머지합니다.

배포 준비가 완료되면 `develop` 브랜치와 `master` 브랜치에 머지합니다.

### 3. 배포
아래 Tag naming convention을 준수하여 `master` 브랜치에 Tagging을 합니다. `-m` 옵션을 사용하면 commit과 마찬가지로 tagging시 제목과 설명을 입력할 수 있습니다. 
- Tag naming convention: **`vMAJOR.MINOR.PATCH`** (예, `v0.0.1`)

#### 참고사항 
**"GitHub의 Releases"** 는 웹페이지 상에서 "3.배포" 단계를 수행합니다. (`release` 브랜치와는 다릅니다. 저도 처음에 잘못 이해했어요 :sob:) 

Tagging, Release title, Description을 한 페이지에서 수행할 수 있습니다.

자세한 과정은 [Managing releases in a repository](https://docs.github.com/en/free-pro-team@latest/github/administering-a-repository/managing-releases-in-a-repository)을 참고 바랍니다.


### 4. 배포 후에 발생한 문제 처리
아래 Hotfix naming convention을 준수하여 `hotfix` 브랜치를 생성한 후 **신속하게 문제를 해결** 합니다. <ins>버전은 배포할 버전으로 설정 합니다.</ins> 처리 후에는 `develop` 브랜치와 `master` 브랜치에 머지 합니다.

- Hotfix naming convention: **`hotfix-vMAJOR.MINOR.PATCH`** (예, `hotfix-v0.0.1`)

**<ins>"배포" 과정을 꼭! 수행합니다.</ins>** (마지막 버전 +1 예, v0.1.0 -> v0.1.1)