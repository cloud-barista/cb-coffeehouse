## Write context, review code: Taking Copilot to the Next Level

(Write context, review code: Copilot 잠재력을 최대로 끌어올리는 방법)

ChatGPT의 등장 이래, 우리는 프롬프트 엔지니어링, MyGPTs와 같은 개인화 기능, 모델을 특정 목적에 맞게 훈련하는 파인튜닝(Fine-tuning), 그리고 외부 데이터로 답변을 보강하는 RAG까지, AI의 응답을 우리에게 최적화하려는 노력을 계속해왔습니다. **모델 컨텍스트 프로토콜(MCP)은 '서비스(기능)와 데이터에 대한 표준화된 접근법'을 제시하면서 관련 생태계가 빠르게 확대되고 있으며, 그 최종 결과물이 VS Code 안에서 더욱 강력하고 체계적인 기능으로 완성되는 것으로 보입니다.**

### TL;DR

- **AI 코딩의 핵심은 컨텍스트 제공**: 모델에 정확한 컨텍스트를 제공하는 것이 중요하며, MCP(Model Context Protocol)는 이를 위한 표준화된 방법을 제시합니다.
  - "Models are only as good as the **context** provided to them" - Anthropic Webinar, Building the future of AI coding with MCP in VS Code and Claude

* **MCP를 통한 개발 경험 확장**:
  - VS Code, Windows, Azure 등 다양한 플랫폼에 MCP를 통합하여 글쓰기, GitHub 이슈 관리, Playwright를 이용한 웹페이지 디버깅 등 개발 도구를 다방면으로 활용할 수 있습니다.
  - (참고) Anthropic 웨비나, MS Reactor MCP Dev Days ([Day 1 - DevTools](https://www.youtube.com/live/8-okWLAUI3Q?si=KX35XMnP3Cj3tPzG), [Day 2 - Builders](https://www.youtube.com/live/lHuxDMMkGJ8?si=z0QpWhKdj3hi65VZ))
* <ins>**VS Code Copilot 맞춤 설정 및 팀 공유**:</ins>
  - `Custom instructions`, `custom chat modes`, `prompt` 등 Copilot의 동작 방식을 프로젝트에 맞게 파일로 정의하고 참여자들(메인테이너, 기여자 등)과 공유할 수 있습니다(e.g., Beast Mode 🐱).
  - 이를 통해 참여자들이 일관된 가이드라인과 명령어를 사용하는 맞춤형 환경에서 작업할 수 있으며, 프로젝트 전체의 개발 생산성을 향상 할 수 있을 것으로 기대합니다.
* **상세 내용**: 본문에서 관련 개념, 설정 방법, 기존 예제, 그리고 `mc-terrarium` 적용 및 활용 현황 등을 확인하실 수 있습니다.
  - 참고: 현재 mc-terrarium은 CSP간 VPN을 구성하는 기능/API를 제공하고 있습니다(Cloud-Barista 커뮤니티에서 멀티 클라우드 인프라에 특정 자원을 보강하기 위한 프로젝트).

![](https://i.imgur.com/yAioHUB.png)

References:

- https://learn.microsoft.com/en-us/azure/developer/ai/build-mcp-server-ts?tabs=github-codespaces
- https://code.visualstudio.com/blogs/2025/02/24/introducing-copilot-agent-mode
- https://www.linkedin.com/pulse/microsoft-copilot-studio-now-supports-model-context-mcp-mohapatra-wscyc/
- https://medium.com/@haridasan.dipu/bringing-ai-into-our-developer-workflow-how-we-use-github-copilot-mcp-at-scale-6477f45d73f8
- https://github.com/opentofu/opentofu-mcp-server

### 왜 컨텍스트인가: 모델 컨텍스트 프로토콜(MCP) 소개

이 글에서 소개할 기능들을 이해하기에 앞서, 왜 '컨텍스트'가 중요한지 그 배경부터 짚어보겠습니다. 2024년 Anthropic에서 '모델 컨텍스트 프로토콜(MCP)'은 AI가 기존의 서비스(기능)와 데이터를 더 깊이 이해하게 만드는 방법에 대한 표준을 제시했습니다.

MCP는 AI 모델(클라이언트)이 다양한 데이터 소스(서버)와 원활하게 소통하기 위한 '약속'입니다. 어떤 AI든 MCP라는 표준을 통해 파일 시스템, Git 히스토리, 데이터베이스 등 다양한 '컨텍스트 서버'에 연결하여 필요한 맥락 정보를 얻을 수 있습니다.

이를 개발의 영역에서 바라보면, 우리가 직접 코드를 작성하기보다 AI가 더 나은 코드를 생성하도록 '컨텍스트'를 제공하는 역할에 집중해야 함을 의미합니다. 이를 바탕으로 신규/핵심 기능 개발에 더욱 집중할 수 있을 것 입니다.

이제 VS Code가 이러한 MCP의 철학을 어떻게 구현하여 Copilot의 잠재력을 끌어올리고, 우리가 어떻게 "Write context, review code" 를 경험할 수 있는지 방법들을 살펴보겠습니다.

#### Use MCP server in VS Code

> [!NOTE]
>
> - MCP(Model Context Protocol) 서버를 사용하면 데이터베이스 연결, API 호출 또는 특수 작업 수행과 같은 추가 도구를 통해 VS Code의 채팅 경험을 확장할 수 있음
> - MCP(Model Context Protocol)는 AI 모델이 통일된 인터페이스를 통해 외부 도구 및 서비스와 상호 작용할 수 있도록 지원하는 공개 표준

원문: https://code.visualstudio.com/docs/copilot/chat/mcp-servers

##### 설정 방법

Note: 아래는 workspace setting 방법을 나타냅니다.

1. **파일 생성하기**
   - 프로젝트의 최상위(root) 경로에 `.vscode/mcp.json` 파일을 추가합니다.
2. **지침 작성하기**
   - 생성된 `mcp.json` 파일에 대상 MCP 서버를 설정합니다.

Example: Configure a Perplexity MCP server

```json
{
  // 💡 Inputs are prompted on first server start, then stored securely by VS Code.
  "inputs": [
    {
      "type": "promptString",
      "id": "perplexity-key",
      "description": "Perplexity API Key",
      "password": true
    }
  ],
  "servers": {
    // https://github.com/github/github-mcp-server/
    "Github": {
      "url": "https://api.githubcopilot.com/mcp/"
    },
    // https://github.com/ppl-ai/modelcontextprotocol/
    "Perplexity": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "server-perplexity-ask"],
      "env": {
        "PERPLEXITY_API_KEY": "${input:perplexity-key}"
      }
    }
  }
}
```

##### Supported MCP capabilities in VS Code

VS Code supports the following MCP capabilities:

- MCP Server transport: local standard input/output (`stdio`), server-sent events (`sse`), and streamable HTTP (`http`) for MCP server transport.
- [MCP features](https://modelcontextprotocol.io/specification/2025-03-26#features): tools, prompts, resources, and sampling.
- VS Code provides servers with the current workspace folders using `roots` ([spec](https://modelcontextprotocol.io/docs/concepts/roots)).

##### Finding MCP Servers

**The curated list of MCP servers on the VS Code website is a great starting point.**

- https://code.visualstudio.com/mcp

MCP's official server repository

- https://github.com/modelcontextprotocol/servers

### mc-terrarium에서 OpenTofu 적용 및 활용 경험

> [!NOTE]
>
> - OpenTofu MCP server 연동 후, Copilot (agent mode)이 알아서 정정해 주는 영역이 늘어남

#### OpenTofu MCP server 활용 전/후

- 배경:
  - OpenTofu/Terraform provider는 각 CSP에서 메인테이닝을 하며 활발하게 업데이트하고 있음
  - 공식 Docs에서 Resource block specification과 Example이 상이한 경우 발생
  - 다양한 버전들을 바탕으로 기술 블로그가 생산됨
- 관련 이슈: (아마도) 이러한 데이터가 **ChatGPT, Claude, Gemini, Copilot** 학습 시 활용되었고, 질의 응답 시 이전 버전을 결과로 제공하거나, 잘못된 응답을 하는 경우를 자주 마주하였음
- **OpenTofu 적용 후: (Copilot Agent 모드 활용) 여전히 같은 상황이 발생하지만, 이를 즉각적으로 인지하고 정정함**
- 소감: 만족스러움. 활용되는 Remote Server와 연결이 간헐적으로 끊어지는 이슈가 있어, Local 구동을 고려중

Example: Configure OpenTofu MCP Server

- `.vscode/mcp.json`
- MCP Server transport: `sse`

```json
{
  "servers": {
    "opentofu": {
      "type": "sse",
      "url": "https://mcp.opentofu.org/sse"
    }
  },
  "inputs": []
}
```

### Customize AI responses in VS Code

> [!NOTE]
>
> - 요약하면, Copilot을 더욱 잘 활용하기 위한 방법

원문: https://code.visualstudio.com/docs/copilot/copilot-customization

Visual Studio Code(VS Code)에서 AI의 응답을 사용자의 코딩 스타일이나 프로젝트 요구사항에 맞게 맞춤 설정할 수 있습니다. 매번 프롬프트에 반복적으로 정보를 추가하는 대신, 특정 파일에 컨텍스트를 저장하여 모든 채팅 요청에 자동으로 포함시키는 방식입니다.

VS Code에서 AI 응답을 맞춤 설정하는 주요 방법은 세 가지가 있습니다.

1. **사용자 지정 지침 (Custom instructions)**

   - AI가 코드 생성, 코드 리뷰, 커밋 메시지 작성과 같은 작업을 **'어떻게'** 수행해야 하는지에 대한 공통된 가이드라인이나 규칙을 정의합니다.

2. **프롬프트 파일 (Prompt files)**

   - 일반적인 작업을 위해 재사용 가능한 프롬프트를 정의합니다. 이는 AI가 **'무엇을'** 해야 하는지, 즉 수행할 작업을 설명합니다. 필요에 따라 작업별 가이드라인을 포함하거나 '사용자 지정 지침'을 참조할 수 있습니다.

3. **사용자 지정 채팅 모드 (Custom chat modes)**

   - 채팅의 전반적인 작동 방식, 사용 가능한 도구, 코드베이스와의 상호작용 방식을 정의합니다. 이를 통해 매번 설정을 반복할 필요 없이 일관된 환경에서 AI를 사용할 수 있습니다.

**참고 - MC-Terrarium 설정 현황**

![](https://i.imgur.com/EavbLqc.png)

---

### Custom instructions

> [!NOTE]
>
> - 요약하면, 프로젝트의 개발 지침/코딩 규칙을 미리 설정해두면 AI가 이를 자동으로 반영하여, 반복적인 설명 없이도 일관성 있는 코드를 얻을 수 있는 방법
> - 예를 들어, 코딩 컨벤션, 소스 트리, 프로젝트 내 특수한 구조 또는 패턴, 기능간 연관 관계, API 규격, 네이밍 컨벤션 등을 개발 지침/코딩 규칙으로 설정해 놓을 수 있음

Custom instruction을 설정하는 방법은 3가지가 있습니다. 여기에서는 `.github/copilot-instructions.md` 파일을 설정하는 방법에 대해서 다루겠습니다. 자세한 내용은 [Custom instructions](https://code.visualstudio.com/docs/copilot/copilot-customization#_custom-instructions)를 참고하시기 바랍니다.

#### 어디에 어떻게 설정하고 사용하는가?

프로젝트의 최상위 폴더에 `.github/copilot-instructions.md`라는 파일을 만들어 두면, GitHub Copilot이 해당 프로젝트에서 코드를 생성하거나 채팅 답변을 할 때 이 파일의 내용을 먼저 참고합니다.

즉, **프로젝트별로 Copilot에게 "이 프로젝트에서는 이렇게 코딩해줘!"라고 구체적인 가이드라인을 제공**하는 설명서 파일입니다. 이 지침은 해당 파일이 있는 프로젝트(워크스페이스)에만 적용됩니다.

##### 설정 방법

1. **VS Code 설정 켜기**
   - VS Code 설정(Settings)에서 `github.copilot.chat.codeGeneration.useInstructionFiles`를 검색하여 체크 박스를 `true`로 설정합니다. 이 설정을 켜야 VS Code가 해당 파일을 자동으로 읽어 들입니다.
2. **파일 생성하기**
   - 프로젝트의 최상위(root) 경로에 `.github` 디렉토리를 만듭니다. (이미 있다면 만들 필요 없음)
   - `.github` 폴더 안에 `copilot-instructions.md`라는 이름으로 파일을 생성합니다.
3. **지침 작성하기**
   - 생성된 `copilot-instructions.md` 파일 안에 **자연어**와 **마크다운(Markdown)** 형식으로 자유롭게 지침을 작성합니다.

##### 작성 내용 예시

파일 안에는 프로젝트의 기술 스택, 코딩 컨벤션, 자주 사용하는 라이브러리 등 다양한 규칙을 적을 수 있습니다.

Example: general coding guidelines

```markdown
---
applyTo: "**"
---

# Project general coding standards

## Naming Conventions

- Use PascalCase for component names, interfaces, and type aliases
- Use camelCase for variables, functions, and methods
- Prefix private class members with underscore (\_)
- Use ALL_CAPS for constants

## Error Handling

- Use try/catch blocks for async operations
- Implement proper error boundaries in React components
- Always log errors with contextual information
```

Example: TypeScript and React coding guidelines

```markdown
---
applyTo: "**/*.ts,**/*.tsx"
---

# Project coding standards for TypeScript and React

Apply the [general coding guidelines](./general-coding.instructions.md) to all code.

## TypeScript Guidelines

- Use TypeScript for all new code
- Follow functional programming principles where possible
- Use interfaces for data structures and type definitions
- Prefer immutable data (const, readonly)
- Use optional chaining (?.) and nullish coalescing (??) operators

## React Guidelines

- Use functional components with hooks
- Follow the React hooks rules (no conditional hooks)
- Use React.FC type for components with children
- Keep components small and focused
- Use CSS modules for component styling
```

Example: Copilot instruction

```markdown
# Copilot Instructions

- This project uses **React** and **TypeScript**.
- All components should be written as **functional components** using **Hooks**. Do not use class components.
- State management is handled with **Redux Toolkit**.
- For styling, please use **Tailwind CSS**.
- For API communication, please implement it using the **`axios`** library instead of `fetch`.
- Please follow **camelCase** for variable names.
```

##### 참고 사항

- `.github/copilot-instructions.md` 파일은 **VS Code**뿐만 아니라 **Visual Studio** 및 **GitHub.com** 웹사이트에서도 동일하게 인식됩니다.
- 따라서 하나의 지침 파일만 만들어 두면 여러 다른 개발 환경에서도 일관된 Copilot의 지원을 받을 수 있습니다.

### mc-terrarium에서 instructions 적용 및 활용 경험

> [!NOTE] > `copilot-instructions.md`도 Copilot으로 만들고 개선하고 싶었어요 😄

#### `copilot-instructions.md`을 적용하기 전과 후

- mc-terrarium 독자적인 구조/패턴: API 요청을 받으면, /templates에 사전에 정의되어 있는 infracode templates들 중에 필요한 infracode들을 .terrarium/{trId} 경로에 복사한 후 이를 실행하여 실제 인프라를 생성하고 있음
- 관련 이슈: **Copilot은 이러한 독자적인 구조/패턴을 인지하지 못하기 때문에 /templates 디렉토리 내에서 infracode 가 잘 동작하도록 만들려고 계속적으로 코드를 개선함. 하지만 이는 원하는 방향이 아님**
- instruction 적용 후: **위 이슈의 출현 빈도가 현저하게 줄어들었음.**
- 소감: 만족스러움. instruction은 세세하게 작성한다면 출현 빈도를 더욱 낮출 수도 있겠지만, 한편으로는 새로운 측면의 코드 제시를 방해할 수 있겠다는 생각이 들었음

#### `copilot-instructions.md` 초기 생성 과정

1. `.github/copilot-instructions.md` 생성
2. Copilot Chat을 열고 Agent 모드로 설정
3. `#codebase 를 분석해서 copilot-instructions를 작성해주세요.` 입력
4. 결과 리뷰 후 instructions을 직접 수정 또는 개선 요청 (이를 반복 수행)
5. 원하는 instructions 얻음

**초기 copilot-instructions.md** (처음 결과를 복사해 놓지 못해서 재 요청해본 결과에요 😅 )

- [initial-copilot-instructions-for-mc-terrarium](initial-copilot-instructions-for-mc-terrarium.md)

#### 기능 추가 구현 후 `copilot-instructions.md` 업데이트 과정

1. Copilot을 열어서 Azure-GCP간 VPN 구성을 위한 infracode(template), model, handler 등을 개발
2. 개발을 완료한 Copilot 창에서, 아래와 같이 요청
   - `지금까지의 질의응답을 통해 azure와 gcp 간에 VPN을 구성할 수 있게 되었습니다. 이를 통해 따라야하는 Instructions도 파악이 되었습니다. 해당 instruction을 copilot-instructions.md에 업데이트해 주시기 바랍니다.`
3. 결과물을 리뷰하고, 아래와 같이 요청하여 instruction을 업데이트
   - `{csp1}-{csp2}는 알파벳 순서로 지정된다는 내용을 copilot-instructions.md에 추가가 필요할까요?`

**업데이트된 `colilot-instruction.md` 😎**

- [updated-copilot-instructions-for-mc-terrarium](updated-copilot-instructions-for-mc-terrarium.md)

---

여기부터는 급격한 마무리 수순을... 😅

Custom chat mode와 Prompt는 조금 더 사용해 보고 업데이트할 예정입니다.

### Custom chat mode

> [!NOTE]
> 요약하면, VS Code에는 Ask, Edit, Agent 세 가지 채팅 모드가 내장되어 있는데요. 새로운 기능 계획이나 구현 옵션 조사와 같은 특정 시나리오를 위해 **자신만의 채팅 모드를 정의하는 방법**

> [!TIP]
>
> - Standard Models (e.g., ChatGPT 4.1)에서 Premium Modes (e.g., Claude Sonnet 4)의 퍼포먼스를 낼 수 있다면 ?!
> - 'Beast' Mode는 ChatGPT 4.1에서 사용하도록 설계된 Custom chat mode (모든 모델에서 작동 가능)
> - 할 일 목록 사용, 광범위한 인터넷 검색 기능, 계획 수립, 도구 사용 지침 등 에이전트에 독창적인 워크플로를 추가

자세한 내용은 아래의 "Example: 'Beast' Mode" 섹션 또는 [Chat modes in VS Code](https://code.visualstudio.com/docs/copilot/chat/chat-modes)를 참고하시기 바랍니다.

#### 어디에 어떻게 설정하고 사용하는가?

프로젝트의 최상위 폴더의 `.github/chatmodes` 디렉토리에 "{ChatModeName}.chatmode.md" 형식의 파일을 만들고, mode를 정의해 두면, GitHub Copilot에 채팅에서 해당 모드(`ChatModeName`)를 선택 후 사용할 수 있습니다. (i.e., chatmode 파일은 .chatmode.md 파일 확장자를 가진 마크다운 파일입니다.)

Custom chat mode에 대한 자세한 내용은 [Custom chat modes](https://code.visualstudio.com/docs/copilot/chat/chat-modes#_custom-chat-modes)을 참고 하시기 바랍니다.

##### Custom chat mode 내용 예시

Example: 'Plan' mode that generates an implementation plan and doesn't make any code edits

```markdown
---
description: Generate an implementation plan for new features or refactoring existing code.
tools: ["codebase", "fetch", "findTestFiles", "githubRepo", "search", "usages"]
model: Claude Sonnet 4
---

# Planning mode instructions

You are in planning mode. Your task is to generate an implementation plan for a new feature or for refactoring existing code.
Don't make any code edits, just generate a plan.

The plan consists of a Markdown document that describes the implementation plan, including the following sections:

- Overview: A brief description of the feature or refactoring task.
- Requirements: A list of requirements for the feature or refactoring task.
- Implementation Steps: A detailed list of steps to implement the feature or refactoring task.
- Testing: A list of tests that need to be implemented to verify the feature or refactoring task.
```

Example: 'Beast' Mode

Introduction to 'Beast' Mode 🐱

> Beast Mode is a custom chat mode for VS Code agent that adds an opinionated workflow to the agent, including use of a todo list, extensive internet research capabilities, planning, tool usage instructions and more. Designed to be used with 4.1, although it will work with any model.
>
> Below you will find the Beast Mode prompt in various versions - starting with the most recent - 3.1

- https://gist.github.com/burkeholland/88af0249c4b6aff3820bf37898c8bacf

`beastmode3.1.chatmode.md`

- https://gist.github.com/burkeholland/88af0249c4b6aff3820bf37898c8bacf#file-beastmode3-1-chatmode-md

Demo on "MCP Dev Days: Day 2 - Build ""

- https://youtu.be/lHuxDMMkGJ8?t=2913

##### 설정 방법

: 직접 생성 방법

1. 파일 생성하기
   - 프로젝트의 최상위(root) 경로에 `.github/chatmodes` 디렉토리 만듭니다. (이미 있다면 만들 필요 없음)
   - `.github/chatmodes/` 디렉토리에 `{ChatModeName}.chatmode.md` 형식의 파일 생성합니다.
2. **Chat mode 작성하기**
   - 생성된 `{ChatModeName}.chatmode.md` 파일 안에 **자연어**와 **마크다운(Markdown)** 형식으로 자유롭게 Chat Mode를 작성합니다.
   - 참고 - `${variableName}` syntax를 활용하여 다양한 변수를 참조할 수 있습니다.

##### 사용 방법

1. 채팅 뷰 입력 창에서 Mode를 선택 (Built-in modes: ask, edit, agent / Custom modes: YourChatModeName )
   - 예) `Plan.chatmode.md` 파일을 생성한 경우, 채팅 뷰 입력창에서 `Plan` 모드를 선택 할 수 있음

### mc-terrarium에서 instructions 적용 및 활용 경험

> [!NOTE]
> 단순히 예제를 적용하고 실행해 봄

Plan mode 추가

![](https://i.imgur.com/RswiEXl.png)

채팅장에서 Plan mode를 선택 가능

![](https://i.imgur.com/xNZwDoD.png)

명령어 입력 결과

![](https://i.imgur.com/IdPJuzL.png)

---

### Prompt files

> [!NOTE]
>
> - 요약하면, 코드 생성이나 리뷰처럼 반복적인 작업을 위해 미리 만들어두는 **재사용 가능한 명령어(프롬프트) 템플릿**을 만들어 두는 방법

Prompt files을 설정하는 방법은 2가지가 있습니다. 여기에서는 워크스페이스의 `.github/prompts` 디렉토리에 설정하는 방법에 대해서 다루겠습니다. 자세한 내용은 [Prompt files (experimental)](https://code.visualstudio.com/docs/copilot/copilot-customization#_prompt-files-experimental)을 참고하시기 바랍니다.

#### 어디에 어떻게 설정하고 사용하는가?

프로젝트의 최상위 폴더의 `.github/prompts` 디렉토리에 "{PromptName}.prompt.md" 형식의 파일을 만들고, 프롬프트를 정의해 두면, GitHub Copilot에 채팅할 때 해당 프롬프트(`/PromptName`)를 사용할 수 있습니다. (i.e., 프롬프트 파일은 .prompt.md 파일 확장자를 가진 마크다운 파일입니다.)

Prompt file에 대한 자세한 내용은 [Prompt file structure](https://code.visualstudio.com/docs/copilot/copilot-customization#_prompt-file-structure)을 참고 하시기 바랍니다.

##### Prompt 내용 예시

'Prompt file'에 공통 규칙을 담은 'Instruction file'을 연결할 수 있습니다. 이를 통해 반복되는 Instructions(지침 파일)과 특정 작업에 필요한 고유한 명령(Prompt file)을 조합하여 효율적으로 사용할 수 있습니다.

Example: generate a React form component

```markdown
---
mode: "agent"
model: GPT-4o
tools: ["githubRepo", "codebase"]
description: "Generate a new React form component"
---

Your goal is to generate a new React form component based on the templates in #githubRepo contoso/react-templates.

Ask for the form name and fields if not provided.

Requirements for the form:

- Use form design system components: [design-system/Form.md](../docs/design-system/Form.md)
- Use `react-hook-form` for form state management:
- Always define TypeScript types for your form data
- Prefer _uncontrolled_ components using register
- Use `defaultValues` to prevent unnecessary rerenders
- Use `yup` for validation:
- Create reusable validation schemas in separate files
- Use TypeScript types to ensure type safety
- Customize UX-friendly validation rules
```

Example: perform a security review of a REST API

```markdown
---
mode: "ask"
model: Claude Sonnet 4
description: "Perform a REST API security review"
---

Perform a REST API security review and provide a TODO list of security issues to address.

- Ensure all endpoints are protected by authentication and authorization
- Validate all user inputs and sanitize data
- Implement rate limiting and throttling
- Implement logging and monitoring for security events

Return the TODO list in a Markdown format, grouped by priority and issue type.
```

##### 설정 방법

: 직접 생성 방법

1. 파일 생성하기
   - 프로젝트의 최상위(root) 경로에 `.github/prompts` 디렉토리 만듭니다. (이미 있다면 만들 필요 없음)
   - `.github/prompts/` 디렉토리에 `{PromptName}.prompt.md` 형식의 파일 생성합니다.
2. **Prompt 작성하기**
   - 생성된 `{PromptName}.prompt.md` 파일 안에 **자연어**와 **마크다운(Markdown)** 형식으로 자유롭게 지침을 작성합니다.
   - 참고 - `${variableName}` syntax를 활용하여 다양한 변수를 참조할 수 있습니다.

> - Workspace variables - ${workspaceFolder}, ${workspaceFolderBasename}
> - Selection variables - ${selection}, ${selectedText}
> - File context variables - ${file}, ${fileBasename}, ${fileDirname}, ${fileBasenameNoExtension}
> - Input variables - ${input:variableName}, ${input:variableName:placeholder} (pass values to the prompt from the chat input field)

##### 사용 방법

1. 채팅 뷰 입력 창에 `/`를 입력 후 프롬프트 파일이름을 입력
   - 예) `MyPrompt.prompt.md` 파일을 생성한 경우, 채팅 뷰 입력창에 `/MyPrompt` 를 입력하여 프롬프트 사용

### mc-terrarium에서 instructions 적용 및 활용 경험

> [!NOTE]
> 단순히 예제를 적용하고 실행해 봄

Review-REST-API-security 프롬프트 추가

![](https://i.imgur.com/C71bl4R.png)

`/`를 입력시 리스트에서 프롬프트 선택 가능
![](https://i.imgur.com/zOWJBS8.png)

명령어 입력 결과

![](https://i.imgur.com/ptz7cEY.png)

### References

- https://code.visualstudio.com/docs/copilot/copilot-customization
- https://code.visualstudio.com/docs/copilot/chat/chat-modes
- https://code.visualstudio.com/docs/copilot/chat/prompt-crafting
- https://github.blog/developer-skills/github/how-to-write-better-prompts-for-github-copilot/
