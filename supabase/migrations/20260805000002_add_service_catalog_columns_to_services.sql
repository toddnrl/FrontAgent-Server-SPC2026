alter table public.services
  add column if not exists approval_status text not null default 'approved'
    check (approval_status in ('pending', 'approved', 'rejected')),
  add column if not exists source_type text,
  add column if not exists source_id uuid references public.knowledge_sources(id) on delete set null,
  add column if not exists confidence numeric,
  add column if not exists raw_payload jsonb,
  add column if not exists extracted_hash text,
  add column if not exists last_extracted_at timestamptz,
  add column if not exists pending_payload jsonb,
  add column if not exists sync_status text,
  add column if not exists approved_at timestamptz,
  add column if not exists approved_by text;

create index if not exists services_source_id_idx
  on public.services (source_id);
