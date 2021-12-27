# 예제를 통해 이해해보는 Logging level
개발 시 로깅은 필수 사항입니다. 그런데 막상 적용하려고 보면 다양한 Logging level로 인해 어떻게 로깅해야 할지 혼란스럽습니다. 😭 그래서, 다양한 예제를 통해 Logging level를 이해해보고자 합니다.

**Logging level의 맥락을 파악하는 정도로 활용하시고, 유연하게 Logging level을 적용하시면 좋겠습니다.** 👍  

## Logging level
Golang logrus의 Logging level을 바탕으로 작성하였습니다.

### Logging을 수행하는 범위(?)
Trace가 가장 많은 로깅 정보를 보여주기 때문에 아래와 같이 나타내 보았습니다.

Trace > Debug > Info > Warn > Error > Fatal > Panic

예를 들어, Logging level을 Info로 설정 시 Info, Warn, Error, Fatal, Panic에 대한 로깅을 수행합니다.

- Trace: 
  - 변수 값, 
  - 변수의 주소 값/참조 대상,
  - 메시지(Text, JSON, etc.), 등
- Debug: 
  - 함수의 시작과 끝,
  - 디버깅에 필요한 동작 과정,
  - 디버깅에 필요한 이벤트, 등
- Info: 
  - 서비스의 동작 상태,
  - 정보성 메시지(e.g., cb-network is running),
  - 특정한 Event 알림,
  - 긴 시간이 걸리는 작업(DB 동기화),
  - 상태 변경, 등
- Warn: 
  - 경고성 메시지
  - 실수한 경우(e.g., 날짜를 잘못 입력: yyyy-MM-dd인데 2021-1-21로 입력), 
  - 추후 Error의 원인이 될 수 있는 상황(스토리지 사용량이 75%를 초과함), 등
- Error: 
  - 요청을 처리하는 중 문제가 발생한 경우
  - DB연결 실패, 
  - 파일 열기 실패, 등
  - (의도하지 않은 오류이기 때문에 알림 필수이고, 바로 확인 가능한 문자, 카카오톡, 텔레그램 등을 권장)
- Fatal(비추천):
  - 긴급하게 작업을 중단해야할 때
  - 로그를 남기고 바로 Application을 종료함(os. Exit(1))
  - defer function 수행 X
- Panic(추천):
  - 정상적인 중단을 위해 필요한 과정을 단계적으로 수행하고 중단할 때
  1. Function 수행을 즉시 중단
  2. defer function을 수행함
  3. caller function에 리턴함
  4. caller function이 i ~ iii 을 반복 수행하고
  5. 애플리케이션을 종료함 

## References
- [Level logging](https://github.com/sirupsen/logrus#level-logging) from logrus
- [The difference between golang's log.Fatal() and panic() functions](https://www.programmersought.com/article/9019804586/)
- [log4j 로그레벨](https://mdj1234.tistory.com/63)
- [로그 레벨은어떻게 정하시나요?](https://kldp.org/node/118779)
- [[JAVA] log4j Level 설정](https://myblog.opendocs.co.kr/archives/950)