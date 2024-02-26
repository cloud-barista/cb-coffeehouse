# Key Pair의 이해

인스턴스 접근을 위해 사용하는 Key Pair가 갖는 의미를 설명합니다. 미션을 수행하며 Key Pair를 이용하셨던 분들께 도움이 되기를 바랍니다. (Public-key cryptography or asymmetric cryptography에 대한 상세 알고리즘은 다루지 않습니다.)


# 개요
Key Pair는 개인키(Private Key)와 공개키(Public Key) 쌍으로 구성된다.
- 개인키는 자신만이 가지고 있는 키로 공개되면 안되는 키 이고, 
- 공개키는 공개를 목적으로 개인키를 기반으로 만들어진 키로 공개한다.

Key Pair를 생성할때를 떠올려 보세요 😄 

Public Key는 Console에 등록하였고, Private Key는 다운 받아서 인스턴스 접속(**"인증"**)할때 사용하였습니다.


# Public Key와 Private Key가 갖는 의미
두 키는 상호보완적인 관계이다. 예를 들어, Public Key로 데이터를 암호화 하면 Private Key로 복호화 할 수 있고, Private Key로 데이터를 암호화 한다면 Public Key로 복화할 할 수 있다.

공개한 키(Public Key)와 공개하지 않은 키(Private Key)의 특성상 두 키는 조금다른 의미를 갖는다.

## Public Key - 암호화(데이터 보안)
**결론부터 말하면 Public Key를 통한 데이터 암호화는 "데이터 보안"에 중점을 둔다.**

예를 들어, 공개키는 공개되어 **1명 이상이 보유하고 있다.** <ins>아래 그림의 Bob이 Alice의 Public Key로 데이터를 암호화할 수 있고, 또 다른 Jack이 Alice의 Public Key로 데이터를 암호화할 수 있다.</ins>

하지만, **복호화 할 수 있는 사람은 오직 Alice 뿐이다.** 

따라서, Alice만 암호문을 복호화하여 볼 수 있기 때문에 Public Key 암호화는 데이터 보안에 사용된다.

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Public_key_encryption.svg/1920px-Public_key_encryption.svg.png" width="50%" height="50%">


## Private Key - 인증
**결론부터 말하면 Private Key를 통한 데이터 암호화는 "인증"에 중점을 둔다.**

예를 들어, 개인키는 공개하지 않고 **자신만 보유하고 있다.** <ins>아래 그림의 Alice 만이 Private Key로 데이터를 암호화해서 보낼 수 있고, 다른 사람이 데이터를 Alice의 Private Key로 데이터를 암호화해서 보내는 것은 불가능하다.(해킹 제외 😭)</ins>

Public Key를 가진 모든 사람이 Alice의 Private Key로 암호화한 데이터를 복호화 할 수 있다. 하지만, **해당 암호문을 전송할 수 있는 사람은 오직 Alice 뿐이다.**

따라서, Alice만 해당 암호문을 만들 수 있기 때문에 Public Key 암호화는 데이터 보안에 사용된다.

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Private_key_signing.svg/375px-Private_key_signing.svg.png" width="50%" height="50%">


Reference
- [Public-key cryptography](https://en.wikipedia.org/wiki/Public-key_cryptography)
- [공개키(Public Key) and 개인키(Private Key)](http://blog.naver.com/PostView.nhn?blogId=chodahi&logNo=221385524980)
- [SSH 접속을 위한 Key Pair 만들기](https://thekoguryo.github.io/oci/chapter03/3/)