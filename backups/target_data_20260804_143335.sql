--
-- PostgreSQL database dump
--

\restrict 9XW4g1SAsXQvnxxyxawaC2VDcFl56c0JJBC4tg0leZXB0bkKbj4sbwWj3LcJhPX

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
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at, custom_claims_allowlist) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	3b63621a-d7b0-4fef-a683-651228049361	authenticated	authenticated	andrea144@hs.ac.kr	\N	2026-08-04 03:05:21.996656+00	\N		\N		\N			\N	2026-08-04 03:05:22.002943+00	{"provider": "google", "providers": ["google"]}	{"iss": "https://accounts.google.com", "sub": "100140679880873413031", "name": "이상욱", "email": "andrea144@hs.ac.kr", "picture": "https://lh3.googleusercontent.com/a/ACg8ocITAAarKwn4yo7O_bi4NZeulkXzLxCpecYUPyxcF_PFnVPHLg=s96-c", "full_name": "이상욱", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocITAAarKwn4yo7O_bi4NZeulkXzLxCpecYUPyxcF_PFnVPHLg=s96-c", "provider_id": "100140679880873413031", "custom_claims": {"hd": "hs.ac.kr"}, "email_verified": true, "phone_verified": false}	\N	2026-08-04 03:05:21.976937+00	2026-08-04 04:18:12.645802+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
100140679880873413031	3b63621a-d7b0-4fef-a683-651228049361	{"iss": "https://accounts.google.com", "sub": "100140679880873413031", "name": "이상욱", "email": "andrea144@hs.ac.kr", "picture": "https://lh3.googleusercontent.com/a/ACg8ocITAAarKwn4yo7O_bi4NZeulkXzLxCpecYUPyxcF_PFnVPHLg=s96-c", "full_name": "이상욱", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocITAAarKwn4yo7O_bi4NZeulkXzLxCpecYUPyxcF_PFnVPHLg=s96-c", "provider_id": "100140679880873413031", "custom_claims": {"hd": "hs.ac.kr"}, "email_verified": true, "phone_verified": false}	google	2026-08-04 03:05:21.990679+00	2026-08-04 03:05:21.990784+00	2026-08-04 03:05:21.990784+00	c748f0d7-5612-4376-a9b8-97fe07dd6817
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
05afb8ca-11f3-44e9-82f4-29b55c70a6b1	3b63621a-d7b0-4fef-a683-651228049361	2026-08-04 03:05:22.00313+00	2026-08-04 04:18:12.664987+00	\N	aal1	\N	2026-08-04 04:18:12.664866	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0	221.145.113.207	\N	\N	\N	\N	\N
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
05afb8ca-11f3-44e9-82f4-29b55c70a6b1	2026-08-04 03:05:22.023321+00	2026-08-04 03:05:22.023321+00	oauth	7b980d45-7b02-455a-8003-48d775eac649
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	1	33dc44os2jja	3b63621a-d7b0-4fef-a683-651228049361	t	2026-08-04 03:05:22.00924+00	2026-08-04 04:18:12.632657+00	\N	05afb8ca-11f3-44e9-82f4-29b55c70a6b1
00000000-0000-0000-0000-000000000000	2	qk6rxnokdgyz	3b63621a-d7b0-4fef-a683-651228049361	f	2026-08-04 04:18:12.640999+00	2026-08-04 04:18:12.640999+00	33dc44os2jja	05afb8ca-11f3-44e9-82f4-29b55c70a6b1
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
20260219120000
20260302000000
20260625000000
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.webauthn_challenges (id, user_id, challenge_type, session_data, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.webauthn_credentials (id, user_id, credential_id, public_key, attestation_type, aaguid, sign_count, transports, backup_eligible, backed_up, friendly_name, created_at, updated_at, last_used_at) FROM stdin;
\.


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.organizations (id, name, llm_provider, llm_model, streaming_model, created_at, updated_at) FROM stdin;
ad9a7e54-5a57-4ee0-9784-e43d7f0fcdc6	기본 조직	openai	gpt-4.1-mini	\N	2026-08-04 02:20:01.76357+00	2026-08-04 02:20:01.76357+00
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	Callbee Local Test	openai	gpt-4.1-mini	\N	2026-08-04 03:48:51.748526+00	2026-08-04 03:48:51.748526+00
\.


--
-- Data for Name: agent_runs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.agent_runs (id, organization_id, session_id, user_message, intent, applied_rules, used_knowledge, final_response, status, error_message, created_at) FROM stdin;
410a5177-54e5-45ce-99d8-9e69106c6362	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39	안녕하세요	general	["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"]	[]	안녕하세요! 무엇을 도와드릴까요?	success	\N	2026-08-04 03:49:04.995113
e2db3117-1b78-44c4-a4c6-186e6d7a3d98	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39	예약할래요	\N	["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"]	[]	\N	success	\N	2026-08-04 03:49:09.908449
d17f7c17-a21b-4d62-bd4a-8eb5f73d0586	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	rule_preview_1785817115123	안녕하세요	general	["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"]	[]	안녕하세요! 무엇을 도와드릴까요?	success	\N	2026-08-04 04:18:39.210765
e533681d-4949-4aca-9681-51f3f38f82af	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	rule_preview_1785817115123	예약하고싶어요	reservation	["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"]	[]	예약을 도와드리려고 하는데, 어떤 서비스를 원하시는지 알려주실 수 있을까요? 예를 들어, 미용, 마사지, 또는 다른 서비스가 있을 수 있어요.	success	\N	2026-08-04 04:18:45.761451
59622b32-4bde-4095-a7d3-566181c8988d	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	rule_preview_1785817171109	예약하고싶어요	reservation	["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"]	[]	예약 도와드릴게요! 어떤 서비스를 원하시는지 알려주실 수 있나요? 예를 들어, 헤어컷, 마사지, 네일아트 같은 서비스가 있어요.	success	\N	2026-08-04 04:19:39.72253
e1b7ebc6-49a3-4583-a6a8-c1c34bb8e344	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	rule_preview_1785817171109	헤어컷	reservation	["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"]	[]	죄송하지만 현재 제공 가능한 서비스 목록을 불러올 수 없습니다. 예약하실 서비스를 좀 더 구체적으로 말씀해 주시겠어요?	success	\N	2026-08-04 04:20:19.455883
2e593f45-c6de-4d90-9dc6-051bc584062b	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39	예약하고싶어	reservation	["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"]	[]	안녕하세요! 예약을 도와드리려고 하는데요, 어떤 서비스를 원하시는지 알려주실 수 있을까요? 예를 들어, 미용, 마사지, 또는 다른 서비스가 있을 수 있어요.	success	\N	2026-08-04 04:44:25.36674
913ca097-25dc-4748-97b4-90d3ad0a83f6	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39	헤어컷	reservation	["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"]	[]	죄송하지만 현재 제공 가능한 서비스 목록을 불러올 수 없습니다. 예약하실 서비스를 구체적으로 알려주실 수 있나요?	success	\N	2026-08-04 04:44:30.467615
c0f08797-0b15-48cd-bde8-b2cec956cf30	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39	예약할래	reservation	["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"]	[]	예약을 도와드리고 싶은데, 현재 어떤 서비스를 원하시는지 알려주실 수 있나요? 예를 들어, 미용, 마사지, 또는 다른 서비스가 있을 수 있어요.	success	\N	2026-08-04 04:45:06.024013
8e526e73-ab97-4a5a-8a54-aa7c7a2949a4	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39	헤어컷	reservation	["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"]	[]	죄송하지만 현재 제공 가능한 서비스 목록을 불러올 수 없습니다. 예약하실 서비스명을 조금 더 자세히 알려주실 수 있나요?	success	\N	2026-08-04 04:45:09.029149
\.


--
-- Data for Name: ai_usage_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ai_usage_logs (id, organization_id, conversation_id, session_id, channel, feature, provider, model, input_tokens, output_tokens, total_tokens, audio_duration_ms, audio_bytes, text_chars, estimated_cost_cents, metadata, created_at) FROM stdin;
\.


--
-- Data for Name: booking_calendars; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.booking_calendars (id, organization_id, name, description, calendar_type, external_provider, external_calendar_id, timezone, is_active, created_at, updated_at) FROM stdin;
c4193491-5065-454d-a58e-74d7607a9070	ad9a7e54-5a57-4ee0-9784-e43d7f0fcdc6	한빛클리닝 대표 캘린더	데모 예약을 받는 기본 캘린더입니다.	internal	\N	\N	Asia/Seoul	t	2026-08-04 02:20:02.364428+00	2026-08-04 02:20:02.364428+00
\.


--
-- Data for Name: booking_availability_rules; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.booking_availability_rules (id, organization_id, calendar_id, day_of_week, start_time, end_time, is_active, created_at, updated_at) FROM stdin;
072395f1-5b47-4301-b837-38b963bd70c6	ad9a7e54-5a57-4ee0-9784-e43d7f0fcdc6	c4193491-5065-454d-a58e-74d7607a9070	1	10:00:00	18:00:00	t	2026-08-04 02:20:02.364428+00	2026-08-04 02:20:02.364428+00
ea64d288-f684-4875-8d38-f48fa60fd142	ad9a7e54-5a57-4ee0-9784-e43d7f0fcdc6	c4193491-5065-454d-a58e-74d7607a9070	2	10:00:00	18:00:00	t	2026-08-04 02:20:02.364428+00	2026-08-04 02:20:02.364428+00
10bae67a-a32e-4ad3-a26c-c8966584d5db	ad9a7e54-5a57-4ee0-9784-e43d7f0fcdc6	c4193491-5065-454d-a58e-74d7607a9070	3	10:00:00	18:00:00	t	2026-08-04 02:20:02.364428+00	2026-08-04 02:20:02.364428+00
f1ef4e07-8329-4e5b-80fd-2c15adb624c5	ad9a7e54-5a57-4ee0-9784-e43d7f0fcdc6	c4193491-5065-454d-a58e-74d7607a9070	4	10:00:00	18:00:00	t	2026-08-04 02:20:02.364428+00	2026-08-04 02:20:02.364428+00
e1138e41-23b2-4a34-a41e-a917d6094112	ad9a7e54-5a57-4ee0-9784-e43d7f0fcdc6	c4193491-5065-454d-a58e-74d7607a9070	5	10:00:00	18:00:00	t	2026-08-04 02:20:02.364428+00	2026-08-04 02:20:02.364428+00
30ae4d25-e0ed-4cf7-a245-06ca9dfe0e4d	ad9a7e54-5a57-4ee0-9784-e43d7f0fcdc6	c4193491-5065-454d-a58e-74d7607a9070	6	10:00:00	14:00:00	t	2026-08-04 02:20:02.364428+00	2026-08-04 02:20:02.364428+00
\.


--
-- Data for Name: knowledge_sources; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.knowledge_sources (id, organization_id, folder_id, title, source_type, file_url, file_name, mime_type, status, is_referenced, resolution_rate, reference_count, created_at, updated_at, storage_bucket, storage_path, file_size, checksum_sha256) FROM stdin;
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.services (id, organization_id, name, description, price, currency, duration_minutes, is_reservable, is_active, created_at, updated_at, approval_status, source_type, source_id, confidence, raw_payload, extracted_hash, last_extracted_at, pending_payload, sync_status, approved_at, approved_by) FROM stdin;
50c52d94-3958-43d4-8c83-12a0ba3d838a	ad9a7e54-5a57-4ee0-9784-e43d7f0fcdc6	기본 청소	기본적인 생활 청소 서비스입니다.	30000	KRW	60	t	t	2026-08-04 02:20:02.364428+00	2026-08-04 02:20:02.364428+00	approved	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4b49cd7c-4e52-4f26-83a7-38a618b427a2	ad9a7e54-5a57-4ee0-9784-e43d7f0fcdc6	프리미엄 청소	꼼꼼한 프리미엄 청소 서비스입니다.	50000	KRW	90	t	t	2026-08-04 02:20:02.364428+00	2026-08-04 02:20:02.364428+00	approved	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
a1646572-046a-4355-be7a-dbcc5058a5ce	ad9a7e54-5a57-4ee0-9784-e43d7f0fcdc6	입주 청소	입주 전 전체 공간을 청소하는 서비스입니다.	120000	KRW	180	t	t	2026-08-04 02:20:02.364428+00	2026-08-04 02:20:02.364428+00	approved	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
b00cc620-897d-4a97-a32d-40ed784130c9	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	이사 청소	테스트용 기본 서비스	50000	KRW	60	t	t	2026-08-04 04:16:08.583696+00	2026-08-04 04:16:08.583696+00	approved	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
39da67f6-c69a-4520-9bdd-d03ad4b359ff	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	헤어컷	\N	\N	KRW	30	t	t	2026-08-04 04:34:01.708902+00	2026-08-04 04:34:01.708902+00	approved	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: booking_policies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.booking_policies (id, organization_id, service_id, slot_interval_minutes, min_notice_minutes, max_days_ahead, requires_approval, allow_customer_cancel, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: booking_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.booking_settings (id, organization_id, name, timezone, slot_interval_minutes, min_notice_minutes, max_days_ahead, requires_approval, allow_customer_cancel, weekly_hours, exceptions, service_policy_overrides, legacy_calendar_ids, is_active, created_at, updated_at) FROM stdin;
7f4ec56c-dfe4-43e1-bcec-4d7431cbd082	ad9a7e54-5a57-4ee0-9784-e43d7f0fcdc6	한빛클리닝 대표 캘린더	Asia/Seoul	30	60	30	t	t	[{"end_time": "18:00", "is_active": true, "start_time": "10:00", "day_of_week": 1}, {"end_time": "18:00", "is_active": true, "start_time": "10:00", "day_of_week": 2}, {"end_time": "18:00", "is_active": true, "start_time": "10:00", "day_of_week": 3}, {"end_time": "18:00", "is_active": true, "start_time": "10:00", "day_of_week": 4}, {"end_time": "18:00", "is_active": true, "start_time": "10:00", "day_of_week": 5}, {"end_time": "14:00", "is_active": true, "start_time": "10:00", "day_of_week": 6}]	[]	{}	[{"id": "c4193491-5065-454d-a58e-74d7607a9070", "name": "한빛클리닝 대표 캘린더", "timezone": "Asia/Seoul", "is_active": true, "calendar_type": "internal", "external_provider": null, "external_calendar_id": null}]	t	2026-08-04 02:20:02.465177+00	2026-08-04 02:20:02.465177+00
2950f6ef-734f-43b3-85d6-1dcef747abab	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	대표 예약 캘린더	Asia/Seoul	30	60	30	t	t	[{"end_time": "18:00", "is_active": true, "start_time": "10:00", "day_of_week": 1}, {"end_time": "18:00", "is_active": true, "start_time": "10:00", "day_of_week": 2}, {"end_time": "18:00", "is_active": true, "start_time": "10:00", "day_of_week": 3}, {"end_time": "18:00", "is_active": true, "start_time": "10:00", "day_of_week": 4}, {"end_time": "18:00", "is_active": true, "start_time": "10:00", "day_of_week": 5}]	[]	{}	[]	t	2026-08-04 04:16:08.583696+00	2026-08-04 04:16:08.583696+00
\.


--
-- Data for Name: builtin_rule_overrides; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.builtin_rule_overrides (id, organization_id, builtin_key, name, instruction, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: calendar_integrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.calendar_integrations (id, organization_id, provider, account_email, account_name, external_calendar_id, access_token, refresh_token, token_type, expires_at, scopes, status, last_error, connected_at, disconnected_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: checkpoint_blobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.checkpoint_blobs (thread_id, checkpoint_ns, channel, version, type, blob) FROM stdin;
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_21f3c937-106b-4199-b00b-4af5ca04893d		rules	00000000000000000000000000000003.0.6809172698225958	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_21f3c937-106b-4199-b00b-4af5ca04893d		applied_rules	00000000000000000000000000000003.0.6809172698225958	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_21f3c937-106b-4199-b00b-4af5ca04893d		knowledge_context	00000000000000000000000000000002.0.36295227180849976	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_21f3c937-106b-4199-b00b-4af5ca04893d		used_knowledge	00000000000000000000000000000002.0.36295227180849976	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_21f3c937-106b-4199-b00b-4af5ca04893d		messages	00000000000000000000000000000003.0.6809172698225958	msgpack	\\x92c7b90594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74afec9588eb8595ed9598ec84b8ec9a94b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92466366362643239312d336561342d343765662d623063642d353033636432643164363335b36d6f64656c5f76616c69646174655f6a736f6ec801000594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d92eec9588eb8595ed9598ec84b8ec9a942120ebacb4ec9787ec9d8420eb8f84ec9980eb939ceba6b4eab98cec9a943fb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92463356530623637302d303133642d343466332d383830652d666535323138386562633430aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6e
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_21f3c937-106b-4199-b00b-4af5ca04893d		rules	00000000000000000000000000000005.0.07407476485126607	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_21f3c937-106b-4199-b00b-4af5ca04893d		applied_rules	00000000000000000000000000000005.0.07407476485126607	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_21f3c937-106b-4199-b00b-4af5ca04893d		knowledge_context	00000000000000000000000000000005.0.07407476485126607	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_21f3c937-106b-4199-b00b-4af5ca04893d		used_knowledge	00000000000000000000000000000005.0.07407476485126607	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_21f3c937-106b-4199-b00b-4af5ca04893d		rules	00000000000000000000000000000007.0.03859929765606662	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_21f3c937-106b-4199-b00b-4af5ca04893d		applied_rules	00000000000000000000000000000007.0.03859929765606662	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_21f3c937-106b-4199-b00b-4af5ca04893d		knowledge_context	00000000000000000000000000000007.0.03859929765606662	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_21f3c937-106b-4199-b00b-4af5ca04893d		used_knowledge	00000000000000000000000000000007.0.03859929765606662	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_63d75d43-8a8e-4581-9774-99e4443babe7		rules	00000000000000000000000000000003.0.6190068366000311	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_63d75d43-8a8e-4581-9774-99e4443babe7		applied_rules	00000000000000000000000000000003.0.6190068366000311	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_63d75d43-8a8e-4581-9774-99e4443babe7		knowledge_context	00000000000000000000000000000002.0.11971887407325221	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_63d75d43-8a8e-4581-9774-99e4443babe7		used_knowledge	00000000000000000000000000000002.0.11971887407325221	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_63d75d43-8a8e-4581-9774-99e4443babe7		messages	00000000000000000000000000000003.0.6190068366000311	msgpack	\\x92c7b90594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74afec9588eb8595ed9598ec84b8ec9a94b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92461333461653239332d326338342d346533392d626635302d346464646336313533623932b36d6f64656c5f76616c69646174655f6a736f6ec801000594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d92eec9588eb8595ed9598ec84b8ec9a942120ebacb4ec9787ec9d8420eb8f84ec9980eb939ceba6b4eab98cec9a943fb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92438623164626462622d643036652d346366662d626531352d383335323563306261633235aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6e
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_63d75d43-8a8e-4581-9774-99e4443babe7		rules	00000000000000000000000000000005.0.4275327859592485	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_63d75d43-8a8e-4581-9774-99e4443babe7		applied_rules	00000000000000000000000000000005.0.4275327859592485	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_63d75d43-8a8e-4581-9774-99e4443babe7		knowledge_context	00000000000000000000000000000005.0.4275327859592485	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_63d75d43-8a8e-4581-9774-99e4443babe7		used_knowledge	00000000000000000000000000000005.0.4275327859592485	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		rules	00000000000000000000000000000003.0.32842734419882347	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		applied_rules	00000000000000000000000000000003.0.32842734419882347	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		knowledge_context	00000000000000000000000000000002.0.14841754595619405	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		used_knowledge	00000000000000000000000000000002.0.14841754595619405	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		messages	00000000000000000000000000000003.0.32842734419882347	msgpack	\\x92c7b90594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74afec9588eb8595ed9598ec84b8ec9a94b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92433643831396636382d393232352d343335302d623862612d333164383137616136613863b36d6f64656c5f76616c69646174655f6a736f6ec801000594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d92eec9588eb8595ed9598ec84b8ec9a942120ebacb4ec9787ec9d8420eb8f84ec9980eb939ceba6b4eab98cec9a943fb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92461353534653630662d343338362d346135632d613865372d623533396334326264306437aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6e
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		rules	00000000000000000000000000000006.0.22174538618501116	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		applied_rules	00000000000000000000000000000006.0.22174538618501116	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		knowledge_context	00000000000000000000000000000005.0.47071022819147057	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		used_knowledge	00000000000000000000000000000005.0.47071022819147057	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		messages	00000000000000000000000000000006.0.22174538618501116	msgpack	\\x93c7b90594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74afec9588eb8595ed9598ec84b8ec9a94b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92433643831396636382d393232352d343335302d623862612d333164383137616136613863b36d6f64656c5f76616c69646174655f6a736f6ec801000594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d92eec9588eb8595ed9598ec84b8ec9a942120ebacb4ec9787ec9d8420eb8f84ec9980eb939ceba6b4eab98cec9a943fb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92461353534653630662d343338362d346135632d613865372d623533396334326264306437aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6ec7b90594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74afec9888ec95bded95a0eb9e98ec9a94b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92433653661656230322d653130302d343033332d613337372d623065313632343565353739b36d6f64656c5f76616c69646174655f6a736f6e
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817115123		rules	00000000000000000000000000000003.0.7952789264169401	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817115123		applied_rules	00000000000000000000000000000003.0.7952789264169401	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817115123		knowledge_context	00000000000000000000000000000002.0.03794249926656812	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817115123		used_knowledge	00000000000000000000000000000002.0.03794249926656812	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817115123		messages	00000000000000000000000000000003.0.7952789264169401	msgpack	\\x92c7b90594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74afec9588eb8595ed9598ec84b8ec9a94b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92437346533373230332d326138322d346430632d623036362d353533346361633865343231b36d6f64656c5f76616c69646174655f6a736f6ec801000594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d92eec9588eb8595ed9598ec84b8ec9a942120ebacb4ec9787ec9d8420eb8f84ec9980eb939ceba6b4eab98cec9a943fb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92462633738613535332d373061322d346131622d623237372d326534636333656533343834aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6e
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817171109		rules	00000000000000000000000000000003.0.2244378174841437	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817171109		applied_rules	00000000000000000000000000000003.0.2244378174841437	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817171109		knowledge_context	00000000000000000000000000000002.0.31382639625878717	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817171109		used_knowledge	00000000000000000000000000000002.0.31382639625878717	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817171109		messages	00000000000000000000000000000003.0.2244378174841437	msgpack	\\x92c7bf0594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74b5ec9888ec95bded9598eab3a0ec8bb6ec96b4ec9a94b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92463386438306536662d623065302d343636342d396165372d643062343461373739663261b36d6f64656c5f76616c69646174655f6a736f6ec8017d0594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d9abec9888ec95bd20eb8f84ec9980eb939ceba6b4eab28cec9a942120ec96b4eb96a420ec849cebb984ec8aa4eba5bc20ec9b90ed9598ec8b9ceb8a94eca78020ec958ceba0a4eca3bcec8ba420ec889820ec9e88eb8298ec9a943f20ec9888eba5bc20eb93a4ec96b42c20ed97a4ec96b4ecbbb72c20eba788ec82aceca7802c20eb84a4ec9dbcec9584ed8ab820eab099ec9d8020ec849cebb984ec8aa4eab08020ec9e88ec96b4ec9a942eb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92433663266626338612d333034382d343661642d626437662d306664316331376335626261aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6e
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817171109		task_result	00000000000000000000000000000003.0.2244378174841437	msgpack	\\x88a768616e646c6564c3a76d657373616765d9abec9888ec95bd20eb8f84ec9980eb939ceba6b4eab28cec9a942120ec96b4eb96a420ec849cebb984ec8aa4eba5bc20ec9b90ed9598ec8b9ceb8a94eca78020ec958ceba0a4eca3bcec8ba420ec889820ec9e88eb8298ec9a943f20ec9888eba5bc20eb93a4ec96b42c20ed97a4ec96b4ecbbb72c20eba788ec82aceca7802c20eb84a4ec9dbcec9584ed8ab820eab099ec9d8020ec849cebb984ec8aa4eab08020ec9e88ec96b4ec9a942ea6737461747573b277616974696e675f757365725f696e707574a7666c6f775f6964d92438373166326661652d333963652d346335372d623664392d326231343631313432306332af7461736b5f73657373696f6e5f6964d92461623939313165632d613263372d346364662d396330662d663739303333373535636630b063757272656e745f6e6f64655f6b6579ab61736b5f73657276696365a56572726f72c0a574726163659287a86e6f64655f6b6579a57374617274aa6e6f64655f6c6162656cb7ec849cebb984ec8aa420ebaaa9eba19d20eca1b0ed9a8ca96e6f64655f74797065a866756e6374696f6ea6737461747573a773756363657373ad6e6578745f6265686176696f72ae6576616c756174655f6564676573ae6d656d6f72795f7570646174657391b2617661696c61626c655f7365727669636573a56572726f72c087a86e6f64655f6b6579ab61736b5f73657276696365aa6e6f64655f6c6162656cb7ec849cebb984ec8aa420ec84a0ed839d20eca788ebacb8a96e6f64655f74797065ab696e737472756374696f6ea6737461747573a773756363657373ad6e6578745f6265686176696f72a9776169745f75736572ae6d656d6f72795f7570646174657390a56572726f72c0
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817115123		rules	00000000000000000000000000000006.0.17482572079205516	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817115123		applied_rules	00000000000000000000000000000006.0.17482572079205516	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817115123		knowledge_context	00000000000000000000000000000005.0.8423046652669601	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817115123		used_knowledge	00000000000000000000000000000005.0.8423046652669601	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817115123		messages	00000000000000000000000000000006.0.17482572079205516	msgpack	\\x94c7b90594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74afec9588eb8595ed9598ec84b8ec9a94b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92437346533373230332d326138322d346430632d623036362d353533346361633865343231b36d6f64656c5f76616c69646174655f6a736f6ec801000594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d92eec9588eb8595ed9598ec84b8ec9a942120ebacb4ec9787ec9d8420eb8f84ec9980eb939ceba6b4eab98cec9a943fb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92462633738613535332d373061322d346131622d623237372d326534636333656533343834aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6ec7bf0594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74b5ec9888ec95bded9598eab3a0ec8bb6ec96b4ec9a94b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92432366632376465382d636235342d343436342d613938372d366166666230373964663939b36d6f64656c5f76616c69646174655f6a736f6ec8018f0594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d9bdec9888ec95bdec9d8420eb8f84ec9980eb939ceba6aceba0a4eab3a020ed9598eb8a94eb8db02c20ec96b4eb96a420ec849cebb984ec8aa4eba5bc20ec9b90ed9598ec8b9ceb8a94eca78020ec958ceba0a4eca3bcec8ba420ec889820ec9e88ec9d84eab98cec9a943f20ec9888eba5bc20eb93a4ec96b42c20ebafb8ec9aa92c20eba788ec82aceca7802c20eb9890eb8a9420eb8ba4eba5b820ec849cebb984ec8aa4eab08020ec9e88ec9d8420ec889820ec9e88ec96b4ec9a942eb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92437363033356537382d373736662d343639352d386532652d386534323138636664356630aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6e
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817115123		task_result	00000000000000000000000000000006.0.17482572079205516	msgpack	\\x88a768616e646c6564c3a76d657373616765d9bdec9888ec95bdec9d8420eb8f84ec9980eb939ceba6aceba0a4eab3a020ed9598eb8a94eb8db02c20ec96b4eb96a420ec849cebb984ec8aa4eba5bc20ec9b90ed9598ec8b9ceb8a94eca78020ec958ceba0a4eca3bcec8ba420ec889820ec9e88ec9d84eab98cec9a943f20ec9888eba5bc20eb93a4ec96b42c20ebafb8ec9aa92c20eba788ec82aceca7802c20eb9890eb8a9420eb8ba4eba5b820ec849cebb984ec8aa4eab08020ec9e88ec9d8420ec889820ec9e88ec96b4ec9a942ea6737461747573b277616974696e675f757365725f696e707574a7666c6f775f6964d92438373166326661652d333963652d346335372d623664392d326231343631313432306332af7461736b5f73657373696f6e5f6964d92462356561633036302d636236612d343533332d626166632d353631303931313635393565b063757272656e745f6e6f64655f6b6579ab61736b5f73657276696365a56572726f72c0a574726163659287a86e6f64655f6b6579a57374617274aa6e6f64655f6c6162656cb7ec849cebb984ec8aa420ebaaa9eba19d20eca1b0ed9a8ca96e6f64655f74797065a866756e6374696f6ea6737461747573a773756363657373ad6e6578745f6265686176696f72ae6576616c756174655f6564676573ae6d656d6f72795f7570646174657391b2617661696c61626c655f7365727669636573a56572726f72c087a86e6f64655f6b6579ab61736b5f73657276696365aa6e6f64655f6c6162656cb7ec849cebb984ec8aa420ec84a0ed839d20eca788ebacb8a96e6f64655f74797065ab696e737472756374696f6ea6737461747573a773756363657373ad6e6578745f6265686176696f72a9776169745f75736572ae6d656d6f72795f7570646174657390a56572726f72c0
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817171109		rules	00000000000000000000000000000006.0.6615004429503055	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817171109		applied_rules	00000000000000000000000000000006.0.6615004429503055	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817171109		knowledge_context	00000000000000000000000000000005.0.4690509857226066	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817171109		used_knowledge	00000000000000000000000000000005.0.4690509857226066	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817171109		messages	00000000000000000000000000000006.0.6615004429503055	msgpack	\\x94c7bf0594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74b5ec9888ec95bded9598eab3a0ec8bb6ec96b4ec9a94b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92463386438306536662d623065302d343636342d396165372d643062343461373739663261b36d6f64656c5f76616c69646174655f6a736f6ec8017d0594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d9abec9888ec95bd20eb8f84ec9980eb939ceba6b4eab28cec9a942120ec96b4eb96a420ec849cebb984ec8aa4eba5bc20ec9b90ed9598ec8b9ceb8a94eca78020ec958ceba0a4eca3bcec8ba420ec889820ec9e88eb8298ec9a943f20ec9888eba5bc20eb93a4ec96b42c20ed97a4ec96b4ecbbb72c20eba788ec82aceca7802c20eb84a4ec9dbcec9584ed8ab820eab099ec9d8020ec849cebb984ec8aa4eab08020ec9e88ec96b4ec9a942eb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92433663266626338612d333034382d343661642d626437662d306664316331376335626261aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6ec7b30594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74a9ed97a4ec96b4ecbbb7b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92430353537326339662d663236622d346663312d383434342d343330636365623536663031b36d6f64656c5f76616c69646174655f6a736f6ec801760594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d9a4eca384ec86a1ed9598eca780eba78c20ed9884ec9eac20eca09ceab3b520eab080eb8aa5ed959c20ec849cebb984ec8aa420ebaaa9eba19dec9d8420ebb688eb9facec98ac20ec889820ec9786ec8ab5eb8b88eb8ba42e20ec9888ec95bded9598ec8ba420ec849cebb984ec8aa4eba5bc20eca28020eb8d9420eab5acecb2b4eca081ec9cbceba19c20eba790ec9480ed95b420eca3bcec8b9ceab2a0ec96b4ec9a943fb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92461633663633439622d396135322d343963662d393831372d313635656237376437656262aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6e
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817171109		task_result	00000000000000000000000000000006.0.6615004429503055	msgpack	\\x88a768616e646c6564c3a76d657373616765d9a4eca384ec86a1ed9598eca780eba78c20ed9884ec9eac20eca09ceab3b520eab080eb8aa5ed959c20ec849cebb984ec8aa420ebaaa9eba19dec9d8420ebb688eb9facec98ac20ec889820ec9786ec8ab5eb8b88eb8ba42e20ec9888ec95bded9598ec8ba420ec849cebb984ec8aa4eba5bc20eca28020eb8d9420eab5acecb2b4eca081ec9cbceba19c20eba790ec9480ed95b420eca3bcec8b9ceab2a0ec96b4ec9a943fa6737461747573b277616974696e675f757365725f696e707574a7666c6f775f6964d92438373166326661652d333963652d346335372d623664392d326231343631313432306332af7461736b5f73657373696f6e5f6964d92461623939313165632d613263372d346364662d396330662d663739303333373535636630b063757272656e745f6e6f64655f6b6579ab61736b5f73657276696365a56572726f72c0a574726163659187a86e6f64655f6b6579ab61736b5f73657276696365aa6e6f64655f6c6162656cb7ec849cebb984ec8aa420ec84a0ed839d20eca788ebacb8a96e6f64655f74797065ab696e737472756374696f6ea6737461747573a773756363657373ad6e6578745f6265686176696f72a9776169745f75736572ae6d656d6f72795f7570646174657390a56572726f72c0
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		rules	00000000000000000000000000000009.0.2690235029228105	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		messages	00000000000000000000000000000009.0.2690235029228105	msgpack	\\x95c7b90594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74afec9588eb8595ed9598ec84b8ec9a94b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92433643831396636382d393232352d343335302d623862612d333164383137616136613863b36d6f64656c5f76616c69646174655f6a736f6ec801000594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d92eec9588eb8595ed9598ec84b8ec9a942120ebacb4ec9787ec9d8420eb8f84ec9980eb939ceba6b4eab98cec9a943fb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92461353534653630662d343338362d346135632d613865372d623533396334326264306437aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6ec7b90594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74afec9888ec95bded95a0eb9e98ec9a94b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92433653661656230322d653130302d343033332d613337372d623065313632343565353739b36d6f64656c5f76616c69646174655f6a736f6ec7bc0594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74b2ec9888ec95bded9598eab3a0ec8bb6ec96b4b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92433326537623032362d623337342d343864332d613433312d303662396664346135326666b36d6f64656c5f76616c69646174655f6a736f6ec801a30594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d9d1ec9588eb8595ed9598ec84b8ec9a942120ec9888ec95bdec9d8420eb8f84ec9980eb939ceba6aceba0a4eab3a020ed9598eb8a94eb8db0ec9a942c20ec96b4eb96a420ec849cebb984ec8aa4eba5bc20ec9b90ed9598ec8b9ceb8a94eca78020ec958ceba0a4eca3bcec8ba420ec889820ec9e88ec9d84eab98cec9a943f20ec9888eba5bc20eb93a4ec96b42c20ebafb8ec9aa92c20eba788ec82aceca7802c20eb9890eb8a9420eb8ba4eba5b820ec849cebb984ec8aa4eab08020ec9e88ec9d8420ec889820ec9e88ec96b4ec9a942eb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92434333363353433382d613539322d343962392d623965642d326462383332636262656133aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6e
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		applied_rules	00000000000000000000000000000009.0.2690235029228105	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		used_knowledge	00000000000000000000000000000008.0.9511633829922934	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		knowledge_context	00000000000000000000000000000008.0.9511633829922934	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		task_result	00000000000000000000000000000009.0.2690235029228105	msgpack	\\x88a768616e646c6564c3a76d657373616765d9d1ec9588eb8595ed9598ec84b8ec9a942120ec9888ec95bdec9d8420eb8f84ec9980eb939ceba6aceba0a4eab3a020ed9598eb8a94eb8db0ec9a942c20ec96b4eb96a420ec849cebb984ec8aa4eba5bc20ec9b90ed9598ec8b9ceb8a94eca78020ec958ceba0a4eca3bcec8ba420ec889820ec9e88ec9d84eab98cec9a943f20ec9888eba5bc20eb93a4ec96b42c20ebafb8ec9aa92c20eba788ec82aceca7802c20eb9890eb8a9420eb8ba4eba5b820ec849cebb984ec8aa4eab08020ec9e88ec9d8420ec889820ec9e88ec96b4ec9a942ea6737461747573b277616974696e675f757365725f696e707574a7666c6f775f6964d92438373166326661652d333963652d346335372d623664392d326231343631313432306332af7461736b5f73657373696f6e5f6964d92466613739383464642d656335312d346531322d393266302d356563623338373737653333b063757272656e745f6e6f64655f6b6579ab61736b5f73657276696365a56572726f72c0a574726163659287a86e6f64655f6b6579a57374617274aa6e6f64655f6c6162656cb7ec849cebb984ec8aa420ebaaa9eba19d20eca1b0ed9a8ca96e6f64655f74797065a866756e6374696f6ea6737461747573a773756363657373ad6e6578745f6265686176696f72ae6576616c756174655f6564676573ae6d656d6f72795f7570646174657391b2617661696c61626c655f7365727669636573a56572726f72c087a86e6f64655f6b6579ab61736b5f73657276696365aa6e6f64655f6c6162656cb7ec849cebb984ec8aa420ec84a0ed839d20eca788ebacb8a96e6f64655f74797065ab696e737472756374696f6ea6737461747573a773756363657373ad6e6578745f6265686176696f72a9776169745f75736572ae6d656d6f72795f7570646174657390a56572726f72c0
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		rules	00000000000000000000000000000012.0.5279757818251062	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		messages	00000000000000000000000000000012.0.5279757818251062	msgpack	\\x97c7b90594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74afec9588eb8595ed9598ec84b8ec9a94b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92433643831396636382d393232352d343335302d623862612d333164383137616136613863b36d6f64656c5f76616c69646174655f6a736f6ec801000594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d92eec9588eb8595ed9598ec84b8ec9a942120ebacb4ec9787ec9d8420eb8f84ec9980eb939ceba6b4eab98cec9a943fb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92461353534653630662d343338362d346135632d613865372d623533396334326264306437aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6ec7b90594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74afec9888ec95bded95a0eb9e98ec9a94b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92433653661656230322d653130302d343033332d613337372d623065313632343565353739b36d6f64656c5f76616c69646174655f6a736f6ec7bc0594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74b2ec9888ec95bded9598eab3a0ec8bb6ec96b4b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92433326537623032362d623337342d343864332d613433312d303662396664346135326666b36d6f64656c5f76616c69646174655f6a736f6ec801a30594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d9d1ec9588eb8595ed9598ec84b8ec9a942120ec9888ec95bdec9d8420eb8f84ec9980eb939ceba6aceba0a4eab3a020ed9598eb8a94eb8db0ec9a942c20ec96b4eb96a420ec849cebb984ec8aa4eba5bc20ec9b90ed9598ec8b9ceb8a94eca78020ec958ceba0a4eca3bcec8ba420ec889820ec9e88ec9d84eab98cec9a943f20ec9888eba5bc20eb93a4ec96b42c20ebafb8ec9aa92c20eba788ec82aceca7802c20eb9890eb8a9420eb8ba4eba5b820ec849cebb984ec8aa4eab08020ec9e88ec9d8420ec889820ec9e88ec96b4ec9a942eb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92434333363353433382d613539322d343962392d623965642d326462383332636262656133aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6ec7b30594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74a9ed97a4ec96b4ecbbb7b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92435613336646537612d326364392d343233632d383938632d613633653631373336613233b36d6f64656c5f76616c69646174655f6a736f6ec8016f0594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d99deca384ec86a1ed9598eca780eba78c20ed9884ec9eac20eca09ceab3b520eab080eb8aa5ed959c20ec849cebb984ec8aa420ebaaa9eba19dec9d8420ebb688eb9facec98ac20ec889820ec9786ec8ab5eb8b88eb8ba42e20ec9888ec95bded9598ec8ba420ec849cebb984ec8aa4eba5bc20eab5acecb2b4eca081ec9cbceba19c20ec958ceba0a4eca3bcec8ba420ec889820ec9e88eb8298ec9a943fb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92432636430653232322d303738662d346237352d616138642d323563613436323865613430aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6e
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		applied_rules	00000000000000000000000000000012.0.5279757818251062	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		used_knowledge	00000000000000000000000000000011.0.05355762639814854	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		knowledge_context	00000000000000000000000000000011.0.05355762639814854	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		task_result	00000000000000000000000000000012.0.5279757818251062	msgpack	\\x88a768616e646c6564c3a76d657373616765d99deca384ec86a1ed9598eca780eba78c20ed9884ec9eac20eca09ceab3b520eab080eb8aa5ed959c20ec849cebb984ec8aa420ebaaa9eba19dec9d8420ebb688eb9facec98ac20ec889820ec9786ec8ab5eb8b88eb8ba42e20ec9888ec95bded9598ec8ba420ec849cebb984ec8aa4eba5bc20eab5acecb2b4eca081ec9cbceba19c20ec958ceba0a4eca3bcec8ba420ec889820ec9e88eb8298ec9a943fa6737461747573b277616974696e675f757365725f696e707574a7666c6f775f6964d92438373166326661652d333963652d346335372d623664392d326231343631313432306332af7461736b5f73657373696f6e5f6964d92466613739383464642d656335312d346531322d393266302d356563623338373737653333b063757272656e745f6e6f64655f6b6579ab61736b5f73657276696365a56572726f72c0a574726163659187a86e6f64655f6b6579ab61736b5f73657276696365aa6e6f64655f6c6162656cb7ec849cebb984ec8aa420ec84a0ed839d20eca788ebacb8a96e6f64655f74797065ab696e737472756374696f6ea6737461747573a773756363657373ad6e6578745f6265686176696f72a9776169745f75736572ae6d656d6f72795f7570646174657390a56572726f72c0
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		rules	00000000000000000000000000000015.0.13771854855949106	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		messages	00000000000000000000000000000015.0.13771854855949106	msgpack	\\x99c7b90594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74afec9588eb8595ed9598ec84b8ec9a94b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92433643831396636382d393232352d343335302d623862612d333164383137616136613863b36d6f64656c5f76616c69646174655f6a736f6ec801000594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d92eec9588eb8595ed9598ec84b8ec9a942120ebacb4ec9787ec9d8420eb8f84ec9980eb939ceba6b4eab98cec9a943fb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92461353534653630662d343338362d346135632d613865372d623533396334326264306437aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6ec7b90594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74afec9888ec95bded95a0eb9e98ec9a94b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92433653661656230322d653130302d343033332d613337372d623065313632343565353739b36d6f64656c5f76616c69646174655f6a736f6ec7bc0594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74b2ec9888ec95bded9598eab3a0ec8bb6ec96b4b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92433326537623032362d623337342d343864332d613433312d303662396664346135326666b36d6f64656c5f76616c69646174655f6a736f6ec801a30594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d9d1ec9588eb8595ed9598ec84b8ec9a942120ec9888ec95bdec9d8420eb8f84ec9980eb939ceba6aceba0a4eab3a020ed9598eb8a94eb8db0ec9a942c20ec96b4eb96a420ec849cebb984ec8aa4eba5bc20ec9b90ed9598ec8b9ceb8a94eca78020ec958ceba0a4eca3bcec8ba420ec889820ec9e88ec9d84eab98cec9a943f20ec9888eba5bc20eb93a4ec96b42c20ebafb8ec9aa92c20eba788ec82aceca7802c20eb9890eb8a9420eb8ba4eba5b820ec849cebb984ec8aa4eab08020ec9e88ec9d8420ec889820ec9e88ec96b4ec9a942eb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92434333363353433382d613539322d343962392d623965642d326462383332636262656133aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6ec7b30594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74a9ed97a4ec96b4ecbbb7b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92435613336646537612d326364392d343233632d383938632d613633653631373336613233b36d6f64656c5f76616c69646174655f6a736f6ec8016f0594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d99deca384ec86a1ed9598eca780eba78c20ed9884ec9eac20eca09ceab3b520eab080eb8aa5ed959c20ec849cebb984ec8aa420ebaaa9eba19dec9d8420ebb688eb9facec98ac20ec889820ec9786ec8ab5eb8b88eb8ba42e20ec9888ec95bded9598ec8ba420ec849cebb984ec8aa4eba5bc20eab5acecb2b4eca081ec9cbceba19c20ec958ceba0a4eca3bcec8ba420ec889820ec9e88eb8298ec9a943fb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92432636430653232322d303738662d346237352d616138642d323563613436323865613430aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6ec7b60594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74acec9888ec95bded95a0eb9e98b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92433333162623030322d623536632d343130302d616431382d353431623463333664386265b36d6f64656c5f76616c69646174655f6a736f6ec801900594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d9beec9888ec95bdec9d8420eb8f84ec9980eb939ceba6aceab3a020ec8bb6ec9d80eb8db02c20ed9884ec9eac20ec96b4eb96a420ec849cebb984ec8aa4eba5bc20ec9b90ed9598ec8b9ceb8a94eca78020ec958ceba0a4eca3bcec8ba420ec889820ec9e88eb8298ec9a943f20ec9888eba5bc20eb93a4ec96b42c20ebafb8ec9aa92c20eba788ec82aceca7802c20eb9890eb8a9420eb8ba4eba5b820ec849cebb984ec8aa4eab08020ec9e88ec9d8420ec889820ec9e88ec96b4ec9a942eb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92436333938366636662d383237622d343836392d623434382d323365343639626333653666aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6e
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		task_result	00000000000000000000000000000015.0.13771854855949106	msgpack	\\x88a768616e646c6564c3a76d657373616765d9beec9888ec95bdec9d8420eb8f84ec9980eb939ceba6aceab3a020ec8bb6ec9d80eb8db02c20ed9884ec9eac20ec96b4eb96a420ec849cebb984ec8aa4eba5bc20ec9b90ed9598ec8b9ceb8a94eca78020ec958ceba0a4eca3bcec8ba420ec889820ec9e88eb8298ec9a943f20ec9888eba5bc20eb93a4ec96b42c20ebafb8ec9aa92c20eba788ec82aceca7802c20eb9890eb8a9420eb8ba4eba5b820ec849cebb984ec8aa4eab08020ec9e88ec9d8420ec889820ec9e88ec96b4ec9a942ea6737461747573b277616974696e675f757365725f696e707574a7666c6f775f6964d92438373166326661652d333963652d346335372d623664392d326231343631313432306332af7461736b5f73657373696f6e5f6964d92466613739383464642d656335312d346531322d393266302d356563623338373737653333b063757272656e745f6e6f64655f6b6579ab61736b5f73657276696365a56572726f72c0a574726163659187a86e6f64655f6b6579ab61736b5f73657276696365aa6e6f64655f6c6162656cb7ec849cebb984ec8aa420ec84a0ed839d20eca788ebacb8a96e6f64655f74797065ab696e737472756374696f6ea6737461747573a773756363657373ad6e6578745f6265686176696f72a9776169745f75736572ae6d656d6f72795f7570646174657390a56572726f72c0
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		applied_rules	00000000000000000000000000000015.0.13771854855949106	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		used_knowledge	00000000000000000000000000000014.0.7237614987477308	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		knowledge_context	00000000000000000000000000000014.0.7237614987477308	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		rules	00000000000000000000000000000018.0.9782689613373156	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		messages	00000000000000000000000000000018.0.9782689613373156	msgpack	\\x9bc7b90594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74afec9588eb8595ed9598ec84b8ec9a94b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92433643831396636382d393232352d343335302d623862612d333164383137616136613863b36d6f64656c5f76616c69646174655f6a736f6ec801000594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d92eec9588eb8595ed9598ec84b8ec9a942120ebacb4ec9787ec9d8420eb8f84ec9980eb939ceba6b4eab98cec9a943fb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92461353534653630662d343338362d346135632d613865372d623533396334326264306437aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6ec7b90594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74afec9888ec95bded95a0eb9e98ec9a94b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92433653661656230322d653130302d343033332d613337372d623065313632343565353739b36d6f64656c5f76616c69646174655f6a736f6ec7bc0594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74b2ec9888ec95bded9598eab3a0ec8bb6ec96b4b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92433326537623032362d623337342d343864332d613433312d303662396664346135326666b36d6f64656c5f76616c69646174655f6a736f6ec801a30594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d9d1ec9588eb8595ed9598ec84b8ec9a942120ec9888ec95bdec9d8420eb8f84ec9980eb939ceba6aceba0a4eab3a020ed9598eb8a94eb8db0ec9a942c20ec96b4eb96a420ec849cebb984ec8aa4eba5bc20ec9b90ed9598ec8b9ceb8a94eca78020ec958ceba0a4eca3bcec8ba420ec889820ec9e88ec9d84eab98cec9a943f20ec9888eba5bc20eb93a4ec96b42c20ebafb8ec9aa92c20eba788ec82aceca7802c20eb9890eb8a9420eb8ba4eba5b820ec849cebb984ec8aa4eab08020ec9e88ec9d8420ec889820ec9e88ec96b4ec9a942eb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92434333363353433382d613539322d343962392d623965642d326462383332636262656133aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6ec7b30594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74a9ed97a4ec96b4ecbbb7b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92435613336646537612d326364392d343233632d383938632d613633653631373336613233b36d6f64656c5f76616c69646174655f6a736f6ec8016f0594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d99deca384ec86a1ed9598eca780eba78c20ed9884ec9eac20eca09ceab3b520eab080eb8aa5ed959c20ec849cebb984ec8aa420ebaaa9eba19dec9d8420ebb688eb9facec98ac20ec889820ec9786ec8ab5eb8b88eb8ba42e20ec9888ec95bded9598ec8ba420ec849cebb984ec8aa4eba5bc20eab5acecb2b4eca081ec9cbceba19c20ec958ceba0a4eca3bcec8ba420ec889820ec9e88eb8298ec9a943fb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92432636430653232322d303738662d346237352d616138642d323563613436323865613430aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6ec7b60594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74acec9888ec95bded95a0eb9e98b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92433333162623030322d623536632d343130302d616431382d353431623463333664386265b36d6f64656c5f76616c69646174655f6a736f6ec801900594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d9beec9888ec95bdec9d8420eb8f84ec9980eb939ceba6aceab3a020ec8bb6ec9d80eb8db02c20ed9884ec9eac20ec96b4eb96a420ec849cebb984ec8aa4eba5bc20ec9b90ed9598ec8b9ceb8a94eca78020ec958ceba0a4eca3bcec8ba420ec889820ec9e88eb8298ec9a943f20ec9888eba5bc20eb93a4ec96b42c20ebafb8ec9aa92c20eba788ec82aceca7802c20eb9890eb8a9420eb8ba4eba5b820ec849cebb984ec8aa4eab08020ec9e88ec9d8420ec889820ec9e88ec96b4ec9a942eb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92436333938366636662d383237622d343836392d623434382d323365343639626333653666aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6ec7b30594bd6c616e67636861696e5f636f72652e6d657373616765732e68756d616eac48756d616e4d65737361676586a7636f6e74656e74a9ed97a4ec96b4ecbbb7b16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a568756d616ea46e616d65c0a26964d92432653535616533662d656333632d343633392d616334642d623438356630346131643061b36d6f64656c5f76616c69646174655f6a736f6ec801770594ba6c616e67636861696e5f636f72652e6d657373616765732e6169a941494d65737361676589a7636f6e74656e74d9a5eca384ec86a1ed9598eca780eba78c20ed9884ec9eac20eca09ceab3b520eab080eb8aa5ed959c20ec849cebb984ec8aa420ebaaa9eba19dec9d8420ebb688eb9facec98ac20ec889820ec9786ec8ab5eb8b88eb8ba42e20ec9888ec95bded9598ec8ba420ec849cebb984ec8aa4ebaa85ec9d8420eca1b0eab88820eb8d9420ec9e90ec84b8ed9e8820ec958ceba0a4eca3bcec8ba420ec889820ec9e88eb8298ec9a943fb16164646974696f6e616c5f6b776172677380b1726573706f6e73655f6d6574616461746180a474797065a26169a46e616d65c0a26964d92438613839306335632d656565632d346139392d393435662d386161336334303733626562aa746f6f6c5f63616c6c7390b2696e76616c69645f746f6f6c5f63616c6c7390ae75736167655f6d65746164617461c0b36d6f64656c5f76616c69646174655f6a736f6e
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		task_result	00000000000000000000000000000018.0.9782689613373156	msgpack	\\x88a768616e646c6564c3a76d657373616765d9a5eca384ec86a1ed9598eca780eba78c20ed9884ec9eac20eca09ceab3b520eab080eb8aa5ed959c20ec849cebb984ec8aa420ebaaa9eba19dec9d8420ebb688eb9facec98ac20ec889820ec9786ec8ab5eb8b88eb8ba42e20ec9888ec95bded9598ec8ba420ec849cebb984ec8aa4ebaa85ec9d8420eca1b0eab88820eb8d9420ec9e90ec84b8ed9e8820ec958ceba0a4eca3bcec8ba420ec889820ec9e88eb8298ec9a943fa6737461747573b277616974696e675f757365725f696e707574a7666c6f775f6964d92438373166326661652d333963652d346335372d623664392d326231343631313432306332af7461736b5f73657373696f6e5f6964d92466613739383464642d656335312d346531322d393266302d356563623338373737653333b063757272656e745f6e6f64655f6b6579ab61736b5f73657276696365a56572726f72c0a574726163659187a86e6f64655f6b6579ab61736b5f73657276696365aa6e6f64655f6c6162656cb7ec849cebb984ec8aa420ec84a0ed839d20eca788ebacb8a96e6f64655f74797065ab696e737472756374696f6ea6737461747573a773756363657373ad6e6578745f6265686176696f72a9776169745f75736572ae6d656d6f72795f7570646174657390a56572726f72c0
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		applied_rules	00000000000000000000000000000018.0.9782689613373156	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		used_knowledge	00000000000000000000000000000017.0.039232078942281756	msgpack	\\x90
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		knowledge_context	00000000000000000000000000000017.0.039232078942281756	msgpack	\\x90
\.


--
-- Data for Name: checkpoint_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.checkpoint_migrations (v) FROM stdin;
0
1
2
3
4
5
6
7
8
9
\.


--
-- Data for Name: checkpoint_writes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.checkpoint_writes (thread_id, checkpoint_ns, checkpoint_id, task_id, idx, channel, type, blob, task_path) FROM stdin;
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_21f3c937-106b-4199-b00b-4af5ca04893d		1f18fb2c-2f8f-69aa-8003-f9bdebe2c0eb	dd34f272-cb7e-b3d2-2cb2-2f26b723118b	-1	__error__	msgpack	\\xd9654572726f722050475253543230353a0a4d6573736167653a20436f756c64206e6f742066696e6420746865207461626c6520277075626c69632e6275696c74696e5f72756c655f6f76657272696465732720696e2074686520736368656d61206361636865	~__pregel_pull, prepare
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_21f3c937-106b-4199-b00b-4af5ca04893d		1f18fb2c-660a-6374-8005-fe662f8b9b3c	c21a1ec4-5310-3805-256f-54a9aeb30b93	-1	__error__	msgpack	\\xd9654572726f722050475253543230353a0a4d6573736167653a20436f756c64206e6f742066696e6420746865207461626c6520277075626c69632e6275696c74696e5f72756c655f6f76657272696465732720696e2074686520736368656d61206361636865	~__pregel_pull, prepare
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_63d75d43-8a8e-4581-9774-99e4443babe7		1f18fb70-69dc-683d-8003-ef82cb891d3e	8f3ad3a9-5ea7-0e8e-ac15-5cb2a9250d2f	-1	__error__	msgpack	\\xd96d4572726f722050475253543131363a0a4d6573736167653a2043616e6e6f7420636f657263652074686520726573756c7420746f20612073696e676c65204a534f4e206f626a6563740a44657461696c733a2054686520726573756c7420636f6e7461696e73203020726f7773	~__pregel_pull, prepare
\.


--
-- Data for Name: checkpoints; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.checkpoints (thread_id, checkpoint_ns, checkpoint_id, parent_checkpoint_id, type, checkpoint, metadata) FROM stdin;
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_21f3c937-106b-4199-b00b-4af5ca04893d		1f18fb2b-f739-6434-8001-bfc956285b47	\N	\N	{"v": 4, "id": "1f18fb2b-f739-6434-8001-bfc956285b47", "ts": "2026-08-04T03:15:30.417143+00:00", "versions_seen": {"prepare": {"branch:to:prepare": "00000000000000000000000000000002.0.36295227180849976"}, "__input__": {}, "__start__": {"__start__": "00000000000000000000000000000001.0.5715731783650185"}}, "channel_values": {"intent": null, "channel": "web_chat", "task_type": "none", "ai_enabled": true, "session_id": "web_call_21f3c937-106b-4199-b00b-4af5ca04893d", "log_message": null, "next_action": null, "task_status": null, "user_message": "안녕하세요", "use_knowledge": false, "final_response": null, "conversation_id": null, "decision_reason": null, "organization_id": "a55c98f9-74ba-40d8-bc9d-bc3f1c0870da", "follow_up_response": null, "should_end_session": false, "knowledge_folder_id": null}, "channel_versions": {"rules": "00000000000000000000000000000003.0.6809172698225958", "intent": "00000000000000000000000000000003.0.6809172698225958", "channel": "00000000000000000000000000000002.0.36295227180849976", "messages": "00000000000000000000000000000003.0.6809172698225958", "__start__": "00000000000000000000000000000002.0.36295227180849976", "task_type": "00000000000000000000000000000003.0.6809172698225958", "ai_enabled": "00000000000000000000000000000003.0.6809172698225958", "session_id": "00000000000000000000000000000002.0.36295227180849976", "log_message": "00000000000000000000000000000002.0.36295227180849976", "next_action": "00000000000000000000000000000003.0.6809172698225958", "user_message": "00000000000000000000000000000002.0.36295227180849976", "applied_rules": "00000000000000000000000000000003.0.6809172698225958", "use_knowledge": "00000000000000000000000000000003.0.6809172698225958", "final_response": "00000000000000000000000000000003.0.6809172698225958", "used_knowledge": "00000000000000000000000000000002.0.36295227180849976", "conversation_id": "00000000000000000000000000000003.0.6809172698225958", "decision_reason": "00000000000000000000000000000002.0.36295227180849976", "organization_id": "00000000000000000000000000000002.0.36295227180849976", "branch:to:prepare": "00000000000000000000000000000003.0.6809172698225958", "knowledge_context": "00000000000000000000000000000002.0.36295227180849976", "follow_up_response": "00000000000000000000000000000002.0.36295227180849976", "should_end_session": "00000000000000000000000000000003.0.6809172698225958", "knowledge_folder_id": "00000000000000000000000000000002.0.36295227180849976"}, "updated_channels": ["ai_enabled", "applied_rules", "conversation_id", "final_response", "intent", "messages", "next_action", "rules", "should_end_session", "task_type", "use_knowledge"]}	{"step": 1, "source": "loop", "parents": {}}
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_21f3c937-106b-4199-b00b-4af5ca04893d		1f18fb2c-2f8f-69aa-8003-f9bdebe2c0eb	1f18fb2b-f739-6434-8001-bfc956285b47	\N	{"v": 4, "id": "1f18fb2c-2f8f-69aa-8003-f9bdebe2c0eb", "ts": "2026-08-04T03:15:36.512413+00:00", "versions_seen": {"prepare": {"branch:to:prepare": "00000000000000000000000000000002.0.36295227180849976"}, "__input__": {}, "__start__": {"__start__": "00000000000000000000000000000004.0.8302863030697012"}}, "channel_values": {"intent": null, "channel": "web_chat", "task_type": null, "ai_enabled": true, "session_id": "web_call_21f3c937-106b-4199-b00b-4af5ca04893d", "log_message": null, "next_action": null, "task_status": null, "user_message": "예약할래요", "use_knowledge": false, "final_response": null, "conversation_id": null, "decision_reason": null, "organization_id": "a55c98f9-74ba-40d8-bc9d-bc3f1c0870da", "branch:to:prepare": null, "follow_up_response": null, "should_end_session": false, "knowledge_folder_id": null}, "channel_versions": {"rules": "00000000000000000000000000000005.0.07407476485126607", "intent": "00000000000000000000000000000005.0.07407476485126607", "channel": "00000000000000000000000000000005.0.07407476485126607", "messages": "00000000000000000000000000000003.0.6809172698225958", "__start__": "00000000000000000000000000000005.0.07407476485126607", "task_type": "00000000000000000000000000000005.0.07407476485126607", "ai_enabled": "00000000000000000000000000000005.0.07407476485126607", "session_id": "00000000000000000000000000000005.0.07407476485126607", "log_message": "00000000000000000000000000000005.0.07407476485126607", "next_action": "00000000000000000000000000000005.0.07407476485126607", "user_message": "00000000000000000000000000000005.0.07407476485126607", "applied_rules": "00000000000000000000000000000005.0.07407476485126607", "use_knowledge": "00000000000000000000000000000005.0.07407476485126607", "final_response": "00000000000000000000000000000005.0.07407476485126607", "used_knowledge": "00000000000000000000000000000005.0.07407476485126607", "conversation_id": "00000000000000000000000000000005.0.07407476485126607", "decision_reason": "00000000000000000000000000000005.0.07407476485126607", "organization_id": "00000000000000000000000000000005.0.07407476485126607", "branch:to:prepare": "00000000000000000000000000000005.0.07407476485126607", "knowledge_context": "00000000000000000000000000000005.0.07407476485126607", "follow_up_response": "00000000000000000000000000000005.0.07407476485126607", "should_end_session": "00000000000000000000000000000005.0.07407476485126607", "knowledge_folder_id": "00000000000000000000000000000005.0.07407476485126607"}, "updated_channels": ["ai_enabled", "applied_rules", "branch:to:prepare", "channel", "conversation_id", "decision_reason", "final_response", "follow_up_response", "intent", "knowledge_context", "knowledge_folder_id", "log_message", "next_action", "organization_id", "rules", "session_id", "should_end_session", "task_type", "use_knowledge", "used_knowledge", "user_message"]}	{"step": 3, "source": "loop", "parents": {}}
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_21f3c937-106b-4199-b00b-4af5ca04893d		1f18fb2c-660a-6374-8005-fe662f8b9b3c	1f18fb2c-2f8f-69aa-8003-f9bdebe2c0eb	\N	{"v": 4, "id": "1f18fb2c-660a-6374-8005-fe662f8b9b3c", "ts": "2026-08-04T03:15:42.194253+00:00", "versions_seen": {"prepare": {"branch:to:prepare": "00000000000000000000000000000005.0.07407476485126607"}, "__input__": {}, "__start__": {"__start__": "00000000000000000000000000000006.0.8213819059706675"}}, "channel_values": {"intent": null, "channel": "web_chat", "task_type": null, "ai_enabled": true, "session_id": "web_call_21f3c937-106b-4199-b00b-4af5ca04893d", "log_message": null, "next_action": null, "task_status": null, "user_message": "이상욱입니다", "use_knowledge": false, "final_response": null, "conversation_id": null, "decision_reason": null, "organization_id": "a55c98f9-74ba-40d8-bc9d-bc3f1c0870da", "branch:to:prepare": null, "follow_up_response": null, "should_end_session": false, "knowledge_folder_id": null}, "channel_versions": {"rules": "00000000000000000000000000000007.0.03859929765606662", "intent": "00000000000000000000000000000007.0.03859929765606662", "channel": "00000000000000000000000000000007.0.03859929765606662", "messages": "00000000000000000000000000000003.0.6809172698225958", "__start__": "00000000000000000000000000000007.0.03859929765606662", "task_type": "00000000000000000000000000000007.0.03859929765606662", "ai_enabled": "00000000000000000000000000000007.0.03859929765606662", "session_id": "00000000000000000000000000000007.0.03859929765606662", "log_message": "00000000000000000000000000000007.0.03859929765606662", "next_action": "00000000000000000000000000000007.0.03859929765606662", "user_message": "00000000000000000000000000000007.0.03859929765606662", "applied_rules": "00000000000000000000000000000007.0.03859929765606662", "use_knowledge": "00000000000000000000000000000007.0.03859929765606662", "final_response": "00000000000000000000000000000007.0.03859929765606662", "used_knowledge": "00000000000000000000000000000007.0.03859929765606662", "conversation_id": "00000000000000000000000000000007.0.03859929765606662", "decision_reason": "00000000000000000000000000000007.0.03859929765606662", "organization_id": "00000000000000000000000000000007.0.03859929765606662", "branch:to:prepare": "00000000000000000000000000000007.0.03859929765606662", "knowledge_context": "00000000000000000000000000000007.0.03859929765606662", "follow_up_response": "00000000000000000000000000000007.0.03859929765606662", "should_end_session": "00000000000000000000000000000007.0.03859929765606662", "knowledge_folder_id": "00000000000000000000000000000007.0.03859929765606662"}, "updated_channels": ["ai_enabled", "applied_rules", "branch:to:prepare", "channel", "conversation_id", "decision_reason", "final_response", "follow_up_response", "intent", "knowledge_context", "knowledge_folder_id", "log_message", "next_action", "organization_id", "rules", "session_id", "should_end_session", "task_type", "use_knowledge", "used_knowledge", "user_message"]}	{"step": 5, "source": "loop", "parents": {}}
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_63d75d43-8a8e-4581-9774-99e4443babe7		1f18fb70-4619-6863-8001-8361fe46e11c	\N	\N	{"v": 4, "id": "1f18fb70-4619-6863-8001-8361fe46e11c", "ts": "2026-08-04T03:46:04.049218+00:00", "versions_seen": {"prepare": {"branch:to:prepare": "00000000000000000000000000000002.0.11971887407325221"}, "__input__": {}, "__start__": {"__start__": "00000000000000000000000000000001.0.476804505218831"}}, "channel_values": {"intent": null, "channel": "web_chat", "task_type": "none", "ai_enabled": true, "session_id": "web_call_63d75d43-8a8e-4581-9774-99e4443babe7", "log_message": null, "next_action": null, "task_status": null, "user_message": "안녕하세요", "use_knowledge": false, "final_response": null, "conversation_id": null, "decision_reason": null, "organization_id": "a55c98f9-74ba-40d8-bc9d-bc3f1c0870da", "follow_up_response": null, "should_end_session": false, "knowledge_folder_id": null}, "channel_versions": {"rules": "00000000000000000000000000000003.0.6190068366000311", "intent": "00000000000000000000000000000003.0.6190068366000311", "channel": "00000000000000000000000000000002.0.11971887407325221", "messages": "00000000000000000000000000000003.0.6190068366000311", "__start__": "00000000000000000000000000000002.0.11971887407325221", "task_type": "00000000000000000000000000000003.0.6190068366000311", "ai_enabled": "00000000000000000000000000000003.0.6190068366000311", "session_id": "00000000000000000000000000000002.0.11971887407325221", "log_message": "00000000000000000000000000000002.0.11971887407325221", "next_action": "00000000000000000000000000000003.0.6190068366000311", "user_message": "00000000000000000000000000000002.0.11971887407325221", "applied_rules": "00000000000000000000000000000003.0.6190068366000311", "use_knowledge": "00000000000000000000000000000003.0.6190068366000311", "final_response": "00000000000000000000000000000003.0.6190068366000311", "used_knowledge": "00000000000000000000000000000002.0.11971887407325221", "conversation_id": "00000000000000000000000000000003.0.6190068366000311", "decision_reason": "00000000000000000000000000000002.0.11971887407325221", "organization_id": "00000000000000000000000000000002.0.11971887407325221", "branch:to:prepare": "00000000000000000000000000000003.0.6190068366000311", "knowledge_context": "00000000000000000000000000000002.0.11971887407325221", "follow_up_response": "00000000000000000000000000000002.0.11971887407325221", "should_end_session": "00000000000000000000000000000003.0.6190068366000311", "knowledge_folder_id": "00000000000000000000000000000002.0.11971887407325221"}, "updated_channels": ["ai_enabled", "applied_rules", "conversation_id", "final_response", "intent", "messages", "next_action", "rules", "should_end_session", "task_type", "use_knowledge"]}	{"step": 1, "source": "loop", "parents": {}}
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_63d75d43-8a8e-4581-9774-99e4443babe7		1f18fb70-69dc-683d-8003-ef82cb891d3e	1f18fb70-4619-6863-8001-8361fe46e11c	\N	{"v": 4, "id": "1f18fb70-69dc-683d-8003-ef82cb891d3e", "ts": "2026-08-04T03:46:08.206456+00:00", "versions_seen": {"prepare": {"branch:to:prepare": "00000000000000000000000000000002.0.11971887407325221"}, "__input__": {}, "__start__": {"__start__": "00000000000000000000000000000004.0.9858912817982175"}}, "channel_values": {"intent": null, "channel": "web_chat", "task_type": null, "ai_enabled": true, "session_id": "web_call_63d75d43-8a8e-4581-9774-99e4443babe7", "log_message": null, "next_action": null, "task_status": null, "user_message": "예약할래요", "use_knowledge": false, "final_response": null, "conversation_id": null, "decision_reason": null, "organization_id": "a55c98f9-74ba-40d8-bc9d-bc3f1c0870da", "branch:to:prepare": null, "follow_up_response": null, "should_end_session": false, "knowledge_folder_id": null}, "channel_versions": {"rules": "00000000000000000000000000000005.0.4275327859592485", "intent": "00000000000000000000000000000005.0.4275327859592485", "channel": "00000000000000000000000000000005.0.4275327859592485", "messages": "00000000000000000000000000000003.0.6190068366000311", "__start__": "00000000000000000000000000000005.0.4275327859592485", "task_type": "00000000000000000000000000000005.0.4275327859592485", "ai_enabled": "00000000000000000000000000000005.0.4275327859592485", "session_id": "00000000000000000000000000000005.0.4275327859592485", "log_message": "00000000000000000000000000000005.0.4275327859592485", "next_action": "00000000000000000000000000000005.0.4275327859592485", "user_message": "00000000000000000000000000000005.0.4275327859592485", "applied_rules": "00000000000000000000000000000005.0.4275327859592485", "use_knowledge": "00000000000000000000000000000005.0.4275327859592485", "final_response": "00000000000000000000000000000005.0.4275327859592485", "used_knowledge": "00000000000000000000000000000005.0.4275327859592485", "conversation_id": "00000000000000000000000000000005.0.4275327859592485", "decision_reason": "00000000000000000000000000000005.0.4275327859592485", "organization_id": "00000000000000000000000000000005.0.4275327859592485", "branch:to:prepare": "00000000000000000000000000000005.0.4275327859592485", "knowledge_context": "00000000000000000000000000000005.0.4275327859592485", "follow_up_response": "00000000000000000000000000000005.0.4275327859592485", "should_end_session": "00000000000000000000000000000005.0.4275327859592485", "knowledge_folder_id": "00000000000000000000000000000005.0.4275327859592485"}, "updated_channels": ["ai_enabled", "applied_rules", "branch:to:prepare", "channel", "conversation_id", "decision_reason", "final_response", "follow_up_response", "intent", "knowledge_context", "knowledge_folder_id", "log_message", "next_action", "organization_id", "rules", "session_id", "should_end_session", "task_type", "use_knowledge", "used_knowledge", "user_message"]}	{"step": 3, "source": "loop", "parents": {}}
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		1f18fb77-20d3-6852-8001-7ddf93df91aa	\N	\N	{"v": 4, "id": "1f18fb77-20d3-6852-8001-7ddf93df91aa", "ts": "2026-08-04T03:49:08.045376+00:00", "versions_seen": {"prepare": {"branch:to:prepare": "00000000000000000000000000000002.0.14841754595619405"}, "__input__": {}, "__start__": {"__start__": "00000000000000000000000000000001.0.5628765598906152"}}, "channel_values": {"intent": null, "channel": "web_chat", "task_type": "none", "ai_enabled": true, "session_id": "web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39", "log_message": null, "next_action": null, "task_status": null, "user_message": "안녕하세요", "use_knowledge": false, "final_response": null, "conversation_id": null, "decision_reason": null, "organization_id": "a55c98f9-74ba-40d8-bc9d-bc3f1c0870da", "follow_up_response": null, "should_end_session": false, "knowledge_folder_id": null}, "channel_versions": {"rules": "00000000000000000000000000000003.0.32842734419882347", "intent": "00000000000000000000000000000003.0.32842734419882347", "channel": "00000000000000000000000000000002.0.14841754595619405", "messages": "00000000000000000000000000000003.0.32842734419882347", "__start__": "00000000000000000000000000000002.0.14841754595619405", "task_type": "00000000000000000000000000000003.0.32842734419882347", "ai_enabled": "00000000000000000000000000000003.0.32842734419882347", "session_id": "00000000000000000000000000000002.0.14841754595619405", "log_message": "00000000000000000000000000000002.0.14841754595619405", "next_action": "00000000000000000000000000000003.0.32842734419882347", "user_message": "00000000000000000000000000000002.0.14841754595619405", "applied_rules": "00000000000000000000000000000003.0.32842734419882347", "use_knowledge": "00000000000000000000000000000003.0.32842734419882347", "final_response": "00000000000000000000000000000003.0.32842734419882347", "used_knowledge": "00000000000000000000000000000002.0.14841754595619405", "conversation_id": "00000000000000000000000000000003.0.32842734419882347", "decision_reason": "00000000000000000000000000000002.0.14841754595619405", "organization_id": "00000000000000000000000000000002.0.14841754595619405", "branch:to:prepare": "00000000000000000000000000000003.0.32842734419882347", "knowledge_context": "00000000000000000000000000000002.0.14841754595619405", "follow_up_response": "00000000000000000000000000000002.0.14841754595619405", "should_end_session": "00000000000000000000000000000003.0.32842734419882347", "knowledge_folder_id": "00000000000000000000000000000002.0.14841754595619405"}, "updated_channels": ["ai_enabled", "applied_rules", "conversation_id", "final_response", "intent", "messages", "next_action", "rules", "should_end_session", "task_type", "use_knowledge"]}	{"step": 1, "source": "loop", "parents": {}}
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		1f18fb77-546f-652d-8004-28b0b3c8d50a	1f18fb77-20d3-6852-8001-7ddf93df91aa	\N	{"v": 4, "id": "1f18fb77-546f-652d-8004-28b0b3c8d50a", "ts": "2026-08-04T03:49:13.457033+00:00", "versions_seen": {"prepare": {"branch:to:prepare": "00000000000000000000000000000005.0.47071022819147057"}, "__input__": {}, "__start__": {"__start__": "00000000000000000000000000000004.0.9963570389036149"}}, "channel_values": {"intent": null, "channel": "web_chat", "task_type": null, "ai_enabled": true, "session_id": "web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39", "log_message": null, "next_action": null, "task_status": null, "user_message": "예약할래요", "use_knowledge": false, "final_response": null, "conversation_id": "23ec54b8-318c-4d2c-b084-6078d67c181e", "decision_reason": null, "organization_id": "a55c98f9-74ba-40d8-bc9d-bc3f1c0870da", "follow_up_response": null, "should_end_session": false, "knowledge_folder_id": null}, "channel_versions": {"rules": "00000000000000000000000000000006.0.22174538618501116", "intent": "00000000000000000000000000000005.0.47071022819147057", "channel": "00000000000000000000000000000005.0.47071022819147057", "messages": "00000000000000000000000000000006.0.22174538618501116", "__start__": "00000000000000000000000000000005.0.47071022819147057", "task_type": "00000000000000000000000000000005.0.47071022819147057", "ai_enabled": "00000000000000000000000000000006.0.22174538618501116", "session_id": "00000000000000000000000000000005.0.47071022819147057", "log_message": "00000000000000000000000000000005.0.47071022819147057", "next_action": "00000000000000000000000000000005.0.47071022819147057", "user_message": "00000000000000000000000000000005.0.47071022819147057", "applied_rules": "00000000000000000000000000000006.0.22174538618501116", "use_knowledge": "00000000000000000000000000000005.0.47071022819147057", "final_response": "00000000000000000000000000000005.0.47071022819147057", "used_knowledge": "00000000000000000000000000000005.0.47071022819147057", "conversation_id": "00000000000000000000000000000006.0.22174538618501116", "decision_reason": "00000000000000000000000000000005.0.47071022819147057", "organization_id": "00000000000000000000000000000005.0.47071022819147057", "branch:to:prepare": "00000000000000000000000000000006.0.22174538618501116", "knowledge_context": "00000000000000000000000000000005.0.47071022819147057", "follow_up_response": "00000000000000000000000000000005.0.47071022819147057", "should_end_session": "00000000000000000000000000000005.0.47071022819147057", "knowledge_folder_id": "00000000000000000000000000000005.0.47071022819147057"}, "updated_channels": ["ai_enabled", "applied_rules", "conversation_id", "messages", "rules"]}	{"step": 4, "source": "loop", "parents": {}}
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817115123		1f18fbb9-3825-6783-8001-f8daa586c2e3	\N	\N	{"v": 4, "id": "1f18fbb9-3825-6783-8001-f8daa586c2e3", "ts": "2026-08-04T04:18:42.164726+00:00", "versions_seen": {"prepare": {"branch:to:prepare": "00000000000000000000000000000002.0.03794249926656812"}, "__input__": {}, "__start__": {"__start__": "00000000000000000000000000000001.0.18684247164177004"}}, "channel_values": {"intent": null, "channel": "web_chat", "task_type": "none", "ai_enabled": true, "session_id": "rule_preview_1785817115123", "log_message": null, "next_action": null, "task_status": null, "user_message": "안녕하세요", "use_knowledge": false, "final_response": null, "conversation_id": null, "decision_reason": null, "organization_id": "a55c98f9-74ba-40d8-bc9d-bc3f1c0870da", "follow_up_response": null, "should_end_session": false, "knowledge_folder_id": null}, "channel_versions": {"rules": "00000000000000000000000000000003.0.7952789264169401", "intent": "00000000000000000000000000000003.0.7952789264169401", "channel": "00000000000000000000000000000002.0.03794249926656812", "messages": "00000000000000000000000000000003.0.7952789264169401", "__start__": "00000000000000000000000000000002.0.03794249926656812", "task_type": "00000000000000000000000000000003.0.7952789264169401", "ai_enabled": "00000000000000000000000000000003.0.7952789264169401", "session_id": "00000000000000000000000000000002.0.03794249926656812", "log_message": "00000000000000000000000000000002.0.03794249926656812", "next_action": "00000000000000000000000000000003.0.7952789264169401", "user_message": "00000000000000000000000000000002.0.03794249926656812", "applied_rules": "00000000000000000000000000000003.0.7952789264169401", "use_knowledge": "00000000000000000000000000000003.0.7952789264169401", "final_response": "00000000000000000000000000000003.0.7952789264169401", "used_knowledge": "00000000000000000000000000000002.0.03794249926656812", "conversation_id": "00000000000000000000000000000003.0.7952789264169401", "decision_reason": "00000000000000000000000000000002.0.03794249926656812", "organization_id": "00000000000000000000000000000002.0.03794249926656812", "branch:to:prepare": "00000000000000000000000000000003.0.7952789264169401", "knowledge_context": "00000000000000000000000000000002.0.03794249926656812", "follow_up_response": "00000000000000000000000000000002.0.03794249926656812", "should_end_session": "00000000000000000000000000000003.0.7952789264169401", "knowledge_folder_id": "00000000000000000000000000000002.0.03794249926656812"}, "updated_channels": ["ai_enabled", "applied_rules", "conversation_id", "final_response", "intent", "messages", "next_action", "rules", "should_end_session", "task_type", "use_knowledge"]}	{"step": 1, "source": "loop", "parents": {}}
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817171109		1f18fbbb-7cce-6a8a-8001-c469f50c56c5	\N	\N	{"v": 4, "id": "1f18fbbb-7cce-6a8a-8001-c469f50c56c5", "ts": "2026-08-04T04:19:43.051327+00:00", "versions_seen": {"prepare": {"branch:to:prepare": "00000000000000000000000000000002.0.31382639625878717"}, "__input__": {}, "__start__": {"__start__": "00000000000000000000000000000001.0.9937992427919257"}}, "channel_values": {"intent": null, "channel": "web_chat", "task_step": "ask_service", "task_type": "reservation_create", "ai_enabled": true, "session_id": "rule_preview_1785817171109", "active_task": "reservation", "log_message": null, "next_action": null, "task_status": null, "user_message": "예약하고싶어요", "use_knowledge": false, "final_response": null, "conversation_id": null, "decision_reason": null, "organization_id": "a55c98f9-74ba-40d8-bc9d-bc3f1c0870da", "follow_up_response": null, "should_end_session": false, "knowledge_folder_id": null}, "channel_versions": {"rules": "00000000000000000000000000000003.0.2244378174841437", "intent": "00000000000000000000000000000003.0.2244378174841437", "channel": "00000000000000000000000000000002.0.31382639625878717", "messages": "00000000000000000000000000000003.0.2244378174841437", "__start__": "00000000000000000000000000000002.0.31382639625878717", "task_step": "00000000000000000000000000000003.0.2244378174841437", "task_type": "00000000000000000000000000000003.0.2244378174841437", "ai_enabled": "00000000000000000000000000000003.0.2244378174841437", "session_id": "00000000000000000000000000000002.0.31382639625878717", "active_task": "00000000000000000000000000000003.0.2244378174841437", "log_message": "00000000000000000000000000000002.0.31382639625878717", "next_action": "00000000000000000000000000000003.0.2244378174841437", "task_result": "00000000000000000000000000000003.0.2244378174841437", "task_status": "00000000000000000000000000000003.0.2244378174841437", "user_message": "00000000000000000000000000000002.0.31382639625878717", "applied_rules": "00000000000000000000000000000003.0.2244378174841437", "use_knowledge": "00000000000000000000000000000003.0.2244378174841437", "final_response": "00000000000000000000000000000003.0.2244378174841437", "used_knowledge": "00000000000000000000000000000002.0.31382639625878717", "conversation_id": "00000000000000000000000000000003.0.2244378174841437", "decision_reason": "00000000000000000000000000000002.0.31382639625878717", "organization_id": "00000000000000000000000000000002.0.31382639625878717", "branch:to:prepare": "00000000000000000000000000000003.0.2244378174841437", "knowledge_context": "00000000000000000000000000000002.0.31382639625878717", "follow_up_response": "00000000000000000000000000000002.0.31382639625878717", "should_end_session": "00000000000000000000000000000003.0.2244378174841437", "knowledge_folder_id": "00000000000000000000000000000002.0.31382639625878717"}, "updated_channels": ["active_task", "ai_enabled", "applied_rules", "conversation_id", "final_response", "intent", "messages", "next_action", "rules", "should_end_session", "task_result", "task_status", "task_step", "task_type", "use_knowledge"]}	{"step": 1, "source": "loop", "parents": {}}
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		1f18fbf2-df23-6842-800a-facd73c4e2c9	1f18fbf2-af47-63bb-8007-bcbb44bef6ef	\N	{"v": 4, "id": "1f18fbf2-df23-6842-800a-facd73c4e2c9", "ts": "2026-08-04T04:44:29.757135+00:00", "versions_seen": {"prepare": {"branch:to:prepare": "00000000000000000000000000000011.0.05355762639814854"}, "__input__": {}, "__start__": {"__start__": "00000000000000000000000000000010.0.5675944940927544"}}, "channel_values": {"intent": null, "channel": "web_chat", "task_step": "ask_service", "task_type": "reservation_create", "ai_enabled": true, "session_id": "web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39", "active_task": "reservation", "log_message": null, "next_action": null, "task_status": null, "user_message": "헤어컷", "use_knowledge": false, "final_response": null, "conversation_id": "23ec54b8-318c-4d2c-b084-6078d67c181e", "decision_reason": null, "organization_id": "a55c98f9-74ba-40d8-bc9d-bc3f1c0870da", "follow_up_response": null, "should_end_session": false, "knowledge_folder_id": null}, "channel_versions": {"rules": "00000000000000000000000000000012.0.5279757818251062", "intent": "00000000000000000000000000000012.0.5279757818251062", "channel": "00000000000000000000000000000011.0.05355762639814854", "messages": "00000000000000000000000000000012.0.5279757818251062", "__start__": "00000000000000000000000000000011.0.05355762639814854", "task_step": "00000000000000000000000000000012.0.5279757818251062", "task_type": "00000000000000000000000000000012.0.5279757818251062", "ai_enabled": "00000000000000000000000000000012.0.5279757818251062", "session_id": "00000000000000000000000000000011.0.05355762639814854", "active_task": "00000000000000000000000000000012.0.5279757818251062", "log_message": "00000000000000000000000000000011.0.05355762639814854", "next_action": "00000000000000000000000000000012.0.5279757818251062", "task_result": "00000000000000000000000000000012.0.5279757818251062", "task_status": "00000000000000000000000000000012.0.5279757818251062", "user_message": "00000000000000000000000000000011.0.05355762639814854", "applied_rules": "00000000000000000000000000000012.0.5279757818251062", "use_knowledge": "00000000000000000000000000000012.0.5279757818251062", "final_response": "00000000000000000000000000000012.0.5279757818251062", "used_knowledge": "00000000000000000000000000000011.0.05355762639814854", "conversation_id": "00000000000000000000000000000012.0.5279757818251062", "decision_reason": "00000000000000000000000000000011.0.05355762639814854", "organization_id": "00000000000000000000000000000011.0.05355762639814854", "branch:to:prepare": "00000000000000000000000000000012.0.5279757818251062", "knowledge_context": "00000000000000000000000000000011.0.05355762639814854", "follow_up_response": "00000000000000000000000000000011.0.05355762639814854", "should_end_session": "00000000000000000000000000000012.0.5279757818251062", "knowledge_folder_id": "00000000000000000000000000000011.0.05355762639814854"}, "updated_channels": ["active_task", "ai_enabled", "applied_rules", "conversation_id", "final_response", "intent", "messages", "next_action", "rules", "should_end_session", "task_result", "task_status", "task_step", "task_type", "use_knowledge"]}	{"step": 10, "source": "loop", "parents": {}}
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		1f18fbf4-3626-6b3e-800d-2723711ec8f7	1f18fbf2-df23-6842-800a-facd73c4e2c9	\N	{"v": 4, "id": "1f18fbf4-3626-6b3e-800d-2723711ec8f7", "ts": "2026-08-04T04:45:05.724595+00:00", "versions_seen": {"prepare": {"branch:to:prepare": "00000000000000000000000000000014.0.7237614987477308"}, "__input__": {}, "__start__": {"__start__": "00000000000000000000000000000013.0.6573659668986287"}}, "channel_values": {"intent": null, "channel": "web_chat", "task_step": "ask_service", "task_type": "reservation_create", "ai_enabled": true, "session_id": "web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39", "active_task": "reservation", "log_message": null, "next_action": null, "task_status": null, "user_message": "예약할래", "use_knowledge": false, "final_response": null, "conversation_id": null, "decision_reason": null, "organization_id": "a55c98f9-74ba-40d8-bc9d-bc3f1c0870da", "follow_up_response": null, "should_end_session": false, "knowledge_folder_id": null}, "channel_versions": {"rules": "00000000000000000000000000000015.0.13771854855949106", "intent": "00000000000000000000000000000015.0.13771854855949106", "channel": "00000000000000000000000000000014.0.7237614987477308", "messages": "00000000000000000000000000000015.0.13771854855949106", "__start__": "00000000000000000000000000000014.0.7237614987477308", "task_step": "00000000000000000000000000000015.0.13771854855949106", "task_type": "00000000000000000000000000000015.0.13771854855949106", "ai_enabled": "00000000000000000000000000000015.0.13771854855949106", "session_id": "00000000000000000000000000000014.0.7237614987477308", "active_task": "00000000000000000000000000000015.0.13771854855949106", "log_message": "00000000000000000000000000000014.0.7237614987477308", "next_action": "00000000000000000000000000000015.0.13771854855949106", "task_result": "00000000000000000000000000000015.0.13771854855949106", "task_status": "00000000000000000000000000000015.0.13771854855949106", "user_message": "00000000000000000000000000000014.0.7237614987477308", "applied_rules": "00000000000000000000000000000015.0.13771854855949106", "use_knowledge": "00000000000000000000000000000015.0.13771854855949106", "final_response": "00000000000000000000000000000015.0.13771854855949106", "used_knowledge": "00000000000000000000000000000014.0.7237614987477308", "conversation_id": "00000000000000000000000000000015.0.13771854855949106", "decision_reason": "00000000000000000000000000000014.0.7237614987477308", "organization_id": "00000000000000000000000000000014.0.7237614987477308", "branch:to:prepare": "00000000000000000000000000000015.0.13771854855949106", "knowledge_context": "00000000000000000000000000000014.0.7237614987477308", "follow_up_response": "00000000000000000000000000000014.0.7237614987477308", "should_end_session": "00000000000000000000000000000015.0.13771854855949106", "knowledge_folder_id": "00000000000000000000000000000014.0.7237614987477308"}, "updated_channels": ["active_task", "ai_enabled", "applied_rules", "conversation_id", "final_response", "intent", "messages", "next_action", "rules", "should_end_session", "task_result", "task_status", "task_step", "task_type", "use_knowledge"]}	{"step": 13, "source": "loop", "parents": {}}
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817115123		1f18fbb9-7a42-61a3-8004-c7e5073f8604	1f18fbb9-3825-6783-8001-f8daa586c2e3	\N	{"v": 4, "id": "1f18fbb9-7a42-61a3-8004-c7e5073f8604", "ts": "2026-08-04T04:18:49.096952+00:00", "versions_seen": {"prepare": {"branch:to:prepare": "00000000000000000000000000000005.0.8423046652669601"}, "__input__": {}, "__start__": {"__start__": "00000000000000000000000000000004.0.5881737964909303"}}, "channel_values": {"intent": null, "channel": "web_chat", "task_step": "ask_service", "task_type": "reservation_create", "ai_enabled": true, "session_id": "rule_preview_1785817115123", "active_task": "reservation", "log_message": null, "next_action": null, "task_status": null, "user_message": "예약하고싶어요", "use_knowledge": false, "final_response": null, "conversation_id": "24d0467f-4a54-4970-9091-7b26f14cf29b", "decision_reason": null, "organization_id": "a55c98f9-74ba-40d8-bc9d-bc3f1c0870da", "follow_up_response": null, "should_end_session": false, "knowledge_folder_id": null}, "channel_versions": {"rules": "00000000000000000000000000000006.0.17482572079205516", "intent": "00000000000000000000000000000006.0.17482572079205516", "channel": "00000000000000000000000000000005.0.8423046652669601", "messages": "00000000000000000000000000000006.0.17482572079205516", "__start__": "00000000000000000000000000000005.0.8423046652669601", "task_step": "00000000000000000000000000000006.0.17482572079205516", "task_type": "00000000000000000000000000000006.0.17482572079205516", "ai_enabled": "00000000000000000000000000000006.0.17482572079205516", "session_id": "00000000000000000000000000000005.0.8423046652669601", "active_task": "00000000000000000000000000000006.0.17482572079205516", "log_message": "00000000000000000000000000000005.0.8423046652669601", "next_action": "00000000000000000000000000000006.0.17482572079205516", "task_result": "00000000000000000000000000000006.0.17482572079205516", "task_status": "00000000000000000000000000000006.0.17482572079205516", "user_message": "00000000000000000000000000000005.0.8423046652669601", "applied_rules": "00000000000000000000000000000006.0.17482572079205516", "use_knowledge": "00000000000000000000000000000006.0.17482572079205516", "final_response": "00000000000000000000000000000006.0.17482572079205516", "used_knowledge": "00000000000000000000000000000005.0.8423046652669601", "conversation_id": "00000000000000000000000000000006.0.17482572079205516", "decision_reason": "00000000000000000000000000000005.0.8423046652669601", "organization_id": "00000000000000000000000000000005.0.8423046652669601", "branch:to:prepare": "00000000000000000000000000000006.0.17482572079205516", "knowledge_context": "00000000000000000000000000000005.0.8423046652669601", "follow_up_response": "00000000000000000000000000000005.0.8423046652669601", "should_end_session": "00000000000000000000000000000006.0.17482572079205516", "knowledge_folder_id": "00000000000000000000000000000005.0.8423046652669601"}, "updated_channels": ["active_task", "ai_enabled", "applied_rules", "conversation_id", "final_response", "intent", "messages", "next_action", "rules", "should_end_session", "task_result", "task_status", "task_step", "task_type", "use_knowledge"]}	{"step": 4, "source": "loop", "parents": {}}
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:rule_preview_1785817171109		1f18fbbc-f7d9-665e-8004-3a71b731a589	1f18fbbb-7cce-6a8a-8001-c469f50c56c5	\N	{"v": 4, "id": "1f18fbbc-f7d9-665e-8004-3a71b731a589", "ts": "2026-08-04T04:20:22.796766+00:00", "versions_seen": {"prepare": {"branch:to:prepare": "00000000000000000000000000000005.0.4690509857226066"}, "__input__": {}, "__start__": {"__start__": "00000000000000000000000000000004.0.15381640671975894"}}, "channel_values": {"intent": null, "channel": "web_chat", "task_step": "ask_service", "task_type": "reservation_create", "ai_enabled": true, "session_id": "rule_preview_1785817171109", "active_task": "reservation", "log_message": null, "next_action": null, "task_status": null, "user_message": "헤어컷", "use_knowledge": false, "final_response": null, "conversation_id": null, "decision_reason": null, "organization_id": "a55c98f9-74ba-40d8-bc9d-bc3f1c0870da", "follow_up_response": null, "should_end_session": false, "knowledge_folder_id": null}, "channel_versions": {"rules": "00000000000000000000000000000006.0.6615004429503055", "intent": "00000000000000000000000000000006.0.6615004429503055", "channel": "00000000000000000000000000000005.0.4690509857226066", "messages": "00000000000000000000000000000006.0.6615004429503055", "__start__": "00000000000000000000000000000005.0.4690509857226066", "task_step": "00000000000000000000000000000006.0.6615004429503055", "task_type": "00000000000000000000000000000006.0.6615004429503055", "ai_enabled": "00000000000000000000000000000006.0.6615004429503055", "session_id": "00000000000000000000000000000005.0.4690509857226066", "active_task": "00000000000000000000000000000006.0.6615004429503055", "log_message": "00000000000000000000000000000005.0.4690509857226066", "next_action": "00000000000000000000000000000006.0.6615004429503055", "task_result": "00000000000000000000000000000006.0.6615004429503055", "task_status": "00000000000000000000000000000006.0.6615004429503055", "user_message": "00000000000000000000000000000005.0.4690509857226066", "applied_rules": "00000000000000000000000000000006.0.6615004429503055", "use_knowledge": "00000000000000000000000000000006.0.6615004429503055", "final_response": "00000000000000000000000000000006.0.6615004429503055", "used_knowledge": "00000000000000000000000000000005.0.4690509857226066", "conversation_id": "00000000000000000000000000000006.0.6615004429503055", "decision_reason": "00000000000000000000000000000005.0.4690509857226066", "organization_id": "00000000000000000000000000000005.0.4690509857226066", "branch:to:prepare": "00000000000000000000000000000006.0.6615004429503055", "knowledge_context": "00000000000000000000000000000005.0.4690509857226066", "follow_up_response": "00000000000000000000000000000005.0.4690509857226066", "should_end_session": "00000000000000000000000000000006.0.6615004429503055", "knowledge_folder_id": "00000000000000000000000000000005.0.4690509857226066"}, "updated_channels": ["active_task", "ai_enabled", "applied_rules", "conversation_id", "final_response", "intent", "messages", "next_action", "rules", "should_end_session", "task_result", "task_status", "task_step", "task_type", "use_knowledge"]}	{"step": 4, "source": "loop", "parents": {}}
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		1f18fbf2-af47-63bb-8007-bcbb44bef6ef	1f18fb77-546f-652d-8004-28b0b3c8d50a	\N	{"v": 4, "id": "1f18fbf2-af47-63bb-8007-bcbb44bef6ef", "ts": "2026-08-04T04:44:24.738708+00:00", "versions_seen": {"prepare": {"branch:to:prepare": "00000000000000000000000000000008.0.9511633829922934"}, "__input__": {}, "__start__": {"__start__": "00000000000000000000000000000007.0.6123398020432315"}}, "channel_values": {"intent": null, "channel": "web_chat", "task_step": "ask_service", "task_type": "reservation_create", "ai_enabled": true, "session_id": "web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39", "active_task": "reservation", "log_message": null, "next_action": null, "task_status": null, "user_message": "예약하고싶어", "use_knowledge": false, "final_response": null, "conversation_id": null, "decision_reason": null, "organization_id": "a55c98f9-74ba-40d8-bc9d-bc3f1c0870da", "follow_up_response": null, "should_end_session": false, "knowledge_folder_id": null}, "channel_versions": {"rules": "00000000000000000000000000000009.0.2690235029228105", "intent": "00000000000000000000000000000009.0.2690235029228105", "channel": "00000000000000000000000000000008.0.9511633829922934", "messages": "00000000000000000000000000000009.0.2690235029228105", "__start__": "00000000000000000000000000000008.0.9511633829922934", "task_step": "00000000000000000000000000000009.0.2690235029228105", "task_type": "00000000000000000000000000000009.0.2690235029228105", "ai_enabled": "00000000000000000000000000000009.0.2690235029228105", "session_id": "00000000000000000000000000000008.0.9511633829922934", "active_task": "00000000000000000000000000000009.0.2690235029228105", "log_message": "00000000000000000000000000000008.0.9511633829922934", "next_action": "00000000000000000000000000000009.0.2690235029228105", "task_result": "00000000000000000000000000000009.0.2690235029228105", "task_status": "00000000000000000000000000000009.0.2690235029228105", "user_message": "00000000000000000000000000000008.0.9511633829922934", "applied_rules": "00000000000000000000000000000009.0.2690235029228105", "use_knowledge": "00000000000000000000000000000009.0.2690235029228105", "final_response": "00000000000000000000000000000009.0.2690235029228105", "used_knowledge": "00000000000000000000000000000008.0.9511633829922934", "conversation_id": "00000000000000000000000000000009.0.2690235029228105", "decision_reason": "00000000000000000000000000000008.0.9511633829922934", "organization_id": "00000000000000000000000000000008.0.9511633829922934", "branch:to:prepare": "00000000000000000000000000000009.0.2690235029228105", "knowledge_context": "00000000000000000000000000000008.0.9511633829922934", "follow_up_response": "00000000000000000000000000000008.0.9511633829922934", "should_end_session": "00000000000000000000000000000009.0.2690235029228105", "knowledge_folder_id": "00000000000000000000000000000008.0.9511633829922934"}, "updated_channels": ["active_task", "ai_enabled", "applied_rules", "conversation_id", "final_response", "intent", "messages", "next_action", "rules", "should_end_session", "task_result", "task_status", "task_step", "task_type", "use_knowledge"]}	{"step": 7, "source": "loop", "parents": {}}
a55c98f9-74ba-40d8-bc9d-bc3f1c0870da:web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39		1f18fbf4-4f16-60d9-8010-d653cfaba6d5	1f18fbf4-3626-6b3e-800d-2723711ec8f7	\N	{"v": 4, "id": "1f18fbf4-4f16-60d9-8010-d653cfaba6d5", "ts": "2026-08-04T04:45:08.339220+00:00", "versions_seen": {"prepare": {"branch:to:prepare": "00000000000000000000000000000017.0.039232078942281756"}, "__input__": {}, "__start__": {"__start__": "00000000000000000000000000000016.0.37513774540196443"}}, "channel_values": {"intent": null, "channel": "web_chat", "task_step": "ask_service", "task_type": "reservation_create", "ai_enabled": true, "session_id": "web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39", "active_task": "reservation", "log_message": null, "next_action": null, "task_status": null, "user_message": "헤어컷", "use_knowledge": false, "final_response": null, "conversation_id": "23ec54b8-318c-4d2c-b084-6078d67c181e", "decision_reason": null, "organization_id": "a55c98f9-74ba-40d8-bc9d-bc3f1c0870da", "follow_up_response": null, "should_end_session": false, "knowledge_folder_id": null}, "channel_versions": {"rules": "00000000000000000000000000000018.0.9782689613373156", "intent": "00000000000000000000000000000018.0.9782689613373156", "channel": "00000000000000000000000000000017.0.039232078942281756", "messages": "00000000000000000000000000000018.0.9782689613373156", "__start__": "00000000000000000000000000000017.0.039232078942281756", "task_step": "00000000000000000000000000000018.0.9782689613373156", "task_type": "00000000000000000000000000000018.0.9782689613373156", "ai_enabled": "00000000000000000000000000000018.0.9782689613373156", "session_id": "00000000000000000000000000000017.0.039232078942281756", "active_task": "00000000000000000000000000000018.0.9782689613373156", "log_message": "00000000000000000000000000000017.0.039232078942281756", "next_action": "00000000000000000000000000000018.0.9782689613373156", "task_result": "00000000000000000000000000000018.0.9782689613373156", "task_status": "00000000000000000000000000000018.0.9782689613373156", "user_message": "00000000000000000000000000000017.0.039232078942281756", "applied_rules": "00000000000000000000000000000018.0.9782689613373156", "use_knowledge": "00000000000000000000000000000018.0.9782689613373156", "final_response": "00000000000000000000000000000018.0.9782689613373156", "used_knowledge": "00000000000000000000000000000017.0.039232078942281756", "conversation_id": "00000000000000000000000000000018.0.9782689613373156", "decision_reason": "00000000000000000000000000000017.0.039232078942281756", "organization_id": "00000000000000000000000000000017.0.039232078942281756", "branch:to:prepare": "00000000000000000000000000000018.0.9782689613373156", "knowledge_context": "00000000000000000000000000000017.0.039232078942281756", "follow_up_response": "00000000000000000000000000000017.0.039232078942281756", "should_end_session": "00000000000000000000000000000018.0.9782689613373156", "knowledge_folder_id": "00000000000000000000000000000017.0.039232078942281756"}, "updated_channels": ["active_task", "ai_enabled", "applied_rules", "conversation_id", "final_response", "intent", "messages", "next_action", "rules", "should_end_session", "task_result", "task_status", "task_step", "task_type", "use_knowledge"]}	{"step": 16, "source": "loop", "parents": {}}
\.


--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.conversations (id, organization_id, session_id, channel, customer_id, customer_name, customer_email, customer_phone, status, assigned_admin_id, last_message, last_message_at, created_at, updated_at, ai_enabled, idle_warned_at, call_started_at, call_ended_at, call_duration_seconds) FROM stdin;
24d0467f-4a54-4970-9091-7b26f14cf29b	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	rule_preview_1785817115123	web_chat	\N	\N	\N	\N	closed	\N	예약을 도와드리려고 하는데, 어떤 서비스를 원하시는지 알려주실 수 있을까요? 예를 들어, 미용, 마사지, 또는 다른 서비스가 있을 수 있어요.	2026-08-04 04:18:49.597051	2026-08-04 04:18:38.547062	2026-08-04 04:22:08.678097	t	2026-08-04 04:21:58.102752	\N	\N	\N
72d45642-d9da-4205-b60a-86ce2637f2e5	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	rule_preview_1785817171109	web_chat	\N	\N	\N	\N	closed	\N	죄송하지만 현재 제공 가능한 서비스 목록을 불러올 수 없습니다. 예약하실 서비스를 좀 더 구체적으로 말씀해 주시겠어요?	2026-08-04 04:20:23.302254	2026-08-04 04:19:39.208879	2026-08-04 04:23:41.230762	t	2026-08-04 04:23:30.69068	\N	\N	\N
23ec54b8-318c-4d2c-b084-6078d67c181e	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39	web_chat	\N	\N	\N	\N	closed	\N	죄송하지만 현재 제공 가능한 서비스 목록을 불러올 수 없습니다. 예약하실 서비스명을 조금 더 자세히 알려주실 수 있나요?	2026-08-04 04:45:08.849638	2026-08-04 03:49:04.495326	2026-08-04 04:45:08.849638	t	2026-08-04 03:52:17.448036	\N	\N	\N
\.


--
-- Data for Name: conversation_messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.conversation_messages (id, organization_id, conversation_id, sender_type, sender_name, message, metadata, created_at) FROM stdin;
16a8bb52-f9d0-4ab3-90be-fb769ceaf8b0	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	23ec54b8-318c-4d2c-b084-6078d67c181e	customer	Customer	안녕하세요	{"channel": "web_chat", "session_id": "web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39", "agent_message": null}	2026-08-04 03:49:04.602448
851bfe85-9929-4903-a47d-aee111a8d348	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	23ec54b8-318c-4d2c-b084-6078d67c181e	ai	Callbee	안녕하세요! 무엇을 도와드릴까요?	{"intent": "general", "applied_rules": ["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"], "used_knowledge": []}	2026-08-04 03:49:04.794169
d40bbe05-4bbd-438c-b5fa-5e79614de15f	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	23ec54b8-318c-4d2c-b084-6078d67c181e	customer	Customer	예약할래요	{"channel": "web_chat", "session_id": "web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39", "agent_message": null}	2026-08-04 03:49:09.604502
a31cd22e-4493-4547-b368-5b421628bb37	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	23ec54b8-318c-4d2c-b084-6078d67c181e	system	\N	아직 거기 계신가요? 잠시 더 기다려도 응답이 없으면 상담이 종료됩니다.	{}	2026-08-04 03:52:13.682161
14235c54-e6a4-4e51-ba81-dcf90f1db77c	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	23ec54b8-318c-4d2c-b084-6078d67c181e	system	\N	응답이 없어 상담이 종료되었습니다. 다시 문의하실 일이 있으면 새로 말씀해 주세요.	{}	2026-08-04 03:52:24.119234
4b72aca5-1405-46c9-aed6-678b70269f37	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	24d0467f-4a54-4970-9091-7b26f14cf29b	customer	Customer	안녕하세요	{"channel": "web_chat", "session_id": "rule_preview_1785817115123", "agent_message": null}	2026-08-04 04:18:38.666577
5cd03e3f-1c29-4060-873e-c4290844a2f2	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	24d0467f-4a54-4970-9091-7b26f14cf29b	ai	Callbee	안녕하세요! 무엇을 도와드릴까요?	{"intent": "general", "applied_rules": ["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"], "used_knowledge": []}	2026-08-04 04:18:39.007457
55e6f8f2-624d-4392-9f15-a75e04552003	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	24d0467f-4a54-4970-9091-7b26f14cf29b	customer	Customer	예약하고싶어요	{"channel": "web_chat", "session_id": "rule_preview_1785817115123", "agent_message": null}	2026-08-04 04:18:45.167894
76b78ac1-02e5-4b91-936d-48e7d1840448	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	24d0467f-4a54-4970-9091-7b26f14cf29b	ai	Callbee	예약을 도와드리려고 하는데, 어떤 서비스를 원하시는지 알려주실 수 있을까요? 예를 들어, 미용, 마사지, 또는 다른 서비스가 있을 수 있어요.	{"task": {"error": null, "trace": [{"error": null, "status": "success", "node_key": "start", "node_type": "function", "node_label": "서비스 목록 조회", "next_behavior": "evaluate_edges", "memory_updates": ["available_services"]}, {"error": null, "status": "success", "node_key": "ask_service", "node_type": "instruction", "node_label": "서비스 선택 질문", "next_behavior": "wait_user", "memory_updates": []}], "status": "waiting_user_input", "flow_id": "871f2fae-39ce-4c57-b6d9-2b14611420c2", "task_session_id": "b5eac060-cb6a-4533-bafc-56109116595e", "current_node_key": "ask_service"}, "intent": "reservation", "applied_rules": ["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"], "used_knowledge": []}	2026-08-04 04:18:45.348754
1904884b-fdb6-4959-a92c-746a7959c911	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	72d45642-d9da-4205-b60a-86ce2637f2e5	customer	Customer	예약하고싶어요	{"channel": "web_chat", "session_id": "rule_preview_1785817171109", "agent_message": null}	2026-08-04 04:19:39.313806
8b55310b-7094-4c26-8c84-2f4fe708ecd4	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	72d45642-d9da-4205-b60a-86ce2637f2e5	ai	Callbee	예약 도와드릴게요! 어떤 서비스를 원하시는지 알려주실 수 있나요? 예를 들어, 헤어컷, 마사지, 네일아트 같은 서비스가 있어요.	{"task": {"error": null, "trace": [{"error": null, "status": "success", "node_key": "start", "node_type": "function", "node_label": "서비스 목록 조회", "next_behavior": "evaluate_edges", "memory_updates": ["available_services"]}, {"error": null, "status": "success", "node_key": "ask_service", "node_type": "instruction", "node_label": "서비스 선택 질문", "next_behavior": "wait_user", "memory_updates": []}], "status": "waiting_user_input", "flow_id": "871f2fae-39ce-4c57-b6d9-2b14611420c2", "task_session_id": "ab9911ec-a2c7-4cdf-9c0f-f79033755cf0", "current_node_key": "ask_service"}, "intent": "reservation", "applied_rules": ["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"], "used_knowledge": []}	2026-08-04 04:19:39.515755
2fb3f3de-2f88-456c-88cb-25fdc2b46efd	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	72d45642-d9da-4205-b60a-86ce2637f2e5	customer	Customer	헤어컷	{"channel": "web_chat", "session_id": "rule_preview_1785817171109", "agent_message": null}	2026-08-04 04:20:18.921938
c11d818d-bd9f-4416-b8d9-d61b488187cf	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	72d45642-d9da-4205-b60a-86ce2637f2e5	ai	Callbee	죄송하지만 현재 제공 가능한 서비스 목록을 불러올 수 없습니다. 예약하실 서비스를 좀 더 구체적으로 말씀해 주시겠어요?	{"task": {"error": null, "trace": [{"error": null, "status": "success", "node_key": "ask_service", "node_type": "instruction", "node_label": "서비스 선택 질문", "next_behavior": "wait_user", "memory_updates": []}], "status": "waiting_user_input", "flow_id": "871f2fae-39ce-4c57-b6d9-2b14611420c2", "task_session_id": "ab9911ec-a2c7-4cdf-9c0f-f79033755cf0", "current_node_key": "ask_service"}, "intent": "reservation", "applied_rules": ["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"], "used_knowledge": []}	2026-08-04 04:20:19.254857
12203520-a138-4f5a-8b81-c6c3320c6e84	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	24d0467f-4a54-4970-9091-7b26f14cf29b	system	\N	아직 거기 계신가요? 잠시 더 기다려도 응답이 없으면 상담이 종료됩니다.	{}	2026-08-04 04:21:54.257364
23bbdc78-eb0d-4ba2-a04e-139e955def0b	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	24d0467f-4a54-4970-9091-7b26f14cf29b	system	\N	응답이 없어 상담이 종료되었습니다. 다시 문의하실 일이 있으면 새로 말씀해 주세요.	{}	2026-08-04 04:22:04.66177
046b2562-4c71-4e80-a712-58253cafcca6	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	72d45642-d9da-4205-b60a-86ce2637f2e5	system	\N	아직 거기 계신가요? 잠시 더 기다려도 응답이 없으면 상담이 종료됩니다.	{}	2026-08-04 04:23:26.82737
4372ef9e-6921-4322-a27b-f06bdb19b6da	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	72d45642-d9da-4205-b60a-86ce2637f2e5	system	\N	응답이 없어 상담이 종료되었습니다. 다시 문의하실 일이 있으면 새로 말씀해 주세요.	{}	2026-08-04 04:23:37.171008
314846da-62c1-4444-afe9-454d12e9ff9d	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	23ec54b8-318c-4d2c-b084-6078d67c181e	customer	Customer	예약하고싶어	{"channel": "web_chat", "session_id": "web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39", "agent_message": null}	2026-08-04 04:44:24.996952
5a525d6c-24b0-4e32-87b3-2f4702e0409a	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	23ec54b8-318c-4d2c-b084-6078d67c181e	ai	Callbee	안녕하세요! 예약을 도와드리려고 하는데요, 어떤 서비스를 원하시는지 알려주실 수 있을까요? 예를 들어, 미용, 마사지, 또는 다른 서비스가 있을 수 있어요.	{"task": {"error": null, "trace": [{"error": null, "status": "success", "node_key": "start", "node_type": "function", "node_label": "서비스 목록 조회", "next_behavior": "evaluate_edges", "memory_updates": ["available_services"]}, {"error": null, "status": "success", "node_key": "ask_service", "node_type": "instruction", "node_label": "서비스 선택 질문", "next_behavior": "wait_user", "memory_updates": []}], "status": "waiting_user_input", "flow_id": "871f2fae-39ce-4c57-b6d9-2b14611420c2", "task_session_id": "fa7984dd-ec51-4e12-92f0-5ecb38777e33", "current_node_key": "ask_service"}, "intent": "reservation", "applied_rules": ["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"], "used_knowledge": []}	2026-08-04 04:44:25.171394
309929ad-8f11-4dec-bc62-099fa648e884	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	23ec54b8-318c-4d2c-b084-6078d67c181e	customer	Customer	헤어컷	{"channel": "web_chat", "session_id": "web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39", "agent_message": null}	2026-08-04 04:44:29.778613
0bef04ed-7dd7-46e7-a17d-5beef5b7f0fc	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	23ec54b8-318c-4d2c-b084-6078d67c181e	ai	Callbee	죄송하지만 현재 제공 가능한 서비스 목록을 불러올 수 없습니다. 예약하실 서비스를 구체적으로 알려주실 수 있나요?	{"task": {"error": null, "trace": [{"error": null, "status": "success", "node_key": "ask_service", "node_type": "instruction", "node_label": "서비스 선택 질문", "next_behavior": "wait_user", "memory_updates": []}], "status": "waiting_user_input", "flow_id": "871f2fae-39ce-4c57-b6d9-2b14611420c2", "task_session_id": "fa7984dd-ec51-4e12-92f0-5ecb38777e33", "current_node_key": "ask_service"}, "intent": "reservation", "applied_rules": ["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"], "used_knowledge": []}	2026-08-04 04:44:30.023833
c3f5245b-8d9a-40cb-b1a3-6ae6e591fdc6	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	23ec54b8-318c-4d2c-b084-6078d67c181e	customer	Customer	예약할래	{"channel": "web_chat", "session_id": "web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39", "agent_message": null}	2026-08-04 04:45:05.804763
bfe32be5-4723-4269-9f17-60d4dda88016	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	23ec54b8-318c-4d2c-b084-6078d67c181e	ai	Callbee	예약을 도와드리고 싶은데, 현재 어떤 서비스를 원하시는지 알려주실 수 있나요? 예를 들어, 미용, 마사지, 또는 다른 서비스가 있을 수 있어요.	{"task": {"error": null, "trace": [{"error": null, "status": "success", "node_key": "ask_service", "node_type": "instruction", "node_label": "서비스 선택 질문", "next_behavior": "wait_user", "memory_updates": []}], "status": "waiting_user_input", "flow_id": "871f2fae-39ce-4c57-b6d9-2b14611420c2", "task_session_id": "fa7984dd-ec51-4e12-92f0-5ecb38777e33", "current_node_key": "ask_service"}, "intent": "reservation", "applied_rules": ["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"], "used_knowledge": []}	2026-08-04 04:45:05.922082
fd4b193e-2629-4544-94cd-ca9629726dfd	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	23ec54b8-318c-4d2c-b084-6078d67c181e	customer	Customer	헤어컷	{"channel": "web_chat", "session_id": "web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39", "agent_message": null}	2026-08-04 04:45:08.369717
04d48cbe-a4c3-452d-8cdb-e7198dffc691	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	23ec54b8-318c-4d2c-b084-6078d67c181e	ai	Callbee	죄송하지만 현재 제공 가능한 서비스 목록을 불러올 수 없습니다. 예약하실 서비스명을 조금 더 자세히 알려주실 수 있나요?	{"task": {"error": null, "trace": [{"error": null, "status": "success", "node_key": "ask_service", "node_type": "instruction", "node_label": "서비스 선택 질문", "next_behavior": "wait_user", "memory_updates": []}], "status": "waiting_user_input", "flow_id": "871f2fae-39ce-4c57-b6d9-2b14611420c2", "task_session_id": "fa7984dd-ec51-4e12-92f0-5ecb38777e33", "current_node_key": "ask_service"}, "intent": "reservation", "applied_rules": ["기본 CX 톤앤매너", "모르면 지어내지 않기", "상담 범위 유지"], "used_knowledge": []}	2026-08-04 04:45:08.604963
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customers (id, organization_id, name, phone, email, memo, created_at, updated_at, is_guest) FROM stdin;
\.


--
-- Data for Name: knowledge_chunks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.knowledge_chunks (id, organization_id, source_id, folder_id, chunk_index, content, embedding, metadata, created_at, keywords) FROM stdin;
\.


--
-- Data for Name: knowledge_folders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.knowledge_folders (id, organization_id, name, description, created_at, updated_at, parent_id, is_active) FROM stdin;
\.


--
-- Data for Name: knowledge_semantic_cache; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.knowledge_semantic_cache (id, organization_id, folder_id, query_embedding, result, created_at) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders (id, organization_id, order_code, customer_name, customer_phone, customer_email, order_status, payment_status, delivery_status, recipient_name, recipient_phone, postal_code, address_line1, address_line2, delivery_memo, courier_name, tracking_number, total_amount, currency, source_channel, memo, shipped_at, delivered_at, cancelled_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products (id, organization_id, name, description, price, duration_minutes, is_active, created_at, updated_at, short_description, category, sku, currency, stock_quantity, main_image_url, image_urls, options, detail_info, source_type, source_ref) FROM stdin;
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_items (id, organization_id, order_id, product_id, product_name, product_sku, quantity, unit_price, total_price, selected_options, created_at) FROM stdin;
\.


--
-- Data for Name: organization_ai_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.organization_ai_settings (id, organization_id, llm_provider, llm_model, decision_model, voice_enabled, voice_mode, voice_stt_model, voice_tts_model, voice_tts_voice, realtime_model, realtime_voice, voice_response_style, monthly_budget_limit_cents, monthly_token_limit, created_at, updated_at, voice_tts_provider, elevenlabs_model, elevenlabs_voice_id, voice_stt_provider, elevenlabs_agent_id) FROM stdin;
93480c8d-db62-4c9c-aa15-4107496b9b49	ad9a7e54-5a57-4ee0-9784-e43d7f0fcdc6	openai	gpt-4.1-mini	\N	t	pipeline	gpt-4o-mini-transcribe	gpt-4o-mini-tts	marin	gpt-realtime-2	marin	friendly_short	\N	\N	2026-08-04 02:20:02.197096+00	2026-08-04 02:20:02.197096+00	openai	eleven_flash_v2_5	\N	openai	\N
3dd3f684-b2ff-4bac-a47d-efd45bcce651	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	openai	gpt-4.1-mini	\N	t	pipeline	gpt-4o-mini-transcribe	gpt-4o-mini-tts	marin	gpt-realtime-2	marin	friendly_short	\N	\N	2026-08-04 03:49:07.661298+00	2026-08-04 03:49:07.661298+00	openai	eleven_flash_v2_5	\N	openai	\N
\.


--
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reservations (id, organization_id, conversation_id, customer_id, service_id, calendar_id, customer_name, customer_phone, customer_email, start_at, end_at, timezone, status, source_channel, memo, created_by, confirmed_at, cancelled_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: reservation_calendar_events; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reservation_calendar_events (id, organization_id, reservation_id, calendar_id, provider, external_event_id, external_event_url, sync_status, error_message, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: reservations_backup_before_domain_v1; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reservations_backup_before_domain_v1 (id, organization_id, customer_id, product_id, customer_name, customer_phone, product_name, scheduled_start_at, scheduled_end_at, status, cancel_reason, cancelled_at, google_calendar_event_id, calendar_sync_status, calendar_sync_error, metadata, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: rules; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rules (id, organization_id, name, instruction, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: service_calendars; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.service_calendars (id, organization_id, service_id, calendar_id, is_default, created_at) FROM stdin;
\.


--
-- Data for Name: task_flows; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.task_flows (id, organization_id, name, description, trigger_intent, trigger_description, trigger_examples, allowed_channels, filters, is_enabled, created_at, updated_at) FROM stdin;
871f2fae-39ce-4c57-b6d9-2b14611420c2	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	예약 생성 플로우	MVP 테스트용 예약 생성 태스크 플로우	reservation_create	고객이 새 예약을 원할 때 실행	["예약하고 싶어요", "방문 예약 잡아주세요", "내일 예약 가능해요?"]	["chat", "voice"]	{}	t	2026-08-04 04:16:55.257784+00	2026-08-04 04:16:55.257784+00
\.


--
-- Data for Name: task_edges; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.task_edges (id, flow_id, source_node_key, target_node_key, edge_type, condition_type, condition_config, is_failure_edge, priority, created_at) FROM stdin;
94590fe1-9a08-491a-94a7-95ac2acd8c7c	871f2fae-39ce-4c57-b6d9-2b14611420c2	start	ask_service	single	always	{}	f	100	2026-08-04 04:16:55.596755+00
63ed6053-a364-4afd-91e0-a349fdac0c29	871f2fae-39ce-4c57-b6d9-2b14611420c2	ask_service	resolve_service_item	single	always	{}	f	100	2026-08-04 04:16:55.596755+00
e586d03a-ad2b-4950-9083-0c4ad00dccf8	871f2fae-39ce-4c57-b6d9-2b14611420c2	ask_new_time	check_availability	single	always	{}	f	100	2026-08-04 04:16:55.596755+00
293b723a-134f-44ae-86e5-3b96d9c1caf7	871f2fae-39ce-4c57-b6d9-2b14611420c2	check_availability	normalize_reservation_info	single	always	{}	f	100	2026-08-04 04:16:55.596755+00
3e89f3ed-5898-402c-ac95-73be6bbd24c7	871f2fae-39ce-4c57-b6d9-2b14611420c2	normalize_reservation_info	create_reservation	single	always	{}	f	100	2026-08-04 04:16:55.596755+00
95e15cf6-92a8-4261-bcd9-eb6636b3e3d1	871f2fae-39ce-4c57-b6d9-2b14611420c2	create_reservation	complete	single	always	{"expression": "memory.reservation_result.ok == true"}	f	100	2026-08-04 04:16:55.596755+00
301d5186-1557-4785-9585-a78707ab18e0	871f2fae-39ce-4c57-b6d9-2b14611420c2	create_reservation	ask_new_time	fallback	fallback	{"fallback": true}	t	200	2026-08-04 04:16:55.596755+00
65e4de60-f811-4551-ae1c-c5812fcb2398	871f2fae-39ce-4c57-b6d9-2b14611420c2	ask_new_time	fail_end	fallback	fallback	{"fallback": true}	t	200	2026-08-04 04:16:55.596755+00
57b0c820-302b-441d-8b51-f40a7bafa04b	871f2fae-39ce-4c57-b6d9-2b14611420c2	resolve_service_item	ask_reservation_details	single	always	{}	f	100	2026-08-04 04:16:55.596755+00
161e560d-ec3c-49af-9c16-428cec8dd9d7	871f2fae-39ce-4c57-b6d9-2b14611420c2	ask_reservation_details	check_availability	single	always	{"expression": "memory.customer_name != null && memory.customer_name != \\"\\" && memory.reservation_date != null && memory.reservation_time != null && memory.customer_phone != null"}	f	100	2026-08-04 04:16:55.596755+00
f8e21a76-5fc3-464e-9a9a-5e2f6d3f176c	871f2fae-39ce-4c57-b6d9-2b14611420c2	ask_reservation_details	ask_reservation_details	fallback	fallback	{"fallback": true, "expression": "memory.customer_name != null && memory.customer_name != \\"\\" && memory.reservation_date != null && memory.reservation_time != null && memory.customer_phone != null"}	t	200	2026-08-04 04:16:55.596755+00
\.


--
-- Data for Name: task_nodes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.task_nodes (id, flow_id, node_key, node_type, label, config, code, position_x, position_y, timeout_seconds, retry_limit, created_at, updated_at) FROM stdin;
b9d8ca76-c1c3-458e-ae6f-4c63fda48ec1	871f2fae-39ce-4c57-b6d9-2b14611420c2	complete	message	예약 요청 완료	{"message": "{{memory.customer_name}}님, 예약 요청이 접수되었습니다. 예약일은 {{memory.reservation_date}} {{memory.reservation_time}}입니다. 담당자가 확인 후 안내드리겠습니다.", "next_step_mode": "end"}	\N	3080	640	10	0	2026-08-04 04:16:55.386475+00	2026-08-04 04:16:55.386475+00
331e55b3-09cf-4ce8-8a21-44d8b35c43df	871f2fae-39ce-4c57-b6d9-2b14611420c2	create_reservation	function	예약 요청 생성	{"params": {"date": "{{memory.normalized_date}}", "time": "{{memory.normalized_time}}", "customer_name": "{{memory.customer_name}}", "customer_phone": "{{memory.customer_phone}}", "source_channel": "web_chat", "service_item_id": "{{memory.service_item_id}}"}, "save_as": "reservation_result", "function_name": "reservation.create_reservation", "next_step_mode": "branch", "branch_node_key": "complete", "branch_condition": "memory.reservation_result.ok == true", "fallback_node_key": "ask_new_time"}	\N	2680	640	10	0	2026-08-04 04:16:55.386475+00	2026-08-04 04:16:55.386475+00
98483280-3013-46b6-ab78-0662375c946a	871f2fae-39ce-4c57-b6d9-2b14611420c2	check_availability	function	예약 가능 여부 확인	{"params": {"date": "{{memory.reservation_date}}", "organization_id": "{{memory.organization_id}}", "service_item_id": "{{memory.service_item_id}}"}, "save_as": "availability_result", "function_name": "reservation.get_available_slots", "next_node_key": "normalize_reservation_info", "next_step_mode": "single"}	\N	1800	640	10	0	2026-08-04 04:16:55.386475+00	2026-08-04 04:16:55.386475+00
70513cc6-9b95-4fa0-a820-8fb9cbe3c435	871f2fae-39ce-4c57-b6d9-2b14611420c2	normalize_reservation_info	instruction	예약 정보 정규화	{"instruction": "현재 memory에서 예약 날짜, 예약 시간을 정규화해라. reservation_date가 YYYY-MM-DD 형식이면 그대로 normalized_date에 넣어라. reservation_time은 24시간 HH:MM 형식으로 normalized_time에 넣어라. 확실하지 않은 값은 null로 둬라.", "next_node_key": "create_reservation", "next_step_mode": "single", "save_to_memory": true}	\N	2240	960	10	0	2026-08-04 04:16:55.386475+00	2026-08-04 04:16:55.386475+00
d38969e6-8b17-42d7-82c8-4740e9c46e1f	871f2fae-39ce-4c57-b6d9-2b14611420c2	fail_end	message	예약 실패 종료	{"message": "예약 요청 처리 중 문제가 발생했습니다. 담당자 확인이 필요합니다.", "next_step_mode": "end"}	\N	2680	960	10	0	2026-08-04 04:16:55.386475+00	2026-08-04 04:16:55.386475+00
93cd8b01-d7ea-4ca6-a86a-f17f3193b864	871f2fae-39ce-4c57-b6d9-2b14611420c2	start	function	서비스 목록 조회	{"params": {}, "save_as": "available_services", "function_name": "reservation.list_services", "next_node_key": "ask_service", "next_step_mode": "single"}	\N	520	280	10	0	2026-08-04 04:16:55.386475+00	2026-08-04 04:16:55.386475+00
79bbcc9b-078b-4034-b029-2b13859cdf3a	871f2fae-39ce-4c57-b6d9-2b14611420c2	ask_new_time	instruction	예약 충돌 - 새 시간 질문	{"instruction": "[역할]\\n예약 진행 중 문제가 발생했다. 실패 원인을 파악하고 고객에게 자연스럽게 안내 후 다시 묻는 에이전트다. 응답은 2~3문장 이내로 짧게 한다.\\n\\n[실패 원인 확인]\\n- <promptdata type=\\"read-variable\\" subtype=\\"text\\" identifier=\\"availability_result.is_available\\"></promptdata>가 false이거나 <promptdata type=\\"read-variable\\" subtype=\\"text\\" identifier=\\"availability_result.slot_count\\"></promptdata>가 0이면: 해당 날짜에는 예약 가능한 시간이 없다고만 안내하고 다른 날짜를 물어본다. 이때 \\"30일 이내\\" 같은 전체 예약 가능 기간 안내는 절대 함께 언급하지 않는다 — 특정 날짜가 불가능하다는 사실과 전체 접수 가능 기간은 서로 다른 정보이며 같이 말하면 방금 불가하다고 한 날짜가 가능한 것처럼 들려 고객이 혼란스러워한다.\\n- 가능한 시간 목록(<promptdata type=\\"read-variable\\" subtype=\\"json\\" identifier=\\"availability_result.slots\\"></promptdata>)이 있으면, 슬롯을 하나씩 나열하지 말고 연속된 구간을 \\"O시부터 O시까지\\" 식으로 묶어서 최대 1~2개 구간만 짧게 안내한다.\\n- <promptdata type=\\"read-variable\\" subtype=\\"text\\" identifier=\\"reservation_result.error_code\\"></promptdata>를 확인한다.\\n- \\"reservation_conflict\\"이면: 해당 날짜/시간에 이미 예약이 있다는 뜻이다. 고객에게 \\"죄송합니다, 해당 날짜/시간은 이미 예약이 있어 진행할 수 없습니다. 다른 시간이나 날짜를 알려주세요.\\"라고 안내한다.\\n- \\"missing_required_fields\\"이면: 예약에 필요한 정보(예: 연락처)가 빠진 것이다. <promptdata type=\\"read-variable\\" subtype=\\"text\\" identifier=\\"reservation_result.missing_keys\\"></promptdata>를 보고, 빠진 항목을 자연스러운 말로 바꿔서 다시 질문한다(customer_phone이 빠졌으면 \\"예약 진행을 위해 연락 가능한 번호를 알려주세요.\\" 등).\\n- 그 외면 \\"예약 처리 중 문제가 발생했습니다. 다시 시도해주세요.\\"라고 안내한다.\\n\\n[충돌로 인한 재질문일 때]\\n- 직전 값은 <promptdata type=\\"read-variable\\" subtype=\\"text\\" identifier=\\"reservation_date\\"></promptdata>, <promptdata type=\\"read-variable\\" subtype=\\"text\\" identifier=\\"reservation_time\\"></promptdata>이다.\\n- 고객이 시간만 새로 말하면 날짜는 기존 값을 그대로 유지하고 <promptdata type=\\"update-variable\\" subtype=\\"text\\" identifier=\\"reservation_time\\"></promptdata>만 새 값으로 바꾼다.\\n- 고객이 날짜만 새로 말하면 시간은 기존 값을 그대로 유지하고 <promptdata type=\\"update-variable\\" subtype=\\"text\\" identifier=\\"reservation_date\\"></promptdata>만 새 값으로 바꾼다.\\n- 고객이 직전과 똑같은 날짜+시간을 다시 말하면 같은 조합은 받아들이지 않고 다시 질문한다.\\n\\n[정보 누락으로 인한 재질문일 때]\\n- 고객이 답한 연락처는 숫자와 하이픈만 남기고 정리해서 <promptdata type=\\"update-variable\\" subtype=\\"text\\" identifier=\\"customer_phone\\"></promptdata>에 저장한다.\\n\\n[종료 조건]\\n- 충돌이었다면 새 (reservation_date, reservation_time) 조합이 직전과 달라지면 종료한다.\\n- 정보 누락이었다면 빠졌던 값이 채워지면 종료한다.\\n\\n[예외 사항]\\n- \\"내일\\", \\"모레\\"처럼 상대적인 표현은 현재 날짜 기준 절대 날짜(YYYY-MM-DD)로, \\"오후 3시\\"같은 표현은 24시간 HH:MM 형식으로 변환해서 저장한다.", "next_step_mode": "branch", "save_to_memory": true, "branch_node_key": "check_availability", "branch_condition": "", "fallback_node_key": "fail_end"}	\N	2240	640	10	0	2026-08-04 04:16:55.386475+00	2026-08-04 04:16:55.386475+00
42b46fc5-3935-42f2-989b-9832a117caf2	871f2fae-39ce-4c57-b6d9-2b14611420c2	ask_service	instruction	서비스 선택 질문	{"instruction": "[역할]\\n고객이 예약하려는 서비스명을 파악한다.\\n\\n[담당 슬롯]\\n- 이 노드의 메인 슬롯은 <promptdata type=\\"update-variable\\" subtype=\\"text\\" identifier=\\"service_item_text\\"></promptdata>다.\\n\\n[대화 흐름]\\n- memory에 <promptdata type=\\"update-variable\\" subtype=\\"text\\" identifier=\\"service_item_text\\"></promptdata>가 이미 있으면 즉시 종료한다(message는 null).\\n- 고객의 현재 메시지 또는 이전 대화 내용에서 서비스명을 파악할 수 있으면 service_item_text에 저장하고 종료한다.\\n- 파악할 수 없으면 <promptdata type=\\"read-variable\\" subtype=\\"json\\" identifier=\\"available_services\\"></promptdata>의 서비스 목록을 보며, 각 서비스를 짧게 소개하는 방식으로 안내한다. 매번 다른 표현을 쓰고 자연스러운 대화체로 말한다.\\n\\n[종료 조건]\\n- service_item_text가 확인되면 종료한다.", "next_node_key": "resolve_service_item", "next_step_mode": "single"}	\N	960	280	10	0	2026-08-04 04:16:55.386475+00	2026-08-04 04:16:55.386475+00
3cdd142f-b6b2-4698-8588-47c0051c93d8	871f2fae-39ce-4c57-b6d9-2b14611420c2	resolve_service_item	function	서비스명 해석	{"params": {"organization_id": "a55c98f9-74ba-40d8-bc9d-bc3f1c0870da", "service_item_text": "{{memory.service_item_text}}"}, "save_as": "service_item_resolve_result", "function_name": "reservation.resolve_service_item", "next_node_key": "ask_reservation_details", "next_step_mode": "single", "memory_mappings": {"service_item_id": "service_item_id", "service_item_name": "service_item_name"}}	\N	1360	280	10	0	2026-08-04 04:16:55.386475+00	2026-08-04 04:16:55.386475+00
16f1e6e6-298d-4355-9997-31eed70bcfdb	871f2fae-39ce-4c57-b6d9-2b14611420c2	ask_reservation_details	instruction	예약 정보 수집	{"instruction": "[역할]\\n예약 접수에 필요한 고객 정보를 수집한다. Current Memory에 이미 있는 값은 절대 다시 묻지 않는다. 응답은 짧게, 한 번에 한 단계씩만 진행한다.\\n\\n[담당 슬롯 및 질문 순서]\\n1. <promptdata type=\\"update-variable\\" subtype=\\"text\\" identifier=\\"reservation_date\\"></promptdata> (예약 날짜, YYYY-MM-DD), <promptdata type=\\"update-variable\\" subtype=\\"text\\" identifier=\\"reservation_time\\"></promptdata> (예약 시간, HH:MM 24시간) — 함께 질문\\n2. <promptdata type=\\"update-variable\\" subtype=\\"text\\" identifier=\\"customer_name\\"></promptdata> (성함)\\n3. <promptdata type=\\"update-variable\\" subtype=\\"text\\" identifier=\\"customer_phone\\"></promptdata> (연락처)\\n\\n[대화 흐름]\\n- memory에 이번에 필요한 슬롯이 모두 있으면 다시 묻지 않고 즉시 종료한다(message는 null).\\n- 위 순서대로, 아직 비어 있는 첫 단계의 슬롯만 질문한다. 예: 날짜/시간이 비어 있으면 그것만 묻고, 채워지면 다음 메시지에서 성함을 묻는 식으로 한 번에 한 단계만 진행한다. 여러 단계를 한 메시지에 몰아서 묻지 않는다.\\n- 다만 고객이 한 메시지에 여러 정보를 스스로 말하면 전부 추출해서 저장한다(먼저 다 물어보라는 뜻이 아니라, 고객이 알아서 여러 개를 말했을 때만 놓치지 않고 받으라는 뜻).\\n- 이미 memory에 있는 값은 덮어쓰지 않는다.\\n- 이번 질문에 대한 답으로 값 하나만 짧게 오더라도(예: 이름만, 날짜만) 그 형식 자체는 모호한 게 아니다 — 값이 무엇인지 해석할 수 있으면 memory_updates에 반드시 저장한다. 그 값을 \\"~맞으신가요?\\" 처럼 자연스럽게 재확인하는 message를 같이 보내는 것은 괜찮지만, 재확인 질문을 한다고 해서 저장을 건너뛰거나 다음 턴(고객이 \\"네\\"라고만 답한 턴)까지 저장을 미루지 않는다 — 값을 받은 바로 그 턴에 저장한다. 가리키는 슬롯 자체가 불명확할 때만(예: 숫자만 와서 날짜인지 다른 정보인지 알 수 없을 때) 모호하다고 보고 저장 없이 되묻는다.\\n\\n[날짜+시간 동시 입력]\\n- \\"7월2일 14시\\", \\"7월 2일 14시요\\", \\"내일 오후 3시\\"처럼 한 메시지에 날짜와 시간이 함께 있으면 reservation_date와 reservation_time을 memory_updates에 동시에 모두 넣는다.\\n- 날짜만 저장하고 시간을 빠뜨리지 않는다. reservation_time이 이미 채워졌으면 시간을 다시 묻지 않는다.\\n\\n[종료 조건]\\n- customer_name, reservation_date, reservation_time, customer_phone이 모두 확인되면 종료한다.\\n\\n[예외 사항]\\n- \\"내일\\", \\"모레\\"처럼 상대적인 날짜 표현은 현재 날짜 기준 YYYY-MM-DD로 변환해서 저장한다.\\n- \\"오후 3시\\", \\"14시\\", \\"저녁 7시반\\"처럼 표현된 시간은 24시간 HH:MM 형식으로 변환해서 저장한다.\\n- 연락처는 숫자와 하이픈만 남기고 정리해서 저장한다(예: \\"010-1234-5678\\").\\n- 답변이 모호하면 값을 추측하지 말고 다시 질문한다.", "next_step_mode": "branch", "save_to_memory": true, "branch_node_key": "check_availability", "branch_condition": "memory.customer_name != null && memory.customer_name != \\"\\" && memory.reservation_date != null && memory.reservation_time != null && memory.customer_phone != null", "fallback_node_key": "ask_reservation_details"}	\N	1360	800	10	0	2026-08-04 04:16:55.386475+00	2026-08-04 04:16:55.386475+00
\.


--
-- Data for Name: task_sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.task_sessions (id, organization_id, session_id, flow_id, current_node_key, waiting_node_key, variables, status, approval_status, last_error, expires_at, created_at, updated_at) FROM stdin;
b5eac060-cb6a-4533-bafc-56109116595e	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	rule_preview_1785817115123	871f2fae-39ce-4c57-b6d9-2b14611420c2	ask_service	ask_service	{"available_services": {"ok": false, "count": 0, "message": "{'message': \\"Could not find the table 'public.service_items' in the schema cache\\", 'code': 'PGRST205', 'hint': None, 'details': None}", "services": [], "error_code": "unknown_error"}}	waiting_user_input	\N	\N	\N	2026-08-04 04:18:42.802684+00	2026-08-04 04:18:45.161751+00
ab9911ec-a2c7-4cdf-9c0f-f79033755cf0	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	rule_preview_1785817171109	871f2fae-39ce-4c57-b6d9-2b14611420c2	ask_service	ask_service	{"available_services": {"ok": false, "count": 0, "message": "{'message': \\"Could not find the table 'public.service_items' in the schema cache\\", 'code': 'PGRST205', 'hint': None, 'details': None}", "services": [], "error_code": "unknown_error"}}	waiting_user_input	\N	\N	\N	2026-08-04 04:19:37.181858+00	2026-08-04 04:20:18.854455+00
fa7984dd-ec51-4e12-92f0-5ecb38777e33	a55c98f9-74ba-40d8-bc9d-bc3f1c0870da	web_call_c62570e2-0f8a-4a27-8c0f-5cbafa6b8c39	871f2fae-39ce-4c57-b6d9-2b14611420c2	ask_service	ask_service	{"available_services": {"ok": false, "count": 0, "message": "{'message': \\"Could not find the table 'public.service_items' in the schema cache\\", 'code': 'PGRST205', 'hint': None, 'details': None}", "services": [], "error_code": "unknown_error"}}	waiting_user_input	\N	\N	\N	2026-08-04 04:44:22.064993+00	2026-08-04 04:45:08.349712+00
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-08-04 01:31:47
20211116045059	2026-08-04 01:31:47
20211116050929	2026-08-04 01:31:47
20211116051442	2026-08-04 01:31:47
20211116212300	2026-08-04 01:31:47
20211116213355	2026-08-04 01:31:47
20211116213934	2026-08-04 01:31:47
20211116214523	2026-08-04 01:31:47
20211122062447	2026-08-04 01:31:47
20211124070109	2026-08-04 01:31:47
20211202204204	2026-08-04 01:31:47
20211202204605	2026-08-04 01:31:47
20211210212804	2026-08-04 01:31:47
20211228014915	2026-08-04 01:31:47
20220107221237	2026-08-04 01:31:47
20220228202821	2026-08-04 01:31:47
20220312004840	2026-08-04 01:31:47
20220603231003	2026-08-04 01:31:47
20220603232444	2026-08-04 01:31:47
20220615214548	2026-08-04 01:31:47
20220712093339	2026-08-04 01:31:47
20220908172859	2026-08-04 01:31:47
20220916233421	2026-08-04 01:31:47
20230119133233	2026-08-04 01:31:47
20230128025114	2026-08-04 01:31:47
20230128025212	2026-08-04 01:31:47
20230227211149	2026-08-04 01:31:47
20230228184745	2026-08-04 01:31:47
20230308225145	2026-08-04 01:31:47
20230328144023	2026-08-04 01:31:47
20231018144023	2026-08-04 01:31:47
20231204144023	2026-08-04 01:31:47
20231204144024	2026-08-04 01:31:47
20231204144025	2026-08-04 01:31:47
20240108234812	2026-08-04 01:31:47
20240109165339	2026-08-04 01:31:47
20240227174441	2026-08-04 01:31:47
20240311171622	2026-08-04 01:31:47
20240321100241	2026-08-04 01:31:47
20240401105812	2026-08-04 01:31:47
20240418121054	2026-08-04 01:31:47
20240523004032	2026-08-04 01:31:47
20240618124746	2026-08-04 01:31:47
20240801235015	2026-08-04 01:31:47
20240805133720	2026-08-04 01:31:47
20240827160934	2026-08-04 01:31:47
20240919163303	2026-08-04 01:31:47
20240919163305	2026-08-04 01:31:47
20241019105805	2026-08-04 01:31:47
20241030150047	2026-08-04 01:31:47
20241108114728	2026-08-04 01:31:47
20241121104152	2026-08-04 01:31:47
20241130184212	2026-08-04 01:31:47
20241220035512	2026-08-04 01:31:47
20241220123912	2026-08-04 01:31:47
20241224161212	2026-08-04 01:31:47
20250107150512	2026-08-04 01:31:47
20250110162412	2026-08-04 01:31:47
20250123174212	2026-08-04 01:31:47
20250128220012	2026-08-04 01:31:47
20250506224012	2026-08-04 01:31:47
20250523164012	2026-08-04 01:31:47
20250714121412	2026-08-04 01:31:47
20250905041441	2026-08-04 01:31:47
20251103001201	2026-08-04 01:31:47
20251120212548	2026-08-04 01:31:47
20251120215549	2026-08-04 01:31:47
20260218120000	2026-08-04 01:31:47
20260326120000	2026-08-04 01:31:47
20260514120000	2026-08-04 01:31:47
20260527120000	2026-08-04 01:31:47
20260528120000	2026-08-04 01:31:47
20260603120000	2026-08-04 01:31:47
20260605120000	2026-08-04 01:31:47
20260606110000	2026-08-04 01:31:47
20260616120000	2026-08-04 01:31:47
20260624120000	2026-08-04 01:31:47
20260626120000	2026-08-04 01:31:47
20260706120000	2026-08-04 01:31:47
20260707120000	2026-08-04 01:31:47
20260709120000	2026-08-04 01:31:47
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter, selected_columns) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
knowledge-originals	knowledge-originals	\N	2026-08-04 02:20:01.98739+00	2026-08-04 02:20:01.98739+00	f	f	20971520	{application/pdf,text/plain,text/markdown,text/csv,application/csv,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet}	\N	STANDARD
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-08-03 17:46:20.130198
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-08-03 17:46:20.183956
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2026-08-03 17:46:20.190574
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-08-03 17:46:20.230646
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-08-03 17:46:20.247896
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-08-03 17:46:20.254905
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2026-08-03 17:46:20.264215
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-08-03 17:46:20.271403
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-08-03 17:46:20.278082
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2026-08-03 17:46:20.285248
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2026-08-03 17:46:20.292101
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-08-03 17:46:20.300724
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-08-03 17:46:20.308473
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-08-03 17:46:20.315371
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-08-03 17:46:20.322594
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-08-03 17:46:20.367832
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-08-03 17:46:20.375496
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-08-03 17:46:20.382346
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-08-03 17:46:20.389007
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-08-03 17:46:20.398126
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-08-03 17:46:20.40645
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-08-03 17:46:20.41645
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-08-03 17:46:20.435819
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-08-03 17:46:20.44981
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-08-03 17:46:20.457051
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-08-03 17:46:20.464614
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2026-08-03 17:46:20.471665
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2026-08-03 17:46:20.478089
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2026-08-03 17:46:20.485027
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2026-08-03 17:46:20.491704
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2026-08-03 17:46:20.498195
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2026-08-03 17:46:20.505017
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2026-08-03 17:46:20.5115
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2026-08-03 17:46:20.517947
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2026-08-03 17:46:20.524446
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2026-08-03 17:46:20.530951
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2026-08-03 17:46:20.537403
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-08-03 17:46:20.543854
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2026-08-03 17:46:20.551702
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2026-08-03 17:46:20.56736
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2026-08-03 17:46:20.574088
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2026-08-03 17:46:20.581019
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2026-08-03 17:46:20.587787
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2026-08-03 17:46:20.594263
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-08-03 17:46:20.600844
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-08-03 17:46:20.611795
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-08-03 17:46:20.634683
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-08-03 17:46:20.644886
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2026-08-03 17:46:20.651563
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-08-03 17:46:20.698399
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-08-03 17:46:20.707685
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-08-03 17:46:21.739601
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-08-03 17:46:21.742458
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-08-03 17:46:21.755471
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-08-03 17:46:21.759472
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-08-03 17:46:21.761878
56	fix-optimized-search-function	b823ed1e418101032fa01374edc9a436e54e3ed4	2026-08-03 17:46:21.769683
57	s3-multipart-uploads-metadata	f127886e00d1b374fadbc7c6b31e09336aad5287	2026-08-03 17:46:21.777949
58	operation-ergonomics	00ca5d483b3fe0d522133d9002ccc5df98365120	2026-08-03 17:46:21.784755
59	drop-unused-functions	38456f13e39691c2bbb4b5151d0d1cdbabd4a8c4	2026-08-03 17:46:21.792151
60	optimize-existing-functions-again	db35e1c91a9201e59f4fef8d972c2f277d68b157	2026-08-03 17:46:21.799325
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata, metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: -
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: -
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 2, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: -
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

\unrestrict 9XW4g1SAsXQvnxxyxawaC2VDcFl56c0JJBC4tg0leZXB0bkKbj4sbwWj3LcJhPX

