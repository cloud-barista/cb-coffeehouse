# Good things to know when you develop software with Golang
Golang으로 소프트웨어를 개발할때 알아두면 좋은 내용 입니다.

## Package naming
According to the The Go Blog - Package names](https://blog.golang.org/package-names#TOC_2.),
> Good package names are short and clear. **They are lower case, with no `under_scores` or `mixedCaps`.** They are often simple nouns, such as:
> - time (provides functionality for measuring and displaying time)
> - list (implements a doubly linked list)
> - http (provides HTTP client and server implementations)

## 생성자 함수 구현
Golang은 Class가 없고, 구조체(`struct`)내에 함수를 구현할 수 없습니다. 따라서, 별도의 방법으로 생성자(Constructor)를 만드는 방법을 설명합니다.
이는 C++가 나오기 전, C에서 구조체와 함수를 가지고 사용하던 방식과 유사하다고 생각합니다.

본래 생성자는 인스턴스의 초기 작업을 담당합니다. **변수 초기화** 뿐만 아니라, **메모리 할당**, **연결 확인** 등 인스턴스가 온전히 활용되기 위해 필요한 모든 작업을 수행합니다. 따라서, 인터넷 상의 구조체 생성 및 변수 초기화 만을 수행하는 방법은 제외하였고, 아래와 같은 예를 통해 Golang 생성자 만드는 방법을 설명합니다.

```go
package main

import "fmt"

type Speaker struct {
	textOfSpeech string
}

func (s Speaker) GiveATalk(){
	fmt.Println(s.textOfSpeech)
}

func (s *Speaker) writeTextOfSpeech(){
	s.textOfSpeech = "Hello, I'm Alvin. ~~~~~"
}

//생성자 함수 정의
func NewSpeaker() *Speaker {
	s := &Speaker{}
	s.writeTextOfSpeech()
	return s //포인터 전달
}

func main() {
	s := NewSpeaker() // 생성자 호출
	s.GiveATalk()
}
```
- Speaker를 생성하면 연설문을 쓴 후에 연설을 할 수가 있습니다.
- 그런데 Golang 문법으로는 이를 수행하기 어렵기 때문에 (유사) 생성자 함수, `NewSpeaker()`를 정의 하였습니다.
- main 구문에서  `NewSpeaker()` 호출하여 Speaker 인스턴스를 생성하면, 내부에서는 인스턴스 `Speaker`인스턴스를 생성하고, 연설문을 작성한후 리턴(포인터)합니다.
- 이상 Golang표 (유사) 생성자 함수 만드는 법이었습니다 😄 