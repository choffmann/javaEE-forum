PGDMP         ;                y            javaee_forum    14.0    14.0 D    Q           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            R           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            S           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            T           1262    16464    javaee_forum    DATABASE     a   CREATE DATABASE javaee_forum WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';
    DROP DATABASE javaee_forum;
                hoffmann    false            U           0    0    DATABASE javaee_forum    ACL     :   GRANT ALL ON DATABASE javaee_forum TO javaee_forum_admin;
                   hoffmann    false    3668            �            1259    16759    answer    TABLE     �   CREATE TABLE public.answer (
    id integer NOT NULL,
    thread integer,
    creator integer,
    created_at date DEFAULT CURRENT_DATE NOT NULL,
    modified_at date NOT NULL,
    text text NOT NULL
);
    DROP TABLE public.answer;
       public         heap    hoffmann    false            �            1259    16758    answer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.answer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.answer_id_seq;
       public          hoffmann    false    219            V           0    0    answer_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.answer_id_seq OWNED BY public.answer.id;
          public          hoffmann    false    218            �            1259    16706    category    TABLE     R   CREATE TABLE public.category (
    id integer NOT NULL,
    text text NOT NULL
);
    DROP TABLE public.category;
       public         heap    hoffmann    false            �            1259    16705    category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.category_id_seq;
       public          hoffmann    false    212            W           0    0    category_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;
          public          hoffmann    false    211            �            1259    16779    comment    TABLE     �   CREATE TABLE public.comment (
    id integer NOT NULL,
    answer integer,
    creator integer,
    created_at date DEFAULT CURRENT_DATE NOT NULL,
    modified_at date NOT NULL,
    text text NOT NULL
);
    DROP TABLE public.comment;
       public         heap    hoffmann    false            �            1259    16778    comment_id_seq    SEQUENCE     �   CREATE SEQUENCE public.comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.comment_id_seq;
       public          hoffmann    false    221            X           0    0    comment_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.comment_id_seq OWNED BY public.comment.id;
          public          hoffmann    false    220            �            1259    16695    creator    TABLE     �   CREATE TABLE public.creator (
    id integer NOT NULL,
    username text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    is_admin boolean DEFAULT false NOT NULL,
    score numeric DEFAULT 0 NOT NULL
);
    DROP TABLE public.creator;
       public         heap    hoffmann    false            �            1259    16801    creator_answer    TABLE     �   CREATE TABLE public.creator_answer (
    creator_id integer NOT NULL,
    answer_id integer NOT NULL,
    validation boolean NOT NULL
);
 "   DROP TABLE public.creator_answer;
       public         heap    hoffmann    false            �            1259    16816    creator_comment    TABLE     j   CREATE TABLE public.creator_comment (
    creator_id integer NOT NULL,
    comment_id integer NOT NULL
);
 #   DROP TABLE public.creator_comment;
       public         heap    hoffmann    false            �            1259    16694    creator_id_seq    SEQUENCE     �   CREATE SEQUENCE public.creator_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.creator_id_seq;
       public          hoffmann    false    210            Y           0    0    creator_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.creator_id_seq OWNED BY public.creator.id;
          public          hoffmann    false    209            �            1259    16735    tag    TABLE     L   CREATE TABLE public.tag (
    id integer NOT NULL,
    tag text NOT NULL
);
    DROP TABLE public.tag;
       public         heap    hoffmann    false            �            1259    16734 
   tag_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.tag_id_seq;
       public          hoffmann    false    216            Z           0    0 
   tag_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;
          public          hoffmann    false    215            �            1259    16715    thread    TABLE     �   CREATE TABLE public.thread (
    id integer NOT NULL,
    creator integer,
    title text NOT NULL,
    created_at date DEFAULT CURRENT_DATE NOT NULL,
    modified_at date NOT NULL,
    text text NOT NULL,
    category integer
);
    DROP TABLE public.thread;
       public         heap    hoffmann    false            �            1259    16714    thread_id_seq    SEQUENCE     �   CREATE SEQUENCE public.thread_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.thread_id_seq;
       public          hoffmann    false    214            [           0    0    thread_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.thread_id_seq OWNED BY public.thread.id;
          public          hoffmann    false    213            �            1259    16743 
   thread_tag    TABLE     `   CREATE TABLE public.thread_tag (
    thread_id integer NOT NULL,
    tag_id integer NOT NULL
);
    DROP TABLE public.thread_tag;
       public         heap    hoffmann    false            �           2604    16762 	   answer id    DEFAULT     f   ALTER TABLE ONLY public.answer ALTER COLUMN id SET DEFAULT nextval('public.answer_id_seq'::regclass);
 8   ALTER TABLE public.answer ALTER COLUMN id DROP DEFAULT;
       public          hoffmann    false    218    219    219            �           2604    16709    category id    DEFAULT     j   ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 :   ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
       public          hoffmann    false    212    211    212            �           2604    16782 
   comment id    DEFAULT     h   ALTER TABLE ONLY public.comment ALTER COLUMN id SET DEFAULT nextval('public.comment_id_seq'::regclass);
 9   ALTER TABLE public.comment ALTER COLUMN id DROP DEFAULT;
       public          hoffmann    false    220    221    221            �           2604    16698 
   creator id    DEFAULT     h   ALTER TABLE ONLY public.creator ALTER COLUMN id SET DEFAULT nextval('public.creator_id_seq'::regclass);
 9   ALTER TABLE public.creator ALTER COLUMN id DROP DEFAULT;
       public          hoffmann    false    210    209    210            �           2604    16738    tag id    DEFAULT     `   ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);
 5   ALTER TABLE public.tag ALTER COLUMN id DROP DEFAULT;
       public          hoffmann    false    215    216    216            �           2604    16718 	   thread id    DEFAULT     f   ALTER TABLE ONLY public.thread ALTER COLUMN id SET DEFAULT nextval('public.thread_id_seq'::regclass);
 8   ALTER TABLE public.thread ALTER COLUMN id DROP DEFAULT;
       public          hoffmann    false    214    213    214            J          0    16759    answer 
   TABLE DATA           T   COPY public.answer (id, thread, creator, created_at, modified_at, text) FROM stdin;
    public          hoffmann    false    219   �L       C          0    16706    category 
   TABLE DATA           ,   COPY public.category (id, text) FROM stdin;
    public          hoffmann    false    212   �L       L          0    16779    comment 
   TABLE DATA           U   COPY public.comment (id, answer, creator, created_at, modified_at, text) FROM stdin;
    public          hoffmann    false    221   �L       A          0    16695    creator 
   TABLE DATA           Q   COPY public.creator (id, username, email, password, is_admin, score) FROM stdin;
    public          hoffmann    false    210   �L       M          0    16801    creator_answer 
   TABLE DATA           K   COPY public.creator_answer (creator_id, answer_id, validation) FROM stdin;
    public          hoffmann    false    222   	M       N          0    16816    creator_comment 
   TABLE DATA           A   COPY public.creator_comment (creator_id, comment_id) FROM stdin;
    public          hoffmann    false    223   &M       G          0    16735    tag 
   TABLE DATA           &   COPY public.tag (id, tag) FROM stdin;
    public          hoffmann    false    216   CM       E          0    16715    thread 
   TABLE DATA           ]   COPY public.thread (id, creator, title, created_at, modified_at, text, category) FROM stdin;
    public          hoffmann    false    214   `M       H          0    16743 
   thread_tag 
   TABLE DATA           7   COPY public.thread_tag (thread_id, tag_id) FROM stdin;
    public          hoffmann    false    217   }M       \           0    0    answer_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.answer_id_seq', 1, false);
          public          hoffmann    false    218            ]           0    0    category_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.category_id_seq', 1, false);
          public          hoffmann    false    211            ^           0    0    comment_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.comment_id_seq', 1, false);
          public          hoffmann    false    220            _           0    0    creator_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.creator_id_seq', 1, false);
          public          hoffmann    false    209            `           0    0 
   tag_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.tag_id_seq', 1, false);
          public          hoffmann    false    215            a           0    0    thread_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.thread_id_seq', 1, false);
          public          hoffmann    false    213            �           2606    16767    answer answer_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.answer DROP CONSTRAINT answer_pkey;
       public            hoffmann    false    219            �           2606    16713    category category_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            hoffmann    false    212            �           2606    16787    comment comment_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_pkey;
       public            hoffmann    false    221            �           2606    16805 "   creator_answer creator_answer_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.creator_answer
    ADD CONSTRAINT creator_answer_pkey PRIMARY KEY (creator_id, answer_id);
 L   ALTER TABLE ONLY public.creator_answer DROP CONSTRAINT creator_answer_pkey;
       public            hoffmann    false    222    222            �           2606    16820 $   creator_comment creator_comment_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.creator_comment
    ADD CONSTRAINT creator_comment_pkey PRIMARY KEY (creator_id, comment_id);
 N   ALTER TABLE ONLY public.creator_comment DROP CONSTRAINT creator_comment_pkey;
       public            hoffmann    false    223    223            �           2606    16704    creator creator_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.creator
    ADD CONSTRAINT creator_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.creator DROP CONSTRAINT creator_pkey;
       public            hoffmann    false    210            �           2606    16742    tag tag_pkey 
   CONSTRAINT     J   ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);
 6   ALTER TABLE ONLY public.tag DROP CONSTRAINT tag_pkey;
       public            hoffmann    false    216            �           2606    16723    thread thread_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.thread
    ADD CONSTRAINT thread_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.thread DROP CONSTRAINT thread_pkey;
       public            hoffmann    false    214            �           2606    16747    thread_tag thread_tag_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.thread_tag
    ADD CONSTRAINT thread_tag_pkey PRIMARY KEY (thread_id, tag_id);
 D   ALTER TABLE ONLY public.thread_tag DROP CONSTRAINT thread_tag_pkey;
       public            hoffmann    false    217    217            �           2606    16773    answer answer_creator_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_creator_fkey FOREIGN KEY (creator) REFERENCES public.creator(id);
 D   ALTER TABLE ONLY public.answer DROP CONSTRAINT answer_creator_fkey;
       public          hoffmann    false    210    3480    219            �           2606    16768    answer answer_thread_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_thread_fkey FOREIGN KEY (thread) REFERENCES public.thread(id);
 C   ALTER TABLE ONLY public.answer DROP CONSTRAINT answer_thread_fkey;
       public          hoffmann    false    214    219    3484            �           2606    16788    comment comment_answer_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_answer_fkey FOREIGN KEY (answer) REFERENCES public.answer(id);
 E   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_answer_fkey;
       public          hoffmann    false    221    219    3490            �           2606    16793    comment comment_creator_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_creator_fkey FOREIGN KEY (creator) REFERENCES public.creator(id);
 F   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_creator_fkey;
       public          hoffmann    false    221    210    3480            �           2606    16811 ,   creator_answer creator_answer_answer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.creator_answer
    ADD CONSTRAINT creator_answer_answer_id_fkey FOREIGN KEY (answer_id) REFERENCES public.answer(id);
 V   ALTER TABLE ONLY public.creator_answer DROP CONSTRAINT creator_answer_answer_id_fkey;
       public          hoffmann    false    222    219    3490            �           2606    16806 -   creator_answer creator_answer_creator_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.creator_answer
    ADD CONSTRAINT creator_answer_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.creator(id);
 W   ALTER TABLE ONLY public.creator_answer DROP CONSTRAINT creator_answer_creator_id_fkey;
       public          hoffmann    false    210    3480    222            �           2606    16826 /   creator_comment creator_comment_comment_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.creator_comment
    ADD CONSTRAINT creator_comment_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.comment(id);
 Y   ALTER TABLE ONLY public.creator_comment DROP CONSTRAINT creator_comment_comment_id_fkey;
       public          hoffmann    false    223    3492    221            �           2606    16821 /   creator_comment creator_comment_creator_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.creator_comment
    ADD CONSTRAINT creator_comment_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.creator(id);
 Y   ALTER TABLE ONLY public.creator_comment DROP CONSTRAINT creator_comment_creator_id_fkey;
       public          hoffmann    false    210    3480    223            �           2606    16729    thread thread_category_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.thread
    ADD CONSTRAINT thread_category_fkey FOREIGN KEY (category) REFERENCES public.category(id);
 E   ALTER TABLE ONLY public.thread DROP CONSTRAINT thread_category_fkey;
       public          hoffmann    false    212    3482    214            �           2606    16724    thread thread_creator_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.thread
    ADD CONSTRAINT thread_creator_fkey FOREIGN KEY (creator) REFERENCES public.creator(id);
 D   ALTER TABLE ONLY public.thread DROP CONSTRAINT thread_creator_fkey;
       public          hoffmann    false    214    3480    210            �           2606    16753 !   thread_tag thread_tag_tag_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.thread_tag
    ADD CONSTRAINT thread_tag_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tag(id);
 K   ALTER TABLE ONLY public.thread_tag DROP CONSTRAINT thread_tag_tag_id_fkey;
       public          hoffmann    false    217    216    3486            �           2606    16748 $   thread_tag thread_tag_thread_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.thread_tag
    ADD CONSTRAINT thread_tag_thread_id_fkey FOREIGN KEY (thread_id) REFERENCES public.thread(id);
 N   ALTER TABLE ONLY public.thread_tag DROP CONSTRAINT thread_tag_thread_id_fkey;
       public          hoffmann    false    214    3484    217            J      x������ � �      C      x������ � �      L      x������ � �      A      x������ � �      M      x������ � �      N      x������ � �      G      x������ � �      E      x������ � �      H      x������ � �     