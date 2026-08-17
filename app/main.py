import logging

from fastapi import FastAPI, Request
from fastapi.exception_handlers import request_validation_exception_handler
from fastapi.exceptions import RequestValidationError
from fastapi.middleware.cors import CORSMiddleware

from app.core.config import settings
from app.graph.graph_runtime import lifespan_graph
from app.api import (
    health,
    chat,
    knowledge,
    knowledge_folders,
    services,
    agent_runs,
    conversations,
    rules,
    task_flows,
    voice,
    web_call,
    organization_ai_settings,
    reservations,
    booking_settings,
    calendar,
    products,
    orders,
)

logger = logging.getLogger(__name__)

app = FastAPI(
    title=settings.app_name,
    version=settings.app_version,
    lifespan=lifespan_graph,
)


@app.exception_handler(RequestValidationError)
async def logging_validation_exception_handler(request: Request, exc: RequestValidationError):
    """
    요청 검증 실패(422)를 서버 로그에 남긴다. 응답 형식은 FastAPI 기본
    핸들러에 그대로 위임해 API 계약(응답 바디 구조)은 바꾸지 않는다.

    organization_id처럼 클라이언트가 잘못된 값을 보내는 문제는 지금까지
    로그 없이 조용히 422만 나가서, 운영 중 얼마나 자주 발생하는지 알 방법이
    없었다.
    """
    fields = ", ".join(".".join(str(part) for part in error["loc"]) for error in exc.errors())
    logger.warning("요청 검증 실패 (422): %s %s - 필드: %s", request.method, request.url.path, fields)
    return await request_validation_exception_handler(request, exc)

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "https://front-agent-ai.vercel.app",
        "https://callbee.vercel.app",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 기본 상태 확인 API
app.include_router(health.router)

# 채팅 API (SSE 스트리밍 지원, 웹/전화/웹콜 등 모든 채널 공통)
app.include_router(chat.router)

# 브라우저 WebRTC 음성 통화 세션
app.include_router(voice.router)

# 웹 음성방(web_call) 실시간 WebSocket (ver3.md, 3단계: 텍스트만 우선 처리)
app.include_router(web_call.router)

# 조직별 AI/음성 모델 설정 API
app.include_router(organization_ai_settings.router)

# AI 응답 규칙 관리 API
app.include_router(rules.router)

# 지식 폴더 관리 API
app.include_router(knowledge_folders.router)

# 지식 관리 API
app.include_router(knowledge.router)

# 서비스 관리 API
app.include_router(services.router)

# Agent 실행 로그 API
app.include_router(agent_runs.router)

# 상담방 / 메시지 관리 API
app.include_router(conversations.router)

# 태스크 플로우 테스트 API
app.include_router(task_flows.router)

# 예약 설정 API
app.include_router(booking_settings.router)

# 예약 도메인 API
app.include_router(reservations.router)

# 자체 캘린더 조회 API
app.include_router(calendar.router)

# 상품 도메인 API
app.include_router(products.router)

# 상품 주문 도메인 API
app.include_router(orders.router)

