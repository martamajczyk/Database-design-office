PGDMP  ;    5                 |            biuro_projektowe    16.0    16.0 Y    j           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            k           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            l           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            m           1262    17055    biuro_projektowe    DATABASE     �   CREATE DATABASE biuro_projektowe WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Polish_Poland.1250';
     DROP DATABASE biuro_projektowe;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            n           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1259    17093    adresy    TABLE     N  CREATE TABLE public.adresy (
    adres_id bigint NOT NULL,
    adres_ulica text NOT NULL,
    adres_nr_ulicy integer NOT NULL,
    adres_nr_lokalu integer,
    adres_kod_pocztowy character varying(6) NOT NULL,
    adres_miasto text NOT NULL,
    ostatnia_aktualizacja timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.adresy;
       public         heap    postgres    false    4            �            1259    17092    adresy_adres_id_seq    SEQUENCE     |   CREATE SEQUENCE public.adresy_adres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.adresy_adres_id_seq;
       public          postgres    false    222    4            o           0    0    adresy_adres_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.adresy_adres_id_seq OWNED BY public.adresy.adres_id;
          public          postgres    false    221            �            1259    17109 
   inwestorzy    TABLE     9  CREATE TABLE public.inwestorzy (
    inwestor_id bigint NOT NULL,
    inwestor_imie text NOT NULL,
    inwestor_nazwisko text NOT NULL,
    inwestor_plec character(1) NOT NULL,
    inwestor_data_urodzenia date NOT NULL,
    inwestor_sposob_dotarcia text NOT NULL,
    adres_id bigint NOT NULL,
    ostatnia_aktualizacja timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT check_data_urodzenia CHECK ((inwestor_data_urodzenia > '1920-01-01'::date)),
    CONSTRAINT check_plec CHECK ((inwestor_plec = ANY (ARRAY['K'::bpchar, 'M'::bpchar])))
);
    DROP TABLE public.inwestorzy;
       public         heap    postgres    false    4            �            1259    17108    inwestorzy_inwestor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.inwestorzy_inwestor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.inwestorzy_inwestor_id_seq;
       public          postgres    false    4    226            p           0    0    inwestorzy_inwestor_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.inwestorzy_inwestor_id_seq OWNED BY public.inwestorzy.inwestor_id;
          public          postgres    false    225            �            1259    17063 
   inwestycje    TABLE     �   CREATE TABLE public.inwestycje (
    inwestycja_id bigint NOT NULL,
    inwestycja_nazwa text NOT NULL,
    ostatnia_aktualizacja timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.inwestycje;
       public         heap    postgres    false    4            �            1259    17062    inwestycje_inwestycja_id_seq    SEQUENCE     �   CREATE SEQUENCE public.inwestycje_inwestycja_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.inwestycje_inwestycja_id_seq;
       public          postgres    false    4    216            q           0    0    inwestycje_inwestycja_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.inwestycje_inwestycja_id_seq OWNED BY public.inwestycje.inwestycja_id;
          public          postgres    false    215            �            1259    17138    pakiety    TABLE     �  CREATE TABLE public.pakiety (
    pakiet_id bigint NOT NULL,
    pakiet_nazwa text NOT NULL,
    pakiet_cena_bazowa numeric(10,2) NOT NULL,
    pakiet_kategoria text NOT NULL,
    zakres_pakietu_id bigint NOT NULL,
    ostatnia_aktualizacja timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT check_cena_bazowa CHECK ((pakiet_cena_bazowa > (0)::numeric)),
    CONSTRAINT check_kategoria CHECK ((pakiet_kategoria = ANY (ARRAY['inwestycyjny'::text, 'prywatny'::text])))
);
    DROP TABLE public.pakiety;
       public         heap    postgres    false    4            �            1259    17137    pakiety_pakiet_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.pakiety_pakiet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.pakiety_pakiet_id_seq;
       public          postgres    false    4    234            r           0    0    pakiety_pakiet_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.pakiety_pakiet_id_seq OWNED BY public.pakiety.pakiet_id;
          public          postgres    false    233            �            1259    17123 
   pracownicy    TABLE     {  CREATE TABLE public.pracownicy (
    pracownik_id bigint NOT NULL,
    pracownik_imie text NOT NULL,
    pracownik_nazwisko text NOT NULL,
    pracownik_plec character(1) NOT NULL,
    pracownik_data_urodzenia date NOT NULL,
    pracownik_data_zatrudnienia date NOT NULL,
    pracownik_data_zwolnienia date,
    pracownik_typ_umowy text NOT NULL,
    adres_id bigint NOT NULL,
    ostatnia_aktualizacja timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT check_data_urodzenia CHECK ((pracownik_data_urodzenia > '1920-01-01'::date)),
    CONSTRAINT check_plec CHECK ((pracownik_plec = ANY (ARRAY['K'::bpchar, 'M'::bpchar]))),
    CONSTRAINT check_typ_umowy CHECK ((pracownik_typ_umowy = ANY (ARRAY['Umowa o pracę'::text, 'Umowa zlecenie'::text, 'Umowa o dzieło'::text, 'Kontrakt B2B'::text]))),
    CONSTRAINT pracownik_data_zatrudnienia CHECK (((pracownik_data_zatrudnienia <= pracownik_data_zwolnienia) AND ((pracownik_data_zatrudnienia IS NULL) OR (pracownik_data_zatrudnienia > pracownik_data_urodzenia)) AND ((pracownik_data_zatrudnienia IS NULL) OR (pracownik_data_zatrudnienia < pracownik_data_zwolnienia))))
);
    DROP TABLE public.pracownicy;
       public         heap    postgres    false    4            �            1259    17122    pracownicy_pracownik_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pracownicy_pracownik_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.pracownicy_pracownik_id_seq;
       public          postgres    false    4    230            s           0    0    pracownicy_pracownik_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.pracownicy_pracownik_id_seq OWNED BY public.pracownicy.pracownik_id;
          public          postgres    false    229            �            1259    17101    projekty    TABLE     �  CREATE TABLE public.projekty (
    projekt_id bigint NOT NULL,
    projekt_data_umowa date NOT NULL,
    projekt_cena_umowa numeric(10,2) NOT NULL,
    projekt_data_rozpoczecia date NOT NULL,
    projekt_data_zakonczenia date,
    projekt_tryb text NOT NULL,
    projekt_rynek text NOT NULL,
    projekt_metraz numeric(10,2) NOT NULL,
    projekt_budzet_planowany integer NOT NULL,
    projekt_budzet_zrealizowany integer NOT NULL,
    stylistyka_id bigint NOT NULL,
    inwestycja_id bigint,
    adres_id bigint NOT NULL,
    pakiet_id bigint NOT NULL,
    ostatnia_aktualizacja timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT check_budzet_planowany CHECK ((projekt_budzet_planowany > 0)),
    CONSTRAINT check_budzet_zrealizowany CHECK ((projekt_budzet_zrealizowany > 0)),
    CONSTRAINT check_cena_umowa CHECK ((projekt_cena_umowa > (0)::numeric)),
    CONSTRAINT check_data_rozpoczecia CHECK ((projekt_data_rozpoczecia >= '2019-01-01'::date)),
    CONSTRAINT check_data_umowa CHECK (((projekt_data_umowa <= projekt_data_rozpoczecia) AND ((projekt_data_zakonczenia IS NULL) OR (projekt_data_umowa < projekt_data_zakonczenia)) AND ((projekt_data_zakonczenia IS NULL) OR (projekt_data_rozpoczecia <= projekt_data_zakonczenia)) AND (projekt_data_umowa >= '2019-01-01'::date))),
    CONSTRAINT check_data_zakonczenia CHECK ((projekt_data_zakonczenia >= '2019-01-01'::date)),
    CONSTRAINT check_metraz CHECK ((projekt_metraz > (0)::numeric)),
    CONSTRAINT check_rynek CHECK ((projekt_rynek = ANY (ARRAY['pierwotny'::text, 'wtórny'::text]))),
    CONSTRAINT check_tryb CHECK ((projekt_tryb = ANY (ARRAY['zdalny'::text, 'stacjonarny'::text, 'hybrydowy'::text])))
);
    DROP TABLE public.projekty;
       public         heap    postgres    false    4            �            1259    17117    projekty_inwestorzy    TABLE     �   CREATE TABLE public.projekty_inwestorzy (
    projekty_inwestorzy_id bigint NOT NULL,
    projekt_id bigint NOT NULL,
    inwestor_id bigint NOT NULL,
    ostatnia_aktualizacja timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 '   DROP TABLE public.projekty_inwestorzy;
       public         heap    postgres    false    4            �            1259    17116 .   projekty_inwestorzy_projekty_inwestorzy_id_seq    SEQUENCE     �   CREATE SEQUENCE public.projekty_inwestorzy_projekty_inwestorzy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 E   DROP SEQUENCE public.projekty_inwestorzy_projekty_inwestorzy_id_seq;
       public          postgres    false    4    228            t           0    0 .   projekty_inwestorzy_projekty_inwestorzy_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.projekty_inwestorzy_projekty_inwestorzy_id_seq OWNED BY public.projekty_inwestorzy.projekty_inwestorzy_id;
          public          postgres    false    227            �            1259    17131    projekty_pracownicy    TABLE     �   CREATE TABLE public.projekty_pracownicy (
    projekt_pracownik_id bigint NOT NULL,
    projekt_id bigint NOT NULL,
    pracownik_id bigint NOT NULL,
    ostatnia_aktualizacja timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 '   DROP TABLE public.projekty_pracownicy;
       public         heap    postgres    false    4            �            1259    17130 ,   projekty_pracownicy_projekt_pracownik_id_seq    SEQUENCE     �   CREATE SEQUENCE public.projekty_pracownicy_projekt_pracownik_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 C   DROP SEQUENCE public.projekty_pracownicy_projekt_pracownik_id_seq;
       public          postgres    false    4    232            u           0    0 ,   projekty_pracownicy_projekt_pracownik_id_seq    SEQUENCE OWNED BY     }   ALTER SEQUENCE public.projekty_pracownicy_projekt_pracownik_id_seq OWNED BY public.projekty_pracownicy.projekt_pracownik_id;
          public          postgres    false    231            �            1259    17100    projekty_projekt_id_seq    SEQUENCE     �   CREATE SEQUENCE public.projekty_projekt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.projekty_projekt_id_seq;
       public          postgres    false    4    224            v           0    0    projekty_projekt_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.projekty_projekt_id_seq OWNED BY public.projekty.projekt_id;
          public          postgres    false    223            �            1259    17071 
   stylistyka    TABLE     �   CREATE TABLE public.stylistyka (
    stylistyka_id bigint NOT NULL,
    stylistyka_nazwa text NOT NULL,
    ostatnia_aktualizacja timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.stylistyka;
       public         heap    postgres    false    4            �            1259    17070    stylistyka_stylistyka_id_seq    SEQUENCE     �   CREATE SEQUENCE public.stylistyka_stylistyka_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.stylistyka_stylistyka_id_seq;
       public          postgres    false    4    218            w           0    0    stylistyka_stylistyka_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.stylistyka_stylistyka_id_seq OWNED BY public.stylistyka.stylistyka_id;
          public          postgres    false    217            �            1259    17079    zakresy_pakietow    TABLE     /  CREATE TABLE public.zakresy_pakietow (
    zakres_pakietu_id bigint NOT NULL,
    zakres_pakietu_inwentaryzacja boolean NOT NULL,
    zakres_pakietu_funkcja boolean NOT NULL,
    zakres_pakietu_koncepcja boolean NOT NULL,
    zakres_pakietu_wizualizacje boolean NOT NULL,
    zakres_pakietu_lista_zakupow boolean NOT NULL,
    zakres_pakietu_dokumentacja boolean NOT NULL,
    zakres_pakietu_nadzor boolean NOT NULL,
    zakres_pakietu_home_staging boolean NOT NULL,
    ostatnia_aktualizacja timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 $   DROP TABLE public.zakresy_pakietow;
       public         heap    postgres    false    4            �            1259    17078 &   zakresy_pakietow_zakres_pakietu_id_seq    SEQUENCE     �   CREATE SEQUENCE public.zakresy_pakietow_zakres_pakietu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.zakresy_pakietow_zakres_pakietu_id_seq;
       public          postgres    false    4    220            x           0    0 &   zakresy_pakietow_zakres_pakietu_id_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE public.zakresy_pakietow_zakres_pakietu_id_seq OWNED BY public.zakresy_pakietow.zakres_pakietu_id;
          public          postgres    false    219            �           2604    17096    adresy adres_id    DEFAULT     r   ALTER TABLE ONLY public.adresy ALTER COLUMN adres_id SET DEFAULT nextval('public.adresy_adres_id_seq'::regclass);
 >   ALTER TABLE public.adresy ALTER COLUMN adres_id DROP DEFAULT;
       public          postgres    false    222    221    222            �           2604    17112    inwestorzy inwestor_id    DEFAULT     �   ALTER TABLE ONLY public.inwestorzy ALTER COLUMN inwestor_id SET DEFAULT nextval('public.inwestorzy_inwestor_id_seq'::regclass);
 E   ALTER TABLE public.inwestorzy ALTER COLUMN inwestor_id DROP DEFAULT;
       public          postgres    false    225    226    226            }           2604    17066    inwestycje inwestycja_id    DEFAULT     �   ALTER TABLE ONLY public.inwestycje ALTER COLUMN inwestycja_id SET DEFAULT nextval('public.inwestycje_inwestycja_id_seq'::regclass);
 G   ALTER TABLE public.inwestycje ALTER COLUMN inwestycja_id DROP DEFAULT;
       public          postgres    false    216    215    216            �           2604    17141    pakiety pakiet_id    DEFAULT     v   ALTER TABLE ONLY public.pakiety ALTER COLUMN pakiet_id SET DEFAULT nextval('public.pakiety_pakiet_id_seq'::regclass);
 @   ALTER TABLE public.pakiety ALTER COLUMN pakiet_id DROP DEFAULT;
       public          postgres    false    234    233    234            �           2604    17126    pracownicy pracownik_id    DEFAULT     �   ALTER TABLE ONLY public.pracownicy ALTER COLUMN pracownik_id SET DEFAULT nextval('public.pracownicy_pracownik_id_seq'::regclass);
 F   ALTER TABLE public.pracownicy ALTER COLUMN pracownik_id DROP DEFAULT;
       public          postgres    false    230    229    230            �           2604    17104    projekty projekt_id    DEFAULT     z   ALTER TABLE ONLY public.projekty ALTER COLUMN projekt_id SET DEFAULT nextval('public.projekty_projekt_id_seq'::regclass);
 B   ALTER TABLE public.projekty ALTER COLUMN projekt_id DROP DEFAULT;
       public          postgres    false    223    224    224            �           2604    17120 *   projekty_inwestorzy projekty_inwestorzy_id    DEFAULT     �   ALTER TABLE ONLY public.projekty_inwestorzy ALTER COLUMN projekty_inwestorzy_id SET DEFAULT nextval('public.projekty_inwestorzy_projekty_inwestorzy_id_seq'::regclass);
 Y   ALTER TABLE public.projekty_inwestorzy ALTER COLUMN projekty_inwestorzy_id DROP DEFAULT;
       public          postgres    false    228    227    228            �           2604    17134 (   projekty_pracownicy projekt_pracownik_id    DEFAULT     �   ALTER TABLE ONLY public.projekty_pracownicy ALTER COLUMN projekt_pracownik_id SET DEFAULT nextval('public.projekty_pracownicy_projekt_pracownik_id_seq'::regclass);
 W   ALTER TABLE public.projekty_pracownicy ALTER COLUMN projekt_pracownik_id DROP DEFAULT;
       public          postgres    false    231    232    232                       2604    17074    stylistyka stylistyka_id    DEFAULT     �   ALTER TABLE ONLY public.stylistyka ALTER COLUMN stylistyka_id SET DEFAULT nextval('public.stylistyka_stylistyka_id_seq'::regclass);
 G   ALTER TABLE public.stylistyka ALTER COLUMN stylistyka_id DROP DEFAULT;
       public          postgres    false    217    218    218            �           2604    17082 "   zakresy_pakietow zakres_pakietu_id    DEFAULT     �   ALTER TABLE ONLY public.zakresy_pakietow ALTER COLUMN zakres_pakietu_id SET DEFAULT nextval('public.zakresy_pakietow_zakres_pakietu_id_seq'::regclass);
 Q   ALTER TABLE public.zakresy_pakietow ALTER COLUMN zakres_pakietu_id DROP DEFAULT;
       public          postgres    false    219    220    220            [          0    17093    adresy 
   TABLE DATA           �   COPY public.adresy (adres_id, adres_ulica, adres_nr_ulicy, adres_nr_lokalu, adres_kod_pocztowy, adres_miasto, ostatnia_aktualizacja) FROM stdin;
    public          postgres    false    222   �~       _          0    17109 
   inwestorzy 
   TABLE DATA           �   COPY public.inwestorzy (inwestor_id, inwestor_imie, inwestor_nazwisko, inwestor_plec, inwestor_data_urodzenia, inwestor_sposob_dotarcia, adres_id, ostatnia_aktualizacja) FROM stdin;
    public          postgres    false    226   @�       U          0    17063 
   inwestycje 
   TABLE DATA           \   COPY public.inwestycje (inwestycja_id, inwestycja_nazwa, ostatnia_aktualizacja) FROM stdin;
    public          postgres    false    216   z�       g          0    17138    pakiety 
   TABLE DATA           �   COPY public.pakiety (pakiet_id, pakiet_nazwa, pakiet_cena_bazowa, pakiet_kategoria, zakres_pakietu_id, ostatnia_aktualizacja) FROM stdin;
    public          postgres    false    234   ��       c          0    17123 
   pracownicy 
   TABLE DATA           �   COPY public.pracownicy (pracownik_id, pracownik_imie, pracownik_nazwisko, pracownik_plec, pracownik_data_urodzenia, pracownik_data_zatrudnienia, pracownik_data_zwolnienia, pracownik_typ_umowy, adres_id, ostatnia_aktualizacja) FROM stdin;
    public          postgres    false    230   h�       ]          0    17101    projekty 
   TABLE DATA           8  COPY public.projekty (projekt_id, projekt_data_umowa, projekt_cena_umowa, projekt_data_rozpoczecia, projekt_data_zakonczenia, projekt_tryb, projekt_rynek, projekt_metraz, projekt_budzet_planowany, projekt_budzet_zrealizowany, stylistyka_id, inwestycja_id, adres_id, pakiet_id, ostatnia_aktualizacja) FROM stdin;
    public          postgres    false    224   ��       a          0    17117    projekty_inwestorzy 
   TABLE DATA           u   COPY public.projekty_inwestorzy (projekty_inwestorzy_id, projekt_id, inwestor_id, ostatnia_aktualizacja) FROM stdin;
    public          postgres    false    228   t�       e          0    17131    projekty_pracownicy 
   TABLE DATA           t   COPY public.projekty_pracownicy (projekt_pracownik_id, projekt_id, pracownik_id, ostatnia_aktualizacja) FROM stdin;
    public          postgres    false    232   ��       W          0    17071 
   stylistyka 
   TABLE DATA           \   COPY public.stylistyka (stylistyka_id, stylistyka_nazwa, ostatnia_aktualizacja) FROM stdin;
    public          postgres    false    218   A�       Y          0    17079    zakresy_pakietow 
   TABLE DATA           1  COPY public.zakresy_pakietow (zakres_pakietu_id, zakres_pakietu_inwentaryzacja, zakres_pakietu_funkcja, zakres_pakietu_koncepcja, zakres_pakietu_wizualizacje, zakres_pakietu_lista_zakupow, zakres_pakietu_dokumentacja, zakres_pakietu_nadzor, zakres_pakietu_home_staging, ostatnia_aktualizacja) FROM stdin;
    public          postgres    false    220   Л       y           0    0    adresy_adres_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.adresy_adres_id_seq', 151, true);
          public          postgres    false    221            z           0    0    inwestorzy_inwestor_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.inwestorzy_inwestor_id_seq', 60, true);
          public          postgres    false    225            {           0    0    inwestycje_inwestycja_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.inwestycje_inwestycja_id_seq', 19, true);
          public          postgres    false    215            |           0    0    pakiety_pakiet_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.pakiety_pakiet_id_seq', 20, true);
          public          postgres    false    233            }           0    0    pracownicy_pracownik_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.pracownicy_pracownik_id_seq', 17, false);
          public          postgres    false    229            ~           0    0 .   projekty_inwestorzy_projekty_inwestorzy_id_seq    SEQUENCE SET     ]   SELECT pg_catalog.setval('public.projekty_inwestorzy_projekty_inwestorzy_id_seq', 84, true);
          public          postgres    false    227                       0    0 ,   projekty_pracownicy_projekt_pracownik_id_seq    SEQUENCE SET     [   SELECT pg_catalog.setval('public.projekty_pracownicy_projekt_pracownik_id_seq', 84, true);
          public          postgres    false    231            �           0    0    projekty_projekt_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.projekty_projekt_id_seq', 300, true);
          public          postgres    false    223            �           0    0    stylistyka_stylistyka_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.stylistyka_stylistyka_id_seq', 8, true);
          public          postgres    false    217            �           0    0 &   zakresy_pakietow_zakres_pakietu_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.zakresy_pakietow_zakres_pakietu_id_seq', 7, true);
          public          postgres    false    219            �           2606    17193    adresy pk_adresy 
   CONSTRAINT     T   ALTER TABLE ONLY public.adresy
    ADD CONSTRAINT pk_adresy PRIMARY KEY (adres_id);
 :   ALTER TABLE ONLY public.adresy DROP CONSTRAINT pk_adresy;
       public            postgres    false    222            �           2606    17226    inwestorzy pk_inwestorzy 
   CONSTRAINT     _   ALTER TABLE ONLY public.inwestorzy
    ADD CONSTRAINT pk_inwestorzy PRIMARY KEY (inwestor_id);
 B   ALTER TABLE ONLY public.inwestorzy DROP CONSTRAINT pk_inwestorzy;
       public            postgres    false    226            �           2606    17146    inwestycje pk_inwestycje 
   CONSTRAINT     a   ALTER TABLE ONLY public.inwestycje
    ADD CONSTRAINT pk_inwestycje PRIMARY KEY (inwestycja_id);
 B   ALTER TABLE ONLY public.inwestycje DROP CONSTRAINT pk_inwestycje;
       public            postgres    false    216            �           2606    17180    pakiety pk_pakiety 
   CONSTRAINT     W   ALTER TABLE ONLY public.pakiety
    ADD CONSTRAINT pk_pakiety PRIMARY KEY (pakiet_id);
 <   ALTER TABLE ONLY public.pakiety DROP CONSTRAINT pk_pakiety;
       public            postgres    false    234            �           2606    17247    pracownicy pk_pracownicy 
   CONSTRAINT     `   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pk_pracownicy PRIMARY KEY (pracownik_id);
 B   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT pk_pracownicy;
       public            postgres    false    230            �           2606    17195    projekty pk_projekty 
   CONSTRAINT     Z   ALTER TABLE ONLY public.projekty
    ADD CONSTRAINT pk_projekty PRIMARY KEY (projekt_id);
 >   ALTER TABLE ONLY public.projekty DROP CONSTRAINT pk_projekty;
       public            postgres    false    224            �           2606    17235 *   projekty_inwestorzy pk_projekty_inwestorzy 
   CONSTRAINT     |   ALTER TABLE ONLY public.projekty_inwestorzy
    ADD CONSTRAINT pk_projekty_inwestorzy PRIMARY KEY (projekty_inwestorzy_id);
 T   ALTER TABLE ONLY public.projekty_inwestorzy DROP CONSTRAINT pk_projekty_inwestorzy;
       public            postgres    false    228            �           2606    17258 *   projekty_pracownicy pk_projekty_pracownicy 
   CONSTRAINT     z   ALTER TABLE ONLY public.projekty_pracownicy
    ADD CONSTRAINT pk_projekty_pracownicy PRIMARY KEY (projekt_pracownik_id);
 T   ALTER TABLE ONLY public.projekty_pracownicy DROP CONSTRAINT pk_projekty_pracownicy;
       public            postgres    false    232            �           2606    17174    stylistyka pk_stylistyka 
   CONSTRAINT     a   ALTER TABLE ONLY public.stylistyka
    ADD CONSTRAINT pk_stylistyka PRIMARY KEY (stylistyka_id);
 B   ALTER TABLE ONLY public.stylistyka DROP CONSTRAINT pk_stylistyka;
       public            postgres    false    218            �           2606    17178 $   zakresy_pakietow pk_zakresy_pakietow 
   CONSTRAINT     q   ALTER TABLE ONLY public.zakresy_pakietow
    ADD CONSTRAINT pk_zakresy_pakietow PRIMARY KEY (zakres_pakietu_id);
 N   ALTER TABLE ONLY public.zakresy_pakietow DROP CONSTRAINT pk_zakresy_pakietow;
       public            postgres    false    220            �           2606    17148 "   inwestycje unique_inwestycja_nazwa 
   CONSTRAINT     i   ALTER TABLE ONLY public.inwestycje
    ADD CONSTRAINT unique_inwestycja_nazwa UNIQUE (inwestycja_nazwa);
 L   ALTER TABLE ONLY public.inwestycje DROP CONSTRAINT unique_inwestycja_nazwa;
       public            postgres    false    216            �           2606    17176 "   stylistyka unique_stylistyka_nazwa 
   CONSTRAINT     i   ALTER TABLE ONLY public.stylistyka
    ADD CONSTRAINT unique_stylistyka_nazwa UNIQUE (stylistyka_nazwa);
 L   ALTER TABLE ONLY public.stylistyka DROP CONSTRAINT unique_stylistyka_nazwa;
       public            postgres    false    218            �           2606    17215    projekty fk_adresy    FK CONSTRAINT     y   ALTER TABLE ONLY public.projekty
    ADD CONSTRAINT fk_adresy FOREIGN KEY (adres_id) REFERENCES public.adresy(adres_id);
 <   ALTER TABLE ONLY public.projekty DROP CONSTRAINT fk_adresy;
       public          postgres    false    224    222    4781            �           2606    17229    inwestorzy fk_adresy    FK CONSTRAINT     {   ALTER TABLE ONLY public.inwestorzy
    ADD CONSTRAINT fk_adresy FOREIGN KEY (adres_id) REFERENCES public.adresy(adres_id);
 >   ALTER TABLE ONLY public.inwestorzy DROP CONSTRAINT fk_adresy;
       public          postgres    false    226    4781    222            �           2606    17252    pracownicy fk_adresy    FK CONSTRAINT     {   ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT fk_adresy FOREIGN KEY (adres_id) REFERENCES public.adresy(adres_id);
 >   ALTER TABLE ONLY public.pracownicy DROP CONSTRAINT fk_adresy;
       public          postgres    false    4781    222    230            �           2606    17241 !   projekty_inwestorzy fk_inwestorzy    FK CONSTRAINT     �   ALTER TABLE ONLY public.projekty_inwestorzy
    ADD CONSTRAINT fk_inwestorzy FOREIGN KEY (inwestor_id) REFERENCES public.inwestorzy(inwestor_id);
 K   ALTER TABLE ONLY public.projekty_inwestorzy DROP CONSTRAINT fk_inwestorzy;
       public          postgres    false    228    226    4785            �           2606    17210    projekty fk_inwestycje    FK CONSTRAINT     �   ALTER TABLE ONLY public.projekty
    ADD CONSTRAINT fk_inwestycje FOREIGN KEY (inwestycja_id) REFERENCES public.inwestycje(inwestycja_id);
 @   ALTER TABLE ONLY public.projekty DROP CONSTRAINT fk_inwestycje;
       public          postgres    false    4771    216    224            �           2606    17220    projekty fk_pakiety    FK CONSTRAINT     }   ALTER TABLE ONLY public.projekty
    ADD CONSTRAINT fk_pakiety FOREIGN KEY (pakiet_id) REFERENCES public.pakiety(pakiet_id);
 =   ALTER TABLE ONLY public.projekty DROP CONSTRAINT fk_pakiety;
       public          postgres    false    224    234    4793            �           2606    17264 !   projekty_pracownicy fk_pracownicy    FK CONSTRAINT     �   ALTER TABLE ONLY public.projekty_pracownicy
    ADD CONSTRAINT fk_pracownicy FOREIGN KEY (pracownik_id) REFERENCES public.pracownicy(pracownik_id);
 K   ALTER TABLE ONLY public.projekty_pracownicy DROP CONSTRAINT fk_pracownicy;
       public          postgres    false    230    232    4789            �           2606    17236    projekty_inwestorzy fk_projekty    FK CONSTRAINT     �   ALTER TABLE ONLY public.projekty_inwestorzy
    ADD CONSTRAINT fk_projekty FOREIGN KEY (projekt_id) REFERENCES public.projekty(projekt_id);
 I   ALTER TABLE ONLY public.projekty_inwestorzy DROP CONSTRAINT fk_projekty;
       public          postgres    false    224    4783    228            �           2606    17259    projekty_pracownicy fk_projekty    FK CONSTRAINT     �   ALTER TABLE ONLY public.projekty_pracownicy
    ADD CONSTRAINT fk_projekty FOREIGN KEY (projekt_id) REFERENCES public.projekty(projekt_id);
 I   ALTER TABLE ONLY public.projekty_pracownicy DROP CONSTRAINT fk_projekty;
       public          postgres    false    4783    232    224            �           2606    17205    projekty fk_stylistyka    FK CONSTRAINT     �   ALTER TABLE ONLY public.projekty
    ADD CONSTRAINT fk_stylistyka FOREIGN KEY (stylistyka_id) REFERENCES public.stylistyka(stylistyka_id);
 @   ALTER TABLE ONLY public.projekty DROP CONSTRAINT fk_stylistyka;
       public          postgres    false    4775    218    224            �           2606    17187    pakiety fk_zakresy_pakietow    FK CONSTRAINT     �   ALTER TABLE ONLY public.pakiety
    ADD CONSTRAINT fk_zakresy_pakietow FOREIGN KEY (zakres_pakietu_id) REFERENCES public.zakresy_pakietow(zakres_pakietu_id);
 E   ALTER TABLE ONLY public.pakiety DROP CONSTRAINT fk_zakresy_pakietow;
       public          postgres    false    4779    234    220            [   h  x��Z�n��]��"?���b���wp�H�1� ��t$¡E�EA�vc�|�`>û�������)��[J�"�A��U�ǩS��l�vެs�x�$˓I�p����a����D�I�'�z�������I�,Qg���,���N�o,����b�z�ٺ[�޼Lg��He^�ڐmM�x���b��Ʈ�)lʾ��M��
N��b"���kػvY�l�L+��e���$a�ͦ��?N�3��Zl�]�d� :��]����u�?�S��t��H�Ǉj���q��8g������ib�r�G|8�mۭ��]߸�g�^�D%2ʼd�ZX���7Kr@az{�L�'�
ٮ���]��Ȉ#�o�b������	G,�u�z�~�ޯkX#S���.mؕ�~���r�(gb��4
���uY���:�Hg;g���l�j=�,�ώta���m�m�������s�*К�	�l���ޮN����lZ�:}����Z�T,��$E_<�X�h�����W�H諵��Yh7'����we�o0�YF��ٻ��ۓ𔝷M]���uÌ�s	�QU*̀P�03��bnF<>�^}n�ߖ��`��S{����q3^�f=/��(��tOe������Zt�H$j�%D5��M�ƒ���_�6�ۥ`�v{߭]�9��=��%%�Pl��x����u�T�*���(�� ��[{����;�K0���c��A@g�m�?�%�+��f�~�ٶ�'�����3\�@���8�1F�D"�4؆�).�*�5#Z��\�[�8("�|�e՛J���l�wZ��:��;������t����U�*�r�'d� 7���N9��7��Cy�Ԟ�nF֋�-����m�i�KS���ǟ�@N�K�Z�'���m㦷оUD��9qas��FH������O�ݖ��>�*�6|���-��qWsZ���*zճ�����Pb#�Qd$X��vK_+�v�4"��}�����h��[řN1���嬟��B������{��ׄ�bZ�'Ѡ��C��=��H��`��a�:�0좜�����SیHX�uf�|��^*hj���=a�Sz���/�	��V����H���vZ�5��+�:V���Y�qS(�ZдEEUjh~I�3c��]�[�2��i�ā3O־����-���H�:OM��gi�)T��[D4�(eX��U,�螊����8���k�8ծ�<}&�K�A���Fj��ʃE�`2�:I`�ਫͼ��il���u"Ճ�%w���_n|!,��Y�S6X Աq,�4�`M6��78����d��f�L�^���0$�-l�� J�]�D��RB������z@B�b��i̦�k}���붙��u�[�CX���V���~�On�.�쪨m祐��8��!�9p�χX���z��#�3��*$=>�P�K	�Hl�LtXk�����L(��o�1&�P:��E������K��������wIG�
a3��/�1p���o��y�o�'���R,w��I���� �6�T�dȴ�jp������1�;��Sg��BB�DL�AYy���΀�lL�S�C�>��Qp���C���Y4�}fW����J�>��4���+|=��~d�b����\wZ/�Ah�>ۮ���oL�?��<z_ȡ��;!�?�D�9GW}����������|��O49���D���-^�"ritqH����:�+'.^��A�:�1`}NF��p>
k�j6;��Q����(0�!8���(;slm�Ł��c$wG�~�K��~a���\(�u/��K�}=��òkn�e�_�c��T���tS�خv5o7�Ye;�~{9B�q��k=-��B��b��|�BX����-NƑ�L�5�mF�k�Z�Dp:�/;wB,�&(�#�b8���<���~sbYbՓ� c��y�
�R��8h�_��m�\v�D�f�g�Z&j��tՇ��攔[�"�_N��f��Ϯ�:��֢�s޸+*%�%�3����0zc��ĳ� )�P�Kvag�.���E��1�W
�j�W��:"}�5t���E�� �\�mUb�&68~������r实���3����_���U>8՞<��Ј����)�<��������tN�q����ggg��f      _   *  x�}��n�F���O�`�����4�5��@ћ�(kR\�� �w5҇0�:�{�̒��I1� �r�;�͙#O,�.��ӳ<��nZ�{�b!�t9n�x�x�e��ʅ/|��s������wa�6B?
n|�3�g�ŬS�/�ҧg�)u�w�T�.�|�u!.Q �[�J1-�զև��b�Lq���r�B1�x���%��f������qY"1�*)V�MgN1�8n����~̽����H*L��TfҤx8v|�J�pi�Q�9��i��둚�I&\��X�om�Pw�껃�$���OU��m-w"�r�b�t[�[�Ơ݅2i��\��:��ry� �Y6uyH���N屩<�U�dӉ�닕h����h�eѹܩRܷ��m!ϼ����v�`D�Vx�A�u������?����譬ײ�����Þ��	lp<`D�d�G}~S���r��$�Ώ8�X���b�.��$�Q�X�5�Ɲtwz�9��gTn�jDosR�9�V�D�s>��6�+��;U�n����40�\;�h#��m},hH�Y_����`�)5��(Ô��Sb�s�v^�}���8}y�Br�:�=>��op�rhϧm%[�U�QR�U>�4�Á.�|&:�#a�J�QU��U�o��g��I�z�� l1m}�#�f��%�9n�(�{�}�=�m��W!�6��-k��NV�*�/:��ȍ(`�Ft�ҀGh\��\���Q.oD��4 %m��	X���fM����) �n�I���j��2E2I�f��qD���B ]O�����P�Zv|���f[����#��Z]n��GfGړ�t$��~M��*턲��X���|x����co�F7b�Ft�_�f�g���C�k�P#:��l�)�e�*�h�iD{�_���F]�$��e:$�>��t)��W��$��!K3��1�
K�X���I��!K4������?�~�K��2,��FY�C��6������duѳdlC�G�bZr�(�B������l���ƈ��릲X�Ia�ƞeQX�=:���ɷf�7�1�6KuH>v�;B��ik[Z��Ē����͓�W�6q���qȢ�h�;�vo�(qL��mʈ���x�l����U-b)�ȕl7�$7p�w��MD~���9�g_A~{�D���щX�]�u^�0KY6�)������t���:]��Q�ZW�2F�Rz����ʝ7���/�X�E��<��w>(�O~0bYGt0�Uj[Vh��lF,�N�v_��R�w�������q�
�ϥ����v̲�(�~o��kK1��F�X��z{ss�%�R#      U   .  x����n�0�g�~� �OI�%K�@�V�u��W�bG��V�<D��cǆ�*j*$���|�5#[���H�7�xC|�g�ye�2�s�`����I�j�*�B�-��O�齮d97{#$���(ˆnwB�̀��O(�T�8X;wW�MתLH+lL^Da.��3�і�6�t� 	p�?ҵ��-�<�ҥK7����$��Uq���|�w�>v&F��w�ӽϽ��z^ŵ��H���5��5tmU�'�$T�����/~��='�h�2�݈�'7��-�b��BQB-����u��?�P      g   �   x�}���0��3�����B!B��"�EپTe��?���u_;%�jv5D����_�����#�)R�"!]��D�Q^������}z�w	M�#1N��7�]CD�wׄ:�q�k�lVFm��0��UT�>n'u�:�9nㇶ���Ogb�1�~��p�      c   5  x���AN�0EדS��<�ة����B�tc�2	N�Et�����b������������e�]aai�����ИTH-��$�̄Dج��jm\���n�>AS8�(dc6K�,�	)�)���K�ɲr`k��4�0�@	���O��dԄ`튦���� )�;e^P����+�E��ԡ�;{p��>�`�x�I���ѱ̷�w9h5�Nam���C��h�J ����@��(�/�~��V ���,�n��yx���5�x^�ڶ��ͻ�a_�a�gQ���E�i}�k��$��o_��      ]   �  x��Z[��6��]E7p��3��
���hQ$E h��%tc��"%[f�\�k�{<|��r�˄�AƘw��)������ǟ~����O߾��O�mm��3�\~��Ï���|-ڗ�� �7�=�w)���!�[<��OQ?,?�����+p���� ��$�
�f ���2��/�� ��[��'�|ʵC0�������_�����|�c���t)���PAa ��:'@3��X�+��\A�oj�#�����K�A^�^�R�٭����Bb3'�p�,��Aϼ�Z�� ݨ�`U��܂�-�h�Ŵ	���m��Td��J)sE��Q����b+fw�"����**9��9�r�
�Ja�g�pTex�>os��S��:i�#��tt�
rTI������0�\�Kq�$D#�z.ŕ��>c&����Ę��E.���%[Q2|[8�D��ˇ�p����B"+ۘ�*=��
0�D.z9����4���£VZ�S��`:z�o��.�����\۩L��MMGV�SB�U�"�0N�W=ժ�R���F�K��GU��1e�
r>˨1�nr݁E���d����F7C�ĺ5sK3�uP)YKaB�fyʡ����K�,g͊GTU�"C�|I63�7���Z5Z�$�_�� ��*]��[]�#e)�@-#�Yꙸ�\i�Mvo:)�*�V���A��r�ݭ���b[�!k�j�,r�s���;�����7�&֖8���������h���<��Z��Y��l�l�_��`�Q[$:�r�3�c�vt&y�z�K~kY���n�+�W�-��yu���jZ:WeQ8�f�v��է��J��a,IU-p�s� #s6p�Z#�✴��&�^�q��ᯘ��d�	5叠n*�5�MU�@�OK����b�@®��D�:�:QN�QQ%�2�s�}w���"n�)��~laVC�:�8�v΍�u�5ξv��F���Z�1�l�g�ܺ�<�~񕎲V��s�B�Hd�J%�uv����r@v-�^BϤSY+�a�~��2����*W.�e#��	�����p_�G���"3\D�퀴���K�ؐU��Ҁ�ߤ��t۝�pF'6Z����ki>�z��8/�V�z�s(��"�T��b�0������g��w�ՑU��8`�7/Ȇ�æ��mKhiηPgDO{l�o&�'ljت��v�M},��[1��O�W�U!��	{���7��ؾa��\�?bہ�u^r��\*+��e><a0��^�U1�q�m��b��ϻ�\�3������sT�� ���4d����޿���ʾ*�����a�����vWW�@u�R'Ȁ�Y/MY;e�_�t'��n@s�Q5d���;Т�#�Z�P�� 6�b[$�Д{3m���a$ar+*�00���Za�a�y�ik5��Pue�3L\�����sڼp��z�JݏF}3m��SnD�G��PbG���T��G(a�S�H1�Z��X]��w�]�,����X\��[R�+	��x.�l�g�H��IU����Sp�֑^�m>���f�4�\��Nb�;�#�%��^����i����tj�4�n��^��Y�J�I�����n2�^�'[�6X�}Eǥ��P���N��Y�����^�s�^#}�4��8�H��^Ե�b����/�C�<MUY��8	��q�O381�H�H�D�.[PWĉ0�5ި%X�o���3d�0�
��>��64�ժt%�@�9��e.�W5Ŕm��`�	2��ڙq}e��^|?�N��"����h�;�/u��1R%�ckU�m�X�����W�|����gW�#����Rl[��lǔݴ�w>J;t�/�:ٯ�T�)��W�d.�Ϟ:�/��d}�� �*W
�sGQ�z2��jw	���JW�#�e�-N�ĄË�\u{1�7���:��N��R��~�tDF����f
k2��ր;Iz�Tx{�B�i
�������!jf      a     x����q$1�3'�M�.$%ʱ8�8m ����_w����k��?��O��0�	F�����RE��R��l��a$�o��V��H�U_�l{D�Ղˆ���e��zq�e�΂c�˞���˦�%��r���ǳi.'B=�2�3��g� ��K��tp/�M�s Cl:߹d�M'��S!%$��S!%d�H	ɽ�XH	ɽ�XH	�e�X�݌�ȱ��-�Xh	����-�����ʧoV�Я6ެbZ�UZH�R��T�,ն�
��:r��-�q9`ZB]K�ҳ�,��gi��T����>K{2NK�9�x�]C��������%�Bl|�)����]���-�Jl��R�%���NZ�?5�h	g[���p���9�k����d�zM!�'���/ٸ|�h	��%tN!�'㴄f��ഄ>V-�{����Z�3�񻬤LZ��a���+��/TXIt����vl񖕔IK��J�DK�l\�XeA���Z�e�r��kٖ���|>�5/�      e   �  x����m�0 ѳ\E�A��%�בIܳ�<x��C]O��.�M�����r>g�5^8��Isr��@�O|F�O����'�I�O����r��?d�Mu����찱0����[	���[#7��ʭ��1s�ac�:ˆ6���:���9vn'�c�^�9v�5l��Cg��[�ع��ڡ��F;��Y;��Y;��Y;��Y;��Y;��Y;��Y;��Y;�6v��v��v��v��v��v���v���v���v���v���v����3���a���a��a���a���a���a���a���a���aٙ����Y;����
���
�����vء�vء�vء�vء�v���v���P;l;���v��	��%����O�N�N�N�N����mc���pBg�p�g��R����y�^4!h      W      x���A�  ���~@(���^��f���������a�@��7Xm�A�AO/�V�WkF������{J��	~9�\G�@�H!c��sS�鼟jH�x0�g��*[���()�~s�%aO~F��9�O      Y   T   x�3�L�,�40A##]C]cC3++#=ssK.#���������b$3	:Ôg���s�L����� �X@�     