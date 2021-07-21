# A structure of gRPC-applied microservices
gRPC는 구글이 마이크로서비스 아키텍처(Microservice Architecture (MSA))에서 매우 거대한 서비스를 운영하면서 겪는 문제를 해결하고자 Stubby라는 내부 프레임워크를 만들어 사용하다가 이를 오픈소스화 하면서 탄생하였습니다. 👍 
> 2,000,000,000 ? 구글이 1주일 동안 띄우는 컨테이너의 수   
> 10,000,000,000 ? 구글이 1초 동안 던지는 원격 호출의 수   
> \- [오명운, gㅏ벼운 RPC, gRPC(빠르고 가벼운 Polyglot RPC framework), 스프링캠프 2017 [Day1 B5]](https://youtu.be/sKWy7BJxIas)

gRPC 관련 많은 글에서 "마이크로서비스를 위한 프레임워크다", "마이크로서비스 스타일 아키텍처에 적용하기 좋다", "마이크로서비스의 성능을 향상시킬 수 있다" 라는 내용을 심심치않게 접할 수 있었습니다.

**하지만, "gRPC를 가지고 마이크로서비스를 구현하면 어떤 형상이 되는가?"에 대한 궁금증을 시원하게 해결해주는 글을 접하지 못하였습니다.** 😢 

그래서, 스터디를 통해 **<ins>"gRPC를 적용한 마이크로서비스의 구조"에 대해 이해한 바를 설명하고자 합니다.</ins>** 

다양한 포스트와 gRPC 관련 서적에서 내용, 구조, 소스코드를 스터디 하면서 많은 것을 알게 되었습니다. 포스트 저자 및 책 저자 및 옮긴이에게 감사의 말씀을 전합니다.

- 원서: gRPC: Up and Running by Kasun Indrasiri and Danesh Kuruppu (O'Reilly). Copyright 2020 Kasun Indrasiri and Danesh Kuruppu, 978-1-492-05833-5
- 번역서: gRPC 시작에서 운영까지(지은이: 카순 인드라시리, 다네쉬 쿠루푸, 옮긴이: 한성곤), 에이콘출판주식회사, 2021년 1월 4일 발행, 979-11-6175-463-5
- 참고 포스트: 제일 하단부에 정리하였습니다.

하지만, 실제 환경에 적용 및 테스트 한것이 아닌 스터디의 결과물 정도이니 참고 바라며, 정정할 부분이 있으면 말씀해주세요. 이후 실제 환경에 적용하면 환경정보, 소스코드와 함께 구조를 업데이트 하겠습니다. 😅

## gRPC 개요
사실 "개요를 정리해야하나?"라는 고민을 했는데요. 다른분들께서 gRPC 개요를 엄청 잘 작성해놓으셨기 때문에 생략하겠습니다. 아래 참고자료 중에서 입맛에 맞는 글을 보시기 바랍니다.

### gRPC의 장단점
"gRPC 시작에서 운영까지" 서적의 "프로세스간 통신의 역사" 부분에서 "gRPC의 장단점"을 조목조목 잘 정리해 놓았기에 이를 간단히 보이고자 합니다.

#### gRPC의 장점
- **프로세스 간 통신 효율성**: gRPC는 JSON이나 XML같은 사람이 읽을 수 있는(Humand-readable) 텍스트 대신 프로토콜 버퍼(Protocol buffer) 기반 바이너리 프로토콜을 사용해 gRPC 서비스 및 클라이언트와 통신함, HTTP/2 상에 구현됨
- **간단 명확한 서비스 인터페이스와 스키마**: gRPC는 애플리케이션 개발용 계약 우선(Contract-first) 접근 방식을 권장하여 서비스 인터페이스를 정의한 후 구현 세부사항을 작업하기 때문에 간단하고 일관되면서도 안정적인 확장 가능한 애플리케이션 개발 경험 제공
- **엄격한 타입 점검 형식**: gRPC 서비스 정의 시 프로토콜 버퍼를 사용하기 때문에 애플리케이션 간 통신에 사용할 데이터 타입이 명확하게 정의됨, 런타임과 상호운용 에러를 극복하는데 도움이 됨
- **폴리글랏**: 프로토콜 버퍼 기반의 gRPC 서비스는 특정 언어에 구애 받지 않음
- **이중 스트리밍**: gRPC는 클라리언트나 서버 측 스트리밍을 기본적으로 지원하므로 스트리밍 서비스나 스트리밍 클라이언트를 훨씬 쉽게 개발 가능
- **유용한 내장 기능 지원**: gRPC는 인증, 암호화, 복원력(데드라인과 타임아웃), 메타데이터 교환, 압축, 로드밸런싱, 서비스 검색 등과 같은 필수 기능을 기본적으로 지원
- **클라우드 네이티브 생태계와 통합**: gRPC는 CNCF의 일부이며 대부분의 최신 프레임워크(예, Envoy)와 기술은 gRPC를 기본적으로 지원함
- **성숙하고 널리 채택됨**: gRPC는 구글의 강력한 테스트를 통해 완성되었으며 스퀘어, 리프트, 넷플릭스, 도커, 시스코, CoreOS와 같은 주요 기술 회사에 채택됨

#### gRPC의 단점
- **외부 서비스 부적합**: 외부 사용자는 gRPC가 새롭기 때문에 적합하지 않을 수 있음, 계약 기반이면서 강력한 타입 속성을 갖는 gRPC 서비스는 외부 당사자에게 노출되는 서비스의 유연성을 방해할 수 있음
- **서비스 정의의 급격한 변경에 따른 개발 프로세스 복잡성**: gRPC 서비스 정의가 급격히 변경되면 클라이언트와 서버 코드 모두 다시 생성해야하고, CI 프로세스에 통합되야 하기 때문에 전체 개발 생명 주기를 복잡하게 할 수 있음 (주요 변경 사항이 없는한 다른 버전의 프로토를 사용해 문제없이 상호운용 할 수 있음)
- **상대적으로 작은 생태계**: gRPC 생태계는 기존 REST나 HTTP 프로토콜에 비해 상대적으로 작음

:pushpin: **<ins>[참고] gRPC 적용 포인트</ins>**: gRPC의 장점이 많지만 정해야할 규칙이 존재하기 때문에 API를 지원하는 내부 서비스 개발시 gRPC를 적용하고, 외부 서비스나 API에는 REST나 GraphQL을 사용해 구현하것이 좋겠다고 합니다. 

## gRPC와 마이크로서비스 아키텍처
우리가 많이 접하는 "클라이언트-서버 구조"에서 시작하여 한 단계식 설명을 진행해 보겠습니다. 

### 기본적인 클라이언트-서버 구조
가장 많이 접하는 클라이언트-서버 구조 입니다. 클라이언트가 Service A를 요청하면 서버가 응답 합니다.
<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/102491888-31479d80-40b4-11eb-9e6b-3a606e39405f.png" width="50%" height="50%">
</p>

### 클라이언트-gRPC 서버 구조
위 구조에 gRPC적용하였습니다. 클라이언트가 stub을 통해 Service A를 요청하면, gRPC 서버가 응답 합니다.
<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/102491989-5b995b00-40b4-11eb-8724-ba8d72a3d3a3.png" width="50%" height="50%">
</p>

### Service A를 Microservice a와 b로 분리한 구조
위 구조에서 Service A가 Microservice a와 b로 분리된다면 어떻게 될까요? 아래와 같은 구조로 변화할 것이고, 다음과 같은 순서로 작업을 진행할 것 입니다.
1. 클라이언트는 stub을 통해 Service A를 요청
2. (실제로 Backend에서는) Microservice a 제공을 위한 작업 시작
3. 작업 도중 stub을 통해 Microservice b를 요청
4. Microservice b 제공을 위한 작업 시작
5. Microservice b 응답
6. Microservice a 나머지 작업 수행
7. Microservice a 응답 (Service A 응답으로 봐도 무방)
8. 클라이언트는 Service A 결과 수신

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/102492026-65bb5980-40b4-11eb-8702-c3b36290ae99.png" width="80%" height="80%">
</p>

### gRPC를 적용한 마이크로서비스 구조
하지만, 마이크로서비스는 이렇게 정적인 구조가 아닙니다. 기본적으로 사용자 요청 부하에 따라 매우 동적으로 서비스 확장 및 축소(Autoscaling)를 수행하겠지요. 따라서, Microservice a와 b는 아래 구조와 같이 Endpoint 밑에 위치하여 동적 확장 및 축소(Autoscaling)을 반복할 것입니다. (아래 그림을 보실때 Endpoint를 LoadBalancer라고 생각하고 보셔도 괜찮습니다.)

1. 클라이언트는 stub을 통해 Endpoint로 Service A를 요청
2. Endpoint에서 적절한 gRPC 서버로 요청 전달
3. 요청을 전달받은 gRPC 서버에서 Microservice a 제공을 위한 작업 시작
4. 작업 도중 stub을 통해 Endpoint로 Microservice b를 요청
5. Enpoint에서 적절한 gRPC 서버로 요청 전달
4. 요청을 전달 받은 gRPC 서버에서 Microservice b 제공을 위한 작업 시작
5. Microservice b 응답
6. Microservice a 나머지 작업 수행
7. Microservice a 응답 (Service A 응답으로 봐도 무방)
8. 클라이언트는 Service A 결과 수신

(요청 응답을 위한 경로는 IP transparency, Proxy 등의 적용 유무에 따라 달라질 수 있기 때문에 표기하지 않았습니다.)

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/102492032-67851d00-40b4-11eb-9492-3f213bb4196c.png" width="100%" height="100%">
</p>


## 참고자료
### 공식 홈페이지
- [gRPC](https://grpc.io/about/)

### 책
- (번역서) gRPC 시작에서 운영까지(지은이: 카순 인드라시리, 다네쉬 쿠루푸, 옮긴이: 한성곤), 에이콘출판주식회사, 2021년 1월 4일 발행, 979-11-6175-463-5
   - (원서) gRPC: Up and Running by Kasun Indrasiri and Danesh Kuruppu (O'Reilly). Copyright 2020 Kasun Indrasiri and Danesh Kuruppu, 978-1-492-05833-5

### 영상
- [오명운, gㅏ벼운 RPC, gRPC(빠르고 가벼운 Polyglot RPC framework), 스프링캠프 2017 [Day1 B5]](https://youtu.be/sKWy7BJxIas)

### 슬라이드
- [Tim Burks, Usable APIs at Scale, 2019](https://www.slideshare.net/timburks/usable-apis-at-scale)

### 포스트/글
- [NAVER CLOUDPLATFORM, [NBP 기술&경험] 시대의 흐름, gRPC 깊게 파고들기 #1, 2020](https://medium.com/naver-cloud-platform/nbp-%EA%B8%B0%EC%88%A0-%EA%B2%BD%ED%97%98-%EC%8B%9C%EB%8C%80%EC%9D%98-%ED%9D%90%EB%A6%84-grpc-%EA%B9%8A%EA%B2%8C-%ED%8C%8C%EA%B3%A0%EB%93%A4%EA%B8%B0-1-39e97cb3460)
- [livlikwav, REST를 위협하는 gRPC의 등장배경과, HTTP/2를 비롯한 특징들, 2020](https://livlikwav.github.io/study/grpc-and-its-history/)
- [alice_k106, [Network] gRPC 기본 개념 및 사용 예시 (golang, python), gRPC의 Load Balancing, 2019](https://blog.naver.com/alice_k106/221617347519)
- [Chaewon Kong, gRPC의 출현배경과 특징, 2019](https://chaewonkong.github.io/posts/grpc.html)
- [James Newton-King, gRPC 서비스와 HTTP API 비교, 2019](https://docs.microsoft.com/ko-kr/aspnet/core/grpc/comparison?view=aspnetcore-5.0)
- [yundream, gRPC, 2019](https://www.joinc.co.kr/w/man/12/grpc)
- [디지털 세상을 만드는 아날로거, Microservices with gRPC, 2017](https://medium.com/@goinhacker/microservices-with-grpc-d504133d191d)
- [위키백과 - gRPC](https://ko.wikipedia.org/wiki/GRPC)
- [hoon.choi, GraphQL 개념잡기, 2019](https://tech.kakao.com/2019/08/01/graphql-basic/)