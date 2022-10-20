# Deep Learning using PyTorch

단기간에 딥러닝 프로그래밍 개념과 방법을 익히고, 이를 멀티클라우드/분산클라우드에서 분산 처리할 수 있는 포인트를 찾아보고자 1주일 동안 "PyTorch를 활용한 Deep Learning"을 수강하였습니다.

구현 중심의 강좌를 수강하면서 기존에 추상적으로만 알고 있던 개념들을 구체적으로 들여다보며 딥러닝에 대한 이해 폭을 넓힐 수 있었습니다. 
혼자 스터디했다면 기존에 가지고 있던 고정관념 또는 개념 때문에 한참 동안 시행착오를 겪었을 것 같은데 이를 무사히 지나온 것 같기도 합니다.
그래서, 생각을 바꿔준 내용을 중점적으로 정리해 보고자 합니다. 

초심자로서 서술한 내용이라서 잘못된 부분이 많을 것 같습니다. 
개선이 필요한 부분이 있다면 편하게 의견을 남겨 주시기 바랍니다. ^^

참고: [(강좌 실습 내용) PyTorch를 활용한 Deep Learning](https://github.com/yunkon-kim/course-deep-learning-using-pytorch): 실습한 Jupyter Notebook 파일과 이를 다운받은 Python 파일이 포함됨

## 프로그래밍을 통해 이해하는 Machine Learning 기본 개념

구현과 이론을 함께 이해해 보는 차원에서 Python 레벨 Machine Learning 프로그래밍과 기본 개념을 함께 살펴보겠습니다.
(대학 시절 자료구조 강의에서 Double linked list를 직접 코딩하면서 배운 기억이 떠오르네요 :sweat_smile:)

### Math, engineering approach, and machine learning

Machine learning (ML)을 처음 접했을 때도, 또한 이번 강좌에서도 가장 먼저 만나게 된 것은 아래 수식이었습니다. ( $w$ : Weight, $b$ : Bias )

$$h(x) = w x + b$$

Hypothesis(가설)이라 불리는 이 수식을 방정식 또는 데이터를 토대로 도출한 것 정도로 지극히 추상적으로 바라봤는데요.
강좌를 들은 후 다른 관점으로 보게 되었습니다. 
전에는 몇 개의 $w$, $b$ 쌍을 주고 $x$, $y$를 찾는 것으로 생각했던 것을 
지금은 데이터라는 많은 수의 $x$, $y$ 쌍을 줬을 때 $w$, $b$를 찾는 것이라고 이해할 수 있습니다.

예를 들어, 기존에는 세 점 (1, 2), (2, 3), (3, 4)가 주어졌을 때, 우리는 주어진 세 점을 분석하여 $y = x + 1$라는 수식을 찾아내고, 이를 프로그래밍에 활용했습니다.
지금은 세 점 (1, 2), (2, 3), (3, 4)과 가설 $y = w x + b$을 입력해주고 컴퓨터 프로그램이 학습을 통해 만족하는 $w$와 $b$를 찾아내고, 이를 프로그램에 활용하는 방식으로 달라진 것이랄까요?

한편으로는 "새로운 문제 풀이 방법론, 역할, 생태계가 추가되었구나!"라는 생각마저 들었습니다 ^^;; 
기존에는 수학자가 현상/데이터를 분석하여 적절한 수식을 도출하거나, 개발자가 엔지니어링 접근법을 통해 적절한 수식 $x$를 찾고, 이를 프로그래밍에서 사용했다면, 
이제는 데이터 분석가가 데이터를 분석 및 정제하고 입/출력 데이터와 대략적인 수식(가설, hypothesis)을 입력하면 학습을 통해 적절한 수식 도출하여 프로그램에서 활용할 수 있게 된 것 같습니다. 
설레발이 길었네요 ^^;; 요지는 두 가지 방식 모두 장단점이 있어서 적재적소에 활용해야 할 것으로 보입니다.


### 실습 1 - Python-level programming

Machine Learning 프로그래밍에 도움을 주는 패키지를 활용하지 않은 Python 레벨의 매우 원시적인(?) 소스 코드입니다.

제가 이해한 Machine Learning 목표는 데이터와 가설이 주어졌을 때 모든 데이터에 부합하는 수식을 찾는 것입니다.
가지고 있는 데이터는 정답을 나타내고, 가설을 거듭 수정하여 정답에 부합하는 수식을 찾는 것입니다.
정답 데이터와 가설을 통해 얻는 데이터의 차이를 Cost라고 합니다.

예제를 보시겠습니다.
- 목표: (1, 1), (2, 2), (3, 3)이 주어졌을 때 이를 만족하는 수식을 찾는 것입니다. 
- 과정: w를 변경하면서 입력한 정답 데이터와 가설의 차이가 가장 적은 최적의 w를 구하고 있습니다.
- 설명: Machine Learning 프로그래밍을 통해 정답 $y = 1 \times x$을 찾는 방법을 알아보겠습니다.

```python
import matplotlib.pyplot as plt
import numpy as np


# (1, 1), (2, 2), (3, 3)을 아래와 같이 나타낼 수 있습니다.
# 입력 x=1 일 때 출력 y=1, 입력 x=2일 때 출력 y=2, 등
# 이것은 알고 있는 정답입니다.
x_data = [1,2,3]
y_data = [1,2,3]


# 이를 차트로 나타냅니다. (아래 왼쪽 차트 참고)
plt.xlim(0,5)
plt.ylim(0,5)
plt.scatter(x_data,y_data)
plt.show()

# 가설을 세웁니다. hx = w * x 
# Cost function을 정의합니다. 
# Cost function은 가설에 따라 추측한 답이, 정답과 얼마나 차이가 나는지 계산하는 함수입니다.
# 여기서는 Cost를 최저로 만드는 w를 찾는 것이 목표입니다.
# 이를 위해 추측한 답과 정답의 차이인 error 제곱의 평균을 계산합니다. 이것을 Mean Squared Error (MSE)
# Cost를 최저로 만드는 w를 찾는 것이 목표이므로 Least mean Square Error(LMS)로 나타내기도 합니다.

# 코드상으로 보면,
# 입력된 w를 바탕으로 가설에 x[i]를 입력해 예측값 hx를 얻고, 
# 예측값 hx와 y[i]의 차이를 제곱하여 c에 더합니다.
# 모든 데이터에 대해 이를 수행하고, c를 입력 데이터의 수로 나누어 평균을 구합니다. (MSE)
def cost(x,y,w):
    c=0
    for i in range (len(x)):
        hx = w*x[i]
        c = c + (hx-y[i])**2
    return c/len(x)

# w가 각각 -1, 0, 1, 2 일 때 cost를 구하고, 이를 출력합니다.
# 목표가 최저의 Cost를 구하는 것(Least mean Square Error(LMS)) 이므로 cost가 0이면 구한 것입니다.
print(cost(x_data,y_data, -1))
print(cost(x_data,y_data, 0))
print(cost(x_data,y_data, 1))
print(cost(x_data,y_data, 2))


# np.linspace(-3, 5, 50) # -3~5 사이에 같은 간격의 50개의 값을 생성함
# 다음은 Engineering approach를 통해 최적의 w를 찾는 내용입니다.
for w in np.linspace(-3, 5, 50):
    c = cost(x_data, y_data, w)
    print('w', w, 'cost=', c)
    plt.plot(w, c, 'ro') # r: red, o: circle marker # plt.scatter(w,c)

# w의 변화에 따른 cost(mse)를 차트로 보여줍니다. (아래 오른쪽 차트 참고)
plt.xlabel('w')
plt.ylabel('cost(mse)')
plt.show()

```

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/195261247-ba34560c-af0b-40c3-8952-f5b81e684502.png" width="45%" height="45%" />
  <img src="https://user-images.githubusercontent.com/7975459/195261332-6b6eb875-c100-4dca-951d-c7d180253085.png" width="45%" height="45%" />
</p>

### Cost function과 Loss function의 미묘한 차이

**요약하자면, 개별적으로 봤을 때는 loss, 전체적으로 봤을 때는 cost입니다.**

사실 둘의 의미 차이를 크게 두고 있지 않은 것 같습니다. 
그렇지만, PyTorch를 활용하다 보니 `loss_fn` 같은 loss와 관련된 명칭이 종종 등장했습니다.
이로 인해, 개념과 소스 코드를 매칭해서 이해하기 어려웠습니다.
그래서 둘의 미묘한 차이를 짚고 넘어가겠습니다.

주석으로 설명해 드린 것처럼 Cost function은 가설에 따라 추측한 답과 알고 있는 정답 간에 얼마만큼 차이가 나는지 계산하는 함수입니다.
계산하는 과정에서 각 i에 따라 `(hx-y[i])**2`가 나타내는 값이 있는데 이를 (개별적인) loss라고 볼 수 있고,
loss를 합산하여 전체 평균을 내면 이를 (전체적인) cost라고 볼 수 있겠습니다.

### 효과적으로 최적 지점에 도달하기 위한 Gradient Descent algorithm

위 실습에서는 w의 변화량을 일정하게 하여 최저 cost를 구했습니다.
한편 w의 변화량을 달리하여 효과적으로 최저 cost를 찾아갈 수 있도록 Gradient Descent algorithm을 활용하고 있습니다.
이름에도 나타나 있듯이 Gradient (경사도)를 활용하는 방법입니다.

MSE를 적용한 Cost function 그래프(위 우측 그림)를 보면 포물선 형태를 띠게 되는데요. 
최초 w에서 나타내는 지점에 대한 미분 값, 즉 기울기를 활용합니다.
얻어낸 기울기에 학습률(Learning rate) 또는 보폭(Step size)이라 불리는 스칼라를 곱해 다음 w 값을 결정합니다.
아래 그림 설명을 참고하시기 바랍니다.

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/195480046-76feca57-13a8-477d-a62f-55df1f59d05c.png" width="70%" height="70%" />
</p>

Source: [Rekha M, The Ascent of Gradient Descent](https://blog.clairvoyantsoft.com/the-ascent-of-gradient-descent-23356390836f)

이때, 적절한 Learning rate를 설정해야 합니다.
Learning rate 크기에 따른 현상은 아래 그림을 참고하시기 바랍니다.

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/195505107-e26b937f-f2a8-4e65-acae-a6eb9db8a39a.png" width="70%" height="70%" />
</p>

Source: [Jeremy Jordan, Setting the learning rate of your neural network](https://www.jeremyjordan.me/nn-learning-rate/)

먼저, Gradient Descent를 적용한 소스 코드를 보시겠습니다.

```python
# 위 실습의 설명 참고
def cost(x,y,w):
    c=0
    for i in range (len(x)):
        hx = w*x[i]
        c = c + (hx-y[i])**2
    return c/len(x)

# 기울기를 사용한 w 평균 변화량을 구하는 함수
def gradient(x,y,w):
    c=0
    for i in range (len(x)):
        hx = w*x[i]
        c = c + (hx-y[i])*x[i]
    return c/len(x)

# 초기값/설정값: w=10, 반복 횟수=200, learning_rate=0.1
# 200회를 수행하여 최종 w를 도출
w = 10
for epoch in range(200):
    c = cost(x_data, y_data, w)
    print('epoch:', epoch, 'cost=', c, 'w=', w)
    g = gradient(x_data, y_data, w)
    w = w - 0.1 * g
print('최종 w: ', w)

```

합성함수 미분을 통해 Loss function `(hx-y[i])**2`의 기울기를 구하면 (`hx = w*x[i]`),
`(hx-y[i])*x[i]`을 도출할 수 있습니다. (상수는 영향력이 미비하여 날린 것일까요? :thinking:)

(합성함수 미분을 하고..... Forward propagation과 관련있고.... 명확하게 설명하기 어려워 우선 넘어가겠습니다 :sweat_smile:)

gradient 함수에서 이를 활용하여 cost에 대한 기울기 g를 구하였습니다.
g와 0.1 (learning_rate)를 곱하여 w를 갱신합니다.
이를 반복하면서 최적의 cost에 수렴해갑니다. (위 그림 참고)

## PyTorch를 활용한 Machine Learning 프로그래밍

익히 알고 있는 **Tensorflow, PyTorch**는 Machine Learning을 하기 위해 유용한 라이브러리를 제공합니다.
여기서는 PyTorch를 활용한 Machine Learning 프로그래밍 방법과 관련 개념들을 설명하겠습니다.

### Machine Learning 기본 구조의 이해

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/194984363-58822433-354b-4b81-be0e-3c74560af6cb.png" width="40%" height="40%" />
</p>

위 그림은 Machine Learning Network의 기본 구조를 나타냅니다.
$1 + 2$ 연산이 Graph 형태로 나타나 있습니다. 
Node는 데이터 1, 2 또는 연산자 + 를 가지고 있고, Edge가 이들의 흐름 및 관계를 나타내고 있습니다. 
- Network: 그래프 이론의 Node와 Edge로 구성된 기하 모형 
- Node: 연산 및 데이터를 정의 
- Edge: 노드들을 연결 (데이터의 흐름)

이러한 기본 단위가 모여서 Network가 만들어지는데요.
<ins>노드가 갖는 데이터는 1개의 스칼라값이 아닌 데이터 뭉치였습니다. </ins>

행렬식에서의 곱셈 연산(Matrix multiplication), 자료구조에서의 요소별 연산(Element-wise operation) 등을 활용하여
다량의 데이터 연산을 간단하게 표현하면서도 효과적으로 처리하고 있었습니다.


### 데이터 뭉치와 Tensor?!

Tensor는 데이터 뭉치 및 데이터의 형상/특성을 잘 담아낼 수 있는 자료구조입니다.

PyTorch에서는 Tensor를 아래와 같이 정의하고 있는데요. (쉽게 다차원 배열로 이해)
> A torch.Tensor is a multi-dimensional matrix containing elements of a single data type. - PyTorch

개인적으로 다차원 배열은 데이터 연관성을 나타내기 좋은 자료구조라고 생각합니다.
예를 들어, 색상 데이터를 다차원 배열에서 [[r1, g1, B1], [r2, g2, B2], ...]와 같이 나타낼 수 있는 것처럼요.

<ins>그래서, Tensor를 데이터의 형상/특성을 반영할 수 있는 다차원 데이터 배열로 정도로 이해하고 넘어가면 좋을 것 같습니다.</ins>

Tensor의 형상은 아래와 같고요.

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/194982627-0de4afd1-c2d8-4a30-a442-4c0e4348b0b5.png" width="70%" height="70%" />
</p>

Tensor를 소스 코드로 나타내보면 아래와 같습니다.

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/194982662-5b623cbc-d050-43d5-879f-e291a386e052.png" width="60%" height="60%" />
</p>

### Machine Learning 프로그래밍을 위한 관점의 전환

다시 돌아와서, $h(x) = x w + b$인 수식(가설)을 통해 찾으려는 것은 최적의 $w$와 $b$ 입니다.
우리가 수천, 수억 개의 데이터(우리가 알고 있는 정답)를 가지고 있다고 가정했을 때,
데이터를 대입하여 쭉~ 나열해보면 아래와 같은 w와 b 값에 대한 연립일차방정식을 도출할 수 있습니다.
하지만, Machine Learning Network를 생각해보면 이것을 어떻게 구현해야 할지 막막합니다….

$$x_1 \times w + b = h(x_1)$$

$$x_2 \times w + b = h(x_2)$$

$$x_3 \times w + b = h(x_3)$$

$$...$$


조금 다른 각도로 학습의 관점에서 바라보겠습니다.
우리는 연립방정식을 도출하여 이를 풀려고 하는 것도, 행렬화를 하려는 것도 아니니까요 ^^

예를 들어, 학습하는 경우 우리는 개와 고양이 이미지 데이터를 가지고 있을 것입니다.
이미지가 흑백일 수도, 컬러일 수도, 컬러+투명도일 수도 있습니다. 
흑백(gray)이라면 $x_1$, 컬러(r,g,b)라면 $x_1, x_2, x_3$, 컬러+투명도(r,g,b,a) 라면 $x_1, x_2, x_3, x_4$ 처럼 feature의 수가 다를 것입니다.
각 이미지의 Label(정답)은 개 또는 고양이일 것이고요.

말씀드리려는 관점은 우리가 이미 데이터 분석을 끝마쳤기 때문에 데이터의 형태, 연관성 등을 알고 있으며,
당연히 데이터의 특성이 반영된 nD-tensor 형태로 입력될 것입니다.
우리는 Feature 수, bias를 고려하여 가설을 잘 세워주면 되는 것이지요. (답은 프로그램이 찾아줄 거예요)

따라서, 아래 행렬식에서 왼쪽 행렬은 Tensor 형태의 입력 데이터이고요. 
우리는 입력 데이터의 Feature에 따라 몇 개의 행으로 w 행렬을 구성할 것인지, b의 필요 여부를 판단해주면 되는 것입니다. 
가설 도출이 끝난 것이라 볼 수 있겠습니다.

$$\begin{bmatrix} 
x_{1} \\ 
x_{2} \\
x_{3} \\
... 
\end{bmatrix} \times 
\begin{bmatrix} 
w 
\end{bmatrix} +
b =
\begin{bmatrix} 
h( x_{1} ) \\
h( x_{2} ) \\
h( x_{3} ) \\
...
\end{bmatrix}$$

### 요소별 연산을 위한 브로드캐스팅

그런데 눈치채셨겠지만 $+ b$ 연산하는데 이슈가 있습니다…. 행렬식을 덧셈하려면 행렬의 크기가 같아야 하지만 $b$가 스칼라값입니다.
Python NumPy Array 및 Torch Tensor에서도 더하거나 빼고자 하는 둘 이상의 벡터, 행렬의 사이즈가 같아야 한다는 규칙이 적용됩니다.
이렇듯 두 행렬에 같은 위치의 요소끼리 연산하는 것을 요소별 연산(Element-wise operation)이라 지칭합니다.

그래서, $b$ 처럼 스칼라값인 경우, 서로 다른 차원의 벡터 또는 행렬이 주어졌을 경우 등에는 본래 Element-wise operation이 불가합니다.
그런데도, 이러한 연산을 에러 처리하지 않고 허용합니다. 
두 행렬의 연산이 가능하도록 동일한 차원으로 변형해주는 브로드캐스팅(Broadcasting) 기능을 지원하기 때문입니다. 
따라서, 실제로 연산하기 전에 아래와 같이 브로드캐스팅을 수행하고요. 이후 실제 연산을 진행합니다. 

참고 - 브로드캐스팅이 적용을 위한 룰은 [NumPy Broadcating](https://numpy.org/doc/stable/user/basics.broadcasting.html)을 참고하시기 바랍니다.

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/195344795-e1d13284-dc75-4f36-93e7-549461f9cc7f.png" width="70%" height="70%" />
</p>

출처: [Broadcasting](https://scipy-lectures.org/intro/numpy/operations.html#broadcasting)

### 실습 2 - PyTorch low-level library

PyTorch low-level library를 활용한 소스 코드입니다. 

데이터가 Tensor로 선언되었고요.
실습 1에서는 데이터를 순차 탐색하여 Cost와 gradient를 얻었는데요. 이것을 단 몇 줄로 처리하고 있습니다.
Broadcasting, element-wise operation으로 인해 간단히 프로그래밍할 수 있었습니다.

예제를 보시겠습니다.
- 목표: (1, 5), (2, 8), (3, 11), (4, 13), (5, 17)이 주어졌을 때 이를 만족하는 수식을 찾고, 7일 때 예측값을 확인
- 설명: 가설 $hx = x \times w + b$을 바탕으로 최종의 $w$와 $b$를 구한 후, 7을 대입하여 예측값을 얻음 

```python
import matplotlib.pyplot as plt
import numpy as np
import torch
import torch.nn.functional as F


# 알고 있는 정답 (1, 5), (2, 8), (3, 11), (4, 13), (5, 17)을 
# Tensor 객체로 할당했습니다.
x = torch.FloatTensor([1,2,3,4,5])
y = torch.FloatTensor([5,8,11,13,17])

# 이를 차트로 나타냅니다.
plt.xlim(0, 15)
plt.ylim(0, 30)
plt.scatter(x, y)
plt.show()


# 초기값/설정값을 세팅합니다.
w = 10                # weight
b = 10                # bias
epochs = 3000         # 수행 횟수
learning_rate = 0.01  # 학습률
n = 5                 # 정답 데이터의 수

# 참고
# def cost(x, y, w):
#     hx = w*x 
#     s = torch.sum((hx-y)**2) 
#     return s/len(x)


# 참고
# def gradient(x, y, w):
#     hx = w * x
#     s = torch.sum((hx-y)*2*x)
#     return s/len(x)


# PyTorch low-level library를 활용하여
# 간소화된 학습 코드입니다.
for i in range(epochs):
    hx = w*x + b                          # 가설
    cost = torch.sum((hx-y)**2)/n         # cost function
    gradientW = torch.sum((hx-y)*2*x)/n   # w에 대한 기울기
    gradientB = torch.sum((hx-y)*2)/n     # b에 대한 기울기
    w = w - learning_rate * gradientW     # w 조정
    b = b - learning_rate * gradientB     # b 조정
    print('cost: ', cost, 'w=', w, 'b=',b)
    
print('최종w: ', w, '최종b: ', b)

# 학습하여 얻은 최종 w와 b를 활용하여
# x=7인 경우 결과를 예측해 봅니다.
estimated = w * 7 + b
print('Estimated: ', estimated)

# 예측한 수식을 그래프로 나타냅니다.
# torch.arange()
# start (Number) – the starting value for the set of points. Default: 0.
# end (Number) – the ending value for the set of points
# step (Number) – the gap between each pair of adjacent points. Default: 1.
x_gen = torch.arange(-1, 10) 
print(x_gen)
y_est = w * x_gen + b
print(y_est)

plt.plot(x_gen, y_est) # r: red, o: circle marker # plt.scatter(w,c)
plt.xlabel('x')
plt.ylabel('estimated')
plt.show()

```

### Optimizers in neural networks

이전에 소개한 Gradient Decent는 뉴럴 네트워크의 가중치 parameter 들을 최적화(optimize)하는 방법입니다.
그런데 w를 갱신할 때마다 가지고 있는 수천, 수억 건의 모든 데이터를 활용하여 Cost를 계산합니다.
이처럼 한 스텝마다 방대한 양의 연산을 수행하는 것은 비효율적일 뿐만 아니라 오래 걸립니다.
그래서 등장한 것이 Stochastic Gradient Decent입니다.
Gradient Decent가 Full batch를 통해 모든 데이터를 보고 최적의 한 스텝을 내디뎠던 것이라면 (최적인데 느림),
Stochastic Gradient Decent는 Mini batch를 통해 작은 단위로 일단 스텝을 내디뎌 보는 방식입니다. (조금 헤매는데 빠름).

> 산을 잘 타고 내려오는 것은  
> 어느 **방향**으로 발을 디딜지   
> 얼마의 **보폭**으로 발을 디딜지   
> 두 가지를 잘 잡아야 빠르게 타고 내려온다.
>
> SGD를 더 개선한 멋진 optimizer가 많다! SGD의 개선된 후계자들

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/195497984-ce4b729e-9a99-438e-8b52-3569c83a32a4.png" width="70%" height="70%" />
</p>

출처: [하용호, 자습해도 모르겠던 딥러닝, 머리속에 인스톨 시켜드립니다.](https://www.slideshare.net/yongho/ss-79607172)

"어떤 Optimizer를 써야 할지 잘 모르겠다면 Adam을 써라"라는 말이 있다고 합니다.
저도 일단 써보고 있습니다. :smiley:

### 실습 3 - PyTorch high-level library

PyTorch high-level library를 활용한 소스 코드입니다. 

데이터가 Tensor로 선언되었고요.
w, b 또한 Tensor 객체로 선언되었습니다.
실습 2에서는 w, b를 얻어서 직접 갱신해 주었지만, 이제는 이 작업을 Adam optimizer 내부에서 처리합니다.
코드가 점점 간결해 지는 것이 느껴지실까요? ^^

예제를 보시겠습니다.
- 목표: (1, 3), (2, 5), (3, 7), (4, 9), (5, 11)이 주어졌을 때 이를 만족하는 수식을 찾는 것
- 설명: Adam optimizer에 갱신해야 할 Parameters ( $w$, $b$ )를 입력하였고, 학습을 통해 수식을 도출함


```python
import torch
import torch.optim as o


# 참고 - 미분 값을 초기화 해야 하는 이유
# w = torch.tensor(2.0, requires_grad=True) # 미분을 통해 수정할 수 있는 Tensor 객체

# y = 2*w**2
# y.backward() # 미분... 이후에 왜 이 함수 이름이 backward인지 알 수 있음
# print(w.grad)

# # 여기서 초기화하지 않으면, 기존 미분 값이 계속 합산됨
# y = 2*w**2
# y.backward() 
# print(w.grad)

# y = 2*w**2
# y.backward() 
# print(w.grad)


# 알고 있는 정답 (1, 3), (3, 5), (3, 7, (4, 9), (5, 11)을 
# Tensor 객체로 할당했습니다.
x = torch.FloatTensor([1,2,3,4,5])
y = torch.FloatTensor([3,5,7,9,11])


# w, b를 미분해 수정할 수 있는 Tensor 객체로 선언합니다. (requires_grad=True)
# 초기값 10.0
w = torch.tensor(10.0, requires_grad=True)
b = torch.tensor(10.0, requires_grad=True)

# 
optimizer = o.Adam([w,b], lr=0.1)
for i in range(2000):
    hx = w*x+b                    # Forward 개념
    cost = torch.mean((hx-y)**2)  # cost 개념 
    optimizer.zero_grad()         # 기존 미분 값 초기화 (미분 값이 합산되는 것을 방지)
    cost.backward()               # 미분 w, b (왜 미분인지 추후 설명)
    optimizer.step()              # w, b 갱신 (backward() 단계에서 수집된 변호도로 매개변수를 조정)
    print(i, 'cost=', cost.item())

print('최종w: ', w, '최종b: ', b)

```
## Linear regression

$$y = x w + b$$

앞서 봐왔던 위 수식은 사실 단순 선형 회귀 분석에 대한 수식이었습니다.
우리는 이미 세 가지 방법으로 선형 회귀 분석을 수행해 본 것이나 다름없습니다.

선형 회귀(Linear regression)란 수많은 점 데이터를 놓고 봤을 때 이것을 가장 잘 나타낼 수 있는 선을 찾는 것입니다.
이를 찾는 분석하는 방법을 선형 회귀 분석이라 합니다.

아래 그림에서 파란색 점으로 표현된 데이터를 놓고 봤을 때 빨간색 점선을 찾는 것입니다. 
$y=x$ 는 하나의 선밖에 나타낼 수 없지만, $w$와 $b$가 추가되면 수많은 선을 그릴 수 있습니다. 

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/195769402-04014982-180d-49c1-af1d-98c9f9459be9.png" width="50%" height="50%" />
</p>

### 상관관계 분석

두 변수 간에 어떤 선형적 관계를 가졌는지를 분석하는 방법입니다. 
피어슨 상관계수 (Pearson correlation coefficient 또는 Pearson's r)는 두 변수 X와 Y 간의 선형 상관 관계를 계량화한 수치를 나타냅니다. 
r 값은 X 와 Y가 완전히 동일하면 +1, 전혀 다르면 0, 반대 방향으로 완전히 동일하면 –1 을 가집니다.

> r이 -1.0과 -0.7 사이이면, 강한 음적 선형관계,   
> r이 -0.7과 -0.3 사이이면, 뚜렷한 음적 선형관계,   
> r이 -0.3과 -0.1 사이이면, 약한 음적 선형관계,   
> r이 -0.1과 +0.1 사이이면, 거의 무시될 수 있는 선형관계,   
> r이 +0.1과 +0.3 사이이면, 약한 양적 선형관계,   
> r이 +0.3과 +0.7 사이이면, 뚜렷한 양적 선형관계,   
> r이 +0.7과 +1.0 사이이면, 강한 양적 선형관계

출처: [Wikipedia, 상관 분석](https://ko.wikipedia.org/wiki/%EC%83%81%EA%B4%80_%EB%B6%84%EC%84%9D)


### 실습 4 - Linear regression with PyTorch high-level library

50개의 자동차의 속도와 거리 데이터를 활용하여 선형 회귀를 진행하였습니다.

데이터가 Tensor로 선언되었고요.
w, b 또한 Tensor 객체로 선언되었습니다.
실습 2에서는 w, b를 얻어서 직접 갱신해 주었지만, 이제는 이 작업을 Adam optimizer 내부에서 처리합니다.
코드가 점점 간결해지는 것이 느껴지실까요? ^^

예제를 보시겠습니다.

```python
import torch
from torch.optim import Adam
from torch.nn import Linear, MSELoss, Sequential
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


# pandas 패키지를 활용하여 cars.csv를 읽어 들입니다.
df = pd.read_csv('../data/cars.csv', index_col="Unnamed: 0")

# 데이터(speed, dist)를 출력해봅니다.
df

# speed와 dist의 상관관계를 알아봅니다.
df.corr()

# Data를 입력하여 Tensor를 할당했습니다. 
# Matrix 형태로 할당해야 합니다.
# 지금은 Feature(speed)가 1개이지만, 2개 이상이 되면 Matrix multiplication을 해야 하기 때문입니다.
x = torch.FloatTensor(df[['speed']].values) # 특성 데이터
y = torch.FloatTensor(df[['dist']].values) # 라벨


# Linear 객체를 활용하는 방법입니다.
# w, b를 직접 생성하지 않고,
# 특성 데이터의 개수, 라벨의 개수를 입력합니다.
linear = Linear(1, 1) # (특성 데이터의 개수, 라벨의 개수)

# linear.parameters() 안에서 w와 b의 값이 Random 하게 주어집니다.
# 이를 출력하려 확인해봅니다.
list(linear.parameters())
linear.weight
linear.bias


# 손실함수(loss function)를 Mean Squared Error로 설정합니다.
loss_fn = MSELoss()
# w, b를 나타내는 linear.parameters()와 learning rate를 입력하여 Adam optimizer를 생성합니다.
optimizer = Adam(linear.parameters(), lr=0.1)

for step in range(1000):
    optimizer.zero_grad()     # 이전 미분 값이 합산되지 않도록 초기화
    hx = linear.forward(x)    # hx = w*x+b # linear(x)로도 가능 <-- special 함수로 Overwriting 되어있어서 가능
    cost = loss_fn(hx, y)     # Cost function
    cost.backward()           # w, b 각각에 대한 미분 
    optimizer.step()          # w, b 갱신 (backward() 단계에서 수집된 변호도로 매개변수를 조정)
    print(step, cost.item())  # 결과 출력

# 최종 w, b 결과를 출력해 봅니다.
list(linear.parameters())
linear.weight
linear.bias

# speed=10일 때 dist를 예측해보고 결과를 출력합니다.
linear.forward(torch.FloatTensor([10]))
# linear.forward(x)와 linear(x)는 동일한 함수입니다. <-- special 함수로 Overwriting 되어있음

# 그래프를 그리기 위해 기존 speed 값을 활용하여 예측값을 얻었습니다.
# speed 대신 임의의 값을 입력해도 됩니다.
# plot이 인자를 NumPy array 받기 때문에, Tensor를 NumPy array로 변환하였습니다.
pred = linear(x).detach().numpy()

# 실제 데이터 출력
plt.scatter(df['speed'], df['dist'])
# 예측값을 활용하여 예측선 출력
plt.plot(df['speed'], pred, 'r--')
plt.show()


# 참고: Python의 special 함수
# class Test:
#     def __init__(self):
#         self.d = {}
#         self.a = 10
#     def __repr__(self):
#         return f'a={self.a}'
#     def __setitem__(self, key, value):
#         print('setitem call')
#         self.d[key] = value
#
# obj = Test()
# print(obj) # obj.__repr__()
# 
# obj['aa']=100 # obj.__setitem__('aa', 100)

```

### 실습 5 - Linear regression with PyTorch high-level library

```python

import torch
from torch.optim import Adam
from torch.nn import Linear, MSELoss, Sequential
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


# pandas 패키지를 활용하여 cars.csv를 읽어 들입니다.
df = pd.read_csv('../data/cars.csv', index_col="Unnamed: 0")
# 데이터(speed, dist)를 출력해봅니다.
df

# speed와 dist의 상관관계를 알아봅니다.
df.corr()

# Data를 Matrix 형태로 입력하여 Tensor를 할당했습니다.
x = torch.FloatTensor(df[['speed']].values) # 특성 데이터
y = torch.FloatTensor(df[['dist']].values) # 라벨

# Sequential 컨테이너 객체와 Linear 객체를 활용하는 방법입니다.
# 이후 딥러닝을 위해 알아두어야 할 객체입니다.
model = Sequential()
model.add_module('nn1', Linear(1,1))  # (특성 데이터의 개수, 라벨의 개수)


# 손실함수(loss function)를 Mean Squared Error로 설정합니다.
loss_fn = MSELoss()
# w, b를 나타내는 linear.parameters()와 learning rate를 입력하여 Adam optimizer를 생성합니다.
optimizer = Adam(model.parameters(), lr=0.1)

for step in range(1000):
    optimizer.zero_grad()     # 이전 미분 값이 합산되지 않도록 초기화
    hx = model.forward(x)     # w*x+b # hx = model(x)도 가능 (Overwriting)
    cost = loss_fn(hx, y)     # Cost function
    cost.backward()           # w, b 각각에 대한 미분 
    optimizer.step()          # w, b 갱신 (backward() 단계에서 수집된 변호도로 매개변수를 조정)
    print(step, cost.item())  # 결과 출력

# 최종 결과 출력
model[0].weight
model[0].bias

# 10일때 예측값 확인
model( torch.FloatTensor([10]))

```

## Multi-Linear Regression

다중 선형 회귀(Multiple Linear Regression) 또한 수많은 점 데이터가 주어졌을 때 이를 가장 잘 나타낼 수 있는 선을 찾는 것입니다.
단순 선형 회귀는 feature 1개, label 1개였는데요. 다중 선형 회귀에서는 feature가 2개 이상이 됩니다.

예를 들어, 집의 매매 가격을 결정하는 것은 집의 평수, 집의 층의 수, 방의 개수, 지하철역과의 거리, 등과 영향이 있습니다. 
이렇듯 여러 개의 Feature를 가지고 Label을 예측하는 경우 이를 다중 회귀 분석이라고 합니다.

$$y = x_1 w_1 + x_2 w_2 + ... x_n w_n + b$$


### 실습 6 - Multi-linear regression with PyTorch high-level library

```python
import torch
from torch.optim import Adam
from torch.nn import Linear, MSELoss, Sequential
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


# pandas 패키지를 활용하여 test.csv를 읽어 들입니다.
df = pd.read_csv('../data/test.csv', header=None) # Quiz1 , Quiz2, Midterm, Final
# column 제목을 설정합니다.
df.columns = ['q1', 'q2', 'mid', 'final']
# 데이터('q1', 'q2', 'mid', 'final')를 출력해봅니다.
df



# Data가 Tensor 객체로 할당되었습니다. (Matrix 형태)
# #df.iloc[행, 열]
x = torch.FloatTensor(df.iloc[:,:-1].values) 
y = torch.FloatTensor(df.iloc[:,[-1]].values)


# Sequential 컨테이너 객체와 Linear 객체를 활용하는 방법입니다.
# 이후 딥러닝을 위해 알아두어야 할 객체입니다.
model = Sequential()
model.add_module('nn1', Linear(3,1)) # (특성 데이터 개수, 라벨의 개수)

# 손실함수(loss function)를 Mean Squared Error로 설정합니다.
loss_fn = MSELoss()
# w1, w2, w3, b를 나타내는 linear.parameters()와 learning rate를 입력하여 Adam optimizer를 생성합니다.
optimizer = Adam(model.parameters(), lr=0.1)

for step in range(1000):
    optimizer.zero_grad()       # 이전 미분 값이 합산되지 않도록 초기화
    hx = model.forward(x)       # matmul (x, w) + b # model(x) 가능 (Overwriting)
    cost = loss_fn(hx, y)       # Cost function
    cost.backward()             # w, b 미분 
    optimizer.step()            # w, b 갱신 (backward() 단계에서 수집된 변호도로 매개변수를 조정)
    print(step, cost.item())    # 결과 출력


# 최종 결과 출력
model[0].weight
model[0].bias


# q1=80, q2=90, mid=90 일 때 예측된 final 출력
model(torch.FloatTensor([[80,90,90]]))

# 여러 데이터에 대해 예측 가능
model(torch.FloatTensor([[80,90,90], [70,50,50]]))

```

## 마치며

잊어버리기 전에 강좌의 내용을 간단히 정리해 놓아야겠다고 생각하여 쓰기 시작했던 글이 제법 길어졌네요.
강좌의 내용을 정리 및 설명하면서 Machine Learning에 대해 더욱 많이 배우는 시간이었습니다.
아직 설명하지 못한 이진/다중 분류, 딥러닝이 남아 있지만 이쯤에 끊고 가는 것이 좋을 것 같습니다.
필요하신 분들께 조금이나마 도움이 되기를 바라며, 다음 글에서 만나 뵙겠습니다.

그럼 저는 이만 cb-network system 성능 평가 결과를 활용하여 선형회귀분석을 진행하러 가보겠습니다 ^^ 감사합니다.

#### TBD
- Binary classification 
- Multiclass classification
- Activation function
  - Sigmoid (Binary classification)
  - Softmax (Multinomial classification)
  - ReLU (Deep Learning)
- Deep Learning
  - Forward propagation
  - Backward propagation
- Python 및 Data science packages (Pandas, Sklearn)
- Hyper-parameter tuning
- 학습 기반의 시스템 운영을 위한 구조도 (클라우드바리스타를 예시로 활용)
  - (스케치) cb-network system log 수집, 처리, 저장, 분석, 시각화 -> 학습을 위한 데이터 추출, 전처리 -> 학습 -> 수식 도출 -> 활용
