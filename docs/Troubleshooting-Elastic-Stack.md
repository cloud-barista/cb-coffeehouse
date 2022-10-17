## Troubleshooting Elastic Stack

#### 1 of 16 shards failed on Kibaba

Kibana interface에서 "1 of 16 shards failed" 이슈가 발생했을떄 해결방법 입니다. 

##### 1. ElasicSearch Shards 확인

```bash
curl http://localhost:9200/_cluster/health/?level=shards
```

##### 2. 상태(status) 값이 정상이 아닌 경우를 탐색한다

예시
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

##### 3. ElasticSearch에서 해당 인덱스를 삭제한다.


```bash
curl -X DELETE localhost:9200/filebeat-8.3.0-2022.10.14
```

보안이 활성화 된 경우
```
curl -u ID:PASSWARD -X DELETE localhost:9200/filebeat-8.3.0-2022.10.14
```

##### 4. 결과 확인 

```json
{
    "acknowledged": true
}
```

##### 5. ElasticSearch 재시작

```
sudo systemctl restart elasticsearch.service
```
