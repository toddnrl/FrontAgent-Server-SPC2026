-- knowledge_folders 원본 테이블 생성.
--
-- 이 테이블은 기존 migration 히스토리에 CREATE TABLE로 캡처되지 않았지만,
-- 이후 세 마이그레이션이 이 테이블이 이미 존재한다고 전제하고 동작한다:
--   1) 20260622000001_create_organizations_and_normalize_organization_id.sql
--      organization_id를 text -> uuid로 정규화하고 organizations FK를 추가한다.
--   2) 20260703000001_knowledge_folder_depth_and_keywords.sql
--      parent_id(uuid, 자기참조 FK)를 추가한다.
--   3) 20260704000003_knowledge_search_active_folder_filter.sql
--      is_active(boolean)를 추가한다.
--
-- 위 마이그레이션들과의 정합성을 위해, organization_id는 같은 시기(6/15)에
-- 만들어진 다른 테이블들(rules, knowledge_sources 등)과 동일하게 text로 생성한다.
-- parent_id, is_active는 위 후속 마이그레이션이 추가하므로 여기서는 만들지 않는다.

create table public.knowledge_folders (
  id uuid primary key default gen_random_uuid(),
  organization_id text not null,
  name text not null,
  description text,
  created_at timestamp without time zone default now(),
  updated_at timestamp without time zone default now()
);
