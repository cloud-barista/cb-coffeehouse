
### 용어 정리의 배경

유사하면서도 조금씩 다르게 받아들일 수 있는 용어들을 사용 중이다. 이러한 용어들은 다양한 분야에서 일반적으로 사용되고 있기도 하고, 실제로 그 조금의 차이로 인해 명확한 의미 전달/소통의 어려움 발생했다. 모두를 만족하기는 어렵겠으나, 그럼에도 소통에 도움이 되기를 바라는 마음으로 간략히 정리해 보고자 한다. 

**기여/의견 수렴을 통해 앞으로도 개선되기를 바란다. Contributions are always welcome!**

#### 목적
1. **명확한 소통을 위해 각 용어의 의미, 키워드, 예제, 쓰임새 등을 간단히 정리하고자 함**
2. (TBD) 구체적인 사례/예시 추가 예정

### 활용 중인 용어

현재 활용하고 있는 용어 및 활용 사례는 아래와 같으며, 아래 용어들을 포함하는 범위/도메인으로 용어 정리의 범위를 한정하고자 한다.

|   용어    |                                              활용 사례                                               |
|:---------:|:----------------------------------------------------------------------------------------------------:|
|  모델링   |     워크플로우 웹 모델링, 컴퓨팅 인프라 전환 웹 모델링, SW 전환 웹 모델링, 데이터 전환 웹 모델링     |
|   형상    |                               인프라/SW/데이터 형상 분석 및 정보 수집                                |
|   모델    |              소스/목표 사용자 모델 등록 및 관리, 인프라/SW/데이터 사용자 정의 모델 검증              |
|  스키마   |                                        JSON 스키마, DB 스키마                                        |
|  템플릿   |                                사용자 워크플로우 복제 및 템플릿 관리                                 |
|  메트릭   |                                인프라/SW/데이터 형상 분석 메트릭 정의                                |
| 규격 정의 | 인프라/SW/데이터 소스/목표 모델 규격 정의 및 관리, 소스/목표 모델 규격 정의 및 관리, 워크플로우 규격 |


### 용어 정리(안)

많이 알려진 일반적인 용어를 정리하기 때문에, ChatGPT를 활용해 뼈대를 만들고, 검색을 통해 보완하였다.
- [모델링 관련 용어에 대한 ChatGPT 질의 및 결과](2023-10-18-ChatGPT-queries-for-modeling-related-terms.md) 

#### 모델링 (Modeling)

일반적으로, 시스템, 프로세스, 또는 개념 등의 실체를 이해하거나 설명하기 위한 모델을 도출하는 과정

- 키워드: 과정, 프로세스
- 활용 예: 
	- 컴퓨팅 인프라 전환 웹 모델링, 
	- SW 전환 웹 모델링, 
	- 데이터 전환 웹 모델링, 
	- 워크플로우 웹 모델링
- 과정/프로세스 예: 
	- 물리 서버 → 물리 서버 형상 분석 → 물리 서버 규격 정의 →  물리 서버 모델 도출

#### 형상

클라우드 마이그레이션의 대상이 되는 실체 (컴퓨팅 인프라/SW/데이터, 구성 요소 및 상태를 나타냄)

- 키워드: 대상, 실체
- 활용 예: 
	- 인프라/SW/데이터 형상 분석 및 정보 수집
- 형상의 예:
	- 인프라 형상: CPU, Memory, Disk, Network, Firewall, GPU, OS, 등
	- 소프트웨어 형상: SW/Packages, 의존성, 등 
	- 데이터 형상: 데이터 타입(정형/비정형/반정형), 규모, 암호화, 인증, 의존성, 등

#### 모델 (Model)

클라우드 마이그레이션 대상 자원/서비스(즉, 형상/실체) 분석 및 규격(속성/특성) 정의를 바탕으로 만들어진 모형 및 로직 

(템플릿과 구분을 위한) 주 목적: 모형을 나타내는 데이터를 시스템 내에서 효과적으로 조직하고, 관리하며, 처리하는 것

- 키워드: 모형, 구조, 로직, 동작
- 활용 예: 
	- 소스/목표 모델 규격 정의 및 버전 관리, 
	- 소스/목표 사용자 모델 등록 및 관리, 
	- 인프라/SW/데이터 사용자 정의 모델 검증
- 모델 예: 
	- VPC struct/instance/object in a programming language (e.g., Go),
		```go
		type VPC struct {
			NameId   string `json:"nameId"  yaml:"nameId"`
			IPv4CIDR string `json:"iPv4CIDR"  yaml:"iPv4CIDR"`
			Subnets  []struct {
				NameId   string `json:"nameId"  yaml:"nameId"`
				IPv4CIDR string `json:"iPv4CIDR"  yaml:"iPv4CIDR"`
			} `json:"subnets"  yaml:"subnets"`
		}
		```

		```go
		vpc := &infra.VPC{
			NameId:   "vpc-01",
			IPv4CIDR: "192.168.0.0/16",
			Subnets: []struct {
				NameId   string "json:\"nameId\"  yaml:\"nameId\""
				IPv4CIDR string "json:\"iPv4CIDR\"  yaml:\"iPv4CIDR\""
			}{
				{"subnet-01", "192.168.0.0/24"},
				{"subnet-02", "192.168.1.0/24"},
			},
		}
		```
 
	 - JSON string/object,
		```json
		{
			"nameId": "",
			"iPv4CIDR": "",
			"subnets": [
				{
					"nameId": "",
					"iPv4CIDR": ""
				},
				{
					"nameId": "",
					"iPv4CIDR": ""
				}
			]
		}		
		```

		```json
		{
			"nameId": "vpc-01",
			"iPv4CIDR": "192.168.0.0/16",
			"subnets": [
				{
					"nameId": "subnet-01",
					"iPv4CIDR": "192.168.0.0./24"
				},
				{
					"nameId": "subnet-02",
					"iPv4CIDR": "192.168.1.0./24"
				}
			]
		}		
		```

#### 템플릿 (Template)

클라우드 마이그레이션에서 일련의 작업이나 프로세스를 표준화하고 자동화하기 위해 사전에 디자인된 형식, 패턴 또는 구조

(모델과 구분을 위한) 주 목적: 반복적인 작업을 최소화하고 효율성을 높이며, 일관된 디자인과 레이아웃을 유지하는 것

- 키워드: 표준화, 자동화, 형식, 패턴, 구조
- 활용 예: 워크플로우 복제 및 템플릿 관리
- 템플릿 예: 
	- Airflow DAG/Task/Operator, VM template, 등
	- (조금 더 구체적인 예시 추가 필요)

#### 스키마 (Schema) 

클라우드 마이그레이션에서 사용되는 데이터의 구조, 형식/규칙, 관계에 대한 정의 (데이터 유효성 검사, 저장, 검색 및 처리 등에 활용)

- 키워드: 구조, 형식/규칙, 관계, 유효성
- 활용 예: 
- 스키마 예: 
	- DB schema, 
	- XML schema, 
	- JSON schema, 등 
- 참고:
	- Go struct+validator 를 통한 유효성 검증 가능

#### 메트릭 (Metric)

마이그레이션의 대상이 되는 실체의 형상/현상/속성을 측정하기 위해 사용되는 척도 또는 측정 항목

(인프라 모델이 형상 분석에 활용되는 경우, 인프라 형상 분석 메트릭으로 활용 가능)

- 키워드 : 측정, 항목
- 활용 예: 인프라/SW/데이터 형상 분석 메트릭 정의
- 메트릭 예:
	- Monitoring metric (e.g., CPU utilization), 
	- 인프라 형상 분석 메트릭


#### 기타

##### 규격 정의

형상(실체)을 나타내기 위한 속성/특성을 정의 및 설명하는 행위 (시스템에서 필요한 만큼의 속성/특성을 포함)

- 키워드: 속성, 특성, 설명, 요구사항
- 활용 예: 인프라/SW/데이터 소스/목표 모델 규격 정의 및 관리, 소스/목표 모델 규격 정의 및 버전 관리, 워크플로우 규격 정의 및 버전 관리
- 규격의 예: Server spec, network spec, vm spec, OS spec, SW component spec, 등


### References:
- https://chat.openai.com/
- https://docs.oracle.com/cd/E19528-01/820-2195/afxbs/index.html
- https://brownbears.tistory.com/588
- https://www.tutorialspoint.com/mvc_framework/mvc_framework_introduction.htm
- https://www.youtube.com/watch?v=y8NwhdEGY4A
- https://www.tcpschool.com/json/json_schema_schema
- https://h2o.ai/wiki/ai-models/
- https://www.ibm.com/kr-ko/topics/database-schema
- https://gfx.cs.princeton.edu/pubs/Funkhouser_2004_MBE/index.php
- https://csis.pace.edu/~marchese/CS389/L5/Chap5_summary.pdf
- https://learn.microsoft.com/ko-kr/dotnet/core/diagnostics/metrics