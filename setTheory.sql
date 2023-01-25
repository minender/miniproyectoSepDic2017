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
    nombre text NOT NULL,
    teoriaid integer DEFAULT 1
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
-- Name: incluye; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.incluye (
    padreid integer NOT NULL,
    hijoid integer NOT NULL
);


ALTER TABLE userdb.incluye OWNER TO userdb;

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
-- Name: mostrarcategoria; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.mostrarcategoria (
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
    variables text,
    teoriaid integer DEFAULT 1
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
    teoriaid integer NOT NULL,
    tipo character varying DEFAULT ''::character varying
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
    autosust boolean DEFAULT false NOT NULL,
    teoriaid integer DEFAULT 1
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

COPY userdb.categoria (id, nombre, teoriaid) FROM stdin;
1	Equivalence and true	1
2	Negation Inequivalence and false	1
3	Disjunction	1
4	Conjunction	1
5	Implication	1
6	Leibniz as an Axiom	1
7	Universal Quantification	1
8	Existential Quantification	1
9	Axioms	2
10	Theorems	2
11	Otros	2
\.


--
-- Name: categoria_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.categoria_id_seq', 11, true);


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
-- Data for Name: incluye; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.incluye (padreid, hijoid) FROM stdin;
1	2
\.


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

COPY userdb.mostrarcategoria (categoriaid, usuariologin) FROM stdin;
11	AdminTeoremas
1	federico
2	federico
3	federico
4	federico
5	federico
7	federico
1	minender
8	federico
10	AdminTeoremas
9	federico
10	federico
6	federico
9	AdminTeoremas
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

COPY userdb.resuelve (id, nombreteorema, numeroteorema, resuelto, loginusuario, teoremaid, categoriaid, variables, teoriaid) FROM stdin;
210	Distributivity of $\\vee$ over $\\wedge$	3.45	t	federico	49	4	;p,q,r	1
138	Generalized De Morgan	9.17	t	AdminTeoremas	133	8	x,x,x,x;P,R	1
10	Reflexivity of $\\equiv$	3.5	t	AdminTeoremas	10	1	;q	1
8	Identity of $\\equiv$	3.3.b	t	AdminTeoremas	8	1	;q	1
11	Definition of $false$	3.8	t	AdminTeoremas	11	2	;	1
12	Distributivity of $\\neg$ over $\\equiv$	3.9	t	AdminTeoremas	12	2	;p,q	1
13	Definition of $\\not\\equiv$	3.10	t	AdminTeoremas	13	2	;p,q	1
23	Symmetry of $\\vee$	3.24	t	AdminTeoremas	23	3	;p,q	1
24	Associativity of $\\vee$	3.25	t	AdminTeoremas	24	3	;p,q,r	1
25	Idempotency of $\\vee$	3.26	t	AdminTeoremas	25	3	;p	1
139	Generalized De Morgan	9.18.a	f	AdminTeoremas	134	8	x,x,x,x;P,R	1
140	Generalized De Morgan	9.18.b	f	AdminTeoremas	135	8	x,x,x,x;P,R	1
165		21	t	AdminTeoremas	160	9	;A,B	2
122	Trading	9.2	t	AdminTeoremas	117	7	x,x,x;P,R	1
123	Trading	9.3.a	f	AdminTeoremas	118	7	x,x,x;P,R	1
124	Trading	9.3.b	f	AdminTeoremas	119	7	x,x,x;P,R	1
125	Trading	9.3.c	f	AdminTeoremas	120	7	x,x,x;P,R	1
126	Trading	9.4.a	f	AdminTeoremas	121	7	x,x,x,x;P,Q,R	1
127	Trading	9.4.b	f	AdminTeoremas	122	7	x,x,x,x;P,Q,R	1
128	Trading	9.4.c	f	AdminTeoremas	123	7	x,x,x,x;P,Q,R	1
129	Trading	9.4.d	f	AdminTeoremas	124	7	x,x,x,x;P,Q,R	1
141	Generalized De Morgan	9.18.c	f	AdminTeoremas	136	8	x,x,x,x;P,R	1
7	Identity of $\\equiv$	3.3.a	f	AdminTeoremas	7	1	;q	1
142	Trading	9.19	f	AdminTeoremas	137	8	x,x,x;P,R	1
143	Trading	9.20	f	AdminTeoremas	138	8	x,x,x,x;P,Q,R	1
144	Distributivity of $\\wedge$ over $\\exists$	9.21	f	AdminTeoremas	139	8	x,x,x,x;P,Q,R	1
145		9.22	f	AdminTeoremas	140	8	x,x,x;P,R	1
146	Distributivity of $\\vee$ over $\\exists$	9.23	f	AdminTeoremas	141	8	x,x,x,x,x;P,Q,R	1
14		3.11	f	AdminTeoremas	14	2	;p,q	1
15	Double negation	3.12	f	AdminTeoremas	15	2	;p	1
16	Negation of $false$	3.13	f	AdminTeoremas	16	2	;	1
17		3.14	f	AdminTeoremas	17	2	;p,q	1
147		9.24.a	f	AdminTeoremas	142	8	x,x;R	1
19	Symmetry of $\\not\\equiv$	3.16	f	AdminTeoremas	19	2	;p,q	1
20	Associativity of $\\not\\equiv$	3.17	f	AdminTeoremas	20	2	;p,q,r	1
21	Mutual associativity	3.18	f	AdminTeoremas	21	2	;p,q,r	1
22	Mutual interchangeability	3.19	f	AdminTeoremas	22	2	;p,q,r	1
148	Range weakening/strengthening	9.25	f	AdminTeoremas	143	8	x,x,x,x;P,Q,R	1
149	Body weakening/strengthening	9.26	f	AdminTeoremas	144	8	x,x,x,x;P,Q,R	1
130	Distributivity of $\\vee$ over $\\forall$	9.5	t	AdminTeoremas	125	7	x,x,x,x;P,Q,R	1
131		9.6	f	AdminTeoremas	126	7	x,x,x;P,R	1
132	Distributivity of $\\wedge$ over $\\forall$	9.7	f	AdminTeoremas	127	7	x,x,x,x,x;P,Q,R	1
133		9.9	f	AdminTeoremas	128	7	x,x,x,x,x,x;P,Q,R	1
134	Range weakening/strengthening	9.10	f	AdminTeoremas	129	7	x,x,x,x;P,Q,R	1
135	Body weakening/strengthening	9.11	f	AdminTeoremas	130	7	x,x,x,x;P,Q,R	1
136	Monotonicity of $\\forall$	9.12	f	AdminTeoremas	131	7	x,x,x,x,x,x;P,Q,R	1
137	Instantiation	9.13	f	AdminTeoremas	132	7	x;P,e	1
150	Monotonicity of $\\exists$	9.27	f	AdminTeoremas	145	8	x,x,x,x,x,x;P,Q,R	1
151	$\\exists$-Introduction	9.28	f	AdminTeoremas	146	8	x;E,P	1
152	Interchange of quantifications	9.29	f	AdminTeoremas	147	8	x,x,y,y,y,y,x,x;P,Q,R	1
161		17	t	AdminTeoremas	156	9	x,C,C,x;B	2
107	Extension	1.a	t	AdminTeoremas	107	9	A,B,x;	2
211	Distributivity of $\\wedge$ over $\\vee$	3.46	t	federico	50	4	;p,q,r	1
183	Zero of $\\vee$	3.29	t	federico	28	3	;p	1
182	Identity of $\\wedge$	3.39	t	federico	41	4	;p	1
184		3.4	t	federico	9	1	;	1
185	Identity of $\\equiv$	3.3.a	t	federico	7	1	;q	1
186	Symmetry of $\\equiv$	3.2.b	t	federico	3	1	;p,q	1
207	Distributivity of $\\wedge$ over $\\wedge$	3.41	t	federico	43	4	;p,q,r	1
208	Contradiction	3.42	t	federico	44	4	;p	1
209		3.50	t	federico	60	4	;p,q	1
212	Definition of $\\equiv$	3.52	t	federico	62	4	;p,q	1
215	Replacement	3.51	t	federico	61	4	;p,q,r	1
216	Exclusive or	3.53	t	federico	63	4	;p,q	1
218	Golden rule	3.35.c	t	federico	35	4	;p,q	1
219	Golden rule	3.35.d	t	federico	36	4	;p,q	1
220	Golden rule	3.35.e	t	federico	37	4	;p,q	1
217	Golden rule	3.35.a	t	federico	33	4	;p,q	1
221	Absorption	3.43.a	t	federico	45	4	;p,q	1
222	Absorption	3.43.b	t	federico	46	4	;p,q	1
223	Absorption	3.44.a	t	federico	47	4	;p,q	1
224	Absorption	3.44.b	t	federico	48	4	;p,q	1
225	De Morgan	3.47.a	t	federico	51	4	;p,q	1
226	De Morgan	3.47.b	t	federico	52	4	;p,q	1
227		3.48.a	t	federico	53	4	;p,q	1
228		3.48.b	t	federico	54	4	;p,q	1
213	Definition of Implication	3.59	t	federico	66	5	;p,q	1
229	Definition of Implication	3.60	t	federico	67	5	;p,q	1
230		3.66	t	federico	73	5	;p,q	1
214	Replace by $true$	3.87	t	federico	104	6	;E,p	1
231	Replace by $false$	3.88	t	federico	105	6	;E,p	1
232	Shannon	3.89	f	federico	106	6	;E,p	1
18		3.15.a	f	AdminTeoremas	18	2	;p	1
1	Associativity of $\\equiv$	3.1	t	AdminTeoremas	1	1	;p,q,r	1
2	Symmetry of $\\equiv$	3.2.a	t	AdminTeoremas	2	1	;p,q	1
26	Distributivity of $\\vee$ over $\\equiv$	3.27	t	AdminTeoremas	26	3	;p,q,r	1
27	Excluded Middle	3.28	t	AdminTeoremas	27	3	;p	1
34	Golden rule	3.35.b	t	AdminTeoremas	34	4	;p,q	1
64	Definition of Implication	3.57	t	AdminTeoremas	64	5	;p,q	1
65	Consequence	3.58	t	AdminTeoremas	65	5	;p,q	1
171		10.2	f	AdminTeoremas	165	10	B,A;	2
111	Pairs	4	t	AdminTeoremas	110	9	a,b,A,x;	2
28	Zero of $\\vee$	3.29	f	AdminTeoremas	28	3	;p	1
29	Identity of $\\vee$	3.30	f	AdminTeoremas	29	3	;p	1
30	Distributivity of $\\vee$ over $\\vee$	3.31	f	AdminTeoremas	30	3	;p,q,r	1
31		3.32.a	f	AdminTeoremas	31	3	;p,q	1
32		3.32.b	f	AdminTeoremas	32	3	;p,q	1
33	Golden rule	3.35.a	f	AdminTeoremas	33	4	;p,q	1
35	Golden rule	3.35.c	f	AdminTeoremas	35	4	;p,q	1
36	Golden rule	3.35.d	f	AdminTeoremas	36	4	;p,q	1
37	Golden rule	3.35.e	f	AdminTeoremas	37	4	;p,q	1
38	Symmetry of $\\wedge$	3.36	f	AdminTeoremas	38	4	;p,q	1
39	Associativity of $\\wedge$	3.37	f	AdminTeoremas	39	4	;p,q,r	1
40	Idempotency of $\\wedge$	3.38	f	AdminTeoremas	40	4	;p	1
41	Identity of $\\wedge$	3.39	f	AdminTeoremas	41	4	;p	1
42	Zero of $\\wedge$	3.40	f	AdminTeoremas	42	4	;p	1
43	Distributivity of $\\wedge$ over $\\wedge$	3.41	f	AdminTeoremas	43	4	;p,q,r	1
44	Contradiction	3.42	f	AdminTeoremas	44	4	;p	1
45	Absorption	3.43.a	f	AdminTeoremas	45	4	;p,q	1
46	Absorption	3.43.b	f	AdminTeoremas	46	4	;p,q	1
47	Absorption	3.44.a	f	AdminTeoremas	47	4	;p,q	1
48	Absorption	3.44.b	f	AdminTeoremas	48	4	;p,q	1
49	Distributivity of $\\vee$ over $\\wedge$	3.45	f	AdminTeoremas	49	4	;p,q,r	1
50	Distributivity of $\\wedge$ over $\\vee$	3.46	f	AdminTeoremas	50	4	;p,q,r	1
51	De Morgan	3.47.a	f	AdminTeoremas	51	4	;p,q	1
52	De Morgan	3.47.b	f	AdminTeoremas	52	4	;p,q	1
53		3.48.a	f	AdminTeoremas	53	4	;p,q	1
54		3.48.b	f	AdminTeoremas	54	4	;p,q	1
55		3.49.a	f	AdminTeoremas	55	4	;p,q,r	1
56		3.49.b	f	AdminTeoremas	56	4	;p,q,r	1
57		3.49.c	f	AdminTeoremas	57	4	;p,q,r	1
58		3.49.d	f	AdminTeoremas	58	4	;p,q,r	1
59		3.49.e	f	AdminTeoremas	59	4	;p,q,r	1
60		3.50	f	AdminTeoremas	60	4	;p,q	1
61	Replacement	3.51	f	AdminTeoremas	61	4	;p,q,r	1
62	Definition of $\\equiv$	3.52	f	AdminTeoremas	62	4	;p,q	1
63	Exclusive or	3.53	f	AdminTeoremas	63	4	;p,q	1
66	Definition of Implication	3.59	f	AdminTeoremas	66	5	;p,q	1
67	Definition of Implication	3.60	f	AdminTeoremas	67	5	;p,q	1
68	Contrapositive	3.61	f	AdminTeoremas	68	5	;p,q	1
69		3.62	f	AdminTeoremas	69	5	;p,q,r	1
70	Distributivity of $\\Rightarrow$ over $\\equiv$	3.63	f	AdminTeoremas	70	5	;p,q,r	1
71		3.64	f	AdminTeoremas	71	5	;p,q,r	1
72	Shunting	3.65	f	AdminTeoremas	72	5	;p,q,r	1
73		3.66	f	AdminTeoremas	73	5	;p,q	1
74		3.67	f	AdminTeoremas	74	5	;p,q	1
9		3.4	f	AdminTeoremas	9	1	;	1
3	Symmetry of $\\equiv$	3.2.b	f	AdminTeoremas	3	1	;p,q	1
4	Symmetry of $\\equiv$	3.2.c	f	AdminTeoremas	4	1	;p,q	1
5	Symmetry of $\\equiv$	3.2.d	f	AdminTeoremas	5	1	;p,q	1
6	Symmetry of $\\equiv$	3.2.e	f	AdminTeoremas	6	1	;p,q	1
187	Symmetry of $\\equiv$	3.2.c	t	federico	4	1	;p,q	1
188	Symmetry of $\\equiv$	3.2.d	t	federico	5	1	;p,q	1
189	Symmetry of $\\equiv$	3.2.e	t	federico	6	1	;p,q	1
162		18	t	AdminTeoremas	157	9	x,x;A,B	2
173		26	t	AdminTeoremas	167	9	x,a,b,x;A,B	2
191		3.11	t	federico	14	2	;p,q	1
192	Double negation	3.12	t	federico	15	2	;p	1
109	Empty set	2	t	AdminTeoremas	108	9	A,x;	2
153		10	t	AdminTeoremas	148	9	;A,x	2
154	Empty symbol	11	t	AdminTeoremas	149	9	x;	2
193	Negation of $false$	3.13	t	federico	16	2	;	1
194		3.14	t	federico	17	2	;p,q	1
163		19	t	AdminTeoremas	158	9	x;A,B	2
164		20	t	AdminTeoremas	159	9	;A,B	2
166		22	t	AdminTeoremas	161	9	;A,B	2
167		23	t	AdminTeoremas	162	9	;a,b	2
168		25	t	AdminTeoremas	163	9	;A,B	2
169		27	t	AdminTeoremas	164	9	;x	2
195		3.15	t	federico	18	2	;p	1
196	Symmetry of $\\not\\equiv$	3.16	t	federico	19	2	;p,q	1
197	Associativity of $\\not\\equiv$	3.17	t	federico	20	2	;p,q,r	1
198	Mutual associativity	3.18	t	federico	21	2	;p,q,r	1
199	Mutual interchangeability	3.19	t	federico	22	2	;p,q,r	1
190	Identity of $\\vee$	3.30	t	federico	29	3	;p	1
200	Distributivity of $\\vee$ over $\\vee$	3.31	t	federico	30	3	;p,q,r	1
201		3.32.a	t	federico	31	3	;p,q	1
202		3.32.b	t	federico	32	3	;p,q	1
203	Symmetry of $\\wedge$	3.36	t	federico	38	4	;p,q	1
170	Extension	1.b	f	AdminTeoremas	109	9	A,B,x;	2
174	Extension	1.b	f	federico	109	9	A,B,x;	2
96	Leibniz	3.83	t	AdminTeoremas	96	6	;E,e,f	1
248	Interchange of dummies	8.19	t	AdminTeoremas	175	7	y,x,x,y,x,y,y,x;P,Q,R	1
159		15	t	AdminTeoremas	154	9	;A,B	2
155		12	t	AdminTeoremas	150	9	x,x;P,U,y	2
179		4.20	f	federico	168	4	;q	1
98	Substitution	3.84.b	t	AdminTeoremas	98	6	;E,e,f	1
91	Mutual implication	3.80	t	AdminTeoremas	91	5	;p,q	1
204	Associativity of $\\wedge$	3.37	t	federico	39	4	;p,q,r	1
205	Idempotency of $\\wedge$	3.38	t	federico	40	4	;p	1
249	Distributivity of $\\Rightarrow$ over $\\equiv$	3.63	t	federico	70	5	;p,q,r	1
206	Zero of $\\wedge$	3.40	t	federico	42	4	;p	1
233	Substitution	3.84.a	t	federico	97	6	;E,e,f	1
235		3.15.b	f	AdminTeoremas	169	2	;p	1
236		3.15.b	t	federico	169	2	;p	1
250		3.64	t	federico	71	5	;p,q,r	1
113	Union	5	t	AdminTeoremas	112	9	B,A,x,C,C;	2
114	Foundation	6	t	AdminTeoremas	113	9	A,A,x,x,y,y;	2
115	Infinity	7	t	AdminTeoremas	114	9	A,x;	2
116	Parts	8	t	AdminTeoremas	115	9	B,A,x;	2
237	Weakening/strengthening	3.76.f	f	AdminTeoremas	170	5	;p,q	1
158		14	t	AdminTeoremas	153	9	C,C;B,x	2
75		3.68	f	AdminTeoremas	75	5	;p,q	1
76		3.69	f	AdminTeoremas	76	5	;p,q	1
77		3.70	f	AdminTeoremas	77	5	;p,q	1
78	Reflexivity of $\\Rightarrow$	3.71	f	AdminTeoremas	78	5	;p	1
79	Right zero of $\\Rightarrow$	3.72	f	AdminTeoremas	79	5	;p	1
80	Left identity of $\\Rightarrow$	3.73	f	AdminTeoremas	80	5	;p	1
81		3.74	f	AdminTeoremas	81	5	;p	1
82		3.75	f	AdminTeoremas	82	5	;p	1
83	Weakening/strengthening	3.76.a	f	AdminTeoremas	83	5	;p,q	1
84	Weakening/strengthening	3.76.b	f	AdminTeoremas	84	5	;p,q	1
85	Weakening/strengthening	3.76.c	f	AdminTeoremas	85	5	;p,q	1
86	Weakening/strengthening	3.76.d	f	AdminTeoremas	86	5	;p,q,r	1
87	Weakening/strengthening	3.76.e	f	AdminTeoremas	87	5	;p,q,r	1
88	Modus ponens	3.77	f	AdminTeoremas	88	5	;p,q	1
89		3.78	f	AdminTeoremas	89	5	;p,q,r	1
90		3.79	f	AdminTeoremas	90	5	;p,r	1
251	Shunting	3.65	t	federico	72	5	;p,q,r	1
92	Antisymmetry	3.81	f	AdminTeoremas	92	5	;p,q	1
93	Transitivity	3.82.a	f	AdminTeoremas	93	5	;p,q,r	1
94	Transitivity	3.82.b	f	AdminTeoremas	94	5	;p,q,r	1
95	Transitivity	3.82.c	f	AdminTeoremas	95	5	;p,q,r	1
238	Weakening/strengthening	3.76.f	t	federico	170	5	;p,q	1
97	Substitution	3.84.a	f	AdminTeoremas	97	6	;E,e,f	1
99	Substitution	3.84.c	f	AdminTeoremas	99	6	;E,e,f,q	1
100	Replace by $true$	3.85.a	f	AdminTeoremas	100	6	;E,p	1
101	Replace by $true$	3.85.b	f	AdminTeoremas	101	6	;E,p,q	1
102	Replace by $false$	3.86.a	f	AdminTeoremas	102	6	;E,p	1
103	Replace by $false$	3.86.b	f	AdminTeoremas	103	6	;E,p,q	1
104	Replace by $true$	3.87	f	AdminTeoremas	104	6	;E,p	1
105	Replace by $false$	3.88	f	AdminTeoremas	105	6	;E,p	1
106	Shannon	3.89	f	AdminTeoremas	106	6	;E,p	1
239	Replace by $true$	3.85.a	t	federico	100	6	;E,p	1
234	Substitution	3.84.c	t	federico	99	6	;E,e,f,q	1
240	Contrapositive	3.61	t	federico	68	5	;p,q	1
241		3.62	t	federico	69	5	;p,q,r	1
112	Separation	3	t	AdminTeoremas	111	9	U,A,x;P	2
242		9.6	t	federico	126	7	x,x,x;P,R	1
243		9.8	t	federico	116	7	x;	1
156		13.a	t	AdminTeoremas	151	9	;a,x	2
157		13.b	t	AdminTeoremas	152	9	;a,b,x	2
160		16	t	AdminTeoremas	155	9	x,x;A,B	2
121		9.8.a	f	AdminTeoremas	116	7	x;	1
244		9.8.b	f	AdminTeoremas	171	7	x,x,x;P	1
245	Empty range	9.1	t	AdminTeoremas	172	7	x,x;P	1
246	Distributivity	8.15	t	AdminTeoremas	173	7	x,x,x,x,x,x;P,Q,R	1
247	Rage split	8.18	t	AdminTeoremas	174	7	x,x,x,x,x,x;P,R,S	1
253	Left identity of $\\Rightarrow$	3.73	t	federico	80	5	;p	1
252		9.8.b	t	federico	171	7	x,x,x;P	1
254	Trading	9.3.a	t	federico	118	7	x,x,x;P,R	1
255		3.67	t	federico	74	5	;p,q	1
256		3.68	t	federico	75	5	;p,q	1
257		3.69	t	federico	76	5	;p,q	1
258		3.70	t	federico	77	5	;p,q	1
259	Reflexivity of $\\Rightarrow$	3.71	t	federico	78	5	;p	1
260	Right zero of $\\Rightarrow$	3.72	t	federico	79	5	;p	1
261		3.74	t	federico	81	5	;p	1
262		3.75	t	federico	82	5	;p	1
263	Modus ponens	3.77	t	federico	88	5	;p,q	1
264		3.78	t	federico	89	5	;p,q,r	1
265		3.79	t	federico	90	5	;p,r	1
267	Weakening/strengthening	3.76.b	t	federico	84	5	;p,q	1
266	Range weakening/strengthening	9.10	t	federico	129	7	x,x,x,x;P,Q,R	1
268	Body weakening/strengthening	9.11	t	federico	130	7	x,x,x,x;P,Q,R	1
269	Trading	9.3.b	t	federico	119	7	x,x,x;P,R	1
270	Trading	9.3.c	t	federico	120	7	x,x,x;P,R	1
271	Distributivity of $\\wedge$ over $\\forall$	9.7	t	federico	127	7	x,x,x,x,x;P,Q,R	1
272		3.4	t	minender	9	1	;	1
273	Identity of $\\equiv$	3.3.a	t	minender	7	1	;q	1
274	Symmetry of $\\equiv$	3.2.b	f	minender	3	1	;p,q	1
275	Antisymmetry	3.81	t	federico	92	5	;p,q	1
276	Weakening/strengthening	3.76.a	t	federico	83	5	;p,q	1
277	Weakening/strengthening	3.76.c	t	federico	85	5	;p,q	1
278	Weakening/strengthening	3.76.d	t	federico	86	5	;p,q,r	1
279	Weakening/strengthening	3.76.e	t	federico	87	5	;p,q,r	1
280	Transitivity	3.82.a	t	federico	93	5	;p,q,r	1
281	Replace by $true$	3.85.b	t	federico	101	6	;E,p,q	1
282	Replace by $false$	3.86.a	t	federico	102	6	;E,p	1
283	Replace by $false$	3.86.b	t	federico	103	6	;E,p,q	1
284	Trading	9.4.a	t	federico	121	7	x,x,x,x;P,Q,R	1
285	Trading	9.4.b	t	federico	122	7	x,x,x,x;P,Q,R	1
286	Trading	9.4.c	t	federico	123	7	x,x,x,x;P,Q,R	1
287	Trading	9.4.d	t	federico	124	7	x,x,x,x;P,Q,R	1
288		9.9	f	federico	128	7	x,x,x,x,x,x;P,Q,R	1
290		9.24.b	t	AdminTeoremas	176	8	x,x,x;P	1
289	Trading	9.19	t	federico	137	8	x,x,x;P,R	1
291	Trading	9.20	t	federico	138	8	x,x,x,x;P,Q,R	1
292	Distributivity of $\\wedge$ over $\\exists$	9.21	t	federico	139	8	x,x,x,x;P,Q,R	1
293		9.22	t	federico	140	8	x,x,x;P,R	1
294	Instantiation	9.13	f	federico	132	7	x;P,e	1
295	Range weakening/strengthening	9.25	f	federico	143	8	x,x,x,x;P,Q,R	1
299		10.1	f	AdminTeoremas	177	10	A,B,x,x;	2
300		10.3	f	AdminTeoremas	178	10	U,A,B,x,x;P	2
301		10.4	f	AdminTeoremas	179	10	a,b,A,B,x,x;	2
302		10.5	f	AdminTeoremas	180	10	B,A,D,x,C,C,x,C,C;	2
303		10.6	f	AdminTeoremas	181	10	B,A,C,x,x;	2
304		28	f	AdminTeoremas	182	10	;A,B,x	2
305		29	f	AdminTeoremas	183	10	;A,B,x	2
306		30	f	AdminTeoremas	184	10	;x	2
307		31	f	AdminTeoremas	185	10	C,C;B,x	2
308		32	f	AdminTeoremas	186	10	;A,B,x	2
309		33	f	AdminTeoremas	187	10	;	2
310		34	f	AdminTeoremas	188	10	;	2
311		35	f	AdminTeoremas	189	10	;A,B	2
312		36	f	AdminTeoremas	190	10	;A,B	2
313		37	f	AdminTeoremas	191	10	x;A	2
314		38	f	AdminTeoremas	192	10	;A,B,C	2
315		39	f	AdminTeoremas	193	10	;A,B	2
316		40	f	AdminTeoremas	194	10	C;A,B	2
317		41	f	AdminTeoremas	195	10	;A,B	2
318		42	f	AdminTeoremas	196	10	;A,B	2
319		43	f	AdminTeoremas	197	10	;A,B,C	2
320		44	f	AdminTeoremas	198	10	;	2
321		45	f	AdminTeoremas	199	10	;A,B	2
322		46	f	AdminTeoremas	200	10	;A,B	2
323		47	f	AdminTeoremas	201	10	;A	2
324		48	f	AdminTeoremas	202	10	;A	2
325		49	f	AdminTeoremas	203	10	;A	2
326		50	f	AdminTeoremas	204	10	A,B;	2
327		51	f	AdminTeoremas	205	10	A,B,C;	2
328		52	f	AdminTeoremas	206	10	;a,b	2
329		53	f	AdminTeoremas	207	10	;a,b	2
330		54	f	AdminTeoremas	208	10	;a,b	2
331		55	f	AdminTeoremas	209	10	;a,b	2
332		56	f	AdminTeoremas	210	10	;a,b,c,d	2
333		57	f	AdminTeoremas	211	10	a,b;A,B,x	2
334		58	f	AdminTeoremas	212	10	;A,B,a,b	2
335		59	f	AdminTeoremas	213	10	;A,B	2
336		60	f	AdminTeoremas	214	10	x,x;A,B	2
337		61	f	AdminTeoremas	215	10	;A,B	2
338		62	f	AdminTeoremas	216	10	a,b;A,B,x	2
339		63	f	AdminTeoremas	217	10	;A,B,C	2
340		64	f	AdminTeoremas	218	10	;R,S,w	2
341		65	f	AdminTeoremas	219	10	x,y,z;R,S,w	2
342		66	f	AdminTeoremas	220	10	;A,B,C	2
343		67	f	AdminTeoremas	221	10	;R,S	2
344		27.a	f	AdminTeoremas	222	9	x,y,x;R	2
345		27.b	f	AdminTeoremas	223	9	y,x,y;R	2
346		68	f	AdminTeoremas	224	10	y;R,z	2
347		69	f	AdminTeoremas	225	10	x;R,z	2
348		10.1	f	federico	177	10	A,B,x,x;	2
\.


--
-- Name: resuelve_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.resuelve_id_seq', 348, true);


--
-- Data for Name: simbolo; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid, tipo) FROM stdin;
2	\\Rightarrow	2	t	3	2	%(a2) %(op) %(aa1)	1	b->b->b
3	\\Leftarrow	2	t	3	2	%(aa2) %(op) %(a1)	1	b->b->b
4	\\vee	2	t	4	3	%(a2) %(op) %(a1)	1	b->b->b
5	\\wedge	2	t	4	3	%(a2) %(op) %(a1)	1	b->b->b
6	\\not\\equiv	2	t	3	4	%(a2) %(op) %(a1)	1	b->b->b
10	 	2	f	3	7	%(aa1) . %(a2)	1	(*->*)->*->*
19	 	2	f	3	7	\\{%(v1) \\in %(na2) | %(na1) \\}	2	(t->b)->(t->t)->t
7	\\neg	1	f	1	5	%(op) %(aa1)	1	b->b
8	true	0	f	0	0	%(op)	1	b
9	false	0	f	0	0	%(op)	1	b
12	\\forall	2	f	3	6	(%(op) %(v1)| %(na2) : %(na1))	1	(t->b)->(t->b)->b
13	\\exists	1	f	3	6	(%(op) %(v1) |: %(na1))	1	(t->b)->b
14	\\exists	2	f	3	6	(%(op) %(v1) | %(na2) : %(na1) )	1	(t->b)->(t->b)->b
16	\\in	2	f	3	7	%(a2) %(op) %(a1)	2	t->t->b
11	\\forall	1	f	3	6	( %(op) %(v1) |: %(na1) )	1	(t->b)->b
17	\\notin	2	f	3	7	%(a2) %(op) %(a1)	2	t->t->b
18	\\emptyset	0	f	3	0	%(op)	2	t
20	 	1	f	3	7	\\{ %(na1) \\}	2	t->t
22	\\bigcup	1	f	3	8	%(op) %(a1)	2	t->t
24	\\cup	2	f	3	7	%(aa2) %(op) %(a1)	2	t->t->t
25	\\cap	2	f	3	7	%(aa2) %(op) %(a1)	2	t->t->t
23	\\bigcap	1	f	3	8	%(op) %(a1)	2	t->t
26	\\subset	2	f	3	6	%(a2) %(op) %(a1)	2	t->t->b
27	\\subseteq	2	f	3	6	%(a2) %(op) %(a1)	2	t->t->b
28	\\supset	2	f	3	6	%(a2) %(op) %(a1)	2	t->t->b
29	\\supseteq	2	f	3	6	%(a2) %(op) %(a1)	2	t->t->b
30	\\setminus	2	f	3	8	%(a2) %(op) %(a1)	2	t->t->t
31	 	2	f	3	8	\\langle %(na2) , %(na1)\\rangle	2	t->t->t
32	\\times	2	f	3	8	%(a2) %(op) %(a1)	2	t->t->t
34	\\circ	2	f	3	9	%(a2) %(op) %(a1)	2	t->t->t
35	\\mathcal{P}	1	f	3	8	%(op) ( %(na1) )	2	t->t
36	\\mathbb{Z}	0	f	3	0	%(op)	2	t
37	\\mathbb{B}	0	f	3	0	%(op)	2	t
59	\\neq	2	f	3	7	%(na2) %(op) %(na1)	2	t->t->b
39	id	1	f	3	9	%(op)_{%(na1) }	2	t->t
40	abort	0	f	3	0	%(op)	2	t
41	 	1	f	3	9	%(a1)^{c}	2	t->t
21	 	2	f	3	7	%(na2) , %(na1)	2	t->t->t
33	 	1	f	3	8	( %(na1) )	2	t->t
42	0	0	f	3	0	%(op)	2	t
43	1	0	f	3	0	%(op)	2	t
44	2	0	f	3	0	%(op)	2	t
45	3	0	f	3	0	%(op)	2	t
46	4	0	f	3	0	%(op)	2	t
47	5	0	f	3	0	%(op)	2	t
48	6	0	f	3	0	%(op)	2	t
49	7	0	f	3	0	%(op)	2	t
50	8	0	f	3	0	%(op)	2	t
51	9	0	f	3	0	%(op)	2	t
52	S	1	f	3	10	%(op)(%(na1) )	2	t->t
53	P	1	f	3	9	%(op)(%(na1) )	2	t->t
54	 	2	f	3	10	%(na1) %(na2)	2	t->t->t
55	+	2	f	3	9	%(a2) %(op) %(a1)	2	t->t->t
56	-	2	f	3	9	%(a2) %(op) %(a1)	2	t->t->t
57	*	2	f	3	9	%(a2) %(op) %(a1)	2	t->t->t
58	 	3	f	3	10	%(a3) ( %(a2) : %(a1) )	2	t->t->(t->t)->(t->t)
1	\\equiv	2	f	3	1	%(a2) %(op) %(a1)	1	b->b->b
38	 	3	f	3	9	%(a1)^{[%(na2)..%(na3)]}	2	t->t->t->t
15	=	2	f	3	7	%(na2) %(op) %(na1)	1	t->t->b
60	Dom	1	f	3	9	%(op)(%(na1) )	2	t->t
61	Rg	1	f	3	9	%(op)(%(na1) )	2	t->t
\.


--
-- Name: simbolo_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.simbolo_id_seq', 61, true);


--
-- Data for Name: solucion; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.solucion (id, resuelveid, resuelto, demostracion, metodo) FROM stdin;
18	184	t	S (S (I^{[x_{113} := c_{8}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})})	DM
19	185	t	S (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	SS
30	195	t	S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} A^{= (c_{7} c_{8}) c_{9}} (S (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{ccb} c_{7} c_{1} \\Phi_{cbb}) (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7})})) (S (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))})) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})))	SS
17	183	t	S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113} := c_{8}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (I^{[x_{113},x_{114} := c_{8},c_{8}]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{4} \\Phi_{cbcb})}) (S (I^{[x_{113} := (c_{4} c_{8} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))	SS
20	185	t	S (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	SS
21	186	t	M_{4} (S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{112},x_{114} := x_{113},x_{112}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}) (S (I^{[x_{114} := (c_{1} x_{112} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}))) (M_{1}^{1} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}))	EO DM
16	182	t	I^{[x_{113} := c_{8}]} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} c_{8} x_{112})} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))}) (L^{\\lambda x_{122}.c_{1} c_{8} x_{122}} (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} c_{8} x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})	SS
22	187	t	M_{4} (S (S (I^{[x_{114} := (c_{1} x_{112} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (M_{1}^{1} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}))	EO DM
23	188	t	M_{4} (S (I^{[x_{112},x_{114} := (c_{1} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}) (M_{1}^{1} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}))	EO DM
28	193	t	M_{4} (S (S (I^{[x_{112},x_{113} := c_{9},c_{8}]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))}) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{112},x_{113} := c_{9},c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{112},x_{113} := c_{8},c_{9}]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))}) (S (L^{\\lambda x_{122}.c_{1} c_{9} x_{122}} A^{= (c_{7} c_{8}) c_{9}}))) (I^{[x_{113} := c_{9}]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	EO DM
24	189	t	M_{4} (S (S (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} (I^{[x_{114} := x_{113}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (I^{[x_{112},x_{114} := (c_{1} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (M_{1}^{1} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}))	EO DM
29	194	t	A^{= (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7})) (\\Phi_{cb} c_{6} \\Phi_{cb})} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))}	SS
40	205	t	I^{[x_{113} := x_{112}]} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{112} x_{112})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (S (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})	SS
26	191	t	S A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))} (L^{\\lambda x_{122}.c_{7} x_{122}} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))}) (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})	SS
31	196	t	A^{= (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7})) (\\Phi_{cb} c_{6} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{7} x_{122}} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7})) (\\Phi_{cb} c_{6} \\Phi_{cb})}))	SS
9	174	f	S (L^{\\lambda x_{122}.c_{11} (\\lambda x_{65}.c_{11} (\\lambda x_{66}.x_{122}))} (I^{[x_{112},x_{113} := (c_{11} (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))),(c_{15} x_{66} x_{65})]} A^{= (\\Phi_{cb} c_{1} \\Phi_{cb}) (\\Phi_{c(bb,)} c_{2} (\\Phi_{(bb,cb)} c_{5}) c_{2})}))	DM
27	192	t	M_{4} (S (S (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))}) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{113} := (c_{7} x_{112})]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))})) (I^{[x_{113} := (c_{7} x_{112})]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	EO DM
25	190	t	M_{4} (S (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} c_{9} x_{112})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (S (I^{[x_{113},x_{114} := c_{9},x_{112}]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{4} \\Phi_{cbcb})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112},x_{113} := c_{9},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})}))) A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})	EO DM
73	234	t	I^{[x_{112},x_{113} := (c_{5} (c_{1} x_{102} x_{101}) x_{113}),(x_{69} x_{101})]} A^{= (\\Phi_{c(cb,)} c_{5} c_{2} \\Phi_{cbcb}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{2} x_{122} (c_{5} (c_{1} x_{102} x_{101}) x_{113})} (I^{[x_{112},x_{113},x_{114} := x_{113},(c_{1} x_{102} x_{101}),(x_{69} x_{101})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{2} (c_{5} x_{122} x_{113}) (c_{5} (c_{1} x_{102} x_{101}) x_{113})} A^{= (\\Phi_{bb} (\\Phi_{cb} c_{1}) (\\Phi_{(bb,cb)} c_{5})) (\\Phi_{b} (\\Phi_{c(bbb,)} c_{1} \\Phi_{bcb} c_{5}))}) (S (L^{\\lambda x_{122}.c_{2} x_{122} (c_{5} (c_{1} x_{102} x_{101}) x_{113})} (I^{[x_{112},x_{113},x_{114} := x_{113},(c_{1} x_{102} x_{101}),(x_{69} x_{102})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))}))) (S (I^{[x_{112},x_{113} := (c_{5} (c_{1} x_{102} x_{101}) x_{113}),(x_{69} x_{102})]} A^{= (\\Phi_{c(cb,)} c_{5} c_{2} \\Phi_{cbcb}) (\\Phi_{cb} c_{2} \\Phi_{cb})}))	SS
32	197	t	S (I^{[x_{113} := (c_{6} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{6} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{7} x_{112})} (I^{[x_{112},x_{113} := x_{113},x_{114}]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{6} \\Phi_{cb})})) (S (I^{[x_{113} := (c_{1} x_{114} (c_{7} x_{113}))]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))})) (S (L^{\\lambda x_{122}.c_{7} (c_{1} x_{122} x_{112})} (I^{[x_{112},x_{113} := x_{113},x_{114}]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))}))) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{ccb} c_{7} c_{1} \\Phi_{cbb}) (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7})}))) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))}))) (S (L^{\\lambda x_{122}.c_{7} (c_{7} x_{122})} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))})) (L^{\\lambda x_{122}.c_{7} (c_{1} x_{114} x_{122})} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))}) (S (L^{\\lambda x_{122}.c_{7} (c_{1} x_{114} x_{122})} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{6} \\Phi_{cb})})) (I^{[x_{112},x_{113} := (c_{6} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))}) (S (I^{[x_{112},x_{113} := (c_{6} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{6} \\Phi_{cb})})))	SS
34	199	t	L^{\\lambda x_{122}.c_{1} x_{114} x_{122}} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{6} \\Phi_{cb})} (S (L^{\\lambda x_{122}.c_{1} x_{114} x_{122}} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))})) (S (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))})) (L^{\\lambda x_{122}.c_{7} x_{122}} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}) (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))}) (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{ccb} c_{7} c_{1} \\Phi_{cbb}) (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7})}) (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{112},x_{113} := x_{113},x_{114}]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))})) (S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{112},x_{113} := x_{113},x_{114}]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{6} \\Phi_{cb})})))	SS
33	198	t	L^{\\lambda x_{122}.c_{1} x_{114} x_{122}} A^{= (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7})) (\\Phi_{cb} c_{6} \\Phi_{cb})} (S (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))})) (L^{\\lambda x_{122}.c_{7} x_{122}} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}) (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))}) (S (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{6} \\Phi_{cb})}))	SS
118	289	t	A^{= (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) c_{12} (\\Phi_{bb} c_{7})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{14} \\Phi_{b})} (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{80} := (\\lambda x_{120}.c_{7} (x_{80} x_{120}))]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{11}) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12} \\Phi_{b})})) (L^{\\lambda x_{122}.c_{7} (c_{11} (\\lambda x_{120}.x_{122}))} (I^{[x_{112},x_{113} := (x_{82} x_{120}),(c_{7} (x_{80} x_{120}))]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{7} (c_{11} (\\lambda x_{120}.x_{122}))} (I^{[x_{112},x_{113} := (x_{82} x_{120}),(x_{80} x_{120})]} A^{= (\\Phi_{ccbb} c_{7} c_{4} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{5} (\\Phi_{bcb} c_{7}))}))) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{80} := (\\lambda x_{120}.c_{7} (c_{5} (x_{80} x_{120}) (x_{82} x_{120})))]} A^{= (\\Phi_{bb} c_{11} \\Phi_{b}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) c_{12} \\Phi_{b})}))) (S (I^{[x_{80},x_{82} := (\\lambda x_{120}.c_{5} (x_{80} x_{120}) (x_{82} x_{120})),(\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) c_{12} (\\Phi_{bb} c_{7})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{14} \\Phi_{b})})) (I^{[x_{80} := (\\lambda x_{120}.c_{5} (x_{80} x_{120}) (x_{82} x_{120}))]} A^{= (\\Phi_{bb} c_{13} \\Phi_{b}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) c_{14} \\Phi_{b})})	SS
108	279	t	S (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),(c_{5} (c_{4} x_{114} x_{113}) x_{112})]} A^{= (\\Phi_{cb} c_{4} (\\Phi_{(b,cb)} c_{1})) (\\Phi_{cb} c_{2} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{4} x_{114} x_{113}) x_{112}) x_{122}} (I^{[x_{112},x_{113},x_{114} := (c_{5} x_{113} x_{112}),x_{112},(c_{4} x_{114} x_{113})]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{4} \\Phi_{cbcb})})) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{4} x_{114} x_{113}) x_{112}) (c_{5} (c_{4} (c_{4} x_{114} x_{113}) (c_{5} x_{113} x_{112})) x_{122})} (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{4} x_{114} x_{113}) x_{112}) (c_{5} (c_{4} (c_{4} x_{114} x_{113}) (c_{5} x_{113} x_{112})) x_{122})} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{5} c_{4} \\Phi_{cbcb})}) (S (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{4} x_{114} x_{113}) x_{112}) (c_{5} x_{122} x_{112})} (I^{[x_{112} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{4} x_{114} x_{113}) x_{112}) (c_{5} (c_{4} x_{114} x_{122}) x_{112})} (I^{[x_{112} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{4} x_{114} x_{113}) x_{112}) (c_{5} (c_{4} x_{114} x_{122}) x_{112})} (I^{[x_{112},x_{113},x_{114} := x_{113},x_{112},x_{113}]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{4} \\Phi_{cbcb})})) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{4} x_{114} x_{113}) x_{112}) (c_{5} (c_{4} x_{114} (c_{5} x_{122} (c_{4} x_{112} x_{113}))) x_{112})} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{4} x_{114} x_{113}) x_{112}) (c_{5} (c_{4} x_{114} x_{122}) x_{112})} (I^{[x_{112} := (c_{4} x_{112} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{4} x_{114} x_{113}) x_{112}) (c_{5} (c_{4} x_{114} x_{122}) x_{112})} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{4} c_{5} \\Phi_{cbcb})}))) (I^{[x_{113} := (c_{5} (c_{4} x_{114} x_{113}) x_{112})]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})})	DM
119	291	t	I^{[x_{82} := (\\lambda x_{120}.c_{5} (x_{82} x_{120}) (x_{81} x_{120}))]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{13}) (\\Phi_{(bb,b)} c_{5})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{14} \\Phi_{b})} (L^{\\lambda x_{122}.c_{13} (\\lambda x_{120}.x_{122})} (I^{[x_{112},x_{113},x_{114} := (x_{81} x_{120}),(x_{82} x_{120}),(x_{80} x_{120})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))})) (S (I^{[x_{80},x_{82} := (\\lambda x_{120}.c_{5} (x_{80} x_{120}) (x_{82} x_{120})),(\\lambda x_{120}.x_{81} x_{120})]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{13}) (\\Phi_{(bb,b)} c_{5})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{14} \\Phi_{b})}))	SS
35	200	t	S (L^{\\lambda x_{122}.c_{4} (c_{4} x_{114} x_{113}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (I^{[x_{113},x_{114} := x_{112},(c_{4} x_{114} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))})) (I^{[x_{113} := (c_{4} x_{114} (c_{4} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112},x_{113},x_{114} := (c_{4} x_{113} x_{112}),x_{114},x_{112}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{4} x_{113} x_{112})} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))	SS
38	203	t	A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{112} x_{113})} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})}))	SS
39	204	t	S (L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} (I^{[x_{112},x_{113} := x_{113},x_{114}]} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})}) (I^{[x_{113} := (c_{1} (c_{4} x_{114} x_{113}) (c_{1} x_{114} x_{113}))]} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{1} (c_{4} x_{114} x_{113}) (c_{1} x_{114} x_{113})) x_{112})} (I^{[x_{113},x_{114} := (c_{1} x_{114} x_{113}),(c_{4} x_{114} x_{113})]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{4} \\Phi_{cbcb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{4} (c_{1} x_{114} x_{113}) x_{112})) (c_{1} (c_{1} (c_{4} x_{114} x_{113}) (c_{1} x_{114} x_{113})) x_{112})} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} (c_{4} x_{113} x_{112})) x_{122}) (c_{1} (c_{1} (c_{4} x_{114} x_{113}) (c_{1} x_{114} x_{113})) x_{112})} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{4} \\Phi_{cbcb})}) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} (c_{4} x_{113} x_{112})) (c_{1} (c_{4} x_{114} x_{112}) (c_{4} x_{113} x_{112}))) x_{122}} (I^{[x_{113},x_{114} := (c_{1} x_{114} x_{113}),(c_{4} x_{114} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} (c_{4} x_{113} x_{112})) (c_{1} (c_{4} x_{114} x_{112}) (c_{4} x_{113} x_{112}))) (c_{1} (c_{4} x_{114} x_{113}) x_{122})} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} (c_{4} x_{113} x_{112})) (c_{1} (c_{4} x_{114} x_{112}) (c_{4} x_{113} x_{112}))) x_{122}} (I^{[x_{112},x_{113},x_{114} := (c_{1} x_{113} x_{112}),x_{114},(c_{4} x_{114} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (I^{[x_{112},x_{113},x_{114} := (c_{1} x_{113} x_{112}),(c_{1} (c_{4} x_{114} x_{113}) x_{114}),(c_{1} (c_{4} x_{114} (c_{4} x_{113} x_{112})) (c_{1} (c_{4} x_{114} x_{112}) (c_{4} x_{113} x_{112})))]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113},x_{114} := x_{114},(c_{4} x_{114} x_{113}),(c_{1} (c_{4} x_{114} (c_{4} x_{113} x_{112})) (c_{1} (c_{4} x_{114} x_{112}) (c_{4} x_{113} x_{112})))]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} x_{122} (c_{4} x_{114} x_{113})) x_{114}) (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113},x_{114} := (c_{4} x_{113} x_{112}),(c_{4} x_{114} x_{112}),(c_{4} x_{114} (c_{4} x_{113} x_{112}))]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113} := x_{114},(c_{1} (c_{1} (c_{1} (c_{4} x_{114} (c_{4} x_{113} x_{112})) (c_{4} x_{114} x_{112})) (c_{4} x_{113} x_{112})) (c_{4} x_{114} x_{113}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{114} x_{122}) (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113} := (c_{4} x_{114} x_{113}),(c_{1} (c_{1} (c_{4} x_{114} (c_{4} x_{113} x_{112})) (c_{4} x_{114} x_{112})) (c_{4} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{114} x_{122}) (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113},x_{114} := (c_{4} x_{113} x_{112}),(c_{1} (c_{4} x_{114} (c_{4} x_{113} x_{112})) (c_{4} x_{114} x_{112})),(c_{4} x_{114} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),(c_{1} (c_{4} x_{114} x_{113}) (c_{1} (c_{4} x_{114} (c_{4} x_{113} x_{112})) (c_{4} x_{114} x_{112})))]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} x_{114} (c_{1} (c_{4} x_{114} x_{113}) x_{122})) (c_{4} x_{113} x_{112})) (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113} := (c_{4} x_{114} x_{112}),(c_{4} x_{114} (c_{4} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} x_{114} x_{122}) (c_{4} x_{113} x_{112})) (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113},x_{114} := (c_{4} x_{114} (c_{4} x_{113} x_{112})),(c_{4} x_{114} x_{112}),(c_{4} x_{114} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} x_{114} (c_{1} (c_{1} (c_{4} x_{114} x_{113}) x_{122}) (c_{4} x_{114} (c_{4} x_{113} x_{112})))) (c_{4} x_{113} x_{112})) (c_{1} x_{113} x_{112})} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} x_{114} (c_{1} (c_{1} x_{122} (c_{4} x_{112} x_{114})) (c_{4} x_{114} (c_{4} x_{113} x_{112})))) (c_{4} x_{113} x_{112})) (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113} := x_{113},x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} x_{114} (c_{1} x_{122} (c_{4} x_{114} (c_{4} x_{113} x_{112})))) (c_{4} x_{113} x_{112})) (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113},x_{114} := x_{114},x_{112},x_{113}]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{4} \\Phi_{cbcb})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} x_{114} (c_{1} (c_{4} (c_{1} x_{113} x_{112}) x_{114}) x_{122})) (c_{4} x_{113} x_{112})) (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} x_{114} x_{122}) (c_{4} x_{113} x_{112})) (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113},x_{114} := x_{114},(c_{4} x_{113} x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{4} \\Phi_{cbcb})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} x_{114} (c_{4} x_{122} x_{114})) (c_{4} x_{113} x_{112})) (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} x_{114} (c_{4} x_{122} x_{114})) (c_{4} x_{113} x_{112})) (c_{1} x_{113} x_{112})} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{4} x_{113} x_{112})) (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113} := (c_{4} (c_{5} x_{113} x_{112}) x_{114}),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} x_{122} x_{114}) (c_{4} x_{113} x_{112})) (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113} := x_{114},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (I^{[x_{114} := (c_{1} (c_{1} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{114}) (c_{4} x_{113} x_{112}))]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}) (S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{112},x_{113},x_{114} := x_{113},(c_{4} x_{113} x_{112}),(c_{1} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{114})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}))) (S (I^{[x_{113},x_{114} := (c_{1} (c_{4} x_{113} x_{112}) x_{113}),(c_{1} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{114})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{114}) x_{122}} (I^{[x_{114} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{114}) x_{122}} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (I^{[x_{112},x_{113},x_{114} := (c_{5} x_{113} x_{112}),x_{114},(c_{4} x_{114} (c_{5} x_{113} x_{112}))]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (S (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})})))	SS
74	240	t	S (I^{[x_{112},x_{113} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{4} (c_{7} x_{112}) x_{122}} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}))	SS
36	201	t	M_{4} (S (S (I^{[x_{112},x_{113},x_{114} := (c_{4} x_{113} x_{112}),(c_{4} (c_{7} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}) (S (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} (I^{[x_{114} := (c_{7} x_{113})]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{4} \\Phi_{cbcb})}))) (S (L^{\\lambda x_{122}.c_{1} x_{112} (c_{4} x_{122} x_{112})} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{ccb} c_{7} c_{1} \\Phi_{cbb}) (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7})}))) (S (L^{\\lambda x_{122}.c_{1} x_{112} (c_{4} x_{122} x_{112})} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))}))) (S (L^{\\lambda x_{122}.c_{1} x_{112} (c_{4} (c_{7} x_{122}) x_{112})} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})})) (S (L^{\\lambda x_{122}.c_{1} x_{112} (c_{4} x_{122} x_{112})} A^{= (c_{7} c_{8}) c_{9}})) (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})) (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	EO DM
37	202	t	M_{4} (S (I^{[x_{112},x_{113},x_{114} := (c_{4} x_{113} x_{112}),(c_{4} (c_{7} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}) (M_{1}^{1} A^{= (\\Phi_{cc(bb,)} c_{7} c_{4} \\Phi_{bcbb} c_{1}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))	EO DM
41	206	t	I^{[x_{113} := c_{9}]} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} c_{9} x_{112})} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))}) (S (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (S (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))})) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (S A^{= (c_{7} c_{8}) c_{9}})	SS
43	208	t	I^{[x_{113} := (c_{7} x_{112})]} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{7} x_{112}) x_{112})} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112},x_{113} := (c_{1} (c_{7} x_{112}) x_{112}),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113} := (c_{1} (c_{7} x_{112}) x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}) (S (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{ccb} c_{7} c_{1} \\Phi_{cbb}) (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7})})) (S (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))})) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (S A^{= (c_{7} c_{8}) c_{9}})	SS
75	241	t	S (L^{\\lambda x_{122}.c_{1} (c_{5} x_{114} x_{112}) x_{122}} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{112}) (c_{1} x_{113} x_{112}))} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (I^{[x_{112},x_{113},x_{114} := (c_{1} x_{113} x_{112}),(c_{4} x_{113} x_{112}),(c_{1} (c_{4} x_{114} x_{112}) (c_{1} x_{114} x_{112}))]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113},x_{114} := (c_{4} x_{113} x_{112}),(c_{1} x_{114} x_{112}),(c_{4} x_{114} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) x_{122}) (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),(c_{1} x_{114} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113},x_{114} := (c_{1} x_{114} x_{112}),(c_{4} x_{113} x_{112}),(c_{4} x_{114} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{1} x_{114} x_{112})) (c_{1} x_{113} x_{112})} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{4} \\Phi_{cbcb})})) (S (I^{[x_{112},x_{113},x_{114} := (c_{1} x_{113} x_{112}),(c_{1} x_{114} x_{112}),(c_{4} (c_{1} x_{114} x_{113}) x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{114} x_{113}) x_{112}) x_{122}} (I^{[x_{114} := (c_{1} x_{114} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{114} x_{113}) x_{112}) (c_{1} (c_{1} x_{122} x_{113}) x_{112})} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{114} x_{113}) x_{112}) (c_{1} x_{122} x_{112})} (I^{[x_{112},x_{113},x_{114} := x_{113},x_{114},x_{112}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{114} x_{113}) x_{112}) (c_{1} x_{122} x_{112})} (I^{[x_{112},x_{113} := (c_{1} x_{114} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{114} x_{113}) x_{112}) x_{122}} (I^{[x_{113},x_{114} := x_{112},(c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}))) (S (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{114} x_{113}) x_{112}) (c_{1} (c_{1} x_{114} x_{113}) x_{122})} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{114} x_{113}) x_{112}) x_{122}} (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} x_{113})} (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} x_{113})} (I^{[x_{112},x_{113} := (c_{1} x_{114} x_{113}),x_{112}]} A^{= (\\Phi_{cc(bb,)} c_{7} c_{4} \\Phi_{bcbb} c_{1}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} x_{113})} (I^{[x_{112},x_{113} := (c_{4} (c_{7} x_{112}) (c_{1} x_{114} x_{113})),(c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (I^{[x_{112},x_{113},x_{114} := (c_{1} x_{114} x_{113}),(c_{1} x_{114} x_{113}),(c_{4} (c_{7} x_{112}) (c_{1} x_{114} x_{113}))]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{7} x_{112}) (c_{1} x_{114} x_{113})) x_{122}} (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{113} := (c_{4} (c_{7} x_{112}) (c_{1} x_{114} x_{113}))]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}) (I^{[x_{112},x_{113} := (c_{1} x_{114} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})})))	SS
42	207	t	S (L^{\\lambda x_{122}.c_{5} (c_{5} x_{114} x_{113}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})}) (I^{[x_{113},x_{114} := x_{112},(c_{5} x_{114} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))}) (S (L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))})) (I^{[x_{113} := (c_{5} x_{114} (c_{5} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}) (I^{[x_{112},x_{113},x_{114} := (c_{5} x_{113} x_{112}),x_{114},x_{112}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{5} x_{113} x_{112})} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))	SS
77	243	t	S (L^{\\lambda x_{122}.c_{11} (\\lambda x_{120}.x_{122})} (I^{[x_{112} := c_{8}]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})) (L^{\\lambda x_{122}.c_{11} (\\lambda x_{120}.c_{4} x_{122} c_{8})} A^{= (c_{7} c_{8}) c_{9}}) (L^{\\lambda x_{122}.c_{11} (\\lambda x_{120}.x_{122})} (I^{[x_{112},x_{113} := c_{8},(c_{7} c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{11} (\\lambda x_{120}.x_{122})} (I^{[x_{112},x_{113} := c_{8},c_{8}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}))) (S (I^{[x_{80},x_{82} := (\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{11}) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12} \\Phi_{b})})) (S (L^{\\lambda x_{122}.c_{12} (\\lambda x_{120}.x_{122}) (\\lambda x_{120}.c_{8})} (I^{[x_{112} := c_{8}]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}))) (S (I^{[x_{80},x_{81},x_{82} := c_{8},(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{bcb} (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12}) c_{4} \\Phi_{cbb}) (\\Phi_{ccbcb} \\Phi_{b} c_{12} (\\Phi_{cbbb} \\Phi_{b}) c_{4} \\Phi_{cbbb})})) (I^{[x_{112},x_{113} := c_{8},(c_{12} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{8}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{12} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{8}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})	SS
76	242	t	S (S (L^{\\lambda x_{122}.c_{4} (c_{11} (\\lambda x_{120}.x_{122})) x_{80}} (I^{[x_{112} := (c_{7} (x_{82} x_{120}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})) (S (L^{\\lambda x_{122}.c_{4} (c_{11} (\\lambda x_{120}.x_{122})) x_{80}} (I^{[x_{112},x_{113} := (x_{82} x_{120}),c_{9}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}))) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{80}} (I^{[x_{80} := (\\lambda x_{120}.c_{9})]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{11}) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12} \\Phi_{b})}))) (I^{[x_{81} := (\\lambda x_{120}.c_{9})]} A^{= (\\Phi_{bcb} (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12}) c_{4} \\Phi_{cbb}) (\\Phi_{ccbcb} \\Phi_{b} c_{12} (\\Phi_{cbbb} \\Phi_{b}) c_{4} \\Phi_{cbbb})}) (L^{\\lambda x_{122}.c_{12} (\\lambda x_{120}.x_{122}) (\\lambda x_{120}.x_{82} x_{120})} (I^{[x_{112} := x_{80}]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})))	SS
64	229	t	A^{= (\\Phi_{cb} c_{4} (\\Phi_{(b,cb)} c_{1})) (\\Phi_{cb} c_{2} \\Phi_{cb})} (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} x_{113} x_{112})} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} x_{113} x_{112})} (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} x_{113}) (c_{4} x_{113} x_{112})} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})})) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} x_{113} x_{112})} (I^{[x_{112},x_{113},x_{114} := x_{113},x_{112},x_{112}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{112} x_{122}) (c_{4} x_{113} x_{112})} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (I^{[x_{112},x_{113},x_{114} := (c_{4} x_{113} x_{112}),(c_{1} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})}))	SS
57	222	t	I^{[x_{113},x_{114} := x_{112},x_{113}]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{4} \\Phi_{cbcb})} (L^{\\lambda x_{122}.c_{5} (c_{4} x_{113} x_{112}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{4} c_{5} \\Phi_{cbcb})}	SS
46	211	t	S (I^{[x_{112},x_{113},x_{114} := (c_{5} x_{113} x_{112}),x_{112},x_{114}]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{4} \\Phi_{cbcb})} (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} (c_{5} x_{113} x_{112}) x_{112})} (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{5} x_{113} x_{112}) x_{114}) x_{122}} (I^{[x_{113},x_{114} := x_{112},x_{113}]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{4} \\Phi_{cbcb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{5} x_{113} x_{112}) x_{114}) (c_{5} (c_{4} x_{113} x_{112}) x_{122})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{5} x_{113} x_{112}) x_{114}) x_{122}} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{5} x_{113} x_{112}) x_{114}) (c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{112}) x_{112}))} (I^{[x_{113},x_{114} := x_{112},x_{113}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{5} x_{113} x_{112}) x_{114}) (c_{1} (c_{4} x_{113} x_{122}) (c_{1} (c_{4} x_{113} x_{112}) x_{112}))} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{5} x_{113} x_{112}) x_{114}) x_{122}} (I^{[x_{113},x_{114} := (c_{4} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{5} x_{113} x_{112}) x_{114}) (c_{1} x_{122} x_{112})} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{5} x_{113} x_{112}) x_{114}) x_{122}} (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{5} x_{113} x_{112}) x_{114}) x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} (I^{[x_{112},x_{113},x_{114} := x_{114},x_{112},x_{113}]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{4} \\Phi_{cbcb})})) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{4} x_{112} x_{114})) x_{112}} (I^{[x_{112} := x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{112},x_{113},x_{114} := x_{112},(c_{4} x_{112} x_{114}),(c_{4} x_{114} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) x_{122}} (I^{[x_{113} := (c_{4} x_{112} x_{114})]} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} (c_{4} x_{122} x_{112}) (c_{1} (c_{4} x_{112} x_{114}) x_{112}))} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} x_{122} (c_{1} (c_{4} x_{112} x_{114}) x_{112}))} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} (c_{4} x_{114} x_{122}) (c_{1} (c_{4} x_{112} x_{114}) x_{112}))} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} (c_{4} x_{114} x_{112}) (c_{1} x_{122} x_{112}))} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) x_{122}} (I^{[x_{113},x_{114} := (c_{4} x_{114} x_{112}),(c_{4} x_{114} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} x_{122} x_{112})} (I^{[x_{113} := (c_{4} x_{114} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) x_{122}} (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})))	SS
50	215	t	L^{\\lambda x_{122}.c_{5} (c_{1} x_{112} x_{114}) x_{122}} A^{= (\\Phi_{c(ccbb,)} c_{5} c_{7} c_{5} (\\Phi_{(bcbb,cb)} c_{4}) c_{7}) (\\Phi_{cb} c_{1} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112}))} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{c(ccbb,)} c_{5} c_{7} c_{5} (\\Phi_{(bcbb,cb)} c_{4}) c_{7}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{112},x_{113},x_{114} := (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})),(c_{5} x_{112} x_{114}),(c_{5} (c_{7} x_{112}) (c_{7} x_{114}))]} A^{= (\\Phi_{c(ccb,)} c_{5} \\Phi_{cbcb} c_{4} (\\Phi_{cccbcb} c_{5})) (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{5} \\Phi_{cbcb})}) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{5} (c_{7} x_{112}) (c_{7} x_{114})) (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112}))) x_{122}} (I^{[x_{112},x_{113} := (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})),(c_{5} x_{112} x_{114})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{5} (c_{7} x_{112}) (c_{7} x_{114})) (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112}))) x_{122}} (I^{[x_{112},x_{113},x_{114} := (c_{5} x_{112} x_{114}),(c_{5} x_{113} x_{112}),(c_{5} (c_{7} x_{113}) (c_{7} x_{112}))]} A^{= (\\Phi_{c(ccb,)} c_{5} \\Phi_{cbcb} c_{4} (\\Phi_{cccbcb} c_{5})) (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{5} \\Phi_{cbcb})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{113} x_{112}) (c_{5} x_{112} x_{114})))} (I^{[x_{112},x_{113} := (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})),(c_{5} (c_{7} x_{112}) (c_{7} x_{114}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{113} x_{112}) (c_{5} x_{112} x_{114})))} (I^{[x_{112},x_{113},x_{114} := (c_{5} (c_{7} x_{112}) (c_{7} x_{114})),(c_{5} x_{113} x_{112}),(c_{5} (c_{7} x_{113}) (c_{7} x_{112}))]} A^{= (\\Phi_{c(ccb,)} c_{5} \\Phi_{cbcb} c_{4} (\\Phi_{cccbcb} c_{5})) (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{5} \\Phi_{cbcb})})) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{112}) (c_{7} x_{114}))) (c_{5} (c_{5} x_{113} x_{112}) (c_{5} (c_{7} x_{112}) (c_{7} x_{114})))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) x_{122})} (I^{[x_{112},x_{113},x_{114} := x_{114},x_{112},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{112}) (c_{7} x_{114}))) (c_{5} (c_{5} x_{113} x_{112}) (c_{5} (c_{7} x_{112}) (c_{7} x_{114})))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} x_{122} x_{114}))} (I^{[x_{113},x_{114} := x_{112},x_{113}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{112}) (c_{7} x_{114}))) (c_{5} (c_{5} x_{113} x_{112}) (c_{5} (c_{7} x_{112}) (c_{7} x_{114})))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{113} x_{122}) x_{114}))} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})}) (S (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{112}) (c_{7} x_{114}))) (c_{5} (c_{5} x_{113} x_{112}) (c_{5} (c_{7} x_{112}) (c_{7} x_{114})))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{122} x_{112}) x_{114}))} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})}))) (S (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{112}) (c_{7} x_{114}))) (c_{5} (c_{5} x_{113} x_{112}) (c_{5} (c_{7} x_{112}) (c_{7} x_{114})))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} x_{122} x_{114}))} (I^{[x_{114} := x_{113}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{112}) (c_{7} x_{114}))) (c_{5} (c_{5} x_{113} x_{112}) (c_{5} (c_{7} x_{112}) (c_{7} x_{114})))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} x_{122} x_{114}))} (I^{[x_{112} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{112}) (c_{7} x_{114}))) (c_{5} (c_{5} x_{113} x_{112}) (c_{5} (c_{7} x_{112}) (c_{7} x_{114})))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{122} x_{113}) x_{114}))} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}) (S (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{112}) (c_{7} x_{114}))) (c_{5} (c_{5} x_{113} x_{112}) (c_{5} (c_{7} x_{112}) (c_{7} x_{114})))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) x_{122})} (I^{[x_{112},x_{113},x_{114} := x_{114},x_{113},(c_{5} x_{112} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{4} (c_{4} x_{122} (c_{5} (c_{5} x_{113} x_{112}) (c_{5} (c_{7} x_{112}) (c_{7} x_{114})))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{114}),(c_{7} x_{112}),(c_{5} (c_{7} x_{113}) (c_{7} x_{112}))]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} x_{122} (c_{7} x_{114})) (c_{5} (c_{5} x_{113} x_{112}) (c_{5} (c_{7} x_{112}) (c_{7} x_{114})))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{112}),(c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) x_{122}) (c_{7} x_{114})) (c_{5} (c_{5} x_{113} x_{112}) (c_{5} (c_{7} x_{112}) (c_{7} x_{114})))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112} := (c_{7} x_{112})]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})})) (S (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} x_{122} (c_{7} x_{112})) (c_{7} x_{114})) (c_{5} (c_{5} x_{113} x_{112}) (c_{5} (c_{7} x_{112}) (c_{7} x_{114})))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112} := (c_{7} x_{113})]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})}))) (S (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} x_{122} (c_{7} x_{114})) (c_{5} (c_{5} x_{113} x_{112}) (c_{5} (c_{7} x_{112}) (c_{7} x_{114})))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{112}),(c_{7} x_{113}),(c_{7} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) x_{122}) (c_{7} x_{114})) (c_{5} (c_{5} x_{113} x_{112}) (c_{5} (c_{7} x_{112}) (c_{7} x_{114})))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} x_{122} (c_{7} x_{114})) (c_{5} (c_{5} x_{113} x_{112}) (c_{5} (c_{7} x_{112}) (c_{7} x_{114})))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{113}),(c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{4} (c_{4} x_{122} (c_{5} (c_{5} x_{113} x_{112}) (c_{5} (c_{7} x_{112}) (c_{7} x_{114})))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{114}),(c_{7} x_{113}),(c_{5} (c_{7} x_{113}) (c_{7} x_{112}))]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) x_{122}) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{114}),(c_{7} x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{5} x_{122} (c_{7} x_{114}))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{112}),x_{112},x_{113}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{5} (c_{5} x_{113} x_{122}) (c_{7} x_{114}))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{5} (c_{5} x_{113} x_{122}) (c_{7} x_{114}))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{5} x_{122} (c_{7} x_{114}))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112} := c_{9}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{5} x_{122} (c_{7} x_{114}))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{5} c_{9}))})) (S (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{5} x_{122} (c_{7} x_{114}))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} A^{= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{5} c_{9}))})) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{5} x_{122} (c_{7} x_{114}))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{113} := c_{9}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{5} (c_{5} x_{112} x_{122}) (c_{7} x_{114}))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}))) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{5} (c_{5} x_{112} x_{122}) (c_{7} x_{114}))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{5} x_{122} (c_{7} x_{114}))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{113}),x_{113},x_{112}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{5} (c_{5} x_{122} (c_{7} x_{113})) (c_{7} x_{114}))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) x_{122}) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{114}),(c_{7} x_{113}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))}))) (S (L^{\\lambda x_{122}.c_{4} x_{122} (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{112} x_{114})) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113},x_{114} := (c_{5} (c_{7} x_{113}) (c_{7} x_{114})),(c_{5} x_{113} x_{112}),(c_{5} (c_{7} x_{113}) (c_{7} x_{112}))]} A^{= (\\Phi_{c(ccb,)} c_{5} \\Phi_{cbcb} c_{4} (\\Phi_{cccbcb} c_{5})) (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{5} \\Phi_{cbcb})}))) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{4} x_{122} (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113},x_{114} := x_{114},x_{112},(c_{5} (c_{7} x_{113}) (c_{7} x_{112}))]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{4} (c_{5} x_{122} x_{114}) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{113},x_{114} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{4} (c_{5} (c_{5} (c_{7} x_{113}) x_{122}) x_{114}) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{4} (c_{5} x_{122} x_{114}) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113} := c_{9},(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{4} (c_{5} x_{122} x_{114}) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112} := (c_{7} x_{113})]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{5} c_{9}))})) (S (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{4} (c_{5} x_{122} x_{114}) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{5} c_{9}))}))) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{4} (c_{5} x_{122} x_{114}) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113} := (c_{7} x_{112}),c_{9}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{4} (c_{5} (c_{5} (c_{7} x_{112}) x_{122}) x_{114}) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}))) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{4} (c_{5} x_{122} x_{114}) (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113},x_{114} := x_{113},(c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{4} x_{122} (c_{5} (c_{5} x_{112} x_{113}) (c_{5} x_{113} x_{114})))} (I^{[x_{112},x_{113},x_{114} := x_{114},x_{113},(c_{5} (c_{7} x_{112}) (c_{7} x_{113}))]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))}))) (S (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) x_{122}} (I^{[x_{112},x_{113},x_{114} := (c_{5} x_{113} x_{114}),(c_{5} x_{112} x_{113}),(c_{5} (c_{7} x_{112}) (c_{7} x_{113}))]} A^{= (\\Phi_{c(ccb,)} c_{5} \\Phi_{cbcb} c_{4} (\\Phi_{cccbcb} c_{5})) (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{5} \\Phi_{cbcb})}))) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{5} (c_{4} (c_{5} (c_{7} x_{112}) (c_{7} x_{113})) x_{122}) (c_{5} x_{113} x_{114}))} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) (c_{5} (c_{4} x_{122} (c_{5} x_{113} x_{112})) (c_{5} x_{113} x_{114}))} (I^{[x_{112},x_{113} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} x_{114}))) x_{122}} (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{114}),(c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{5} (c_{5} x_{113} x_{114}) (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})))} (I^{[x_{112},x_{113} := (c_{5} (c_{7} x_{113}) (c_{7} x_{114})),(c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (I^{[x_{112},x_{113},x_{114} := (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{5} x_{113} x_{112})),(c_{5} x_{113} x_{114}),(c_{5} (c_{7} x_{113}) (c_{7} x_{114}))]} A^{= (\\Phi_{c(ccb,)} c_{5} \\Phi_{cbcb} c_{4} (\\Phi_{cccbcb} c_{5})) (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{5} \\Phi_{cbcb})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{5} (c_{7} x_{113}) (c_{7} x_{114})) (c_{5} x_{113} x_{114})) x_{122}} A^{= (\\Phi_{c(ccbb,)} c_{5} c_{7} c_{5} (\\Phi_{(bcbb,cb)} c_{4}) c_{7}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{5} x_{122} (c_{1} x_{113} x_{112})} (I^{[x_{112} := x_{114}]} A^{= (\\Phi_{c(ccbb,)} c_{5} c_{7} c_{5} (\\Phi_{(bcbb,cb)} c_{4}) c_{7}) (\\Phi_{cb} c_{1} \\Phi_{cb})})))	SS
78	249	t	S (L^{\\lambda x_{122}.c_{1} (c_{2} x_{114} x_{112}) x_{122}} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} x_{113} (c_{7} x_{112}))} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})})) (S (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{4} \\Phi_{cbcb})})) (S (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})})))	SS
51	216	t	A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{6} \\Phi_{cb})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{c(ccbb,)} c_{5} c_{7} c_{5} (\\Phi_{(bcbb,cb)} c_{4}) c_{7}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) x_{122}) (c_{5} x_{113} (c_{7} x_{112}))} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})	SS
56	221	t	I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})} (I^{[x_{113},x_{114} := (c_{4} x_{113} x_{112}),(c_{4} (c_{4} x_{113} x_{112}) x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{4} x_{113} x_{112})) x_{112}} (I^{[x_{113},x_{114} := x_{112},x_{113}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{113} x_{122}) (c_{4} x_{113} x_{112})) x_{112}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})	SS
65	230	t	L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (I^{[x_{113},x_{114} := (c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{c(ccb,)} c_{5} \\Phi_{cbcb} c_{4} (\\Phi_{cccbcb} c_{5})) (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{5} \\Phi_{cbcb})}) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} x_{112}) x_{122}} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}) (I^{[x_{112},x_{113} := c_{9},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{5} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})	SS
58	223	t	I^{[x_{113},x_{114} := (c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{c(ccb,)} c_{5} \\Phi_{cbcb} c_{4} (\\Phi_{cccbcb} c_{5})) (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{5} \\Phi_{cbcb})} (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} x_{112}) x_{122}} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}) (I^{[x_{112},x_{113} := c_{9},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{5} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})	SS
44	209	t	I^{[x_{113} := (c_{1} x_{112} x_{113})]} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) (c_{1} x_{122} x_{112})} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) x_{122}} (I^{[x_{113},x_{114} := x_{112},x_{113}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}))) (S (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) (c_{1} x_{113} x_{122})} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) x_{122}} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} x_{113}} (I^{[x_{114} := x_{112}]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{4} \\Phi_{cbcb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{4} x_{113} x_{112})) x_{113}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{1} x_{122} x_{113}} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (I^{[x_{112},x_{113},x_{114} := x_{113},x_{112},(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})})	SS
53	218	t	A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})} (I^{[x_{114} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})	SS
45	210	t	S (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),(c_{4} x_{114} x_{112})]} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})} (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} x_{114} x_{112}) (c_{4} x_{113} x_{112}))} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{4} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) x_{122}} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{4} \\Phi_{cbcb})})) (S (I^{[x_{113},x_{114} := (c_{1} x_{114} x_{113}),(c_{4} x_{114} x_{113})]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{4} \\Phi_{cbcb})})) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112},x_{113} := x_{113},x_{114}]} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})}))))	SS
54	219	t	M_{4} (S (I^{[x_{112},x_{113},x_{114} := (c_{5} x_{113} x_{112}),(c_{1} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}) (M_{1}^{1} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})}))	EO DM
55	220	t	M_{4} (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{112},x_{113},x_{114} := (c_{5} x_{113} x_{112}),x_{112},x_{113}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (M_{1}^{1} A^{= (\\Phi_{cb} c_{4} \\Phi_{cb}) (\\Phi_{c(cb,)} c_{5} c_{1} (\\Phi_{(bcb,cb)} c_{1}))}))	EO DM
52	217	t	M_{4} (S (I^{[x_{112},x_{113},x_{114} := (c_{5} x_{113} x_{112}),x_{112},(c_{1} (c_{4} x_{113} x_{112}) x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}) (M_{1}^{1} A^{= (\\Phi_{c(ccb,)} c_{4} c_{1} c_{1} \\Phi_{cb(bcb,)}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))	EO DM
59	224	t	I^{[x_{113},x_{114} := (c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{4} \\Phi_{cbcb})} (L^{\\lambda x_{122}.c_{5} (c_{4} x_{113} x_{112}) x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112},x_{113} := c_{8},(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}) (I^{[x_{112} := (c_{4} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})	SS
47	212	t	S (I^{[x_{112},x_{113},x_{114} := (c_{5} x_{113} x_{112}),(c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{4} \\Phi_{cbcb})} (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{7} x_{113}) (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} (c_{5} x_{113} x_{112}) (c_{7} x_{112}))} (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{5} x_{113} x_{112}) (c_{7} x_{113})) x_{122}} (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{112}),x_{112},x_{113}]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{4} \\Phi_{cbcb})})) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{5} (c_{4} x_{113} (c_{7} x_{112})) (c_{4} x_{112} (c_{7} x_{112})))} (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{113}),x_{112},x_{113}]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{4} \\Phi_{cbcb})})) (L^{\\lambda x_{122}.c_{5} (c_{5} (c_{4} x_{113} (c_{7} x_{113})) (c_{4} x_{112} (c_{7} x_{113}))) (c_{5} (c_{4} x_{113} (c_{7} x_{112})) x_{122})} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{5} (c_{4} x_{113} (c_{7} x_{113})) (c_{4} x_{112} (c_{7} x_{113}))) (c_{5} (c_{4} x_{113} (c_{7} x_{112})) x_{122})} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (L^{\\lambda x_{122}.c_{5} (c_{5} (c_{4} x_{113} (c_{7} x_{113})) (c_{4} x_{112} (c_{7} x_{113}))) x_{122}} (I^{[x_{112},x_{113} := c_{8},(c_{4} x_{113} (c_{7} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{5} (c_{4} x_{113} (c_{7} x_{113})) (c_{4} x_{112} (c_{7} x_{113}))) x_{122}} (I^{[x_{112} := (c_{4} x_{113} (c_{7} x_{112}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{4} x_{112} (c_{7} x_{113}))) (c_{4} x_{113} (c_{7} x_{112}))} (I^{[x_{112} := (c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{4} x_{112} (c_{7} x_{113}))) (c_{4} x_{113} (c_{7} x_{112}))} (I^{[x_{112} := x_{113}]} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} x_{113} (c_{7} x_{112}))} (I^{[x_{112} := (c_{4} x_{112} (c_{7} x_{113}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{112} (c_{7} x_{113})) x_{122}} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{112} (c_{7} x_{113})) x_{122}} (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{cc(bb,)} c_{7} c_{4} \\Phi_{bcbb} c_{1}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{112} (c_{7} x_{113})) (c_{1} x_{113} (c_{4} x_{122} x_{113}))} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{1} x_{113} (c_{4} x_{112} x_{113}))} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{1} x_{113} (c_{4} x_{112} x_{113}))} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{cc(bb,)} c_{7} c_{4} \\Phi_{bcbb} c_{1}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{1} x_{112} (c_{4} x_{122} x_{112})) (c_{1} x_{113} (c_{4} x_{112} x_{113}))} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (S (L^{\\lambda x_{122}.c_{5} (c_{1} x_{112} (c_{4} x_{113} x_{112})) (c_{1} x_{122} (c_{4} x_{112} x_{113}))} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}))) (S (L^{\\lambda x_{122}.c_{5} (c_{1} x_{122} (c_{4} x_{113} x_{112})) (c_{1} (c_{4} x_{113} x_{113}) (c_{4} x_{112} x_{113}))} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})) (S (L^{\\lambda x_{122}.c_{5} (c_{1} (c_{4} x_{112} x_{112}) (c_{4} x_{113} x_{112})) x_{122}} (I^{[x_{112},x_{113},x_{114} := x_{113},x_{112},x_{113}]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{4} \\Phi_{cbcb})}))) (S (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} (c_{1} x_{113} x_{112}) x_{113})} (I^{[x_{114} := x_{112}]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{4} \\Phi_{cbcb})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{122} x_{112}) (c_{4} (c_{1} x_{113} x_{112}) x_{113})} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{1} x_{113} x_{112}) x_{112}) x_{122}} (I^{[x_{112},x_{113} := x_{113},(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} x_{113} (c_{1} x_{113} x_{112}))} (I^{[x_{113} := (c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{112},x_{114} := (c_{1} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{4} \\Phi_{cbcb})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{1} x_{113} x_{112})} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})}) (I^{[x_{112},x_{113},x_{114} := (c_{1} x_{113} x_{112}),(c_{1} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{4} \\Phi_{cbcb})}) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{4} x_{113} x_{112}) (c_{1} x_{113} x_{112})) x_{122}} (I^{[x_{112} := (c_{1} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113},x_{114} := (c_{4} x_{113} x_{112}),x_{112},x_{113}]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{4} \\Phi_{cbcb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{4} x_{112} (c_{4} x_{113} x_{112}))) (c_{1} x_{113} x_{112})} (I^{[x_{114} := x_{113}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{122} x_{112}) (c_{4} x_{112} (c_{4} x_{113} x_{112}))) (c_{1} x_{113} x_{112})} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{113} x_{112}) x_{122}) (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{113} x_{112}) x_{122}) (c_{1} x_{113} x_{112})} (I^{[x_{113},x_{114} := x_{112},x_{113}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{113} x_{112}) (c_{4} x_{113} x_{122})) (c_{1} x_{113} x_{112})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{113} x_{112})} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113} := (c_{1} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))	SS
61	226	t	S (S (I^{[x_{112} := (c_{5} (c_{7} x_{113}) (c_{7} x_{112}))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{ccbb} c_{7} c_{4} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{5} (\\Phi_{bcb} c_{7}))})) (L^{\\lambda x_{122}.c_{7} (c_{4} (c_{7} (c_{7} x_{113})) x_{122})} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{7} (c_{4} x_{122} x_{112})} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})))	SS
62	227	t	S (S (I^{[x_{112},x_{113} := (c_{5} (c_{7} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{ccb} c_{7} c_{1} \\Phi_{cbb}) (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7})}) (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{ccbb} c_{7} c_{4} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{5} (\\Phi_{bcb} c_{7}))})) (L^{\\lambda x_{122}.c_{1} x_{112} (c_{4} x_{122} (c_{7} x_{112}))} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{cc(bb,)} c_{7} c_{4} \\Phi_{bcbb} c_{1}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} x_{112} (c_{1} (c_{7} x_{112}) x_{122})} A^{= (\\Phi_{ccbb} c_{7} c_{4} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{5} (\\Phi_{bcb} c_{7}))})) (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),(c_{7} x_{112})]} A^{= (\\Phi_{ccb} c_{7} c_{1} \\Phi_{cbb}) (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7})})) (L^{\\lambda x_{122}.c_{1} x_{112} (c_{1} x_{122} (c_{5} x_{113} x_{112}))} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (I^{[x_{112},x_{113},x_{114} := (c_{5} x_{113} x_{112}),x_{112},x_{112}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{113} x_{112})} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113} := (c_{5} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))	SS
63	228	t	M_{4} (S (I^{[x_{112},x_{113},x_{114} := (c_{5} x_{113} x_{112}),(c_{5} (c_{7} x_{113}) x_{112}),(c_{7} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}) (M_{1}^{1} A^{= (\\Phi_{cc(bbb,)} c_{7} c_{5} \\Phi_{bcbb} c_{1} c_{7}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))	EO DM
80	251	t	S (L^{\\lambda x_{122}.c_{2} x_{122} x_{112}} (I^{[x_{112},x_{113} := x_{113},x_{114}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (I^{[x_{113} := (c_{4} x_{114} (c_{7} x_{113}))]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{4} x_{114} x_{122}} A^{= (\\Phi_{ccbb} c_{7} c_{4} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{5} (\\Phi_{bcb} c_{7}))})) (S (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})})))	SS
48	213	t	A^{= (\\Phi_{cb} c_{4} (\\Phi_{(b,cb)} c_{1})) (\\Phi_{cb} c_{2} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{1} x_{113} x_{122}} A^{= (\\Phi_{cc(bb,)} c_{7} c_{4} \\Phi_{bcbb} c_{1}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (L^{\\lambda x_{122}.c_{1} x_{113} (c_{1} x_{112} (c_{4} (c_{7} x_{113}) x_{122}))} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (S (L^{\\lambda x_{122}.c_{1} x_{113} (c_{1} x_{112} x_{122})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{ccbb} c_{7} c_{4} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{5} (\\Phi_{bcb} c_{7}))}))) (L^{\\lambda x_{122}.c_{1} x_{113} x_{122}} (I^{[x_{112},x_{113} := (c_{5} x_{113} (c_{7} x_{112})),x_{112}]} A^{= (\\Phi_{ccb} c_{7} c_{1} \\Phi_{cbb}) (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7})})) (I^{[x_{112},x_{113},x_{114} := (c_{5} x_{113} (c_{7} x_{112})),(c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{113} (c_{7} x_{112}))} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (I^{[x_{112},x_{114} := (c_{5} x_{113} (c_{7} x_{112})),(c_{7} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{1} (c_{7} x_{112}) (c_{1} x_{122} (c_{5} x_{113} (c_{7} x_{112})))} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{7} x_{112}) x_{122}} (I^{[x_{112},x_{113} := (c_{5} x_{113} (c_{7} x_{112})),(c_{7} x_{113})]} A^{= (\\Phi_{ccb} c_{7} c_{1} \\Phi_{cbb}) (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{7} x_{112}) x_{122}} (I^{[x_{112},x_{113} := (c_{5} x_{113} (c_{7} x_{112})),(c_{7} x_{113})]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))}))) (L^{\\lambda x_{122}.c_{1} (c_{7} x_{112}) (c_{7} (c_{1} (c_{7} x_{113}) x_{122}))} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{7} x_{112}) (c_{7} x_{122})} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{cc(bbb,)} c_{7} c_{5} \\Phi_{bcbb} c_{1} c_{7}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (L^{\\lambda x_{122}.c_{1} (c_{7} x_{112}) x_{122}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{ccbb} c_{7} c_{4} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{5} (\\Phi_{bcb} c_{7}))})) (L^{\\lambda x_{122}.c_{1} (c_{7} x_{112}) x_{122}} (I^{[x_{112},x_{113} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{cc(bb,)} c_{7} c_{4} \\Phi_{bcbb} c_{1}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))	SS
60	225	t	L^{\\lambda x_{122}.c_{7} x_{122}} A^{= (\\Phi_{c(cb,)} c_{1} c_{4} (\\Phi_{(bcb,cb)} c_{1})) (\\Phi_{cb} c_{5} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{7} (c_{1} x_{122} (c_{1} x_{113} x_{112}))} A^{= (\\Phi_{cc(bb,)} c_{7} c_{4} \\Phi_{bcbb} c_{1}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{7} (c_{1} (c_{1} x_{112} x_{122}) (c_{1} x_{113} x_{112}))} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{7} (c_{1} (c_{1} x_{112} x_{122}) (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{cc(bb,)} c_{7} c_{4} \\Phi_{bcbb} c_{1}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{7} (c_{1} (c_{1} x_{112} x_{122}) (c_{1} x_{113} x_{112}))} (I^{[x_{112} := (c_{4} (c_{7} x_{112}) (c_{7} x_{113}))]} A^{= (\\Phi_{ccb} c_{7} c_{1} \\Phi_{cbb}) (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7})}))) (L^{\\lambda x_{122}.c_{7} (c_{1} x_{122} (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{114} := (c_{7} (c_{4} (c_{7} x_{112}) (c_{7} x_{113}))),x_{112}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{7} (c_{1} x_{122} (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{7} (c_{4} (c_{7} x_{112}) (c_{7} x_{113}))),(c_{1} x_{112} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{7} (c_{1} x_{122} (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{1} x_{112} x_{113}),(c_{4} (c_{7} x_{112}) (c_{7} x_{113}))]} A^{= (\\Phi_{ccb} c_{7} c_{1} \\Phi_{cbb}) (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7})}))) (S (L^{\\lambda x_{122}.c_{7} (c_{1} x_{122} (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{1} x_{112} x_{113}),(c_{4} (c_{7} x_{112}) (c_{7} x_{113}))]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))}))) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),(c_{1} (c_{4} (c_{7} x_{112}) (c_{7} x_{113})) (c_{1} x_{112} x_{113}))]} A^{= (\\Phi_{ccb} c_{7} c_{1} \\Phi_{cbb}) (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7})}))) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),(c_{1} (c_{4} (c_{7} x_{112}) (c_{7} x_{113})) (c_{1} x_{112} x_{113}))]} A^{= (\\Phi_{cbb} c_{1} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{1} (\\Phi_{bcb} c_{7}))}))) (I^{[x_{112} := (c_{1} (c_{1} (c_{4} (c_{7} x_{112}) (c_{7} x_{113})) (c_{1} x_{112} x_{113})) (c_{1} x_{113} x_{112}))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (S (I^{[x_{112},x_{113},x_{114} := (c_{1} x_{113} x_{112}),(c_{1} x_{112} x_{113}),(c_{4} (c_{7} x_{112}) (c_{7} x_{113}))]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{7} x_{112}) (c_{7} x_{113})) (c_{1} x_{122} (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{7} x_{112}) (c_{7} x_{113})) x_{122}} (I^{[x_{113} := (c_{1} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{113} := (c_{4} (c_{7} x_{112}) (c_{7} x_{113}))]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}) (I^{[x_{112},x_{113} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})	SS
79	250	t	S (L^{\\lambda x_{122}.c_{2} (c_{2} x_{114} x_{112}) x_{122}} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{2} x_{122} (c_{4} x_{113} (c_{7} x_{112}))} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})})) (I^{[x_{112},x_{113} := (c_{4} x_{113} (c_{7} x_{112})),(c_{4} x_{114} (c_{7} x_{112}))]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{4} (c_{4} x_{114} (c_{7} x_{112})) x_{122}} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{ccbb} c_{7} c_{5} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{4} (\\Phi_{bcb} c_{7}))})) (L^{\\lambda x_{122}.c_{4} (c_{4} x_{114} (c_{7} x_{112})) (c_{5} (c_{7} x_{113}) x_{122})} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (I^{[x_{112},x_{113} := (c_{5} (c_{7} x_{113}) x_{112}),(c_{4} x_{114} (c_{7} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112},x_{113},x_{114} := (c_{4} x_{114} (c_{7} x_{112})),x_{112},(c_{7} x_{113})]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{4} \\Phi_{cbcb})}) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{7} x_{113}) (c_{4} x_{114} (c_{7} x_{112}))) x_{122}} (I^{[x_{112},x_{113} := (c_{4} x_{114} (c_{7} x_{112})),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{7} x_{113}) (c_{4} x_{114} (c_{7} x_{112}))) x_{122}} (I^{[x_{113} := (c_{7} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{7} x_{113}) (c_{4} x_{114} (c_{7} x_{112}))) (c_{4} x_{114} x_{122})} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{7} x_{113}) (c_{4} x_{114} (c_{7} x_{112}))) x_{122}} (I^{[x_{112},x_{113} := c_{8},x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{7} x_{113}) (c_{4} x_{114} (c_{7} x_{112}))) x_{122}} (I^{[x_{112} := x_{114}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) (I^{[x_{112},x_{113} := c_{8},(c_{4} (c_{7} x_{113}) (c_{4} x_{114} (c_{7} x_{112})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}) (I^{[x_{112} := (c_{4} (c_{7} x_{113}) (c_{4} x_{114} (c_{7} x_{112})))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{112}),x_{114},(c_{7} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{7} x_{112})} (I^{[x_{112},x_{113} := x_{114},(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{4} x_{122} (c_{7} x_{112})} (I^{[x_{112},x_{113} := x_{113},x_{114}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}))) (S (I^{[x_{113} := (c_{2} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})})))	SS
83	254	t	A^{= (\\Phi_{bb} (\\Phi_{bb} c_{11}) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12} \\Phi_{b})} (L^{\\lambda x_{122}.c_{11} (\\lambda x_{120}.x_{122})} (I^{[x_{112},x_{113} := (x_{82} x_{120}),(x_{80} x_{120})]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}))	SS
85	256	t	L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (S (I^{[x_{112},x_{113},x_{114} := x_{112},(c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{4} x_{113} x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})	SS
82	253	t	I^{[x_{112},x_{113} := c_{8},x_{112}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (S (L^{\\lambda x_{122}.c_{4} x_{112} x_{122}} A^{= (c_{7} c_{8}) c_{9}})) (I^{[x_{112},x_{113} := c_{9},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))}	SS
81	252	t	I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{11}) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12} \\Phi_{b})} (L^{\\lambda x_{122}.c_{11} (\\lambda x_{120}.x_{122})} (I^{[x_{112} := (x_{80} x_{120})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{2})}))	SS
84	255	t	L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{4} c_{5} \\Phi_{cbcb})})	SS
90	261	t	I^{[x_{113} := c_{9}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})	SS
49	214	t	S (L^{\\lambda x_{122}.c_{5} (x_{69} x_{112}) x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (S (L^{\\lambda x_{122}.c_{5} (x_{69} x_{112}) x_{122}} (I^{[x_{112} := (c_{1} x_{112} c_{8})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}))) (S (L^{\\lambda x_{122}.c_{5} (x_{69} x_{112}) (c_{5} x_{122} (c_{1} x_{112} c_{8}))} (I^{[x_{101},x_{102} := c_{8},x_{112}]} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} (\\Phi_{(bcbb,cb)} c_{2}) c_{1} (\\Phi_{c(ccbb,)} c_{1}))}))))) (L^{\\lambda x_{122}.c_{5} (x_{69} x_{112}) x_{122}} (I^{[x_{112},x_{113} := (c_{1} x_{112} c_{8}),(c_{1} (x_{69} x_{112}) (x_{69} c_{8}))]} A^{= (\\Phi_{cb} c_{5} \\Phi_{cb}) (\\Phi_{c(cb,)} c_{2} c_{5} \\Phi_{cbcb})})) (I^{[x_{112},x_{113},x_{114} := (c_{1} x_{112} c_{8}),(c_{1} (x_{69} x_{112}) (x_{69} c_{8})),(x_{69} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))}) (S (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{1} (x_{69} x_{112}) (x_{69} c_{8}))) (c_{1} x_{112} c_{8})} (I^{[x_{113} := (x_{69} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))) (S (L^{\\lambda x_{122}.c_{5} x_{122} (c_{1} x_{112} c_{8})} (I^{[x_{112},x_{113},x_{114} := (x_{69} c_{8}),(x_{69} x_{112}),c_{8}]} A^{= (\\Phi_{ccb} c_{1} c_{1} (\\Phi_{(cbcb,b)} c_{5} \\Phi_{cbb})) (\\Phi_{c(ccbb,)} c_{1} \\Phi_{cbb} c_{5} \\Phi_{ccbcb} c_{1})}))) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{1} (x_{69} x_{112}) (x_{69} c_{8}))) (c_{1} x_{112} c_{8})} (I^{[x_{113} := (x_{69} c_{8})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (S (I^{[x_{112},x_{113},x_{114} := (c_{1} x_{112} c_{8}),(c_{1} (x_{69} x_{112}) (x_{69} c_{8})),(x_{69} c_{8})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) x_{122}} (I^{[x_{112},x_{113} := (c_{1} x_{112} c_{8}),(c_{1} (x_{69} x_{112}) (x_{69} c_{8}))]} A^{= (\\Phi_{cb} c_{5} \\Phi_{cb}) (\\Phi_{c(cb,)} c_{2} c_{5} \\Phi_{cbcb})}))) (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) (c_{5} x_{122} (c_{1} x_{112} c_{8}))} (I^{[x_{101},x_{102} := c_{8},x_{112}]} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} (\\Phi_{(bcbb,cb)} c_{2}) c_{1} (\\Phi_{c(ccbb,)} c_{1}))})))) (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) x_{122}} (I^{[x_{112} := (c_{1} x_{112} c_{8})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))	SS
93	264	t	S (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{4} x_{114} x_{122}} A^{= (\\Phi_{ccbb} c_{7} c_{5} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{4} (\\Phi_{bcb} c_{7}))}) (I^{[x_{112},x_{113} := (c_{5} (c_{7} x_{113}) (c_{7} x_{112})),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112},x_{113},x_{114} := x_{114},(c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{4} \\Phi_{cbcb})}) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{7} x_{113}) x_{114}) x_{122}} (I^{[x_{112},x_{113} := x_{114},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} x_{114} (c_{7} x_{112}))} (I^{[x_{112},x_{113} := x_{114},(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{7} x_{113})) x_{122}} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}))) (S (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{114} x_{112})} (I^{[x_{112},x_{113} := x_{113},x_{114}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}))))	SS
86	257	t	L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{112},x_{113},x_{114} := x_{112},x_{112},(c_{7} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{4} (c_{7} x_{113}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}))	SS
92	263	t	S (L^{\\lambda x_{122}.c_{2} x_{113} (c_{5} x_{122} x_{112})} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{2} x_{113} x_{122}} A^{= (\\Phi_{cb} c_{5} \\Phi_{cb}) (\\Phi_{c(cb,b)} c_{4} c_{5} \\Phi_{cbcb} c_{7})}) (I^{[x_{112} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{4} x_{113} x_{122}} A^{= (\\Phi_{ccbb} c_{7} c_{4} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{5} (\\Phi_{bcb} c_{7}))}) (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{112}),(c_{7} x_{113}),x_{113}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{7} x_{112})} (I^{[x_{112} := (c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{7} x_{112})} (I^{[x_{112} := x_{113}]} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}}	DM
91	262	t	I^{[x_{112},x_{113} := c_{9},x_{112}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{4} x_{112} x_{122}} A^{= c_{8} (c_{7} c_{9})}) (I^{[x_{112},x_{113} := c_{8},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))}	SS
87	258	t	I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} x_{112}) x_{122}} A^{= (\\Phi_{ccbb} c_{7} c_{5} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{4} (\\Phi_{bcb} c_{7}))}) (I^{[x_{112},x_{113} := (c_{5} (c_{7} x_{113}) (c_{7} x_{112})),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S A^{= (\\Phi_{c(ccbb,)} c_{5} c_{7} c_{5} (\\Phi_{(bcbb,cb)} c_{4}) c_{7}) (\\Phi_{cb} c_{1} \\Phi_{cb})})	SS
66	231	t	M_{4} (S (S (I^{[x_{113},x_{114} := (x_{69} x_{112}),(x_{69} c_{9})]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{1} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{4} \\Phi_{cbcb})}) (S (L^{\\lambda x_{122}.c_{4} (c_{1} (x_{69} c_{9}) (x_{69} x_{112})) x_{122}} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (S (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{1} (x_{69} c_{9}) (x_{69} x_{112}))]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{1} (x_{69} c_{9}) (x_{69} x_{112})) x_{122}} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})}) (I^{[x_{101},x_{102} := x_{112},c_{9}]} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} (\\Phi_{(bcbb,cb)} c_{2}) c_{1} (\\Phi_{c(ccbb,)} c_{1}))})))) A^{= T c_{8}})	EO DM
88	259	t	I^{[x_{113} := x_{112}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))	SS
89	260	t	I^{[x_{113} := c_{8}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})	SS
121	293	t	I^{[x_{80} := (\\lambda x_{120}.x_{80})]} A^{= (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) c_{12} (\\Phi_{bb} c_{7})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{14} \\Phi_{b})} (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{80} := (c_{7} x_{80})]} A^{= (\\Phi_{cccb} (\\Phi_{bb} c_{7}) c_{11} c_{4} \\Phi_{cbbb}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12} \\Phi_{K})})) (I^{[x_{112},x_{113} := (c_{7} x_{80}),(c_{11} (\\lambda x_{120}.c_{7} (x_{82} x_{120})))]} A^{= (\\Phi_{ccbb} c_{7} c_{5} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{4} (\\Phi_{bcb} c_{7}))}) (L^{\\lambda x_{122}.c_{5} (c_{7} (c_{11} (\\lambda x_{120}.c_{7} (x_{82} x_{120})))) x_{122}} (I^{[x_{112} := x_{80}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (S (L^{\\lambda x_{122}.c_{5} (c_{7} x_{122}) x_{80}} (I^{[x_{80} := (\\lambda x_{120}.c_{7} (x_{82} x_{120}))]} A^{= (\\Phi_{bb} c_{11} \\Phi_{b}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) c_{12} \\Phi_{b})}))) (S (L^{\\lambda x_{122}.c_{5} x_{122} x_{80}} (I^{[x_{80},x_{82} := (\\lambda x_{120}.x_{82} x_{120}),(\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) c_{12} (\\Phi_{bb} c_{7})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{14} \\Phi_{b})}))) (L^{\\lambda x_{122}.c_{5} x_{122} x_{80}} (I^{[x_{80} := (\\lambda x_{120}.x_{82} x_{120})]} A^{= (\\Phi_{bb} c_{13} \\Phi_{b}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) c_{14} \\Phi_{b})}))	SS
94	265	t	L^{\\lambda x_{122}.c_{5} (c_{2} x_{114} (c_{7} x_{112})) x_{122}} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} x_{114} (c_{7} x_{112}))} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{114}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{122}) (c_{4} x_{114} (c_{7} x_{112}))} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{112}) x_{122}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} (c_{7} x_{112}) x_{114})} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{112},x_{113},x_{114} := x_{114},(c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{4} \\Phi_{cbcb})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{114}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{114}} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}) (I^{[x_{112} := x_{114}]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})	SS
67	232	f		
123	295	f	c_{2} (c_{14} (\\lambda x_{120}.x_{80} x_{120}) (\\lambda x_{120}.c_{4} (x_{82} x_{120}) (x_{81} x_{120}))) (c_{14} (\\lambda x_{120}.x_{80} x_{120}) (\\lambda x_{120}.x_{82} x_{120}))	DM
122	294	f	I^{[x_{112},x_{113} := (c_{11} (\\lambda x_{120}.x_{80} x_{120})),(x_{80} x_{101})]} A^{= (\\Phi_{cb} c_{4} (\\Phi_{(b,cb)} c_{1})) (\\Phi_{cb} c_{2} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{1} (x_{80} x_{101}) x_{122}} (I^{[x_{112},x_{113} := (c_{11} (\\lambda x_{120}.x_{80} x_{120})),(x_{80} x_{101})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (x_{80} x_{101}) (c_{4} x_{122} (x_{80} x_{101}))} A^{= (\\Phi_{bb} c_{11} \\Phi_{b}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) c_{12} \\Phi_{b})})) (L^{\\lambda x_{122}.c_{1} (x_{80} x_{101}) x_{122}} (I^{[x_{80},x_{81},x_{82} := (x_{80} x_{101}),(\\lambda x_{120}.x_{80} x_{120}),(\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{bcb} (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12}) c_{4} \\Phi_{cbb}) (\\Phi_{ccbcb} \\Phi_{b} c_{12} (\\Phi_{cbbb} \\Phi_{b}) c_{4} \\Phi_{cbbb})}))	DM
109	280	t	S (L^{\\lambda x_{122}.c_{2} (c_{2} x_{114} x_{112}) (c_{5} (c_{2} x_{114} x_{113}) x_{122})} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{2} (c_{2} x_{114} x_{112}) (c_{5} x_{122} (c_{4} x_{113} (c_{7} x_{112})))} (I^{[x_{112},x_{113} := x_{113},x_{114}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} x_{122} (c_{5} (c_{4} x_{114} (c_{7} x_{113})) (c_{4} x_{113} (c_{7} x_{112})))} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})})) (I^{[x_{112},x_{113} := (c_{5} (c_{4} x_{114} (c_{7} x_{113})) (c_{4} x_{113} (c_{7} x_{112}))),(c_{4} x_{114} (c_{7} x_{112}))]} A^{= (\\Phi_{cb} c_{4} (\\Phi_{(b,cb)} c_{1})) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} (c_{7} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{5} (c_{4} x_{114} (c_{7} x_{113})) (c_{4} x_{113} (c_{7} x_{112}))),(c_{7} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} (c_{7} x_{112})) (c_{4} x_{114} x_{122})} (I^{[x_{112},x_{113} := (c_{5} (c_{4} x_{114} (c_{7} x_{113})) (c_{4} x_{113} (c_{7} x_{112}))),(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} (c_{7} x_{112})) (c_{4} x_{114} x_{122})} (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{112}),(c_{4} x_{113} (c_{7} x_{112})),(c_{4} x_{114} (c_{7} x_{113}))]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{4} \\Phi_{cbcb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} (c_{7} x_{112})) (c_{4} x_{114} (c_{5} (c_{4} (c_{4} x_{114} (c_{7} x_{113})) (c_{7} x_{112})) x_{122}))} (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{112}),(c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} (c_{7} x_{112})) (c_{4} x_{114} (c_{5} (c_{4} (c_{4} x_{114} (c_{7} x_{113})) (c_{7} x_{112})) (c_{4} x_{113} x_{122})))} (I^{[x_{112} := (c_{7} x_{112})]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} (c_{7} x_{112})) (c_{4} x_{114} (c_{5} x_{122} (c_{4} x_{113} (c_{7} x_{112}))))} (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} (c_{7} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{5} (c_{4} x_{114} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))) (c_{4} x_{113} (c_{7} x_{112}))),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} (c_{7} x_{112})) x_{122}} (I^{[x_{112},x_{113},x_{114} := x_{114},(c_{4} x_{113} (c_{7} x_{112})),(c_{4} x_{114} (c_{4} (c_{7} x_{113}) (c_{7} x_{112})))]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{4} \\Phi_{cbcb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} (c_{7} x_{112})) (c_{5} (c_{4} x_{122} x_{114}) (c_{4} (c_{4} x_{113} (c_{7} x_{112})) x_{114}))} (I^{[x_{112},x_{113} := (c_{4} (c_{7} x_{113}) (c_{7} x_{112})),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} (c_{7} x_{112})) (c_{5} x_{122} (c_{4} (c_{4} x_{113} (c_{7} x_{112})) x_{114}))} (I^{[x_{112},x_{113},x_{114} := x_{114},x_{114},(c_{4} (c_{7} x_{113}) (c_{7} x_{112}))]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} (c_{7} x_{112})) (c_{5} (c_{4} (c_{4} (c_{7} x_{113}) (c_{7} x_{112})) x_{122}) (c_{4} (c_{4} x_{113} (c_{7} x_{112})) x_{114}))} (I^{[x_{112} := x_{114}]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} (c_{7} x_{112})) (c_{5} (c_{4} (c_{4} (c_{7} x_{113}) (c_{7} x_{112})) x_{114}) x_{122})} (I^{[x_{112},x_{113},x_{114} := x_{114},(c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}))) (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} (c_{7} x_{112})) (c_{5} x_{122} (c_{4} x_{113} (c_{4} (c_{7} x_{112}) x_{114})))} (I^{[x_{112},x_{113},x_{114} := x_{114},(c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}))) (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} (c_{7} x_{112})) x_{122}} (I^{[x_{112},x_{114} := (c_{4} (c_{7} x_{112}) x_{114}),(c_{7} x_{113})]} A^{= (\\Phi_{c(ccb,)} c_{4} \\Phi_{cbcb} c_{5} (\\Phi_{cccbcb} c_{4})) (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{4} \\Phi_{cbcb})}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} (c_{7} x_{112})) (c_{4} x_{122} (c_{4} (c_{7} x_{112}) x_{114}))} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} (c_{7} x_{112})) x_{122}} (I^{[x_{112} := (c_{4} (c_{7} x_{112}) x_{114})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} (c_{7} x_{112})) x_{122}} (I^{[x_{112},x_{113} := x_{114},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (I^{[x_{113} := (c_{4} x_{114} (c_{7} x_{112}))]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})})	DM
120	292	t	S (I^{[x_{80} := (\\lambda x_{120}.c_{5} (x_{81} x_{120}) x_{80})]} A^{= (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) c_{12} (\\Phi_{bb} c_{7})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{14} \\Phi_{b})} (L^{\\lambda x_{122}.c_{7} (c_{12} (\\lambda x_{120}.x_{122}) (\\lambda x_{120}.x_{82} x_{120}))} (I^{[x_{112},x_{113} := x_{80},(x_{81} x_{120})]} A^{= (\\Phi_{ccbb} c_{7} c_{4} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{5} (\\Phi_{bcb} c_{7}))})) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{80},x_{81} := (c_{7} x_{80}),(\\lambda x_{120}.c_{7} (x_{81} x_{120}))]} A^{= (\\Phi_{bcb} (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12}) c_{4} \\Phi_{cbb}) (\\Phi_{ccbcb} \\Phi_{b} c_{12} (\\Phi_{cbbb} \\Phi_{b}) c_{4} \\Phi_{cbbb})}))) (I^{[x_{112},x_{113} := (c_{7} x_{80}),(c_{12} (\\lambda x_{120}.c_{7} (x_{81} x_{120})) (\\lambda x_{120}.x_{82} x_{120}))]} A^{= (\\Phi_{ccbb} c_{7} c_{5} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{4} (\\Phi_{bcb} c_{7}))}) (L^{\\lambda x_{122}.c_{5} (c_{7} (c_{12} (\\lambda x_{120}.c_{7} (x_{81} x_{120})) (\\lambda x_{120}.x_{82} x_{120}))) x_{122}} (I^{[x_{112} := x_{80}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (S (L^{\\lambda x_{122}.c_{5} x_{122} x_{80}} (I^{[x_{80} := (\\lambda x_{120}.x_{81} x_{120})]} A^{= (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) c_{12} (\\Phi_{bb} c_{7})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{14} \\Phi_{b})}))))	SS
97	268	t	S (S (L^{\\lambda x_{122}.c_{2} (c_{12} (\\lambda x_{120}.x_{80} x_{120}) (\\lambda x_{120}.x_{82} x_{120})) x_{122}} A^{= (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{cbbcb} \\Phi_{b} \\Phi_{bb} c_{12})) (\\Phi_{ccccbbb} \\Phi_{b} c_{12} (\\Phi_{(bbb,bb)} c_{5}) \\Phi_{b} (\\Phi_{cccbbb} \\Phi_{b}) c_{12} \\Phi_{b})})) (I^{[x_{112},x_{113} := (c_{12} (\\lambda x_{120}.x_{80} x_{120}) (\\lambda x_{120}.x_{82} x_{120})),(c_{12} (\\lambda x_{120}.x_{81} x_{120}) (\\lambda x_{120}.x_{82} x_{120}))]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})})	DM
68	233	t	S (L^{\\lambda x_{122}.c_{5} (x_{69} x_{101}) x_{122}} (I^{[x_{112} := (c_{1} x_{102} x_{101})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (S (L^{\\lambda x_{122}.c_{5} (x_{69} x_{101}) (c_{5} x_{122} (c_{1} x_{102} x_{101}))} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} (\\Phi_{(bcbb,cb)} c_{2}) c_{1} (\\Phi_{c(ccbb,)} c_{1}))})))) (L^{\\lambda x_{122}.c_{5} (x_{69} x_{101}) x_{122}} (I^{[x_{112},x_{113} := (c_{1} x_{102} x_{101}),(c_{1} (x_{69} x_{102}) (x_{69} x_{101}))]} A^{= (\\Phi_{cb} c_{5} \\Phi_{cb}) (\\Phi_{c(cb,)} c_{2} c_{5} \\Phi_{cbcb})})) (I^{[x_{112},x_{113},x_{114} := (c_{1} x_{102} x_{101}),(c_{1} (x_{69} x_{102}) (x_{69} x_{101})),(x_{69} x_{101})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))}) (S (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{1} (x_{69} x_{102}) (x_{69} x_{101}))) (c_{1} x_{102} x_{101})} (I^{[x_{113} := (x_{69} x_{101})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{1} x_{102} x_{101})} (I^{[x_{112},x_{113},x_{114} := (x_{69} x_{101}),(x_{69} x_{102}),c_{8}]} A^{= (\\Phi_{ccb} c_{1} c_{1} (\\Phi_{(cbcb,b)} c_{5} \\Phi_{cbb})) (\\Phi_{c(ccbb,)} c_{1} \\Phi_{cbb} c_{5} \\Phi_{ccbcb} c_{1})})) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{1} (x_{69} x_{102}) (x_{69} x_{101}))) (c_{1} x_{102} x_{101})} (I^{[x_{113} := (x_{69} x_{102})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (S (I^{[x_{112},x_{113},x_{114} := (c_{1} x_{102} x_{101}),(c_{1} (x_{69} x_{102}) (x_{69} x_{101})),(x_{69} x_{102})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{5} (x_{69} x_{102}) x_{122}} (I^{[x_{112},x_{113} := (c_{1} x_{102} x_{101}),(c_{1} (x_{69} x_{102}) (x_{69} x_{101}))]} A^{= (\\Phi_{cb} c_{5} \\Phi_{cb}) (\\Phi_{c(cb,)} c_{2} c_{5} \\Phi_{cbcb})}))) (L^{\\lambda x_{122}.c_{5} (x_{69} x_{102}) (c_{5} x_{122} (c_{1} x_{102} x_{101}))} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} (\\Phi_{(bcbb,cb)} c_{2}) c_{1} (\\Phi_{c(ccbb,)} c_{1}))}))) (L^{\\lambda x_{122}.c_{5} (x_{69} x_{102}) x_{122}} (I^{[x_{112} := (c_{1} x_{102} x_{101})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}))	SS
70	236	t	M_{4} (S (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{112}),x_{112},c_{9}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))}) (M_{1}^{1} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})}))	EO DM
110	281	t	I^{[x_{112},x_{113} := (c_{5} x_{112} x_{113}),(x_{69} x_{112})]} A^{= (\\Phi_{c(cb,)} c_{5} c_{2} \\Phi_{cbcb}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{2} x_{122} (c_{5} x_{112} x_{113})} (I^{[x_{112},x_{113},x_{114} := x_{113},x_{112},(x_{69} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{2} (c_{5} x_{122} x_{113}) (c_{5} x_{112} x_{113})} A^{= (\\Phi_{bbc} \\Phi_{b} c_{5} c_{8}) (\\Phi_{b} (\\Phi_{(bb,)} c_{5}))}) (S (L^{\\lambda x_{122}.c_{2} x_{122} (c_{5} x_{112} x_{113})} (I^{[x_{112},x_{113},x_{114} := x_{113},x_{112},(x_{69} c_{8})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))}))) (S (I^{[x_{112},x_{113} := (c_{5} x_{112} x_{113}),(x_{69} c_{8})]} A^{= (\\Phi_{c(cb,)} c_{5} c_{2} \\Phi_{cbcb}) (\\Phi_{cb} c_{2} \\Phi_{cb})}))	SS
98	269	t	A^{= (\\Phi_{bb} (\\Phi_{bb} c_{11}) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12} \\Phi_{b})} (L^{\\lambda x_{122}.c_{11} (\\lambda x_{120}.x_{122})} (I^{[x_{112},x_{113} := (x_{82} x_{120}),(x_{80} x_{120})]} A^{= (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{1}) (\\Phi_{cb} c_{2} \\Phi_{cb})}))	SS
96	267	t	S (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{4} x_{112} x_{122}} A^{= (\\Phi_{ccbb} c_{7} c_{4} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{5} (\\Phi_{bcb} c_{7}))}) (I^{[x_{112},x_{113} := (c_{4} (c_{7} x_{113}) (c_{7} x_{112})),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (I^{[x_{112},x_{113},x_{114} := x_{112},(c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{4} (c_{7} x_{113}) x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112},x_{113} := c_{8},(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{7} x_{113})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}}	DM
99	270	t	A^{= (\\Phi_{bb} (\\Phi_{bb} c_{11}) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12} \\Phi_{b})} (L^{\\lambda x_{122}.c_{11} (\\lambda x_{120}.x_{122})} (I^{[x_{112},x_{113} := (x_{82} x_{120}),(x_{80} x_{120})]} A^{= (\\Phi_{cb} c_{4} (\\Phi_{(b,cb)} c_{1})) (\\Phi_{cb} c_{2} \\Phi_{cb})}))	SS
95	266	t	S (L^{\\lambda x_{122}.c_{2} (c_{12} (\\lambda x_{120}.x_{80} x_{120}) (\\lambda x_{120}.x_{81} x_{120})) x_{122}} (I^{[x_{82},x_{83} := (\\lambda x_{120}.x_{81} x_{120}),(\\lambda x_{120}.x_{82} x_{120})]} A^{= (\\Phi_{c(ccbbb,bb)} \\Phi_{b} \\Phi_{cbbb} c_{5} (\\Phi_{cccbbb} \\Phi_{b}) c_{12} \\Phi_{b} c_{12} \\Phi_{b}) (\\Phi_{bbbb} (\\Phi_{cb} (\\Phi_{(bb,b)} c_{4})) \\Phi_{bcb} c_{12} \\Phi_{b})})) (I^{[x_{112},x_{113} := (c_{12} (\\lambda x_{120}.x_{80} x_{120}) (\\lambda x_{120}.x_{81} x_{120})),(c_{12} (\\lambda x_{120}.x_{80} x_{120}) (\\lambda x_{120}.x_{82} x_{120}))]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})})	DM
111	282	t	I^{[x_{112},x_{113} := (x_{69} x_{112}),x_{112}]} A^{= (\\Phi_{cb} c_{4} (\\Phi_{(b,cb)} c_{1})) (\\Phi_{cb} c_{2} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} (I^{[x_{112},x_{113} := (x_{69} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} A^{= (\\Phi_{bbc} \\Phi_{b} c_{4} c_{9}) (\\Phi_{b} (\\Phi_{(bb,)} c_{4}))}) (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} (I^{[x_{113} := (x_{69} c_{9})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{112},x_{113} := (x_{69} c_{9}),x_{112}]} A^{= (\\Phi_{cb} c_{4} (\\Phi_{(b,cb)} c_{1})) (\\Phi_{cb} c_{2} \\Phi_{cb})}))	SS
112	283	t	I^{[x_{112},x_{113} := (x_{69} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{cb} c_{4} (\\Phi_{(b,cb)} c_{1})) (\\Phi_{cb} c_{2} \\Phi_{cb})} (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{112},x_{113},x_{114} := (x_{69} x_{112}),x_{112},x_{113}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) (c_{4} x_{113} x_{122})} (I^{[x_{112},x_{113} := (x_{69} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) (c_{4} x_{113} x_{122})} A^{= (\\Phi_{bbc} \\Phi_{b} c_{4} c_{9}) (\\Phi_{b} (\\Phi_{(bb,)} c_{4}))}) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) (c_{4} x_{113} x_{122})} (I^{[x_{113} := (x_{69} c_{9})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{112},x_{113},x_{114} := (x_{69} c_{9}),x_{112},x_{113}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))})) (S (I^{[x_{112},x_{113} := (x_{69} c_{9}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{cb} c_{4} (\\Phi_{(b,cb)} c_{1})) (\\Phi_{cb} c_{2} \\Phi_{cb})}))	SS
100	271	t	S (S (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{5} (c_{12} (\\lambda x_{120}.x_{81} x_{120}) (\\lambda x_{120}.x_{82} x_{120})) x_{80}) x_{122}) (c_{7} (c_{11} (\\lambda x_{120}.c_{7} (x_{82} x_{120}))))} (I^{[x_{80} := (\\lambda x_{120}.x_{80})]} A^{= (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{cbbcb} \\Phi_{b} \\Phi_{bb} c_{12})) (\\Phi_{ccccbbb} \\Phi_{b} c_{12} (\\Phi_{(bbb,bb)} c_{5}) \\Phi_{b} (\\Phi_{cccbbb} \\Phi_{b}) c_{12} \\Phi_{b})})) (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{5} (c_{12} (\\lambda x_{120}.x_{81} x_{120}) (\\lambda x_{120}.x_{82} x_{120})) x_{80}) (c_{5} (c_{12} (\\lambda x_{120}.x_{81} x_{120}) (\\lambda x_{120}.x_{82} x_{120})) x_{122})) (c_{7} (c_{11} (\\lambda x_{120}.c_{7} (x_{82} x_{120}))))} A^{= (\\Phi_{cccb} (\\Phi_{bb} c_{7}) c_{11} c_{4} \\Phi_{cbbb}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12} \\Phi_{K})}) (S (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{5} (c_{12} (\\lambda x_{120}.x_{81} x_{120}) (\\lambda x_{120}.x_{82} x_{120})) x_{80}) (c_{5} (c_{12} (\\lambda x_{120}.x_{81} x_{120}) (\\lambda x_{120}.x_{82} x_{120})) (c_{4} x_{122} x_{80}))) (c_{7} (c_{11} (\\lambda x_{120}.c_{7} (x_{82} x_{120}))))} (I^{[x_{112} := (c_{11} (\\lambda x_{120}.c_{7} (x_{82} x_{120})))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))) (I^{[x_{69},x_{112} := (\\lambda x_{122}.c_{1} (c_{5} (c_{12} (\\lambda x_{120}.x_{81} x_{120}) (\\lambda x_{120}.x_{82} x_{120})) x_{80}) (c_{5} (c_{12} (\\lambda x_{120}.x_{81} x_{120}) (\\lambda x_{120}.x_{82} x_{120})) (c_{4} (c_{7} x_{122}) x_{80}))),(c_{7} (c_{11} (\\lambda x_{120}.c_{7} (x_{82} x_{120}))))]} A^{= (\\Phi_{bbc} \\Phi_{b} c_{2} c_{8}) (\\Phi_{b} (\\Phi_{(bb,)} c_{2}))}) (S (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{5} (c_{12} (\\lambda x_{65}.x_{81} x_{65}) (\\lambda x_{65}.x_{82} x_{65})) x_{80}) (c_{5} (c_{12} (\\lambda x_{65}.x_{81} x_{65}) (\\lambda x_{65}.x_{82} x_{65})) (c_{4} x_{122} x_{80}))) (c_{7} (c_{11} (\\lambda x_{120}.c_{7} (x_{82} x_{120}))))} A^{= (c_{7} c_{8}) c_{9}})) (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{5} (c_{12} (\\lambda x_{65}.x_{81} x_{65}) (\\lambda x_{65}.x_{82} x_{65})) x_{80}) (c_{5} (c_{12} (\\lambda x_{65}.x_{81} x_{65}) (\\lambda x_{65}.x_{82} x_{65})) x_{122})) (c_{7} (c_{11} (\\lambda x_{120}.c_{7} (x_{82} x_{120}))))} (I^{[x_{112} := x_{80}]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})) (S (L^{\\lambda x_{122}.c_{2} x_{122} (c_{7} (c_{11} (\\lambda x_{120}.c_{7} (x_{82} x_{120}))))} (I^{[x_{113} := (c_{5} (c_{12} (\\lambda x_{65}.x_{81} x_{65}) (\\lambda x_{65}.x_{82} x_{65})) x_{80})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{112} := (c_{7} (c_{11} (\\lambda x_{120}.c_{7} (x_{82} x_{120}))))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) A^{= T c_{8}}	DM
101	272	t	S (S (I^{[x_{113} := c_{8}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})})	DM
69	234	t	I^{[x_{112},x_{113} := (c_{5} (c_{1} x_{102} x_{101}) x_{113}),(x_{69} x_{101})]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{4} (x_{69} x_{101}) x_{122}} (I^{[x_{112},x_{113} := x_{113},(c_{1} x_{102} x_{101})]} A^{= (\\Phi_{ccbb} c_{7} c_{4} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{5} (\\Phi_{bcb} c_{7}))})) (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{113}),(c_{7} (c_{1} x_{102} x_{101})),(x_{69} x_{101})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}) (S (L^{\\lambda x_{122}.c_{4} x_{122} (c_{7} x_{113})} (I^{[x_{112},x_{113} := (c_{7} (c_{1} x_{102} x_{101})),(x_{69} x_{101})]} A^{= (\\Phi_{cb} c_{4} \\Phi_{cb}) (\\Phi_{c(cb,b)} c_{5} c_{4} \\Phi_{cbcb} c_{7})}))) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (x_{69} x_{101}) x_{122}) (c_{7} (c_{1} x_{102} x_{101}))) (c_{7} x_{113})} (I^{[x_{112} := (c_{1} x_{102} x_{101})]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (S (L^{\\lambda x_{122}.c_{4} x_{122} (c_{7} x_{113})} (I^{[x_{112},x_{113} := (c_{1} x_{102} x_{101}),(c_{5} (x_{69} x_{101}) (c_{1} x_{102} x_{101}))]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}))) (L^{\\lambda x_{122}.c_{4} (c_{2} x_{122} (c_{1} x_{102} x_{101})) (c_{7} x_{113})} A^{= (\\Phi_{bb} (\\Phi_{cb} c_{1}) (\\Phi_{(bb,cb)} c_{5})) (\\Phi_{b} (\\Phi_{c(bbb,)} c_{1} \\Phi_{bcb} c_{5}))}) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{7} x_{113})} (I^{[x_{112},x_{113} := (c_{1} x_{102} x_{101}),(c_{5} (x_{69} x_{102}) (c_{1} x_{102} x_{101}))]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{5} (x_{69} x_{102}) x_{122}) (c_{7} (c_{1} x_{102} x_{101}))) (c_{7} x_{113})} (I^{[x_{112} := (c_{1} x_{102} x_{101})]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{7} x_{113})} (I^{[x_{112},x_{113} := (c_{7} (c_{1} x_{102} x_{101})),(x_{69} x_{102})]} A^{= (\\Phi_{cb} c_{4} \\Phi_{cb}) (\\Phi_{c(cb,b)} c_{5} c_{4} \\Phi_{cbcb} c_{7})})) (S (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{113}),(c_{7} (c_{1} x_{102} x_{101})),(x_{69} x_{102})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{4} (x_{69} x_{102}) x_{122}} (I^{[x_{112},x_{113} := x_{113},(c_{1} x_{102} x_{101})]} A^{= (\\Phi_{ccbb} c_{7} c_{4} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{5} (\\Phi_{bcb} c_{7}))}))) (S (I^{[x_{112},x_{113} := (c_{5} (c_{1} x_{102} x_{101}) x_{113}),(x_{69} x_{102})]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}))	SS
102	273	t	S (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	SS
113	284	t	I^{[x_{82} := (\\lambda x_{120}.c_{5} (x_{82} x_{120}) (x_{81} x_{120}))]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{11}) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12} \\Phi_{b})} (L^{\\lambda x_{122}.c_{11} (\\lambda x_{120}.x_{122})} (I^{[x_{112},x_{113} := (c_{5} (x_{82} x_{120}) (x_{81} x_{120})),(x_{80} x_{120})]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{11} (\\lambda x_{120}.c_{4} (x_{80} x_{120}) x_{122})} (I^{[x_{112},x_{113} := (x_{81} x_{120}),(x_{82} x_{120})]} A^{= (\\Phi_{ccbb} c_{7} c_{4} \\Phi_{cbb} c_{7}) (\\Phi_{cb} c_{5} (\\Phi_{bcb} c_{7}))})) (L^{\\lambda x_{122}.c_{11} (\\lambda x_{120}.x_{122})} (I^{[x_{112},x_{113},x_{114} := (c_{7} (x_{81} x_{120})),(c_{7} (x_{82} x_{120})),(x_{80} x_{120})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{11} (\\lambda x_{120}.x_{122})} (I^{[x_{112},x_{113} := (x_{81} x_{120}),(c_{4} (x_{80} x_{120}) (c_{7} (x_{82} x_{120})))]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}))) (S (I^{[x_{80},x_{82} := (\\lambda x_{120}.c_{4} (x_{80} x_{120}) (c_{7} (x_{82} x_{120}))),(\\lambda x_{120}.x_{81} x_{120})]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{11}) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12} \\Phi_{b})})) (S (L^{\\lambda x_{122}.c_{12} (\\lambda x_{120}.x_{122}) (\\lambda x_{120}.x_{81} x_{120})} (I^{[x_{112},x_{113} := (x_{82} x_{120}),(x_{80} x_{120})]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})})))	SS
105	276	t	S (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (S (I^{[x_{112},x_{113},x_{114} := (c_{7} x_{112}),x_{112},x_{113}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{4} x_{113} x_{122}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} x_{113} x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}}	DM
103	274	f	L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{112},x_{113},x_{114} := x_{113},x_{113},x_{112}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})	EO DM
104	275	t	S (L^{\\lambda x_{122}.c_{2} (c_{1} x_{113} x_{112}) x_{122}} A^{= (\\Phi_{cb} c_{1} \\Phi_{cb}) (\\Phi_{c(bb,)} c_{2} (\\Phi_{(bb,cb)} c_{5}) c_{2})} (I^{[x_{112} := (c_{1} x_{113} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})})) A^{= T c_{8}}	DM
114	285	t	A^{= (\\Phi_{cccbb} \\Phi_{b} \\Phi_{cbb} c_{12} \\Phi_{ccbb} (\\Phi_{(bb,b)} c_{2})) (\\Phi_{bbbb} (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5})) \\Phi_{bcb} c_{12} \\Phi_{b})} (L^{\\lambda x_{122}.c_{12} (\\lambda x_{120}.x_{122}) (\\lambda x_{120}.x_{81} x_{120})} (I^{[x_{112},x_{113} := (x_{82} x_{120}),(x_{80} x_{120})]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}))	SS
115	286	t	A^{= (\\Phi_{cccbb} \\Phi_{b} \\Phi_{cbb} c_{12} \\Phi_{ccbb} (\\Phi_{(bb,b)} c_{2})) (\\Phi_{bbbb} (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5})) \\Phi_{bcb} c_{12} \\Phi_{b})} (L^{\\lambda x_{122}.c_{12} (\\lambda x_{120}.x_{122}) (\\lambda x_{120}.x_{81} x_{120})} (I^{[x_{112},x_{113} := (x_{82} x_{120}),(x_{80} x_{120})]} A^{= (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{1}) (\\Phi_{cb} c_{2} \\Phi_{cb})}))	SS
106	277	t	S (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{cb} c_{4} (\\Phi_{(b,cb)} c_{1})) (\\Phi_{cb} c_{2} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) (c_{4} (c_{5} x_{113} x_{112}) x_{122})} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{112},x_{113},x_{114} := x_{113},x_{112},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) (c_{4} x_{122} x_{113})} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{5} c_{4} \\Phi_{cbcb})})) (I^{[x_{112},x_{113} := x_{113},x_{112}]} (M_{1}^{1} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))	DM
116	287	t	A^{= (\\Phi_{cccbb} \\Phi_{b} \\Phi_{cbb} c_{12} \\Phi_{ccbb} (\\Phi_{(bb,b)} c_{2})) (\\Phi_{bbbb} (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5})) \\Phi_{bcb} c_{12} \\Phi_{b})} (L^{\\lambda x_{122}.c_{12} (\\lambda x_{120}.x_{122}) (\\lambda x_{120}.x_{81} x_{120})} (I^{[x_{112},x_{113} := (x_{82} x_{120}),(x_{80} x_{120})]} A^{= (\\Phi_{cb} c_{4} (\\Phi_{(b,cb)} c_{1})) (\\Phi_{cb} c_{2} \\Phi_{cb})}))	SS
107	278	t	S (I^{[x_{112},x_{113} := (c_{4} (c_{5} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{cb} c_{4} (\\Phi_{(b,cb)} c_{1})) (\\Phi_{cb} c_{2} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{112},x_{113} := (c_{4} (c_{5} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) (c_{4} (c_{4} (c_{5} x_{114} x_{113}) x_{112}) x_{122})} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{112},x_{113},x_{114} := x_{113},x_{112},(c_{4} (c_{5} x_{114} x_{113}) x_{112})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) (c_{4} x_{122} x_{113})} (I^{[x_{113},x_{114} := x_{112},(c_{5} x_{114} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) (c_{4} (c_{4} (c_{5} x_{114} x_{113}) x_{122}) x_{113})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{112},x_{113},x_{114} := x_{113},x_{112},(c_{5} x_{114} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) (c_{4} (c_{5} x_{114} x_{113}) x_{122})} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{114} := (c_{5} x_{114} x_{113})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{4}) c_{4} \\Phi_{cbcb}) (\\Phi_{cb} c_{4} (\\Phi_{cbcb} c_{4} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) (c_{4} x_{122} x_{112})} (I^{[x_{112},x_{113} := x_{113},x_{114}]} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{5} c_{4} \\Phi_{cbcb})}))) (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})})	DM
71	238	t	S (I^{[x_{113} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (S (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} x_{122}) (c_{7} x_{112})} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{cb} c_{4} \\Phi_{cb}) (\\Phi_{c(cb,b)} c_{5} c_{4} \\Phi_{cbcb} c_{7})}) (S A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}))	SS
117	288	f	S (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{12} (\\lambda x_{120}.x_{81} x_{120}) (\\lambda x_{120}.x_{82} x_{120})) (c_{12} (\\lambda x_{120}.x_{80} x_{120}) (\\lambda x_{120}.x_{82} x_{120}))) (c_{12} (\\lambda x_{120}.x_{122}) (\\lambda x_{120}.x_{82} x_{120}))} (I^{[x_{112},x_{113} := (x_{80} x_{120}),(x_{81} x_{120})]} A^{= (\\Phi_{cb} c_{1} \\Phi_{cb}) (\\Phi_{c(bb,)} c_{2} (\\Phi_{(bb,cb)} c_{5}) c_{2})})) (S (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{12} (\\lambda x_{120}.x_{81} x_{120}) (\\lambda x_{120}.x_{82} x_{120})) (c_{12} (\\lambda x_{120}.x_{80} x_{120}) (\\lambda x_{120}.x_{82} x_{120}))) x_{122}} (I^{[x_{80},x_{81} := (\\lambda x_{120}.c_{2} (x_{81} x_{120}) (x_{80} x_{120})),(\\lambda x_{120}.c_{2} (x_{80} x_{120}) (x_{81} x_{120}))]} A^{= (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{cbbcb} \\Phi_{b} \\Phi_{bb} c_{12})) (\\Phi_{ccccbbb} \\Phi_{b} c_{12} (\\Phi_{(bbb,bb)} c_{5}) \\Phi_{b} (\\Phi_{cccbbb} \\Phi_{b}) c_{12} \\Phi_{b})})))	DM
72	239	t	S (I^{[x_{113} := (x_{69} c_{8})]} A^{= (\\Phi_{c(cb,)} c_{5} c_{2} \\Phi_{cbcb}) (\\Phi_{cb} c_{2} \\Phi_{cb})} (S (L^{\\lambda x_{122}.c_{2} x_{122} x_{112}} A^{= (\\Phi_{bbc} \\Phi_{b} c_{5} c_{8}) (\\Phi_{b} (\\Phi_{(bb,)} c_{5}))})) (I^{[x_{113} := (c_{5} (x_{69} x_{112}) x_{112})]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (L^{\\lambda x_{122}.c_{4} (c_{5} (x_{69} x_{112}) x_{122}) (c_{7} x_{112})} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (I^{[x_{112},x_{113} := (c_{7} x_{112}),(x_{69} x_{112})]} A^{= (\\Phi_{cb} c_{4} \\Phi_{cb}) (\\Phi_{c(cb,b)} c_{5} c_{4} \\Phi_{cbcb} c_{7})}) (S (I^{[x_{113} := (x_{69} x_{112})]} A^{= (\\Phi_{cbb} c_{4} \\Phi_{cb} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})})))	SS
127	348	f	S (L^{\\lambda x_{122}.c_{11} (\\lambda x_{65}.c_{11} (\\lambda x_{66}.c_{2} (c_{15} x_{66} x_{65}) (c_{5} (c_{11} (\\lambda x_{120}.c_{17} x_{66} x_{120})) x_{122})))} (I^{[x_{80} := (\\lambda x_{120}.c_{17} x_{65} x_{120})]} A^{= (\\Phi_{bb} c_{11} \\Phi_{b}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) c_{12} \\Phi_{b})})) (S (L^{\\lambda x_{122}.c_{11} (\\lambda x_{65}.c_{11} (\\lambda x_{66}.c_{2} (c_{15} x_{66} x_{65}) (c_{5} x_{122} (c_{12} (\\lambda x_{120}.c_{17} x_{65} x_{120}) (\\lambda x_{120}.c_{8})))))} (I^{[x_{80} := (\\lambda x_{120}.c_{17} x_{66} x_{120})]} A^{= (\\Phi_{bb} c_{11} \\Phi_{b}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) c_{12} \\Phi_{b})}))) (L^{\\lambda x_{122}.c_{11} (\\lambda x_{65}.c_{11} (\\lambda x_{66}.c_{2} (c_{15} x_{66} x_{65}) x_{122}))} (I^{[x_{80},x_{81},x_{82} := (\\lambda x_{120}.c_{17} x_{65} x_{120}),(\\lambda x_{120}.c_{17} x_{66} x_{120}),(\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{cbbcb} \\Phi_{b} \\Phi_{bb} c_{12})) (\\Phi_{ccccbbb} \\Phi_{b} c_{12} (\\Phi_{(bbb,bb)} c_{5}) \\Phi_{b} (\\Phi_{cccbbb} \\Phi_{b}) c_{12} \\Phi_{b})})) (S (L^{\\lambda x_{122}.c_{11} (\\lambda x_{65}.c_{11} (\\lambda x_{66}.c_{2} (c_{15} x_{66} x_{65}) (c_{12} (\\lambda x_{120}.x_{122}) (\\lambda x_{120}.c_{8}))))} (I^{[x_{112} := (c_{5} (c_{17} x_{66} x_{120}) (c_{17} x_{65} x_{120}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}))) (L^{\\lambda x_{122}.c_{11} (\\lambda x_{65}.c_{11} (\\lambda x_{66}.c_{2} (c_{15} x_{66} x_{65}) (c_{12} (\\lambda x_{120}.x_{122}) (\\lambda x_{120}.c_{8}))))} (I^{[x_{112},x_{113},x_{114} := (c_{17} x_{65} x_{120}),(c_{17} x_{66} x_{120}),c_{8}]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{11} (\\lambda x_{65}.c_{11} (\\lambda x_{66}.c_{2} (c_{15} x_{66} x_{65}) (c_{12} (\\lambda x_{120}.c_{5} (c_{5} x_{122} (c_{17} x_{66} x_{120})) (c_{17} x_{65} x_{120})) (\\lambda x_{120}.c_{8}))))} (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})})) (S (L^{\\lambda x_{122}.c_{11} (\\lambda x_{65}.c_{11} (\\lambda x_{66}.c_{2} (c_{15} x_{66} x_{65}) (c_{12} (\\lambda x_{120}.c_{5} x_{122} (c_{17} x_{65} x_{120})) (\\lambda x_{120}.c_{8}))))} (I^{[x_{69},x_{112} := (\\lambda x_{122}.c_{1} x_{122} c_{8}),(c_{17} x_{66} x_{120})]} A^{= (\\Phi_{bbc} \\Phi_{b} c_{5} c_{8}) (\\Phi_{b} (\\Phi_{(bb,)} c_{5}))}))) (S (L^{\\lambda x_{122}.c_{11} (\\lambda x_{65}.c_{11} (\\lambda x_{66}.c_{2} (c_{15} x_{66} x_{65}) (c_{12} (\\lambda x_{120}.x_{122}) (\\lambda x_{120}.c_{8}))))} (I^{[x_{112},x_{113},x_{114} := (c_{17} x_{65} x_{120}),(c_{17} x_{66} x_{120}),(c_{1} (c_{17} x_{66} x_{120}) c_{8})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))}))) (L^{\\lambda x_{122}.c_{11} (\\lambda x_{65}.c_{11} (\\lambda x_{66}.c_{2} (c_{15} x_{66} x_{65}) (c_{12} (\\lambda x_{120}.c_{5} (c_{1} (c_{17} x_{66} x_{120}) c_{8}) x_{122}) (\\lambda x_{120}.c_{8}))))} (I^{[x_{112},x_{113} := (c_{17} x_{65} x_{120}),(c_{17} x_{66} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{11} (\\lambda x_{65}.c_{11} (\\lambda x_{66}.c_{2} (c_{15} x_{66} x_{65}) (c_{12} (\\lambda x_{120}.x_{122}) (\\lambda x_{120}.c_{8}))))} (I^{[x_{112},x_{113},x_{114} := (c_{17} x_{66} x_{120}),(c_{17} x_{65} x_{120}),(c_{1} (c_{17} x_{66} x_{120}) c_{8})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))})) (S (L^{\\lambda x_{122}.c_{11} (\\lambda x_{65}.c_{11} (\\lambda x_{66}.c_{2} (c_{15} x_{66} x_{65}) (c_{12} (\\lambda x_{120}.c_{5} x_{122} (c_{17} x_{66} x_{120})) (\\lambda x_{120}.c_{8}))))} (I^{[x_{69},x_{112} := (\\lambda x_{122}.c_{1} (c_{17} x_{66} x_{120}) x_{122}),(c_{17} x_{65} x_{120})]} A^{= (\\Phi_{bbc} \\Phi_{b} c_{5} c_{8}) (\\Phi_{b} (\\Phi_{(bb,)} c_{5}))}))) (S (L^{\\lambda x_{122}.c_{11} (\\lambda x_{65}.c_{11} (\\lambda x_{66}.c_{2} (c_{15} x_{66} x_{65}) (c_{12} (\\lambda x_{120}.x_{122}) (\\lambda x_{120}.c_{8}))))} (I^{[x_{112},x_{113},x_{114} := (c_{17} x_{66} x_{120}),(c_{17} x_{65} x_{120}),(c_{1} (c_{17} x_{66} x_{120}) (c_{17} x_{65} x_{120}))]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{5}) c_{5} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{5} \\Phi_{cb}))}))) (S (L^{\\lambda x_{122}.c_{11} (\\lambda x_{65}.c_{11} (\\lambda x_{66}.c_{2} (c_{15} x_{66} x_{65}) x_{122}))} (I^{[x_{80},x_{81},x_{82} := (\\lambda x_{120}.c_{5} (c_{17} x_{65} x_{120}) (c_{17} x_{66} x_{120})),(\\lambda x_{120}.c_{1} (c_{17} x_{66} x_{120}) (c_{17} x_{65} x_{120})),(\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{cbbcb} \\Phi_{b} \\Phi_{bb} c_{12})) (\\Phi_{ccccbbb} \\Phi_{b} c_{12} (\\Phi_{(bbb,bb)} c_{5}) \\Phi_{b} (\\Phi_{cccbbb} \\Phi_{b}) c_{12} \\Phi_{b})}))) (L^{\\lambda x_{122}.c_{11} (\\lambda x_{65}.c_{11} (\\lambda x_{66}.x_{122}))} (I^{[x_{112},x_{113},x_{114} := (c_{12} (\\lambda x_{120}.c_{5} (c_{17} x_{65} x_{120}) (c_{17} x_{66} x_{120})) (\\lambda x_{120}.c_{8})),(c_{12} (\\lambda x_{120}.c_{1} (c_{17} x_{66} x_{120}) (c_{17} x_{65} x_{120})) (\\lambda x_{120}.c_{8})),(c_{15} x_{66} x_{65})]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{2}) c_{2} \\Phi_{cbcb}) (\\Phi_{cb} c_{5} (\\Phi_{cbcb} c_{2} \\Phi_{cb}))})) (L^{\\lambda x_{122}.c_{11} (\\lambda x_{65}.c_{11} (\\lambda x_{66}.c_{2} (c_{2} (c_{15} x_{66} x_{65}) x_{122}) (c_{12} (\\lambda x_{120}.c_{5} (c_{17} x_{65} x_{120}) (c_{17} x_{66} x_{120})) (\\lambda x_{120}.c_{8}))))} (I^{[x_{80} := (\\lambda x_{120}.c_{1} (c_{17} x_{66} x_{120}) (c_{17} x_{65} x_{120}))]} A^{= (\\Phi_{bb} c_{11} \\Phi_{b}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) c_{12} \\Phi_{b})}))	DM
\.


--
-- Name: solucion_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.solucion_id_seq', 127, true);


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
99	= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{5} (\\Phi_{(bbb,bcb)} \\Phi_{bb} c_{2})) (\\Phi_{b} (\\Phi_{c(cbbbb,)} c_{1} c_{5} \\Phi_{bbcb} \\Phi_{bb} c_{2}))	f	
100	= (\\Phi_{bbc} \\Phi_{b} c_{2} c_{8}) (\\Phi_{b} (\\Phi_{(bb,)} c_{2}))	f	
101	= (\\Phi_{cbbbc} c_{5} \\Phi_{bb} \\Phi_{bb} c_{2} c_{8}) (\\Phi_{cb} c_{5} (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2}))	f	
102	= (\\Phi_{cbc} c_{2} \\Phi_{cb} c_{9}) (\\Phi_{b} (\\Phi_{(b,b)} c_{2}))	f	
103	= (\\Phi_{bcbc} (\\Phi_{cb} c_{4}) c_{2} \\Phi_{cbcb} c_{9}) (\\Phi_{b} (\\Phi_{c(cbb,)} c_{4} c_{2} \\Phi_{cbcb}))	f	
104	= (\\Phi_{bbc} \\Phi_{b} c_{5} c_{8}) (\\Phi_{b} (\\Phi_{(bb,)} c_{5}))	f	
105	= (\\Phi_{bbc} \\Phi_{b} c_{4} c_{9}) (\\Phi_{b} (\\Phi_{(bb,)} c_{4}))	f	
106	= (\\Phi_{(cbbc,bc)} c_{7} (\\Phi_{(bbb,b)} c_{4}) c_{5} c_{9} c_{5} c_{8}) (\\Phi_{b} \\Phi_{b})	f	
107	= T (c_{11} (\\Phi_{bcc(ccb,b)} c_{11} c_{16} (\\Phi_{(bb,b)} c_{1}) c_{11} c_{15} (\\Phi_{(bcb,bcbb)} c_{2}) c_{16}))	f	
108	= T (c_{13} (\\Phi_{bbb} c_{11} (\\Phi_{bb} c_{7}) c_{16}))	f	
109	= T (c_{11} (\\Phi_{bcc(ccb,b)} c_{11} c_{16} (\\Phi_{(bb,b)} c_{1}) c_{11} c_{15} (\\Phi_{(bcb,bcbb)} c_{1}) c_{16}))	f	
110	= T (c_{11} (\\Phi_{bccbb} c_{11} c_{15} (\\Phi_{(b(bb,b),b)} c_{1} c_{4}) (\\Phi_{bcbcbb} c_{13} c_{16} (\\Phi_{bbb} c_{11})) c_{15}))	f	
111	= (\\Phi_{K} T) (\\Phi_{bccb} c_{11} c_{16} (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) (\\Phi_{bcb(cb,b)} c_{13} c_{16} (\\Phi_{bbb} c_{11})))	f	
112	= T (c_{11} (\\Phi_{bcbcccbbb} c_{13} c_{16} (\\Phi_{bbb} c_{11}) \\Phi_{cb} c_{16} c_{14} (\\Phi_{(bcbcb,b)} c_{1}) \\Phi_{b} c_{16}))	f	
113	= T (c_{12} (\\Phi_{(bccbbbb,bb)} c_{14} c_{16} \\Phi_{b} \\Phi_{bbb} c_{12} \\Phi_{b} c_{17} \\Phi_{b} c_{16}) (\\Phi_{b} (c_{59} c_{18})))	f	
114	= T (c_{13} (\\Phi_{(bb(ccbb,b),cb)} c_{5} c_{11} c_{20} c_{24} (\\Phi_{(bb(bb,),b)} c_{2}) c_{16} c_{16} c_{18} c_{16}))	f	
115	= T (c_{11} (\\Phi_{bcbbb} c_{13} c_{16} (\\Phi_{bbb} c_{11}) (\\Phi_{(bb,b)} c_{1}) c_{27}))	f	
98	= (\\Phi_{bb} (\\Phi_{cb} c_{15}) (\\Phi_{(bb,cb)} c_{2})) (\\Phi_{b} (\\Phi_{c(bbb,)} c_{15} \\Phi_{bcb} c_{2}))	f	
116	= c_{8} (c_{11} (\\Phi_{K} c_{8}))	f	
10	= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})	f	
117	= (\\Phi_{bb} (\\Phi_{bb} c_{11}) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12} \\Phi_{b})	f	
118	= (\\Phi_{bcb} (\\Phi_{bb} c_{11}) c_{7} (\\Phi_{(bb,bb)} c_{4})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12} \\Phi_{b})	f	
119	= (\\Phi_{ccb} (\\Phi_{(bb,(bb,b))} c_{1}) c_{5} (\\Phi_{b(ccb,)} c_{11})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12} \\Phi_{b})	f	
120	= (\\Phi_{b(cb,)} (\\Phi_{bb} c_{11}) c_{4} (\\Phi_{(bb,(bb,b))} c_{1})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12} \\Phi_{b})	f	
121	= (\\Phi_{cccbb} \\Phi_{b} \\Phi_{cbb} c_{12} \\Phi_{ccbb} (\\Phi_{(bb,b)} c_{2})) (\\Phi_{bbbb} (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5})) \\Phi_{bcb} c_{12} \\Phi_{b})	f	
122	= (\\Phi_{cccbcb} \\Phi_{b} \\Phi_{cbb} c_{12} \\Phi_{ccbb} c_{7} (\\Phi_{(bb,bb)} c_{4})) (\\Phi_{bbbb} (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5})) \\Phi_{bcb} c_{12} \\Phi_{b})	f	
123	= (\\Phi_{cccb} \\Phi_{b} \\Phi_{cb(ccb,)} c_{12} (\\Phi_{ccccbb} (\\Phi_{(bb,(bb,b))} c_{1}) c_{5})) (\\Phi_{bbbb} (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5})) \\Phi_{bcb} c_{12} \\Phi_{b})	f	
124	= (\\Phi_{cccb(cb,)} \\Phi_{b} \\Phi_{cbb} c_{12} \\Phi_{ccbb} c_{4} (\\Phi_{(bb,(bb,b))} c_{1})) (\\Phi_{bbbb} (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5})) \\Phi_{bcb} c_{12} \\Phi_{b})	f	
125	= (\\Phi_{bcb} (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12}) c_{4} \\Phi_{cbb}) (\\Phi_{ccbcb} \\Phi_{b} c_{12} (\\Phi_{cbbb} \\Phi_{b}) c_{4} \\Phi_{cbbb})	f	
126	= (\\Phi_{cccb} (\\Phi_{bb} c_{7}) c_{11} c_{4} \\Phi_{cbbb}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12} \\Phi_{K})	f	
127	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbcb,cb)} c_{12} \\Phi_{b} c_{12} (\\Phi_{cccc(cbbb,bb)} (\\Phi_{bb} c_{7}) c_{11} c_{7} \\Phi_{b} \\Phi_{b}) c_{5} (\\Phi_{(b(bcbbb,bb),bbb)} c_{2} c_{1}) c_{5} \\Phi_{cbb})	f	
128	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(cccccbbb,)} (\\Phi_{(bb,b)} c_{1}) c_{12} \\Phi_{b} c_{12} (\\Phi_{(b(bbb,bb),bb)} c_{2} c_{1}) \\Phi_{b} (\\Phi_{c(cccbbb,bcb)} \\Phi_{b} \\Phi_{b}) c_{12} \\Phi_{b})	f	
129	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbbb,bb)} \\Phi_{b} c_{2} \\Phi_{bbcb} (\\Phi_{c(cbbbb,)} (\\Phi_{(bb,b)} c_{4})) c_{12} \\Phi_{b} c_{12} \\Phi_{b})	f	
130	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(cbcbbb,)} (\\Phi_{(bb,b)} c_{5}) c_{12} (\\Phi_{cbbcb} \\Phi_{b}) \\Phi_{b} (\\Phi_{(bbb,bb)} c_{2}) c_{12} \\Phi_{b})	f	
131	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbcbbb,b)} c_{12} \\Phi_{b} c_{12} (\\Phi_{c(cbbb,bb)} \\Phi_{b} \\Phi_{b}) \\Phi_{b} (\\Phi_{(b(bbb,bb),bb)} c_{2} c_{2}) c_{12} \\Phi_{b} (\\Phi_{(bb,b)} c_{2}))	f	
132	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(cbbb,)} c_{2} \\Phi_{cbb} c_{11} \\Phi_{b})	f	
133	= (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) c_{12} (\\Phi_{bb} c_{7})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{14} \\Phi_{b})	f	
134	= (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12} \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) c_{14} (\\Phi_{bb} c_{7}))	f	
135	= (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{12} (\\Phi_{bb} c_{7})) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) c_{14} \\Phi_{b})	f	
136	= (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) c_{12} \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{14} (\\Phi_{bb} c_{7}))	f	
137	= (\\Phi_{bb} (\\Phi_{bb} c_{13}) (\\Phi_{(bb,b)} c_{5})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{14} \\Phi_{b})	f	
138	= (\\Phi_{cccbb} \\Phi_{b} \\Phi_{cbb} c_{14} \\Phi_{ccbb} (\\Phi_{(bb,b)} c_{5})) (\\Phi_{bbbb} (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5})) \\Phi_{bcb} c_{14} \\Phi_{b})	f	
139	= (\\Phi_{bcb} (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{14}) c_{5} \\Phi_{cbb}) (\\Phi_{ccbcb} \\Phi_{b} c_{14} (\\Phi_{cbbb} \\Phi_{b}) c_{5} \\Phi_{cbbb})	f	
140	= (\\Phi_{cccb} \\Phi_{b} c_{13} c_{5} \\Phi_{cbbb}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} c_{14} \\Phi_{K})	f	
141	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbcb,cb)} c_{14} \\Phi_{b} c_{14} (\\Phi_{ccc(cbbb,bb)} \\Phi_{b} c_{13} \\Phi_{b} \\Phi_{b}) c_{4} (\\Phi_{(b(bcbbb,bb),bb)} c_{2} c_{1}) c_{4} \\Phi_{cbb})	f	
142	= (\\Phi_{K} c_{9}) (\\Phi_{bb} (c_{14} (\\Phi_{K} c_{9})) \\Phi_{b})	f	
143	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cbbb,bbb)} (\\Phi_{(bb,b)} c_{4}) (\\Phi_{cccb} \\Phi_{b}) c_{14} \\Phi_{b} (\\Phi_{(bbcb,bb)} c_{2}) c_{14} \\Phi_{b})	f	
144	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(cccbbb,)} (\\Phi_{(bb,b)} c_{4}) c_{14} (\\Phi_{(bbb,bb)} c_{2}) \\Phi_{b} (\\Phi_{cccbbcb} \\Phi_{b}) c_{14} \\Phi_{b})	f	
145	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbcbbb,b)} c_{12} \\Phi_{b} c_{14} (\\Phi_{c(cbbb,bb)} \\Phi_{b} \\Phi_{b}) \\Phi_{b} (\\Phi_{(b(bbb,bb),bb)} c_{2} c_{2}) c_{14} \\Phi_{b} (\\Phi_{(bb,b)} c_{2}))	f	
146	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{b} (\\Phi_{(bbb,c)} c_{2} c_{13} \\Phi_{b}))	f	
147	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cccc(cccccb,)} \\Phi_{b} \\Phi_{cbbb} c_{12} \\Phi_{b} c_{14} \\Phi_{b} (\\Phi_{(bcbcccbb,bb)} c_{2}) c_{12} \\Phi_{cb} (\\Phi_{c(ccccccbb,bcccbb)} \\Phi_{b} \\Phi_{b} \\Phi_{cbcb} c_{14}))	f	
148	= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})	f	
149	= T (c_{11} (\\Phi_{b} (c_{17} c_{18})))	f	
151	= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{20})	f	
152	= (\\Phi_{ccbb} c_{16} (\\Phi_{(bb,b)} c_{4}) \\Phi_{cbb} c_{16}) (\\Phi_{cb} c_{21} (\\Phi_{bbbcb} \\Phi_{b} c_{16} c_{20}))	f	
153	= (\\Phi_{cccbbb} \\Phi_{cb} c_{16} c_{14} \\Phi_{cbcb} \\Phi_{b} c_{16}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{22})	f	
154	= (\\Phi_{cb} c_{21} (\\Phi_{bbcb} c_{22} c_{20})) (\\Phi_{cb} c_{24} \\Phi_{cb})	f	
155	= (\\Phi_{c(cccbb,)} c_{24} \\Phi_{K} c_{16} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{(bcbb,bcb)} c_{19}) c_{16}) (\\Phi_{cb} c_{25} \\Phi_{cb})	f	
157	= (\\Phi_{cc(cbb,b)} c_{17} (\\Phi_{(bb,b)} c_{5}) c_{19} \\Phi_{cbcbb} \\Phi_{K} c_{16}) (\\Phi_{cb} c_{30} \\Phi_{cb})	f	
158	= (\\Phi_{ccbb} c_{16} (\\Phi_{(bb,b)} c_{2}) (\\Phi_{bcbb} c_{11}) c_{16}) (\\Phi_{cb} c_{27} \\Phi_{cb})	f	
159	= (\\Phi_{bb} \\Phi_{b} c_{27}) (\\Phi_{cb} c_{29} \\Phi_{cb})	f	
160	= (\\Phi_{c(cb,)} c_{27} c_{59} (\\Phi_{(bcb,cb)} c_{5})) (\\Phi_{cb} c_{26} \\Phi_{cb})	f	
161	= (\\Phi_{bb} \\Phi_{b} c_{26}) (\\Phi_{cb} c_{28} \\Phi_{cb})	f	
162	= (\\Phi_{c(ccbb,)} c_{21} c_{20} c_{21} (\\Phi_{bcbbcb} c_{20}) c_{20}) (\\Phi_{cb} c_{31} \\Phi_{cb})	f	
163	= (\\Phi_{bb} \\Phi_{b} c_{27}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{35})	f	
164	= (\\Phi_{(bb,)} c_{24} c_{20}) (\\Phi_{b} c_{52})	f	
165	= T (c_{11} (\\Phi_{bbb} c_{13} \\Phi_{b} c_{17}))	f	
156	= (\\Phi_{(bcccbbb,bb)} c_{19} \\Phi_{cb} c_{16} c_{12} \\Phi_{cbcb} \\Phi_{b} c_{16} \\Phi_{K} c_{22}) (\\Phi_{b} c_{23})	f	
167	= (\\Phi_{c(cccccbcbb,)} c_{24} c_{35} c_{35} \\Phi_{K} c_{16} (\\Phi_{(bb,bcbcb)} c_{5}) (\\Phi_{(bcbbb,bbbcb)} c_{19} (\\Phi_{bc(ccbbb,)} c_{13} c_{31} c_{15})) c_{5} (\\Phi_{bcccb} c_{13}) c_{16}) (\\Phi_{cb} c_{32} \\Phi_{cb})	f	
150	= (\\Phi_{ccb} c_{16} (\\Phi_{(bcb,b)} c_{5}) \\Phi_{(cb,b)}) (\\Phi_{ccb} \\Phi_{K} \\Phi_{cb} (\\Phi_{bb(bcb,b)} \\Phi_{b} c_{16} c_{19}))	f	
168	= (\\Phi_{K} T) (\\Phi_{cb(b(b,),)} (c_{1} c_{8} c_{8}) c_{5} c_{1} c_{1})	f	
169	= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})	f	
170	= (\\Phi_{c(cb,)} c_{5} c_{2} \\Phi_{cbcb}) (\\Phi_{cb} c_{2} \\Phi_{cb})	f	
171	= (\\Phi_{bb} c_{11} \\Phi_{b}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) c_{12} \\Phi_{b})	f	
172	= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{9}) c_{12} \\Phi_{b})	f	
173	= (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{cbbcb} \\Phi_{b} \\Phi_{bb} c_{12})) (\\Phi_{ccccbbb} \\Phi_{b} c_{12} (\\Phi_{(bbb,bb)} c_{5}) \\Phi_{b} (\\Phi_{cccbbb} \\Phi_{b}) c_{12} \\Phi_{b})	f	
174	= (\\Phi_{c(ccbbb,bb)} \\Phi_{b} \\Phi_{cbbb} c_{5} (\\Phi_{cccbbb} \\Phi_{b}) c_{12} \\Phi_{b} c_{12} \\Phi_{b}) (\\Phi_{bbbb} (\\Phi_{cb} (\\Phi_{(bb,b)} c_{4})) \\Phi_{bcb} c_{12} \\Phi_{b})	f	
175	= (\\Phi_{ccccb} \\Phi_{b} \\Phi_{cbcccbb} c_{12} \\Phi_{cb} (\\Phi_{ccccccbb} \\Phi_{b} \\Phi_{cbcb} c_{12})) (\\Phi_{ccccb} \\Phi_{b} \\Phi_{cbbb} c_{12} \\Phi_{b} (\\Phi_{cbbcccbb} \\Phi_{b} \\Phi_{bb} c_{12}))	f	
176	= (\\Phi_{bb} c_{13} \\Phi_{b}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) c_{14} \\Phi_{b})	f	
177	= T (c_{11} (\\Phi_{bcccc(cb,bbb)} c_{11} c_{17} \\Phi_{b} c_{11} c_{5} c_{15} (\\Phi_{(bcb,cbbbb)} c_{2}) c_{11} \\Phi_{b} c_{17}))	f	
178	= (\\Phi_{K} T) (\\Phi_{bcc(ccb,)} c_{11} c_{16} (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) c_{16} (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) (\\Phi_{bc(cccccb(cb,b),(cb,b))} c_{11} c_{16} c_{11} (\\Phi_{(bcb,cbbbb)} c_{2}) c_{15} c_{5} c_{11} (\\Phi_{bcccc(cb,bbb)} c_{11} c_{16})))	f	
179	= T (c_{11} (\\Phi_{bcc(ccbb,b)} c_{11} c_{15} (\\Phi_{(b(bb,b),b)} c_{1} c_{4}) c_{15} (\\Phi_{(b(bb,b),b)} c_{1} c_{4}) (\\Phi_{bc(cccccbcbb,cbb)} c_{11} c_{16} c_{11} (\\Phi_{(bcb,cbbbb)} c_{2}) c_{15} c_{5} c_{11} (\\Phi_{bcccc(cb,bbb)} c_{11} c_{16})) c_{15} c_{15}))	f	
180	= T (c_{11} (\\Phi_{bc(cccccbcccbbb,cccbbb)} c_{11} c_{16} c_{11} (\\Phi_{(bcb,cbbbb)} c_{2}) c_{15} c_{5} c_{11} (\\Phi_{bcccc(cb,bbb)} c_{11} c_{16}) \\Phi_{cb} c_{16} c_{14} (\\Phi_{(bcbcb,b)} c_{1}) \\Phi_{b} c_{16} \\Phi_{cb} c_{16} c_{14} (\\Phi_{(bcbcb,b)} c_{1}) \\Phi_{b} c_{16}))	f	
181	= T (c_{11} (\\Phi_{bcccc(ccbbb,bb)} c_{11} (\\Phi_{(bcb,(bbbb,bbb))} c_{2}) c_{15} c_{5} c_{11} c_{16} c_{11} (\\Phi_{bccccccccb} c_{11} c_{16}) (\\Phi_{(bb,b)} c_{1}) c_{27} (\\Phi_{(bb,b)} c_{1}) c_{27}))	f	
182	= (\\Phi_{ccbb} c_{16} (\\Phi_{(bb,b)} c_{4}) \\Phi_{cbb} c_{16}) (\\Phi_{cb} c_{24} (\\Phi_{bbcb} \\Phi_{b} c_{16}))	f	
183	= (\\Phi_{ccbb} c_{16} (\\Phi_{(bb,b)} c_{5}) \\Phi_{cbb} c_{16}) (\\Phi_{cb} c_{25} (\\Phi_{bbcb} \\Phi_{b} c_{16}))	f	
184	= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{16} c_{18}))	f	
185	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(ccc(ccbb,bb),bb)} \\Phi_{cb} c_{16} c_{12} c_{1} c_{2} \\Phi_{cb(bcbcb,b)} (c_{59} c_{18}) \\Phi_{b} c_{16} c_{16} c_{23})	f	
186	= (\\Phi_{ccbb} c_{17} (\\Phi_{(bb,b)} c_{5}) \\Phi_{cbb} c_{16}) (\\Phi_{cb} c_{30} (\\Phi_{bbcb} \\Phi_{b} c_{16}))	f	
187	= c_{18} (c_{22} c_{18})	f	
188	= c_{18} (c_{23} c_{18})	f	
189	= (\\Phi_{bb} \\Phi_{b} c_{24}) (\\Phi_{cb} c_{24} \\Phi_{cb})	f	
190	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c((ccb,b),)} c_{27} c_{5} c_{15} (\\Phi_{(bcb,(bb,cb))} c_{2}) c_{27})	f	
191	= (\\Phi_{bbb} c_{13} \\Phi_{b} c_{16}) (\\Phi_{b} (c_{59} c_{18}))	f	
192	= (\\Phi_{c(ccb,)} c_{24} \\Phi_{cbcb} c_{25} (\\Phi_{cccbcb} c_{24})) (\\Phi_{bcb} (\\Phi_{cb} c_{25}) c_{24} \\Phi_{cbcb})	f	
193	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bbb,)} c_{27} (\\Phi_{(bb,bcb)} c_{2} (c_{59} c_{18})) c_{5} (c_{59} c_{18}))	f	
194	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c((cbbb,bbbb),)} c_{27} c_{23} (\\Phi_{(bbb,bcb)} c_{2}) c_{27} c_{23} c_{5} c_{13} \\Phi_{b} c_{16})	f	
195	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(cc(ccbbb,b),)} c_{27} (c_{59} c_{18}) c_{5} c_{5} c_{23} (\\Phi_{(bbb,(bcbb,cb))} c_{2}) c_{27} c_{23} (c_{59} c_{18}))	f	
196	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{cb} c_{16} (\\Phi_{(bb,cb)} c_{2} (c_{59} c_{18})))	f	
197	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(cccccb,)} c_{16} c_{23} (\\Phi_{(bbcb,cbbcb)} c_{2} (c_{15} c_{18})) c_{25} c_{5} (c_{15} c_{18}) (\\Phi_{cccc(cbb,cb)} c_{25}))	f	
198	= c_{18} (c_{23} (c_{20} c_{18}))	f	
199	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{cb} c_{21} (\\Phi_{bbcb} (c_{59} c_{18}) c_{20}))	f	
200	= (\\Phi_{cb} c_{25} \\Phi_{cb}) (\\Phi_{cb} c_{21} (\\Phi_{bbcb} c_{23} c_{20}))	f	
201	= (\\Phi_{K} T) (\\Phi_{bb} (c_{59} c_{18}) c_{20})	f	
202	= \\Phi_{} (\\Phi_{bb} c_{23} c_{20})	f	
203	= (\\Phi_{K} T) (\\Phi_{(b,)} c_{17})	f	
204	= T (c_{7} (c_{13} (\\Phi_{bc(bb,)} c_{13} c_{16} (\\Phi_{(bb,cb)} c_{5}) c_{16})))	f	
205	= T (c_{7} (c_{13} (\\Phi_{bc(cccbb,)} c_{13} c_{16} \\Phi_{cb(bb,cb)} c_{5} c_{5} (\\Phi_{bc(cccbcb,)} c_{13} c_{16}) c_{16})))	f	
206	= (\\Phi_{cb} c_{21} (\\Phi_{bcb} c_{20})) (\\Phi_{cb} c_{31} (\\Phi_{bcb} c_{22}))	f	
207	= (\\Phi_{bb} \\Phi_{K} c_{20}) (\\Phi_{cb} c_{31} (\\Phi_{bcb} c_{23}))	f	
208	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(c(bb,),)} c_{59} c_{31} (\\Phi_{(b(bb,cb),cb)} c_{2} c_{59}) c_{31})	f	
209	= (\\Phi_{cb} c_{15} \\Phi_{cb}) (\\Phi_{ccbb} c_{20} c_{15} \\Phi_{cbb} c_{20})	f	
210	= (\\Phi_{cccb} (\\Phi_{cccbcb} c_{15}) c_{5} \\Phi_{cbcb} (\\Phi_{ccccb} c_{15})) (\\Phi_{cb} c_{31} (\\Phi_{bcbcb} (\\Phi_{cb} c_{31}) c_{15} \\Phi_{cbcb}))	f	
211	= (\\Phi_{cbccbb} c_{16} (\\Phi_{cbb} (\\Phi_{bc(ccccbb,)} c_{13} c_{31} c_{15})) c_{5} (\\Phi_{(bcbb,cbcb)} c_{5}) (\\Phi_{bccccb} c_{13}) c_{16}) (\\Phi_{cb} c_{32} (\\Phi_{bbcb} \\Phi_{b} c_{16}))	f	
212	= (\\Phi_{ccccbb} c_{16} \\Phi_{ccbb} c_{5} \\Phi_{cbb} \\Phi_{cccbb} c_{16}) (\\Phi_{cb} c_{32} (\\Phi_{bbbcb} (\\Phi_{cb} c_{31}) \\Phi_{bcb} c_{16}))	f	
213	= (\\Phi_{ccbb} (c_{15} c_{18}) c_{4} \\Phi_{cbb} (c_{15} c_{18})) (\\Phi_{cb} c_{32} (\\Phi_{bcb} (c_{15} c_{18})))	f	
214	= (\\Phi_{cc(cccbb,b)} c_{17} (\\Phi_{(bb,b)} c_{5}) c_{13} c_{16} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{(bbcbb,bcbb)} c_{4} c_{13}) c_{17} c_{16}) (\\Phi_{cb} c_{59} \\Phi_{cb})	f	
215	= (\\Phi_{cc(cb,b)} (c_{15} c_{18}) c_{4} c_{15} (\\Phi_{(bcb,cbb)} c_{4}) (c_{15} c_{18})) (\\Phi_{c(bb,)} c_{32} (\\Phi_{(bb,cb)} c_{15}) c_{32})	f	
216	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cb} c_{32} (\\Phi_{bbcb} (\\Phi_{(bbbcb,b)} c_{2} c_{13} (\\Phi_{bcb} c_{13} c_{31}) c_{15} \\Phi_{cbcb}) c_{16}))	f	
217	= (\\Phi_{c(ccb,)} c_{32} \\Phi_{cbcb} c_{25} (\\Phi_{cccbcb} c_{32})) (\\Phi_{bcb} (\\Phi_{cb} c_{25}) c_{32} \\Phi_{cbcb})	f	
218	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{34} c_{16} c_{24} (\\Phi_{(bbbbcb,bcb)} (\\Phi_{(bb,b)} c_{2}) c_{16} c_{22} c_{22}))	f	
219	= (\\Phi_{ccbbb} c_{16} (\\Phi_{(bbb,bcb)} c_{5}) (\\Phi_{ccbbb} (\\Phi_{bc(cccccb,)} c_{13} c_{31} c_{15}) c_{31}) (\\Phi_{bccccb} c_{13} (\\Phi_{(bbcccbb,cbcb)} c_{5} c_{13} c_{31})) c_{16}) (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{16}) c_{34})	f	
220	= (\\Phi_{(ccbb,b)} \\Phi_{cbb} c_{24} \\Phi_{ccbb} c_{34} c_{34}) (\\Phi_{bbb} (\\Phi_{cb} c_{24}) \\Phi_{bcb} c_{34})	f	
221	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(cccbb,)} c_{25} c_{60} c_{60} c_{25} (\\Phi_{(bcbb,bcb)} c_{27}) c_{60})	f	
222	= (\\Phi_{(bbbb,bbb)} c_{19} (\\Phi_{bcb} c_{13} c_{31}) \\Phi_{bcb} c_{16} \\Phi_{K} c_{22} c_{22}) (\\Phi_{b} c_{60})	f	
223	= (\\Phi_{(bcbbb,bbb)} c_{19} c_{31} (\\Phi_{bbb} c_{13}) \\Phi_{bb} c_{16} \\Phi_{K} c_{22} c_{22}) (\\Phi_{b} c_{61})	f	
224	= (\\Phi_{bbb} (\\Phi_{bcb} c_{13} c_{31}) \\Phi_{bcb} c_{16}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{60})	f	
225	= (\\Phi_{cbbb} c_{31} (\\Phi_{bbb} c_{13}) \\Phi_{bb} c_{16}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{61})	f	
\.


--
-- Name: teorema_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.teorema_id_seq', 225, true);


--
-- Data for Name: teoria; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.teoria (id, nombre) FROM stdin;
1	Predicate Logic
2	Set Theory
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

COPY userdb.usuario (login, nombre, apellido, correo, password, materiaid, admin, autosust, teoriaid) FROM stdin;
admin	Admin	Admin	correodem@asiado.falso	1f0d65c78b2350520c7bb6409104226063e3d9b05cb0a31ba497f489f98ef6bb8c92cd81ba298543d4fb1b293e139d12f4a7110adb157c75075d8a582e1fe97d	1	t	f	1
AdminTeoremas	Admin	Teoremas	admin@teoremas.gries	4b39bf2b2076bb3aec161cfd09ca0614a65f3c0adadb80ff443b8434237ad0a2745018653685a9811f2335dd0b314427ff7568592cd3856ef67ddb0315da4627	1	t	f	2
federico	Federico	Flaviani	federico.flaviani@gmail.com	4b39bf2b2076bb3aec161cfd09ca0614a65f3c0adadb80ff443b8434237ad0a2745018653685a9811f2335dd0b314427ff7568592cd3856ef67ddb0315da4627	1	f	t	2
minender	Sergio	Hernandez	sergio@hernandez	4b39bf2b2076bb3aec161cfd09ca0614a65f3c0adadb80ff443b8434237ad0a2745018653685a9811f2335dd0b314427ff7568592cd3856ef67ddb0315da4627	1	f	t	2
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

