--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.19
-- Dumped by pg_dump version 9.6.8

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
-- Name: userdb; Type: SCHEMA; Schema: -; Owner: userdb
--

CREATE SCHEMA "userdb";


ALTER SCHEMA userdb OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "plpgsql" WITH SCHEMA "pg_catalog";


--
-- Name: EXTENSION "plpgsql"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "plpgsql" IS 'PL/pgSQL procedural language';


--
-- Name: alias_list; Type: DOMAIN; Schema: userdb; Owner: userdb
--

CREATE DOMAIN "userdb"."alias_list" AS "text" NOT NULL
	CONSTRAINT "alias_list_check" CHECK (((VALUE ~ '(^(([A-Z][a-z]*:(1|2)*),\s)*([A-Z][a-z]*:(1|2)*))$'::"text") OR (VALUE ~~ ''::"text")));


ALTER DOMAIN userdb.alias_list OWNER TO userdb;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categoria; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE "userdb"."categoria" (
    "id" integer NOT NULL,
    "nombre" "text" NOT NULL
);


ALTER TABLE userdb.categoria OWNER TO userdb;

--
-- Name: categoria_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE "userdb"."categoria_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.categoria_id_seq OWNER TO userdb;

--
-- Name: categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE "userdb"."categoria_id_seq" OWNED BY "userdb"."categoria"."id";


--
-- Name: dispone; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE "userdb"."dispone" (
    "id" integer NOT NULL,
    "numerometateorema" "text",
    "resuelto" boolean DEFAULT false NOT NULL,
    "loginusuario" "text" NOT NULL,
    "metateoremaid" integer NOT NULL
);


ALTER TABLE userdb.dispone OWNER TO userdb;

--
-- Name: dispone_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE "userdb"."dispone_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.dispone_id_seq OWNER TO userdb;

--
-- Name: dispone_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE "userdb"."dispone_id_seq" OWNED BY "userdb"."dispone"."id";


--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE "userdb"."hibernate_sequence"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.hibernate_sequence OWNER TO userdb;

--
-- Name: materia; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE "userdb"."materia" (
    "id" integer NOT NULL,
    "nombre" "text" NOT NULL
);


ALTER TABLE userdb.materia OWNER TO userdb;

--
-- Name: materia_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE "userdb"."materia_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.materia_id_seq OWNER TO userdb;

--
-- Name: materia_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE "userdb"."materia_id_seq" OWNED BY "userdb"."materia"."id";


--
-- Name: metateorema; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE "userdb"."metateorema" (
    "id" integer NOT NULL,
    "enunciado" "text" NOT NULL,
    "metateoserializado" "bytea" NOT NULL
);


ALTER TABLE userdb.metateorema OWNER TO userdb;

--
-- Name: metateorema_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE "userdb"."metateorema_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.metateorema_id_seq OWNER TO userdb;

--
-- Name: metateorema_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE "userdb"."metateorema_id_seq" OWNED BY "userdb"."metateorema"."id";


--
-- Name: simbolo; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE "userdb"."simbolo" (
    "id" integer NOT NULL,
    "notacion_latex" "text" NOT NULL,
    "argumentos" integer,
    "esinfijo" boolean DEFAULT false NOT NULL,
    "asociatividad" integer,
    "precedencia" integer NOT NULL,
    "notacion" "text" NOT NULL,
    "teoriaid" integer NOT NULL
);


ALTER TABLE userdb.simbolo OWNER TO userdb;

--
-- Name: simbolo_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE "userdb"."simbolo_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.simbolo_id_seq OWNER TO userdb;

--
-- Name: simbolo_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE "userdb"."simbolo_id_seq" OWNED BY "userdb"."simbolo"."id";


--
-- Name: mostrarcategoria; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE "userdb"."mostrarcategoria" (
    "id" integer DEFAULT "nextval"('"userdb"."simbolo_id_seq"'::"regclass") NOT NULL,
    "categoriaid" integer NOT NULL,
    "usuariologin" "text" NOT NULL
);


ALTER TABLE userdb.mostrarcategoria OWNER TO userdb;

--
-- Name: mostrarcategoria_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE "userdb"."mostrarcategoria_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.mostrarcategoria_id_seq OWNER TO userdb;

--
-- Name: predicado; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE "userdb"."predicado" (
    "predicado" "text" NOT NULL,
    "alias" "text" NOT NULL,
    "login" "text" NOT NULL,
    "argumentos" "text" NOT NULL,
    "aliases" "userdb"."alias_list" NOT NULL,
    "notacion" "text" NOT NULL
);


ALTER TABLE userdb.predicado OWNER TO userdb;

--
-- Name: publicacion; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE "userdb"."publicacion" (
    "alias" "text",
    "login" "text"
);


ALTER TABLE userdb.publicacion OWNER TO userdb;

--
-- Name: resuelve; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE "userdb"."resuelve" (
    "id" integer NOT NULL,
    "nombreteorema" "text",
    "numeroteorema" "text" NOT NULL,
    "resuelto" boolean DEFAULT false NOT NULL,
    "loginusuario" "text" NOT NULL,
    "teoremaid" integer NOT NULL,
    "categoriaid" integer NOT NULL
);


ALTER TABLE userdb.resuelve OWNER TO userdb;

--
-- Name: resuelve_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE "userdb"."resuelve_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.resuelve_id_seq OWNER TO userdb;

--
-- Name: resuelve_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE "userdb"."resuelve_id_seq" OWNED BY "userdb"."resuelve"."id";


--
-- Name: solucion; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE "userdb"."solucion" (
    "id" integer NOT NULL,
    "resuelveid" integer NOT NULL,
    "resuelto" boolean DEFAULT false NOT NULL,
    "demostracion" "text" NOT NULL,
    "metodo" "text" NOT NULL
);


ALTER TABLE userdb.solucion OWNER TO userdb;

--
-- Name: solucion_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE "userdb"."solucion_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.solucion_id_seq OWNER TO userdb;

--
-- Name: solucion_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE "userdb"."solucion_id_seq" OWNED BY "userdb"."solucion"."id";

--
-- Name: plantilla_teorema; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.plantilla_teorema (
    id integer NOT NULL,
    template text NOT NULL,
    path_to_placeholders text NOT NULL
);

ALTER TABLE userdb.plantilla_teorema OWNER TO userdb;

--
-- Name: plantilla_teorema_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE userdb.plantilla_teorema_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.plantilla_teorema_id_seq OWNER TO userdb;

COPY userdb.plantilla_teorema (id, template, path_to_placeholders) FROM stdin;
1	(I^{[x_{113} := (%T1)]} A^{c_{1} (c_{1} c_{8} x_{113}) x_{113}}) (%T2)	T2:q
2	(I^{[x_{112} := c_{8}]} A^{c_{1} (c_{5} x_{112} x_{112}) x_{112}}) (L^{\\lambda x_{122}.c_{5} c_{8} x_{122}} (S (%M1P))) (L^{\\lambda x_{122}.c_{5} x_{122} (%P1)} (S (%M1Q))) A^{c_{8}}	M1Q:pqqq;M1P:ppqqq
\.

--
-- Name: resuelve_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE userdb.plantilla_teorema_id_seq OWNED BY userdb.plantilla_teorema.id;

--
-- Name: teorema; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE "userdb"."teorema" (
    "id" integer NOT NULL,
    "enunciado" "text" NOT NULL,
    "esquema" boolean NOT NULL,
    "aliases" "userdb"."alias_list" NOT NULL
);


ALTER TABLE userdb.teorema OWNER TO userdb;

--
-- Name: teorema_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE "userdb"."teorema_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.teorema_id_seq OWNER TO userdb;

--
-- Name: teorema_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE "userdb"."teorema_id_seq" OWNED BY "userdb"."teorema"."id";


--
-- Name: teoria; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE "userdb"."teoria" (
    "id" integer NOT NULL,
    "nombre" "text" NOT NULL
);


ALTER TABLE userdb.teoria OWNER TO userdb;

--
-- Name: teoria_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE "userdb"."teoria_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.teoria_id_seq OWNER TO userdb;

--
-- Name: teoria_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE "userdb"."teoria_id_seq" OWNED BY "userdb"."teoria"."id";


--
-- Name: termino; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE "userdb"."termino" (
    "combinador" "text" NOT NULL,
    "serializado" "bytea" NOT NULL,
    "alias" "text" NOT NULL,
    "login" "text" NOT NULL
);


ALTER TABLE userdb.termino OWNER TO userdb;

--
-- Name: usuario; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE "userdb"."usuario" (
    "login" "text" NOT NULL,
    "nombre" "text" NOT NULL,
    "apellido" "text" NOT NULL,
    "correo" "text" NOT NULL,
    "password" "text" NOT NULL,
    "materiaid" integer NOT NULL,
    "admin" boolean DEFAULT false NOT NULL,
	autosust boolean DEFAULT false NOT NULL
);


ALTER TABLE userdb.usuario OWNER TO userdb;

--
-- Name: categoria id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."categoria" ALTER COLUMN "id" SET DEFAULT "nextval"('"userdb"."categoria_id_seq"'::"regclass");


--
-- Name: dispone id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."dispone" ALTER COLUMN "id" SET DEFAULT "nextval"('"userdb"."dispone_id_seq"'::"regclass");


--
-- Name: metateorema id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."metateorema" ALTER COLUMN "id" SET DEFAULT "nextval"('"userdb"."metateorema_id_seq"'::"regclass");


--
-- Name: resuelve id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."resuelve" ALTER COLUMN "id" SET DEFAULT "nextval"('"userdb"."resuelve_id_seq"'::"regclass");


--
-- Name: simbolo id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."simbolo" ALTER COLUMN "id" SET DEFAULT "nextval"('"userdb"."simbolo_id_seq"'::"regclass");


--
-- Name: solucion id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."solucion" ALTER COLUMN "id" SET DEFAULT "nextval"('"userdb"."solucion_id_seq"'::"regclass");


--
-- Name: teorema id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."teorema" ALTER COLUMN "id" SET DEFAULT "nextval"('"userdb"."teorema_id_seq"'::"regclass");


--
-- Name: teoria id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."teoria" ALTER COLUMN "id" SET DEFAULT "nextval"('"userdb"."teoria_id_seq"'::"regclass");


--
-- Data for Name: categoria; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY "userdb"."categoria" ("id", "nombre") FROM stdin;
1	Addition and Subtraction 
2	Multiplication
6	Arithmetic
7	Trigonometric
3	Absorbent and Signs
5	Exponentiation
4	Division
9	Derivation
10	Finite Difference
8	Function Operations
12	Summation
11	Factorial Polynomials
13	Exercises
\.


--
-- Name: categoria_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('"userdb"."categoria_id_seq"', 13, true);


--
-- Data for Name: dispone; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY "userdb"."dispone" ("id", "numerometateorema", "resuelto", "loginusuario", "metateoremaid") FROM stdin;
\.


--
-- Name: dispone_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('"userdb"."dispone_id_seq"', 1, false);


--
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('"userdb"."hibernate_sequence"', 1, false);


--
-- Data for Name: materia; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY "userdb"."materia" ("id", "nombre") FROM stdin;
1	CI-2525 2020
\.


--
-- Name: materia_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('"userdb"."materia_id_seq"', 1, true);


--
-- Data for Name: metateorema; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY "userdb"."metateorema" ("id", "enunciado", "metateoserializado") FROM stdin;
\.


--
-- Name: metateorema_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('"userdb"."metateorema_id_seq"', 1, false);


--
-- Data for Name: mostrarcategoria; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY "userdb"."mostrarcategoria" ("id", "categoriaid", "usuariologin") FROM stdin;
\.


--
-- Name: mostrarcategoria_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('"userdb"."mostrarcategoria_id_seq"', 1047, true);


--
-- Data for Name: predicado; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY "userdb"."predicado" ("predicado", "alias", "login", "argumentos", "aliases", "notacion") FROM stdin;
\.


--
-- Data for Name: publicacion; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY "userdb"."publicacion" ("alias", "login") FROM stdin;
\.


--
-- Data for Name: resuelve; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY "userdb"."resuelve" ("id", "nombreteorema", "numeroteorema", "resuelto", "loginusuario", "teoremaid", "categoriaid") FROM stdin;
25		5.6	f	AdminTeoremas	25	5
209		5.5	f	AdminTeoremas	81	5
210		6.9	f	AdminTeoremas	82	6
15	Absorbent element of $.$	3.1	f	AdminTeoremas	15	3
16	Absorbent element of $.$	3.2	f	AdminTeoremas	16	3
17	Signs rule	3.3	f	AdminTeoremas	17	3
18	Signs rule	3.4	f	AdminTeoremas	18	3
19	Signs rule	3.5	f	AdminTeoremas	19	3
211		6.10	f	AdminTeoremas	83	6
212		6.11	f	AdminTeoremas	84	6
213		6.12	f	AdminTeoremas	85	6
42	Definition of $2$	6.1	t	AdminTeoremas	42	6
43	Definition of $3$	6.2	t	AdminTeoremas	43	6
44	Definition of $4$	6.3	t	AdminTeoremas	44	6
45	Definition of $5$	6.4	t	AdminTeoremas	45	6
46	Definition of $6$	6.5	t	AdminTeoremas	46	6
47	Definition of $7$	6.6	t	AdminTeoremas	47	6
48	Definition of $8$	6.7	t	AdminTeoremas	48	6
49	Definition of $9$	6.8	t	AdminTeoremas	49	6
50	Fundamental Identity	7.1	t	AdminTeoremas	50	7
51	$0$ angle Identity	7.2	t	AdminTeoremas	51	7
52	$0$ angle Identity	7.3	t	AdminTeoremas	52	7
214		6.13	f	AdminTeoremas	86	6
215		6.14	f	AdminTeoremas	87	6
216		6.15	f	AdminTeoremas	88	6
217		6.16	f	AdminTeoremas	89	6
57		7.12	f	AdminTeoremas	57	7
218		7.10	f	AdminTeoremas	90	7
53		7.9	t	AdminTeoremas	53	7
55		7.8	t	AdminTeoremas	55	7
263	Definition of $^{(n)}$	11.1	t	AdminTeoremas	135	11
56	Inparity of $sin$	7.7	t	AdminTeoremas	56	7
58		7.13	f	AdminTeoremas	58	7
219		7.11	f	AdminTeoremas	91	7
223	Division of functions	8.5	t	AdminTeoremas	95	8
220	Scalar product	8.2	t	AdminTeoremas	92	8
224	Scalar product	8.6	f	AdminTeoremas	96	8
221	Product of functions	8.4	t	AdminTeoremas	93	8
4	Inverse of $+$	1.5	t	AdminTeoremas	4	1
41		2.9	f	AdminTeoremas	41	2
5	Inverse of $+$	1.6	f	AdminTeoremas	5	1
6	Definition of $-$	1.7	t	AdminTeoremas	6	1
14	Distributivity of $.$ over $+$	2.8	f	AdminTeoremas	14	2
13	Distributivity of $.$ over $+$	2.7	t	AdminTeoremas	13	2
12	Inverse of $.$	2.6	f	AdminTeoremas	12	2
11	Inverse of $.$	2.5	t	AdminTeoremas	11	2
10	Neutral Element	2.4	f	AdminTeoremas	10	2
9	Neutral Element	2.3	t	AdminTeoremas	9	2
8	Commutativity of $.$	2.2	t	AdminTeoremas	8	2
31		4.3	f	AdminTeoremas	31	4
32		4.4	f	AdminTeoremas	32	4
37		4.5	f	AdminTeoremas	37	4
222	Scalar product	8.8	f	AdminTeoremas	94	8
54	Parity of $cos$	7.6	t	AdminTeoremas	54	7
34		4.8	f	AdminTeoremas	34	4
21		5.1	t	AdminTeoremas	21	5
22		5.2	t	AdminTeoremas	22	5
23		5.3	t	AdminTeoremas	23	5
24		5.4	t	AdminTeoremas	24	5
33		4.7	f	AdminTeoremas	33	4
40		4.16	f	AdminTeoremas	40	4
39		4.15	f	AdminTeoremas	39	4
38		4.14	f	AdminTeoremas	38	4
36		4.13	f	AdminTeoremas	36	4
35		4.12	f	AdminTeoremas	35	4
225	Scalar product	8.7	f	AdminTeoremas	97	8
241		9.12	t	AdminTeoremas	113	9
60		10.17	f	AdminTeoremas	60	10
59		10.16	f	AdminTeoremas	59	10
29	Definition of $\\frac{1}{a}$	4.1	t	AdminTeoremas	29	4
30	Definition of $\\frac{a}{b}$	4.2	t	AdminTeoremas	30	4
226	Scalar product	8.9	f	AdminTeoremas	98	8
1	Commutativity of $+$	1.2	t	AdminTeoremas	1	1
2	Neutral Element	1.3	t	AdminTeoremas	2	1
3	Neutral Element	1.4	f	AdminTeoremas	3	1
121	Associativity of $+$	1.1	t	AdminTeoremas	61	1
193	Sum of functions	8.1	t	AdminTeoremas	71	8
227	Scalar product	8.10	f	AdminTeoremas	99	8
28		5.9	t	AdminTeoremas	28	5
122	Associativity of $.$	2.1	t	AdminTeoremas	62	2
27		5.8	t	AdminTeoremas	27	5
26		5.7	f	AdminTeoremas	26	5
194	Difference of functions	8.3	f	AdminTeoremas	72	8
228	Scalar product	8.11	f	AdminTeoremas	100	8
229	Scalar product	8.12	f	AdminTeoremas	101	8
230	Scalar product	8.13	f	AdminTeoremas	102	8
192	Definition of $\\Delta$	10.1	t	AdminTeoremas	70	10
195		10.2	f	AdminTeoremas	73	10
240		9.11	t	AdminTeoremas	112	9
239		9.10	t	AdminTeoremas	111	9
238		9.9	t	AdminTeoremas	110	9
237		9.8	t	AdminTeoremas	109	9
236		9.7	t	AdminTeoremas	108	9
235		9.6	f	AdminTeoremas	107	9
234		9.5	t	AdminTeoremas	106	9
233		9.4	t	AdminTeoremas	105	9
231		9.2	t	AdminTeoremas	103	9
232		9.1	t	AdminTeoremas	104	9
207		4.11	f	AdminTeoremas	65	4
246		9.17	t	AdminTeoremas	118	9
245		9.16	t	AdminTeoremas	117	9
244		9.15	t	AdminTeoremas	116	9
243		9.14	t	AdminTeoremas	115	9
242		9.13	t	AdminTeoremas	114	9
247		9.3	t	AdminTeoremas	119	9
248		10.3	f	AdminTeoremas	120	10
249		10.4	f	AdminTeoremas	121	10
199		1.10	f	AdminTeoremas	66	1
7		1.9	f	AdminTeoremas	7	1
196		3.9	f	AdminTeoremas	74	3
202		3.8	f	AdminTeoremas	63	3
20	Signs rule	3.7	f	AdminTeoremas	20	3
250		10.5	f	AdminTeoremas	122	10
251		10.6	f	AdminTeoremas	123	10
252		10.7	f	AdminTeoremas	124	10
253		10.8	f	AdminTeoremas	125	10
254		10.9	f	AdminTeoremas	126	10
255		10.10	f	AdminTeoremas	127	10
256		10.11	f	AdminTeoremas	128	10
257		10.12	f	AdminTeoremas	129	10
258		10.13	f	AdminTeoremas	130	10
259		10.14	f	AdminTeoremas	131	10
204		4.10	f	AdminTeoremas	78	4
203		4.9	f	AdminTeoremas	77	4
208		4.6	f	AdminTeoremas	64	4
206		4.18	f	AdminTeoremas	80	4
205		4.17	f	AdminTeoremas	79	4
260		10.15	f	AdminTeoremas	132	10
261	$\\frac{\\pi}{2}$ angle identity	7.4	t	AdminTeoremas	133	7
262	$\\frac{\\pi}{2}$ angle identity	7.5	t	AdminTeoremas	134	7
264	Definition of $^{(n)}$	11.2	t	AdminTeoremas	136	11
265	Definition of $^{(n)}$	11.3	t	AdminTeoremas	137	11
198		11.4	f	AdminTeoremas	75	11
266		11.5	f	AdminTeoremas	138	11
267		11.6	f	AdminTeoremas	139	11
268		12.1	t	AdminTeoremas	140	12
269		12.2	t	AdminTeoremas	141	12
270		12.3	t	AdminTeoremas	142	12
271		12.4	t	AdminTeoremas	143	12
272		12.5	t	AdminTeoremas	144	12
273		12.6	t	AdminTeoremas	145	12
274		12.7	t	AdminTeoremas	146	12
275		12.8	t	AdminTeoremas	147	12
276		12.9	t	AdminTeoremas	148	12
277		12.10	t	AdminTeoremas	149	12
278		12.11	t	AdminTeoremas	150	12
279		12.12	t	AdminTeoremas	151	12
280		12.13	t	AdminTeoremas	152	12
281		12.14	t	AdminTeoremas	153	12
282		12.15	t	AdminTeoremas	154	12
283	Summation by parts	12.16	t	AdminTeoremas	155	12
7252		3.14	f	AdminTeoremas	168	3
7266		2.10	f	AdminTeoremas	636	2
7267		2.11	f	AdminTeoremas	198	2
7268		1.8	f	AdminTeoremas	167	1
7269		3.16	f	AdminTeoremas	165	3
7270		3.17	f	AdminTeoremas	265	3
7253	Signs rule	3.6	f	AdminTeoremas	390	3
7271		4.19	f	AdminTeoremas	182	4
7272		4.20	f	AdminTeoremas	178	4
7273		4.21	f	AdminTeoremas	215	4
7274		3.18	f	AdminTeoremas	214	3
7275		4.22	f	AdminTeoremas	194	4
7276		4.23	f	AdminTeoremas	269	4
7277		4.24	f	AdminTeoremas	637	4
7278		4.25	f	AdminTeoremas	440	4
7279		4.26	f	AdminTeoremas	638	4
7280		4.27	f	AdminTeoremas	211	4
7072		11.7	f	AdminTeoremas	282	11
7073		11.8	f	AdminTeoremas	286	11
7074		13.4	f	AdminTeoremas	294	13
7075		13.5	f	AdminTeoremas	295	13
7076		13.6	f	AdminTeoremas	629	13
7077		13.7	f	AdminTeoremas	297	13
7078		13.9	f	AdminTeoremas	630	13
7079		13.10	f	AdminTeoremas	631	13
7080		13.11	f	AdminTeoremas	632	13
7254		3.10	f	AdminTeoremas	612	3
7255		3.11	f	AdminTeoremas	222	3
7256		1.15	f	AdminTeoremas	633	1
201		1.12	f	AdminTeoremas	76	1
200		1.11	f	AdminTeoremas	67	1
437		10.18	f	AdminTeoremas	156	10
438		10.19	f	AdminTeoremas	157	10
7257		6.17	f	AdminTeoremas	162	6
7263		3.12	f	AdminTeoremas	635	3
7264		3.13	f	AdminTeoremas	246	3
7265		3.15	f	AdminTeoremas	216	3
7261		1.18	f	AdminTeoremas	634	1
7260		1.17	f	AdminTeoremas	260	1
7259		1.14	f	AdminTeoremas	205	1
7262		1.13	f	AdminTeoremas	262	1
6369		7.15	t	AdminTeoremas	314	7
6370		12.17	t	AdminTeoremas	315	12
6525		13.1	f	AdminTeoremas	280	13
6367		7.14	t	AdminTeoremas	313	7
6685		13.3	f	AdminTeoremas	293	13
6690		13.8	f	AdminTeoremas	411	13
6654		13.2	f	AdminTeoremas	285	13
\.


--
-- Name: resuelve_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('"userdb"."resuelve_id_seq"', 7479, true);


--
-- Data for Name: simbolo; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY "userdb"."simbolo" ("id", "notacion_latex", "argumentos", "esinfijo", "asociatividad", "precedencia", "notacion", "teoriaid") FROM stdin;
1	\\equiv	2	t	0	1	%(aa2) %(op) %(a1)	1
2	\\Rightarrow	2	t	1	2	%(a2) %(op) %(aa1)	1
3	\\Leftarrow	2	t	0	2	%(aa2) %(op) %(a1)	1
4	\\vee	2	t	0	3	%(aa2) %(op) %(a1)	1
5	\\wedge	2	t	0	3	%(aa2) %(op) %(a1)	1
6	\\not\\equiv	2	t	0	4	%(a2) %(op) %(a1)	1
7	\\neg	1	t	1	5	%(op) %(aa1)	1
8	true	0	t	0	0	%(op)	1
9	false	0	t	0	0	%(op)	1
10	0	0	t	0	0	%(op)	1
11	1	0	t	0	0	%(op)	1
12	2	0	t	0	0	%(op)	1
13	3	0	t	0	0	%(op)	1
14	4	0	t	0	0	%(op)	1
15	5	0	t	0	0	%(op)	1
16	6	0	t	0	0	%(op)	1
17	7	0	t	0	0	%(op)	1
18	8	0	t	0	0	%(op)	1
19	9	0	t	0	0	%(op)	1
21	+	2	t	0	6	%(a2) %(op) %(a1)	1
22	-	2	t	0	6	%(a2) %(op) %(a1)	1
25	-	1	f	3	9	%(op)%(a1)	1
24	 	2	f	3	8	\\frac{%(na2)}{%(na1)}	1
27	sin	1	f	3	11	%(op)(%(na1))	1
28	cos	1	f	3	11	%(op)(%(na1))	1
23	.	2	t	3	7	%(a2) %(op) %(a1)	1
26	^	2	f	3	10	%(a2)^{%(na1)}	1
29	 	2	f	3	7	%(a1)(%(na2))	1
31	\\Delta	2	f	3	12	(%(op) %(a1))(%(na2))	1
30	\\prime	1	f	3	12	%(a1)^{%(op)}	1
32		2	f	3	10	%(a2)^{(%(na1))}	1
33	\\Sigma	1	f	3	12	%(op) %(a1)	1
34	\\pi	0	f	3	0	%(op)	1
20	=	2	t	3	5	%(a2) %(op) %(a1)	1
\.


--
-- Name: simbolo_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('"userdb"."simbolo_id_seq"', 34, true);


--
-- Data for Name: solucion; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY "userdb"."solucion" ("id", "resuelveid", "resuelto", "demostracion", "metodo") FROM stdin;
\.


--
-- Name: solucion_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('"userdb"."solucion_id_seq"', 3744, true);


--
-- Data for Name: teorema; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY "userdb"."teorema" ("id", "enunciado", "esquema", "aliases") FROM stdin;
1	c_{20} (c_{21} x_{97} x_{98}) (c_{21} x_{98} x_{97})	f	
2	c_{20} x_{97} (c_{21} c_{10} x_{97})	f	
3	c_{20} x_{97} (c_{21} x_{97} c_{10})	f	
4	c_{20} c_{10} (c_{21} (c_{25} x_{97}) x_{97})	f	
5	c_{20} c_{10} (c_{21} x_{97} (c_{25} x_{97}))	f	
6	c_{20} (c_{21} (c_{25} x_{98}) x_{97}) (c_{22} x_{98} x_{97})	f	
7	c_{20} c_{10} (c_{22} x_{97} x_{97})	f	
8	c_{20} (c_{23} x_{97} x_{98}) (c_{23} x_{98} x_{97})	f	
9	c_{20} x_{97} (c_{23} c_{11} x_{97})	f	
10	c_{20} x_{97} (c_{23} x_{97} c_{11})	f	
11	c_{20} c_{11} (c_{23} (c_{26} (c_{25} c_{11}) x_{97}) x_{97})	f	
12	c_{20} c_{11} (c_{23} x_{97} (c_{26} (c_{25} c_{11}) x_{97}))	f	
13	c_{20} (c_{21} (c_{23} x_{99} x_{97}) (c_{23} x_{98} x_{97})) (c_{23} (c_{21} x_{99} x_{98}) x_{97})	f	
14	c_{20} (c_{21} (c_{23} x_{97} x_{99}) (c_{23} x_{97} x_{98})) (c_{23} x_{97} (c_{21} x_{99} x_{98}))	f	
15	c_{20} c_{10} (c_{23} c_{10} x_{97})	f	
16	c_{20} c_{10} (c_{23} x_{97} c_{10})	f	
17	c_{20} (c_{25} (c_{23} x_{98} x_{97})) (c_{23} (c_{25} x_{98}) x_{97})	f	
18	c_{20} (c_{25} (c_{23} x_{98} x_{97})) (c_{23} x_{98} (c_{25} x_{97}))	f	
19	c_{20} (c_{23} x_{98} x_{97}) (c_{23} (c_{25} x_{98}) (c_{25} x_{97}))	f	
20	c_{20} (c_{23} x_{97} (c_{25} c_{11})) (c_{25} x_{97})	f	
21	c_{20} c_{11} (c_{26} c_{10} x_{97})	f	
22	c_{20} (c_{23} x_{97} (c_{26} (c_{22} c_{11} x_{110}) x_{97})) (c_{26} x_{110} x_{97})	f	
23	c_{20} (c_{26} (c_{21} x_{109} x_{110}) x_{97}) (c_{23} (c_{26} x_{109} x_{97}) (c_{26} x_{110} x_{97}))	f	
24	c_{20} (c_{26} (c_{22} x_{109} x_{110}) x_{97}) (c_{24} (c_{26} x_{109} x_{97}) (c_{26} x_{110} x_{97}))	f	
25	c_{20} (c_{24} x_{99} (c_{23} x_{98} (c_{26} (c_{22} x_{109} x_{110}) x_{97}))) (c_{24} (c_{23} x_{99} (c_{26} x_{109} x_{97})) (c_{23} x_{98} (c_{26} x_{110} x_{97})))	f	
26	c_{20} (c_{24} x_{99} (c_{23} (c_{26} (c_{22} x_{109} x_{110}) x_{97}) x_{98})) (c_{24} (c_{23} (c_{26} x_{109} x_{97}) x_{99}) (c_{23} (c_{26} x_{110} x_{97}) x_{98}))	f	
27	c_{20} (c_{26} (c_{23} x_{109} x_{110}) x_{97}) (c_{26} x_{109} (c_{26} x_{110} x_{97}))	f	
28	c_{20} (c_{23} (c_{26} x_{110} x_{98}) (c_{26} x_{110} x_{97})) (c_{26} x_{110} (c_{23} x_{98} x_{97}))	f	
29	c_{20} (c_{26} (c_{25} c_{11}) x_{97}) (c_{24} x_{97} c_{11})	f	
30	c_{20} (c_{23} (c_{24} x_{98} c_{11}) x_{97}) (c_{24} x_{98} x_{97})	f	
31	c_{20} (c_{23} x_{97} (c_{24} x_{98} c_{11})) (c_{24} x_{98} x_{97})	f	
32	c_{20} (c_{24} x_{99} (c_{23} x_{98} x_{97})) (c_{23} (c_{24} x_{99} x_{98}) x_{97})	f	
33	c_{20} x_{98} (c_{24} x_{97} (c_{23} x_{98} x_{97}))	f	
34	c_{20} x_{98} (c_{24} x_{97} (c_{23} x_{97} x_{98}))	f	
35	c_{20} (c_{24} x_{98} (c_{21} (c_{23} x_{98} x_{99}) x_{97})) (c_{21} x_{99} (c_{24} x_{98} x_{97}))	f	
36	c_{20} (c_{24} x_{99} (c_{21} x_{98} (c_{23} x_{99} x_{97}))) (c_{21} (c_{24} x_{99} x_{98}) x_{97})	f	
37	c_{20} (c_{24} (c_{23} x_{100} x_{98}) (c_{23} x_{99} x_{97})) (c_{23} (c_{24} x_{100} x_{99}) (c_{24} x_{98} x_{97}))	f	
38	c_{20} (c_{24} (c_{23} x_{100} x_{98}) (c_{21} (c_{23} x_{98} x_{99}) (c_{23} x_{100} x_{97}))) (c_{21} (c_{24} x_{100} x_{99}) (c_{24} x_{98} x_{97}))	f	
39	c_{20} (c_{24} x_{99} x_{98}) (c_{24} (c_{23} x_{99} x_{97}) (c_{23} x_{98} x_{97}))	f	
40	c_{20} (c_{24} x_{99} x_{98}) (c_{24} (c_{23} x_{97} x_{99}) (c_{23} x_{97} x_{98}))	f	
41	c_{20} (c_{26} (c_{25} c_{11}) (c_{23} x_{98} x_{97})) (c_{23} (c_{26} (c_{25} c_{11}) x_{98}) (c_{26} (c_{25} c_{11}) x_{97}))	f	
42	c_{20} (c_{21} c_{11} c_{11}) c_{12}	f	
43	c_{20} (c_{21} c_{11} c_{12}) c_{13}	f	
44	c_{20} (c_{21} c_{11} c_{13}) c_{14}	f	
45	c_{20} (c_{21} c_{11} c_{14}) c_{15}	f	
46	c_{20} (c_{21} c_{11} c_{15}) c_{16}	f	
47	c_{20} (c_{21} c_{11} c_{16}) c_{17}	f	
48	c_{20} (c_{21} c_{11} c_{17}) c_{18}	f	
49	c_{20} (c_{21} c_{11} c_{18}) c_{19}	f	
50	c_{20} c_{11} (c_{21} (c_{26} c_{12} (c_{27} x_{116})) (c_{26} c_{12} (c_{28} x_{116})))	f	
51	c_{20} c_{11} (c_{28} c_{10})	f	
52	c_{20} c_{10} (c_{27} c_{10})	f	
53	c_{20} (c_{22} (c_{23} (c_{27} x_{98}) (c_{27} x_{97})) (c_{23} (c_{28} x_{98}) (c_{28} x_{97}))) (c_{28} (c_{21} x_{98} x_{97}))	f	
55	c_{20} (c_{21} (c_{23} (c_{28} x_{98}) (c_{27} x_{97})) (c_{23} (c_{27} x_{98}) (c_{28} x_{97}))) (c_{27} (c_{21} x_{98} x_{97}))	f	
57	c_{20} (c_{24} c_{12} (c_{22} (c_{28} (c_{23} x_{116} c_{12})) c_{11})) (c_{26} c_{12} (c_{27} x_{116}))	f	
58	c_{20} (c_{24} c_{12} (c_{21} (c_{28} (c_{23} x_{116} c_{12})) c_{11})) (c_{26} c_{12} (c_{28} x_{116}))	f	
59	c_{20} (c_{23} (c_{28} (c_{23} (c_{21} (c_{24} c_{12} x_{104}) x_{120}) x_{97})) (c_{23} (c_{27} (c_{24} c_{12} (c_{23} x_{104} x_{97}))) c_{12})) (c_{22} (c_{27} (c_{23} x_{120} x_{97})) (c_{27} (c_{23} (c_{21} x_{104} x_{120}) x_{97})))	f	
60	c_{20} (c_{23} (c_{27} (c_{23} (c_{21} (c_{24} c_{12} x_{104}) x_{120}) x_{97})) (c_{23} (c_{27} (c_{24} c_{12} (c_{23} x_{104} x_{97}))) (c_{25} c_{12}))) (c_{22} (c_{28} (c_{23} x_{120} x_{97})) (c_{28} (c_{23} (c_{21} x_{104} x_{120}) x_{97})))	f	
61	c_{20} (c_{21} (c_{21} x_{99} x_{98}) x_{97}) (c_{21} x_{99} (c_{21} x_{98} x_{97}))	f	
62	c_{20} (c_{23} (c_{23} x_{99} x_{98}) x_{97}) (c_{23} x_{99} (c_{23} x_{98} x_{97}))	f	
63	c_{20} x_{97} (c_{25} (c_{25} x_{97}))	f	
64	c_{20} c_{11} (c_{24} x_{97} x_{97})	f	
65	c_{20} (c_{24} x_{99} (c_{21} x_{98} x_{97})) (c_{21} (c_{24} x_{99} x_{98}) (c_{24} x_{99} x_{97}))	f	
66	c_{20} c_{10} (c_{25} c_{10})	f	
67	c_{20} x_{97} (c_{22} c_{10} x_{97})	f	
68	c_{20} x_{97} (c_{26} c_{11} x_{97})	f	
69	x_{104}	f	
54	c_{20} (c_{28} x_{116}) (c_{28} (c_{25} x_{116}))	f	
70	c_{20} (c_{22} (x_{102} x_{120}) (x_{102} (c_{21} c_{11} x_{120}))) (c_{31} x_{102} x_{120})	f	
56	c_{20} (c_{25} (c_{27} x_{116})) (c_{27} (c_{25} x_{116}))	f	
140	c_{20} x_{120} (c_{33} c_{11})	f	
141	c_{20} (c_{24} (c_{21} c_{11} x_{109}) (c_{32} (c_{21} c_{11} x_{109}) x_{120})) (c_{33} (c_{32} x_{109} x_{120}))	f	
124	c_{20} (c_{23} (c_{31} x_{102} x_{120}) c_{12}) (c_{31} (c_{23} x_{102} c_{12}) x_{120})	f	
71	c_{20} (c_{21} (x_{103} x_{120}) (x_{102} x_{120})) (c_{21} x_{103} x_{102} x_{120})	f	
279	c_{20} (c_{22} x_{98} (c_{21} x_{99} x_{97})) (c_{22} (c_{22} x_{99} x_{98}) x_{97})	f	
74	c_{20} (c_{22} x_{98} (c_{25} x_{97})) (c_{25} (c_{21} x_{98} x_{97}))	f	
125	c_{20} (c_{23} (c_{31} x_{102} x_{120}) c_{13}) (c_{31} (c_{23} x_{102} c_{13}) x_{120})	f	
138	c_{20} (c_{23} (c_{32} c_{11} x_{120}) c_{12}) (c_{31} (c_{32} c_{12} x_{120}) x_{120})	f	
73	c_{20} (c_{21} (c_{31} x_{103} x_{120}) (c_{31} x_{102} x_{120})) (c_{31} (c_{21} x_{103} x_{102}) x_{120})	f	
76	c_{20} (c_{25} x_{97}) (c_{22} x_{97} c_{10})	f	
78	c_{20} (c_{24} x_{98} c_{11}) (c_{24} (c_{23} x_{97} x_{98}) x_{97})	f	
126	c_{20} (c_{23} (c_{31} x_{102} x_{120}) c_{14}) (c_{31} (c_{23} x_{102} c_{14}) x_{120})	f	
77	c_{20} (c_{24} x_{98} c_{11}) (c_{24} (c_{23} x_{98} x_{97}) x_{97})	f	
79	c_{20} (c_{24} x_{99} x_{98}) (c_{24} (c_{23} x_{97} x_{99}) (c_{23} x_{98} x_{97}))	f	
80	c_{20} (c_{24} x_{99} x_{98}) (c_{24} (c_{23} x_{99} x_{97}) (c_{23} x_{97} x_{98}))	f	
81	c_{20} (c_{26} c_{12} x_{97}) (c_{23} x_{97} x_{97})	f	
82	c_{20} c_{18} (c_{22} c_{11} c_{19})	f	
83	c_{20} c_{17} (c_{22} c_{11} c_{18})	f	
84	c_{20} c_{16} (c_{22} c_{11} c_{17})	f	
85	c_{20} c_{15} (c_{22} c_{11} c_{16})	f	
86	c_{20} c_{14} (c_{22} c_{11} c_{15})	f	
87	c_{20} c_{13} (c_{22} c_{11} c_{14})	f	
88	c_{20} c_{12} (c_{22} c_{11} c_{13})	f	
89	c_{20} c_{11} (c_{22} c_{11} c_{12})	f	
91	c_{20} (c_{22} (c_{26} c_{12} (c_{27} x_{116})) (c_{26} c_{12} (c_{28} x_{116}))) (c_{28} (c_{23} x_{116} c_{12}))	f	
90	c_{20} (c_{23} (c_{23} (c_{28} x_{116}) (c_{27} x_{116})) c_{12}) (c_{27} (c_{23} x_{116} c_{12}))	f	
93	c_{20} (c_{23} (x_{103} x_{120}) (x_{102} x_{120})) (c_{23} x_{103} x_{102} x_{120})	f	
94	c_{20} (c_{23} (x_{102} x_{120}) c_{13}) (c_{23} x_{102} c_{13} x_{120})	f	
127	c_{20} (c_{23} (c_{31} x_{102} x_{120}) c_{15}) (c_{31} (c_{23} x_{102} c_{15}) x_{120})	f	
92	c_{20} (c_{25} (x_{102} x_{120})) (c_{25} x_{102} x_{120})	f	
95	c_{20} (c_{24} (x_{103} x_{120}) (x_{102} x_{120})) (c_{24} x_{103} x_{102} x_{120})	f	
96	c_{20} (c_{23} (x_{102} x_{120}) c_{12}) (c_{23} x_{102} c_{12} x_{120})	f	
97	c_{20} (c_{23} (x_{102} x_{120}) (c_{25} c_{12})) (c_{23} x_{102} (c_{25} c_{12}) x_{120})	f	
98	c_{20} (c_{23} (x_{102} x_{120}) (c_{25} c_{13})) (c_{23} x_{102} (c_{25} c_{13}) x_{120})	f	
99	c_{20} (c_{23} (x_{102} x_{120}) c_{14}) (c_{23} x_{102} c_{14} x_{120})	f	
100	c_{20} (c_{23} (x_{102} x_{120}) (c_{25} c_{14})) (c_{23} x_{102} (c_{25} c_{14}) x_{120})	f	
101	c_{20} (c_{23} (x_{102} x_{120}) c_{15}) (c_{23} x_{102} c_{15} x_{120})	f	
102	c_{20} (c_{23} (x_{102} x_{120}) (c_{25} c_{15})) (c_{23} x_{102} (c_{25} c_{15}) x_{120})	f	
103	c_{20} c_{11} (c_{30} x_{120})	f	
104	c_{20} c_{10} (c_{30} c_{11})	f	
105	c_{20} (c_{25} (c_{30} x_{102})) (c_{30} (c_{25} x_{102}))	f	
106	c_{20} (c_{21} (c_{30} x_{103}) (c_{30} x_{102})) (c_{30} (c_{21} x_{103} x_{102}))	f	
107	c_{20} (c_{22} (c_{30} x_{103}) (c_{30} x_{102})) (c_{30} (c_{22} x_{103} x_{102}))	f	
108	c_{20} (c_{21} (c_{23} (c_{30} x_{103}) x_{102}) (c_{23} x_{103} (c_{30} x_{102}))) (c_{30} (c_{23} x_{103} x_{102}))	f	
109	c_{20} (c_{25} (c_{24} (c_{26} c_{12} x_{102}) (c_{30} x_{102}))) (c_{30} (c_{24} x_{102} c_{11}))	f	
110	c_{20} (c_{24} (c_{26} c_{12} x_{103}) (c_{22} (c_{23} (c_{30} x_{103}) x_{102}) (c_{23} x_{103} (c_{30} x_{102})))) (c_{30} (c_{24} x_{103} x_{102}))	f	
111	c_{20} (c_{23} (c_{30} x_{102}) c_{12}) (c_{30} (c_{23} x_{102} c_{12}))	f	
112	c_{20} (c_{23} (c_{30} x_{102}) c_{13}) (c_{30} (c_{23} x_{102} c_{13}))	f	
113	c_{20} (c_{23} (c_{30} x_{102}) c_{14}) (c_{30} (c_{23} x_{102} c_{14}))	f	
114	c_{20} (c_{23} x_{102} c_{15}) (c_{30} (c_{23} x_{102} c_{15}))	f	
115	c_{20} (c_{23} (c_{30} x_{102}) c_{16}) (c_{30} (c_{23} x_{102} c_{16}))	f	
116	c_{20} (c_{23} (c_{30} x_{102}) c_{17}) (c_{30} (c_{23} x_{102} c_{17}))	f	
117	c_{20} (c_{23} (c_{30} x_{102}) c_{18}) (c_{30} (c_{23} x_{102} c_{18}))	f	
118	c_{20} (c_{23} (c_{30} x_{102}) c_{19}) (c_{30} (c_{23} x_{102} c_{19}))	f	
119	c_{20} (c_{23} (c_{26} (c_{22} c_{11} x_{110}) x_{120}) x_{110}) (c_{30} (c_{26} x_{110} x_{120}))	f	
120	c_{20} (c_{25} (c_{31} x_{102} x_{120})) (c_{31} (c_{25} x_{102}) x_{120})	f	
121	c_{20} (c_{22} (c_{31} x_{103} x_{120}) (c_{31} x_{102} x_{120})) (c_{31} (c_{22} x_{103} x_{102}) x_{120})	f	
122	c_{20} (c_{21} (c_{23} (c_{31} x_{103} x_{120}) (x_{102} x_{120})) (c_{23} (x_{103} (c_{21} c_{11} x_{120})) (c_{31} x_{102} x_{120}))) (c_{31} (c_{23} x_{103} x_{102}) x_{120})	f	
123	c_{20} (c_{24} (c_{23} (x_{103} (c_{21} c_{11} x_{120})) (x_{103} x_{120})) (c_{22} (c_{23} (c_{31} x_{103} x_{120}) (x_{102} x_{120})) (c_{23} (x_{103} x_{120}) (c_{31} x_{102} x_{120})))) (c_{31} (c_{24} x_{103} x_{102}) x_{120})	f	
128	c_{20} (c_{23} (c_{31} x_{102} x_{120}) c_{16}) (c_{31} (c_{23} x_{102} c_{16}) x_{120})	f	
129	c_{20} (c_{23} (c_{31} x_{102} x_{120}) c_{17}) (c_{31} (c_{23} x_{102} c_{17}) x_{120})	f	
130	c_{20} (c_{23} (c_{31} x_{102} x_{120}) c_{18}) (c_{31} (c_{23} x_{102} c_{18}) x_{120})	f	
131	c_{20} (c_{23} (c_{31} x_{102} x_{120}) c_{19}) (c_{31} (c_{23} x_{102} c_{19}) x_{120})	f	
132	c_{20} (c_{26} x_{120} c_{12}) (c_{31} (c_{26} x_{120} c_{12}) x_{120})	f	
133	c_{20} c_{10} (c_{28} (c_{24} c_{12} c_{34}))	f	
134	c_{20} c_{11} (c_{27} (c_{24} c_{12} c_{34}))	f	
136	c_{20} (c_{23} (x_{102} (c_{22} c_{11} x_{120})) (x_{102} x_{120})) (c_{32} c_{12} (x_{102} x_{120}))	f	
137	c_{20} (c_{23} (x_{102} (c_{22} c_{12} x_{120})) (c_{23} (x_{102} (c_{22} c_{11} x_{120})) (x_{102} x_{120}))) (c_{32} c_{13} (x_{102} x_{120}))	f	
135	c_{20} (x_{102} x_{120}) (c_{32} c_{11} (x_{102} x_{120}))	f	
75	c_{20} c_{11} (c_{31} (c_{32} c_{11} x_{120}) x_{120})	f	
139	c_{20} (c_{23} (c_{32} c_{12} x_{120}) c_{13}) (c_{31} (c_{32} c_{13} x_{120}) x_{120})	f	
142	c_{20} (c_{26} x_{120} c_{12}) (c_{33} (c_{26} x_{120} c_{12}))	f	
143	c_{20} (c_{25} (c_{24} (c_{23} (c_{27} (c_{24} c_{12} x_{97})) c_{12}) (c_{28} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) x_{97})))) (c_{33} (c_{27} (c_{23} x_{120} x_{97})))	f	
144	c_{20} (c_{24} (c_{23} (c_{27} (c_{24} c_{12} x_{97})) c_{12}) (c_{27} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) x_{97}))) (c_{33} (c_{28} (c_{23} x_{120} x_{97})))	f	
145	c_{20} (c_{21} (c_{33} x_{103}) (c_{33} x_{102})) (c_{33} (c_{21} x_{103} x_{102}))	f	
146	c_{20} (c_{25} (c_{33} x_{102})) (c_{33} (c_{25} x_{102}))	f	
147	c_{20} (c_{23} (c_{33} x_{102}) c_{12}) (c_{33} (c_{23} x_{102} c_{12}))	f	
148	c_{20} (c_{23} (c_{33} x_{102}) c_{13}) (c_{33} (c_{23} x_{102} c_{13}))	f	
149	c_{20} (c_{23} (c_{33} x_{102}) c_{14}) (c_{33} (c_{23} x_{102} c_{14}))	f	
150	c_{20} (c_{23} (c_{33} x_{102}) c_{15}) (c_{33} (c_{23} x_{102} c_{15}))	f	
151	c_{20} (c_{23} (c_{33} x_{102}) c_{16}) (c_{33} (c_{23} x_{102} c_{16}))	f	
152	c_{20} (c_{23} (c_{33} x_{102}) c_{17}) (c_{33} (c_{23} x_{102} c_{17}))	f	
153	c_{20} (c_{23} (c_{33} x_{102}) c_{18}) (c_{33} (c_{23} x_{102} c_{18}))	f	
154	c_{20} (c_{23} (c_{33} x_{102}) c_{19}) (c_{33} (c_{23} x_{102} c_{19}))	f	
155	c_{20} (c_{22} (c_{33} (c_{23} (c_{31} x_{102} x_{120}) (x_{103} (c_{21} c_{11} x_{120})))) (c_{23} (x_{103} x_{120}) (x_{102} x_{120}))) (c_{33} (c_{23} (c_{31} x_{103} x_{120}) (x_{102} x_{120})))	f	
156	c_{20} (c_{23} (c_{28} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) x_{97})) (c_{23} (c_{27} (c_{24} c_{12} x_{97})) c_{12})) (c_{31} (c_{27} (c_{23} x_{120} x_{97})) x_{120})	f	
157	c_{20} (c_{23} (c_{27} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) x_{97})) (c_{23} (c_{27} (c_{24} c_{12} x_{97})) (c_{25} c_{12}))) (c_{31} (c_{28} (c_{23} x_{120} x_{97})) x_{120})	f	
158	c_{20} (c_{21} (c_{22} x_{99} x_{98}) x_{97}) (c_{22} x_{99} (c_{21} x_{98} x_{97}))	f	
159	c_{20} x_{97} (c_{22} c_{11} (c_{21} c_{11} x_{97}))	f	
160	c_{20} x_{97} (c_{21} (c_{22} x_{98} x_{98}) x_{97})	f	
162	c_{20} (c_{23} x_{97} c_{12}) (c_{21} x_{97} x_{97})	f	
163	c_{20} (c_{22} (c_{26} c_{12} (c_{28} x_{116})) c_{11}) (c_{26} c_{12} (c_{27} x_{116}))	f	
164	c_{20} (c_{22} (c_{26} c_{12} (c_{27} x_{116})) c_{11}) (c_{26} c_{12} (c_{28} x_{116}))	f	
165	c_{20} (c_{21} x_{98} (c_{25} x_{97})) (c_{25} (c_{22} x_{98} x_{97}))	f	
166	c_{20} (c_{22} x_{97} x_{98}) (c_{25} (c_{22} x_{98} x_{97}))	f	
167	c_{20} (c_{21} x_{97} (c_{25} x_{98})) (c_{22} x_{98} x_{97})	f	
168	c_{20} (c_{22} (c_{23} x_{99} x_{97}) (c_{23} x_{98} x_{97})) (c_{23} (c_{22} x_{99} x_{98}) x_{97})	f	
169	c_{20} (c_{23} x_{104} x_{97} x_{120}) (c_{23} (x_{104} x_{120}) x_{97})	f	
170	c_{20} (c_{21} (x_{104} x_{120}) (c_{23} (x_{104} x_{120}) (c_{22} c_{11} x_{97}))) (c_{23} (x_{104} x_{120}) x_{97})	f	
171	c_{20} (c_{23} x_{102} c_{11} x_{120}) (c_{23} (x_{102} x_{120}) c_{11})	f	
172	c_{20} (c_{22} (c_{22} x_{99} x_{98}) x_{97}) (c_{22} x_{99} (c_{22} x_{98} x_{97}))	f	
173	c_{20} (c_{22} (c_{21} x_{99} x_{98}) x_{97}) (c_{21} x_{99} (c_{22} x_{98} x_{97}))	f	
174	c_{20} (c_{21} (c_{21} x_{99} (c_{25} x_{98})) x_{97}) (c_{21} x_{99} (c_{22} x_{98} x_{97}))	f	
175	c_{20} (c_{21} (c_{25} (x_{102} x_{120})) (x_{102} x_{120})) (c_{31} x_{102} x_{120})	f	
176	c_{20} (c_{21} (c_{25} (x_{102} x_{120})) (x_{102} (c_{21} c_{11} x_{120}))) (c_{31} x_{102} x_{120})	f	
177	c_{20} (c_{24} (c_{23} x_{100} x_{98}) (c_{22} (c_{23} x_{99} x_{98}) (c_{23} x_{100} x_{97}))) (c_{22} (c_{24} x_{100} x_{99}) (c_{24} x_{98} x_{97}))	f	
178	c_{20} (c_{24} x_{98} (c_{25} x_{97})) (c_{25} (c_{24} x_{98} x_{97}))	f	
179	c_{20} (c_{21} (c_{22} x_{99} x_{97}) x_{98}) (c_{21} (c_{22} x_{99} x_{98}) x_{97})	f	
180	c_{20} (c_{23} x_{97} (c_{22} x_{99} x_{98})) (c_{22} (c_{23} x_{97} x_{99}) (c_{23} x_{97} x_{98}))	f	
181	c_{20} (c_{21} (c_{21} (c_{25} x_{98}) x_{98}) x_{97}) x_{97}	f	
182	c_{20} (c_{24} (c_{23} x_{100} x_{98}) (c_{22} (c_{23} x_{98} x_{99}) (c_{23} x_{100} x_{97}))) (c_{22} (c_{24} x_{100} x_{99}) (c_{24} x_{98} x_{97}))	f	
183	c_{20} (c_{21} (c_{22} x_{98} x_{99}) (c_{21} x_{100} x_{97})) (c_{21} (c_{21} x_{100} x_{99}) (c_{22} x_{98} x_{97}))	f	
184	c_{20} (c_{25} (c_{22} x_{97} x_{98})) (c_{22} x_{98} x_{97})	f	
185	c_{20} (c_{23} (c_{31} x_{102} x_{120}) x_{97}) (c_{31} (c_{23} x_{102} x_{97}) x_{120})	f	
186	c_{20} (c_{22} (c_{23} (c_{28} x_{120}) (c_{27} x_{121})) (c_{23} (c_{28} x_{121}) (c_{27} x_{120}))) (c_{27} (c_{22} x_{121} x_{120}))	f	
187	c_{20} (c_{21} (c_{21} x_{99} x_{98}) (c_{20} x_{100} x_{97})) (c_{21} (c_{21} x_{100} x_{99}) (c_{21} x_{98} x_{97}))	f	
188	c_{20} (c_{21} (c_{23} (c_{27} x_{121}) (c_{27} x_{120})) (c_{23} (c_{28} x_{121}) (c_{28} x_{120}))) (c_{28} (c_{22} x_{121} x_{120}))	f	
189	c_{20} (c_{21} (c_{21} x_{99} x_{98}) (c_{21} x_{100} x_{97})) (c_{21} (c_{21} x_{100} x_{99}) (c_{21} x_{98} x_{97}))	f	
190	c_{20} (c_{23} (c_{32} c_{12} (c_{28} x_{120})) c_{12}) (c_{21} (c_{28} (c_{23} x_{120} c_{12})) c_{11})	f	
191	c_{20} (c_{23} (c_{32} c_{12} (c_{27} x_{120})) c_{12}) (c_{22} (c_{28} (c_{23} x_{120} c_{12})) c_{11})	f	
192	c_{20} (c_{23} (c_{26} c_{12} (c_{28} x_{120})) c_{12}) (c_{21} (c_{28} (c_{23} x_{120} c_{12})) c_{11})	f	
193	c_{20} (c_{23} (c_{26} c_{12} (c_{27} x_{120})) c_{12}) (c_{22} (c_{28} (c_{23} x_{120} c_{12})) c_{11})	f	
194	c_{20} x_{98} (c_{23} (c_{24} x_{97} x_{98}) x_{97})	f	
195	c_{20} (c_{22} (c_{23} x_{99} x_{98}) (c_{23} x_{99} x_{97})) (c_{23} x_{99} (c_{22} x_{98} x_{97}))	f	
196	c_{20} (c_{23} (c_{23} x_{100} x_{98}) (c_{23} x_{99} x_{97})) (c_{23} (c_{23} x_{100} x_{99}) (c_{23} x_{98} x_{97}))	f	
197	c_{20} (c_{23} x_{97} (c_{22} x_{99} x_{98})) (c_{22} (c_{23} x_{99} x_{97}) (c_{23} x_{98} x_{97}))	f	
198	c_{20} (c_{23} (c_{23} x_{99} x_{97}) x_{98}) (c_{23} (c_{23} x_{99} x_{98}) x_{97})	f	
199	c_{20} (c_{25} x_{98}) (c_{23} (c_{24} x_{97} x_{98}) (c_{25} x_{97}))	f	
200	c_{20} x_{97} (c_{21} x_{97} (c_{23} x_{97} (c_{25} c_{12})))	f	
201	c_{20} (c_{25} x_{97}) (c_{21} x_{97} (c_{23} x_{97} (c_{25} c_{12})))	f	
202	c_{20} x_{98} (c_{22} x_{97} (c_{21} x_{98} x_{97}))	f	
203	c_{20} x_{98} (c_{22} (c_{22} x_{98} x_{97}) x_{97})	f	
204	c_{20} (c_{25} c_{11}) (c_{22} c_{12} c_{11})	f	
208	c_{20} (c_{23} (c_{22} x_{99} x_{98}) x_{97}) (c_{22} (c_{23} x_{99} x_{97}) (c_{23} x_{98} x_{97}))	f	
209	c_{20} (c_{21} x_{97} x_{97}) (c_{23} x_{97} c_{12})	f	
213	c_{20} c_{10} (c_{22} c_{11} c_{11})	f	
218	c_{20} (c_{23} x_{120} (c_{23} x_{102} x_{97})) (c_{23} (x_{102} x_{120}) x_{97})	f	
219	c_{20} (c_{23} x_{102} x_{97} x_{120}) (c_{23} (x_{102} x_{120}) x_{97})	f	
226	c_{20} (c_{23} (x_{102} x_{120}) x_{97}) (c_{23} x_{102} x_{97} x_{120})	f	
72	c_{20} (c_{22} (x_{103} x_{120}) (x_{102} x_{120})) (c_{22} x_{103} x_{102} x_{120})	f	
236	c_{20} (c_{22} (c_{22} x_{100} x_{98}) (c_{22} x_{99} x_{97})) (c_{22} (c_{22} x_{100} x_{99}) (c_{22} x_{98} x_{97}))	f	
238	c_{20} (c_{24} x_{99} (c_{22} x_{98} x_{97})) (c_{22} (c_{24} x_{99} x_{98}) (c_{24} x_{99} x_{97}))	f	
242	c_{20} (c_{23} (x_{102} x_{120}) c_{18}) (c_{23} x_{102} c_{18} x_{120})	f	
243	c_{20} (c_{23} (x_{102} x_{120}) c_{19}) (c_{23} x_{102} c_{19} x_{120})	f	
244	c_{20} (c_{22} (c_{26} c_{12} (c_{28} x_{97})) c_{11}) (c_{26} c_{12} (c_{27} x_{97}))	f	
245	c_{20} (c_{23} x_{97} c_{13}) (c_{21} x_{97} (c_{23} x_{97} c_{12}))	f	
247	c_{20} (c_{23} x_{97} c_{14}) (c_{21} x_{97} (c_{23} x_{97} c_{13}))	f	
249	c_{20} (c_{23} x_{97} c_{16}) (c_{21} x_{97} (c_{23} x_{97} c_{15}))	f	
250	c_{20} (c_{23} x_{97} c_{17}) (c_{21} x_{97} (c_{23} x_{97} c_{16}))	f	
251	c_{20} (c_{23} x_{97} c_{18}) (c_{21} x_{97} (c_{23} x_{97} c_{17}))	f	
252	c_{20} (c_{23} x_{97} c_{19}) (c_{21} x_{97} (c_{23} x_{97} c_{18}))	f	
255	c_{20} (c_{21} (c_{22} x_{98} x_{99}) x_{97}) (c_{21} x_{99} (c_{22} x_{98} x_{97}))	f	
256	c_{20} x_{97} (c_{23} (c_{24} x_{97} x_{98}) x_{97})	f	
263	c_{20} (c_{31} x_{102} x_{120}) (c_{31} (c_{23} x_{102} c_{11}) x_{120})	f	
266	c_{20} (c_{23} (x_{102} x_{120}) c_{11}) (c_{23} x_{102} c_{11} x_{120})	f	
267	c_{20} (c_{21} x_{98} (c_{22} x_{99} x_{97})) (c_{22} x_{99} (c_{21} x_{98} x_{97}))	f	
268	c_{20} (c_{16} (x_{102} x_{120})) (c_{23} x_{102} c_{16} x_{120})	f	
273	c_{20} x_{97} (c_{32} c_{11} x_{97})	f	
274	c_{20} (c_{23} (c_{23} (c_{27} (c_{24} c_{12} (c_{22} x_{98} x_{97}))) (c_{28} (c_{24} c_{12} (c_{21} x_{98} x_{97})))) c_{12}) (c_{22} (c_{27} x_{98}) (c_{27} x_{97}))	f	
277	c_{20} (c_{22} (c_{32} c_{12} (c_{27} x_{116})) c_{11}) (c_{32} c_{12} (c_{28} x_{116}))	f	
278	c_{20} (c_{21} (c_{22} x_{100} x_{98}) (c_{22} x_{99} x_{97})) (c_{22} (c_{21} x_{100} x_{99}) (c_{21} x_{98} x_{97}))	f	
280	c_{20} (c_{24} (c_{23} (c_{28} (c_{21} c_{11} x_{120})) (c_{28} x_{120})) (c_{27} c_{11})) (c_{31} (c_{24} (c_{28} x_{120}) (c_{27} x_{120})) x_{120})	f	
283	c_{20} x_{97} (c_{23} (c_{25} x_{97}) (c_{25} c_{11}))	f	
284	c_{20} c_{10} (c_{21} (c_{23} x_{97} (c_{25} c_{11})) x_{97})	f	
289	c_{20} c_{18} (c_{26} c_{13} c_{12})	f	
290	c_{20} c_{14} (c_{26} c_{12} c_{12})	f	
291	c_{20} c_{11} (c_{31} (c_{32} c_{11} (c_{22} x_{97} x_{120})) x_{120})	f	
293	c_{20} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))) (c_{31} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))) x_{120})	f	
294	c_{20} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{31} (c_{25} (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{28} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))))) x_{120})	f	
296	c_{20} (c_{21} (c_{22} (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{23} (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11}))) (c_{25} (c_{23} (c_{24} c_{12} (c_{21} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{26} x_{120} c_{12})))) (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12})))	f	
297	c_{20} (c_{22} (c_{23} (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{22} (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{23} (c_{24} c_{12} (c_{22} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{26} x_{120} c_{12})))) (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12})))	f	
301	c_{20} (c_{21} (c_{23} (c_{26} c_{12} (c_{28} x_{120})) (c_{27} c_{11})) (c_{23} (c_{23} (c_{28} x_{120}) (c_{27} x_{120})) (c_{28} c_{11}))) (c_{23} (c_{28} x_{120}) (c_{27} (c_{21} c_{11} x_{120})))	f	
303	c_{20} (c_{22} (c_{23} (c_{26} c_{12} (c_{27} x_{120})) (c_{27} c_{11})) (c_{23} (c_{23} (c_{28} x_{120}) (c_{27} x_{120})) (c_{28} c_{11}))) (c_{23} (c_{28} (c_{21} c_{11} x_{120})) (c_{27} x_{120}))	f	
304	c_{20} (c_{22} (c_{21} x_{99} x_{98}) x_{97}) (c_{22} x_{99} (c_{22} x_{98} x_{97}))	f	
309	c_{20} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{31} (c_{25} (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{28} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{88}) (c_{24} c_{12} c_{34}))))) x_{120})	f	
312	c_{20} (c_{21} (c_{21} x_{98} x_{99}) (c_{22} x_{100} x_{97})) (c_{21} (c_{22} x_{100} x_{99}) (c_{21} x_{98} x_{97}))	f	
317	c_{20} (c_{24} c_{12} (c_{23} (c_{24} c_{12} c_{11}) c_{12})) (c_{27} (c_{24} c_{14} c_{34}))	f	
321	c_{20} (c_{27} (c_{24} c_{14} c_{34})) (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12}))	f	
322	c_{20} (c_{33} (c_{23} x_{102} (c_{24} c_{12} c_{11}))) (c_{23} (c_{33} x_{102}) (c_{24} c_{12} c_{11}))	f	
323	c_{20} x_{101} (c_{31} (c_{33} x_{101}) x_{101})	f	
324	c_{20} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{11})) (c_{28} (c_{24} c_{14} c_{34}))	f	
325	c_{20} (c_{24} (c_{23} (c_{28} (c_{21} c_{11} x_{120})) (c_{27} x_{120})) (c_{27} c_{11})) (c_{31} (c_{24} (c_{28} x_{120}) (c_{27} x_{120})) x_{120})	f	
327	c_{20} (c_{22} x_{99} x_{97}) (c_{22} (c_{22} x_{98} x_{99}) (c_{22} x_{98} x_{97}))	f	
328	c_{20} (c_{24} (c_{23} (c_{21} c_{11} x_{120}) (c_{28} x_{120})) (c_{27} c_{11})) (c_{31} (c_{24} (c_{28} x_{120}) (c_{27} x_{120})) x_{120})	f	
329	c_{20} x_{120} (c_{31} (c_{33} x_{120}) x_{120})	f	
330	c_{20} (c_{22} (c_{21} x_{98} x_{98}) x_{97}) (c_{22} x_{98} (c_{22} x_{98} x_{97}))	f	
386	c_{20} c_{10} (c_{33} c_{10})	f	
207	c_{20} (c_{23} (c_{31} x_{102} x_{120}) c_{11}) (c_{31} (c_{23} x_{102} c_{11}) x_{120})	f	
210	c_{20} (c_{26} c_{11} x_{97}) x_{97}	f	
215	c_{20} (c_{24} (c_{25} x_{98}) x_{97}) (c_{25} (c_{24} x_{98} x_{97}))	f	
220	c_{20} (c_{26} c_{12} (c_{27} x_{120})) (c_{22} (c_{26} c_{12} (c_{28} x_{120})) c_{11})	f	
221	c_{20} (c_{26} c_{12} (c_{28} x_{120})) (c_{22} (c_{26} c_{12} (c_{27} x_{120})) c_{11})	f	
222	c_{20} (c_{22} x_{99} (c_{22} x_{98} x_{97})) (c_{22} (c_{21} x_{99} x_{98}) x_{97})	f	
224	c_{20} (c_{22} x_{97} x_{98}) (c_{22} x_{98} x_{97})	f	
225	c_{20} (c_{23} (c_{32} c_{11} x_{120}) (c_{32} c_{12} x_{120})) (c_{32} c_{13} x_{120})	f	
230	c_{20} (x_{102} (c_{21} c_{11} x_{120})) (c_{21} (x_{102} x_{120}) (c_{31} x_{102} x_{120}))	f	
231	c_{20} (c_{22} (c_{31} x_{102} x_{120}) (x_{102} (c_{21} c_{11} x_{120}))) (x_{102} x_{120})	f	
237	c_{20} (c_{25} (c_{24} x_{98} x_{97})) (c_{24} x_{98} (c_{25} x_{97}))	f	
239	c_{20} (c_{31} (c_{23} x_{102} x_{97}) x_{120}) (c_{23} (c_{31} x_{102} x_{120}) x_{97})	f	
246	c_{20} (c_{21} x_{99} (c_{22} x_{98} x_{97})) (c_{22} (c_{22} x_{99} x_{98}) x_{97})	f	
248	c_{20} (c_{23} x_{97} c_{15}) (c_{21} x_{97} (c_{23} x_{97} c_{14}))	f	
253	c_{20} (c_{21} (c_{22} x_{99} x_{98}) x_{97}) (c_{21} (c_{25} x_{99}) (c_{21} x_{98} x_{97}))	f	
254	c_{20} (c_{22} (c_{23} x_{98} x_{97}) (c_{23} x_{99} x_{97})) (c_{23} x_{99} (c_{22} x_{98} x_{97}))	f	
257	c_{20} (c_{20} (c_{23} x_{99} x_{97}) (c_{23} x_{98} x_{97})) (c_{23} (c_{22} x_{99} x_{98}) x_{97})	f	
258	c_{20} (c_{23} (c_{25} (c_{23} x_{99} x_{97})) (c_{23} x_{98} x_{97})) (c_{23} (c_{22} x_{99} x_{98}) x_{97})	f	
259	c_{20} x_{97} (c_{22} x_{97} (c_{23} x_{97} c_{12}))	f	
260	c_{20} (c_{21} x_{98} (c_{21} x_{99} x_{97})) (c_{21} x_{99} (c_{21} x_{98} x_{97}))	f	
261	c_{20} (c_{23} x_{98} (c_{23} x_{99} x_{97})) (c_{23} (c_{23} x_{99} x_{98}) x_{97})	f	
264	c_{20} (c_{25} (c_{22} x_{98} (c_{25} x_{97}))) (c_{21} x_{98} x_{97})	f	
265	c_{20} (c_{22} x_{98} x_{97}) (c_{25} (c_{21} x_{98} (c_{25} x_{97})))	f	
270	c_{20} (c_{22} x_{98} x_{99}) (c_{22} (c_{22} x_{99} x_{97}) (c_{22} x_{98} x_{97}))	f	
275	c_{20} (x_{97} c_{11}) x_{97}	f	
281	c_{20} (c_{21} (c_{23} (c_{27} x_{98}) (c_{27} x_{97})) (c_{23} (c_{28} x_{98}) (c_{28} x_{97}))) (c_{28} (c_{22} x_{98} x_{97}))	f	
282	c_{20} c_{11} (c_{31} (c_{32} c_{11} (c_{22} c_{11} x_{120})) x_{120})	f	
287	c_{20} (c_{22} (c_{23} x_{98} c_{12}) x_{97}) (c_{22} x_{98} (c_{22} x_{98} x_{97}))	f	
288	c_{20} (c_{21} (c_{23} x_{98} c_{12}) x_{97}) (c_{21} x_{98} (c_{21} x_{98} x_{97}))	f	
292	c_{20} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{26} c_{12} (c_{22} c_{11} x_{120}))))) (c_{33} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))	f	
295	c_{20} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{31} (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{27} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34})))) x_{120})	f	
298	c_{31} (c_{25} (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{28} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))))) x_{120}	f	
299	c_{20} (c_{21} (c_{23} (c_{26} c_{12} (c_{28} x_{120})) (c_{27} c_{11})) (c_{23} (c_{23} (c_{28} x_{120}) (c_{27} x_{120})) (c_{28} c_{11}))) (c_{23} (c_{28} x_{120}) (c_{31} (c_{27} x_{120}) x_{120}))	f	
300	c_{20} (c_{23} (c_{31} (c_{28} x_{120}) x_{120}) (c_{27} x_{120})) (c_{21} (c_{23} (c_{23} (c_{28} x_{120}) (c_{27} x_{120})) (c_{27} c_{11})) (c_{25} (c_{23} (c_{26} c_{12} (c_{27} x_{120})) (c_{27} c_{11}))))	f	
302	c_{20} (c_{22} (c_{23} (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{22} (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{23} (c_{24} c_{12} (c_{21} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{26} x_{120} c_{12})))) (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12})))	f	
305	c_{20} (c_{23} (c_{26} c_{12} x_{98}) x_{97}) (c_{23} x_{98} (c_{23} x_{98} x_{97}))	f	
307	c_{20} (c_{22} (c_{23} (c_{27} x_{98}) (c_{28} x_{97})) (c_{23} (c_{28} x_{98}) (c_{27} x_{97}))) (c_{27} (c_{22} x_{98} x_{97}))	f	
311	c_{20} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))) (c_{33} (c_{23} (c_{32} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))	f	
313	c_{20} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12})) (c_{28} (c_{24} c_{14} c_{34}))	f	
319	c_{20} (c_{24} c_{12} (c_{23} (c_{24} c_{12} c_{11}) c_{12})) (c_{27} (c_{24} c_{12} c_{34}))	f	
326	c_{20} (c_{22} x_{99} x_{98}) (c_{22} (c_{22} x_{97} x_{99}) (c_{22} x_{97} x_{98}))	f	
332	c_{20} (c_{26} (c_{21} c_{11} (c_{21} x_{110} x_{120})) c_{12}) (c_{23} c_{12} (c_{26} (c_{21} x_{110} x_{120}) c_{12}))	f	
337	c_{20} (c_{22} (c_{23} (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{22} (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{23} (c_{24} c_{12} (c_{22} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{26} x_{120} c_{12})))) (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12})))	f	
338	c_{20} (c_{22} x_{98} (c_{22} x_{99} x_{97})) (c_{22} (c_{21} x_{99} x_{98}) x_{97})	f	
339	c_{20} x_{102} (c_{31} (c_{33} x_{102}) x_{120})	f	
341	c_{20} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{31} (c_{25} (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{27} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))))) x_{120})	f	
342	c_{20} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{11}))) (c_{31} (c_{25} (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{28} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))))) x_{120})	f	
345	c_{20} x_{97} (c_{26} c_{12} x_{97})	f	
628	c_{20} c_{10} c_{11}	f	
206	c_{20} (c_{22} (c_{21} x_{99} x_{98}) x_{97}) (c_{21} x_{98} (c_{22} x_{98} x_{97}))	f	
211	c_{20} x_{97} (c_{24} c_{11} x_{97})	f	
212	c_{20} (c_{23} (c_{24} x_{99} x_{98}) x_{97}) (c_{24} x_{99} (c_{23} x_{98} x_{97}))	f	
214	c_{20} (c_{21} x_{98} x_{97}) (c_{22} (c_{25} x_{98}) x_{97})	f	
216	c_{20} (c_{22} (c_{23} x_{97} x_{99}) (c_{23} x_{97} x_{98})) (c_{23} x_{97} (c_{22} x_{99} x_{98}))	f	
217	c_{20} (c_{25} (c_{21} x_{98} x_{97})) (c_{22} x_{98} (c_{25} x_{97}))	f	
223	c_{20} (c_{22} x_{97} x_{98}) (c_{25} (c_{21} x_{97} (c_{25} x_{98})))	f	
227	c_{20} (c_{25} (c_{22} x_{98} x_{97})) (c_{21} x_{98} (c_{25} x_{97}))	f	
228	c_{20} (c_{22} (c_{28} (c_{23} x_{116} c_{12})) c_{11}) (c_{23} (c_{26} c_{12} (c_{27} x_{116})) c_{12})	f	
229	c_{20} (c_{22} x_{100} (c_{21} x_{99} (c_{22} x_{98} x_{97}))) (c_{21} (c_{22} x_{100} x_{99}) (c_{22} x_{98} x_{97}))	f	
232	c_{20} (c_{23} (c_{22} c_{11} x_{97}) (c_{26} x_{120} x_{97})) (c_{31} (c_{26} x_{120} x_{97}) x_{120})	f	
233	c_{20} (c_{22} c_{11} (c_{21} c_{11} x_{97})) x_{97}	f	
234	c_{20} x_{98} (c_{21} (c_{21} x_{98} (c_{25} x_{97})) x_{97})	f	
235	c_{20} x_{98} (c_{21} (c_{21} x_{98} x_{97}) (c_{25} x_{97}))	f	
240	c_{20} (c_{23} (x_{102} x_{120}) c_{16}) (c_{23} x_{102} c_{16} x_{120})	f	
241	c_{20} (c_{23} (x_{102} x_{120}) c_{17}) (c_{23} x_{102} c_{17} x_{120})	f	
269	c_{20} x_{98} (c_{23} x_{97} (c_{24} x_{97} x_{98}))	f	
271	c_{20} (c_{23} x_{97} (c_{26} x_{110} x_{97})) (c_{26} (c_{21} c_{11} x_{110}) x_{97})	f	
272	c_{20} (c_{23} (c_{26} c_{11} x_{97}) (c_{26} x_{110} x_{97})) (c_{26} (c_{21} c_{11} x_{110}) x_{97})	f	
276	c_{20} (c_{32} c_{11} x_{97}) x_{97}	f	
285	c_{20} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))) (c_{33} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))	f	
286	c_{20} (c_{23} (c_{32} c_{11} (c_{22} c_{11} x_{120})) c_{12}) (c_{31} (c_{32} c_{12} (c_{22} c_{11} x_{120})) x_{120})	f	
306	c_{20} c_{10} (c_{22} c_{10} x_{97})	f	
308	c_{20} c_{14} (c_{23} c_{12} c_{12})	f	
310	c_{20} (c_{31} (c_{32} c_{12} (c_{22} c_{11} x_{120})) x_{120}) (c_{23} (c_{32} c_{11} (c_{22} c_{11} x_{120})) c_{12})	f	
314	c_{20} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12})) (c_{27} (c_{24} c_{14} c_{34}))	f	
315	c_{20} (c_{23} (c_{33} x_{102}) (c_{24} c_{12} c_{11})) (c_{33} (c_{23} x_{102} (c_{24} c_{12} c_{11})))	f	
316	c_{20} (c_{24} c_{12} (c_{23} (c_{24} c_{12} c_{11}) c_{12})) (c_{28} (c_{24} c_{14} c_{34}))	f	
318	c_{20} (c_{23} (c_{31} x_{102} x_{120}) (c_{24} c_{12} c_{11})) (c_{31} (c_{23} x_{102} (c_{24} c_{12} c_{11})) x_{120})	f	
320	c_{20} (c_{28} (c_{24} c_{14} c_{34})) (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12}))	f	
331	c_{20} (c_{22} (c_{23} (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{22} (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{24} c_{12} (c_{23} (c_{22} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{26} x_{120} c_{12}))))) (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12})))	f	
333	c_{20} (c_{21} c_{10} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120})))) (c_{21} c_{10} (c_{31} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))) x_{120}))	f	
334	c_{20} x_{120} (c_{31} (c_{33} (x_{102} x_{120})) x_{120})	f	
335	c_{20} (c_{21} (c_{32} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))) (c_{33} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))	f	
336	c_{20} (c_{21} (c_{22} (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{23} (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11}))) (c_{25} (c_{23} (c_{24} c_{12} (c_{21} (c_{27} (c_{24} c_{12} c_{34})) (c_{28} (c_{24} c_{12} c_{34})))) (c_{26} x_{120} c_{12})))) (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12})))	f	
340	c_{20} (c_{21} x_{99} x_{97}) (c_{22} (c_{22} x_{99} x_{98}) (c_{21} x_{98} x_{97}))	f	
343	c_{20} (c_{24} (c_{23} (c_{28} (c_{21} c_{11} x_{120})) (c_{28} x_{120})) (c_{27} c_{11})) (c_{21} c_{10} (c_{31} (c_{24} (c_{28} x_{120}) (c_{27} x_{120})) x_{120}))	f	
344	c_{20} (c_{22} (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{21} (c_{23} (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{25} (c_{23} (c_{24} c_{12} (c_{21} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{26} x_{120} c_{12}))))) (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12})))	f	
346	c_{20} (c_{23} (c_{22} c_{11} x_{120}) c_{12}) (c_{31} (c_{32} c_{12} (c_{22} c_{11} x_{120})) x_{120})	f	
347	c_{20} (c_{21} (c_{22} x_{99} x_{98}) (c_{21} x_{100} x_{97})) (c_{22} (c_{22} x_{100} x_{99}) (c_{21} x_{98} x_{97}))	f	
348	c_{20} (c_{22} (c_{33} (x_{103} x_{120})) (c_{33} (x_{102} x_{120}))) (c_{33} (c_{22} (x_{103} x_{120}) (x_{102} x_{120})))	f	
349	c_{20} (c_{23} (c_{23} (c_{26} x_{120} c_{12}) c_{12}) c_{12}) (c_{26} (c_{21} c_{12} x_{120}) c_{12})	f	
350	c_{20} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{31} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) x_{120})	f	
351	c_{20} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{31} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) x_{120})	f	
352	c_{20} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{23} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))) (c_{33} (c_{23} (c_{26} x_{120} c_{12}) (c_{26} c_{12} (c_{22} c_{11} x_{120}))))	f	
353	c_{20} (c_{26} x_{120} c_{12}) (c_{31} (c_{26} (c_{21} x_{97} x_{120}) c_{12}) x_{120})	f	
356	c_{20} (c_{22} x_{99} x_{98}) (c_{22} (c_{21} x_{97} x_{99}) (c_{21} x_{98} x_{97}))	f	
364	c_{20} x_{120} (c_{22} (c_{23} x_{120} c_{11}) (c_{23} x_{120} c_{12}))	f	
354	c_{20} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{31} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))) x_{120})	f	
355	c_{20} (c_{26} (c_{24} c_{12} c_{11}) c_{12}) (c_{23} (c_{27} (c_{24} c_{15} c_{34})) c_{12})	f	
369	c_{20} c_{11} (c_{31} (c_{26} c_{11} (c_{22} c_{11} x_{120})) x_{120})	f	
371	c_{20} (c_{23} (c_{28} (c_{24} c_{14} c_{34})) (c_{21} (c_{25} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{25} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))))) (c_{23} (c_{27} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))) (c_{25} c_{11}))	f	
382	c_{20} (c_{23} (c_{32} c_{11} (c_{22} c_{11} x_{120})) c_{12}) (c_{31} (c_{26} c_{12} (c_{22} c_{11} x_{120})) x_{120})	f	
383	c_{20} (c_{24} c_{12} c_{11}) (c_{23} (c_{28} (c_{24} c_{12} c_{11})) (c_{27} (c_{24} c_{12} c_{11})))	f	
472	c_{20} (c_{23} (c_{23} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12})) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) c_{12}) (c_{22} (c_{27} (c_{22} (c_{24} c_{14} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{27} (c_{22} (c_{24} c_{14} c_{34}) (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34})))))	f	
473	c_{20} (c_{23} x_{98} c_{12}) (c_{22} (c_{22} x_{98} x_{97}) (c_{21} x_{98} x_{97}))	f	
488	c_{20} (c_{23} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12})) (c_{21} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{28} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34})))	f	
489	c_{20} (c_{23} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12})) (c_{21} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{27} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34})))	f	
493	c_{20} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34})))	f	
515	c_{20} (c_{22} x_{97} x_{98}) (c_{21} x_{98} (c_{25} x_{97}))	f	
516	c_{20} (c_{23} (c_{23} x_{99} x_{97}) x_{98}) (c_{23} x_{99} (c_{23} x_{98} x_{97}))	f	
557	c_{20} (c_{21} (c_{31} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) x_{120}) (c_{22} (c_{31} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) x_{120}) (c_{31} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))) x_{120}))) (c_{31} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))) x_{120})	f	
570	c_{20} (c_{23} x_{97} c_{12}) (c_{21} (c_{21} x_{98} (c_{25} x_{97})) (c_{21} x_{98} x_{97}))	f	
573	c_{20} (c_{26} (c_{21} c_{14} x_{120}) c_{12}) (c_{26} (c_{21} c_{13} (c_{21} c_{11} x_{120})) c_{12})	f	
581	c_{20} (c_{22} x_{120} c_{12}) (c_{22} (c_{21} c_{11} x_{120}) c_{13})	f	
593	c_{20} (c_{21} (c_{25} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{21} (c_{23} (c_{28} (c_{25} (c_{23} (c_{24} c_{12} c_{11}) (c_{24} c_{12} c_{34})))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{23} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12})) (c_{25} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))))	f	
594	c_{20} (c_{21} (c_{23} (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) x_{97})) (c_{24} c_{12} c_{11})) (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) x_{97})) (c_{24} c_{12} c_{11}))) (c_{33} (c_{23} x_{97} (c_{24} c_{12} (c_{21} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))))))	f	
595	c_{20} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))) (c_{21} c_{10} (c_{33} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120})))))	f	
598	c_{20} (c_{24} c_{14} c_{34}) (c_{24} c_{12} (c_{24} c_{12} c_{34}))	f	
604	c_{20} (c_{22} (c_{22} (c_{33} (c_{23} c_{16} (c_{26} x_{120} c_{12}))) (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120})))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120})))) (c_{22} (c_{33} (c_{23} (c_{31} (c_{26} x_{120} c_{12}) x_{120}) (c_{23} (c_{32} c_{11} (c_{22} c_{11} x_{120})) c_{14}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))	f	
609	c_{20} (c_{23} c_{16} (c_{26} x_{120} c_{12})) (c_{23} c_{14} (c_{26} (c_{21} c_{11} x_{120}) c_{12}))	f	
614	c_{20} (c_{21} x_{98} (c_{21} x_{99} x_{97})) (c_{21} (c_{21} x_{99} x_{98}) x_{97})	f	
615	c_{20} (c_{22} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120})))) (c_{22} (c_{21} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} (c_{21} c_{12} (c_{21} c_{11} x_{120})) c_{12}) c_{11})) (c_{21} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} (c_{21} c_{11} x_{120}) c_{12}) (c_{23} (c_{32} c_{11} (c_{22} c_{11} x_{120})) c_{12}))))	f	
626	c_{20} x_{97} (c_{23} (c_{24} c_{12} c_{11}) (c_{23} x_{97} c_{12}))	f	
629	c_{20} (c_{21} (c_{22} (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{23} (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11}))) (c_{25} (c_{23} (c_{24} c_{12} (c_{21} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{26} x_{120} c_{12})))) (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12})))	f	
630	c_{20} (c_{22} (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{13} c_{12})) (c_{24} c_{13} (c_{22} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12})) (c_{25} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} (c_{21} c_{11} x_{120}) c_{12})))))) (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12})))	f	
631	c_{20} (c_{24} c_{13} (c_{22} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12})) (c_{25} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} (c_{21} c_{11} x_{120}) c_{12}))))) (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{13} c_{15}))	f	
632	c_{20} (c_{24} c_{15} (c_{22} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12})) (c_{25} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} (c_{21} c_{11} x_{120}) c_{12}))))) (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12})))	f	
357	c_{20} (c_{26} (c_{21} x_{97} x_{120}) c_{12}) (c_{31} (c_{26} (c_{21} x_{97} x_{120}) c_{12}) x_{120})	f	
474	c_{20} (c_{21} c_{10} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120})))) (c_{31} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))) x_{120})	f	
475	c_{20} (c_{26} c_{11} c_{12}) c_{12}	f	
476	c_{20} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{23} (c_{26} (c_{21} c_{11} x_{120}) c_{12}) c_{12})	f	
490	c_{20} (c_{23} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12})) (c_{21} (c_{25} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{28} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34})))	f	
501	c_{20} (c_{22} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120})))) (c_{31} (c_{22} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120})))) x_{120})	f	
504	c_{20} x_{97} (c_{21} (c_{21} (c_{21} x_{97} (c_{25} x_{98})) x_{99}) (c_{21} (c_{25} x_{99}) (c_{21} x_{98} x_{97})))	f	
507	c_{20} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))) (c_{21} c_{10} (c_{31} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))) x_{120}))	f	
511	c_{20} (c_{24} x_{99} x_{97}) (c_{24} (c_{23} x_{98} x_{99}) (c_{23} x_{98} x_{97}))	f	
513	c_{20} (c_{23} (c_{22} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12}))) (c_{27} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34})))	f	
522	c_{20} (c_{22} x_{99} x_{98}) (c_{22} (c_{21} x_{99} x_{97}) (c_{21} x_{98} x_{97}))	f	
523	c_{20} (c_{21} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{22} (c_{28} (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34}))))	f	
558	c_{20} (c_{23} (c_{26} (c_{24} c_{12} c_{11}) c_{12}) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{23} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) c_{12})	f	
560	c_{20} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))) (c_{21} (c_{23} (c_{26} x_{120} c_{12}) c_{18}) (c_{21} (c_{25} (c_{23} (c_{21} (c_{23} (c_{26} x_{120} c_{12}) (c_{22} c_{11} x_{120})) (c_{26} (c_{21} c_{11} x_{120}) c_{12})) c_{14})) (c_{21} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} (c_{21} c_{11} x_{120}) c_{12}) (c_{23} (c_{32} c_{11} (c_{22} c_{11} x_{120})) c_{12})))))	f	
564	c_{20} (c_{23} (c_{33} x_{102}) x_{97}) (c_{33} (c_{23} x_{102} x_{97}))	f	
572	c_{20} (c_{23} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) c_{12}) (c_{23} (c_{26} (c_{24} c_{12} c_{11}) c_{12}) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))	f	
575	c_{20} (c_{23} (c_{22} c_{12} x_{120}) (c_{22} c_{11} x_{120})) (c_{21} (c_{21} c_{12} (c_{25} (c_{23} x_{120} c_{13}))) (c_{26} c_{12} x_{120}))	f	
576	c_{20} (c_{22} (c_{23} (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{22} (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{23} (c_{24} c_{12} (c_{22} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{26} x_{120} c_{12})))) (c_{33} (c_{23} (c_{28} (c_{23} (c_{23} c_{11} x_{120}) (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12})))	f	
578	c_{20} (c_{24} c_{12} (c_{22} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{27} (c_{22} (c_{24} c_{14} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34})))))	f	
579	c_{20} x_{120} (c_{22} c_{11} (c_{21} c_{11} x_{120}))	f	
582	c_{20} (c_{23} x_{97} c_{12}) (c_{22} (c_{23} x_{97} c_{12}) (c_{23} x_{97} c_{14}))	f	
596	c_{20} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) c_{12}) (c_{31} (c_{22} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) x_{120})	f	
597	c_{20} (c_{24} c_{14} c_{34}) (c_{22} (c_{24} c_{14} c_{34}) (c_{24} c_{12} c_{34}))	f	
600	c_{20} c_{11} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}))	f	
605	c_{20} (c_{23} (c_{21} (c_{21} c_{12} (c_{25} (c_{23} x_{120} c_{13}))) (c_{26} c_{12} x_{120})) (c_{26} x_{120} c_{12})) (c_{21} (c_{23} (c_{26} c_{13} c_{12}) (c_{26} x_{120} c_{12})) (c_{23} (c_{21} (c_{21} (c_{25} c_{14}) (c_{21} (c_{25} c_{12}) (c_{23} x_{120} (c_{25} (c_{21} c_{14} (c_{25} c_{11})))))) (c_{26} c_{12} x_{120})) (c_{26} x_{120} c_{12})))	f	
616	c_{20} (c_{23} c_{18} (c_{26} x_{120} c_{12})) (c_{23} c_{14} (c_{26} (c_{21} c_{11} x_{120}) c_{12}))	f	
622	c_{20} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))) (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{21} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} (c_{21} c_{12} (c_{21} c_{11} x_{120})) c_{12}) c_{11})) (c_{21} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} (c_{21} c_{11} x_{120}) c_{12}) (c_{23} (c_{32} c_{11} (c_{22} c_{11} x_{120})) c_{12})))))	f	
633	c_{20} (c_{21} (c_{22} x_{99} (c_{25} x_{98})) x_{97}) (c_{22} x_{99} (c_{22} x_{98} x_{97}))	f	
262	c_{20} (c_{21} (c_{22} x_{99} x_{98}) x_{97}) (c_{22} x_{99} (c_{21} x_{98} x_{97}))	f	
205	c_{20} (c_{21} (c_{21} x_{99} (c_{25} x_{98})) x_{97}) (c_{21} x_{99} (c_{22} x_{98} x_{97}))	f	
358	c_{20} (c_{22} (c_{23} (c_{28} x_{98}) (c_{27} x_{97})) (c_{23} (c_{27} x_{98}) (c_{28} x_{97}))) (c_{27} (c_{22} x_{98} x_{97}))	f	
365	c_{20} (c_{23} (c_{21} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12}))) (c_{28} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34})))	f	
366	c_{20} (c_{28} (c_{24} c_{14} c_{34})) (c_{27} (c_{24} c_{14} c_{34}))	f	
367	c_{20} (c_{23} (c_{22} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12}))) (c_{28} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34})))	f	
370	c_{20} (c_{23} (c_{26} c_{11} (c_{22} c_{11} x_{120})) c_{12}) (c_{31} (c_{26} c_{12} (c_{22} c_{11} x_{120})) x_{120})	f	
375	c_{20} (c_{23} (c_{28} (c_{24} c_{14} c_{34})) (c_{21} (c_{25} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{28} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34})))	f	
381	c_{20} (c_{24} c_{12} (c_{27} (c_{23} x_{120} c_{12}))) (c_{23} (c_{28} x_{120}) (c_{27} x_{120}))	f	
385	c_{20} (c_{22} (c_{33} x_{103}) (c_{33} x_{102})) (c_{33} (c_{22} x_{103} x_{102}))	f	
477	c_{20} (c_{21} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{22} c_{11} x_{120})) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120})))) (c_{31} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))) x_{120})	f	
491	c_{20} (c_{21} (c_{25} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{31} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) x_{120})	f	
492	c_{20} (c_{25} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{28} (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34})))	f	
498	c_{20} (c_{25} (c_{21} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{31} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) x_{120})	f	
499	c_{20} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{23} (c_{22} c_{11} x_{120}) (c_{26} (c_{21} c_{12} x_{120}) c_{12}))) (c_{31} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) x_{120})	f	
500	c_{20} (c_{25} c_{12}) (c_{21} (c_{25} c_{11}) (c_{25} c_{11}))	f	
509	c_{20} (c_{23} c_{12} x_{97}) (c_{22} (c_{21} x_{98} (c_{25} x_{97})) (c_{21} x_{98} x_{97}))	f	
514	c_{20} (c_{24} c_{12} (c_{22} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{27} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))))	f	
520	c_{20} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{26} (c_{21} c_{14} x_{120}) c_{12}))	f	
559	c_{20} c_{11} (c_{31} (c_{22} c_{11} x_{120}) x_{120})	f	
587	c_{20} (c_{33} (c_{23} (c_{31} (c_{26} x_{120} c_{12}) x_{120}) (c_{23} (c_{32} c_{11} (c_{22} c_{11} x_{120})) c_{14}))) (c_{33} (c_{23} (c_{23} (c_{32} c_{11} (c_{22} c_{11} x_{120})) c_{12}) (c_{26} (c_{21} c_{11} x_{120}) c_{12})))	f	
599	c_{20} (c_{23} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12})) (c_{21} (c_{25} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{21} (c_{23} (c_{28} (c_{25} (c_{23} (c_{24} c_{12} c_{11}) (c_{24} c_{12} c_{34})))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{23} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12})) (c_{25} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))))	f	
607	c_{20} (c_{23} c_{11} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120})))) (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{31} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) x_{120}) (c_{31} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))) x_{120})))	f	
612	c_{20} (c_{21} (c_{22} x_{99} (c_{25} x_{98})) x_{97}) (c_{22} (c_{21} x_{99} x_{98}) x_{97})	f	
617	c_{20} (c_{33} (c_{23} c_{18} (c_{26} x_{120} c_{12}))) (c_{33} (c_{23} (c_{31} (c_{23} (c_{32} c_{11} (c_{22} c_{11} x_{120})) c_{14}) x_{120}) (c_{26} (c_{21} c_{11} x_{120}) c_{12})))	f	
634	c_{20} (c_{21} (c_{21} x_{99} x_{97}) x_{98}) (c_{21} (c_{21} x_{99} x_{98}) x_{97})	f	
635	c_{20} (c_{21} (c_{21} x_{99} (c_{25} x_{98})) x_{97}) (c_{22} (c_{22} x_{99} x_{98}) x_{97})	f	
636	c_{20} (c_{23} x_{98} (c_{23} x_{99} x_{97})) (c_{23} x_{99} (c_{23} x_{98} x_{97}))	f	
637	c_{20} (c_{24} (c_{23} x_{99} x_{98}) (c_{23} x_{100} x_{97})) (c_{24} (c_{24} x_{100} x_{99}) (c_{24} x_{98} x_{97}))	f	
638	c_{20} (c_{24} x_{98} (c_{23} x_{99} x_{97})) (c_{24} (c_{24} x_{99} x_{98}) x_{97})	f	
359	c_{20} (c_{24} (c_{23} (c_{28} x_{120}) (c_{28} (c_{21} c_{11} x_{120}))) (c_{27} c_{11})) (c_{31} (c_{24} (c_{28} x_{120}) (c_{27} x_{120})) x_{120})	f	
361	c_{20} (c_{21} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{28} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{14} c_{34})))	f	
363	c_{20} (c_{23} (c_{32} c_{11} (c_{22} x_{97} x_{120})) c_{12}) (c_{31} (c_{32} c_{12} (c_{22} x_{97} x_{120})) x_{120})	f	
478	c_{20} (c_{21} c_{10} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120})))) (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{21} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} (c_{21} c_{12} (c_{21} c_{11} x_{120})) c_{12}) c_{11})) (c_{21} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} (c_{21} c_{11} x_{120}) c_{12}) (c_{23} (c_{32} c_{11} (c_{22} c_{11} x_{120})) c_{12})))))	f	
494	c_{20} (c_{22} (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{23} (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11}))) (c_{33} (c_{23} (c_{23} (c_{26} x_{120} c_{12}) (c_{21} (c_{27} (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34}))))) (c_{24} c_{12} c_{11})))	f	
502	c_{20} (c_{21} c_{10} (c_{26} (c_{21} c_{13} x_{120}) c_{12})) (c_{31} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) x_{120})	f	
503	c_{20} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} (c_{24} c_{12} c_{11}) c_{12})) (c_{22} (c_{21} (c_{23} (c_{28} (c_{24} c_{14} c_{34})) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{23} (c_{25} (c_{27} (c_{24} c_{14} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{21} (c_{23} (c_{28} (c_{24} c_{14} c_{34})) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{23} (c_{27} (c_{24} c_{14} c_{34})) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))))	f	
518	c_{20} (c_{27} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))) (c_{23} (c_{22} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12})))	f	
561	c_{20} (c_{24} x_{99} (c_{21} x_{98} (c_{25} x_{97}))) (c_{25} (c_{24} x_{99} (c_{22} x_{98} x_{97})))	f	
589	c_{20} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{23} (c_{32} c_{11} (c_{22} c_{11} x_{120})) c_{14}))	f	
601	c_{20} (c_{22} (c_{33} (c_{23} (c_{31} (c_{26} x_{120} c_{12}) x_{120}) (c_{23} (c_{32} c_{11} (c_{22} c_{11} x_{120})) c_{14}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120})))) (c_{33} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))	f	
608	c_{20} (c_{33} (c_{23} c_{16} (c_{26} x_{120} c_{12}))) (c_{33} (c_{23} (c_{31} (c_{23} (c_{32} c_{11} (c_{22} c_{11} x_{120})) c_{14}) x_{120}) (c_{26} (c_{21} c_{11} x_{120}) c_{12})))	f	
611	c_{20} (c_{21} (c_{23} (c_{27} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))) (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12})) (c_{23} (c_{28} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))) (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}))) (c_{31} (c_{22} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) x_{120})	f	
618	c_{20} (c_{22} (c_{22} (c_{33} (c_{23} c_{18} (c_{26} x_{120} c_{12}))) (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120})))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120})))) (c_{22} (c_{33} (c_{23} (c_{31} (c_{26} x_{120} c_{12}) x_{120}) (c_{23} (c_{32} c_{11} (c_{22} c_{11} x_{120})) c_{14}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))	f	
624	c_{20} (c_{23} x_{97} (c_{24} c_{12} c_{11})) (c_{24} (c_{26} (c_{24} c_{12} c_{11}) c_{12}) (c_{23} x_{97} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12}))))	f	
360	c_{20} (c_{26} (c_{24} c_{12} c_{11}) c_{12}) (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12})	f	
362	c_{20} (c_{21} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{28} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34})))	f	
373	c_{20} (c_{23} (c_{26} x_{120} c_{12}) (c_{26} c_{12} (c_{22} c_{11} x_{120}))) (c_{31} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{26} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{26} c_{12} (c_{22} c_{11} x_{120}))))) x_{120})	f	
479	c_{20} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{21} c_{11} x_{120})) (c_{31} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) x_{120})	f	
495	c_{20} (c_{21} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{25} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{31} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) x_{120})	f	
496	c_{20} (c_{21} (c_{23} (c_{22} c_{11} x_{120}) (c_{26} (c_{21} c_{12} x_{120}) c_{12})) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120})))) (c_{31} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))) x_{120})	f	
497	c_{20} (c_{21} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{25} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{21} (c_{27} (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34}))))	f	
562	c_{20} (c_{26} (c_{21} x_{110} x_{120}) c_{12}) (c_{31} (c_{26} (c_{21} x_{110} x_{120}) c_{12}) x_{120})	f	
566	c_{20} (c_{21} (c_{22} (c_{23} (c_{33} (c_{23} x_{100} x_{102})) (c_{24} c_{12} c_{11})) (c_{23} (c_{33} (c_{23} x_{99} x_{102})) (c_{24} c_{12} c_{11}))) x_{97}) (c_{22} (c_{33} (c_{23} x_{102} (c_{25} (c_{23} (c_{22} x_{100} x_{99}) (c_{24} c_{12} c_{11}))))) x_{97})	f	
567	c_{20} (c_{23} x_{97} c_{12}) (c_{21} (c_{22} x_{98} x_{97}) (c_{21} x_{98} x_{97}))	f	
580	c_{20} (c_{23} (c_{21} c_{14} (c_{23} x_{120} c_{14})) (c_{26} x_{120} c_{12})) (c_{31} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) x_{120})	f	
583	c_{20} (c_{21} (c_{23} (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{32} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11}))) (c_{33} (c_{23} (c_{26} x_{120} c_{12}) (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{27} (c_{22} (c_{24} c_{14} c_{34}) (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34})))))))	f	
586	c_{20} (c_{24} (c_{23} (c_{28} (c_{21} c_{11} x_{120})) (c_{28} x_{120})) (c_{27} x_{120})) (c_{31} (c_{24} (c_{28} x_{120}) (c_{27} x_{120})) x_{120})	f	
592	c_{20} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) (c_{21} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{27} (c_{22} (c_{24} c_{14} c_{34}) (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34}))))	f	
602	c_{20} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{23} (c_{31} (c_{22} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) x_{120}) (c_{24} c_{12} c_{11}))	f	
619	c_{20} (c_{23} (c_{21} (c_{27} (c_{21} (c_{24} c_{14} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{28} (c_{21} (c_{24} c_{14} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12})) (c_{21} (c_{23} (c_{27} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))) (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12})) (c_{23} (c_{28} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))) (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12})))	f	
621	c_{20} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{23} (c_{24} c_{12} c_{11}) (c_{25} (c_{21} (c_{31} (c_{27} (c_{24} c_{12} c_{34})) x_{120}) (c_{23} (c_{27} (c_{21} (c_{24} c_{14} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{23} (c_{27} (c_{24} c_{14} c_{34})) (c_{25} c_{12}))))))	f	
623	c_{20} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{25} (c_{23} (c_{24} c_{12} c_{11}) (c_{21} (c_{31} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) x_{120}) (c_{23} (c_{27} (c_{21} (c_{24} c_{14} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{23} (c_{27} (c_{24} c_{14} c_{34})) (c_{25} c_{12}))))))	f	
368	c_{20} (c_{23} (c_{31} x_{102} x_{120}) (c_{25} (c_{24} c_{12} c_{11}))) (c_{31} (c_{23} x_{102} (c_{25} (c_{24} c_{12} c_{11}))) x_{120})	f	
372	c_{20} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{26} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{26} c_{12} (c_{22} c_{11} x_{120}))))) (c_{33} (c_{23} (c_{26} x_{120} c_{12}) (c_{26} c_{12} (c_{22} c_{11} x_{120}))))	f	
376	c_{20} (c_{23} (x_{102} x_{120}) (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12}))) (c_{23} x_{102} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12})) x_{120})	f	
384	c_{20} (c_{24} c_{12} (c_{27} c_{11})) (c_{23} (c_{28} (c_{24} c_{12} c_{11})) (c_{27} (c_{24} c_{12} c_{11})))	f	
480	c_{20} (c_{26} (c_{21} x_{99} x_{98}) x_{97}) (c_{31} (c_{26} (c_{21} x_{99} x_{98}) x_{97}) x_{120})	f	
505	c_{20} (c_{22} (c_{24} c_{12} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{24} c_{12} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{28} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))))	f	
506	c_{20} x_{111} (c_{21} (c_{21} c_{10} x_{104}) (c_{22} x_{104} x_{111}))	f	
508	c_{20} (c_{21} x_{100} x_{97}) (c_{21} (c_{21} (c_{21} x_{100} (c_{25} x_{98})) x_{99}) (c_{21} (c_{21} (c_{25} x_{99}) x_{98}) x_{97}))	f	
563	c_{20} (c_{21} (c_{22} (c_{23} (c_{33} (c_{23} x_{100} x_{102})) x_{98}) (c_{23} (c_{33} (c_{23} x_{99} x_{102})) x_{98})) x_{97}) (c_{22} (c_{33} (c_{23} x_{102} (c_{25} (c_{23} (c_{22} x_{100} x_{99}) x_{98})))) x_{97})	f	
568	c_{20} (c_{24} x_{99} (c_{22} x_{98} x_{97})) (c_{25} (c_{24} x_{99} (c_{21} x_{98} (c_{25} x_{97}))))	f	
571	c_{20} (c_{23} x_{97} c_{12}) (c_{22} (c_{21} x_{98} (c_{25} x_{97})) (c_{21} x_{98} x_{97}))	f	
585	c_{20} (c_{23} c_{12} (c_{26} x_{120} c_{12})) (c_{26} (c_{21} c_{11} x_{120}) c_{12})	f	
603	c_{20} (c_{23} c_{11} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120})))) (c_{31} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))) x_{120})	f	
610	c_{20} (c_{21} c_{12} (c_{23} x_{120} (c_{25} c_{13}))) (c_{21} (c_{21} (c_{23} (c_{21} c_{11} c_{13}) c_{12}) (c_{23} c_{14} (c_{25} c_{11}))) (c_{21} (c_{25} c_{12}) (c_{23} x_{120} (c_{25} c_{13}))))	f	
613	c_{20} (c_{23} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) c_{12}) (c_{21} (c_{27} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))))	f	
620	c_{20} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))) (c_{22} (c_{22} (c_{33} (c_{23} c_{18} (c_{26} x_{120} c_{12}))) (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120})))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))	f	
625	c_{20} c_{10} (c_{23} x_{97} (c_{31} (c_{24} c_{12} c_{11}) x_{120}))	f	
627	c_{20} (c_{21} c_{10} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{31} (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{27} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34})))) x_{120})	f	
374	c_{20} (c_{22} (c_{22} x_{99} x_{98}) x_{97}) (c_{21} x_{99} (c_{22} x_{98} x_{97}))	f	
377	c_{20} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{33} (c_{26} (c_{21} c_{13} x_{120}) c_{12}))	f	
378	c_{20} (c_{23} (c_{31} x_{102} x_{120}) (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12}))) (c_{31} (c_{23} x_{102} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12}))) x_{120})	f	
379	c_{20} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{23} (c_{28} (c_{24} c_{14} c_{34})) (c_{25} c_{12}))) (c_{21} (c_{28} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))) (c_{23} (c_{27} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))) (c_{25} c_{11})))	f	
380	c_{20} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{31} (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{28} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34})))) x_{120})	f	
387	c_{20} (c_{23} (c_{22} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12}))) (c_{27} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34})))	f	
395	c_{20} (c_{26} (c_{21} c_{11} x_{110}) x_{97}) (c_{23} (c_{26} x_{110} x_{97}) x_{97})	f	
403	c_{20} (c_{26} (c_{21} c_{11} x_{120}) c_{12}) (c_{33} (c_{26} (c_{21} c_{11} x_{120}) c_{12}))	f	
410	c_{20} (c_{23} (c_{28} (c_{24} c_{14} c_{34})) (c_{21} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{27} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34})))	f	
412	c_{20} (c_{23} (c_{23} x_{97} x_{99}) x_{98}) (c_{23} x_{99} (c_{23} x_{98} x_{97}))	f	
413	c_{20} (c_{24} c_{12} (c_{22} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{28} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))))	f	
421	c_{20} (c_{24} c_{12} (c_{22} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{28} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))))	f	
425	c_{20} (c_{22} (c_{24} c_{14} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))	f	
453	c_{20} (c_{21} (c_{24} c_{12} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{22} (c_{24} c_{14} c_{34}) (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34})))	f	
456	c_{20} (c_{23} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12})) (c_{22} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{28} (c_{22} (c_{24} c_{14} c_{34}) (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34}))))	f	
460	c_{20} (c_{25} (c_{23} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12})) (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) c_{12}))) (c_{22} (c_{28} (c_{22} (c_{24} c_{14} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{28} (c_{22} (c_{24} c_{14} c_{34}) (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34})))))	f	
464	c_{20} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))) (c_{21} (c_{21} (c_{25} (c_{25} (c_{26} (c_{21} c_{13} x_{120}) c_{12}))) (c_{23} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{25} c_{11}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))	f	
468	c_{20} (c_{23} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12})) (c_{22} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{27} (c_{22} (c_{24} c_{14} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34}))))	f	
481	c_{20} (c_{21} c_{10} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120})))) (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{21} (c_{25} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))))) (c_{21} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))))))	f	
510	c_{20} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{25} (c_{31} (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{28} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34})))) x_{120}))	f	
512	c_{20} (c_{23} (c_{33} x_{102}) (c_{24} c_{12} c_{11})) (c_{33} (c_{24} c_{12} x_{102}))	f	
517	c_{20} (c_{24} c_{12} (c_{21} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{27} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))))	f	
519	c_{20} (c_{21} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{26} (c_{21} c_{13} x_{120}) c_{12})) (c_{21} (c_{23} (c_{22} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{26} (c_{21} c_{11} (c_{21} c_{12} x_{120})) c_{12})) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{26} (c_{21} c_{13} x_{120}) c_{12}))	f	
565	c_{20} (c_{21} (c_{23} (c_{28} x_{98}) (c_{27} x_{97})) (c_{25} (c_{23} (c_{27} x_{98}) (c_{28} x_{97})))) (c_{27} (c_{22} x_{98} x_{97}))	f	
569	c_{20} x_{97} (c_{21} x_{99} (c_{22} (c_{21} x_{98} x_{99}) (c_{21} x_{97} x_{98})))	f	
574	c_{20} (c_{23} (c_{25} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) c_{12}) (c_{22} (c_{21} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{21} (c_{27} (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34})))))	f	
584	c_{20} (c_{23} (c_{21} c_{12} x_{120}) (c_{23} (c_{22} c_{11} x_{120}) (c_{26} x_{120} c_{12}))) (c_{22} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} (c_{21} c_{11} x_{120}) c_{12}) (c_{32} c_{12} x_{120})))	f	
591	c_{20} (c_{23} (c_{21} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{25} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12}))) (c_{27} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34})))	f	
606	c_{20} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) c_{12}) (c_{22} (c_{21} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{25} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{21} (c_{27} (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34}))) (c_{25} (c_{28} (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34}))))))	f	
388	c_{20} (c_{33} (c_{31} x_{102} x_{120})) (c_{31} (c_{33} x_{102}) x_{120})	f	
389	c_{20} (c_{24} c_{14} c_{34}) (c_{23} (c_{24} c_{12} c_{11}) (c_{24} c_{12} c_{34}))	f	
390	c_{20} (c_{23} (c_{25} x_{98}) x_{97}) (c_{23} x_{98} (c_{25} x_{97}))	f	
391	c_{20} (c_{21} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} (c_{21} c_{11} x_{120}) c_{12}) (c_{23} (c_{32} c_{11} (c_{22} c_{11} x_{120})) c_{12}))) (c_{31} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))) x_{120})	f	
392	c_{20} (x_{102} x_{120}) (c_{31} (c_{33} (x_{102} x_{120})) x_{120})	f	
393	c_{20} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120})))) (c_{31} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) x_{120})	f	
394	c_{20} c_{12} (c_{23} (c_{26} (c_{24} c_{12} c_{11}) c_{12}) (c_{26} (c_{24} c_{12} c_{11}) c_{12}))	f	
396	c_{20} (c_{26} (c_{21} c_{11} x_{110}) x_{97}) (c_{23} x_{97} (c_{26} x_{110} x_{97}))	f	
397	c_{20} (c_{22} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{31} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) x_{120})	f	
398	c_{20} (c_{23} (c_{26} x_{99} x_{97}) (c_{26} x_{98} x_{97})) (c_{26} (c_{21} x_{99} x_{98}) x_{97})	f	
399	c_{20} (c_{21} (c_{22} (c_{23} (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11}))) (c_{25} (c_{23} (c_{24} c_{12} (c_{21} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{26} x_{120} c_{12})))) (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12})))	f	
400	c_{20} (c_{22} c_{12} x_{97}) (c_{22} c_{11} (c_{22} c_{11} x_{97}))	f	
401	c_{20} (c_{21} (c_{22} x_{98} x_{99}) x_{97}) (c_{22} (c_{22} x_{99} x_{98}) x_{97})	f	
402	c_{20} c_{11} (c_{31} x_{120} x_{120})	f	
404	c_{20} (c_{26} x_{120} c_{12}) (c_{22} (c_{26} x_{120} c_{12}) (c_{26} (c_{21} c_{11} x_{120}) c_{12}))	f	
405	c_{20} (c_{21} (c_{28} (c_{24} c_{12} (c_{23} c_{34} x_{120}))) (c_{25} (c_{27} (c_{24} c_{12} (c_{23} c_{34} x_{120}))))) (c_{21} (c_{27} (c_{21} (c_{24} c_{12} c_{34}) (c_{24} c_{12} (c_{23} c_{34} x_{120})))) (c_{28} (c_{21} (c_{24} c_{12} c_{34}) (c_{24} c_{12} (c_{23} c_{34} x_{120})))))	f	
406	c_{20} (c_{33} (c_{31} (x_{102} x_{120}) x_{120})) (c_{31} (c_{33} x_{102} x_{120}) x_{120})	f	
407	c_{20} (c_{21} (c_{25} (c_{26} (c_{21} c_{11} x_{120}) c_{12})) (c_{23} (c_{26} x_{120} c_{12}) x_{120})) (c_{33} (c_{23} x_{120} (c_{26} x_{120} c_{12})))	f	
408	c_{20} (c_{27} (c_{24} c_{14} c_{34})) (c_{28} (c_{24} c_{14} c_{34}))	f	
409	c_{20} (c_{27} (c_{24} c_{12} (c_{23} c_{34} x_{120}))) (c_{25} (c_{21} (c_{21} (c_{23} (c_{27} (c_{24} c_{12} (c_{23} c_{34} x_{120}))) (c_{25} c_{11})) (c_{23} (c_{28} (c_{24} c_{12} (c_{23} c_{34} x_{120}))) (c_{25} c_{11}))) (c_{21} (c_{27} (c_{21} (c_{24} c_{12} c_{34}) (c_{24} c_{12} (c_{23} c_{34} x_{120})))) (c_{28} (c_{21} (c_{24} c_{12} c_{34}) (c_{24} c_{12} (c_{23} c_{34} x_{120})))))))	f	
411	c_{20} (c_{22} (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{23} (c_{24} c_{12} (c_{22} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{26} x_{120} c_{12}))) (c_{23} (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{13}))	f	
414	c_{20} c_{11} (c_{24} c_{10} c_{10})	f	
415	c_{20} (c_{22} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{25} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{31} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) x_{120})	f	
416	c_{20} (c_{27} (c_{24} c_{12} (c_{23} c_{34} x_{120}))) (c_{25} (c_{24} c_{12} (c_{21} (c_{21} (c_{23} (c_{27} (c_{24} c_{12} (c_{23} c_{34} x_{120}))) (c_{25} c_{11})) (c_{23} (c_{28} (c_{24} c_{12} (c_{23} c_{34} x_{120}))) (c_{25} c_{11}))) (c_{21} (c_{27} (c_{21} (c_{24} c_{12} c_{34}) (c_{24} c_{12} (c_{23} c_{34} x_{120})))) (c_{28} (c_{21} (c_{24} c_{12} c_{34}) (c_{24} c_{12} (c_{23} c_{34} x_{120}))))))))	f	
417	c_{20} (c_{24} c_{12} (c_{21} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{28} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))))	f	
418	c_{20} x_{99} (c_{21} x_{98} (c_{22} (c_{21} x_{97} x_{98}) (c_{21} x_{99} x_{97})))	f	
419	c_{20} (c_{24} c_{12} c_{11}) (c_{22} (c_{24} c_{12} c_{11}) c_{11})	f	
420	c_{20} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{25} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))))) (c_{25} (c_{23} (c_{21} (c_{25} (c_{26} (c_{21} c_{11} x_{120}) c_{12})) (c_{21} (c_{23} c_{12} (c_{25} (c_{26} (c_{21} c_{11} x_{120}) c_{12}))) (c_{23} (c_{26} (c_{21} c_{11} x_{120}) c_{12}) x_{120}))) c_{12}))	f	
422	c_{20} c_{11} (c_{21} (c_{25} c_{11}) c_{12})	f	
423	c_{20} (c_{26} (c_{24} c_{12} c_{11}) c_{12}) (c_{31} (c_{26} (c_{24} c_{12} c_{11}) c_{12}) x_{120})	f	
424	c_{20} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{31} (c_{24} c_{12} (c_{21} (c_{27} (c_{24} c_{12} (c_{23} c_{34} x_{120}))) (c_{25} (c_{28} (c_{24} c_{12} (c_{23} c_{34} x_{120})))))) x_{120})	f	
426	c_{20} (c_{26} x_{97} c_{12}) (c_{22} (c_{26} x_{97} c_{12}) (c_{26} (c_{21} c_{11} x_{97}) c_{12}))	f	
427	c_{20} (c_{28} (c_{24} c_{12} (c_{23} c_{34} x_{120}))) (c_{24} c_{12} (c_{21} (c_{23} (c_{21} (c_{27} (c_{24} c_{12} (c_{23} c_{34} x_{120}))) (c_{25} (c_{28} (c_{24} c_{12} (c_{23} c_{34} x_{120}))))) (c_{25} c_{11})) (c_{21} (c_{27} (c_{21} (c_{24} c_{12} c_{34}) (c_{24} c_{12} (c_{23} c_{34} x_{120})))) (c_{27} (c_{24} c_{12} (c_{23} c_{34} x_{120}))))))	f	
428	c_{20} c_{11} (c_{21} (c_{24} c_{12} c_{11}) (c_{24} c_{12} c_{11}))	f	
429	c_{20} (c_{23} (c_{23} (c_{28} x_{97}) (c_{27} x_{98})) c_{12}) (c_{22} (c_{27} (c_{22} x_{98} x_{97})) (c_{27} (c_{21} x_{98} x_{97})))	f	
430	c_{20} (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{22} (c_{23} (c_{32} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))) (c_{33} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))))	f	
431	c_{20} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} (c_{24} c_{12} c_{11}) c_{12})) (c_{22} (c_{28} (c_{21} (c_{24} c_{14} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{28} (c_{22} (c_{24} c_{14} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34})))))	f	
432	c_{20} (c_{23} x_{98} (c_{25} x_{97})) (c_{23} (c_{25} x_{98}) x_{97})	f	
433	c_{20} x_{98} (c_{21} (c_{21} (c_{25} x_{97}) x_{98}) x_{97})	f	
440	c_{20} (c_{24} (c_{23} x_{99} x_{98}) x_{97}) (c_{24} x_{99} (c_{24} x_{98} x_{97}))	f	
454	c_{20} (c_{21} (c_{24} c_{14} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{22} (c_{24} c_{14} c_{34}) (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34})))	f	
455	c_{20} (c_{22} (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{23} (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11}))) (c_{33} (c_{24} c_{12} (c_{23} (c_{26} x_{120} c_{12}) (c_{22} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))))))	f	
458	c_{20} (c_{32} (c_{21} c_{13} x_{120}) c_{12}) (c_{31} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) x_{120})	f	
462	c_{20} (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{32} c_{11} (c_{22} c_{11} x_{120}))) (c_{23} (c_{26} (c_{21} c_{11} x_{120}) c_{12}) (c_{23} (c_{32} c_{11} (c_{22} c_{11} x_{120})) c_{12}))	f	
471	c_{20} (c_{23} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12})) (c_{21} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{27} (c_{22} (c_{24} c_{14} c_{34}) (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34}))))	f	
482	c_{20} (c_{22} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{28} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) (c_{21} c_{11} x_{120})) (c_{24} c_{12} c_{34}))))	f	
483	c_{20} (c_{24} (c_{25} x_{98}) x_{97}) (c_{24} x_{98} (c_{25} x_{97}))	f	
521	c_{20} (c_{23} x_{98} c_{12}) (c_{21} (c_{21} x_{98} x_{97}) (c_{21} x_{98} (c_{25} x_{97})))	f	
577	c_{20} (c_{23} (c_{22} x_{120} c_{13}) (c_{26} (c_{21} c_{12} x_{120}) c_{12})) (c_{21} (c_{26} (c_{21} c_{13} x_{120}) c_{12}) (c_{23} (c_{26} (c_{21} c_{12} x_{120}) c_{12}) (c_{25} (c_{32} c_{11} (c_{22} c_{11} x_{120})))))	f	
588	c_{20} (c_{23} (c_{22} x_{120} c_{11}) (c_{26} (c_{21} c_{12} x_{120}) c_{12})) (c_{22} (c_{23} (c_{22} x_{120} c_{13}) (c_{26} (c_{21} c_{12} x_{120}) c_{12})) (c_{23} (c_{22} x_{120} c_{12}) (c_{26} (c_{21} c_{13} x_{120}) c_{12})))	f	
590	c_{20} (c_{23} (c_{21} (c_{21} (c_{25} c_{12}) x_{120}) (c_{26} c_{12} x_{120})) (c_{26} x_{120} c_{12})) (c_{31} (c_{23} (c_{26} x_{120} c_{12}) (c_{32} c_{12} (c_{22} c_{11} x_{120}))) x_{120})	f	
434	c_{20} x_{98} (c_{21} (c_{21} x_{97} x_{98}) (c_{25} x_{97}))	f	
436	c_{20} x_{98} (c_{21} (c_{25} x_{97}) (c_{21} x_{98} x_{97}))	f	
439	c_{20} (c_{25} (c_{23} (c_{24} c_{12} (c_{21} (c_{27} (c_{24} c_{12} (c_{23} x_{120} c_{34}))) (c_{28} (c_{24} c_{12} (c_{23} x_{120} c_{34}))))) (c_{26} x_{120} c_{12}))) (c_{23} (c_{25} (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{28} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))))) (c_{26} x_{120} c_{12}))	f	
443	c_{20} (c_{21} x_{99} x_{97}) (c_{21} (c_{21} x_{99} (c_{25} x_{98})) (c_{21} x_{98} x_{97}))	f	
449	c_{20} (c_{23} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12})) (c_{21} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{28} (c_{22} (c_{24} c_{14} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34}))))	f	
450	c_{20} (c_{24} x_{98} (c_{22} x_{99} x_{97})) (c_{22} (c_{24} x_{98} x_{99}) (c_{24} x_{98} x_{97}))	f	
465	c_{20} (c_{27} (c_{22} (c_{24} c_{14} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{27} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34})))	f	
470	c_{20} (c_{21} (c_{23} (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11}))) (c_{33} (c_{23} (c_{26} x_{120} c_{12}) (c_{24} c_{12} (c_{21} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))))))	f	
484	c_{20} (c_{23} (c_{22} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{24} c_{12} c_{11})) (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{28} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) (c_{21} c_{11} x_{120})) (c_{24} c_{12} c_{34}))))	f	
485	c_{20} (c_{25} (c_{24} x_{99} (c_{23} x_{98} x_{97}))) (c_{23} (c_{24} x_{99} x_{98}) (c_{25} x_{97}))	f	
435	c_{20} x_{98} (c_{21} x_{97} (c_{21} x_{98} (c_{25} x_{97})))	f	
442	c_{20} (c_{23} c_{12} c_{12}) c_{14}	f	
446	c_{20} (c_{21} x_{99} x_{97}) (c_{21} (c_{21} x_{99} x_{98}) (c_{22} x_{98} x_{97}))	f	
447	c_{20} (c_{25} (c_{23} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12})) (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) c_{12}))) (c_{22} (c_{22} (c_{23} (c_{27} (c_{25} (c_{24} c_{14} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{23} (c_{28} (c_{25} (c_{24} c_{14} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{22} (c_{23} (c_{27} (c_{25} (c_{24} c_{14} c_{34}))) (c_{27} (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34})))) (c_{23} (c_{28} (c_{25} (c_{24} c_{14} c_{34}))) (c_{28} (c_{23} (c_{21} c_{11} x_{120}) (c_{24} c_{12} c_{34}))))))	f	
461	c_{20} (c_{24} c_{12} (c_{23} (c_{22} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{26} x_{120} c_{12}))) (c_{23} (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{27} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34})))) (c_{26} x_{120} c_{12}))	f	
463	c_{20} (c_{25} (c_{23} x_{98} c_{12})) (c_{21} (c_{22} x_{98} (c_{25} x_{97})) (c_{22} x_{98} x_{97}))	f	
486	c_{20} (c_{23} (c_{24} c_{12} (c_{26} (c_{24} c_{12} c_{11}) c_{12})) (c_{21} (c_{25} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34})))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))) (c_{27} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34})))	f	
487	c_{20} (c_{23} (c_{26} (c_{25} c_{11}) x_{98}) x_{97}) (c_{24} x_{98} x_{97})	f	
437	c_{20} (c_{23} (x_{102} x_{120}) (c_{24} c_{12} c_{11})) (c_{23} x_{102} (c_{24} c_{12} c_{11}) x_{120})	f	
441	c_{20} (c_{23} x_{98} c_{12}) (c_{22} (c_{22} x_{98} x_{97}) (c_{22} (c_{25} x_{98}) x_{97}))	f	
444	c_{20} (c_{21} x_{99} x_{97}) (c_{21} (c_{21} x_{99} x_{97}) (c_{22} x_{98} x_{97}))	f	
466	c_{20} (c_{21} (c_{23} x_{98} (c_{25} c_{11})) x_{97}) (c_{22} x_{98} x_{97})	f	
469	c_{20} (c_{33} (c_{23} (c_{26} x_{120} c_{12}) (c_{24} c_{12} (c_{21} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))))) (c_{33} (c_{23} (c_{26} x_{120} c_{12}) (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{27} (c_{21} (c_{24} c_{14} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34})))))))	f	
556	c_{20} (c_{21} (c_{24} c_{14} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{23} (c_{22} (c_{24} c_{12} c_{11}) (c_{21} c_{11} x_{120})) (c_{24} c_{12} c_{34}))	f	
438	c_{20} (c_{21} c_{10} c_{11}) (c_{31} (c_{32} c_{11} (c_{22} c_{11} x_{120})) x_{120})	f	
452	c_{20} x_{97} (c_{23} (c_{26} (c_{24} c_{12} c_{11}) x_{97}) (c_{26} (c_{24} c_{12} c_{11}) x_{97}))	f	
467	c_{20} (c_{33} (c_{23} (c_{26} x_{120} c_{12}) (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{27} (c_{21} (c_{24} c_{14} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34}))))))) (c_{33} (c_{23} (c_{26} x_{120} c_{12}) (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{27} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) (c_{21} c_{11} x_{120})) (c_{24} c_{12} c_{34}))))))	f	
445	c_{20} (c_{22} (c_{23} (c_{33} (c_{23} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11})) (c_{23} (c_{33} (c_{23} (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{26} x_{120} c_{12}))) (c_{24} c_{12} c_{11}))) (c_{33} (c_{23} (c_{26} x_{120} c_{12}) (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{28} (c_{23} (c_{22} (c_{24} c_{12} c_{11}) (c_{21} c_{11} x_{120})) (c_{24} c_{12} c_{34}))))))	f	
457	c_{20} (c_{21} x_{99} x_{98}) (c_{21} (c_{21} x_{99} (c_{25} x_{97})) (c_{21} x_{98} x_{97}))	f	
459	c_{20} (c_{21} x_{99} x_{97}) (c_{21} (c_{21} x_{99} x_{98}) (c_{21} (c_{25} x_{98}) x_{97}))	f	
448	c_{20} c_{10} (c_{23} (c_{31} (c_{26} (c_{24} c_{12} c_{11}) c_{12}) x_{120}) (c_{27} (c_{22} (c_{24} c_{14} c_{34}) (c_{23} x_{120} (c_{24} c_{12} c_{34})))))	f	
451	c_{20} (c_{33} (c_{24} c_{12} (c_{23} (c_{26} x_{120} c_{12}) (c_{22} (c_{27} (c_{23} x_{120} (c_{24} c_{12} c_{34}))) (c_{28} (c_{23} x_{120} (c_{24} c_{12} c_{34}))))))) (c_{33} (c_{23} (c_{26} x_{120} c_{12}) (c_{24} (c_{23} (c_{27} (c_{24} c_{14} c_{34})) c_{12}) (c_{28} (c_{23} (c_{21} (c_{24} c_{12} c_{11}) x_{120}) (c_{24} c_{12} c_{34}))))))	f	
\.


--
-- Name: teorema_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('"userdb"."teorema_id_seq"', 638, true);


--
-- Data for Name: teoria; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY "userdb"."teoria" ("id", "nombre") FROM stdin;
1	Calculus
\.


--
-- Name: teoria_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('"userdb"."teoria_id_seq"', 1, false);


--
-- Data for Name: termino; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY "userdb"."termino" ("combinador", "serializado", "alias", "login") FROM stdin;
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY "userdb"."usuario" ("login", "nombre", "apellido", "correo", "password", "materiaid", "admin") FROM stdin;
AdminTeoremas	Admin	Teoremas	admin@teoremas.gries	4b39bf2b2076bb3aec161cfd09ca0614a65f3c0adadb80ff443b8434237ad0a2745018653685a9811f2335dd0b314427ff7568592cd3856ef67ddb0315da4627	1	t
\.


--
-- Name: categoria categoria_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."categoria"
    ADD CONSTRAINT "categoria_PK" PRIMARY KEY ("id");


--
-- Name: categoria categoria_UNIQUE; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."categoria"
    ADD CONSTRAINT "categoria_UNIQUE" UNIQUE ("nombre");


--
-- Name: dispone dispone_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."dispone"
    ADD CONSTRAINT "dispone_PK" PRIMARY KEY ("id");


--
-- Name: dispone dispone_metateorema_y_usuario_UNIQUE; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."dispone"
    ADD CONSTRAINT "dispone_metateorema_y_usuario_UNIQUE" UNIQUE ("loginusuario", "metateoremaid");


--
-- Name: materia materia_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."materia"
    ADD CONSTRAINT "materia_PK" PRIMARY KEY ("id");


--
-- Name: materia materia_UNIQUE; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."materia"
    ADD CONSTRAINT "materia_UNIQUE" UNIQUE ("nombre");


--
-- Name: metateorema metateorema_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."metateorema"
    ADD CONSTRAINT "metateorema_PK" PRIMARY KEY ("id");


--
-- Name: mostrarcategoria mostrarCategoria_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."mostrarcategoria"
    ADD CONSTRAINT "mostrarCategoria_PK" PRIMARY KEY ("id");


--
-- Name: predicado predicado_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."predicado"
    ADD CONSTRAINT "predicado_PK" PRIMARY KEY ("alias", "login");


--
-- Name: predicado predicado_alias_UNIQUE; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."predicado"
    ADD CONSTRAINT "predicado_alias_UNIQUE" UNIQUE ("predicado", "login");


--
-- Name: resuelve resuelve_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."resuelve"
    ADD CONSTRAINT "resuelve_PK" PRIMARY KEY ("id");


--
-- Name: resuelve resuelve_teorema_y_usuario_UNIQUE; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."resuelve"
    ADD CONSTRAINT "resuelve_teorema_y_usuario_UNIQUE" UNIQUE ("loginusuario", "teoremaid");


--
-- Name: simbolo simbolo_pk; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."simbolo"
    ADD CONSTRAINT "simbolo_pk" PRIMARY KEY ("id");


--
-- Name: solucion solucion_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."solucion"
    ADD CONSTRAINT "solucion_PK" PRIMARY KEY ("id");


--
-- Name: teorema teorema_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."teorema"
    ADD CONSTRAINT "teorema_PK" PRIMARY KEY ("id");


--
-- Name: teoria teoria_pk; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."teoria"
    ADD CONSTRAINT "teoria_pk" PRIMARY KEY ("id");


--
-- Name: termino termino_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."termino"
    ADD CONSTRAINT "termino_PK" PRIMARY KEY ("alias", "login");


--
-- Name: termino termino_UNIQUE; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."termino"
    ADD CONSTRAINT "termino_UNIQUE" UNIQUE ("combinador", "login");


--
-- Name: usuario usuario_pk; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."usuario"
    ADD CONSTRAINT "usuario_pk" PRIMARY KEY ("login");


--
-- Name: resuelve categoria_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."resuelve"
    ADD CONSTRAINT "categoria_FK" FOREIGN KEY ("categoriaid") REFERENCES "userdb"."categoria"("id");


--
-- Name: mostrarcategoria categoria_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."mostrarcategoria"
    ADD CONSTRAINT "categoria_FK" FOREIGN KEY ("categoriaid") REFERENCES "userdb"."categoria"("id");


--
-- Name: dispone dispone_metateorema_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."dispone"
    ADD CONSTRAINT "dispone_metateorema_FK" FOREIGN KEY ("metateoremaid") REFERENCES "userdb"."metateorema"("id");


--
-- Name: dispone dispone_usuario_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."dispone"
    ADD CONSTRAINT "dispone_usuario_FK" FOREIGN KEY ("loginusuario") REFERENCES "userdb"."usuario"("login");


--
-- Name: predicado predicado_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."predicado"
    ADD CONSTRAINT "predicado_FK" FOREIGN KEY ("login") REFERENCES "userdb"."usuario"("login");


--
-- Name: resuelve resuelve_teorema_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."resuelve"
    ADD CONSTRAINT "resuelve_teorema_FK" FOREIGN KEY ("teoremaid") REFERENCES "userdb"."teorema"("id");


--
-- Name: resuelve resuelve_usuario_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."resuelve"
    ADD CONSTRAINT "resuelve_usuario_FK" FOREIGN KEY ("loginusuario") REFERENCES "userdb"."usuario"("login");


--
-- Name: solucion solucion_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."solucion"
    ADD CONSTRAINT "solucion_FK" FOREIGN KEY ("resuelveid") REFERENCES "userdb"."resuelve"("id");


--
-- Name: simbolo teoria_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."simbolo"
    ADD CONSTRAINT "teoria_FK" FOREIGN KEY ("teoriaid") REFERENCES "userdb"."teoria"("id");


--
-- Name: termino termino_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."termino"
    ADD CONSTRAINT "termino_FK" FOREIGN KEY ("login") REFERENCES "userdb"."usuario"("login");


--
-- Name: usuario usuario_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."usuario"
    ADD CONSTRAINT "usuario_FK" FOREIGN KEY ("materiaid") REFERENCES "userdb"."materia"("id");


--
-- Name: mostrarcategoria usuario_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY "userdb"."mostrarcategoria"
    ADD CONSTRAINT "usuario_FK" FOREIGN KEY ("usuariologin") REFERENCES "userdb"."usuario"("login");


GRANT ALL ON SCHEMA userdb TO userdb;
REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
--
-- PostgreSQL database dump complete
--

