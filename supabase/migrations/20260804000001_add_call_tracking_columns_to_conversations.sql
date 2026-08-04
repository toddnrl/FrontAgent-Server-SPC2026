-- web_call 채널 통화 시작/종료/길이를 기록하기 위한 컬럼 추가.
-- conversation_repo.py(get_or_create_conversation, end_call_conversation, close_idle_calls)와
-- voice.py(end_voice_call)가 참조하지만 기존 migration에는 없던 컬럼들.
alter table public.conversations
  add column if not exists call_started_at timestamp without time zone,
  add column if not exists call_ended_at timestamp without time zone,
  add column if not exists call_duration_seconds integer;
