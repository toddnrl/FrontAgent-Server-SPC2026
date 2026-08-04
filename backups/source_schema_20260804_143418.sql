--
-- PostgreSQL database dump
--

\restrict tN0uclBnk7EjDhT4bbkd4K34WyCVksrl2E7sWeYOQflacWxeDbbYr182DyZETFy

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.10 (Debian 17.10-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: delete_knowledge_folder_keep_contents(uuid, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.delete_knowledge_folder_keep_contents(organization_id_input uuid, folder_id_input uuid) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
  deleted_count integer;
begin
  -- 1. 해당 폴더 + 모든 하위 폴더의 지식 소스를 미분류로 이동
  update public.knowledge_sources
  set
    folder_id = null,
    updated_at = now()
  where organization_id = organization_id_input
    and folder_id in (
      select id from public.knowledge_folders
      where organization_id = organization_id_input
        and (id = folder_id_input or parent_id = folder_id_input)
    );

  -- 2. 해당 폴더 + 모든 하위 폴더의 지식 청크도 미분류로 이동
  update public.knowledge_chunks
  set folder_id = null
  where organization_id = organization_id_input
    and folder_id in (
      select id from public.knowledge_folders
      where organization_id = organization_id_input
        and (id = folder_id_input or parent_id = folder_id_input)
    );

  -- 3. 폴더 삭제 (cascade로 하위 폴더도 함께 삭제됨)
  delete from public.knowledge_folders
  where organization_id = organization_id_input
    and id = folder_id_input;

  get diagnostics deleted_count = row_count;

  return deleted_count > 0;
end;
$$;


--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
begin
  insert into public.users (id, email)
  values (new.id, new.email);
  return new;
end;
$$;


--
-- Name: increment_knowledge_reference_count(uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.increment_knowledge_reference_count(source_id_input uuid) RETURNS void
    LANGUAGE sql
    AS $$
  update public.knowledge_sources
  set reference_count = reference_count + 1
  where id = source_id_input;
$$;


--
-- Name: match_knowledge_chunks(public.vector, uuid, integer, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.match_knowledge_chunks(query_embedding public.vector, match_organization_id uuid, match_count integer, match_folder_id uuid DEFAULT NULL::uuid) RETURNS TABLE(id uuid, source_id uuid, source_title text, folder_id uuid, content text, metadata jsonb, similarity double precision)
    LANGUAGE sql
    AS $$
  SELECT
    kc.id,
    kc.source_id,
    ks.title AS source_title,
    kc.folder_id,
    kc.content,
    kc.metadata,
    1 - (kc.embedding <=> query_embedding) AS similarity
  FROM public.knowledge_chunks kc
  JOIN public.knowledge_sources ks ON ks.id = kc.source_id
  WHERE kc.organization_id = match_organization_id
    AND kc.embedding IS NOT NULL
    AND ks.status = 'indexed'
    AND ks.is_referenced = true
    AND (
      kc.folder_id IS NULL
      OR EXISTS (
        SELECT 1
        FROM public.knowledge_folders kf
        WHERE kf.id = kc.folder_id
          AND kf.organization_id = match_organization_id
          AND kf.is_active = true
      )
    )
    AND (
      match_folder_id IS NULL
      OR kc.folder_id = match_folder_id
    )
  ORDER BY kc.embedding <=> query_embedding
  LIMIT match_count;
$$;


--
-- Name: match_knowledge_chunks_hybrid(public.vector, text[], uuid, integer, uuid, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.match_knowledge_chunks_hybrid(query_embedding public.vector, query_keywords text[], match_organization_id uuid, match_count integer DEFAULT 5, match_folder_id uuid DEFAULT NULL::uuid, vector_weight double precision DEFAULT 0.7, keyword_weight double precision DEFAULT 0.3) RETURNS TABLE(id uuid, source_id uuid, source_title text, folder_id uuid, content text, metadata jsonb, keywords text[], similarity double precision)
    LANGUAGE sql
    AS $$
  WITH filtered_keywords AS (
    SELECT array_agg(DISTINCT lower(k)) AS kws
    FROM unnest(coalesce(query_keywords, '{}'::text[])) AS k
    WHERE length(k) >= 2
  ),
  fts_keywords AS (
    SELECT array_agg(DISTINCT qk) AS kws
    FROM filtered_keywords fk,
      unnest(fk.kws) qk
    WHERE qk !~ '[[:space:]]' AND qk !~ '[^a-zA-Z0-9가-힣]'
  ),
  vector_results AS (
    SELECT
      kc.id,
      kc.source_id,
      ks.title AS source_title,
      kc.folder_id,
      kc.content,
      kc.metadata,
      kc.keywords,
      1 - (kc.embedding <=> query_embedding) AS vector_score
    FROM knowledge_chunks kc
    JOIN knowledge_sources ks ON ks.id = kc.source_id
    WHERE
      kc.organization_id = match_organization_id
      AND kc.embedding IS NOT NULL
      AND ks.status = 'indexed'
      AND ks.is_referenced = true
      AND (
        kc.folder_id IS NULL
        OR EXISTS (
          SELECT 1
          FROM knowledge_folders kf
          WHERE kf.id = kc.folder_id
            AND kf.organization_id = match_organization_id
            AND kf.is_active = true
        )
      )
      AND (match_folder_id IS NULL OR kc.folder_id = match_folder_id)
    ORDER BY kc.embedding <=> query_embedding
    LIMIT match_count * 5
  ),
  lexical_results AS (
    SELECT
      kc.id,
      kc.source_id,
      ks.title AS source_title,
      kc.folder_id,
      kc.content,
      kc.metadata,
      kc.keywords,
      0.0::float AS vector_score
    FROM knowledge_chunks kc
    JOIN knowledge_sources ks ON ks.id = kc.source_id
    CROSS JOIN filtered_keywords fk
    WHERE
      kc.organization_id = match_organization_id
      AND kc.embedding IS NOT NULL
      AND ks.status = 'indexed'
      AND ks.is_referenced = true
      AND (
        kc.folder_id IS NULL
        OR EXISTS (
          SELECT 1
          FROM knowledge_folders kf
          WHERE kf.id = kc.folder_id
            AND kf.organization_id = match_organization_id
            AND kf.is_active = true
        )
      )
      AND (match_folder_id IS NULL OR kc.folder_id = match_folder_id)
      AND fk.kws IS NOT NULL
      AND EXISTS (
        SELECT 1
        FROM unnest(fk.kws) qk
        WHERE kc.content ILIKE ('%' || qk || '%')
      )
  ),
  fts_results AS (
    SELECT
      kc.id,
      kc.source_id,
      ks.title AS source_title,
      kc.folder_id,
      kc.content,
      kc.metadata,
      kc.keywords,
      0.0::float AS vector_score
    FROM knowledge_chunks kc
    JOIN knowledge_sources ks ON ks.id = kc.source_id
    CROSS JOIN fts_keywords fk
    WHERE
      kc.organization_id = match_organization_id
      AND kc.embedding IS NOT NULL
      AND ks.status = 'indexed'
      AND ks.is_referenced = true
      AND (
        kc.folder_id IS NULL
        OR EXISTS (
          SELECT 1
          FROM knowledge_folders kf
          WHERE kf.id = kc.folder_id
            AND kf.organization_id = match_organization_id
            AND kf.is_active = true
        )
      )
      AND (match_folder_id IS NULL OR kc.folder_id = match_folder_id)
      AND fk.kws IS NOT NULL
      AND array_length(fk.kws, 1) > 0
      AND kc.content_tsv @@ to_tsquery(
        'simple',
        (
          SELECT string_agg(replace(qk, '''', ''''''), ' | ')
          FROM unnest(fk.kws) qk
        )
      )
  ),
  combined AS (
    SELECT DISTINCT ON (id)
      id,
      source_id,
      source_title,
      folder_id,
      content,
      metadata,
      keywords,
      vector_score
    FROM (
      SELECT * FROM vector_results
      UNION ALL
      SELECT * FROM lexical_results
      UNION ALL
      SELECT * FROM fts_results
    ) all_candidates
    ORDER BY id, vector_score DESC
  ),
  keyword_scores AS (
    SELECT
      c.*,
      CASE
        WHEN fk.kws IS NOT NULL AND array_length(fk.kws, 1) > 0
        THEN (
          SELECT count(*)::float / array_length(fk.kws, 1)
          FROM unnest(fk.kws) qk
          WHERE
            lower(qk) = ANY(
              SELECT lower(k) FROM unnest(coalesce(c.keywords, '{}'::text[])) k
            )
            OR c.content ILIKE ('%' || qk || '%')
        )
        ELSE 0.0
      END AS keyword_score
    FROM combined c
    CROSS JOIN filtered_keywords fk
  )
  SELECT
    id,
    source_id,
    source_title,
    folder_id,
    content,
    metadata,
    keywords,
    (vector_weight * vector_score + keyword_weight * keyword_score)::float AS similarity
  FROM keyword_scores
  ORDER BY similarity DESC
  LIMIT match_count;
$$;


--
-- Name: match_knowledge_semantic_cache(public.vector, text, uuid, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.match_knowledge_semantic_cache(query_embedding public.vector, match_organization_id text, match_folder_id uuid DEFAULT NULL::uuid, match_threshold double precision DEFAULT 0.93) RETURNS TABLE(result jsonb, similarity double precision)
    LANGUAGE sql
    AS $$
  select
    ksc.result,
    1 - (ksc.query_embedding <=> query_embedding) as similarity
  from public.knowledge_semantic_cache ksc
  where ksc.organization_id = match_organization_id
    and (
      match_folder_id is null
      or ksc.folder_id = match_folder_id
    )
  order by ksc.query_embedding <=> query_embedding
  limit 1;
$$;


--
-- Name: set_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
  new.updated_at = now();
  return new;
end;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: agent_runs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_runs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    session_id text NOT NULL,
    user_message text NOT NULL,
    intent text,
    applied_rules jsonb DEFAULT '[]'::jsonb,
    used_knowledge jsonb DEFAULT '[]'::jsonb,
    final_response text,
    status text DEFAULT 'success'::text NOT NULL,
    error_message text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: ai_usage_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ai_usage_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    conversation_id uuid,
    session_id text,
    channel text,
    feature text NOT NULL,
    provider text DEFAULT 'openai'::text NOT NULL,
    model text NOT NULL,
    input_tokens integer,
    output_tokens integer,
    total_tokens integer,
    audio_duration_ms integer,
    audio_bytes integer,
    text_chars integer,
    estimated_cost_cents integer,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT ai_usage_logs_feature_check CHECK ((feature = ANY (ARRAY['chat'::text, 'stt'::text, 'tts'::text, 'realtime'::text])))
);


--
-- Name: booking_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_settings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id text NOT NULL,
    name text DEFAULT '대표 예약 캘린더'::text NOT NULL,
    timezone text DEFAULT 'Asia/Seoul'::text NOT NULL,
    slot_interval_minutes integer DEFAULT 30 NOT NULL,
    min_notice_minutes integer DEFAULT 60 NOT NULL,
    max_days_ahead integer DEFAULT 30 NOT NULL,
    requires_approval boolean DEFAULT true NOT NULL,
    allow_customer_cancel boolean DEFAULT true NOT NULL,
    weekly_hours jsonb DEFAULT '[]'::jsonb NOT NULL,
    exceptions jsonb DEFAULT '[]'::jsonb NOT NULL,
    service_policy_overrides jsonb DEFAULT '{}'::jsonb NOT NULL,
    legacy_calendar_ids jsonb DEFAULT '[]'::jsonb NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT booking_settings_max_days_ahead_check CHECK ((max_days_ahead > 0)),
    CONSTRAINT booking_settings_min_notice_check CHECK ((min_notice_minutes >= 0)),
    CONSTRAINT booking_settings_slot_interval_check CHECK ((slot_interval_minutes > 0))
);


--
-- Name: builtin_rule_overrides; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.builtin_rule_overrides (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    builtin_key text NOT NULL,
    name text,
    instruction text,
    is_active boolean,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: TABLE builtin_rule_overrides; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.builtin_rule_overrides IS '코드에 고정된 빌트인 규칙(BUILTIN_RULES) 3개에 대한 조직별 오버라이드. row가 없으면 코드 기본값을 그대로 쓰고, row가 있으면 그 필드만 기본값을 덮어쓴다. "기본값으로 복구"는 이 row를 삭제하는 것과 같다.';


--
-- Name: calendar_integrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.calendar_integrations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    provider text DEFAULT 'google'::text NOT NULL,
    account_email text,
    account_name text,
    external_calendar_id text DEFAULT 'primary'::text NOT NULL,
    access_token text,
    refresh_token text,
    token_type text DEFAULT 'Bearer'::text,
    expires_at timestamp with time zone,
    scopes text[] DEFAULT ARRAY['https://www.googleapis.com/auth/calendar.events'::text] NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    last_error text,
    connected_at timestamp with time zone,
    disconnected_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT calendar_integrations_provider_check CHECK ((provider = ANY (ARRAY['google'::text, 'outlook'::text]))),
    CONSTRAINT calendar_integrations_status_check CHECK ((status = ANY (ARRAY['pending'::text, 'connected'::text, 'disconnected'::text, 'failed'::text])))
);


--
-- Name: checkpoint_blobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.checkpoint_blobs (
    thread_id text NOT NULL,
    checkpoint_ns text DEFAULT ''::text NOT NULL,
    channel text NOT NULL,
    version text NOT NULL,
    type text NOT NULL,
    blob bytea
);


--
-- Name: checkpoint_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.checkpoint_migrations (
    v integer NOT NULL
);


--
-- Name: checkpoint_writes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.checkpoint_writes (
    thread_id text NOT NULL,
    checkpoint_ns text DEFAULT ''::text NOT NULL,
    checkpoint_id text NOT NULL,
    task_id text NOT NULL,
    idx integer NOT NULL,
    channel text NOT NULL,
    type text,
    blob bytea NOT NULL,
    task_path text DEFAULT ''::text NOT NULL
);


--
-- Name: checkpoints; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.checkpoints (
    thread_id text NOT NULL,
    checkpoint_ns text DEFAULT ''::text NOT NULL,
    checkpoint_id text NOT NULL,
    parent_checkpoint_id text,
    type text,
    checkpoint jsonb NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: conversation_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.conversation_messages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    conversation_id uuid NOT NULL,
    sender_type text NOT NULL,
    sender_name text,
    message text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: conversations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.conversations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    session_id text NOT NULL,
    channel text DEFAULT 'web_chat'::text NOT NULL,
    customer_id uuid,
    customer_name text,
    customer_email text,
    customer_phone text,
    status text DEFAULT 'open'::text NOT NULL,
    assigned_admin_id uuid,
    last_message text,
    last_message_at timestamp without time zone DEFAULT now(),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    ai_enabled boolean DEFAULT true,
    call_started_at timestamp without time zone,
    call_ended_at timestamp without time zone,
    call_duration_seconds integer,
    idle_warned_at timestamp without time zone
);


--
-- Name: customers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    name text NOT NULL,
    phone text,
    email text,
    memo text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_guest boolean DEFAULT true
);


--
-- Name: knowledge_chunks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.knowledge_chunks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    source_id uuid,
    folder_id uuid,
    chunk_index integer NOT NULL,
    content text NOT NULL,
    embedding public.vector(1536),
    metadata jsonb DEFAULT '{}'::jsonb,
    created_at timestamp without time zone DEFAULT now(),
    keywords text[] DEFAULT '{}'::text[],
    content_tsv tsvector GENERATED ALWAYS AS (to_tsvector('simple'::regconfig, COALESCE(content, ''::text))) STORED
);


--
-- Name: knowledge_folders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.knowledge_folders (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    name text NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    parent_id uuid,
    is_active boolean DEFAULT true NOT NULL
);


--
-- Name: knowledge_semantic_cache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.knowledge_semantic_cache (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id text NOT NULL,
    folder_id uuid,
    query_embedding public.vector NOT NULL,
    result jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: knowledge_sources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.knowledge_sources (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    folder_id uuid,
    title text NOT NULL,
    source_type text DEFAULT 'text'::text NOT NULL,
    file_url text,
    file_name text,
    mime_type text,
    status text DEFAULT 'indexed'::text NOT NULL,
    is_referenced boolean DEFAULT true,
    resolution_rate numeric DEFAULT 0,
    reference_count integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    storage_bucket text,
    storage_path text,
    file_size bigint,
    checksum_sha256 text
);


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    order_id uuid NOT NULL,
    product_id uuid,
    product_name text NOT NULL,
    product_sku text,
    quantity integer DEFAULT 1 NOT NULL,
    unit_price integer DEFAULT 0 NOT NULL,
    total_price integer DEFAULT 0 NOT NULL,
    selected_options jsonb DEFAULT '{}'::jsonb,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT order_items_quantity_check CHECK ((quantity > 0)),
    CONSTRAINT order_items_total_price_check CHECK ((total_price >= 0)),
    CONSTRAINT order_items_unit_price_check CHECK ((unit_price >= 0))
);


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    order_code text,
    customer_name text NOT NULL,
    customer_phone text NOT NULL,
    customer_email text,
    order_status text DEFAULT 'requested'::text NOT NULL,
    payment_status text DEFAULT 'unpaid'::text NOT NULL,
    delivery_status text DEFAULT 'pending'::text NOT NULL,
    recipient_name text,
    recipient_phone text,
    postal_code text,
    address_line1 text,
    address_line2 text,
    delivery_memo text,
    courier_name text,
    tracking_number text,
    total_amount integer DEFAULT 0 NOT NULL,
    currency text DEFAULT 'KRW'::text NOT NULL,
    source_channel text DEFAULT 'web_chat'::text NOT NULL,
    memo text,
    shipped_at timestamp with time zone,
    delivered_at timestamp with time zone,
    cancelled_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT orders_delivery_status_check CHECK ((delivery_status = ANY (ARRAY['pending'::text, 'preparing'::text, 'shipped'::text, 'delivered'::text, 'failed'::text]))),
    CONSTRAINT orders_order_status_check CHECK ((order_status = ANY (ARRAY['requested'::text, 'confirmed'::text, 'preparing'::text, 'shipped'::text, 'delivered'::text, 'cancelled'::text]))),
    CONSTRAINT orders_payment_status_check CHECK ((payment_status = ANY (ARRAY['unpaid'::text, 'paid'::text, 'failed'::text, 'refunded'::text])))
);


--
-- Name: organization_ai_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organization_ai_settings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    llm_provider text DEFAULT 'openai'::text NOT NULL,
    llm_model text DEFAULT 'gpt-4.1-mini'::text NOT NULL,
    decision_model text,
    voice_enabled boolean DEFAULT true NOT NULL,
    voice_mode text DEFAULT 'pipeline'::text NOT NULL,
    voice_stt_model text DEFAULT 'gpt-4o-mini-transcribe'::text NOT NULL,
    voice_tts_model text DEFAULT 'gpt-4o-mini-tts'::text NOT NULL,
    voice_tts_voice text DEFAULT 'marin'::text NOT NULL,
    realtime_model text DEFAULT 'gpt-realtime-2'::text NOT NULL,
    realtime_voice text DEFAULT 'marin'::text NOT NULL,
    voice_response_style text DEFAULT 'friendly_short'::text NOT NULL,
    monthly_budget_limit_cents integer,
    monthly_token_limit integer,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    voice_stt_provider text DEFAULT 'openai'::text NOT NULL,
    voice_tts_provider text DEFAULT 'openai'::text NOT NULL,
    elevenlabs_model text,
    elevenlabs_voice_id text,
    CONSTRAINT organization_ai_settings_voice_mode_check CHECK ((voice_mode = ANY (ARRAY['pipeline'::text, 'realtime'::text]))),
    CONSTRAINT organization_ai_settings_voice_response_style_check CHECK ((voice_response_style = ANY (ARRAY['friendly_short'::text, 'professional_short'::text, 'casual_short'::text]))),
    CONSTRAINT organization_ai_settings_voice_stt_provider_check CHECK ((voice_stt_provider = ANY (ARRAY['openai'::text, 'clova'::text])))
);


--
-- Name: organization_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organization_members (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    user_id uuid NOT NULL,
    role text DEFAULT 'member'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organizations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    llm_provider text DEFAULT 'openai'::text NOT NULL,
    llm_model text DEFAULT 'gpt-4.1-mini'::text NOT NULL,
    decision_model text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: COLUMN organizations.decision_model; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.organizations.decision_model IS 'intent 분류(decision_node)에 사용할 가벼운/빠른 모델. null이면 llm_model을 그대로 사용한다.';


--
-- Name: reservation_calendar_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reservation_calendar_events (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id text NOT NULL,
    reservation_id uuid NOT NULL,
    provider text DEFAULT 'google'::text NOT NULL,
    external_event_id text,
    external_event_url text,
    sync_status text DEFAULT 'pending'::text NOT NULL,
    error_message text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    external_calendar_id text,
    CONSTRAINT reservation_calendar_events_provider_check CHECK ((provider = ANY (ARRAY['google'::text, 'outlook'::text, 'internal'::text]))),
    CONSTRAINT reservation_calendar_events_sync_status_check CHECK ((sync_status = ANY (ARRAY['pending'::text, 'synced'::text, 'failed'::text, 'cancelled'::text])))
);


--
-- Name: reservations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reservations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    conversation_id uuid,
    customer_id uuid,
    service_id uuid,
    customer_name text,
    customer_phone text,
    customer_email text,
    start_at timestamp with time zone NOT NULL,
    end_at timestamp with time zone NOT NULL,
    timezone text DEFAULT 'Asia/Seoul'::text,
    status text DEFAULT 'requested'::text,
    source_channel text DEFAULT 'web_chat'::text,
    memo text,
    created_by text DEFAULT 'ai'::text,
    confirmed_at timestamp with time zone,
    cancelled_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    service_item_id uuid,
    selected_options jsonb DEFAULT '[]'::jsonb NOT NULL,
    total_price integer DEFAULT 0 NOT NULL,
    ordered_summary jsonb DEFAULT '{}'::jsonb NOT NULL,
    CONSTRAINT reservations_created_by_check CHECK ((created_by = ANY (ARRAY['ai'::text, 'admin'::text, 'customer'::text]))),
    CONSTRAINT reservations_source_channel_check CHECK ((source_channel = ANY (ARRAY['web_chat'::text, 'phone'::text, 'kakao'::text, 'admin'::text]))),
    CONSTRAINT reservations_status_check CHECK ((status = ANY (ARRAY['requested'::text, 'confirmed'::text, 'cancelled'::text, 'rejected'::text, 'completed'::text, 'no_show'::text]))),
    CONSTRAINT reservations_time_check CHECK ((start_at < end_at))
);


--
-- Name: rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rules (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    name text NOT NULL,
    instruction text NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- Name: service_item_options; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.service_item_options (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    service_item_id uuid NOT NULL,
    option_group text NOT NULL,
    option_value text NOT NULL,
    additional_price integer DEFAULT 0,
    additional_duration integer DEFAULT 0,
    is_available boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    raw_payload jsonb DEFAULT '{}'::jsonb,
    description text,
    source_id text,
    approval_status text DEFAULT 'pending'::text NOT NULL,
    sync_status text DEFAULT 'synced'::text NOT NULL,
    pending_payload jsonb,
    approved_at timestamp with time zone,
    approved_by text
);


--
-- Name: service_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.service_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    service_id uuid NOT NULL,
    name text NOT NULL,
    description text,
    base_price integer DEFAULT 0,
    duration_minutes integer DEFAULT 0,
    is_available boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    raw_payload jsonb DEFAULT '{}'::jsonb,
    source_id text,
    approval_status text DEFAULT 'pending'::text NOT NULL,
    sync_status text DEFAULT 'synced'::text NOT NULL,
    pending_payload jsonb,
    approved_at timestamp with time zone,
    approved_by text
);


--
-- Name: services; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.services (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    name text NOT NULL,
    description text,
    price integer,
    currency text DEFAULT 'KRW'::text,
    duration_minutes integer,
    is_reservable boolean DEFAULT true,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    approval_status text DEFAULT 'approved'::text NOT NULL,
    source_type text DEFAULT 'manual'::text NOT NULL,
    source_id uuid,
    confidence numeric,
    raw_payload jsonb DEFAULT '{}'::jsonb NOT NULL,
    pending_payload jsonb,
    sync_status text DEFAULT 'synced'::text NOT NULL,
    extracted_hash text,
    last_extracted_at timestamp without time zone,
    approved_at timestamp without time zone,
    approved_by text,
    rejected_reason text,
    CONSTRAINT services_approval_status_check CHECK ((approval_status = ANY (ARRAY['pending'::text, 'approved'::text, 'rejected'::text]))),
    CONSTRAINT services_duration_minutes_check CHECK ((duration_minutes > 0)),
    CONSTRAINT services_price_check CHECK (((price IS NULL) OR (price >= 0))),
    CONSTRAINT services_sync_status_check CHECK ((sync_status = ANY (ARRAY['synced'::text, 'needs_review'::text, 'stale'::text])))
);


--
-- Name: task_edges; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.task_edges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    flow_id uuid NOT NULL,
    source_node_key text NOT NULL,
    target_node_key text NOT NULL,
    edge_type text DEFAULT 'single'::text,
    condition_type text DEFAULT 'always'::text,
    condition_config jsonb DEFAULT '{}'::jsonb,
    is_failure_edge boolean DEFAULT false,
    priority integer DEFAULT 100,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT task_edges_edge_type_check CHECK ((edge_type = ANY (ARRAY['single'::text, 'condition'::text, 'failure'::text, 'fallback'::text])))
);


--
-- Name: task_flows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.task_flows (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    name text NOT NULL,
    description text,
    trigger_intent text,
    trigger_description text,
    trigger_examples jsonb DEFAULT '[]'::jsonb,
    allowed_channels jsonb DEFAULT '["chat", "voice"]'::jsonb,
    filters jsonb DEFAULT '{}'::jsonb,
    is_enabled boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: task_nodes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.task_nodes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    flow_id uuid NOT NULL,
    node_key text NOT NULL,
    node_type text NOT NULL,
    label text NOT NULL,
    config jsonb DEFAULT '{}'::jsonb,
    code text,
    position_x integer DEFAULT 0,
    position_y integer DEFAULT 0,
    timeout_seconds integer DEFAULT 10,
    retry_limit integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT task_nodes_node_type_check CHECK ((node_type = ANY (ARRAY['message'::text, 'ask'::text, 'instruction'::text, 'function'::text, 'condition'::text, 'complete'::text, 'end'::text, 'handoff'::text, 'human_approval'::text, 'code'::text])))
);


--
-- Name: task_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.task_sessions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    session_id text NOT NULL,
    flow_id uuid NOT NULL,
    current_node_key text NOT NULL,
    waiting_node_key text,
    variables jsonb DEFAULT '{}'::jsonb,
    status text DEFAULT 'running'::text,
    approval_status text,
    last_error jsonb,
    expires_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT task_sessions_status_check CHECK ((status = ANY (ARRAY['running'::text, 'waiting_user_input'::text, 'approval_waiting'::text, 'completed'::text, 'cancelled'::text, 'handoff'::text, 'failed'::text, 'expired'::text])))
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    email text NOT NULL,
    name text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: agent_runs agent_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_runs
    ADD CONSTRAINT agent_runs_pkey PRIMARY KEY (id);


--
-- Name: ai_usage_logs ai_usage_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_usage_logs
    ADD CONSTRAINT ai_usage_logs_pkey PRIMARY KEY (id);


--
-- Name: booking_settings booking_settings_organization_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_settings
    ADD CONSTRAINT booking_settings_organization_id_key UNIQUE (organization_id);


--
-- Name: booking_settings booking_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_settings
    ADD CONSTRAINT booking_settings_pkey PRIMARY KEY (id);


--
-- Name: builtin_rule_overrides builtin_rule_overrides_organization_id_builtin_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.builtin_rule_overrides
    ADD CONSTRAINT builtin_rule_overrides_organization_id_builtin_key_key UNIQUE (organization_id, builtin_key);


--
-- Name: builtin_rule_overrides builtin_rule_overrides_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.builtin_rule_overrides
    ADD CONSTRAINT builtin_rule_overrides_pkey PRIMARY KEY (id);


--
-- Name: calendar_integrations calendar_integrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendar_integrations
    ADD CONSTRAINT calendar_integrations_pkey PRIMARY KEY (id);


--
-- Name: checkpoint_blobs checkpoint_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.checkpoint_blobs
    ADD CONSTRAINT checkpoint_blobs_pkey PRIMARY KEY (thread_id, checkpoint_ns, channel, version);


--
-- Name: checkpoint_migrations checkpoint_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.checkpoint_migrations
    ADD CONSTRAINT checkpoint_migrations_pkey PRIMARY KEY (v);


--
-- Name: checkpoint_writes checkpoint_writes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.checkpoint_writes
    ADD CONSTRAINT checkpoint_writes_pkey PRIMARY KEY (thread_id, checkpoint_ns, checkpoint_id, task_id, idx);


--
-- Name: checkpoints checkpoints_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.checkpoints
    ADD CONSTRAINT checkpoints_pkey PRIMARY KEY (thread_id, checkpoint_ns, checkpoint_id);


--
-- Name: conversation_messages conversation_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversation_messages
    ADD CONSTRAINT conversation_messages_pkey PRIMARY KEY (id);


--
-- Name: conversations conversations_organization_id_session_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_organization_id_session_id_key UNIQUE (organization_id, session_id);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: knowledge_chunks knowledge_chunks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_chunks
    ADD CONSTRAINT knowledge_chunks_pkey PRIMARY KEY (id);


--
-- Name: knowledge_folders knowledge_folders_organization_id_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_folders
    ADD CONSTRAINT knowledge_folders_organization_id_name_key UNIQUE (organization_id, name);


--
-- Name: knowledge_folders knowledge_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_folders
    ADD CONSTRAINT knowledge_folders_pkey PRIMARY KEY (id);


--
-- Name: knowledge_semantic_cache knowledge_semantic_cache_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_semantic_cache
    ADD CONSTRAINT knowledge_semantic_cache_pkey PRIMARY KEY (id);


--
-- Name: knowledge_sources knowledge_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_sources
    ADD CONSTRAINT knowledge_sources_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: organization_ai_settings organization_ai_settings_organization_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_ai_settings
    ADD CONSTRAINT organization_ai_settings_organization_id_key UNIQUE (organization_id);


--
-- Name: organization_ai_settings organization_ai_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_ai_settings
    ADD CONSTRAINT organization_ai_settings_pkey PRIMARY KEY (id);


--
-- Name: organization_members organization_members_organization_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_members
    ADD CONSTRAINT organization_members_organization_id_user_id_key UNIQUE (organization_id, user_id);


--
-- Name: organization_members organization_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_members
    ADD CONSTRAINT organization_members_pkey PRIMARY KEY (id);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: reservation_calendar_events reservation_calendar_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservation_calendar_events
    ADD CONSTRAINT reservation_calendar_events_pkey PRIMARY KEY (id);


--
-- Name: reservations reservations_pkey1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey1 PRIMARY KEY (id);


--
-- Name: rules rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rules
    ADD CONSTRAINT rules_pkey PRIMARY KEY (id);


--
-- Name: service_item_options service_item_options_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_item_options
    ADD CONSTRAINT service_item_options_pkey PRIMARY KEY (id);


--
-- Name: service_items service_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_items
    ADD CONSTRAINT service_items_pkey PRIMARY KEY (id);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: task_edges task_edges_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_edges
    ADD CONSTRAINT task_edges_pkey PRIMARY KEY (id);


--
-- Name: task_flows task_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_flows
    ADD CONSTRAINT task_flows_pkey PRIMARY KEY (id);


--
-- Name: task_nodes task_nodes_flow_id_node_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_nodes
    ADD CONSTRAINT task_nodes_flow_id_node_key_key UNIQUE (flow_id, node_key);


--
-- Name: task_nodes task_nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_nodes
    ADD CONSTRAINT task_nodes_pkey PRIMARY KEY (id);


--
-- Name: task_sessions task_sessions_organization_id_session_id_flow_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_sessions
    ADD CONSTRAINT task_sessions_organization_id_session_id_flow_id_key UNIQUE (organization_id, session_id, flow_id);


--
-- Name: task_sessions task_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_sessions
    ADD CONSTRAINT task_sessions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: ai_usage_logs_organization_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ai_usage_logs_organization_created_at_idx ON public.ai_usage_logs USING btree (organization_id, created_at DESC);


--
-- Name: ai_usage_logs_organization_feature_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ai_usage_logs_organization_feature_created_at_idx ON public.ai_usage_logs USING btree (organization_id, feature, created_at DESC);


--
-- Name: checkpoint_blobs_thread_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX checkpoint_blobs_thread_id_idx ON public.checkpoint_blobs USING btree (thread_id);


--
-- Name: checkpoint_writes_thread_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX checkpoint_writes_thread_id_idx ON public.checkpoint_writes USING btree (thread_id);


--
-- Name: checkpoints_thread_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX checkpoints_thread_id_idx ON public.checkpoints USING btree (thread_id);


--
-- Name: idx_booking_settings_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_booking_settings_organization_id ON public.booking_settings USING btree (organization_id);


--
-- Name: idx_calendar_integrations_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_calendar_integrations_organization_id ON public.calendar_integrations USING btree (organization_id);


--
-- Name: idx_calendar_integrations_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_calendar_integrations_provider ON public.calendar_integrations USING btree (provider);


--
-- Name: idx_customers_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_customers_name ON public.customers USING btree (name);


--
-- Name: idx_customers_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_customers_organization_id ON public.customers USING btree (organization_id);


--
-- Name: idx_customers_organization_phone; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_customers_organization_phone ON public.customers USING btree (organization_id, phone);


--
-- Name: idx_customers_phone; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_customers_phone ON public.customers USING btree (phone);


--
-- Name: idx_knowledge_chunks_folder; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_knowledge_chunks_folder ON public.knowledge_chunks USING btree (organization_id, folder_id);


--
-- Name: idx_knowledge_folders_org; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_knowledge_folders_org ON public.knowledge_folders USING btree (organization_id);


--
-- Name: idx_knowledge_sources_folder; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_knowledge_sources_folder ON public.knowledge_sources USING btree (organization_id, folder_id);


--
-- Name: idx_order_items_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_order_items_order ON public.order_items USING btree (order_id);


--
-- Name: idx_order_items_org; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_order_items_org ON public.order_items USING btree (organization_id);


--
-- Name: idx_order_items_product; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_order_items_product ON public.order_items USING btree (product_id);


--
-- Name: idx_orders_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_orders_created_at ON public.orders USING btree (organization_id, created_at DESC);


--
-- Name: idx_orders_customer_phone; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_orders_customer_phone ON public.orders USING btree (organization_id, customer_phone);


--
-- Name: idx_orders_delivery_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_orders_delivery_status ON public.orders USING btree (organization_id, delivery_status);


--
-- Name: idx_orders_org; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_orders_org ON public.orders USING btree (organization_id);


--
-- Name: idx_orders_org_order_code_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_orders_org_order_code_unique ON public.orders USING btree (organization_id, order_code) WHERE (order_code IS NOT NULL);


--
-- Name: idx_orders_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_orders_status ON public.orders USING btree (organization_id, order_status);


--
-- Name: idx_reservation_calendar_events_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reservation_calendar_events_organization_id ON public.reservation_calendar_events USING btree (organization_id);


--
-- Name: idx_reservation_calendar_events_provider_event_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reservation_calendar_events_provider_event_id ON public.reservation_calendar_events USING btree (provider, external_event_id);


--
-- Name: idx_reservation_calendar_events_reservation_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reservation_calendar_events_reservation_id ON public.reservation_calendar_events USING btree (reservation_id);


--
-- Name: idx_reservations_customer_phone; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reservations_customer_phone ON public.reservations USING btree (organization_id, customer_phone);


--
-- Name: idx_reservations_organization_start_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reservations_organization_start_at ON public.reservations USING btree (organization_id, start_at);


--
-- Name: idx_reservations_organization_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reservations_organization_time ON public.reservations USING btree (organization_id, start_at, end_at);


--
-- Name: idx_reservations_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reservations_status ON public.reservations USING btree (organization_id, status);


--
-- Name: idx_services_organization_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_services_organization_active ON public.services USING btree (organization_id, is_active, is_reservable);


--
-- Name: idx_task_edges_flow_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_task_edges_flow_id ON public.task_edges USING btree (flow_id);


--
-- Name: idx_task_edges_source_node; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_task_edges_source_node ON public.task_edges USING btree (flow_id, source_node_key);


--
-- Name: idx_task_flows_enabled; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_task_flows_enabled ON public.task_flows USING btree (organization_id, is_enabled);


--
-- Name: idx_task_flows_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_task_flows_organization_id ON public.task_flows USING btree (organization_id);


--
-- Name: idx_task_nodes_flow_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_task_nodes_flow_id ON public.task_nodes USING btree (flow_id);


--
-- Name: idx_task_sessions_expires_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_task_sessions_expires_at ON public.task_sessions USING btree (expires_at);


--
-- Name: idx_task_sessions_lookup; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_task_sessions_lookup ON public.task_sessions USING btree (organization_id, session_id, status);


--
-- Name: knowledge_chunks_content_tsv_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX knowledge_chunks_content_tsv_idx ON public.knowledge_chunks USING gin (content_tsv);


--
-- Name: knowledge_chunks_keywords_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX knowledge_chunks_keywords_idx ON public.knowledge_chunks USING gin (keywords);


--
-- Name: knowledge_folders_org_active_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX knowledge_folders_org_active_idx ON public.knowledge_folders USING btree (organization_id, is_active);


--
-- Name: knowledge_semantic_cache_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX knowledge_semantic_cache_created_at_idx ON public.knowledge_semantic_cache USING btree (created_at);


--
-- Name: knowledge_semantic_cache_org_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX knowledge_semantic_cache_org_idx ON public.knowledge_semantic_cache USING btree (organization_id);


--
-- Name: knowledge_sources_storage_object_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX knowledge_sources_storage_object_key ON public.knowledge_sources USING btree (storage_bucket, storage_path) WHERE ((storage_bucket IS NOT NULL) AND (storage_path IS NOT NULL));


--
-- Name: organization_ai_settings_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX organization_ai_settings_organization_id_idx ON public.organization_ai_settings USING btree (organization_id);


--
-- Name: organization_members_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX organization_members_organization_id_idx ON public.organization_members USING btree (organization_id);


--
-- Name: organization_members_user_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX organization_members_user_id_idx ON public.organization_members USING btree (user_id);


--
-- Name: services_organization_name_unique_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX services_organization_name_unique_idx ON public.services USING btree (organization_id, name);


--
-- Name: uq_calendar_integrations_org_provider_calendar; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_calendar_integrations_org_provider_calendar ON public.calendar_integrations USING btree (organization_id, provider, external_calendar_id);


--
-- Name: uq_knowledge_sources_org_checksum; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_knowledge_sources_org_checksum ON public.knowledge_sources USING btree (organization_id, checksum_sha256) WHERE (checksum_sha256 IS NOT NULL);


--
-- Name: uq_reservation_calendar_events_provider_event; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_reservation_calendar_events_provider_event ON public.reservation_calendar_events USING btree (provider, external_event_id) WHERE (external_event_id IS NOT NULL);


--
-- Name: booking_settings set_booking_settings_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_booking_settings_updated_at BEFORE UPDATE ON public.booking_settings FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: customers set_customers_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_customers_updated_at BEFORE UPDATE ON public.customers FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: reservations set_reservations_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_reservations_updated_at BEFORE UPDATE ON public.reservations FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: services set_services_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_services_updated_at BEFORE UPDATE ON public.services FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: task_flows set_task_flows_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_task_flows_updated_at BEFORE UPDATE ON public.task_flows FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: task_nodes set_task_nodes_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_task_nodes_updated_at BEFORE UPDATE ON public.task_nodes FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: task_sessions set_task_sessions_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_task_sessions_updated_at BEFORE UPDATE ON public.task_sessions FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: calendar_integrations trg_calendar_integrations_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_calendar_integrations_updated_at BEFORE UPDATE ON public.calendar_integrations FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: reservation_calendar_events trg_reservation_calendar_events_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_reservation_calendar_events_updated_at BEFORE UPDATE ON public.reservation_calendar_events FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: agent_runs agent_runs_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_runs
    ADD CONSTRAINT agent_runs_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: ai_usage_logs ai_usage_logs_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_usage_logs
    ADD CONSTRAINT ai_usage_logs_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: builtin_rule_overrides builtin_rule_overrides_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.builtin_rule_overrides
    ADD CONSTRAINT builtin_rule_overrides_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: calendar_integrations calendar_integrations_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendar_integrations
    ADD CONSTRAINT calendar_integrations_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: conversation_messages conversation_messages_conversation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversation_messages
    ADD CONSTRAINT conversation_messages_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.conversations(id) ON DELETE CASCADE;


--
-- Name: conversation_messages conversation_messages_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversation_messages
    ADD CONSTRAINT conversation_messages_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: conversations conversations_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: customers customers_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: knowledge_chunks knowledge_chunks_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_chunks
    ADD CONSTRAINT knowledge_chunks_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: knowledge_chunks knowledge_chunks_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_chunks
    ADD CONSTRAINT knowledge_chunks_source_id_fkey FOREIGN KEY (source_id) REFERENCES public.knowledge_sources(id) ON DELETE CASCADE;


--
-- Name: knowledge_folders knowledge_folders_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_folders
    ADD CONSTRAINT knowledge_folders_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: knowledge_folders knowledge_folders_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_folders
    ADD CONSTRAINT knowledge_folders_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.knowledge_folders(id) ON DELETE CASCADE;


--
-- Name: knowledge_sources knowledge_sources_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.knowledge_sources
    ADD CONSTRAINT knowledge_sources_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: orders orders_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: organization_ai_settings organization_ai_settings_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_ai_settings
    ADD CONSTRAINT organization_ai_settings_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: organization_members organization_members_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_members
    ADD CONSTRAINT organization_members_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: organization_members organization_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_members
    ADD CONSTRAINT organization_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: reservation_calendar_events reservation_calendar_events_reservation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservation_calendar_events
    ADD CONSTRAINT reservation_calendar_events_reservation_id_fkey FOREIGN KEY (reservation_id) REFERENCES public.reservations(id) ON DELETE CASCADE;


--
-- Name: reservations reservations_conversation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.conversations(id) ON DELETE SET NULL;


--
-- Name: reservations reservations_customer_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_customer_id_fkey1 FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE SET NULL;


--
-- Name: reservations reservations_organization_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_organization_id_fkey1 FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: reservations reservations_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE SET NULL;


--
-- Name: reservations reservations_service_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_service_item_id_fkey FOREIGN KEY (service_item_id) REFERENCES public.service_items(id) ON DELETE SET NULL;


--
-- Name: rules rules_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rules
    ADD CONSTRAINT rules_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: service_item_options service_item_options_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_item_options
    ADD CONSTRAINT service_item_options_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: service_item_options service_item_options_service_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_item_options
    ADD CONSTRAINT service_item_options_service_item_id_fkey FOREIGN KEY (service_item_id) REFERENCES public.service_items(id) ON DELETE CASCADE;


--
-- Name: service_items service_items_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_items
    ADD CONSTRAINT service_items_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: service_items service_items_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_items
    ADD CONSTRAINT service_items_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE CASCADE;


--
-- Name: services services_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: task_edges task_edges_flow_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_edges
    ADD CONSTRAINT task_edges_flow_id_fkey FOREIGN KEY (flow_id) REFERENCES public.task_flows(id) ON DELETE CASCADE;


--
-- Name: task_flows task_flows_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_flows
    ADD CONSTRAINT task_flows_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: task_nodes task_nodes_flow_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_nodes
    ADD CONSTRAINT task_nodes_flow_id_fkey FOREIGN KEY (flow_id) REFERENCES public.task_flows(id) ON DELETE CASCADE;


--
-- Name: task_sessions task_sessions_flow_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_sessions
    ADD CONSTRAINT task_sessions_flow_id_fkey FOREIGN KEY (flow_id) REFERENCES public.task_flows(id) ON DELETE CASCADE;


--
-- Name: task_sessions task_sessions_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_sessions
    ADD CONSTRAINT task_sessions_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: users users_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: agent_runs; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.agent_runs ENABLE ROW LEVEL SECURITY;

--
-- Name: ai_usage_logs; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.ai_usage_logs ENABLE ROW LEVEL SECURITY;

--
-- Name: calendar_integrations; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.calendar_integrations ENABLE ROW LEVEL SECURITY;

--
-- Name: conversation_messages; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.conversation_messages ENABLE ROW LEVEL SECURITY;

--
-- Name: conversations; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.conversations ENABLE ROW LEVEL SECURITY;

--
-- Name: customers; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.customers ENABLE ROW LEVEL SECURITY;

--
-- Name: knowledge_folders; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.knowledge_folders ENABLE ROW LEVEL SECURITY;

--
-- Name: organization_ai_settings; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.organization_ai_settings ENABLE ROW LEVEL SECURITY;

--
-- Name: organization_members organization_members_select_own; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY organization_members_select_own ON public.organization_members FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: reservations; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.reservations ENABLE ROW LEVEL SECURITY;

--
-- Name: services; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.services ENABLE ROW LEVEL SECURITY;

--
-- Name: task_edges; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.task_edges ENABLE ROW LEVEL SECURITY;

--
-- Name: task_flows; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.task_flows ENABLE ROW LEVEL SECURITY;

--
-- Name: task_nodes; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.task_nodes ENABLE ROW LEVEL SECURITY;

--
-- Name: task_sessions; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.task_sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: users users_select_self; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY users_select_self ON public.users FOR SELECT USING ((auth.uid() = id));


--
-- Name: users users_update_self; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY users_update_self ON public.users FOR UPDATE USING ((auth.uid() = id));


--
-- PostgreSQL database dump complete
--

\unrestrict tN0uclBnk7EjDhT4bbkd4K34WyCVksrl2E7sWeYOQflacWxeDbbYr182DyZETFy

