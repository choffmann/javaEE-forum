--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.1

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
    text text NOT NULL
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
    is_deleted boolean DEFAULT false NOT NULL
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
    text text NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.thread OWNER TO hoffmann;

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

COPY public.answer (id, thread_id, creator_id, created_at, modified_at, text) FROM stdin;
14	14	6	2022-01-05 12:48:44.777	2022-01-05 12:48:44.777	Das hab ich mich auch immer gefragt ð¤
16	15	9	2022-01-05 13:00:12.394	2022-01-05 13:00:12.394	Bestimmt hÃ¶ren die ihre TrÃ¤ume
17	16	6	2022-01-05 13:07:04.671	2022-01-05 13:07:04.671	Ja, kann ich dir aus eigener Erfahrung bestÃ¤tigen!
18	16	11	2022-01-05 13:08:21.209	2022-01-05 13:08:21.209	Quatsch!
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: hoffmann
--

COPY public.category (id, text) FROM stdin;
16	Category #0
17	Category #1
18	Category #2
19	Category #3
20	Category #4
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: hoffmann
--

COPY public.comment (id, answer_id, creator_id, created_at, modified_at, text) FROM stdin;
9	14	9	2022-01-05 13:01:05.947	2022-01-05 13:01:05.948	Ich auch
10	14	5	2022-01-05 13:01:36.867	2022-01-05 13:01:36.867	Toll, das hilft mir nicht weiter...
11	16	6	2022-01-05 13:06:02.616	2022-01-05 13:06:02.616	Okay, danke!
12	16	6	2022-01-05 13:06:02.616	2022-01-05 13:06:02.616	Okay, danke!
\.


--
-- Data for Name: creator; Type: TABLE DATA; Schema: public; Owner: hoffmann
--

COPY public.creator (id, username, email, password, is_admin, is_deleted) FROM stdin;
8	admin	admin@example.com	geheim	t	f
5	choffmann	cedrik.hoffmann@stud.hs-flensburg.de	secret_password!	f	f
6	pfriedrichsen	pascal.friedrichsen@stud.hs-flensburg.de	password!	f	f
9	dheckner	dominik.heckner@stud.hs-flensburg.de	super_geheim	f	f
10	fpetersen	fabian.petersen@stud.hs-flensburg.de	mega_geheim	f	f
11	kheuer	kajsa.heuer@stud.hs-flensburg.de	super_duppa_geheim	f	f
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: hoffmann
--

COPY public.tag (id, tag) FROM stdin;
16	Tag #0
17	Tag #1
18	Tag #2
19	Tag #3
20	Tag #4
21	zzh
22	zebra
23	streifen
24	traum
25	
\.


--
-- Data for Name: thread; Type: TABLE DATA; Schema: public; Owner: hoffmann
--

COPY public.thread (id, creator_id, title, created_at, modified_at, text, category_id) FROM stdin;
14	5	Haben Zebras eigentlich weiÃe oder schwarze Streifen? 	2022-01-05 12:26:54.916	2022-01-05 12:26:54.916	Eine sehr wichtige Frage, die mich sehr beschÃ¤ftigt...	16
15	6	Wovon trÃ¤umen blinde Menschen?	2022-01-05 12:47:52.729	2022-01-05 12:47:52.729	Kann mir jemand verraten, was bilde Menschen trÃ¤umen?	17
16	10	Kann durch die richtige Beleuchtung die hÃ¤sslichste Person hÃ¼bsch sein? 	2022-01-05 12:57:17.819	2022-01-05 12:57:17.819	Nichts persÃ¶nliches, nur eine Frage	16
\.


--
-- Data for Name: thread_tag; Type: TABLE DATA; Schema: public; Owner: hoffmann
--

COPY public.thread_tag (thread_id, tag_id) FROM stdin;
14	22
14	23
15	24
16	25
\.


--
-- Name: answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hoffmann
--

SELECT pg_catalog.setval('public.answer_id_seq', 18, true);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hoffmann
--

SELECT pg_catalog.setval('public.category_id_seq', 20, true);


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hoffmann
--

SELECT pg_catalog.setval('public.comment_id_seq', 12, true);


--
-- Name: creator_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hoffmann
--

SELECT pg_catalog.setval('public.creator_id_seq', 11, true);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hoffmann
--

SELECT pg_catalog.setval('public.tag_id_seq', 25, true);


--
-- Name: thread_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hoffmann
--

SELECT pg_catalog.setval('public.thread_id_seq', 16, true);


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
-- Name: thread thread_category_fk; Type: FK CONSTRAINT; Schema: public; Owner: hoffmann
--

ALTER TABLE ONLY public.thread
    ADD CONSTRAINT thread_category_fk FOREIGN KEY (category_id) REFERENCES public.category(id);


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

