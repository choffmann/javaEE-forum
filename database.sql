PGDMP                         y            javaee_forum    14.0    14.0 :    9           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            :           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ;           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            <           1262    16464    javaee_forum    DATABASE     a   CREATE DATABASE javaee_forum WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';
    DROP DATABASE javaee_forum;
                hoffmann    false            =           0    0    DATABASE javaee_forum    ACL     :   GRANT ALL ON DATABASE javaee_forum TO javaee_forum_admin;
                   hoffmann    false    3644            �            1259    16516    answer    TABLE     �   CREATE TABLE public.answer (
    id bigint NOT NULL,
    thread integer,
    creator integer,
    created_at date,
    modified_at date,
    text character varying
);
    DROP TABLE public.answer;
       public         heap    hoffmann    false            �            1259    16515    answer_id_seq    SEQUENCE     v   CREATE SEQUENCE public.answer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.answer_id_seq;
       public          hoffmann    false    217            >           0    0    answer_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.answer_id_seq OWNED BY public.answer.id;
          public          hoffmann    false    216            �            1259    16467    category    TABLE     U   CREATE TABLE public.category (
    id bigint NOT NULL,
    text character varying
);
    DROP TABLE public.category;
       public         heap    hoffmann    false            �            1259    16466    category_id_seq    SEQUENCE     x   CREATE SEQUENCE public.category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.category_id_seq;
       public          hoffmann    false    210            ?           0    0    category_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;
          public          hoffmann    false    209            �            1259    16535    comment    TABLE     �   CREATE TABLE public.comment (
    id bigint NOT NULL,
    answer integer,
    creator integer,
    created_at date,
    modified_at date,
    text character varying
);
    DROP TABLE public.comment;
       public         heap    hoffmann    false            �            1259    16534    comment_id_seq    SEQUENCE     w   CREATE SEQUENCE public.comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.comment_id_seq;
       public          hoffmann    false    219            @           0    0    comment_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.comment_id_seq OWNED BY public.comment.id;
          public          hoffmann    false    218            �            1259    16476    creator    TABLE     �   CREATE TABLE public.creator (
    id bigint NOT NULL,
    username character varying,
    email character varying,
    password character varying,
    is_admin boolean,
    score integer
);
    DROP TABLE public.creator;
       public         heap    hoffmann    false            �            1259    16554    creator_answer    TABLE     �   CREATE TABLE public.creator_answer (
    id bigint NOT NULL,
    creator integer,
    answer integer,
    validation boolean
);
 "   DROP TABLE public.creator_answer;
       public         heap    hoffmann    false            �            1259    16553    creator_answer_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.creator_answer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.creator_answer_id_seq;
       public          hoffmann    false    221            A           0    0    creator_answer_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.creator_answer_id_seq OWNED BY public.creator_answer.id;
          public          hoffmann    false    220            �            1259    16475    creator_id_seq    SEQUENCE     w   CREATE SEQUENCE public.creator_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.creator_id_seq;
       public          hoffmann    false    212            B           0    0    creator_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.creator_id_seq OWNED BY public.creator.id;
          public          hoffmann    false    211            �            1259    16485    thread    TABLE     �   CREATE TABLE public.thread (
    id bigint NOT NULL,
    creator integer,
    title character varying,
    created_at date,
    modified_at date,
    text character varying,
    category integer
);
    DROP TABLE public.thread;
       public         heap    hoffmann    false            �            1259    16484    thread_id_seq    SEQUENCE     v   CREATE SEQUENCE public.thread_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.thread_id_seq;
       public          hoffmann    false    214            C           0    0    thread_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.thread_id_seq OWNED BY public.thread.id;
          public          hoffmann    false    213            �            1259    16503    thread_tags    TABLE     \   CREATE TABLE public.thread_tags (
    thread integer NOT NULL,
    tag character varying
);
    DROP TABLE public.thread_tags;
       public         heap    hoffmann    false            �           2604    16519 	   answer id    DEFAULT     f   ALTER TABLE ONLY public.answer ALTER COLUMN id SET DEFAULT nextval('public.answer_id_seq'::regclass);
 8   ALTER TABLE public.answer ALTER COLUMN id DROP DEFAULT;
       public          hoffmann    false    217    216    217            �           2604    16470    category id    DEFAULT     j   ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 :   ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
       public          hoffmann    false    209    210    210            �           2604    16538 
   comment id    DEFAULT     h   ALTER TABLE ONLY public.comment ALTER COLUMN id SET DEFAULT nextval('public.comment_id_seq'::regclass);
 9   ALTER TABLE public.comment ALTER COLUMN id DROP DEFAULT;
       public          hoffmann    false    219    218    219            �           2604    16479 
   creator id    DEFAULT     h   ALTER TABLE ONLY public.creator ALTER COLUMN id SET DEFAULT nextval('public.creator_id_seq'::regclass);
 9   ALTER TABLE public.creator ALTER COLUMN id DROP DEFAULT;
       public          hoffmann    false    211    212    212            �           2604    16557    creator_answer id    DEFAULT     v   ALTER TABLE ONLY public.creator_answer ALTER COLUMN id SET DEFAULT nextval('public.creator_answer_id_seq'::regclass);
 @   ALTER TABLE public.creator_answer ALTER COLUMN id DROP DEFAULT;
       public          hoffmann    false    221    220    221            �           2604    16488 	   thread id    DEFAULT     f   ALTER TABLE ONLY public.thread ALTER COLUMN id SET DEFAULT nextval('public.thread_id_seq'::regclass);
 8   ALTER TABLE public.thread ALTER COLUMN id DROP DEFAULT;
       public          hoffmann    false    214    213    214            2          0    16516    answer 
   TABLE DATA           T   COPY public.answer (id, thread, creator, created_at, modified_at, text) FROM stdin;
    public          hoffmann    false    217   �?       +          0    16467    category 
   TABLE DATA           ,   COPY public.category (id, text) FROM stdin;
    public          hoffmann    false    210   �?       4          0    16535    comment 
   TABLE DATA           U   COPY public.comment (id, answer, creator, created_at, modified_at, text) FROM stdin;
    public          hoffmann    false    219   �?       -          0    16476    creator 
   TABLE DATA           Q   COPY public.creator (id, username, email, password, is_admin, score) FROM stdin;
    public          hoffmann    false    212   �?       6          0    16554    creator_answer 
   TABLE DATA           I   COPY public.creator_answer (id, creator, answer, validation) FROM stdin;
    public          hoffmann    false    221   
@       /          0    16485    thread 
   TABLE DATA           ]   COPY public.thread (id, creator, title, created_at, modified_at, text, category) FROM stdin;
    public          hoffmann    false    214   '@       0          0    16503    thread_tags 
   TABLE DATA           2   COPY public.thread_tags (thread, tag) FROM stdin;
    public          hoffmann    false    215   D@       D           0    0    answer_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.answer_id_seq', 1, false);
          public          hoffmann    false    216            E           0    0    category_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.category_id_seq', 1, false);
          public          hoffmann    false    209            F           0    0    comment_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.comment_id_seq', 1, false);
          public          hoffmann    false    218            G           0    0    creator_answer_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.creator_answer_id_seq', 1, false);
          public          hoffmann    false    220            H           0    0    creator_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.creator_id_seq', 1, false);
          public          hoffmann    false    211            I           0    0    thread_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.thread_id_seq', 1, false);
          public          hoffmann    false    213            �           2606    16523    answer answer_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.answer DROP CONSTRAINT answer_pkey;
       public            hoffmann    false    217            �           2606    16474    category category_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            hoffmann    false    210            �           2606    16542    comment comment_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_pkey;
       public            hoffmann    false    219            �           2606    16483    creator creator_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.creator
    ADD CONSTRAINT creator_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.creator DROP CONSTRAINT creator_pkey;
       public            hoffmann    false    212            �           2606    16492    thread thread_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.thread
    ADD CONSTRAINT thread_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.thread DROP CONSTRAINT thread_pkey;
       public            hoffmann    false    214            �           2606    16509    thread_tags thread_tags_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.thread_tags
    ADD CONSTRAINT thread_tags_pkey PRIMARY KEY (thread);
 F   ALTER TABLE ONLY public.thread_tags DROP CONSTRAINT thread_tags_pkey;
       public            hoffmann    false    215            �           2606    16529    answer answer_creator_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_creator_fkey FOREIGN KEY (creator) REFERENCES public.creator(id);
 D   ALTER TABLE ONLY public.answer DROP CONSTRAINT answer_creator_fkey;
       public          hoffmann    false    212    217    3469            �           2606    16524    answer answer_thread_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_thread_fkey FOREIGN KEY (thread) REFERENCES public.thread(id);
 C   ALTER TABLE ONLY public.answer DROP CONSTRAINT answer_thread_fkey;
       public          hoffmann    false    217    214    3471            �           2606    16543    comment comment_answer_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_answer_fkey FOREIGN KEY (answer) REFERENCES public.answer(id);
 E   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_answer_fkey;
       public          hoffmann    false    3475    219    217            �           2606    16548    comment comment_creator_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_creator_fkey FOREIGN KEY (creator) REFERENCES public.creator(id);
 F   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_creator_fkey;
       public          hoffmann    false    3469    212    219            �           2606    16563 )   creator_answer creator_answer_answer_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.creator_answer
    ADD CONSTRAINT creator_answer_answer_fkey FOREIGN KEY (answer) REFERENCES public.answer(id);
 S   ALTER TABLE ONLY public.creator_answer DROP CONSTRAINT creator_answer_answer_fkey;
       public          hoffmann    false    221    217    3475            �           2606    16558 *   creator_answer creator_answer_creator_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.creator_answer
    ADD CONSTRAINT creator_answer_creator_fkey FOREIGN KEY (creator) REFERENCES public.creator(id);
 T   ALTER TABLE ONLY public.creator_answer DROP CONSTRAINT creator_answer_creator_fkey;
       public          hoffmann    false    3469    221    212            �           2606    16498    thread thread_category_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.thread
    ADD CONSTRAINT thread_category_fkey FOREIGN KEY (category) REFERENCES public.category(id);
 E   ALTER TABLE ONLY public.thread DROP CONSTRAINT thread_category_fkey;
       public          hoffmann    false    214    3467    210            �           2606    16493    thread thread_creator_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.thread
    ADD CONSTRAINT thread_creator_fkey FOREIGN KEY (creator) REFERENCES public.creator(id);
 D   ALTER TABLE ONLY public.thread DROP CONSTRAINT thread_creator_fkey;
       public          hoffmann    false    212    214    3469            �           2606    16510 #   thread_tags thread_tags_thread_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.thread_tags
    ADD CONSTRAINT thread_tags_thread_fkey FOREIGN KEY (thread) REFERENCES public.thread(id);
 M   ALTER TABLE ONLY public.thread_tags DROP CONSTRAINT thread_tags_thread_fkey;
       public          hoffmann    false    3471    214    215            2      x������ � �      +      x������ � �      4      x������ � �      -      x������ � �      6      x������ � �      /      x������ � �      0      x������ � �     