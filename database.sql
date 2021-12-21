--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: answer; Type: TABLE; Schema: public; Owner: hoffmann
--

CREATE TABLE public.answer (
    id integer NOT NULL,
    thread_id integer,
    creator_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_DATE NOT NULL,
    modified_at timestamp without time zone,
    text text NOT NULL,
    score integer DEFAULT 0
);


ALTER TABLE public.answer OWNER TO hoffmann;

--
-- Name: answer_id_seq; Type: SEQUENCE; Schema: public; Owner: hoffmann
--

CREATE SEQUENCE public.answer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answer_id_seq OWNER TO hoffmann;

--
-- Name: answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hoffmann
--

ALTER SEQUENCE public.answer_id_seq OWNED BY public.answer.id;


--
-- Name: category; Type: TABLE; Schema: public; Owner: hoffmann
--

CREATE TABLE public.category (
    id integer NOT NULL,
    text text NOT NULL
);


ALTER TABLE public.category OWNER TO hoffmann;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: hoffmann
--

CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_id_seq OWNER TO hoffmann;

--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hoffmann
--

ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;


--
-- Name: comment; Type: TABLE; Schema: public; Owner: hoffmann
--

CREATE TABLE public.comment (
    id integer NOT NULL,
    answer_id integer,
    creator_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_DATE NOT NULL,
    modified_at timestamp without time zone,
    text text NOT NULL
);


ALTER TABLE public.comment OWNER TO hoffmann;

--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: hoffmann
--

CREATE SEQUENCE public.comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_id_seq OWNER TO hoffmann;

--
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hoffmann
--

ALTER SEQUENCE public.comment_id_seq OWNED BY public.comment.id;


--
-- Name: creator; Type: TABLE; Schema: public; Owner: hoffmann
--

CREATE TABLE public.creator (
    id integer NOT NULL,
    username text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    is_admin boolean DEFAULT false NOT NULL,
    score numeric DEFAULT 0 NOT NULL
);


ALTER TABLE public.creator OWNER TO hoffmann;

--
-- Name: creator_id_seq; Type: SEQUENCE; Schema: public; Owner: hoffmann
--

CREATE SEQUENCE public.creator_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.creator_id_seq OWNER TO hoffmann;

--
-- Name: creator_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hoffmann
--

ALTER SEQUENCE public.creator_id_seq OWNED BY public.creator.id;


--
-- Name: tag; Type: TABLE; Schema: public; Owner: hoffmann
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    tag text NOT NULL
);


ALTER TABLE public.tag OWNER TO hoffmann;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: hoffmann
--

CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_id_seq OWNER TO hoffmann;

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hoffmann
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- Name: thread; Type: TABLE; Schema: public; Owner: hoffmann
--

CREATE TABLE public.thread (
    id integer NOT NULL,
    creator_id integer,
    title text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_DATE NOT NULL,
    modified_at timestamp without time zone,
    text text NOT NULL
);


ALTER TABLE public.thread OWNER TO hoffmann;

--
-- Name: thread_category; Type: TABLE; Schema: public; Owner: javaee_forum_admin
--

CREATE TABLE public.thread_category (
    thread_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.thread_category OWNER TO javaee_forum_admin;

--
-- Name: thread_id_seq; Type: SEQUENCE; Schema: public; Owner: hoffmann
--

CREATE SEQUENCE public.thread_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.thread_id_seq OWNER TO hoffmann;

--
-- Name: thread_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hoffmann
--

ALTER SEQUENCE public.thread_id_seq OWNED BY public.thread.id;


--
-- Name: thread_tag; Type: TABLE; Schema: public; Owner: hoffmann
--

CREATE TABLE public.thread_tag (
    thread_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.thread_tag OWNER TO hoffmann;

--
-- Name: answer id; Type: DEFAULT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.answer ALTER COLUMN id SET DEFAULT nextval('public.answer_id_seq'::regclass);


--
-- Name: category id; Type: DEFAULT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


--
-- Name: comment id; Type: DEFAULT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.comment ALTER COLUMN id SET DEFAULT nextval('public.comment_id_seq'::regclass);


--
-- Name: creator id; Type: DEFAULT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.creator ALTER COLUMN id SET DEFAULT nextval('public.creator_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Name: thread id; Type: DEFAULT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.thread ALTER COLUMN id SET DEFAULT nextval('public.thread_id_seq'::regclass);


--
-- Data for Name: answer; Type: TABLE DATA; Schema: public; Owner: hoffmann
--

COPY public.answer (id, thread_id, creator_id, created_at, modified_at, text, score) FROM stdin;
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: hoffmann
--

COPY public.category (id, text) FROM stdin;
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: hoffmann
--

COPY public.comment (id, answer_id, creator_id, created_at, modified_at, text) FROM stdin;
\.


--
-- Data for Name: creator; Type: TABLE DATA; Schema: public; Owner: hoffmann
--

COPY public.creator (id, username, email, password, is_admin, score) FROM stdin;
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: hoffmann
--

COPY public.tag (id, tag) FROM stdin;
\.


--
-- Data for Name: thread; Type: TABLE DATA; Schema: public; Owner: hoffmann
--

COPY public.thread (id, creator_id, title, created_at, modified_at, text) FROM stdin;
\.


--
-- Data for Name: thread_category; Type: TABLE DATA; Schema: public; Owner: javaee_forum_admin
--

COPY public.thread_category (thread_id, category_id) FROM stdin;
\.


--
-- Data for Name: thread_tag; Type: TABLE DATA; Schema: public; Owner: hoffmann
--

COPY public.thread_tag (thread_id, tag_id) FROM stdin;
\.


--
-- Name: answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hoffmann
--

SELECT pg_catalog.setval('public.answer_id_seq', 11, true);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hoffmann
--

SELECT pg_catalog.setval('public.category_id_seq', 20, true);


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hoffmann
--

SELECT pg_catalog.setval('public.comment_id_seq', 8, true);


--
-- Name: creator_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hoffmann
--

SELECT pg_catalog.setval('public.creator_id_seq', 6, true);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hoffmann
--

SELECT pg_catalog.setval('public.tag_id_seq', 20, true);


--
-- Name: thread_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hoffmann
--

SELECT pg_catalog.setval('public.thread_id_seq', 12, true);


--
-- Name: answer answer_pkey; Type: CONSTRAINT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_pkey PRIMARY KEY (id);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: creator creator_pkey; Type: CONSTRAINT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.creator
    ADD CONSTRAINT creator_pkey PRIMARY KEY (id);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: thread_category thread_category_pkey; Type: CONSTRAINT; Schema: public; Owner: javaee_forum_admin
--

ALTER TABLE ONLY public.thread_category
    ADD CONSTRAINT thread_category_pkey PRIMARY KEY (thread_id, category_id);


--
-- Name: thread thread_pkey; Type: CONSTRAINT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.thread
    ADD CONSTRAINT thread_pkey PRIMARY KEY (id);


--
-- Name: thread_tag thread_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.thread_tag
    ADD CONSTRAINT thread_tag_pkey PRIMARY KEY (thread_id, tag_id);


--
-- Name: answer answer_creator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_creator_fkey FOREIGN KEY (creator_id) REFERENCES public.creator(id);


--
-- Name: answer answer_thread_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_thread_fkey FOREIGN KEY (thread_id) REFERENCES public.thread(id);


--
-- Name: comment comment_answer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_answer_fkey FOREIGN KEY (answer_id) REFERENCES public.answer(id);


--
-- Name: comment comment_creator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_creator_fkey FOREIGN KEY (creator_id) REFERENCES public.creator(id);


--
-- Name: thread_category thread_category_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: javaee_forum_admin
--

ALTER TABLE ONLY public.thread_category
    ADD CONSTRAINT thread_category_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(id);


--
-- Name: thread_category thread_category_thread_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: javaee_forum_admin
--

ALTER TABLE ONLY public.thread_category
    ADD CONSTRAINT thread_category_thread_id_fkey FOREIGN KEY (thread_id) REFERENCES public.thread(id);


--
-- Name: thread thread_creator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.thread
    ADD CONSTRAINT thread_creator_fkey FOREIGN KEY (creator_id) REFERENCES public.creator(id);


--
-- Name: thread_tag thread_tag_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.thread_tag
    ADD CONSTRAINT thread_tag_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tag(id);


--
-- Name: thread_tag thread_tag_thread_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.thread_tag
    ADD CONSTRAINT thread_tag_thread_id_fkey FOREIGN KEY (thread_id) REFERENCES public.thread(id);


--
-- PostgreSQL database dump complete
--

