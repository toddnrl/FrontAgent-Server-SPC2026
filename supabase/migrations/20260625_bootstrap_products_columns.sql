-- public.products에 대한 두 개의 서로 다른 CREATE TABLE 정의 충돌을 보정한다.
--
-- 20260623000100_create_reservation_domain_tables.sql이 먼저 실행되어
-- 단순한 products 스키마(id, organization_id, name, description, price,
-- duration_minutes, created_at, updated_at)를 만든다.
--
-- 이후 20260625_create_products.sql은 `create table if not exists`라서
-- 테이블이 이미 있으면 CREATE TABLE 자체는 조용히 무시되지만, 뒤이은
-- `create index ... on public.products (category)` 등은 실행되어
-- 실제로는 없는 컬럼(category, sku, stock_quantity, options, image_urls 등)을
-- 참조하다가 오류가 난다.
--
-- 기존 migration 파일은 수정하지 않고, 20260625_create_products.sql 실행 전에
-- 이 파일에서 누락된 컬럼만 먼저 채워 넣어 정합성을 맞춘다.
-- (모두 add column if not exists이며 기존 데이터/컬럼을 삭제하지 않는다.)

alter table public.products
  add column if not exists short_description text,
  add column if not exists category text,
  add column if not exists sku text,
  add column if not exists currency text default 'KRW',
  add column if not exists stock_quantity int default 0,
  add column if not exists main_image_url text,
  add column if not exists image_urls jsonb default '[]'::jsonb,
  add column if not exists options jsonb default '{}'::jsonb,
  add column if not exists detail_info jsonb default '{}'::jsonb,
  add column if not exists is_active boolean default true,
  add column if not exists source_type text default 'manual',
  add column if not exists source_ref text;
