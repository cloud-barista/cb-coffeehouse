# AWS Go SDK를 활용한 인스턴스(VM) 생성 팁
* AWS: Amazon Web Service
* SDK: Software Development Kit

본 가이드는 AWS Go SDK를 활용하여 프로그래밍을 통한 VM 생성 방법 및 과정을 설명합니다. 처음 접하시는 분들께 조금이나마 도움이 되기를 바랍니다.


## AWS Management Console 준비사항

**[준비사항 1 - IAM 사용자 등록]**

AWS Go SDK를 사용하려면 "프로그래밍 방식 액세스"가 가능한 사용자를 추가해야 합니다. 인증되지 않은 사용자가 AWS SDK를 사용하여 인스턴스를 생성한다면 문제가 되겠지요? <ins>그래서 AWS에서 제공하는 Identity and Access Management (IAM) 서비스에서 사용자를 등록하여 **액세스 키 ID (Access key ID)** 와 **비밀 엑세스 키 (Secrect access key)** 를 활성화해야 합니다.</ins>

활성화 하는 방법은 아래를 참고하시고, 생성된 Credentials은 잠시후에 필요합니다. :)
1. [AWS Management Console](https://aws.amazon.com/ko/console/)에 접속하여 로그인
2. 서비스 찾기에서 IAM (Identity and Access Management)을 검색하여 접속
3. [[AWS] IAM 사용자 추가와 aws cli 설정](https://jybaek.tistory.com/838)을 참조하여 사용자 생성
4. 생성된 Credentials(e.g. new_user_credentials.csv)를 다운로드


**[준비사항 2 - 키 페어 생성]**

또한, <ins>AWS Go SDK를 사용해서 인스턴스를 생성한 후 SSH로 접속하기 위해서 해당 인스턴스에 부여할 **Key Pair** 를 생성해야합니다.</ins>

KeyPair 생성 방법은 아래를 참고하세요 :)
1. [AWS Management Console](https://aws.amazon.com/ko/console/)에 접속하여 로그인
2. 서비스 찾기에서 EC2 (Elastic Compute Cloud)을 검색하여 접속
3. 좌측 메뉴에서 "네트워크 및 보안"하위 항목인 "키 페어"를 선택
4. 우측 상단에 "키 페어 생성" 클릭
5. 키 페어 이름을 입력하고, 파일 형식을 선택한 후 "키 페어 생성" 클릭
(저는 PuTTY를 사용하기 때문에 ppk 형식을 선택 했습니다. Linux 사용자는 pem 형식을 선택하세요.)


## AWS Go SDK를 활용한 인스턴스 생성 예제
인스턴스 생성 예제는 [Cloud-Barista Go Test](https://github.com/powerkimhub/go-test.git)를 기반으로 작성되었습니다.
[Go 개발 환경 및 Test](https://gist.github.com/powerkimhub/d1d6b260228746e14151685bbf2cdf03)와 [Echo 기반 REST 서비스 시험](https://github.com/cb-contributhon/cb-contributhon-2020/tree/master/w1/rest-server)을 통해 Go 환경을 구성 및 필요 패키지 추가 후 원활한 예제 진행이 가능합니다.


### 1. AWS SDK for Go 설치
```bash
$ go get github.com/aws/aws-sdk-go
```

### 2. Create credentials file, <ins>**[준비사항 1]의 사용자 Credential 필요**</ins>
```bash
$ mkdir $HOME/.aws
$ vim $HOME/.aws/credentials
```

Credentials (from new_user_credentials.csv)
```
[default]
aws_access_key_id = <YOUR_ACCESS_KEY_ID>
aws_secret_access_key = <YOUR_SECRET_ACCESS_KEY>
```

### 3. Create an instance by programming, <ins>**[준비사항 2]의 키 페어 필요**</ins>
예제 다운로드
```bash
$ go get github.com/powerkimhub/go-test
$ cd $GOPATH/src/github.com/powerkimhub/go-test/ec2_test
```

**[중요??!!!]** 아래 코드를 실행하기 전에 AWS에서 인스턴스를 생성하여 아래에서 사용하는 Region, ImageId, InstanceType, KeyName, SecurityGroupId, SubnetId를 참고하면 보다 쉽게 이해할 수 있습니다.
코드의 <YOUR_KEY_NAME> 부분에 키 이름을 입력하세요 :)
```go
package main

import (
    // import aws go sdk
    "github.com/aws/aws-sdk-go/aws"
    "github.com/aws/aws-sdk-go/aws/session"
    "github.com/aws/aws-sdk-go/service/ec2"
    // import logger
    "github.com/sirupsen/logrus"
    "github.com/cloud-barista/cb-log"

    // import formatted I/O (e.g., fmt.Println(xxx))
    "fmt"
)

var logger *logrus.Logger
func init(){
        // cblog is a global variable.
        logger = cblog.GetLogger("CB-Contribution")
}

func main() {
    sess, err := session.NewSession(&aws.Config{
        Region: aws.String("us-east-2")}, // ohio region
        // Region: aws.String("ap-northeast-2")}, // seoul region.
    )

    // Create EC2 service client
    svc := ec2.New(sess)

    // Specify the details of the instance that you want to create.
    runResult, err := svc.RunInstances(&ec2.RunInstancesInput{
        // An Amazon Linux AMI ID for t2.micro instances in the us-west-2 region
        // ImageId:      aws.String("ami-e7527ed7"),
        ImageId:      aws.String("ami-0bbe28eb2173f6167"),
        InstanceType: aws.String("t2.micro"),
        MinCount:     aws.Int64(1),
        MaxCount:     aws.Int64(1),
        KeyName:      aws.String("<YOUR_KEY_NAME>"),  // add keypair.
        SecurityGroupIds:      []*string{
                        aws.String("sg-00d75d1ab4f3fd997"),
                                        },                 // add security group.
        SubnetId: aws.String("subnet-969e9fec"),           // add subnet.
    })

    if err != nil {
        logger.Error("Could not create instance", err)
        return
    }

    fmt.Println("Created instance", *runResult.Instances[0].InstanceId)

    // Add tags to the created instance
    _, errtag := svc.CreateTags(&ec2.CreateTagsInput{
        Resources: []*string{runResult.Instances[0].InstanceId},
        Tags: []*ec2.Tag{
            {
                Key:   aws.String("Name"),
                Value: aws.String("VM-Alvin"),
            },
        },
    })
    if errtag != nil {
        logger.Error("Could not create tags for instance", runResult.Instances[0].InstanceId, errtag)
        return
    }

    logger.Info("Successfully tagged instance")
}
```


* References
   * [[AWS] IAM 사용자 추가와 aws cli 설정](https://jybaek.tistory.com/838)
   * [farMONI & AWS-SDK4GO](https://drive.google.com/file/d/1jpaP0f3tJ2p27GPCNkJ_M3S98rBFJRIK/view?usp=sharing)
