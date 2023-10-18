
### 용어 정리 개요
#### 이슈 
- 유사하지만 의미가 조금씩 다른 용어들을 사용 중
- 다양한 분야에서 일반적으로 사용되는 용어들이기 때문에 명확한 의미 전달/소통의 어려움 발생

#### 목적
**명확한 소통을 위해 각 용어의 의미, 키워드, 예제, 쓰임새 등을 간단히 정리하고자 함**

### 이슈가 되는 용어

|  용어  |                                  활용 예                                   |
|:------:|:--------------------------------------------------------------------------:|
|  형상  |                         인프라/SW/데이터 형상 분석                         |
|  규격  | 워크플로우 규격, 소스/목표 모델 규격, 인프라/SW/데이터 소스/목표 모델 규격 |
|  모델  |          소스/목표 사용자 모델, 인프라/SW/데이터 사용자 정의 모델          |
| 템플릿 |                          사용자 워크플로우 템플릿                          |
| 스키마 |                           JSON 스키마, DB 스키마                           |
| 모델링 |                            워크플로우 웹 모델링                            |


Related article: 
- [모델링 관련 용어에 대한 ChatGPT 질의 및 결과](2023-10-18-ChatGPT-queries-for-modeling-related-terms.md) 
- 참고 - 일반적인 용어를 정리하기 때문에, ChatGPT를 활용해 봄 (+검색을 통한 보완)

### 용어 정리(안)

#### 형상 (Actual shape)

마이그레이션의 대상이 되는 실체 (컴퓨팅 인프라/SW/데이터 및 구성 요소나 상태를 나타냄)

- Keywords: 실체, 모습
- Examples: 실제 인프라, SW, 데이터

#### 규격 (Specification)

실체의 필요 속성/특성들에 대한 정의 및 설명 (실체의 일부분으로 시스템에서 사용하기 위한 정의 및 설명)

- Keywords: 속성, 정의, 설명, 요구사항
- Examples: Server spec, network spec, vm spec, OS spec, SW component spec, 등

#### 모델 (Model)

실체의 속성/특성을 바탕으로 만들어진 객체(key-value) 및 DB와 상호작용 하기 위한 로직

- Keywords: 객체, 구조, 로직, 동작
- Example: JSON object, Go stuct/object, 등

#### 템플릿 (Template)

모델(key-value)을 입력할 수 있도록 사전에 디자인된 형식, 패턴 또는 구조 (콘텐츠나 프로세스를 생성하기 위한 출발점으로 사용됨)

- Keywords: 형식, 패턴, 구조
- Example: Airflow DAG/Task/Operator, VM template, 등

#### 스키마 (Schema) 

데이터의 구조, 형식/규칙, 관계에 대한 정의 (데이터 유효성 검사, 저장, 검색 및 처리 등에 활용)

- Keywords: 구조, 형식/규칙, 관계, 유효성
- Examples: DB schema, XML schema, JSON schema, 등 (Go struct+validator)

#### 메트릭 (Metric)

현상이나 속성을 측정하기 위해 사용되는 척도 또는 측정 항목

- Keywords: 측정, 항목
- Examples: Monitoring metric (e.g., CPU utilization)

#### 모델링 (Modeling)

실체, 시스템, 프로세스, 또는 개념을 이해하거나 설명하기 위해 모델을 개발하는 과정

- Keywords: 과정, 프로세스
- Examples: 물리 서버 → 형상 분석 → 규격 정의 →  모델 생성


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