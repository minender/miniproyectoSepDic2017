--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.23
-- Dumped by pg_dump version 9.6.23

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
-- Name: proof_template; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.proof_template (
    id integer NOT NULL,
    template text NOT NULL,
    path_to_placeholders text NOT NULL
);


ALTER TABLE userdb.proof_template OWNER TO userdb;

--
-- Name: proof_template_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE userdb.proof_template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.proof_template_id_seq OWNER TO userdb;

--
-- Name: proof_template_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE userdb.proof_template_id_seq OWNED BY userdb.proof_template.id;


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
    categoriaid integer NOT NULL,
    variables text
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
    admin boolean DEFAULT false NOT NULL,
    autosust boolean DEFAULT false NOT NULL
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
2	Negation Inequivalence and false
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
1	LÎ“Ã¶Â£Î“Ã¶Ã©gica SimbÎ“Ã¶Â£Î“Ã¶Ã©lica Ene-Mar 2018
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
6	6	AdminTeoremas
\.


--
-- Name: mostrarcategoria_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.mostrarcategoria_id_seq', 12, true);


--
-- Data for Name: predicado; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.predicado (predicado, alias, login, argumentos, aliases, notacion) FROM stdin;
\.


--
-- Data for Name: proof_template; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.proof_template (id, template, path_to_placeholders) FROM stdin;
1	(I^{[x_{113} := (%T1)]} A^{c_{1} (c_{1} c_{8} x_{113}) x_{113}}) (%T2)	T2:q
2	(I^{[x_{112} := c_{8}]} A^{c_{1} (c_{5} x_{112} x_{112}) x_{112}}) (L^{\\lambda x_{122}.c_{5} c_{8} x_{122}} (S (%M1P))) (L^{\\lambda x_{122}.c_{5} x_{122} (%P1)} (S (%M1Q))) A^{c_{8}}	M1Q:pqqq;M1P:ppqqq
\.


--
-- Name: proof_template_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.proof_template_id_seq', 1, false);


--
-- Data for Name: publicacion; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.publicacion (alias, login) FROM stdin;
\.


--
-- Data for Name: resuelve; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.resuelve (id, nombreteorema, numeroteorema, resuelto, loginusuario, teoremaid, categoriaid, variables) FROM stdin;
1	Associativity of $\\equiv$	3.1	t	AdminTeoremas	1	1	p,q,r
2	Symmetry of $\\equiv$	3.2.a	t	AdminTeoremas	2	1	p,q
3	Symmetry of $\\equiv$	3.2.b	f	AdminTeoremas	3	1	p,q
4	Symmetry of $\\equiv$	3.2.c	f	AdminTeoremas	4	1	p,q
5	Symmetry of $\\equiv$	3.2.d	f	AdminTeoremas	5	1	p,q
6	Symmetry of $\\equiv$	3.2.e	f	AdminTeoremas	6	1	p,q
7	Identity of $\\equiv$	3.3.a	t	AdminTeoremas	7	1	q
8	Identity of $\\equiv$	3.3.b	f	AdminTeoremas	8	1	q
9		3.4	f	AdminTeoremas	9	1	
10	Reflexivity of $\\equiv$	3.5	t	AdminTeoremas	10	1	p
11	Definition of $false$	3.8	t	AdminTeoremas	11	2	
12	Distributivity of $\\neg$ over $\\equiv$	3.9	t	AdminTeoremas	12	2	p,q
13	Definition of $\\not\\equiv$	3.10	t	AdminTeoremas	13	2	p,q
14		3.11	f	AdminTeoremas	14	2	p,q
15	Double negation	3.12	f	AdminTeoremas	15	2	p
16	Negation of $false$	3.13	f	AdminTeoremas	16	2	
17		3.14	f	AdminTeoremas	17	2	p,q
18		3.15	f	AdminTeoremas	18	2	p
19	Symmetry of $\\not\\equiv$	3.16	f	AdminTeoremas	19	2	p,q
20	Associativity of $\\not\\equiv$	3.17	f	AdminTeoremas	20	2	p,q,r
21	Mutual associativity	3.18	f	AdminTeoremas	21	2	p,q,r
22	Mutual interchangeability	3.19	f	AdminTeoremas	22	2	p,q,r
23	Symmetry of $\\vee$	3.24	t	AdminTeoremas	23	3	p,q
24	Associativity of $\\vee$	3.25	t	AdminTeoremas	24	3	p,q,r
25	Idempotency of $\\vee$	3.26	t	AdminTeoremas	25	3	p
26	Distributivity of $\\vee$ over $\\equiv$	3.27	t	AdminTeoremas	26	3	p,q,r
27	Excluded Middle	3.28	t	AdminTeoremas	27	3	p
28	Zero of $\\vee$	3.29	f	AdminTeoremas	28	3	p
29	Identity of $\\vee$	3.30	f	AdminTeoremas	29	3	p
30	Distributivity of $\\vee$ over $\\vee$	3.31	f	AdminTeoremas	30	3	p,q,r
31		3.32.a	f	AdminTeoremas	31	3	p,q
32		3.32.b	f	AdminTeoremas	32	3	p,q
33	Golden rule	3.35.a	t	AdminTeoremas	33	4	p,q
34	Golden rule	3.35.b	f	AdminTeoremas	34	4	p,q
35	Golden rule	3.35.c	f	AdminTeoremas	35	4	p,q
36	Golden rule	3.35.d	f	AdminTeoremas	36	4	p,q
37	Golden rule	3.35.e	f	AdminTeoremas	37	4	p,q
38	Symmetry of $\\wedge$	3.36	f	AdminTeoremas	38	4	p,q
39	Associativity of $\\wedge$	3.37	f	AdminTeoremas	39	4	p,q,r
40	Idempotency of $\\wedge$	3.38	f	AdminTeoremas	40	4	p
41	Identity of $\\wedge$	3.39	f	AdminTeoremas	41	4	p
42	Zero of $\\wedge$	3.40	f	AdminTeoremas	42	4	p
43	Distributivity of $\\wedge$ over $\\wedge$	3.41	f	AdminTeoremas	43	4	p,q,r
44	Contradiction	3.42	f	AdminTeoremas	44	4	p
45	Absorption	3.43.a	f	AdminTeoremas	45	4	p,q
46	Absorption	3.43.b	f	AdminTeoremas	46	4	p,q
47	Absorption	3.44.a	f	AdminTeoremas	47	4	p,q
48	Absorption	3.44.b	f	AdminTeoremas	48	4	p,q
49	Distributivity of $\\vee$ over $\\wedge$	3.45	f	AdminTeoremas	49	4	p,q,r
50	Distributivity of $\\wedge$ over $\\vee$	3.46	f	AdminTeoremas	50	4	p,q,r
51	De Morgan	3.47.a	f	AdminTeoremas	51	4	p,q
52	De Morgan	3.47.b	f	AdminTeoremas	52	4	p,q
53		3.48.a	f	AdminTeoremas	53	4	p,q
54		3.48.b	f	AdminTeoremas	54	4	p,q
55		3.49.a	f	AdminTeoremas	55	4	p,q,r
56		3.49.b	f	AdminTeoremas	56	4	p,q,r
57		3.49.c	f	AdminTeoremas	57	4	p,q,r
58		3.49.d	f	AdminTeoremas	58	4	p,q,r
59		3.49.e	f	AdminTeoremas	59	4	p,q,r
60		3.50	f	AdminTeoremas	60	4	p,q
61	Replacement	3.51	f	AdminTeoremas	61	4	p,q,r
62	Definition of $\\equiv$	3.52	f	AdminTeoremas	62	4	p,q
63	Exclusive or	3.53	f	AdminTeoremas	63	4	p,q
64	Definition of Implication	3.57	t	AdminTeoremas	64	5	p,q
65	Consequence	3.58	t	AdminTeoremas	65	5	p,q
66	Definition of Implication	3.59	f	AdminTeoremas	66	5	p,q
67	Definition of Implication	3.60	f	AdminTeoremas	67	5	p,q
68	Contrapositive	3.61	f	AdminTeoremas	68	5	p,q
69		3.62	f	AdminTeoremas	69	5	p,q,r
70	Distributivity of $\\Rightarrow$ over $\\equiv$	3.63	f	AdminTeoremas	70	5	p,q,r
71		3.64	f	AdminTeoremas	71	5	p,q,r
72	Shunting	3.65	f	AdminTeoremas	72	5	p,q,r
73		3.66	f	AdminTeoremas	73	5	p,q
74		3.67	f	AdminTeoremas	74	5	p,q
75		3.68	f	AdminTeoremas	75	5	p,q
76		3.69	f	AdminTeoremas	76	5	p,q
77		3.70	f	AdminTeoremas	77	5	p,q
78	Reflexivity of $\\Rightarrow$	3.71	f	AdminTeoremas	78	5	p
79	Right zero of $\\Rightarrow$	3.72	f	AdminTeoremas	79	5	p
80	Left identity of $\\Rightarrow$	3.73	f	AdminTeoremas	80	5	p
81		3.74	f	AdminTeoremas	81	5	p
82		3.75	f	AdminTeoremas	82	5	p
83	Weakening/strengthening	3.76.a	f	AdminTeoremas	83	5	p,q
84	Weakening/strengthening	3.76.b	f	AdminTeoremas	84	5	p,q
85	Weakening/strengthening	3.76.c	f	AdminTeoremas	85	5	p,q
86	Weakening/strengthening	3.76.d	f	AdminTeoremas	86	5	p,q,r
87	Weakening/strengthening	3.76.e	f	AdminTeoremas	87	5	p,q,r
88	Modus ponens	3.77	f	AdminTeoremas	88	5	p,q
89		3.78	f	AdminTeoremas	89	5	p,q,r
90		3.79	f	AdminTeoremas	90	5	p,r
91	Mutual implication	3.80	f	AdminTeoremas	91	5	p,q
92	Antisymmetry	3.81	f	AdminTeoremas	92	5	p,q
93	Transitivity	3.82.a	f	AdminTeoremas	93	5	p,q,r
94	Transitivity	3.82.b	f	AdminTeoremas	94	5	p,q,r
95	Transitivity	3.82.c	f	AdminTeoremas	95	5	p,q,r
96	Leibniz	3.83	t	AdminTeoremas	96	6	E,e,f
97	Substitution	3.84.a	f	AdminTeoremas	97	6	E,e,f
98	Substitution	3.84.b	f	AdminTeoremas	98	6	E,e,f
99	Substitution	3.84.c	f	AdminTeoremas	99	6	E,e,f,q
100	Replace by $true$	3.85.a	f	AdminTeoremas	100	6	E,p
101	Replace by $true$	3.85.b	f	AdminTeoremas	101	6	E,p,q
102	Replace by $false$	3.86.a	f	AdminTeoremas	102	6	E,p
103	Replace by $false$	3.86.b	f	AdminTeoremas	103	6	E,p,q
104	Replace by $true$	3.87	f	AdminTeoremas	104	6	E,p
105	Replace by $false$	3.88	f	AdminTeoremas	105	6	E,p
106	Shannon	3.89	f	AdminTeoremas	106	6	E,p
\.


--
-- Name: resuelve_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.resuelve_id_seq', 106, true);


--
-- Data for Name: simbolo; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) FROM stdin;
1	\\equiv	2	t	4	1	%(a2) %(op) %(a1)	1
2	\\Rightarrow	2	t	3	2	%(a2) %(op) %(aa1)	1
3	\\Leftarrow	2	t	3	2	%(aa2) %(op) %(a1)	1
4	\\vee	2	t	4	3	%(a2) %(op) %(a1)	1
5	\\wedge	2	t	4	3	%(a2) %(op) %(a1)	1
6	\\not\\equiv	2	t	3	4	%(a2) %(op) %(a1)	1
7	\\neg	1	f	1	5	%(op) %(aa1)	1
8	true	0	f	0	0	%(op)	1
9	false	0	f	0	0	%(op)	1
10	 	2	f	3	7	%(a1)^z_{%(na2)}	1
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
1	= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))	f	
2	= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})	f	
3	= (\\Phi_{cbb} c_{1} \\Phi_{b(b,)} c_{1}) (\\Phi_{b} \\Phi_{K})	f	
4	= (\\Phi_{bb} (\\Phi_{(bb,)} c_{1}) c_{1}) (\\Phi_{b} \\Phi_{K})	f	
5	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{cb} c_{1} (\\Phi_{(b,cb)} c_{1}))	f	
6	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{ccb} c_{1} c_{1} \\Phi_{cb(b,)})	f	
7	= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})	f	
8	= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})	f	
9	= T c_{8}	f	
10	= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})	f	
11	= (c_{7} c_{8}) c_{9}	f	
12	= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))	f	
13	= (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7})) (\\Phi_{cb} c_{6} \\Phi_{cb})	f	
14	= (\\Phi_{ccb} c_{7} c_{1} \\Phi_{cbb}) (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7})	f	
15	= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})	f	
16	= c_{8} (c_{7} c_{9})	f	
17	= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{6} \\Phi_{cb})	f	
18	= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})	f	
19	= (\\Phi_{bb} \\Phi_{b} c_{6}) (\\Phi_{cb} c_{6} \\Phi_{cb})	f	
20	= (\\Phi_{bcb} (\\Phi_{cb} c_{6}) c_{6} \\Phi_{cbcb}) (\\Phi_{cb} c_{6} (\\Phi_{cbcb} c_{6} \\Phi_{cb}))	f	
21	= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{6} \\Phi_{cbcb}) (\\Phi_{cb} c_{6} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))	f	
22	= (\\Phi_{bcb} (\\Phi_{cb} c_{6}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{6} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))	f	
23	= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})	f	
24	= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))	f	
25	= \\Phi_{} (\\Phi_{(b,)} c_{4})	f	
26	= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{4} \\Phi_{cbcb})	f	
66	= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})	f	
67	= (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{1}) (\\Phi_{cb} c_{2} \\Phi_{cb})	f	
27	= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})	f	
28	= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))	f	
29	= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))	f	
30	= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{4} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb})	f	
31	= (\\Phi_{cc(bb,)} c_{7} c_{4} \\Phi_{bcbb} c_{1}) (\\Phi_{cb} c_{4} \\Phi_{cb})	f	
32	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(ccb,)} c_{4} c_{7} c_{4} (\\Phi_{(bcbb,cb)} c_{1}))	f	
33	= (\\Phi_{cb} c_{4} (\\Phi_{(bcb,)} c_{1})) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{1})	f	
34	= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})	f	
35	= (\\Phi_{c(ccb,)} c_{4} c_{1} c_{1} \\Phi_{cb(bcb,)}) (\\Phi_{cb} c_{5} \\Phi_{cb})	f	
36	= (\\Phi_{cb} c_{4} \\Phi_{cb}) (\\Phi_{c(cb,)} c_{5} c_{1} (\\Phi_{(bcb,cb)} c_{1}))	f	
37	= (\\Phi_{cb} c_{4} \\Phi_{cb}) (\\Phi_{c(bb,)} c_{5} (\\Phi_{(b,bcb)} c_{1}) c_{1})	f	
38	= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})	f	
39	= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))	f	
40	= \\Phi_{} (\\Phi_{(b,)} c_{5})	f	
41	= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))	f	
42	= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{5} c_{9}))	f	
43	= (\\Phi_{c(ccb,)} c_{5} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{5})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb})	f	
44	= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})	f	
45	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{4} c_{5} \\Phi_{cbcb})	f	
46	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{5} c_{4} \\Phi_{cbcb})	f	
47	= (\\Phi_{cb} c_{5} \\Phi_{cb}) (\\Phi_{c(cb,b)} c_{4} c_{5} \\Phi_{cbcb} c_{7})	f	
48	= (\\Phi_{cb} c_{4} \\Phi_{cb}) (\\Phi_{c(cb,b)} c_{5} c_{4} \\Phi_{cbcb} c_{7})	f	
49	= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{4} \\Phi_{cbcb})	f	
50	= (\\Phi_{c(ccb,)} c_{5} \\Phi_{cbcb} c_{4} (\\Phi_{cccbcb} c_{5})) (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{5} \\Phi_{cbcb})	f	
51	= (\\Phi_{ccbb} c_{7} c_{4} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{5} (\\Phi_{bcb} c_{7}))	f	
52	= (\\Phi_{ccbb} c_{7} c_{5} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{4} (\\Phi_{bcb} c_{7}))	f	
53	= (\\Phi_{cc(bbb,)} c_{7} c_{5} \\Phi_{bcbb} c_{1} c_{7}) (\\Phi_{cb} c_{5} \\Phi_{cb})	f	
54	= (\\Phi_{bb} \\Phi_{K} c_{7}) (\\Phi_{c(ccb,)} c_{5} c_{7} c_{5} (\\Phi_{(bcbb,cb)} c_{1}))	f	
55	= (\\Phi_{bc(bb,)} \\Phi_{K} c_{5} \\Phi_{bcb} c_{1}) (\\Phi_{c(ccb,)} c_{5} c_{1} \\Phi_{bcbcb} (\\Phi_{c(ccbbcb,)} c_{1} c_{5}))	f	
56	= (\\Phi_{c((cb,bb),)} c_{5} c_{1} (\\Phi_{cccbcb} c_{5}) \\Phi_{bcbcb} c_{1}) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{5} \\Phi_{cbcb})	f	
57	= (\\Phi_{c(cc(b,b),)} c_{5} \\Phi_{cbbcb} c_{1} (\\Phi_{ccccbcb} c_{5}) c_{1}) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{5} \\Phi_{cbcb})	f	
58	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{c(cc(cb,),)} c_{5} (\\Phi_{(bcbcb,cbcb)} c_{1}) c_{1} c_{5} (\\Phi_{c(cccccbcb,)} c_{1} c_{5}))	f	
59	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{c(c(b,cb),)} c_{5} c_{1} (\\Phi_{c(ccbbcb,)} c_{1} c_{5}) c_{5} (\\Phi_{(bcb,bcbcb)} c_{1}))	f	
60	= (\\Phi_{cb} c_{5} \\Phi_{cb}) (\\Phi_{(cb,b)} c_{5} \\Phi_{cbb} c_{1})	f	
61	= (\\Phi_{ccb} c_{1} c_{1} (\\Phi_{(cbcb,b)} c_{5} \\Phi_{cbb})) (\\Phi_{c(ccbb,)} c_{1} \\Phi_{cbb} c_{5} \\Phi_{ccbcb} c_{1})	f	
62	= (\\Phi_{c(ccbb,)} c_{5} c_{7} c_{5} (\\Phi_{(bcbb,cb)} c_{4}) c_{7}) (\\Phi_{cb} c_{1} \\Phi_{cb})	f	
63	= (\\Phi_{c(ccb,b)} c_{5} c_{7} c_{5} (\\Phi_{(bcbb,cb)} c_{4}) c_{7}) (\\Phi_{cb} c_{6} \\Phi_{cb})	f	
64	= (\\Phi_{cb} c_{4} (\\Phi_{(b,cb)} c_{1})) (\\Phi_{cb} c_{2} \\Phi_{cb})	f	
65	= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})	f	
68	= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})	f	
69	= (\\Phi_{c(ccb,)} c_{5} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{5})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{2} \\Phi_{cbcb})	f	
70	= (\\Phi_{c(ccb,)} c_{2} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{2})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{2} \\Phi_{cbcb})	f	
71	= (\\Phi_{c(ccb,)} c_{2} \\Phi_{cbcb} c_{2} (\\Phi_{cccbcb} c_{2})) (\\Phi_{bcb} (\\Phi_{cb} c_{2}) c_{2} \\Phi_{cbcb})	f	
72	= (\\Phi_{bcb} (\\Phi_{cb} c_{2}) c_{2} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{2} \\Phi_{cb}))	f	
73	= (\\Phi_{cb} c_{5} \\Phi_{cb}) (\\Phi_{c(cb,)} c_{2} c_{5} \\Phi_{cbcb})	f	
74	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{(cb,b)} c_{5} \\Phi_{cbb} c_{2})	f	
75	= (\\Phi_{K} (\\Phi_{K} c_{8})) (\\Phi_{c(cb,)} c_{2} c_{4} \\Phi_{cbcb})	f	
76	= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{(cb,b)} c_{4} \\Phi_{cbb} c_{2})	f	
77	= (\\Phi_{cb} c_{1} \\Phi_{cb}) (\\Phi_{c(cb,)} c_{4} c_{5} (\\Phi_{(bcb,cb)} c_{2}))	f	
78	= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})	f	
79	= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))	f	
80	= \\Phi_{} (\\Phi_{cb} c_{8} c_{2})	f	
81	= (\\Phi_{b} c_{7}) (\\Phi_{b} (c_{2} c_{9}))	f	
82	= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{9} c_{2})	f	
83	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(cb,)} c_{4} c_{2} \\Phi_{cbcb})	f	
84	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})	f	
85	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(cb,)} c_{5} c_{4} (\\Phi_{(bcb,cb)} c_{2}))	f	
86	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{4} c_{2} \\Phi_{bcbcb} (\\Phi_{c(ccbbcb,)} c_{5} c_{4}))	f	
87	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{5} \\Phi_{cbcbcb} c_{2} (\\Phi_{c(cccbcb,)} c_{4} c_{5}))	f	
88	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(cb,)} c_{2} c_{5} (\\Phi_{(b,cbcb)} c_{2}))	f	
89	= (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{2} \\Phi_{cb})) (\\Phi_{ccb} (\\Phi_{(bcb,cb)} c_{5}) c_{2} (\\Phi_{cccb} c_{2}))	f	
90	= (\\Phi_{K} \\Phi_{}) (\\Phi_{c(cbb,)} c_{2} c_{2} (\\Phi_{(bcb,cb)} c_{5}) c_{7})	f	
91	= (\\Phi_{cb} c_{1} \\Phi_{cb}) (\\Phi_{c(bb,)} c_{2} (\\Phi_{(bb,cb)} c_{5}) c_{2})	f	
92	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c((ccb,b),)} c_{2} c_{5} c_{1} (\\Phi_{(bcb,(bb,cb))} c_{2}) c_{2})	f	
93	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(bcb,)} c_{2} (\\Phi_{c(cbcb,)} c_{2} c_{5}) c_{2} (\\Phi_{(bcb,cbcb)} c_{2}))	f	
94	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(bcb,)} c_{1} (\\Phi_{c(cbcb,)} c_{2} c_{5}) c_{2} (\\Phi_{(bcb,cbcb)} c_{2}))	f	
95	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(bcb,)} c_{2} (\\Phi_{c(cbcb,)} c_{1} c_{5}) c_{2} (\\Phi_{(bcb,cbcb)} c_{2}))	f	
96	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} (\\Phi_{(bcbb,cb)} c_{2}) c_{1} (\\Phi_{c(ccbb,)} c_{1}))	f	
97	= (\\Phi_{bb} (\\Phi_{cb} c_{1}) (\\Phi_{(bb,cb)} c_{5})) (\\Phi_{b} (\\Phi_{c(bbb,)} c_{1} \\Phi_{bcb} c_{5}))	f	
98	= (\\Phi_{bb} (\\Phi_{cb} c_{1}) (\\Phi_{(bb,cb)} c_{2})) (\\Phi_{b} (\\Phi_{c(bbb,)} c_{1} \\Phi_{bcb} c_{2}))	f	
99	= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{5} (\\Phi_{(bbb,bcb)} \\Phi_{bb} c_{2})) (\\Phi_{b} (\\Phi_{c(cbbbb,)} c_{1} c_{5} \\Phi_{bbcb} \\Phi_{bb} c_{2}))	f	
100	= (\\Phi_{bbc} \\Phi_{b} c_{2} c_{8}) (\\Phi_{b} (\\Phi_{(bb,)} c_{2}))	f	
101	= (\\Phi_{cbbbc} c_{5} \\Phi_{bb} \\Phi_{bb} c_{2} c_{8}) (\\Phi_{cb} c_{5} (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2}))	f	
102	= (\\Phi_{cbc} c_{2} \\Phi_{cb} c_{9}) (\\Phi_{b} (\\Phi_{(b,b)} c_{2}))	f	
103	= (\\Phi_{bcbc} (\\Phi_{cb} c_{4}) c_{2} \\Phi_{cbcb} c_{9}) (\\Phi_{b} (\\Phi_{c(cbb,)} c_{4} c_{2} \\Phi_{cbcb}))	f	
104	= (\\Phi_{bbc} \\Phi_{b} c_{5} c_{8}) (\\Phi_{b} (\\Phi_{(bb,)} c_{5}))	f	
105	= (\\Phi_{bbc} \\Phi_{b} c_{4} c_{9}) (\\Phi_{b} (\\Phi_{(bb,)} c_{4}))	f	
106	= (\\Phi_{(cbbc,bc)} c_{7} (\\Phi_{(bbb,b)} c_{4}) c_{5} c_{9} c_{5} c_{8}) (\\Phi_{b} \\Phi_{b})	f	
\.


--
-- Name: teorema_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.teorema_id_seq', 106, true);


--
-- Data for Name: teoria; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.teoria (id, nombre) FROM stdin;
1	LÎ“Ã¶Â£Î“Ã¶Ã©gica proposicional
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

COPY userdb.usuario (login, nombre, apellido, correo, password, materiaid, admin, autosust) FROM stdin;
admin	Admin	Admin	correodem@asiado.falso	1f0d65c78b2350520c7bb6409104226063e3d9b05cb0a31ba497f489f98ef6bb8c92cd81ba298543d4fb1b293e139d12f4a7110adb157c75075d8a582e1fe97d	1	t	f
AdminTeoremas	Admin	Teoremas	admin@teoremas.gries	4b39bf2b2076bb3aec161cfd09ca0614a65f3c0adadb80ff443b8434237ad0a2745018653685a9811f2335dd0b314427ff7568592cd3856ef67ddb0315da4627	1	t	f
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
