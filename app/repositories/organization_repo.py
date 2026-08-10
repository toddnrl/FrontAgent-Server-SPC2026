import re

from app.core.db import supabase
from app.repositories.organization_ai_settings_repo import get_ai_settings

# organizations 테이블의 id는 UUID 컬럼이라, 형식이 다른 값을 그대로 쿼리에
# 넘기면 PostgREST가 22P02(invalid input syntax for type uuid)로 500을 낸다.
# 여기서 형식만 먼저 검증해 API 계층이 4xx로 깔끔하게 거절할 수 있게 한다.
# 알 수 없는 값을 임의의 UUID로 치환하지는 않는다.
ORGANIZATION_ID_PATTERN = r"^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$"
_ORGANIZATION_ID_RE = re.compile(ORGANIZATION_ID_PATTERN, re.IGNORECASE)


def is_valid_organization_id(organization_id: str | None) -> bool:
    return bool(organization_id) and bool(_ORGANIZATION_ID_RE.match(organization_id))


def get_organization(organization_id: str) -> dict | None:
    result = (
        supabase.table("organizations")
        .select("id, name, llm_provider, llm_model")
        .eq("id", organization_id)
        .single()
        .execute()
    )
    organization = result.data
    if not organization:
        return None

    ai_settings = get_ai_settings(organization_id)

    return {
        **organization,
        "llm_provider": ai_settings.get("llm_provider") or organization.get("llm_provider"),
        "llm_model": ai_settings.get("llm_model") or organization.get("llm_model"),
        "decision_model": ai_settings.get("decision_model"),
        "voice_response_style": ai_settings.get("voice_response_style", "friendly_short"),
    }
