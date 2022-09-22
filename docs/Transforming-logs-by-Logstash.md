## Transforming logs with Logstash

이 글은 CB-Larva의 사례를 기반으로 Logstash를 활용하여 로그 메시지를 패턴화 및 변형하는 방법을 설명합니다.

관련된 전반적인 시스템 구조, 설명, 설치 방법 등은 아래 글을 참고하시기 바랍니다.

참고 - [Distributed logging by Elastic Stack](https://github.com/cloud-barista/cb-coffeehouse/blob/main/docs/Distributed-logging-by-Elastic-Stack.md): CB-Larva의 분산 로깅 적용기


### Background

CB-Larva에서 멀티클라우드 네트워크 시스템(cb-network system)에 Elastic Stack을 적용하여 분산된 서비스의 로그 정보를 유용하게 활용하고 있었습니다.
그런데, 몇몇 로그의 순서가 시간 순으로 정렬 되어있지 않아 서비스 동작 순서를 파악는데 이슈가 발생했습니다. 
Kibana interface에서 확인 결과 로그 메시지 상에 나타난 시간과 `@timestamp` 값이 상이하여 발생한 이슈였습니다. 
추측컨데 로그 메시지를 뭉치로 저장(Filebeat to Logstash / Logstash to Elasticsearch)할 때 찍히는 시간으로 보입니다.

Logstash가 Data processing에 특화되어 있어 이를 통해 해결하였습니다.
주요 작업은 로그 메시지 상에 나타난 시간을 추출하여 Field화 하는것 이었습니다.
로그 메시지 패턴화 및 변형에 대해서는 아래에서 조금 더 자세하게 설명하겠습니다.


### Introduction to Logstash filter plugin

Logstash에서는 Data processing을 위해 다양한 filter plugin을 활용할 수 있습니다.

Dissect를 통해 로그 메시지 상에 나타난 시간을 패턴화하는 것을 시작으로,
이를 마지막에 date type으로 Field화 하는 작업까지를 수행했습니다.

보통 이러한 작업을 수행하는 사람들은 Filter plugins 중 Dissect와 Grok를 많이 언급합니다.
Grok은 매우 유용하고, 정규식을 활용하여 다양한 처리가 가능하다고 합니다.
하지만, 다소 복잡하며 설정이 잘못될 경우 성능 이슈가 있다는 글을 함께 찾아볼 수 있었습니다.

이에 본 사례에서는 직관성이 높고 손쉽게 활용 가능한 Dissect filter를 적용 했습니다.
(우선은 직관적이고 신속하게 적용하는게 중요했습니다만.. 나중에 Grok으로 갈아탈지도 모르겠습니다 ^^;;)

Dissect와 관련한 설명과 예제를 찾아 해맨 끝에 다행히
[Test Tokenizer Patterns for the Dissect filter](https://dissect-tester.jorgelbg.me/)를 발견하여
조금은 수월하게 Pattern을 생성할 수 있었습니다.

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/191446958-551b952d-1aa8-47b4-bd62-6ec479e837d8.png" width="100%" height="100%" >
</p>


### Pattern generation for log transformation

먼저, Log Samples에 아래와 같은 클라우드바리스타의 로그 몇 개를 입력합니다.
```
[CB-SPIDER].[INFO]: 2022-09-21 10:10:00.4220 sample-with-config-path.go:40, main.main() - end.........
[controller-ccl6r6atiahsa211ovag].[DEBUG]: 2022-09-21 10:49:13.4720 controller.go:114, main.watchHostNetworkInformation() - Start.........
[agent-ccknnqobe3mu7divromg].[TRACE]: 2022-09-20 08:52:07 agent.go:651, main.getRuleType() - GetResponse size (bytes) [total size=249,header size=27,kvs size=222,kv 0=222]
```

그 다음 원하는 결과를 얻을 때까지 Pattern 부분을 바꿔 봅니다. 
- 참고 1 - 스페이스/띄어쓰기가 기본 공백으로 활용됩니다. 
- 참고 2 - 그 밖에 다른 문자들은 원본 로그의 패턴대로 입력해주면 됩니다.

결과:
```
[%{service_id}].[%{log_level}]: %{timestamp_nano} %{+timestamp_nano} %{function} %{+function} - %{log_message}
```

간단 의미 설명: 
- %{service_id}: "service_id: CB-SPIDER"와 같이 key: value 형태로 mapping 함
- %{timestamp_nano} %{+timestamp_nano}: "timestamp-nano: 2022-09-21 10:10:00.4220"와 같이 두 값을 하나로 연결하여 key: vlue 형태로 mapping 함



### Filter configuration on Logstash for log transformation

이전에 Beats -> Logstash -> Elasticsearch 파이프라인 생성을 위해 추가했던 설정 파일을 수정합니다.
Dissect 패턴화를 포함하여 Tranforming 관련 설정을 추가해 주면 됩니다. 
자세한 내용은 아래와 같습니다.

```bash
sudo vim /etc/logstash/conf.d/logstash-filebeat.conf
```

추가한 filter 내에 있는 plugin 들을 간단히 설명하면 다음과 같습니다.
- dissect: message를 패턴화
- mutate: 주로 변형 관련 작업, 여기서는 두 필드를 붙여 새로운 필드를 추가함
- date: string to date 변환 또는 시간 관련 정보 부여(e.g., timezone),  여기서는 기존 log_time에 부족한 timezone 정보 명시
- ruby: lot_time을 date type 으로 변환

**중요 - date type으로 저장해야 Kibana interface에서 시간순 정렬 가능합니다.**

변경 사항:
```diff
# Sample Logstash configuration for creating a simple
# Beats -> Logstash -> Elasticsearch pipeline.

input {
  beats {
    port => 5044
    host => "0.0.0.0"
  }
}

+filter {
+    dissect {
+        mapping => {
+            # [CB-SPIDER].[INFO]: 2022-09-21 10:10:00.4220 sample-with-config-path.go:40, main.main() - end.........
+            # [controller-ccl6r6atiahsa211ovag].[DEBUG]: 2022-09-21 10:49:13.4720 controller.go:114, main.watchHostNetworkInformation() - Start.........
+            # [agent-ccknnqobe3mu7divromg].[TRACE]: 2022-09-20 08:52:07 agent.go:651, main.getRuleType() - GetResponse size (bytes) [total size=249,header size=27,kvs size=222,kv 0=222]
+            "message" => "[%{service_id}].[%{log_level}]: %{log_ts1} %{log_ts2} %{function} %{+function} - %{log_message}"
+        }
+    }
+    mutate {
+        add_field => { "log_time_string" => "%{log_ts1} %{log_ts2}" }
+        add_field => { "log_time" => "%{log_ts1}T%{log_ts2}" }
+    }
+    date {
+        match => [ "log_time", "yyyy-MM-dd'T'HH:mm:ss.SSS" ]
+        timezone => "Asia/Seoul"
+        target => "log_time"
+    }
+    ruby {
+        code => "event.set('log_timestamp', LogStash::Timestamp.new(event.get('log_time')) )"
+    }
+}

output {
  elasticsearch {
    hosts => ["http://localhost:9200"]
    index => "%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}"
    #user => "elastic"
    #password => "changeme"
  }
}
```

적용 후 서비스 재시작
```
sudo systemctl daemon-reload
sudo systemctl restart logstash.service
```

#### Result

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/191512340-48be74e0-6531-46d8-adb2-adb4e858d7bd.png" width="100%" height="100%" >
</p>

`@timestamp`는 동일한 시간을 나타내고 있지만, `log_timestamp`는 각 로그를 기록한 시간이 잘 나타나 있습니다.
(하지만, Elastic Stack에서 Nanosecond 단위는 표현이 어려운 것 같아 보입니다. Nanosecond 까지 필요 없을지도 모릅니다 ^^;;)


이상 적용기를 마칩니다. 필요하신 분들께 조금이나마 도움이 되기를 희망합니다.
