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
20	23	6	2022-01-07 12:24:36.481	2022-01-07 12:24:36.481	As a repairman, I want to see a list of repair opportunities, so that I can pick the most interesting ones
22	23	11	2022-01-07 12:25:00.472	2022-01-07 12:25:00.472	As a person that needs to get something repaired, I want to publish a new opportunity
21	23	10	2022-01-07 12:24:43.995	2022-01-07 12:24:43.995	As a repairman, I want to filter the list of opportunities according to location, type and end date of the auction, so that I can pick the most relevant ones more quickly
23	25	9	2022-01-07 12:34:45.001	2022-01-07 12:34:45.001	Da gibt es die:\r\n- (streng) monoton wachsend\r\n- (streng) monoton fallend\r\n- nach oben beschränkt\r\n- nach unten beschränkt
32	29	5	2022-01-07 13:31:08.653	2022-01-07 13:31:08.653	In der Praxis haben die Kunden von generischer Software nur einen mittelbaren Einfluss (durch Feedback) auf die Spezifikation. Sie müssen daher oft mit dem zurecht kommen, was der Softwarehersteller liefert.
31	29	10	2022-01-07 13:30:28.628	2022-01-07 13:30:28.628	Bei generischen Softwaresystemen wird die Spezifikation vom Softwarehersteller angefertigt.
30	29	6	2022-01-07 13:30:22.158	2022-01-07 13:30:22.158	Bei angepassten Softwaresystemen bestimmt der Kunde die Spezifikation. Die Entwickler müssen sich an die Spezifikation halten.
25	26	5	2022-01-07 12:54:28.627	2022-01-07 12:54:28.627	Eine Liste hat folgende Methoden:\r\n- isEmtpy(): boolean\r\n- size(): int\r\n- get(int index): T\r\n- add(int index, T e): void\r\n- remove(int index): T
29	27	11	2022-01-07 13:20:08.991	2022-01-07 13:20:08.991	Die Datei persistence.xml definiert die Datenbankkonfiguration einer JPA-Anwendung. Bei Eclipse befindet sie sich im Projektordner JPA Content. Wird das Projekt allerdings durch einen Dateimanager oder per Terminal geöffnet, befindet sie sich unterhalb des Projektverzeichnis in src/META-INF.
19	23	9	2022-01-07 12:15:46.303	2022-01-07 12:15:46.303	Langfassung\r\nAs a <role>, I want <goal/desire> so that <benefit>\r\n\r\nKurzfassung\r\nAs a <role>, I want <goal/desire>
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: hoffmann
--

COPY public.category (id, text) FROM stdin;
18	Software Engineering 1
19	Mathematik 2
17	Client-Server Programmierung
16	Algorithmen
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: hoffmann
--

COPY public.comment (id, answer_id, creator_id, created_at, modified_at, text) FROM stdin;
15	21	10	2022-01-07 12:27:00.569	2022-01-07 12:27:00.569	No problem
14	21	5	2022-01-07 12:26:45.401	2022-01-07 12:26:45.401	Das gefällt mir, danke!
13	19	5	2022-01-07 12:25:42.99	2022-01-07 12:25:42.99	Das ist schonmal ein start
25	23	9	2022-01-07 13:26:34.279	2022-01-07 13:26:34.279	wenn es ein K ∈ R gibt, so dass für alle n ∈ ℕ gilt: an ≤ K
24	23	6	2022-01-07 13:24:14.421	2022-01-07 13:24:14.421	Was genau heißt nach oben beschränkt?
16	25	9	2022-01-07 12:54:52.982	2022-01-07 12:54:52.982	Okay danke, was bedeutet das T?
18	25	9	2022-01-07 12:55:50.981	2022-01-07 12:55:50.981	Okay, kannst du mir sagen was 'get' genau macht?
17	25	5	2022-01-07 12:55:26.865	2022-01-07 12:55:26.865	T steht für den Typ, welcher als Generic bei deiner Liste verwendet wird.
19	25	5	2022-01-07 12:56:13.166	2022-01-07 12:56:13.166	'get' liefert das Element an der angegebenen Stelle der Liste.
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
31	user-story
32	folgenmathelernen
33	mathe
34	folgen
35	lernen
36	listen
37	java
38	jpa
39	xml
40	Softwareentwicklung
41	frage
\.


--
-- Data for Name: thread; Type: TABLE DATA; Schema: public; Owner: hoffmann
--

COPY public.thread (id, creator_id, title, created_at, modified_at, text, category_id) FROM stdin;
23	5	Hilfe bei User-Stories	2022-01-07 12:15:20.159	2022-01-07 12:15:20.159	Ich benötige Hilfe bei einer User-Story.\r\n\r\nWir wollen verhindern, dass zu viele Dinge weggeworfen werden, obwohl sie mit ein wenig Fachkenntnis durchaus reparierbar wären. Mit der neuen Webplattform Repairix sollen Personen, die etwas repariert haben wollen mit denen die etwas reparieren können zusammengebracht werden. Wir stellen uns so etwas wie ein Ebay für Reparaturen vor.	18
25	6	Klassifikationen von Folgen	2022-01-07 12:32:35.054	2022-01-07 12:32:35.054	Hey, kann mir jemand sagen, welche Klassifikationen es von folgen in der Mathematik gibt?	19
29	11	Unterschied zwischen generischer Softwareproduktentwicklung und kundenspezifischer Softwareentwicklung?	2022-01-07 13:29:48.331	2022-01-07 13:29:48.331	Was ist der wichtigste Unterschied zwischen generischer Softwareproduktentwick- lung und kundenspezifischer Softwareentwicklung? Was könnte das in der Praxis für Benutzer von generischen Softwareprodukten bedeuten?	18
26	9	Methode in Listen	2022-01-07 12:45:48.598	2022-01-07 12:45:48.598	Ich bin gerade dabei eine Liste zu programmieren, welche Methoden hat eine Liste in Java standardmäßig?	16
27	10	JPA persistence.xml Konfiguration	2022-01-07 13:00:38.785	2022-01-07 13:00:38.785	Hallo, ich arbeite gerade an einem Projekt mit JPA.\r\nKann mir jemand helfen und sagen, was die Datei persistence.xml macht?	17
\.


--
-- Data for Name: thread_tag; Type: TABLE DATA; Schema: public; Owner: hoffmann
--

COPY public.thread_tag (thread_id, tag_id) FROM stdin;
23	31
25	33
25	34
25	35
26	36
26	37
27	37
27	38
27	39
29	40
29	41
\.


--
-- Name: answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hoffmann
--

SELECT pg_catalog.setval('public.answer_id_seq', 32, true);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hoffmann
--

SELECT pg_catalog.setval('public.category_id_seq', 20, true);


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hoffmann
--

SELECT pg_catalog.setval('public.comment_id_seq', 27, true);


--
-- Name: creator_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hoffmann
--

SELECT pg_catalog.setval('public.creator_id_seq', 11, true);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hoffmann
--

SELECT pg_catalog.setval('public.tag_id_seq', 41, true);


--
-- Name: thread_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hoffmann
--

SELECT pg_catalog.setval('public.thread_id_seq', 29, true);


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

