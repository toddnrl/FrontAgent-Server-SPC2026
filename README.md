## CALLBEE

AI의 답변을 실제 고객 업무로 연결하는 Agentic Customer Service Platform입니다.

고객의 채팅·음성 문의를 분석해 업장이 등록한 지식을 기반으로 답변하고, 예약 생성·조회·취소·변경 및 상담원 연결과 같은 실제 업무까지 수행합니다.

## 핵심 구현

### 1. LangGraph 기반 Agent State 관리

사용자의 요청을 단발성으로 처리하지 않고 **LangGraph `AgentState`와 PostgreSQL Checkpoint를 이용해 멀티턴 대화 상태를 유지**하도록 구현했습니다.

세션별로 이전 대화와 Agent 상태를 복원하기 때문에 예약 진행 중 다른 질문을 하더라도 기존 업무 Context를 유지한 채 다시 이어서 처리할 수 있습니다.

```text
User Message
    ↓
AgentState 복원
    ↓
Agent 처리
    ↓
State Update
    ↓
PostgreSQL Checkpoint
```

---

### 2. Code Fast Path + LLM 기반 Agent Routing

모든 사용자 메시지마다 LLM에게 Intent Classification을 요청하지 않고, **코드로 명확하게 판단할 수 있는 요청은 Fast Path에서 먼저 처리**하도록 설계했습니다.

예약 Trigger, 상담원 요청, 세션 종료, 진행 중인 Task 응답 등을 먼저 코드에서 판단하고 자연어 해석이 필요한 경우에만 LLM을 사용합니다.

```text
User Message
    ↓
Code Fast Path
    ├─ Task Trigger
    ├─ Knowledge Question
    ├─ Handoff
    └─ Session End
    ↓
필요한 경우에만 LLM
```

이를 통해 불필요한 LLM 호출을 줄이고 응답 속도와 API 비용을 함께 최적화했습니다.

---

### 3. LLM Function Calling

Agent가 실제 업무를 수행해야 하는 경우 OpenAI Function Calling을 사용합니다.

LLM에게 모든 Backend 함수를 직접 노출하지 않고 다음과 같은 상위 수준 Tool만 제공합니다.

```text
run_task
request_handoff
end_session
```

예를 들어 사용자가 `"예약하고 싶어요"`라고 요청하면 Agent는 `run_task`를 통해 실제 예약 Task Flow를 시작합니다.

```text
LLM
 ↓
run_task
 ↓
Dynamic Task Flow
 ↓
Backend Function
 ↓
Database
```

LLM은 **무엇을 할지 판단**하고, 실제 업무 절차는 Backend가 통제하도록 역할을 분리했습니다.

---

### 4. Dynamic Task Flow

예약 생성·조회·취소 등의 업무를 코드에 고정된 Workflow로 작성하지 않고 **DB에 저장된 Node와 Edge를 따라 동적으로 실행하는 Task Engine**을 구현했습니다.

```text
Task Flow
   ↓
Node
   ↓
Memory Update
   ↓
Edge
   ↓
Next Node
```

지원하는 주요 Node는 다음과 같습니다.

```text
message
ask
instruction
condition
function
end
```

이를 통해 업무 절차가 변경되어도 Backend Workflow 전체를 다시 구현하지 않고 Node와 Edge 구성을 변경하여 새로운 업무 흐름을 만들 수 있습니다.

---

### 5. Task Session & Memory 기반 멀티턴 업무 처리

예약처럼 한 번의 메시지로 끝나지 않는 업무를 처리하기 위해 별도의 **Task Session과 Task Memory**를 관리합니다.

예를 들어 예약 과정에서는 다음 데이터가 대화를 거치며 누적됩니다.

```text
service_item
      ↓
reservation_date
      ↓
reservation_time
      ↓
customer_name
      ↓
customer_phone
```

사용자가 예약 도중 가격을 묻거나 다른 질문을 하더라도 현재까지 수집된 Task Memory를 유지한 상태로 다른 요청을 처리한 뒤 다시 예약 Flow를 이어갈 수 있습니다.

---

### 6. RAG 기반 업장 지식 검색

관리자가 등록한 FAQ, 가격표, 서비스 안내 등의 문서를 기반으로 답변하는 RAG Pipeline을 구현했습니다.

```text
Document
   ↓
Chunking
   ↓
Keyword Extraction
   ↓
Embedding
   ↓
Vector DB

User Question
   ↓
Retrieval
   ↓
Relevant Chunks
   ↓
LLM
   ↓
Answer
```

문서는 Markdown Heading과 문장 경계를 고려하여 Chunking하고 `text-embedding-3-small`을 이용해 Vector Embedding을 생성합니다.

LLM이 자체 지식으로 임의의 정보를 생성하는 것이 아니라 **업장이 실제로 등록한 지식을 검색해 답변 Context로 사용**하도록 구성했습니다.

---

### 7. Task Context 기반 Query Expansion

멀티턴 대화에서는 사용자의 현재 질문만 검색할 경우 Context가 사라질 수 있습니다.

예를 들어:

```text
User : 화장실 청소 예약할게요.
AI   : 언제 예약하시겠어요?
User : 그런데 그거 얼마예요?
```

마지막 질문인 `"그거 얼마예요?"`만 Vector Search하면 정확한 문서를 찾기 어렵습니다.

이를 해결하기 위해 현재 Task Memory의 서비스 Context를 Query에 추가합니다.

```text
그거 얼마예요?
       +
화장실 청소
       +
가격

→ "화장실 청소 가격"
```

즉 별도의 LLM Query Rewrite를 반복 호출하지 않고 **현재 대화와 Task Memory를 활용한 Context-aware Query Expansion**을 적용했습니다.

---

### 8. Hybrid Search

RAG 검색 정확도를 높이기 위해 Vector Search 하나에 의존하지 않고 **Dense Vector Search, Lexical Search, PostgreSQL Full Text Search를 결합한 Hybrid Retrieval​**을 구현했습니다.

```text
Query
  │
  ├─ Dense Vector Search
  │
  ├─ Lexical Search
  │
  └─ PostgreSQL FTS
          ↓
    Candidate Merge
          ↓
    Hybrid Score
```

최종 검색 Score는 기본적으로 다음 비율을 사용합니다.

```text
Final Score
=
Vector Similarity × 0.7
+
Keyword Match Score × 0.3
```

Vector Search로 의미적으로 유사한 문서를 찾고, Keyword Search를 통해 서비스명이나 가격처럼 **정확한 단어가 중요한 정보까지 함께 반영**합니다.

검색 이후에는 Similarity Threshold와 실제 Keyword Evidence를 한 번 더 검사하여 관련성이 낮은 Chunk를 제거합니다.

---

### 9. Knowledge → Service 자동 추출

등록된 지식을 단순한 RAG 검색 데이터로만 사용하는 것이 아니라 **LLM Structured Output을 이용해 문서에서 실제 서비스 정보를 추출**하도록 구현했습니다.

```text
Knowledge Document
       ↓
LLM Structured Extraction
       ↓
Service
       ↓
Service Item
       ↓
Service Option
```

예를 들어 가격표나 서비스 안내 문서를 등록하면 서비스명, 가격, 옵션 등의 정보를 추출하여 실제 예약 Task에서 사용할 수 있는 서비스 데이터로 연결할 수 있습니다.

이를 통해 **지식 검색과 실제 업무 실행 데이터를 하나의 Pipeline으로 연결**했습니다.

---

### 10. Redis 기반 AI Pipeline 최적화

반복적인 AI API 및 DB 호출을 줄이기 위해 Redis Cache를 여러 단계에서 활용했습니다.

```text
Embedding Cache
      +
Semantic Search Cache
      +
Task Session Cache
```

동일한 문장의 Embedding은 Redis에 저장하여 OpenAI Embedding API 재호출을 줄이고, 이전 질문과 의미적으로 매우 유사한 Query는 Semantic Cache의 검색 결과를 재사용합니다.

Task Session 역시 Redis에서 우선 조회하고 Cache Miss 발생 시 PostgreSQL에서 복원하도록 구성했습니다.

이를 통해 **LLM·Embedding API 비용, Vector Search 호출, DB 접근 횟수를 줄이는 방향으로 전체 Agent Pipeline을 최적화​**했습니다.
