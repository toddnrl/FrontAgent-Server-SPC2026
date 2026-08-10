create table if not exists public.builtin_rule_overrides (
  id uuid primary key default gen_random_uuid(),
  organization_id uuid not null references public.organizations(id) on delete cascade,
  builtin_key text not null,
  name text,
  instruction text,
  is_active boolean,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  unique (organization_id, builtin_key)
);

create index if not exists builtin_rule_overrides_organization_id_idx
  on public.builtin_rule_overrides (organization_id);

alter table public.builtin_rule_overrides enable row level security;
