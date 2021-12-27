# Getting started with Amazon EKS
몇 가지 시행착오를 겪으며 Amazon EKS (Elastic Kubernetes Service)를 통해 Kubernetes (K8s) 클러스터를 생성한 내용을 정리합니다.

자세한 설명없이 순서만 쭉~ 정리하였는데요. 추후에 시간이 허락하면 설명 추가하겠습니다. (아래 내용 활용하시다가 필요한 설명을 적어주시면 더욱 좋습니다 👍 )

### 1. Amazon EKS 사이트 접속
링크: [Amazon Elastic Kubernetes Service(Amazon EKS)](https://aws.amazon.com/ko/eks/)

위 사이트에서 `Amazon EKS 시작하기`를 눌러 로그인을 하면 아래와 같은 화면을 볼 수 있습니다.

### 2. EKS 클러스터 생성
아래 그림의 우측 상단 부에 "클러스터 이름"(예, alvin-eks-cluster)을 입력하고 "다음 단계" 버튼을 누릅니다.

![image](https://user-images.githubusercontent.com/7975459/108996674-0431ef80-76e2-11eb-8fac-d8821b23b8e4.png)

### 3. Identity and Access Management (IAM) 역할 생성
아래 그림의 "클러스터 구성"의 3번째 항목에서 "클러스터 서비스 역할"을 요구하는데, `IAM 콘솔` 링크를 따라가 이를 생성합니다.
![image](https://user-images.githubusercontent.com/7975459/108997427-eb760980-76e2-11eb-8a9c-51b639654832.png)

`IAM 콘솔`에서 "역할 만들기"를 누릅니다.
![image](https://user-images.githubusercontent.com/7975459/108997809-69d2ab80-76e3-11eb-836b-43a6cfadd392.png)

아래 그림과 같이
1) "신뢰할 수 있는 유형의 개체 선택"에서 `AWS 서비스`를 선택합니다
2) "사용 사례 선택"에서 `EKS`를 선택합니다.
3) "사용 사례 선택"에서 `EKS - Cluster`를 선택합니다.
![image](https://user-images.githubusercontent.com/7975459/108998049-b322fb00-76e3-11eb-908a-6143a59b67ce.png)

이후 "권한", "태그" 부분은 `다음`을 눌러 넘어 갑니다.

"검토" 부분에서 "역할 이름"(예, alvin-eks-cluster-role)을 입력하고 `역할 만들기`를 클릭합니다.

### 4. Identity and Access Management (IAM) 역할 선택
"클러스터 구성" 페이지로 돌아가 "클러스터 서비스 역할"을 새로고침하고 방금 생성한 역할을 선택한 후 `다음`을 클릭합니다.

### 5. 네트워킹 지정 및 클러스터 엔드포인트 엑세스 설정
아래 그림의 "VPC", "서브넷", "보안 그룹"을 일일히 생성하여 지정하면 번거로울것 입니다. 그래서, [Amazon EKS 클러스터용 VPC 생성](https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/create-public-private-vpc.html)을 활용하여 편하게 진행해 보겠습니다.

1) 아래 그림의 "클러스터 엔드포인트 액세스"(퍼블릭, 퍼플릭 및 프라이빗, 프라이빗)를 어떤 것으로 지정할 것인지 결정 합니다.
2) 위 결정에 따라 [Amazon EKS 클러스터용 VPC 생성](https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/create-public-private-vpc.html)에서 3가지 가이드 중 맞는 가이드를 따라서 진행하시면 손쉽게 만들수 있습니다.

참고: "퍼블릭 및 프라이빗 서브넷"을 위한 Stack 생성 중 오류가 발생하였는데요. 아직 원인 파악을 못하였습니다..ㅠ

![image](https://user-images.githubusercontent.com/7975459/108999464-ae5f4680-76e5-11eb-9ddc-c81b6530943a.png)

### 6. 생성
5번 이후의 설정은 모두 다음을 누르고 클러스터를 생성하였습니다.

참고: 생성 후 Namespace 연결관련 오류가 있었는데요. Kubernetes 버전을 업그레이드하니 해결 되었습니다.

후기: Google Kubernetes Engine(GKE)는 쉽게 생성할 수 있는데 EKS는 복잡하네요..