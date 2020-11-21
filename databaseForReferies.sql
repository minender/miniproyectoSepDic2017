--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.17
-- Dumped by pg_dump version 9.6.17

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

--
-- Name: userdb; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA userdb;


ALTER SCHEMA userdb OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: alias_list; Type: DOMAIN; Schema: userdb; Owner: postgres
--

CREATE DOMAIN userdb.alias_list AS text NOT NULL
	CONSTRAINT alias_list_check CHECK (((VALUE ~ '(^(([A-Z][a-z]*:(1|2)*),\s)*([A-Z][a-z]*:(1|2)*))$'::text) OR (VALUE ~~ ''::text)));


ALTER DOMAIN userdb.alias_list OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categoria; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.categoria (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE userdb.categoria OWNER TO userdb;

--
-- Name: categoria_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE userdb.categoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.categoria_id_seq OWNER TO userdb;

--
-- Name: categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE userdb.categoria_id_seq OWNED BY userdb.categoria.id;


--
-- Name: dispone; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.dispone (
    id integer NOT NULL,
    numerometateorema text,
    resuelto boolean DEFAULT false NOT NULL,
    loginusuario text NOT NULL,
    metateoremaid integer NOT NULL
);


ALTER TABLE userdb.dispone OWNER TO userdb;

--
-- Name: dispone_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE userdb.dispone_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.dispone_id_seq OWNER TO userdb;

--
-- Name: dispone_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE userdb.dispone_id_seq OWNED BY userdb.dispone.id;


--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE userdb.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.hibernate_sequence OWNER TO userdb;

--
-- Name: materia; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.materia (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE userdb.materia OWNER TO userdb;

--
-- Name: materia_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE userdb.materia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.materia_id_seq OWNER TO userdb;

--
-- Name: materia_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE userdb.materia_id_seq OWNED BY userdb.materia.id;


--
-- Name: metateorema; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.metateorema (
    id integer NOT NULL,
    enunciado text NOT NULL,
    metateoserializado bytea NOT NULL
);


ALTER TABLE userdb.metateorema OWNER TO userdb;

--
-- Name: metateorema_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE userdb.metateorema_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.metateorema_id_seq OWNER TO userdb;

--
-- Name: metateorema_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE userdb.metateorema_id_seq OWNED BY userdb.metateorema.id;


--
-- Name: simbolo; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.simbolo (
    id integer NOT NULL,
    notacion_latex text NOT NULL,
    argumentos integer,
    esinfijo boolean DEFAULT false NOT NULL,
    asociatividad integer,
    precedencia integer NOT NULL,
    notacion text NOT NULL,
    teoriaid integer NOT NULL
);


ALTER TABLE userdb.simbolo OWNER TO userdb;

--
-- Name: simbolo_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE userdb.simbolo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.simbolo_id_seq OWNER TO userdb;

--
-- Name: simbolo_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE userdb.simbolo_id_seq OWNED BY userdb.simbolo.id;


--
-- Name: mostrarcategoria; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.mostrarcategoria (
    id integer DEFAULT nextval('userdb.simbolo_id_seq'::regclass) NOT NULL,
    categoriaid integer NOT NULL,
    usuariologin text NOT NULL
);


ALTER TABLE userdb.mostrarcategoria OWNER TO userdb;

--
-- Name: mostrarcategoria_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE userdb.mostrarcategoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.mostrarcategoria_id_seq OWNER TO userdb;

--
-- Name: predicado; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.predicado (
    predicado text NOT NULL,
    alias text NOT NULL,
    login text NOT NULL,
    argumentos text NOT NULL,
    aliases userdb.alias_list NOT NULL,
    notacion text NOT NULL
);


ALTER TABLE userdb.predicado OWNER TO userdb;

--
-- Name: publicacion; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.publicacion (
    alias text,
    login text
);


ALTER TABLE userdb.publicacion OWNER TO userdb;

--
-- Name: resuelve; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.resuelve (
    id integer NOT NULL,
    nombreteorema text,
    numeroteorema text NOT NULL,
    resuelto boolean DEFAULT false NOT NULL,
    loginusuario text NOT NULL,
    teoremaid integer NOT NULL,
    categoriaid integer NOT NULL
);


ALTER TABLE userdb.resuelve OWNER TO userdb;

--
-- Name: resuelve_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE userdb.resuelve_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.resuelve_id_seq OWNER TO userdb;

--
-- Name: resuelve_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE userdb.resuelve_id_seq OWNED BY userdb.resuelve.id;


--
-- Name: solucion; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.solucion (
    id integer NOT NULL,
    resuelveid integer NOT NULL,
    resuelto boolean DEFAULT false NOT NULL,
    demostracion text NOT NULL,
    metodo text NOT NULL
);


ALTER TABLE userdb.solucion OWNER TO userdb;

--
-- Name: solucion_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE userdb.solucion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.solucion_id_seq OWNER TO userdb;

--
-- Name: solucion_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE userdb.solucion_id_seq OWNED BY userdb.solucion.id;


--
-- Name: teorema; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.teorema (
    id integer NOT NULL,
    enunciado text NOT NULL,
    esquema boolean NOT NULL,
    aliases userdb.alias_list NOT NULL
);


ALTER TABLE userdb.teorema OWNER TO userdb;

--
-- Name: teorema_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE userdb.teorema_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.teorema_id_seq OWNER TO userdb;

--
-- Name: teorema_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE userdb.teorema_id_seq OWNED BY userdb.teorema.id;


--
-- Name: teoria; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.teoria (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE userdb.teoria OWNER TO userdb;

--
-- Name: teoria_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE userdb.teoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.teoria_id_seq OWNER TO userdb;

--
-- Name: teoria_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE userdb.teoria_id_seq OWNED BY userdb.teoria.id;


--
-- Name: termino; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.termino (
    combinador text NOT NULL,
    serializado bytea NOT NULL,
    alias text NOT NULL,
    login text NOT NULL
);


ALTER TABLE userdb.termino OWNER TO userdb;

--
-- Name: usuario; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.usuario (
    login text NOT NULL,
    nombre text NOT NULL,
    apellido text NOT NULL,
    correo text NOT NULL,
    password text NOT NULL,
    materiaid integer NOT NULL,
    admin boolean DEFAULT false NOT NULL
);


ALTER TABLE userdb.usuario OWNER TO userdb;

--
-- Name: categoria id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.categoria ALTER COLUMN id SET DEFAULT nextval('userdb.categoria_id_seq'::regclass);


--
-- Name: dispone id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.dispone ALTER COLUMN id SET DEFAULT nextval('userdb.dispone_id_seq'::regclass);


--
-- Name: metateorema id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.metateorema ALTER COLUMN id SET DEFAULT nextval('userdb.metateorema_id_seq'::regclass);


--
-- Name: resuelve id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.resuelve ALTER COLUMN id SET DEFAULT nextval('userdb.resuelve_id_seq'::regclass);


--
-- Name: simbolo id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.simbolo ALTER COLUMN id SET DEFAULT nextval('userdb.simbolo_id_seq'::regclass);


--
-- Name: solucion id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.solucion ALTER COLUMN id SET DEFAULT nextval('userdb.solucion_id_seq'::regclass);


--
-- Name: teorema id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.teorema ALTER COLUMN id SET DEFAULT nextval('userdb.teorema_id_seq'::regclass);


--
-- Name: teoria id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.teoria ALTER COLUMN id SET DEFAULT nextval('userdb.teoria_id_seq'::regclass);


--
-- Data for Name: categoria; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.categoria (id, nombre) FROM stdin;
1	Equivalence and true
2	Negación Inequivalence and false
3	Disjunction
4	Conjunction
5	Implication
6	Leibniz as an Axiom
\.


--
-- Name: categoria_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.categoria_id_seq', 6, true);


--
-- Data for Name: dispone; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.dispone (id, numerometateorema, resuelto, loginusuario, metateoremaid) FROM stdin;
\.


--
-- Name: dispone_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.dispone_id_seq', 1, false);


--
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.hibernate_sequence', 1, false);


--
-- Data for Name: materia; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.materia (id, nombre) FROM stdin;
1	Symbolic Logic
\.


--
-- Name: materia_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.materia_id_seq', 1, true);


--
-- Data for Name: metateorema; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.metateorema (id, enunciado, metateoserializado) FROM stdin;
\.


--
-- Name: metateorema_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.metateorema_id_seq', 1, false);


--
-- Data for Name: mostrarcategoria; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.mostrarcategoria (id, categoriaid, usuariologin) FROM stdin;
8	5	AdminTeoremas
14	1	teacher1
\.


--
-- Name: mostrarcategoria_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.mostrarcategoria_id_seq', 14, true);


--
-- Data for Name: predicado; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.predicado (predicado, alias, login, argumentos, aliases, notacion) FROM stdin;
\.


--
-- Data for Name: publicacion; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.publicacion (alias, login) FROM stdin;
\.


--
-- Data for Name: resuelve; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.resuelve (id, nombreteorema, numeroteorema, resuelto, loginusuario, teoremaid, categoriaid) FROM stdin;
1	Associativity of $\\equiv$	3.1	t	AdminTeoremas	1	1
2	Symmetry of $\\equiv$	3.2.a	t	AdminTeoremas	2	1
3	Symmetry of $\\equiv$	3.2.b	f	AdminTeoremas	3	1
4	Symmetry of $\\equiv$	3.2.c	f	AdminTeoremas	4	1
5	Symmetry of $\\equiv$	3.2.d	f	AdminTeoremas	5	1
6	Symmetry of $\\equiv$	3.2.e	f	AdminTeoremas	6	1
7	Identity of $\\equiv$	3.3.a	t	AdminTeoremas	7	1
8	Identity of $\\equiv$	3.3.b	f	AdminTeoremas	8	1
9		3.4	f	AdminTeoremas	9	1
10	Reflexivity of $\\equiv$	3.5	f	AdminTeoremas	10	1
11	Definition of $false$	3.8	t	AdminTeoremas	11	2
12	Distributivity of $\\neg$ over $\\equiv$	3.9	t	AdminTeoremas	12	2
13	Definition of $\\not\\equiv$	3.10	t	AdminTeoremas	13	2
14		3.11	f	AdminTeoremas	14	2
15	Double negation	3.12	f	AdminTeoremas	15	2
16	Negation of $false$	3.13	f	AdminTeoremas	16	2
17		3.14	f	AdminTeoremas	17	2
18		3.15	f	AdminTeoremas	18	2
19	Symmetry of $\\not\\equiv$	3.16	f	AdminTeoremas	19	2
20	Associativity of $\\not\\equiv$	3.17	f	AdminTeoremas	20	2
21	Mutual associativity	3.18	f	AdminTeoremas	21	2
22	Mutual interchangeability	3.19	f	AdminTeoremas	22	2
23	Symmetry of $\\vee$	3.24	t	AdminTeoremas	23	3
24	Associativity of $\\vee$	3.25	t	AdminTeoremas	24	3
25	Idempotency of $\\vee$	3.26	t	AdminTeoremas	25	3
26	Distributivity of $\\vee$ over $\\equiv$	3.27	t	AdminTeoremas	26	3
27	Excluded Middle	3.28	t	AdminTeoremas	27	3
28	Zero of $\\vee$	3.29	f	AdminTeoremas	28	3
29	Identity of $\\vee$	3.30	f	AdminTeoremas	29	3
30	Distributivity of $\\vee$ over $\\vee$	3.31	f	AdminTeoremas	30	3
31		3.32.a	f	AdminTeoremas	31	3
32		3.32.b	f	AdminTeoremas	32	3
33	Golden rule	3.35.a	t	AdminTeoremas	33	4
34	Golden rule	3.35.b	f	AdminTeoremas	34	4
35	Golden rule	3.35.c	f	AdminTeoremas	35	4
36	Golden rule	3.35.d	f	AdminTeoremas	36	4
37	Symmetry of $\\wedge$	3.36	f	AdminTeoremas	37	4
38	Associativity of $\\wedge$	3.37	f	AdminTeoremas	38	4
39	Idempotency of $\\wedge$	3.38	f	AdminTeoremas	39	4
40	Identity of $\\wedge$	3.39	f	AdminTeoremas	40	4
41	Zero of $\\wedge$	3.40	f	AdminTeoremas	41	4
42	Distributivity of $\\wedge$ over $\\wedge$	3.41	f	AdminTeoremas	42	4
43	Contradiction	3.42	f	AdminTeoremas	43	4
44	Absorption	3.43.a	f	AdminTeoremas	44	4
45	Absorption	3.43.b	f	AdminTeoremas	45	4
46	Absorption	3.44.a	f	AdminTeoremas	46	4
47	Absorption	3.44.b	f	AdminTeoremas	47	4
48	Distributivity of $\\vee$ over $\\wedge$	3.45	f	AdminTeoremas	48	4
49	Distributivity of $\\wedge$ over $\\vee$	3.46	f	AdminTeoremas	49	4
50	De Morgan	3.47.a	f	AdminTeoremas	50	4
51	De Morgan	3.47.b	f	AdminTeoremas	51	4
52		3.48.a	f	AdminTeoremas	52	4
53		3.48.b	f	AdminTeoremas	53	4
54		3.49.a	f	AdminTeoremas	54	4
55		3.49.b	f	AdminTeoremas	55	4
56		3.49.c	f	AdminTeoremas	56	4
57		3.49.d	f	AdminTeoremas	57	4
58		3.50	f	AdminTeoremas	58	4
59	Replacement	3.51	f	AdminTeoremas	59	4
61	Exclusive or	3.53	f	AdminTeoremas	61	4
62	Leibniz	3.83	t	AdminTeoremas	62	6
63	Substitution	3.84.a	f	AdminTeoremas	63	6
64	Substitution	3.84.b	f	AdminTeoremas	64	6
65	Substitution	3.84.c	f	AdminTeoremas	65	6
66	Replace by $true$	3.85.a	f	AdminTeoremas	66	6
67	Replace by $true$	3.85.b	f	AdminTeoremas	67	6
68	Replace by $false$	3.86.a	f	AdminTeoremas	68	6
69	Replace by $false$	3.86.b	f	AdminTeoremas	69	6
70	Replace by $true$	3.87	f	AdminTeoremas	70	6
71	Replace by $false$	3.88	f	AdminTeoremas	71	6
72	Shannon	3.89	f	AdminTeoremas	72	6
73		4.1	f	AdminTeoremas	73	6
74	Monotonicity of $\\vee$	4.2	f	AdminTeoremas	74	6
75	Monotonicity of $\\wedge$	4.3	f	AdminTeoremas	75	6
76	Definition of Implication	3.57	t	AdminTeoremas	76	5
77	Consequence	3.58	t	AdminTeoremas	77	5
78	Definition of Implication	3.59	f	AdminTeoremas	78	5
79	Definition of Implication	3.60	f	AdminTeoremas	79	5
80	Contrapositive	3.61	f	AdminTeoremas	80	5
60	Definition of $\\equiv$	3.52	f	AdminTeoremas	60	4
81		3.62	f	AdminTeoremas	81	5
82	Distributivity of $\\Rightarrow$ over $\\equiv$	3.63	f	AdminTeoremas	82	5
83		3.64	f	AdminTeoremas	83	5
84	Shunting	3.65	f	AdminTeoremas	84	5
85		3.66	f	AdminTeoremas	85	5
86		3.67	f	AdminTeoremas	86	5
87		3.68	f	AdminTeoremas	87	5
88		3.69	f	AdminTeoremas	88	5
89		3.70	f	AdminTeoremas	89	5
90	Reflexivity of $\\Rightarrow$	3.71	f	AdminTeoremas	90	5
91	Right  zero of $\\Rightarrow$	3.72	f	AdminTeoremas	91	5
92	Left identity of $\\Rightarrow$	3.73	f	AdminTeoremas	92	5
93		3.74	f	AdminTeoremas	93	5
94		3.75	f	AdminTeoremas	94	5
95	Weakening/strengthening	3.76.a	f	AdminTeoremas	95	5
96	Weakening/strengthening	3.76.b	f	AdminTeoremas	96	5
97	Weakening/strengthening	3.76.c	f	AdminTeoremas	97	5
98	Weakening/strengthening	3.76.d	f	AdminTeoremas	98	5
99	Weakening/strengthening	3.76.e	f	AdminTeoremas	99	5
100	Modus ponens	3.77	f	AdminTeoremas	100	5
101		3.78	f	AdminTeoremas	101	5
102		3.79	f	AdminTeoremas	102	5
103	Mutual implication	3.80	f	AdminTeoremas	103	5
104	Antisymmetry	3.81	f	AdminTeoremas	104	5
105	Transitivity	3.82.a	f	AdminTeoremas	105	5
106	Transitivity	3.82.b	f	AdminTeoremas	106	5
107	Transitivity	3.82.c	f	AdminTeoremas	107	5
108	Associativity of $\\equiv$	3.1	t	teacher1	1	1
109		3.4	f	teacher1	9	1
110	Reflexivity of $\\equiv$	3.5	f	teacher1	10	1
111	Definition of $false$	3.8	t	teacher1	11	2
112	Distributivity of $\\neg$ over $\\equiv$	3.9	t	teacher1	12	2
113		4.1	f	teacher1	73	6
114	Monotonicity of $\\vee$	4.2	f	teacher1	74	6
115	Monotonicity of $\\wedge$	4.3	f	teacher1	75	6
116	Definition of $\\not\\equiv$	3.10	t	teacher1	13	2
117		3.11	f	teacher1	14	2
118	Double negation	3.12	f	teacher1	15	2
119	Negation of $false$	3.13	f	teacher1	16	2
120		3.14	f	teacher1	17	2
121		3.15	f	teacher1	18	2
122	Symmetry of $\\not\\equiv$	3.16	f	teacher1	19	2
123	Associativity of $\\not\\equiv$	3.17	f	teacher1	20	2
124	Mutual associativity	3.18	f	teacher1	21	2
125	Mutual interchangeability	3.19	f	teacher1	22	2
126	Symmetry of $\\vee$	3.24	t	teacher1	23	3
127	Associativity of $\\vee$	3.25	t	teacher1	24	3
128	Idempotency of $\\vee$	3.26	t	teacher1	25	3
129	Distributivity of $\\vee$ over $\\equiv$	3.27	t	teacher1	26	3
130	Excluded Middle	3.28	t	teacher1	27	3
131	Zero of $\\vee$	3.29	f	teacher1	28	3
132	Identity of $\\vee$	3.30	f	teacher1	29	3
133	Distributivity of $\\vee$ over $\\vee$	3.31	f	teacher1	30	3
134	Symmetry of $\\wedge$	3.36	f	teacher1	37	4
135	Associativity of $\\wedge$	3.37	f	teacher1	38	4
136	Idempotency of $\\wedge$	3.38	f	teacher1	39	4
137	Identity of $\\wedge$	3.39	f	teacher1	40	4
138	Zero of $\\wedge$	3.40	f	teacher1	41	4
139	Distributivity of $\\wedge$ over $\\wedge$	3.41	f	teacher1	42	4
140	Contradiction	3.42	f	teacher1	43	4
141	Distributivity of $\\vee$ over $\\wedge$	3.45	f	teacher1	48	4
142	Distributivity of $\\wedge$ over $\\vee$	3.46	f	teacher1	49	4
143		3.50	f	teacher1	58	4
144	Replacement	3.51	f	teacher1	59	4
145	Definition of $\\equiv$	3.52	f	teacher1	60	4
146	Exclusive or	3.53	f	teacher1	61	4
147	Definition of Implication	3.57	t	teacher1	76	5
148	Consequence	3.58	t	teacher1	77	5
149	Definition of Implication	3.59	f	teacher1	78	5
150	Definition of Implication	3.60	f	teacher1	79	5
151	Contrapositive	3.61	f	teacher1	80	5
152		3.62	f	teacher1	81	5
153	Distributivity of $\\Rightarrow$ over $\\equiv$	3.63	f	teacher1	82	5
154		3.64	f	teacher1	83	5
155	Shunting	3.65	f	teacher1	84	5
156		3.66	f	teacher1	85	5
157		3.67	f	teacher1	86	5
158		3.68	f	teacher1	87	5
159		3.69	f	teacher1	88	5
160		3.70	f	teacher1	89	5
161	Reflexivity of $\\Rightarrow$	3.71	f	teacher1	90	5
162	Right  zero of $\\Rightarrow$	3.72	f	teacher1	91	5
163	Left identity of $\\Rightarrow$	3.73	f	teacher1	92	5
164		3.74	f	teacher1	93	5
165		3.75	f	teacher1	94	5
166	Modus ponens	3.77	f	teacher1	100	5
167		3.78	f	teacher1	101	5
168		3.79	f	teacher1	102	5
169	Mutual implication	3.80	f	teacher1	103	5
170	Antisymmetry	3.81	f	teacher1	104	5
171	Leibniz	3.83	t	teacher1	62	6
172	Replace by $true$	3.87	f	teacher1	70	6
173	Replace by $false$	3.88	f	teacher1	71	6
174	Shannon	3.89	f	teacher1	72	6
175	Symmetry of $\\equiv$	3.2.a	t	teacher1	2	1
176	Symmetry of $\\equiv$	3.2.b	f	teacher1	3	1
177	Symmetry of $\\equiv$	3.2.c	f	teacher1	4	1
178	Symmetry of $\\equiv$	3.2.d	f	teacher1	5	1
179	Symmetry of $\\equiv$	3.2.e	f	teacher1	6	1
180	Identity of $\\equiv$	3.3.a	t	teacher1	7	1
181	Identity of $\\equiv$	3.3.b	f	teacher1	8	1
182		3.32.a	f	teacher1	31	3
183		3.32.b	f	teacher1	32	3
184	Golden rule	3.35.a	t	teacher1	33	4
185	Golden rule	3.35.b	f	teacher1	34	4
186	Golden rule	3.35.c	f	teacher1	35	4
187	Golden rule	3.35.d	f	teacher1	36	4
188	Absorption	3.43.a	f	teacher1	44	4
189	Absorption	3.43.b	f	teacher1	45	4
190	Absorption	3.44.a	f	teacher1	46	4
191	Absorption	3.44.b	f	teacher1	47	4
192	De Morgan	3.47.a	f	teacher1	50	4
193	De Morgan	3.47.b	f	teacher1	51	4
194		3.48.a	f	teacher1	52	4
195		3.48.b	f	teacher1	53	4
196		3.49.a	f	teacher1	54	4
197		3.49.b	f	teacher1	55	4
198		3.49.c	f	teacher1	56	4
199		3.49.d	f	teacher1	57	4
200	Weakening/strengthening	3.76.a	f	teacher1	95	5
201	Weakening/strengthening	3.76.b	f	teacher1	96	5
202	Weakening/strengthening	3.76.c	f	teacher1	97	5
203	Weakening/strengthening	3.76.d	f	teacher1	98	5
204	Weakening/strengthening	3.76.e	f	teacher1	99	5
205	Transitivity	3.82.a	f	teacher1	105	5
206	Transitivity	3.82.b	f	teacher1	106	5
207	Transitivity	3.82.c	f	teacher1	107	5
208	Substitution	3.84.a	f	teacher1	63	6
209	Substitution	3.84.b	f	teacher1	64	6
210	Substitution	3.84.c	f	teacher1	65	6
211	Replace by $true$	3.85.a	f	teacher1	66	6
212	Replace by $true$	3.85.b	f	teacher1	67	6
213	Replace by $false$	3.86.a	f	teacher1	68	6
214	Replace by $false$	3.86.b	f	teacher1	69	6
\.


--
-- Name: resuelve_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.resuelve_id_seq', 214, true);


--
-- Data for Name: simbolo; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) FROM stdin;
7	\\neg	1	f	1	5	%(op) %(aa1)	1
8	true	0	f	0	0	%(op)	1
9	false	0	f	0	0	%(op)	1
3	\\Leftarrow	2	t	2	2	%(aa2) %(op) %(aa1)	1
10		2	f	3	7	%(a1)^z_{%(na2)}	1
1	\\equiv	2	t	3	1	%(a2) %(op) %(a1)	1
6	\\not\\equiv	2	t	3	4	%(a2) %(op) %(a1)	1
4	\\vee	2	t	3	3	%(a2) %(op) %(a1)	1
5	\\wedge	2	t	3	3	%(a2) %(op) %(a1)	1
2	\\Rightarrow	2	t	1	2	%(a2) %(op) %(aa1)	1
\.


--
-- Name: simbolo_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.simbolo_id_seq', 10, true);


--
-- Data for Name: solucion; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.solucion (id, resuelveid, resuelto, demostracion, metodo) FROM stdin;
\.


--
-- Name: solucion_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.solucion_id_seq', 1, false);


--
-- Data for Name: teorema; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.teorema (id, enunciado, esquema, aliases) FROM stdin;
1	c_{1} (c_{1} (c_{1} x_{114} x_{113}) x_{112}) (c_{1} x_{114} (c_{1} x_{113} x_{112}))	f	
2	c_{1} (c_{1} x_{112} x_{113}) (c_{1} x_{113} x_{112})	f	
3	c_{1} (c_{1} x_{112} (c_{1} x_{113} x_{113})) x_{112}	f	
4	c_{1} (c_{1} (c_{1} x_{112} x_{113}) x_{113}) x_{112}	f	
5	c_{1} x_{112} (c_{1} x_{113} (c_{1} x_{113} x_{112}))	f	
6	c_{1} x_{112} (c_{1} (c_{1} x_{113} x_{113}) x_{112})	f	
7	c_{1} (c_{1} x_{113} x_{113}) c_{8}	f	
8	c_{1} x_{113} (c_{1} x_{113} c_{8})	f	
9	c_{8}	f	
10	c_{1} x_{112} x_{112}	f	
11	c_{1} (c_{7} c_{8}) c_{9}	f	
12	c_{1} (c_{1} x_{113} (c_{7} x_{112})) (c_{7} (c_{1} x_{113} x_{112}))	f	
13	c_{1} (c_{7} (c_{1} x_{113} x_{112})) (c_{6} x_{113} x_{112})	f	
14	c_{1} (c_{1} (c_{7} x_{113}) x_{112}) (c_{1} x_{113} (c_{7} x_{112}))	f	
15	c_{1} x_{112} (c_{7} (c_{7} x_{112}))	f	
16	c_{1} c_{8} (c_{7} c_{9})	f	
17	c_{1} (c_{1} x_{113} (c_{7} x_{112})) (c_{6} x_{113} x_{112})	f	
18	c_{1} (c_{1} c_{9} x_{112}) (c_{7} x_{112})	f	
19	c_{1} (c_{6} x_{112} x_{113}) (c_{6} x_{113} x_{112})	f	
20	c_{1} (c_{6} (c_{6} x_{114} x_{113}) x_{112}) (c_{6} x_{114} (c_{6} x_{113} x_{112}))	f	
21	c_{1} (c_{6} (c_{1} x_{114} x_{113}) x_{112}) (c_{1} x_{114} (c_{6} x_{113} x_{112}))	f	
22	c_{1} (c_{1} (c_{6} x_{114} x_{113}) x_{112}) (c_{1} x_{114} (c_{6} x_{113} x_{112}))	f	
23	c_{1} (c_{4} x_{112} x_{113}) (c_{4} x_{113} x_{112})	f	
24	c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{4} x_{114} (c_{4} x_{113} x_{112}))	f	
25	c_{1} x_{112} (c_{4} x_{112} x_{112})	f	
26	c_{1} (c_{1} (c_{4} x_{114} x_{112}) (c_{4} x_{113} x_{112})) (c_{4} (c_{1} x_{114} x_{113}) x_{112})	f	
27	c_{4} (c_{7} x_{112}) x_{112}	f	
28	c_{1} c_{8} (c_{4} c_{8} x_{112})	f	
29	c_{1} x_{112} (c_{4} c_{9} x_{112})	f	
30	c_{1} (c_{4} (c_{4} x_{114} x_{112}) (c_{4} x_{113} x_{112})) (c_{4} (c_{4} x_{114} x_{113}) x_{112})	f	
31	c_{1} (c_{1} x_{112} (c_{4} (c_{7} x_{113}) x_{112})) (c_{4} x_{113} x_{112})	f	
32	c_{1} x_{112} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112}))	f	
33	c_{1} (c_{1} (c_{1} (c_{4} x_{113} x_{112}) x_{113}) x_{112}) (c_{5} x_{113} x_{112})	f	
34	c_{1} (c_{1} (c_{4} x_{113} x_{112}) (c_{1} x_{113} x_{112})) (c_{5} x_{113} x_{112})	f	
35	c_{1} (c_{4} x_{113} x_{112}) (c_{1} (c_{1} x_{113} x_{112}) (c_{5} x_{113} x_{112}))	f	
36	c_{1} (c_{4} x_{113} x_{112}) (c_{1} x_{113} (c_{1} x_{112} (c_{5} x_{113} x_{112})))	f	
37	c_{1} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{112})	f	
38	c_{1} (c_{5} (c_{5} x_{114} x_{113}) x_{112}) (c_{5} x_{114} (c_{5} x_{113} x_{112}))	f	
39	c_{1} x_{112} (c_{5} x_{112} x_{112})	f	
40	c_{1} x_{112} (c_{5} c_{8} x_{112})	f	
41	c_{1} c_{9} (c_{5} c_{9} x_{112})	f	
42	c_{1} (c_{5} (c_{5} x_{114} x_{112}) (c_{5} x_{113} x_{112})) (c_{5} (c_{5} x_{114} x_{113}) x_{112})	f	
43	c_{1} c_{9} (c_{5} (c_{7} x_{112}) x_{112})	f	
44	c_{1} x_{112} (c_{5} (c_{4} x_{113} x_{112}) x_{112})	f	
45	c_{1} x_{112} (c_{4} (c_{5} x_{113} x_{112}) x_{112})	f	
46	c_{1} (c_{5} x_{113} x_{112}) (c_{5} (c_{4} x_{113} (c_{7} x_{112})) x_{112})	f	
47	c_{1} (c_{4} x_{113} x_{112}) (c_{4} (c_{5} x_{113} (c_{7} x_{112})) x_{112})	f	
48	c_{1} (c_{5} (c_{4} x_{114} x_{112}) (c_{4} x_{113} x_{112})) (c_{4} (c_{5} x_{114} x_{113}) x_{112})	f	
49	c_{1} (c_{4} (c_{5} x_{114} x_{112}) (c_{5} x_{113} x_{112})) (c_{5} (c_{4} x_{114} x_{113}) x_{112})	f	
50	c_{1} (c_{4} (c_{7} x_{113}) (c_{7} x_{112})) (c_{7} (c_{5} x_{113} x_{112}))	f	
51	c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{7} (c_{4} x_{113} x_{112}))	f	
52	c_{1} (c_{1} (c_{7} x_{112}) (c_{5} (c_{7} x_{113}) x_{112})) (c_{5} x_{113} x_{112})	f	
53	c_{1} (c_{7} x_{112}) (c_{1} (c_{5} (c_{7} x_{113}) x_{112}) (c_{5} x_{113} x_{112}))	f	
54	c_{1} (c_{1} (c_{1} x_{112} (c_{5} x_{114} x_{112})) (c_{5} x_{113} x_{112})) (c_{5} (c_{1} x_{114} x_{113}) x_{112})	f	
55	c_{1} (c_{1} x_{112} (c_{1} (c_{5} x_{114} x_{112}) (c_{5} x_{113} x_{112}))) (c_{5} (c_{1} x_{114} x_{113}) x_{112})	f	
56	c_{1} x_{112} (c_{1} (c_{1} (c_{5} x_{114} x_{112}) (c_{5} x_{113} x_{112})) (c_{5} (c_{1} x_{114} x_{113}) x_{112}))	f	
57	c_{1} x_{112} (c_{1} (c_{5} x_{114} x_{112}) (c_{1} (c_{5} x_{113} x_{112}) (c_{5} (c_{1} x_{114} x_{113}) x_{112})))	f	
58	c_{1} (c_{5} x_{113} x_{112}) (c_{5} (c_{1} x_{112} x_{113}) x_{112})	f	
59	c_{1} (c_{5} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{5} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112}))	f	
60	c_{1} (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})) (c_{1} x_{113} x_{112})	f	
61	c_{1} (c_{4} (c_{5} (c_{7} x_{113}) x_{112}) (c_{5} x_{113} (c_{7} x_{112}))) (c_{6} x_{113} x_{112})	f	
62	c_{2} (c_{1} (x_{69} x_{102}) (x_{69} x_{101})) (c_{1} x_{102} x_{101})	f	
63	c_{1} (c_{5} (x_{69} x_{102}) (c_{1} x_{102} x_{101})) (c_{5} (x_{69} x_{101}) (c_{1} x_{102} x_{101}))	f	
64	c_{1} (c_{2} (x_{69} x_{102}) (c_{1} x_{102} x_{101})) (c_{2} (x_{69} x_{101}) (c_{1} x_{102} x_{101}))	f	
65	c_{1} (c_{2} (x_{69} x_{102}) (c_{5} (c_{1} x_{102} x_{101}) x_{113})) (c_{2} (x_{69} x_{101}) (c_{5} (c_{1} x_{102} x_{101}) x_{113}))	f	
66	c_{1} (c_{2} (x_{69} c_{8}) x_{112}) (c_{2} (x_{69} x_{112}) x_{112})	f	
67	c_{1} (c_{2} (x_{69} c_{8}) (c_{5} x_{112} x_{113})) (c_{2} (x_{69} x_{112}) (c_{5} x_{112} x_{113}))	f	
68	c_{1} (c_{2} x_{112} (x_{69} c_{9})) (c_{2} x_{112} (x_{69} x_{112}))	f	
69	c_{1} (c_{2} (c_{4} x_{113} x_{112}) (x_{69} c_{9})) (c_{2} (c_{4} x_{113} x_{112}) (x_{69} x_{112}))	f	
70	c_{1} (c_{5} (x_{69} c_{8}) x_{112}) (c_{5} (x_{69} x_{112}) x_{112})	f	
71	c_{1} (c_{4} (x_{69} c_{9}) x_{112}) (c_{4} (x_{69} x_{112}) x_{112})	f	
72	c_{1} (c_{4} (c_{5} (x_{69} c_{9}) (c_{7} x_{112})) (c_{5} (x_{69} c_{8}) x_{112})) (x_{69} x_{112})	f	
73	c_{2} (c_{2} x_{112} x_{113}) x_{112}	f	
74	c_{2} (c_{2} (c_{4} x_{114} x_{113}) (c_{4} x_{114} x_{112})) (c_{2} x_{113} x_{112})	f	
75	c_{2} (c_{2} (c_{5} x_{114} x_{113}) (c_{5} x_{114} x_{112})) (c_{2} x_{113} x_{112})	f	
76	c_{1} (c_{1} x_{113} (c_{4} x_{113} x_{112})) (c_{2} x_{113} x_{112})	f	
77	c_{1} (c_{2} x_{112} x_{113}) (c_{3} x_{113} x_{112})	f	
78	c_{1} (c_{4} x_{113} (c_{7} x_{112})) (c_{2} x_{113} x_{112})	f	
79	c_{1} (c_{1} x_{112} (c_{5} x_{113} x_{112})) (c_{2} x_{113} x_{112})	f	
80	c_{1} (c_{2} (c_{7} x_{112}) (c_{7} x_{113})) (c_{2} x_{113} x_{112})	f	
81	c_{1} (c_{1} (c_{5} x_{114} x_{112}) (c_{5} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})	f	
82	c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})	f	
83	c_{1} (c_{2} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{2} x_{114} x_{113}) x_{112})	f	
84	c_{1} (c_{2} (c_{2} x_{114} x_{113}) x_{112}) (c_{2} x_{114} (c_{5} x_{113} x_{112}))	f	
85	c_{1} (c_{5} x_{113} x_{112}) (c_{5} (c_{2} x_{113} x_{112}) x_{112})	f	
86	c_{1} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112})	f	
87	c_{1} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112})	f	
88	c_{1} (c_{2} x_{112} x_{113}) (c_{4} (c_{2} x_{112} x_{113}) x_{112})	f	
89	c_{1} (c_{1} x_{113} x_{112}) (c_{2} (c_{5} x_{113} x_{112}) (c_{4} x_{113} x_{112}))	f	
90	c_{1} c_{8} (c_{2} x_{112} x_{112})	f	
91	c_{1} c_{8} (c_{2} c_{8} x_{112})	f	
92	c_{1} x_{112} (c_{2} x_{112} c_{8})	f	
93	c_{1} (c_{7} x_{112}) (c_{2} c_{9} x_{112})	f	
94	c_{1} c_{8} (c_{2} x_{112} c_{9})	f	
95	c_{2} (c_{4} x_{113} x_{112}) x_{112}	f	
96	c_{2} x_{112} (c_{5} x_{113} x_{112})	f	
97	c_{2} (c_{4} x_{113} x_{112}) (c_{5} x_{113} x_{112})	f	
98	c_{2} (c_{4} x_{113} x_{112}) (c_{4} (c_{5} x_{114} x_{113}) x_{112})	f	
99	c_{2} (c_{5} (c_{4} x_{114} x_{113}) x_{112}) (c_{5} x_{113} x_{112})	f	
100	c_{2} x_{113} (c_{5} (c_{2} x_{113} x_{112}) x_{112})	f	
101	c_{1} (c_{2} x_{114} (c_{4} x_{113} x_{112})) (c_{5} (c_{2} x_{114} x_{113}) (c_{2} x_{114} x_{112}))	f	
102	c_{1} x_{114} (c_{5} (c_{2} x_{114} (c_{7} x_{112})) (c_{2} x_{114} x_{112}))	f	
103	c_{1} (c_{1} x_{113} x_{112}) (c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112}))	f	
104	c_{2} (c_{1} x_{113} x_{112}) (c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112}))	f	
105	c_{2} (c_{2} x_{114} x_{112}) (c_{5} (c_{2} x_{114} x_{113}) (c_{2} x_{113} x_{112}))	f	
106	c_{2} (c_{2} x_{114} x_{112}) (c_{5} (c_{2} x_{114} x_{113}) (c_{1} x_{113} x_{112}))	f	
107	c_{2} (c_{2} x_{114} x_{112}) (c_{5} (c_{1} x_{114} x_{113}) (c_{2} x_{113} x_{112}))	f	
\.


--
-- Name: teorema_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.teorema_id_seq', 107, true);


--
-- Data for Name: teoria; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.teoria (id, nombre) FROM stdin;
1	Propositional Logic
\.


--
-- Name: teoria_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.teoria_id_seq', 1, false);


--
-- Data for Name: termino; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.termino (combinador, serializado, alias, login) FROM stdin;
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.usuario (login, nombre, apellido, correo, password, materiaid, admin) FROM stdin;
teacher1	Teacher	Teacher	thism@ilistomuch.fake	c475d3bde27fa92fbcca391cce7c95e7e33326fe35c41a695ab2e7703d664f4d85b74545d7a6be5c1a55bd8130237c4deb4c134ed165a8f90206cbdd46bfeeb5	1	t
AdminTeoremas	Admin	Teoremas	admin@teoremas.gries	4b39bf2b2076bb3aec161cfd09ca0614a65f3c0adadb80ff443b8434237ad0a2745018653685a9811f2335dd0b314427ff7568592cd3856ef67ddb0315da4627	1	t
\.


--
-- Name: categoria categoria_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.categoria
    ADD CONSTRAINT "categoria_PK" PRIMARY KEY (id);


--
-- Name: categoria categoria_UNIQUE; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.categoria
    ADD CONSTRAINT "categoria_UNIQUE" UNIQUE (nombre);


--
-- Name: dispone dispone_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.dispone
    ADD CONSTRAINT "dispone_PK" PRIMARY KEY (id);


--
-- Name: dispone dispone_metateorema_y_usuario_UNIQUE; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.dispone
    ADD CONSTRAINT "dispone_metateorema_y_usuario_UNIQUE" UNIQUE (loginusuario, metateoremaid);


--
-- Name: materia materia_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.materia
    ADD CONSTRAINT "materia_PK" PRIMARY KEY (id);


--
-- Name: materia materia_UNIQUE; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.materia
    ADD CONSTRAINT "materia_UNIQUE" UNIQUE (nombre);


--
-- Name: metateorema metateorema_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.metateorema
    ADD CONSTRAINT "metateorema_PK" PRIMARY KEY (id);


--
-- Name: mostrarcategoria mostrarCategoria_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.mostrarcategoria
    ADD CONSTRAINT "mostrarCategoria_PK" PRIMARY KEY (id);


--
-- Name: predicado predicado_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.predicado
    ADD CONSTRAINT "predicado_PK" PRIMARY KEY (alias, login);


--
-- Name: predicado predicado_alias_UNIQUE; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.predicado
    ADD CONSTRAINT "predicado_alias_UNIQUE" UNIQUE (predicado, login);


--
-- Name: resuelve resuelve_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.resuelve
    ADD CONSTRAINT "resuelve_PK" PRIMARY KEY (id);


--
-- Name: resuelve resuelve_teorema_y_usuario_UNIQUE; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.resuelve
    ADD CONSTRAINT "resuelve_teorema_y_usuario_UNIQUE" UNIQUE (loginusuario, teoremaid);


--
-- Name: simbolo simbolo_pk; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.simbolo
    ADD CONSTRAINT simbolo_pk PRIMARY KEY (id);


--
-- Name: solucion solucion_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.solucion
    ADD CONSTRAINT "solucion_PK" PRIMARY KEY (id);


--
-- Name: teorema teorema_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.teorema
    ADD CONSTRAINT "teorema_PK" PRIMARY KEY (id);


--
-- Name: teoria teoria_pk; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.teoria
    ADD CONSTRAINT teoria_pk PRIMARY KEY (id);


--
-- Name: termino termino_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.termino
    ADD CONSTRAINT "termino_PK" PRIMARY KEY (alias, login);


--
-- Name: termino termino_UNIQUE; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.termino
    ADD CONSTRAINT "termino_UNIQUE" UNIQUE (combinador, login);


--
-- Name: usuario usuario_pk; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.usuario
    ADD CONSTRAINT usuario_pk PRIMARY KEY (login);


--
-- Name: resuelve categoria_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.resuelve
    ADD CONSTRAINT "categoria_FK" FOREIGN KEY (categoriaid) REFERENCES userdb.categoria(id);


--
-- Name: mostrarcategoria categoria_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.mostrarcategoria
    ADD CONSTRAINT "categoria_FK" FOREIGN KEY (categoriaid) REFERENCES userdb.categoria(id);


--
-- Name: dispone dispone_metateorema_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.dispone
    ADD CONSTRAINT "dispone_metateorema_FK" FOREIGN KEY (metateoremaid) REFERENCES userdb.metateorema(id);


--
-- Name: dispone dispone_usuario_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.dispone
    ADD CONSTRAINT "dispone_usuario_FK" FOREIGN KEY (loginusuario) REFERENCES userdb.usuario(login);


--
-- Name: predicado predicado_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.predicado
    ADD CONSTRAINT "predicado_FK" FOREIGN KEY (login) REFERENCES userdb.usuario(login);


--
-- Name: resuelve resuelve_teorema_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.resuelve
    ADD CONSTRAINT "resuelve_teorema_FK" FOREIGN KEY (teoremaid) REFERENCES userdb.teorema(id);


--
-- Name: resuelve resuelve_usuario_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.resuelve
    ADD CONSTRAINT "resuelve_usuario_FK" FOREIGN KEY (loginusuario) REFERENCES userdb.usuario(login);


--
-- Name: solucion solucion_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.solucion
    ADD CONSTRAINT "solucion_FK" FOREIGN KEY (resuelveid) REFERENCES userdb.resuelve(id);


--
-- Name: simbolo teoria_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.simbolo
    ADD CONSTRAINT "teoria_FK" FOREIGN KEY (teoriaid) REFERENCES userdb.teoria(id);


--
-- Name: termino termino_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.termino
    ADD CONSTRAINT "termino_FK" FOREIGN KEY (login) REFERENCES userdb.usuario(login);


--
-- Name: usuario usuario_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.usuario
    ADD CONSTRAINT "usuario_FK" FOREIGN KEY (materiaid) REFERENCES userdb.materia(id);


--
-- Name: mostrarcategoria usuario_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.mostrarcategoria
    ADD CONSTRAINT "usuario_FK" FOREIGN KEY (usuariologin) REFERENCES userdb.usuario(login);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;


--
-- Name: SCHEMA userdb; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA userdb TO userdb;


--
-- PostgreSQL database dump complete
--

