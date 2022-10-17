## Troubleshooting Elastic Stack

#### 1 of 16 shards failed on Kibaba

Kibana interface에서 "1 of 16 shards failed" 이슈가 발생했을때 해결방법 입니다. 

- 1차 시도(실패): 문제가 있는 index 삭제후 재부팅하면 문제가 된다고 하여 시도했으나 해결되지 않음
- 2차 시도(실패): 노드 수, replicas 수, shards 수가 잘못 설정되면 발생 할 수 있다고하여 조정했으나 해결되지 않음
- 3차 시도(성공): 디스크 공간의 여유가 없을때(Running out of disk space) 발생 한다고 하여 시도하였고 해결되었음

1. 모든 Indices 정보 확인
```bash
curl localhost:9200/_cat/indices?pretty
```

2. 용량 큰 Index 제거
```bash
curl -X DELETE localhost:9200/filebeat-8.3.0-xxxxx
```

---

아래는 명령어 참고

##### ElasicSearch Shards 확인

```bash
curl http://localhost:9200/_cluster/health/?level=shards
```

결과 중 일부분
```json
            ...
        },
        "filebeat-8.3.0-2022.10.14": {
			"status": "red",
			"number_of_shards": 1,
			"number_of_replicas": 1,
			"active_primary_shards": 0,
			"active_shards": 0,
			"relocating_shards": 0,
			"initializing_shards": 0,
			"unassigned_shards": 2,
			"shards": {
				"0": {
					"status": "red",
					"primary_active": false,
					"active_shards": 0,
					"relocating_shards": 0,
					"initializing_shards": 0,
					"unassigned_shards": 2
				}
			}
		},
        ...
```

##### 인덱스 상태 확인
```bash
curl localhost:9200/_cat/indices?pretty
```

결과 중 일부분
```bash
green open filebeat-8.3.0-2022.09.23 yoyC0s6TT5Oa_5TDZ1-TXA 1 0 551124 0   465mb   465mb
green open filebeat-8.3.0-2022.09.20 3m8BmQdlQFqHGmvee2EoWw 1 0 609732 0 402.7mb 402.7mb
green open filebeat-8.3.0-2022.08.22 jB4LjyH9SKCRaLEDPCopTA 1 0    892 0 755.2kb 755.2kb
green open filebeat-8.3.0-2022.10.05 Ir7LyqcoRaqT92z5ZSgENA 1 0 501238 0 369.2mb 369.2mb
green open filebeat-8.3.0-2022.09.28 iC5UEwseSiGEDBCPcPj0lw 1 0   6705 0   5.5mb   5.5mb
green open filebeat-8.3.0-2022.09.02 XbUFm_BYS72XmBd5WqMsxw 1 0   1250 0 766.2kb 766.2kb
green open filebeat-8.3.0-2022.10.17 BNr-k2rIR7OwVq-hjFBLuA 1 0  32345 0  13.8mb  13.8mb
green open filebeat-8.3.0-2022.09.21 71z0Et0nSWicpCh8Z2Zvrw 1 0    532 0 781.1kb 781.1kb
green open filebeat-8.3.0-2022.09.13 PAsGxb-cR5m1GU4zJUQo8Q 1 0 181226 0  90.9mb  90.9mb
green open filebeat-8.3.0-2022.10.07 3aZxxwBjSQCh3f1WWsgJig 1 0 422353 0 191.9mb 191.9mb
```

##### ElasticSearch에서 인덱스를 삭제

```bash
curl -X DELETE localhost:9200/filebeat-8.3.0-xxxxx
```

보안이 활성화 된 경우
```
curl -u ID:PASSWARD -X DELETE localhost:9200/filebeat-8.3.0-xxxxx
```


##### Replica, Shards 수 조정

기존 Indices의 Replica 수를 수정
```bash
curl -XPUT "http://localhost:9200/filebeat-*/_settings" -H 'Content-Type: application/json' -d'
{
  "number_of_replicas": 0
}'
```

전체 적용으로 위해 Template을 수정
```bash
curl -XPUT "http://localhost:9200/_template/no-replicas" -H 'Content-Type: application/json' -d'
{
  "index_patterns": [
    "*"
  ],
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  }
}'
```
