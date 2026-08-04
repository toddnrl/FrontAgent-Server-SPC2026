--
-- PostgreSQL database dump
--

\restrict aosvwpje3q8n5KxvlCiERZkgcpoBnVoVx0MDHjvZ2F75Xb0ducXFT9XtYWpico1

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

SET default_tablespace = '';

SET default_table_access_method = heap;

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
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: organization_members_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX organization_members_organization_id_idx ON public.organization_members USING btree (organization_id);


--
-- Name: organization_members_user_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX organization_members_user_id_idx ON public.organization_members USING btree (user_id);


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
-- Name: users users_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: organization_members organization_members_select_own; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY organization_members_select_own ON public.organization_members FOR SELECT USING ((auth.uid() = user_id));


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

\unrestrict aosvwpje3q8n5KxvlCiERZkgcpoBnVoVx0MDHjvZ2F75Xb0ducXFT9XtYWpico1

