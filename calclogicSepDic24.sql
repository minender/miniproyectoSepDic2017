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
-- Name: purecombstheorems; Type: TABLE; Schema: userdb; Owner: userdb
--

CREATE TABLE userdb.purecombstheorems (
    id integer NOT NULL,
    statement text NOT NULL
);


ALTER TABLE userdb.purecombstheorems OWNER TO userdb;

--
-- Name: purecombstheorems_id_seq; Type: SEQUENCE; Schema: userdb; Owner: userdb
--

CREATE SEQUENCE userdb.purecombstheorems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userdb.purecombstheorems_id_seq OWNER TO userdb;

--
-- Name: purecombstheorems_id_seq; Type: SEQUENCE OWNED BY; Schema: userdb; Owner: userdb
--

ALTER SEQUENCE userdb.purecombstheorems_id_seq OWNED BY userdb.purecombstheorems.id;


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
    aliases userdb.alias_list NOT NULL,
    purecombstheoid integer NOT NULL,
    constlist text
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
-- Name: purecombstheorems id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.purecombstheorems ALTER COLUMN id SET DEFAULT nextval('userdb.purecombstheorems_id_seq'::regclass);


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
12	General Laws of Quantification	1
14	Aritmetic tables	2
13	Aritmetic axioms	2
\.


--
-- Name: categoria_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.categoria_id_seq', 14, true);


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
1	L├ÄΓÇ£├â┬╢├é┬ú├ÄΓÇ£├â┬╢├â┬⌐gica Simb├ÄΓÇ£├â┬╢├é┬ú├ÄΓÇ£├â┬╢├â┬⌐lica Ene-Mar 2018
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
4	federico
2	federico
3	federico
6	federico
1	federico
5	federico
7	federico
1	prueba
2	prueba
8	federico
5	prueba
3	prueba
4	prueba
9	federico
10	federico
12	federico
10	AdminTeoremas
9	AdminTeoremas
5	AdminTeoremas
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
-- Data for Name: purecombstheorems; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.purecombstheorems (id, statement) FROM stdin;
1	= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})
2	= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})
3	= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{9} c_{2})
4	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{4})
5	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})
6	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{2}) c_{4} c_{5})
379	= (\\Phi_{K} T) (\\Phi_{bb(cb,)} c_{7} (c_{62} c_{4} (\\Phi_{K} c_{8})) (\\Phi_{(bb,cb)} c_{5}) (\\Phi_{bc(bb,)} (c_{62} c_{4} (\\Phi_{K} c_{8}))))
380	= (\\Phi_{K} T) (\\Phi_{bb((cccb,b),)} c_{7} (c_{62} c_{4} (\\Phi_{K} c_{8})) c_{5} c_{5} \\Phi_{cb(bb,cb)} (\\Phi_{bc(cccbb,)} (c_{62} c_{4} (\\Phi_{K} c_{8}))) (\\Phi_{bc(cccbcb,)} (c_{62} c_{4} (\\Phi_{K} c_{8}))))
381	= (\\Phi_{ccc(b,cccb)} (\\Phi_{bc(ccccbb,)} (c_{62} c_{4} (\\Phi_{K} c_{8}))) c_{15} \\Phi_{ccccbb} (\\Phi_{bcbbcb} \\Phi_{K}) c_{5} (\\Phi_{(bcbb,cbcb)} c_{5}) (\\Phi_{bccccb} (c_{62} c_{4} (\\Phi_{K} c_{8}))) \\Phi_{ccccbb}) (\\Phi_{bbbb} \\Phi_{K} \\Phi_{b} \\Phi_{bb} (\\Phi_{bbb} \\Phi_{b}))
383	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))))) (\\Phi_{bcb} (\\Phi_{cbcccb} (\\Phi_{bcb} (c_{62} c_{4} (\\Phi_{K} c_{8}))) (\\Phi_{ccbb} \\Phi_{cbcb} c_{15}) (c_{62} c_{4} (\\Phi_{K} c_{8})) c_{2} \\Phi_{bcbb}) \\Phi_{bb} \\Phi_{cbc(bbbbcb,)})
12	= (\\Phi_{(cb,cb)} \\Phi_{bb} \\Phi_{cbb} \\Phi_{bcb} \\Phi_{c(bbb,)}) (\\Phi_{bcb} \\Phi_{b} \\Phi_{ccb} (\\Phi_{ccbb} \\Phi_{cbb}))
13	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{cb} \\Phi_{bc} \\Phi_{cb})
384	= (\\Phi_{ccccc(cb,b)} (\\Phi_{bc(cccccb,)} (c_{62} c_{4} (\\Phi_{K} c_{8}))) c_{15} \\Phi_{cccbb} (\\Phi_{(bbcccbb,cbcb)} c_{5} (c_{62} c_{4} (\\Phi_{K} c_{8}))) (\\Phi_{bccccb} (c_{62} c_{4} (\\Phi_{K} c_{8}))) (\\Phi_{(bbb,bcb)} c_{5}) (\\Phi_{bcc(bbb,(bcb,))} \\Phi_{K}) \\Phi_{ccbbb}) (\\Phi_{bcbb} \\Phi_{K} \\Phi_{cb} \\Phi_{cb} (\\Phi_{bbcb} \\Phi_{b}))
17	= c_{8} (c_{7} c_{9})
18	= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})
19	= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})
20	= (\\Phi_{bb} \\Phi_{b} c_{6}) (\\Phi_{cb} c_{6} \\Phi_{cb})
21	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{6}) c_{6}) (\\Phi_{cbbb} c_{6} \\Phi_{bb} \\Phi_{bb} c_{6})
22	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{6}) c_{1}) (\\Phi_{cbbb} c_{6} \\Phi_{bb} \\Phi_{bb} c_{1})
23	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{6}) (\\Phi_{cbbb} c_{6} \\Phi_{bb} \\Phi_{bb} c_{1})
24	= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})
25	= (\\Phi_{b} (\\Phi_{bb} \\Phi_{K})) (\\Phi_{ccbbb} c_{15} \\Phi_{b} (\\Phi_{cbbb} c_{62}) \\Phi_{ccb} \\Phi_{b})
26	= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})
27	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})
28	= \\Phi_{} (\\Phi_{(b,)} c_{4})
29	= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})
30	= (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{1}) (\\Phi_{cb} c_{2} \\Phi_{cb})
31	= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})
32	= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))
33	= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))
34	= (\\Phi_{b} (\\Phi_{bb} (\\Phi_{bb} \\Phi_{K}))) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} \\Phi_{})))
35	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})
36	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{4}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{4})
37	= (\\Phi_{cc(bb,)} c_{7} c_{4} \\Phi_{bcbb} c_{1}) (\\Phi_{cb} c_{4} \\Phi_{cb})
38	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(ccb,)} c_{4} c_{7} c_{4} (\\Phi_{(bcbb,cb)} c_{1}))
39	= (\\Phi_{(cb,b)} c_{1} \\Phi_{cbb} c_{4}) (\\Phi_{bb} (\\Phi_{(b,b)} c_{1}) c_{5})
40	= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})
41	= (\\Phi_{(cb,b)} c_{1} (\\Phi_{(bcbb,)} c_{1}) c_{4}) (\\Phi_{bb} \\Phi_{b} c_{5})
42	= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{1} c_{5})
43	= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(cbb,b)} c_{1} \\Phi_{b(b,b)} c_{1} c_{5})
44	= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})
45	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})
46	= \\Phi_{} (\\Phi_{(b,)} c_{5})
47	= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))
48	= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{5} c_{9}))
49	= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})
50	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{4} c_{5} \\Phi_{cbcb})
51	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{5} c_{4} \\Phi_{cbcb})
52	= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cbb} c_{7} (\\Phi_{(bbb,)} c_{5}) c_{4})
53	= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cbb} c_{7} (\\Phi_{(bbb,)} c_{4}) c_{5})
54	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})
55	= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})
56	= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})
57	= (\\Phi_{cc(bbb,)} c_{7} c_{5} \\Phi_{bcbb} c_{1} c_{7}) (\\Phi_{cb} c_{5} \\Phi_{cb})
58	= (\\Phi_{bb} \\Phi_{K} c_{7}) (\\Phi_{c(ccb,)} c_{5} c_{7} c_{5} (\\Phi_{(bcbb,cb)} c_{1}))
59	= (\\Phi_{c(c(b,bb),)} c_{5} c_{1} (\\Phi_{ccbbcb} c_{5}) \\Phi_{bbcb} c_{1}) (\\Phi_{cbcb} c_{1} \\Phi_{bb} c_{5} \\Phi_{cbb})
60	= (\\Phi_{c((ccb,b),)} c_{5} c_{1} \\Phi_{bcb} (\\Phi_{ccbbbcb} c_{5}) c_{1}) (\\Phi_{cbcb} c_{1} \\Phi_{bb} c_{5} \\Phi_{cbb})
61	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{cc(cc(cb,),)} c_{1} c_{5} c_{1} (\\Phi_{(bbcb,cbb)} c_{1}) c_{5} (\\Phi_{(ccccbbcb,b)} c_{5}))
62	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{cc(ccc(cb,),)} c_{1} c_{5} c_{1} \\Phi_{b(bcb,cbb)} c_{1} c_{5} (\\Phi_{(cccccbbcb,b)} c_{5}))
63	= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{1} (\\Phi_{(bcb,)} c_{5}))
118	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{(cb,b)} c_{5} \\Phi_{cbb} c_{2})
64	= (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{1} c_{1}) (\\Phi_{ccbb} (\\Phi_{(bcb,b)} c_{5}) c_{1} \\Phi_{ccb} c_{1})
65	= (\\Phi_{(cbbb,b)} c_{7} (\\Phi_{(bbb,b)} c_{4}) c_{5} c_{7} c_{5}) (\\Phi_{bb} \\Phi_{b} c_{1})
66	= (\\Phi_{c(bbb,b)} c_{7} (\\Phi_{(bb,bb)} c_{4}) c_{5} c_{7} c_{5}) (\\Phi_{bb} \\Phi_{b} c_{6})
67	= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})
68	= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})
69	= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})
70	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{1}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{2} \\Phi_{ccb} c_{1})
71	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{2} \\Phi_{bcb} c_{1}) c_{2}) (\\Phi_{ccbb} \\Phi_{cbb} c_{2} \\Phi_{ccb} c_{1})
72	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{2} \\Phi_{bcb} c_{2}) c_{2}) (\\Phi_{ccbb} \\Phi_{cbb} c_{2} \\Phi_{ccb} c_{2})
73	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{2}) c_{2}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{2})
74	= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})
75	= (\\Phi_{bb} (\\Phi_{(bb,)} c_{1}) c_{1}) (\\Phi_{b} \\Phi_{K})
76	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{ccb} c_{1} c_{1} \\Phi_{cb(b,)})
77	= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})
78	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{cb} c_{1} (\\Phi_{(b,cb)} c_{1}))
79	= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})
80	= T c_{8}
81	= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})
82	= (c_{7} c_{8}) c_{9}
83	= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})
84	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cbb} c_{5} (\\Phi_{(bbb,b)} (\\Phi_{(bb,b)} c_{2}) c_{5}) c_{4})
85	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(cbb,b)} c_{5} \\Phi_{b(bb,)} c_{2} c_{2})
86	= (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{2}) (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{2} c_{2})
87	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{(cbb,b)} c_{7} (\\Phi_{(bbb,b)} c_{5}) c_{2} c_{2})
88	= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})
89	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(c(cbb,),b)} c_{2} c_{5} (\\Phi_{(bb,(bcb,b))} c_{2}) c_{1} c_{2})
90	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{2}) c_{2} c_{2})
91	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{1}) c_{2} c_{2})
92	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{2}) c_{1} c_{2})
93	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})
94	= (\\Phi_{cb} c_{1} (\\Phi_{(bbb,b)} \\Phi_{bb} c_{5})) (\\Phi_{cbb} c_{1} \\Phi_{bb} (\\Phi_{(bb,b)} c_{5}))
95	= (\\Phi_{cb} c_{1} (\\Phi_{(cbbbb,b)} c_{5} \\Phi_{bbb} \\Phi_{bb} c_{2})) (\\Phi_{cbcb} c_{1} \\Phi_{bb} c_{5} (\\Phi_{(bbb,bb)} \\Phi_{bb} c_{2}))
96	= (\\Phi_{bbc} \\Phi_{b} c_{2} c_{8}) (\\Phi_{b} (\\Phi_{(bb,)} c_{2}))
97	= (\\Phi_{cbbbc} c_{5} \\Phi_{bb} \\Phi_{bb} c_{2} c_{8}) (\\Phi_{cb} c_{5} (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2}))
98	= (\\Phi_{cbb} c_{9} \\Phi_{bc} c_{2}) (\\Phi_{(bb,)} \\Phi_{bc} c_{2})
99	= (\\Phi_{bb} (\\Phi_{cbbb} c_{9} \\Phi_{bc} c_{2}) c_{4}) (\\Phi_{bb} (\\Phi_{(bbb,)} \\Phi_{bc} c_{2}) c_{4})
100	= (\\Phi_{bbc} \\Phi_{b} c_{5} c_{8}) (\\Phi_{b} (\\Phi_{(bb,)} c_{5}))
101	= (\\Phi_{bbc} \\Phi_{b} c_{4} c_{9}) (\\Phi_{b} (\\Phi_{(bb,)} c_{4}))
102	= (\\Phi_{(cbbc,bc)} c_{7} (\\Phi_{(bbb,b)} c_{4}) c_{5} c_{9} c_{5} c_{8}) (\\Phi_{b} \\Phi_{b})
385	= (\\Phi_{bcbb} (\\Phi_{bb} \\Phi_{K}) \\Phi_{bcb} \\Phi_{bbb} (\\Phi_{bcb} (c_{62} c_{4} (\\Phi_{K} c_{8})))) (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} (\\Phi_{bbb} \\Phi_{b})))
386	= (\\Phi_{bccb} (\\Phi_{bb} \\Phi_{K}) \\Phi_{bb} (\\Phi_{bbb} (c_{62} c_{4} (\\Phi_{K} c_{8}))) \\Phi_{cbbb}) (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} (\\Phi_{bbb} \\Phi_{b})))
387	= (\\Phi_{K} T) (\\Phi_{b(cccccccb,)} (c_{62} c_{5} (\\Phi_{K} c_{8})) \\Phi_{b} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{(bcb,cbbbb)} c_{2}) c_{15} c_{5} (c_{62} c_{5} (\\Phi_{K} c_{8})) \\Phi_{b} (\\Phi_{bcccc(cb,bbb)} (c_{62} c_{5} (\\Phi_{K} c_{8}))))
388	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(c(cb,),(cccccb,b))} (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) (\\Phi_{bcc(ccb,)} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{5} c_{15} (\\Phi_{(bcb,cbbbb)} c_{2}) (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{bc(cccccb(cb,b),(cb,b))} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{bcccc(cb,bbb)} (c_{62} c_{5} (\\Phi_{K} c_{8}))))
107	= (\\Phi_{cb} c_{15} (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2})) (\\Phi_{cbb} c_{15} \\Phi_{bb} (\\Phi_{(bb,b)} c_{2}))
389	= (\\Phi_{K} T) (\\Phi_{bb} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{bbb} (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{b}))
390	= (\\Phi_{K} T) (\\Phi_{bccb(cccccb,b)} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{15} c_{15} (\\Phi_{bcc(ccbb,b)} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{15} (\\Phi_{(b(bb,b),b)} c_{1} c_{4}) c_{15} (\\Phi_{(b(bb,b),b)} c_{1} c_{4})) (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{5} c_{15} (\\Phi_{(bcb,cbbbb)} c_{2}) (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{bc(cccccbcbb,cbb)} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{bcccc(cb,bbb)} (c_{62} c_{5} (\\Phi_{K} c_{8}))))
391	= (\\Phi_{K} T) (\\Phi_{b(ccc(c(ccc(c(cccccb,b),),),),)} (c_{62} c_{5} (\\Phi_{K} c_{8})) \\Phi_{b} (c_{62} c_{4}) (\\Phi_{(bbcb,b)} c_{1}) \\Phi_{cb} \\Phi_{b} (c_{62} c_{4}) (\\Phi_{(bbcb,b)} c_{1}) \\Phi_{cb} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{5} c_{15} (\\Phi_{(bcb,cbbbb)} c_{2}) (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{bc(cccccbccbbbb,ccbbbb)} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{bcccc(cb,bbb)} (c_{62} c_{5} (\\Phi_{K} c_{8}))))
392	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bc(cccccb,b)} (\\Phi_{b(cb,)} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{(bb,b)} c_{1})) (\\Phi_{(bb,b)} c_{1}) (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{5} c_{15} (\\Phi_{(bcb,cbbbb)} c_{2}) (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{bc(cccccbbb,bb)} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{bcccc(cb,bbb)} (c_{62} c_{5} (\\Phi_{K} c_{8}))))
117	= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})
119	= (\\Phi_{K} (\\Phi_{K} c_{8})) (\\Phi_{bb} (\\Phi_{(bb,)} c_{4}) c_{2})
120	= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{(cb,b)} c_{4} \\Phi_{cbb} c_{2})
121	= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{2}) c_{5} c_{4})
122	= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})
123	= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))
124	= \\Phi_{} (\\Phi_{cb} c_{8} c_{2})
125	= (\\Phi_{b} c_{7}) (\\Phi_{b} (c_{2} c_{9}))
394	= (\\Phi_{bbcb} \\Phi_{K} \\Phi_{b} (\\Phi_{(bb,cb)} c_{5}) \\Phi_{c(bb,)}) (\\Phi_{bb} (\\Phi_{cb} (\\Phi_{ccccb} \\Phi_{cb})) (\\Phi_{cccb} \\Phi_{cb(bcb,)}))
404	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{15} \\Phi_{bcb} c_{4}) c_{15})))) (\\Phi_{bb} (\\Phi_{bcb} \\Phi_{b} \\Phi_{cccb}) (\\Phi_{cccbb} \\Phi_{cbbb}))
130	= (\\Phi_{bb} \\Phi_{K} (\\Phi_{bb} (\\Phi_{bb} c_{7}))) (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))
131	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} c_{15}))) (\\Phi_{bb} \\Phi_{b} (\\Phi_{bbb} \\Phi_{b}))
133	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))
134	= (\\Phi_{bb} (\\Phi_{bbb} (\\Phi_{bb} \\Phi_{K}) \\Phi_{bb}) \\Phi_{bbb}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))))
138	= (\\Phi_{bb} \\Phi_{K} (\\Phi_{bb} \\Phi_{b})) (\\Phi_{K} (\\Phi_{cb} \\Phi_{cb} \\Phi_{cb}))
140	= (\\Phi_{((bb,),b)} (\\Phi_{b(bcb,)} \\Phi_{K}) \\Phi_{cbb} \\Phi_{b(bbb,b)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))))
141	= (\\Phi_{bbb} \\Phi_{K} \\Phi_{K} (\\Phi_{bb} \\Phi_{b})) (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} (\\Phi_{bbb} \\Phi_{b})))
142	= (\\Phi_{bb} (\\Phi_{bb} \\Phi_{K}) \\Phi_{(bb,)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} \\Phi_{b})))
143	= (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{5}) (\\Phi_{bb} \\Phi_{b} c_{2})
147	= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})
160	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))))) (\\Phi_{bb} (\\Phi_{ccbb} c_{15} c_{15} (\\Phi_{bc(cccbb,b)} \\Phi_{(b,)} \\Phi_{(cccbbbbb,b)} c_{5} \\Phi_{b(bbb,b)} c_{2})) \\Phi_{cc(cccccbb,b)})
162	= (\\Phi_{bbbb} \\Phi_{K} \\Phi_{K} \\Phi_{K} (\\Phi_{bb} \\Phi_{b})) (\\Phi_{K} (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} \\Phi_{bb}) \\Phi_{bbb}))
164	= (\\Phi_{K} (\\Phi_{K} \\Phi_{})) (\\Phi_{bb} \\Phi_{b} \\Phi_{bb})
165	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{b} \\Phi_{(b,)})
166	= (\\Phi_{bbb} (\\Phi_{bbb} \\Phi_{K} \\Phi_{K}) \\Phi_{bb} \\Phi_{bb}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{bbb} \\Phi_{b} \\Phi_{bb} \\Phi_{bb})))
167	= (\\Phi_{bbb} \\Phi_{K} \\Phi_{K} (\\Phi_{bb} \\Phi_{K})) (\\Phi_{K} (\\Phi_{cbb} \\Phi_{bcb} \\Phi_{bb} \\Phi_{cb}))
169	= (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} c_{15})) (\\Phi_{(ccb,)} c_{15} \\Phi_{bb} \\Phi_{cbbb})
170	= (\\Phi_{K} (\\Phi_{bb} (\\Phi_{cbbbb} c_{15} \\Phi_{bb} \\Phi_{bb} c_{5}) c_{15})) (\\Phi_{(ccccb,)} \\Phi_{cccbb} c_{15} \\Phi_{bb} \\Phi_{cbbb} \\Phi_{ccccbb})
171	= (\\Phi_{bb(bcccb,)} \\Phi_{K} \\Phi_{K} \\Phi_{bb} c_{5} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb}) (\\Phi_{cccb} \\Phi_{ccccbb} \\Phi_{cbbb} \\Phi_{bb} (\\Phi_{bccccb} \\Phi_{b} \\Phi_{cccbb}))
172	= (\\Phi_{b(ccbb,b)} \\Phi_{K} c_{4} \\Phi_{bb} \\Phi_{cbbb} c_{15} c_{15}) (\\Phi_{bbbb} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} c_{15})
173	= (\\Phi_{b(cccbb,b)} \\Phi_{K} c_{4} c_{15} (\\Phi_{(bb,bb)} c_{4}) \\Phi_{c(bb,bb)} c_{15} c_{15}) (\\Phi_{K} (\\Phi_{(cb,)} (\\Phi_{(bcb,b)} c_{15}) \\Phi_{(cb,b)}))
175	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))))) (\\Phi_{(bb,b)} (\\Phi_{bb(b,)} (\\Phi_{bb} \\Phi_{b})) \\Phi_{(cbb,b)} (\\Phi_{(bbbbb,bb)} (\\Phi_{(bb,b)} c_{2})))
177	= (\\Phi_{bccb} \\Phi_{(b,)} \\Phi_{cbbb} \\Phi_{bb} \\Phi_{(ccbb,b)}) (\\Phi_{bccb} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbb})
178	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccb,)} c_{15} (\\Phi_{(bb,(bcb,b))} c_{2}) c_{5} \\Phi_{(c(cbb,),b)})
179	= (\\Phi_{b} (\\Phi_{b(b,)} \\Phi_{K})) (\\Phi_{K} (\\Phi_{K} \\Phi_{}))
180	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{5}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{5})
395	= (\\Phi_{bb} (\\Phi_{bccb} (\\Phi_{bb} (\\Phi_{b(b,)} \\Phi_{K})) \\Phi_{bb} (\\Phi_{bbb} (c_{62} c_{4} (\\Phi_{K} c_{8})))) \\Phi_{(bcbbb,bb)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} \\Phi_{b})))))
396	= (\\Phi_{b(b,)} (\\Phi_{cb(cb,ccb)} \\Phi_{(bcccbb,bbb)} (\\Phi_{ccbb} (\\Phi_{bc(ccbbb,)} (c_{62} c_{4} (\\Phi_{K} c_{8}))) c_{15}) (\\Phi_{(bb,bcbcb)} c_{5}) (\\Phi_{bccbbcb} (\\Phi_{bb} \\Phi_{K})) c_{5} (\\Phi_{bcccb} (c_{62} c_{4} (\\Phi_{K} c_{8})))) \\Phi_{(cccccbbb,b)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))))))
397	= (\\Phi_{cbb} \\Phi_{(bbb,)} (\\Phi_{bcbb} (\\Phi_{bb} \\Phi_{K}) (\\Phi_{(bb,b)} c_{5})) \\Phi_{cbbb}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))))
184	= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})
185	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccb,b)} c_{2} \\Phi_{bcbcb} c_{4} (\\Phi_{ccc(bbb,)} c_{5}) c_{4})
398	= (\\Phi_{bcb} (\\Phi_{b(cccb,)} (\\Phi_{bb} \\Phi_{K}) \\Phi_{b} (c_{62} c_{5}) \\Phi_{bcb}) \\Phi_{cb} \\Phi_{(bccbbbb,b)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} \\Phi_{b}))))
187	= (\\Phi_{b(bccb,)} \\Phi_{K} \\Phi_{bb} c_{4} \\Phi_{bcb} \\Phi_{c(bbb,)}) (\\Phi_{bcb} \\Phi_{b} \\Phi_{ccb} (\\Phi_{ccbb} \\Phi_{cbb}))
188	= (\\Phi_{(b,)} c_{15}) (\\Phi_{K} c_{8})
189	= (\\Phi_{b(bccb,)} \\Phi_{K} \\Phi_{bb} c_{5} \\Phi_{bcb} \\Phi_{c(bbb,)}) (\\Phi_{bcb} \\Phi_{b} \\Phi_{ccb} (\\Phi_{ccbb} \\Phi_{cbb}))
190	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} c_{9}))) (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))
399	= (\\Phi_{c(cb,b)} \\Phi_{(bbb,b)} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{bccbb} (\\Phi_{bb} \\Phi_{K})) \\Phi_{(cbbb,b)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))))
192	= (\\Phi_{bbccb} (\\Phi_{bb} \\Phi_{K}) \\Phi_{bb} c_{5} \\Phi_{bcb} \\Phi_{c(bbb,)}) (\\Phi_{bbcb} \\Phi_{K} \\Phi_{b} \\Phi_{ccb} (\\Phi_{ccbb} \\Phi_{cbb}))
193	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{b} \\Phi_{c})
194	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))) (\\Phi_{c(bb,(b,))} \\Phi_{(bbb,bb)} \\Phi_{bbb} \\Phi_{(cb,)} \\Phi_{(ccbbb,b)})
195	= (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})) (\\Phi_{cb} \\Phi_{cb} \\Phi_{cb})
400	= (\\Phi_{cbb} (\\Phi_{bcb} (c_{62} c_{4} (\\Phi_{K} c_{8}))) (\\Phi_{bcbb} (\\Phi_{bb} (\\Phi_{b(b,)} \\Phi_{K})) \\Phi_{bcb}) \\Phi_{(bbbb,bb)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} \\Phi_{b})))))
405	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(c(bbb,ccbbb),bb)} \\Phi_{b} c_{5} (\\Phi_{cc(cbbbb,)} \\Phi_{cbb} c_{5}) (c_{62} c_{5}) \\Phi_{b} c_{1} c_{2} \\Phi_{cb(bb,bccb)} (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{b} (c_{62} c_{5}) \\Phi_{b})
410	= \\Phi_{} (\\Phi_{cb} c_{9} c_{4})
411	= (\\Phi_{K} c_{9}) (\\Phi_{cb} c_{9} c_{5})
412	= \\Phi_{} (\\Phi_{cb} c_{8} c_{5})
413	= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{8} c_{4})
206	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{c(ccbb,b)} c_{4} c_{5} (\\Phi_{(bbb,b)} c_{5}) \\Phi_{(cbbb,b)} c_{2} c_{2})
207	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))
208	= (\\Phi_{K} (\\Phi_{K} \\Phi_{})) (\\Phi_{bb} \\Phi_{b} \\Phi_{cb})
209	= (\\Phi_{K} (\\Phi_{K} \\Phi_{})) (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))
210	= (\\Phi_{(bb,)} \\Phi_{bb} (\\Phi_{bbb} \\Phi_{b})) (\\Phi_{(ccb,)} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbb})
211	= (\\Phi_{bbb} \\Phi_{K} \\Phi_{K} \\Phi_{K}) (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} \\Phi_{(bb,)}))
212	= (\\Phi_{cbb} c_{1} \\Phi_{b(b,)} c_{1}) (\\Phi_{b} \\Phi_{K})
401	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))) (\\Phi_{c(cccc(c(cb,b),b),b)} \\Phi_{b} (\\Phi_{(bb,b)} c_{4}) (\\Phi_{b(bb,b)} c_{7} c_{5}) \\Phi_{cccc(cc(bbbb,b),b)} (c_{62} c_{5} (\\Phi_{K} c_{8})) \\Phi_{b} (\\Phi_{(b(bbcbb,cbb),bb)} c_{2} c_{15}) (\\Phi_{ccc(ccccc(cbb,b),bb)} \\Phi_{b} \\Phi_{b} \\Phi_{b}) c_{62} c_{62} c_{62})
414	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{15} c_{15} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})
415	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{15} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})
221	= (\\Phi_{b} (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{K} \\Phi_{K}))) (\\Phi_{K} (\\Phi_{bb} \\Phi_{K} (\\Phi_{bc} \\Phi_{b})))
224	= (\\Phi_{bbbb} \\Phi_{b} \\Phi_{bb} (\\Phi_{bcbb} \\Phi_{b} \\Phi_{bcb}) \\Phi_{ccbb}) (\\Phi_{K} (\\Phi_{bbbcb} \\Phi_{K} \\Phi_{K} \\Phi_{K} \\Phi_{cb} \\Phi_{cb}))
225	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{b} (\\Phi_{bc} \\Phi_{b}))
231	= (\\Phi_{ccbb} (\\Phi_{bccbb} \\Phi_{K}) \\Phi_{bcb} (\\Phi_{(bccb,)} \\Phi_{bb}) \\Phi_{ccbb}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{cb} \\Phi_{cb} \\Phi_{cb})))))
235	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{bb} \\Phi_{b} \\Phi_{cb})
236	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})
237	= (\\Phi_{c(bb,)} c_{5} (\\Phi_{bbcb} \\Phi_{K}) c_{1}) (\\Phi_{cbc(cb,)} c_{1} \\Phi_{bb} c_{5} c_{5} (\\Phi_{(bcb,cbb)} c_{1}))
238	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})
416	= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{15}) (\\Phi_{bb} \\Phi_{b} c_{12})
417	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))) (\\Phi_{c(cc(b,),cccb)} c_{12} (c_{62} c_{5}) \\Phi_{b} (\\Phi_{bccccbb} \\Phi_{b}) \\Phi_{cb(bbcb,b)} c_{2} c_{1} (\\Phi_{(cc(ccbb,bbb),bb)} \\Phi_{cb}))
419	= (\\Phi_{bb} \\Phi_{K} (\\Phi_{bbb} (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{b})) (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} c_{12}))
420	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))) (\\Phi_{b(cccbb,b)} \\Phi_{b} c_{2} \\Phi_{b(bb,b)} c_{5} \\Phi_{(ccbbb,b)} c_{12} c_{12})
421	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))) (\\Phi_{c(ccccb,b)} c_{12} c_{5} c_{5} c_{12} \\Phi_{c(ccb,)} (\\Phi_{(ccbb,ccbb)} (\\Phi_{(bbb,(bcbb,cb))} c_{2})) \\Phi_{c(cc(ccbbb,b),)})
422	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))) (\\Phi_{bbb} \\Phi_{b} (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2}) c_{12})
257	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbb,b)} c_{2} c_{2} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)} c_{5} c_{5})
258	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbb,b)} c_{2} c_{2} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)} c_{4} c_{4})
259	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbb,b)} c_{2} c_{2} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)} c_{3} c_{3})
260	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} (\\Phi_{(bbcb,b)} c_{2}) c_{5} \\Phi_{cc(bbb,)} c_{2} c_{5})
261	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} (\\Phi_{(bbcb,b)} c_{2}) c_{4} \\Phi_{cc(bbb,)} c_{2} c_{4})
262	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} (\\Phi_{(bbcb,b)} c_{2}) c_{2} \\Phi_{cc(bbb,)} c_{2} c_{2})
263	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{3} (\\Phi_{(bbcb,b)} c_{2}) c_{3} \\Phi_{cc(bbb,)} c_{2} c_{3})
264	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbb,b)} c_{2} c_{3} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)} c_{2} c_{2})
265	= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{3} c_{7}) (\\Phi_{bb} \\Phi_{b} c_{2})
266	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbb,b)} c_{3} c_{3} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)} c_{5} c_{5})
267	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbb,b)} c_{3} c_{3} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)} c_{4} c_{4})
268	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbb,b)} c_{3} c_{3} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)} c_{3} c_{3})
269	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{3} (\\Phi_{(bbcb,b)} c_{2}) c_{5} \\Phi_{cc(bbb,)} c_{3} c_{5})
270	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{3} (\\Phi_{(bbcb,b)} c_{2}) c_{4} \\Phi_{cc(bbb,)} c_{3} c_{4})
271	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{3} (\\Phi_{(bbcb,b)} c_{2}) c_{2} \\Phi_{cc(bbb,)} c_{3} c_{2})
272	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} (\\Phi_{(bbcb,b)} c_{2}) c_{3} \\Phi_{cc(bbb,)} c_{3} c_{3})
273	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbb,b)} c_{3} c_{2} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)} c_{2} c_{2})
274	= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{bb} \\Phi_{b} c_{3})
275	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{3}) c_{3} c_{3})
276	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))) (\\Phi_{((bb,),)} (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5}) \\Phi_{c(ccbbb,)})
281	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{3}) c_{5} c_{4})
296	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{K} (\\Phi_{cbcb} \\Phi_{b} \\Phi_{bb} (\\Phi_{K} c_{9}) c_{62}))
297	= (\\Phi_{c(b(cbb,),b)} \\Phi_{b} (\\Phi_{ccbbb} \\Phi_{b} \\Phi_{b}) \\Phi_{bcbb} (\\Phi_{cc(bbbb,b)} \\Phi_{b}) c_{62} c_{62}) (\\Phi_{ccc((bb,b),b)} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{(bb,b)} c_{4}) \\Phi_{cc(ccbb,b)} (\\Phi_{cccc(cbb,b)} \\Phi_{b} \\Phi_{b}) \\Phi_{(bcbb,cbb)} c_{62} c_{62})
298	= (\\Phi_{c(b(cbb,),b)} \\Phi_{b} (\\Phi_{ccbbb} \\Phi_{b} \\Phi_{b}) \\Phi_{bcbb} (\\Phi_{cc(bbbb,b)} \\Phi_{b}) c_{62} c_{62}) (\\Phi_{ccbb} (\\Phi_{(bb,b)} c_{4}) \\Phi_{ccbb} (\\Phi_{cccbb} \\Phi_{b} \\Phi_{cbb}) c_{62})
301	= (\\Phi_{c(ccccbb,b)} \\Phi_{b} \\Phi_{bcb} \\Phi_{cb} \\Phi_{bbbb} \\Phi_{bcb} (\\Phi_{cccbcbbb} \\Phi_{b}) c_{62} c_{62}) (\\Phi_{c(ccccbb,b)} \\Phi_{b} \\Phi_{bbb} \\Phi_{b} \\Phi_{cbbb} \\Phi_{bb} (\\Phi_{cccbcbbb} \\Phi_{b}) c_{62} c_{62})
302	= (\\Phi_{cbbb} \\Phi_{bb} \\Phi_{bb} (\\Phi_{c(bbb,)} \\Phi_{bb} \\Phi_{bcb}) c_{62}) (\\Phi_{cbb} \\Phi_{b} (\\Phi_{bcbbb} \\Phi_{K} \\Phi_{b} \\Phi_{bb}) c_{62})
303	= (\\Phi_{b} (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{15}))) (\\Phi_{K} (\\Phi_{ccb} \\Phi_{cbb} c_{15} \\Phi_{ccb}))
304	= (\\Phi_{c(cccbcbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bcb} \\Phi_{b} \\Phi_{ccbbbb} \\Phi_{b} \\Phi_{(bbb,bb)} c_{62} c_{62}) (\\Phi_{(bcbbcb,ccbb)} \\Phi_{bb} \\Phi_{b} \\Phi_{bcb} \\Phi_{bb} (\\Phi_{K} c_{8}) c_{62} \\Phi_{cbb} c_{5} \\Phi_{(b(cbb,b),bb)} c_{62})
305	= (\\Phi_{(cbcbcb,bb)} \\Phi_{cb} \\Phi_{bcb} \\Phi_{cb} \\Phi_{bcb} (\\Phi_{K} c_{8}) c_{62} \\Phi_{(bcb,cb)} c_{62}) (\\Phi_{(cbbcb,cbb)} \\Phi_{b} \\Phi_{bcb} \\Phi_{bb} (\\Phi_{K} c_{8}) c_{62} \\Phi_{b} \\Phi_{(bbb,bb)} c_{62})
315	= (\\Phi_{b} (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{K} \\Phi_{K}))) (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bc} \\Phi_{b}))))
316	= (\\Phi_{b} (\\Phi_{bb} (\\Phi_{bbbb} \\Phi_{K} \\Phi_{K} \\Phi_{K}))) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))))
317	= (\\Phi_{b} (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{K} \\Phi_{K}))) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} \\Phi_{(b,)}))))
318	= (\\Phi_{b} (\\Phi_{bbb(b,)} \\Phi_{K} \\Phi_{K} \\Phi_{K})) (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))))
320	= (\\Phi_{(bb,)} \\Phi_{bb} (\\Phi_{bbb} (\\Phi_{bbbb} \\Phi_{K} \\Phi_{K} \\Phi_{K}))) (\\Phi_{((bcbcb,),b)} \\Phi_{ccb} \\Phi_{cbb} \\Phi_{bbcbcb} \\Phi_{bb} \\Phi_{cbb} \\Phi_{cccb})
324	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(bcb,b)} (\\Phi_{(cb,b)} c_{5}) c_{5} (\\Phi_{b(ccccb,)} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{(b(b(bb,b),b),(bb,(bb,b)))} c_{1} c_{5} c_{5}))
325	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{cccbb(b,)} c_{15} \\Phi_{b} (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{bbbb} c_{2} c_{15})
326	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cbbbb} (\\Phi_{(b(bb,b),(bb,b))} c_{1} c_{5}) (\\Phi_{(cb,b)} c_{5}) \\Phi_{bc(cb,)} (c_{62} c_{5}) \\Phi_{b})
327	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{cccccbb(b,)} c_{15} \\Phi_{b} \\Phi_{cb} c_{15} (c_{62} c_{4}) \\Phi_{b(bcb,bb)} c_{2} c_{15})
328	= (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{bbb} c_{2}) (\\Phi_{bbb} (\\Phi_{bb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) \\Phi_{bb} c_{2})
329	= (\\Phi_{bb} (\\Phi_{bb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} c_{5}) \\Phi_{cbb} \\Phi_{b})
330	= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} c_{5}) \\Phi_{b})
331	= (\\Phi_{bbbb} \\Phi_{b} c_{4} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{bb} c_{7})) (\\Phi_{cbbb} \\Phi_{K} \\Phi_{bb} (c_{62} c_{5}) \\Phi_{b})
333	= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} c_{5}) \\Phi_{b})
334	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cc(cbbb,bb),bb)} (\\Phi_{(bb,b)} c_{1}) \\Phi_{b} c_{1} (\\Phi_{(bbbb,bb)} c_{2}) \\Phi_{b} \\Phi_{(cccbbbb,b)} (c_{62} c_{5}) \\Phi_{b} (c_{62} c_{5}) \\Phi_{b} (c_{62} c_{5}) \\Phi_{b})
335	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cccb,bb)} \\Phi_{b} \\Phi_{b} c_{2} \\Phi_{bcbcb} (c_{62} c_{5}) (\\Phi_{ccc(bbbb,b)} (\\Phi_{(bb,b)} c_{4})) (c_{62} c_{5}) \\Phi_{b})
336	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbbb,bb)} \\Phi_{b} c_{2} \\Phi_{bbcb} (\\Phi_{c(cbbbb,)} (\\Phi_{(bb,b)} c_{5})) (c_{62} c_{5}) \\Phi_{b} (c_{62} c_{5}) \\Phi_{b})
337	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cc(cbbb,bb),bb)} (\\Phi_{(bb,b)} c_{2}) \\Phi_{b} c_{2} (\\Phi_{(bbbb,bb)} c_{2}) \\Phi_{b} \\Phi_{(cccbbbb,b)} (c_{62} c_{5}) \\Phi_{b} (c_{62} c_{5}) \\Phi_{b} (c_{62} c_{5}) \\Phi_{b})
338	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(cbbb,)} c_{2} \\Phi_{cbb} (c_{62} c_{5} (\\Phi_{K} c_{8})) \\Phi_{b})
339	= (\\Phi_{bcb} (\\Phi_{bb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) c_{7} (\\Phi_{(bb,bb)} c_{4})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} c_{5}) \\Phi_{cbb} \\Phi_{b})
340	= (\\Phi_{(b,cb)} (\\Phi_{bcb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) c_{5} (\\Phi_{(bb,(bb,b))} c_{1})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} c_{5}) \\Phi_{b})
341	= (\\Phi_{b(cb,)} (\\Phi_{bb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) c_{4} (\\Phi_{(bb,(bb,b))} c_{1})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} c_{5}) \\Phi_{cbb} \\Phi_{b})
342	= (\\Phi_{cbbbb} (\\Phi_{(bb,b)} c_{2}) \\Phi_{bb} (\\Phi_{bbb} \\Phi_{K}) (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{ccb} \\Phi_{cccb} \\Phi_{K} (\\Phi_{cccb} (\\Phi_{(bb(bb,b),bb)} (c_{62} c_{5}) \\Phi_{K} c_{5})))
343	= (\\Phi_{ccbbbb} (\\Phi_{(bb,bb)} c_{4}) c_{7} \\Phi_{bcb} \\Phi_{bb} (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cccb} \\Phi_{b} \\Phi_{cbcb} (c_{62} c_{5}) (\\Phi_{cccbb} (\\Phi_{(bb,b)} c_{5})))
344	= (\\Phi_{ccbbbb} (\\Phi_{(bb,(bb,b))} c_{1}) c_{5} \\Phi_{(b,cb)} \\Phi_{bcb} (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{cbbcb} \\Phi_{b} \\Phi_{bb} (c_{62} c_{5})))
345	= (\\Phi_{ccbbbb} (\\Phi_{(bb,(bb,b))} c_{1}) c_{4} \\Phi_{b(cb,)} \\Phi_{bb} (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cccb} \\Phi_{b} \\Phi_{cbcb} (c_{62} c_{5}) (\\Phi_{cccbb} (\\Phi_{(bb,b)} c_{5})))
346	= (\\Phi_{ccbbb} \\Phi_{b} \\Phi_{b} (\\Phi_{cc(bbbb,b)} \\Phi_{b} (c_{62} c_{5}) \\Phi_{bcbb} c_{5}) (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cccbb} \\Phi_{b} \\Phi_{cbb} (c_{62} c_{5}) \\Phi_{ccbb} (\\Phi_{(bb,b)} c_{4}))
347	= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} c_{4}) \\Phi_{b})
348	= (\\Phi_{bb} (\\Phi_{bb} (c_{62} c_{4} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} c_{4}) \\Phi_{cbb} \\Phi_{b})
349	= (\\Phi_{cbbbb} (\\Phi_{(bb,b)} c_{5}) \\Phi_{bb} \\Phi_{bb} (c_{62} c_{4}) \\Phi_{b}) (\\Phi_{cccb} \\Phi_{b} \\Phi_{cbcb} (c_{62} c_{4}) (\\Phi_{cccbb} (\\Phi_{(bb,b)} c_{5})))
350	= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{5}) \\Phi_{bccb} (c_{62} c_{4}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{5}) (c_{62} c_{4}) \\Phi_{b})
351	= (\\Phi_{bbbb} \\Phi_{b} c_{5} (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{K} \\Phi_{bb} (c_{62} c_{4}) \\Phi_{b})
352	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(c(bbb,ccbbb),bb)} \\Phi_{b} c_{4} (\\Phi_{cc(cbbbb,)} \\Phi_{cbb} c_{4}) (c_{62} c_{4}) \\Phi_{b} c_{1} c_{2} \\Phi_{cb(bb,bccb)} (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{b} (c_{62} c_{4}) \\Phi_{b})
353	= (\\Phi_{K} c_{9}) (\\Phi_{cbb} (\\Phi_{K} c_{9}) (c_{62} c_{4}) \\Phi_{b})
354	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbbb,b)} (c_{62} c_{4}) (\\Phi_{(bbb,bb)} c_{2}) \\Phi_{b} (\\Phi_{cccbbb} \\Phi_{b}) (c_{62} c_{4}) \\Phi_{b} (\\Phi_{(bb,b)} c_{4}))
355	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(bbb,bbb)} (\\Phi_{(bb,b)} c_{4}) (\\Phi_{ccbb} \\Phi_{b}) (c_{62} c_{4}) \\Phi_{b} (\\Phi_{(bbb,bb)} c_{2}) (c_{62} c_{4}) \\Phi_{b})
356	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cc(cbbb,bb),bb)} (\\Phi_{(bb,b)} c_{2}) \\Phi_{b} c_{2} (\\Phi_{(bbbb,bb)} c_{2}) \\Phi_{b} \\Phi_{(cccbbbb,b)} (c_{62} c_{5}) \\Phi_{b} (c_{62} c_{4}) \\Phi_{b} (c_{62} c_{4}) \\Phi_{b})
357	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bbbb,)} \\Phi_{bb} c_{2} (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{b})
358	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{ccccc(bcbbb,cbbb)} \\Phi_{b} (c_{62} c_{4}) \\Phi_{b} (c_{62} c_{4}) \\Phi_{bcb} \\Phi_{c(bbbb,bb)} \\Phi_{b} \\Phi_{bbb} (c_{62} c_{5}) \\Phi_{b} \\Phi_{cb} (\\Phi_{(bbcb,bb)} c_{2}) (c_{62} c_{5}) \\Phi_{b})
359	= (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} c_{4}) \\Phi_{b})
360	= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) \\Phi_{bb} (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) (c_{62} c_{4}) \\Phi_{b})
361	= (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) \\Phi_{bb} (c_{62} c_{4}) \\Phi_{b})
362	= (\\Phi_{K} T) (\\Phi_{bb} (c_{62} c_{4} (\\Phi_{K} c_{8})) (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{bb} c_{7})))
363	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cb,cb)} (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) \\Phi_{ccb} (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{bcb(cb,b)} (c_{62} c_{4} (\\Phi_{K} c_{8}))))
364	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{ccbcb} c_{15} (\\Phi_{(b(bb,b),b)} c_{1} c_{4}) (\\Phi_{cbbb} c_{15}) (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{bcbbb} (c_{62} c_{4} (\\Phi_{K} c_{8}))))
365	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(ccc(ccb,),)} \\Phi_{b} (c_{62} c_{4}) (\\Phi_{(bbcb,b)} c_{1}) \\Phi_{cb} (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{bcbccbbbb} (c_{62} c_{4} (\\Phi_{K} c_{8}))))
367	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))) (\\Phi_{bb} (\\Phi_{bcb} (\\Phi_{(b,(b,))} (\\Phi_{bcb} (c_{62} c_{4} (\\Phi_{K} c_{8})))) (\\Phi_{(bb(bb,),b)} c_{2})) (\\Phi_{(bb(ccbb,b),cb)} c_{5} (c_{62} c_{5} (\\Phi_{K} c_{8}))))
368	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{bccb} \\Phi_{b} (\\Phi_{(bb,b)} c_{1}) (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{bcbbb} (c_{62} c_{4} (\\Phi_{K} c_{8}))))
369	= (\\Phi_{b(cccb,)} \\Phi_{K} \\Phi_{b} (c_{62} c_{4}) \\Phi_{bcb} (\\Phi_{ccbbbb} \\Phi_{cb})) (\\Phi_{bb} \\Phi_{b} (\\Phi_{bbb} \\Phi_{b}))
370	= (\\Phi_{b(ccb,)} \\Phi_{K} (\\Phi_{(bb,b)} c_{2}) (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) \\Phi_{cbbb}) (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))
372	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccccb,)} (\\Phi_{(bb,b)} c_{1}) c_{15} (\\Phi_{(bb,bbb)} c_{2}) (c_{62} c_{5} (\\Phi_{K} c_{8})) \\Phi_{c(cbb,bb)})
373	= (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} c_{15})) (\\Phi_{(ccb,)} (\\Phi_{(bb,b)} c_{1}) (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) \\Phi_{cbbb})
377	= (\\Phi_{bbb} \\Phi_{K} \\Phi_{K} (\\Phi_{bbb} (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{b})) (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))
378	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))) (\\Phi_{(cb,b)} (\\Phi_{(bbb,bcb)} c_{2}) (\\Phi_{bccc(ccb,)} \\Phi_{b} \\Phi_{b} (c_{62} c_{4} (\\Phi_{K} c_{8})) c_{5}) \\Phi_{c((cbbb,bbbb),)})
403	= (\\Phi_{K} T) (\\Phi_{(b,)} c_{2})
423	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))) (\\Phi_{bbb} (\\Phi_{bbb} \\Phi_{b} \\Phi_{bb}) \\Phi_{bbb} c_{12})
424	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{bbb} \\Phi_{b} \\Phi_{bb} c_{12})
425	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cb,)} (\\Phi_{(b(bb,cb),cb)} c_{2} c_{12}) (\\Phi_{c(c(bb,),)} c_{12}))
426	= (\\Phi_{(ccb,cb)} (\\Phi_{(bbbb,bbb)} c_{4} (c_{62} c_{4} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5}) (\\Phi_{(ccccb,)} (\\Phi_{(bb,b)} c_{5})) (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{c(ccbbb,bb)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} c_{12})))
427	= (\\Phi_{bb} \\Phi_{K} (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{5}) c_{12})) (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))
428	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))) (\\Phi_{bcccc(b,)} (\\Phi_{cbb} c_{12} \\Phi_{bb}) \\Phi_{b} \\Phi_{cbbb} (c_{62} c_{5}) \\Phi_{b} (\\Phi_{(b(bbb,cccbbb),b)} c_{2} (c_{62} c_{4}) \\Phi_{b}))
\.


--
-- Name: purecombstheorems_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.purecombstheorems_id_seq', 428, true);


--
-- Data for Name: resuelve; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.resuelve (id, nombreteorema, numeroteorema, resuelto, loginusuario, teoremaid, categoriaid, variables, teoriaid) FROM stdin;
7	Identity of $\\equiv$	3.3.a	f	AdminTeoremas	7	1	;q	1
146	Distributivity of $\\vee$ over $\\exists$	9.23	f	AdminTeoremas	141	8	x,x,x,x,x,x;R,Q,P	1
127	Trading	9.4.b	f	AdminTeoremas	122	7	x,x,x,x;Q,P,R	1
8	Identity of $\\equiv$	3.3.b	t	AdminTeoremas	8	1	;q	1
135	Body weakening/strengthening	9.11	f	AdminTeoremas	130	7	x,x,x,x;R,P,Q	1
128	Trading	9.4.c	f	AdminTeoremas	123	7	x,x,x,x;Q,R,P	1
11	Definition of $false$	3.8	t	AdminTeoremas	11	2	;	1
165		21	t	AdminTeoremas	160	9	;B,A	2
129	Trading	9.4.d	f	AdminTeoremas	124	7	x,x,x,x;Q,P,R	1
133		9.9	f	AdminTeoremas	128	7	x,x,x,x,x,x;R,Q,P	1
147		9.24	f	AdminTeoremas	142	8	x,x;R	1
150	Monotonicity of $\\exists$	9.27	f	AdminTeoremas	145	8	x,x,x,x,x,x;R,P,Q	1
136	Monotonicity of $\\forall$	9.12	f	AdminTeoremas	131	7	x,x,x,x,x,x;R,P,Q	1
151	$\\exists$-Introduction	9.28	f	AdminTeoremas	146	8	x,x;P,E	1
488		3.74	t	federico	81	5	;p	1
161		17	t	AdminTeoremas	156	9	x,C,C;B	2
134	Range weakening/strengthening	9.10	f	AdminTeoremas	129	7	x,x,x,x;Q,P,R	1
457	Absorption	3.44.b	t	federico	48	4	;q,p	1
820		A.35	f	AdminTeoremas	321	13	;	2
139	Generalized De Morgan	9.18.a	f	AdminTeoremas	134	8	x,x,x,x;R,P	1
137	Instantiation	9.13	f	AdminTeoremas	132	7	x,x;P,e	1
143	Trading	9.20	f	AdminTeoremas	138	8	x,x,x,x;Q,P,R	1
140	Generalized De Morgan	9.18.b	f	AdminTeoremas	135	8	x,x,x,x;R,P	1
148	Range weakening/strengthening	9.25	f	AdminTeoremas	143	8	x,x,x,x;R,Q,P	1
141	Generalized De Morgan	9.18.c	f	AdminTeoremas	136	8	x,x,x,x;R,P	1
144	Distributivity of $\\wedge$ over $\\exists$	9.21	f	AdminTeoremas	139	8	x,x,x,x;R,Q,P	1
152	Interchange of quantifications	9.29	f	AdminTeoremas	147	8	y,y,x,x,x,x,y,y;Q,R,P	1
13	Definition of $\\not\\equiv$	3.10	t	AdminTeoremas	13	2	;q,p	1
460	De Morgan	3.47.b	t	federico	52	4	;q,p	1
459	De Morgan	3.47.a	t	federico	51	4	;q,p	1
461	Exclusive or	3.53	t	federico	63	4	;q,p	1
383	Symmetry of $\\equiv$	3.2.b	f	AdminTeoremas	232	1	;p,q	1
416	Identity of $\\equiv$	3.3.a	t	federico	7	1	;q	1
463	Definition of Implication	3.60	t	federico	67	5	;p,q	1
465		3.66	t	federico	73	5	;q,p	1
14		3.11	f	AdminTeoremas	14	2	;q,p	1
15	Double negation	3.12	f	AdminTeoremas	15	2	;p	1
16	Negation of $false$	3.13	f	AdminTeoremas	16	2	;	1
145		9.22	f	AdminTeoremas	140	8	x,x,x,x;R,P	1
17		3.14	f	AdminTeoremas	17	2	;q,p	1
18		3.15.a	f	AdminTeoremas	18	2	;p	1
19	Symmetry of $\\not\\equiv$	3.16	f	AdminTeoremas	19	2	;p,q	1
462	Replacement	3.51	t	federico	61	4	;q,r,p	1
498	Weakening/strengthening	3.76.b	t	federico	84	5	;p,q	1
20	Associativity of $\\not\\equiv$	3.17	f	AdminTeoremas	20	2	;r,q,p	1
464	Replace by $true$	3.87	t	federico	104	6	;E,p	1
149	Body weakening/strengthening	9.26	f	AdminTeoremas	144	8	x,x,x,x;R,Q,P	1
21	Mutual associativity	3.18	f	AdminTeoremas	21	2	;r,q,p	1
466	Replace by $false$	3.88	t	federico	105	6	;E,p	1
142	Trading	9.19	f	AdminTeoremas	137	8	x,x,x,x;P,R	1
22	Mutual interchangeability	3.19	f	AdminTeoremas	22	2	;r,q,p	1
23	Symmetry of $\\vee$	3.24	t	AdminTeoremas	23	3	;p,q	1
24	Associativity of $\\vee$	3.25	t	AdminTeoremas	24	3	;r,q,p	1
25	Idempotency of $\\vee$	3.26	t	AdminTeoremas	25	3	;p	1
818		A.33	t	AdminTeoremas	319	13	;	2
10	Reflexivity of $\\equiv$	3.5	t	AdminTeoremas	10	1	;q	1
122	Trading	9.2	t	AdminTeoremas	117	7	x,x,x,x;P,R	1
130	Distributivity of $\\vee$ over $\\forall$	9.5	t	AdminTeoremas	125	7	x,x,x,x;R,Q,P	1
123	Trading	9.3.a	f	AdminTeoremas	118	7	x,x,x,x;P,R	1
138	Generalized De Morgan	9.17	t	AdminTeoremas	133	8	x,x,x,x;R,P	1
124	Trading	9.3.b	f	AdminTeoremas	119	7	x,x,x,x;R,P	1
131		9.6	f	AdminTeoremas	126	7	x,x,x,x;R,P	1
125	Trading	9.3.c	f	AdminTeoremas	120	7	x,x,x,x;P,R	1
819		A.34	t	AdminTeoremas	320	13	;	2
126	Trading	9.4.a	f	AdminTeoremas	121	7	y,y,y,y;Q,P,R,x	1
688		3.83.b	f	AdminTeoremas	243	6	;E,e,f	1
689		3.83.b	t	federico	243	6	;E,e,f	1
107	Extension	1.a	t	AdminTeoremas	107	9	x,x;B,A	2
132	Distributivity of $\\wedge$ over $\\forall$	9.7	f	AdminTeoremas	127	7	x,x,x,x,x,x;R,Q,P	1
744		30	t	federico	184	10	;x	2
745		3.48.b	t	federico	54	4	;p,q	1
827		A.32	f	AdminTeoremas	323	13	;	2
527		88	f	federico	238	12	x,x;P,Q,R	1
781		3.82.8	f	AdminTeoremas	296	5	;r,q,p	1
792		3.82.14	f	AdminTeoremas	302	5	;q,r,p	1
793		3.82.15	f	AdminTeoremas	303	5	;q,r,p	1
794		3.82.16	f	AdminTeoremas	304	5	;q,r,p	1
808		A.27	t	AdminTeoremas	310	13	;p,q	2
1	Associativity of $\\equiv$	3.1	t	AdminTeoremas	1	1	;r,q,p	1
2	Symmetry of $\\equiv$	3.2.a	t	AdminTeoremas	2	1	;p,q	1
29	Identity of $\\vee$	3.30.a	f	AdminTeoremas	29	3	;p	1
41	Identity of $\\wedge$	3.39.a	f	AdminTeoremas	41	4	;p	1
30	Distributivity of $\\vee$ over $\\vee$	3.31	f	AdminTeoremas	30	3	;r,p,q	1
39	Associativity of $\\wedge$	3.37	f	AdminTeoremas	39	4	;r,q,p	1
72	Shunting	3.65	f	AdminTeoremas	72	5	;r,q,p	1
73		3.66	f	AdminTeoremas	73	5	;q,p	1
166		22	t	AdminTeoremas	161	9	;A,B	2
474	Reflexivity of $\\Rightarrow$	3.71	t	federico	78	5	;p	1
528		99	f	federico	239	12	x,x;x,y	1
5	Symmetry of $\\equiv$	3.2.d	f	AdminTeoremas	5	1	;p,q	1
31		3.32.a	f	AdminTeoremas	31	3	;p,q	1
475	Right zero of $\\Rightarrow$	3.72	t	federico	79	5	;p	1
32		3.32.b	f	AdminTeoremas	32	3	;p,q	1
33	Golden rule	3.35.a	f	AdminTeoremas	33	4	;q,p	1
34	Golden rule	3.35.b	t	AdminTeoremas	34	4	;q,p	1
35	Golden rule	3.35.c	f	AdminTeoremas	35	4	;q,p	1
6	Symmetry of $\\equiv$	3.2.e	f	AdminTeoremas	6	1	;p,q	1
9		3.3	f	AdminTeoremas	9	1	;	1
809		A.28	f	AdminTeoremas	311	13	;z,x,y	2
26	Distributivity of $\\vee$ over $\\equiv$	3.27	t	AdminTeoremas	26	3	;r,p,q	1
66	Definition of Implication	3.59	f	AdminTeoremas	66	5	;q,p	1
167		23	t	AdminTeoremas	162	9	;b,a	2
863		A.35	t	federico	321	13	;	2
67	Definition of Implication	3.60	f	AdminTeoremas	67	5	;p,q	1
27	Excluded Middle	3.28	t	AdminTeoremas	27	3	;p	1
168		25	t	AdminTeoremas	163	9	;A,B	2
169		27	t	AdminTeoremas	164	9	;x	2
36	Golden rule	3.35.d	f	AdminTeoremas	36	4	;q,p	1
650		3.69	t	federico	76	5	;p,q	1
37	Golden rule	3.35.e	f	AdminTeoremas	37	4	;q,p	1
417	Symmetry of $\\equiv$	3.2.b	t	federico	232	1	;p,q	1
28	Zero of $\\vee$	3.29.a	f	AdminTeoremas	28	3	;p	1
171		10.2	f	AdminTeoremas	165	10	B,B,A,A;	2
38	Symmetry of $\\wedge$	3.36	f	AdminTeoremas	38	4	;p,q	1
163		19	t	AdminTeoremas	158	9	x,x;B,A	2
40	Idempotency of $\\wedge$	3.38	f	AdminTeoremas	40	4	;p	1
109	Empty set	2	t	AdminTeoremas	108	9	A,A,x,x;	2
42	Zero of $\\wedge$	3.40.a	f	AdminTeoremas	42	4	;p	1
111	Pairs	4	t	AdminTeoremas	110	9	A,A,x,x;b,a	2
43	Distributivity of $\\wedge$ over $\\wedge$	3.41	f	AdminTeoremas	43	4	;r,p,q	1
44	Contradiction	3.42	f	AdminTeoremas	44	4	;p	1
173		26	t	AdminTeoremas	167	9	x,a,a,b,b;B,A	2
45	Absorption	3.43.a	f	AdminTeoremas	45	4	;p,q	1
46	Absorption	3.43.b	f	AdminTeoremas	46	4	;p,q	1
154	Empty symbol	11	t	AdminTeoremas	149	9	;x	2
47	Absorption	3.44.a	f	AdminTeoremas	47	4	;q,p	1
810		A.29	f	AdminTeoremas	312	13	;t,w	2
48	Absorption	3.44.b	f	AdminTeoremas	48	4	;q,p	1
49	Distributivity of $\\vee$ over $\\wedge$	3.45	f	AdminTeoremas	49	4	;r,p,q	1
50	Distributivity of $\\wedge$ over $\\vee$	3.46	f	AdminTeoremas	50	4	;r,p,q	1
51	De Morgan	3.47.a	f	AdminTeoremas	51	4	;q,p	1
52	De Morgan	3.47.b	f	AdminTeoremas	52	4	;q,p	1
53		3.48.a	f	AdminTeoremas	53	4	;p,q	1
54		3.48.b	f	AdminTeoremas	54	4	;p,q	1
55		3.49.a	f	AdminTeoremas	55	4	;p,r,q	1
56		3.49.b	f	AdminTeoremas	56	4	;p,r,q	1
57		3.49.c	f	AdminTeoremas	57	4	;p,r,q	1
58		3.49.d	f	AdminTeoremas	58	4	;p,r,q	1
59		3.49.e	f	AdminTeoremas	59	4	;p,r,q	1
60		3.50	f	AdminTeoremas	60	4	;q,p	1
61	Replacement	3.51	f	AdminTeoremas	61	4	;q,r,p	1
62	Definition of $\\equiv$	3.52	f	AdminTeoremas	62	4	;q,p	1
63	Exclusive or	3.53	f	AdminTeoremas	63	4	;q,p	1
64	Definition of Implication	3.57	t	AdminTeoremas	64	5	;q,p	1
65	Consequence	3.58	t	AdminTeoremas	65	5	;p,q	1
68	Contrapositive	3.61	f	AdminTeoremas	68	5	;p,q	1
69		3.62	f	AdminTeoremas	69	5	;r,p,q	1
70	Distributivity of $\\Rightarrow$ over $\\equiv$	3.63	f	AdminTeoremas	70	5	;r,p,q	1
71		3.64	f	AdminTeoremas	71	5	;r,p,q	1
74		3.67	f	AdminTeoremas	74	5	;p,q	1
153		10	t	AdminTeoremas	148	9	;A,x	2
162		18	t	AdminTeoremas	157	9	x;B,A	2
164		20	t	AdminTeoremas	159	9	;A,B	2
705	Distributivity of $\\Rightarrow$ over $\\equiv$	3.63	t	federico	70	5	;r,p,q	1
862		A.32	t	federico	323	13	;	2
856	Weakening/strengthening	3.76.c	t	federico	85	5	;q,p	1
782		3.82.9	f	AdminTeoremas	297	5	;q,p	1
795		3.82.17	f	AdminTeoremas	305	5	;r,q,p	1
426	Symmetry of $\\not\\equiv$	3.16	t	federico	19	2	;p,q	1
170	Extension	1.b	f	AdminTeoremas	449	9	x,x;B,A	2
895	Change of dummy	8.22	f	AdminTeoremas	356	12	y,y,x,x;s,R,f,P	1
101	Replace by $true$	3.85.b	f	AdminTeoremas	101	6	;E,p,q	1
373	Distributivity	8.15	t	AdminTeoremas	231	12	x,x,x,x,x,x;s,R,Q,P	1
75		3.68	f	AdminTeoremas	75	5	;q,p	1
76		3.69	f	AdminTeoremas	76	5	;p,q	1
102	Replace by $false$	3.86.a	f	AdminTeoremas	102	6	;p,E	1
103	Replace by $false$	3.86.b	f	AdminTeoremas	103	6	;q,p,E	1
77		3.70	f	AdminTeoremas	77	5	;q,p	1
78	Reflexivity of $\\Rightarrow$	3.71	f	AdminTeoremas	78	5	;p	1
79	Right zero of $\\Rightarrow$	3.72	f	AdminTeoremas	79	5	;p	1
80	Left identity of $\\Rightarrow$	3.73	f	AdminTeoremas	80	5	;p	1
81		3.74	f	AdminTeoremas	81	5	;p	1
82		3.75	f	AdminTeoremas	82	5	;p	1
83	Weakening/strengthening	3.76.a	f	AdminTeoremas	83	5	;q,p	1
84	Weakening/strengthening	3.76.b	f	AdminTeoremas	84	5	;p,q	1
104	Replace by $true$	3.87	f	AdminTeoremas	104	6	;E,p	1
85	Weakening/strengthening	3.76.c	f	AdminTeoremas	85	5	;q,p	1
96	Leibniz	3.83.a	t	AdminTeoremas	96	6	;E,f,e	1
115	Infinity	7	t	AdminTeoremas	114	9	A,A,x,x;	2
86	Weakening/strengthening	3.76.d	f	AdminTeoremas	86	5	;q,p,r	1
87	Weakening/strengthening	3.76.e	f	AdminTeoremas	87	5	;r,q,p	1
105	Replace by $false$	3.88	f	AdminTeoremas	105	6	;E,p	1
106	Shannon	3.89	f	AdminTeoremas	106	6	;E,p	1
98	Substitution	3.84.b	t	AdminTeoremas	98	6	;E,f,e	1
156		13.a	t	AdminTeoremas	151	9	;a,x	2
114	Foundation	6	t	AdminTeoremas	113	9	B,B,x,x;A	2
159		15	t	AdminTeoremas	154	9	;B,A	2
160		16	t	AdminTeoremas	155	9	x;B,A	2
157		13.b	t	AdminTeoremas	152	9	;b,x,a	2
235		3.15.b	f	AdminTeoremas	169	2	;p	1
88	Modus ponens	3.77	f	AdminTeoremas	88	5	;q,p	1
237	Weakening/strengthening	3.76.f	f	AdminTeoremas	170	5	;q,p	1
158		14	t	AdminTeoremas	153	9	C,C;B,x	2
89		3.78	f	AdminTeoremas	89	5	;r,q,p	1
706		A.1	t	AdminTeoremas	244	13	;a	2
90		3.79	f	AdminTeoremas	90	5	;r,p	1
843		A.36	t	AdminTeoremas	324	13	;x	2
418	Symmetry of $\\equiv$	3.2.c	t	federico	4	1	;p,q	1
419	Symmetry of $\\equiv$	3.2.d	t	federico	5	1	;p,q	1
121		9.8	f	AdminTeoremas	116	7	x,x;R	1
91	Mutual implication	3.80	t	AdminTeoremas	91	5	;q,p	1
92	Antisymmetry	3.81	f	AdminTeoremas	92	5	;q,p	1
93	Transitivity	3.82.a	f	AdminTeoremas	93	5	;r,p,q	1
94	Transitivity	3.82.b	f	AdminTeoremas	94	5	;r,p,q	1
95	Transitivity	3.82.c	f	AdminTeoremas	95	5	;r,p,q	1
97	Substitution	3.84.a	f	AdminTeoremas	97	6	;E,f,e	1
476	Contrapositive	3.61	t	federico	68	5	;p,q	1
99	Substitution	3.84.c	f	AdminTeoremas	99	6	;E,f,e,q	1
100	Replace by $true$	3.85.a	f	AdminTeoremas	100	6	;E,p	1
477		3.62	t	federico	69	5	;r,p,q	1
478	Weakening/strengthening	3.76.a	t	federico	83	5	;q,p	1
774		3.82.1	f	AdminTeoremas	289	5	;r,q,p	1
788		3.82.10	f	AdminTeoremas	298	5	;r,q,p	1
796		3.82.18	f	AdminTeoremas	306	5	;q,p	1
155		12	t	AdminTeoremas	150	9	x;P,y,U	2
523		3.68	t	federico	75	5	;q,p	1
805	Transitivity	3.82.a	t	federico	93	5	;r,p,q	1
113	Union	5	t	AdminTeoremas	112	9	A,A,x,x,C,C;B	2
804		3.82.d	t	federico	307	5	;r,p,q	1
116	Parts	8	t	AdminTeoremas	115	9	A,A,x,x;B	2
812		A.30	t	AdminTeoremas	314	13	;	2
112	Separation	3	t	AdminTeoremas	111	9	A,A,x,x;P,U	2
813		A.31	f	AdminTeoremas	315	13	;	2
889	Empty range	8.13	t	AdminTeoremas	350	12	x,x;u,s,P	1
864		3.76.cc	t	federico	330	5	;q,p	2
894	Interchange of dummies	8.19.a	t	AdminTeoremas	355	12	y,y,x,x,y,y,x,x;s,Q,R,P	1
918	Symmetry of $\\equiv$	3.2.e	t	prueba	6	1	;p,q	1
412		3.3	t	federico	9	1	;	1
900		3.82.2	t	federico	290	5	;r,q,p	1
901		3.82.10	f	federico	298	5	;r,q,p	1
902		3.82.5	t	federico	293	5	;q,r,p	1
469		8	f	federico	234	12	x,x;Q,R,P	1
914	Identity of $\\equiv$	3.3.a	t	prueba	7	1	;q	1
915		3.3	t	prueba	9	1	;	1
916	Symmetry of $\\equiv$	3.2.b	t	prueba	232	1	;p,q	1
917	Symmetry of $\\equiv$	3.2.d	t	prueba	5	1	;p,q	1
919		3.11	t	prueba	14	2	;q,p	1
920	Double negation	3.12	t	prueba	15	2	;p	1
921	Negation of $false$	3.13	t	prueba	16	2	;	1
922		3.14	t	prueba	17	2	;q,p	1
923		3.15.b	t	prueba	169	2	;p	1
924		3.15.a	t	prueba	18	2	;p	1
925	Zero of $\\vee$	3.29	t	prueba	28	3	;p	1
926	Identity of $\\vee$	3.30	t	prueba	29	3	;p	1
927	Distributivity of $\\vee$ over $\\vee$	3.31	t	prueba	30	3	;r,p,q	1
929		3.32.b	t	prueba	32	3	;p,q	1
928		3.32.a	t	prueba	31	3	;p,q	1
333		57	f	AdminTeoremas	211	10	a,a,b,b;B,A,x	2
301		10.4	f	AdminTeoremas	452	10	a,a,b,b,A,A,B,B,x,x,x,x;	2
720		AT.10	t	AdminTeoremas	258	14	;	2
302		10.5	f	AdminTeoremas	453	10	B,B,A,A,D,D,x,x,C,C,x,x,C,C;	2
307		31	f	AdminTeoremas	185	10	C,C;B,x	2
719		AT.1	t	AdminTeoremas	257	14	;	2
304		28	f	AdminTeoremas	182	10	;B,x,A	2
305		29	f	AdminTeoremas	183	10	;B,x,A	2
306		30	f	AdminTeoremas	184	10	;x	2
721		AT.19	t	AdminTeoremas	259	14	;	2
308		32	f	AdminTeoremas	186	10	;B,x,A	2
309		33	f	AdminTeoremas	187	10	;	2
310		34	f	AdminTeoremas	188	10	;	2
311		35	f	AdminTeoremas	189	10	;A,B	2
312		36	f	AdminTeoremas	190	10	;B,A	2
314		38	f	AdminTeoremas	192	10	;C,A,B	2
317		41	f	AdminTeoremas	195	10	;A,B	2
318		42	f	AdminTeoremas	196	10	;B,A	2
321		45	f	AdminTeoremas	199	10	;B,A	2
319		43	f	AdminTeoremas	197	10	;C,B,A	2
320		44	f	AdminTeoremas	198	10	;	2
323		47	f	AdminTeoremas	201	10	;A	2
322		46	f	AdminTeoremas	200	10	;B,A	2
330		54	f	AdminTeoremas	208	10	;a,b	2
324		48	f	AdminTeoremas	202	10	;A	2
325		49	f	AdminTeoremas	203	10	;A	2
662		3.75	t	federico	82	5	;p	1
722		AT.28	t	AdminTeoremas	260	14	;	2
723		AT.37	t	AdminTeoremas	261	14	;	2
328		52	f	AdminTeoremas	206	10	;b,a	2
329		53	f	AdminTeoremas	207	10	;a,b	2
336		60	f	AdminTeoremas	214	10	x,x,x,x;B,A	2
331		55	f	AdminTeoremas	209	10	;b,a	2
332		56	f	AdminTeoremas	210	10	;d,b,c,a	2
338		62	f	AdminTeoremas	216	10	a,a,b,b;x,B,A	2
334		58	f	AdminTeoremas	212	10	;B,b,A,a	2
335		59	f	AdminTeoremas	213	10	;B,A	2
303		10.6	f	AdminTeoremas	181	10	B,B,A,A,C,C,x,x,x,x;	2
337		61	f	AdminTeoremas	215	10	;B,A	2
724		AT.46	t	AdminTeoremas	262	14	;	2
725		AT.55	t	AdminTeoremas	263	14	;	2
339		63	f	AdminTeoremas	217	10	;C,A,B	2
340		64	f	AdminTeoremas	218	10	;S,R,w	2
326		50	f	AdminTeoremas	204	10	A,A,B,B;	2
342		66	f	AdminTeoremas	220	10	;A,C,B	2
343		67	f	AdminTeoremas	221	10	;S,R	2
350	Reflexivity of $=$	3.83.c	t	AdminTeoremas	226	6	;q	1
341		65	f	AdminTeoremas	219	10	x,x,y,y,z,z;S,R,w	2
327		51	f	AdminTeoremas	205	10	A,A,B,B,C,C;	2
470		3.48.a	t	federico	53	4	;p,q	1
726		AT.64	t	AdminTeoremas	264	14	;	2
428	Mutual associativity	3.18	t	federico	21	2	;r,q,p	1
429	Mutual interchangeability	3.19	t	federico	22	2	;r,q,p	1
430		3.15.a	t	federico	18	2	;p	1
485	Modus ponens	3.77	t	federico	88	5	;q,p	1
344		27.a	f	AdminTeoremas	237	9	x,y,y;R	2
431		3.15.b	t	federico	169	2	;p	1
710		A.3	t	AdminTeoremas	248	13	;a,b	2
345		27.b	f	AdminTeoremas	223	9	y,x,x;R	2
711		A.4	t	AdminTeoremas	249	13	;c,b,a	2
712		A.5	t	AdminTeoremas	250	13	;a	2
313		37	f	AdminTeoremas	467	10	x,x;A	2
420	Symmetry of $\\equiv$	3.2.e	t	federico	6	1	;p,q	1
421		3.11	t	federico	14	2	;q,p	1
422	Double negation	3.12	t	federico	15	2	;p	1
423	Negation of $false$	3.13	t	federico	16	2	;	1
424		3.14	t	federico	17	2	;q,p	1
713		A.6	t	AdminTeoremas	251	13	;a	2
315		39	f	AdminTeoremas	193	10	;B,A	2
427	Associativity of $\\not\\equiv$	3.17	t	federico	20	2	;r,q,p	1
434		3.32.a	t	federico	31	3	;p,q	1
435		3.32.b	t	federico	32	3	;p,q	1
433	Distributivity of $\\vee$ over $\\vee$	3.31	t	federico	30	3	;r,p,q	1
346		68	f	AdminTeoremas	224	10	y,y;R,z	2
316		40	f	AdminTeoremas	194	10	C,C;A,B	2
347		69	f	AdminTeoremas	225	10	x,x;R,z	2
299		10.1	f	AdminTeoremas	450	10	A,A,B,B,x,x,x,x;	2
300		10.3	f	AdminTeoremas	451	10	U,U,A,A,B,B,x,x,x,x;P	2
715		A.8	t	AdminTeoremas	253	13	;a,b	2
716		A.9	t	AdminTeoremas	254	13	;c,b,a	2
717		A.10	t	AdminTeoremas	255	13	;c,a,b	2
718		A.11	f	AdminTeoremas	256	13	;a,c,b	2
714		A.7	f	AdminTeoremas	252	13	;a	2
707		A.2	f	AdminTeoremas	245	13	;a	2
727		A.20	t	AdminTeoremas	265	13	;b,a	2
729		A.2	t	federico	245	13	;a	2
775		3.82.2	f	AdminTeoremas	290	5	;r,q,p	1
776		3.82.3	f	AdminTeoremas	291	5	;r,q,p	1
777		3.82.4	f	AdminTeoremas	292	5	;q,r,p	1
778		3.82.5	f	AdminTeoremas	293	5	;q,r,p	1
779		3.82.6	f	AdminTeoremas	294	5	;q,r,p	1
12	Distributivity of $\\neg$ over $\\equiv$	3.9	t	AdminTeoremas	12	2	;q,p	1
370	One-point rule	8.14	t	AdminTeoremas	229	12	x,x,x;P,E,s	1
453	Definition of $\\equiv$	3.52	t	federico	62	4	;q,p	1
446	Definition of Implication	3.59	t	federico	66	5	;q,p	1
644	Shunting	3.65	t	federico	72	5	;r,q,p	1
533		3.67	t	federico	74	5	;p,q	1
891	Range split for idempotent	8.18	t	AdminTeoremas	352	12	x,x,x,x,x,x;s,S,P,R	1
911	Substitution	3.84.a	t	federico	97	6	;E,f,e	1
896		8.21	t	AdminTeoremas	357	12	;f,x,y	1
436	Symmetry of $\\wedge$	3.36	t	federico	38	4	;p,q	1
437	Associativity of $\\wedge$	3.37	t	federico	39	4	;r,q,p	1
438	Idempotency of $\\wedge$	3.38	t	federico	40	4	;p	1
439	Identity of $\\wedge$	3.39	t	federico	41	4	;p	1
440	Zero of $\\wedge$	3.40	t	federico	42	4	;p	1
441	Distributivity of $\\wedge$ over $\\wedge$	3.41	t	federico	43	4	;r,p,q	1
442	Contradiction	3.42	t	federico	44	4	;p	1
443	Distributivity of $\\vee$ over $\\wedge$	3.45	t	federico	49	4	;r,p,q	1
445		3.50	t	federico	60	4	;q,p	1
444	Distributivity of $\\wedge$ over $\\vee$	3.46	t	federico	50	4	;r,p,q	1
448	Golden rule	3.35.a	t	federico	33	4	;q,p	1
449	Golden rule	3.35.c	t	federico	35	4	;q,p	1
450	Golden rule	3.35.d	t	federico	36	4	;q,p	1
451	Golden rule	3.35.e	t	federico	37	4	;q,p	1
454	Absorption	3.43.a	t	federico	45	4	;p,q	1
455	Absorption	3.43.b	t	federico	46	4	;p,q	1
456	Absorption	3.44.a	t	federico	47	4	;q,p	1
497	Antisymmetry	3.81	t	federico	92	5	;q,p	1
898	Nesting	8.20	t	AdminTeoremas	358	12	x,x,y,y,x,x,y,y;s,R,Q,P	1
807		A.26	t	AdminTeoremas	309	13	;c,a,b	2
899	Interchange of dummies	8.19.b	t	AdminTeoremas	359	12	y,y,x,x,x,x,y,y;s,Q,P	1
897	Change of dummy	8.22	t	federico	356	12	y,y,x,x;s,R,f,P	1
526	Left identity of $\\Rightarrow$	3.73	t	federico	80	5	;p	1
730		A.7	t	federico	252	13	;a	2
643		PCA2	f	federico	242	5	;P,D,C	1
731		A.11	t	federico	256	13	;a,c,b	2
734		A.21	t	federico	267	13	;	2
735		A.22	f	AdminTeoremas	268	13	;b,a	2
736		A.22	t	federico	268	13	;b,a	2
960		AT.18	f	AdminTeoremas	389	14	;	2
739		A.23	f	AdminTeoremas	270	13	;a	2
740		A.24	f	AdminTeoremas	271	13	;a	2
742		A.24	t	federico	271	13	;a	2
945		AT.2	f	AdminTeoremas	374	14	;	2
930	Golden rule	3.35.a	t	prueba	33	4	;q,p	1
780		3.82.7	f	AdminTeoremas	295	5	;q,r,p	1
789		3.82.11	f	AdminTeoremas	299	5	;r,q,p	1
790		3.82.12	f	AdminTeoremas	300	5	;r,q,p	1
791		3.82.13	f	AdminTeoremas	301	5	;q,r,p	1
797		3.82.d	f	AdminTeoremas	307	5	;r,p,q	1
931	Golden rule	3.35.c	t	prueba	35	4	;q,p	1
806		A.25	t	AdminTeoremas	308	13	;	2
932	Golden rule	3.35.d	t	prueba	36	4	;q,p	1
933	Golden rule	3.35.e	t	prueba	37	4	;q,p	1
934	Symmetry of $\\wedge$	3.36	t	prueba	38	4	;p,q	1
935	Idempotency of $\\wedge$	3.38	t	prueba	40	4	;p	1
861		A.31	t	federico	315	13	;	2
865		A.23	t	federico	270	13	;a	2
890	Range split	8.17	t	AdminTeoremas	351	12	x,x,x,x,x,x,x,x;s,S,P,R	1
936	Associativity of $\\wedge$	3.37	t	prueba	39	4	;r,q,p	1
937	Identity of $\\wedge$	3.39	t	prueba	41	4	;p	1
938	Definition of Implication	3.59	t	prueba	66	5	;q,p	1
939	Transitivity	3.82.a	f	prueba	93	5	;r,p,q	1
946		AT.3	f	AdminTeoremas	375	14	;	2
961		AT.20	f	AdminTeoremas	390	14	;	2
947		AT.4	f	AdminTeoremas	376	14	;	2
948		AT.5	f	AdminTeoremas	377	14	;	2
949		AT.6	f	AdminTeoremas	378	14	;	2
950		AT.7	f	AdminTeoremas	379	14	;	2
951		AT.8	f	AdminTeoremas	380	14	;	2
952		AT.9	f	AdminTeoremas	381	14	;	2
953		AT.11	f	AdminTeoremas	382	14	;	2
954		AT.12	f	AdminTeoremas	383	14	;	2
955		AT.13	f	AdminTeoremas	384	14	;	2
956		AT.14	f	AdminTeoremas	385	14	;	2
957		AT.15	f	AdminTeoremas	386	14	;	2
958		AT.16	f	AdminTeoremas	387	14	;	2
959		AT.17	f	AdminTeoremas	388	14	;	2
962		AT.21	f	AdminTeoremas	391	14	;	2
964		AT.23	f	AdminTeoremas	393	14	;	2
965		AT.24	f	AdminTeoremas	394	14	;	2
966		AT.25	f	AdminTeoremas	395	14	;	2
967		AT.26	f	AdminTeoremas	396	14	;	2
968		AT.27	f	AdminTeoremas	397	14	;	2
969		AT.29	f	AdminTeoremas	398	14	;	2
970		AT.30	f	AdminTeoremas	399	14	;	2
971		AT.31	f	AdminTeoremas	400	14	;	2
972		AT.32	f	AdminTeoremas	401	14	;	2
973		AT.33	f	AdminTeoremas	402	14	;	2
974		AT.34	f	AdminTeoremas	403	14	;	2
963		AT.22	f	AdminTeoremas	392	14	;	2
472		9	f	federico	235	12	x,x;x,y	1
869		9.4.e	t	AdminTeoremas	332	7	x,x,x,x,x,x;Q,P,R	1
892	Range split	8.16	t	AdminTeoremas	353	12	x,x,x,x,x,x,x,x;s,S,P,R	1
975		AT.35	f	AdminTeoremas	404	14	;	2
976		AT.36	f	AdminTeoremas	405	14	;	2
977		AT.38	f	AdminTeoremas	406	14	;	2
978		AT.39	f	AdminTeoremas	407	14	;	2
979		AT.40	f	AdminTeoremas	408	14	;	2
980		AT.41	f	AdminTeoremas	409	14	;	2
981		AT.42	f	AdminTeoremas	410	14	;	2
982		AT.43	f	AdminTeoremas	411	14	;	2
983		AT.44	f	AdminTeoremas	412	14	;	2
984		AT.45	f	AdminTeoremas	413	14	;	2
985		AT.47	f	AdminTeoremas	414	14	;	2
986		AT.48	f	AdminTeoremas	415	14	;	2
987		AT.49	f	AdminTeoremas	416	14	;	2
988		AT.50	f	AdminTeoremas	417	14	;	2
989		AT.51	f	AdminTeoremas	418	14	;	2
990		AT.52	f	AdminTeoremas	419	14	;	2
991		AT.53	f	AdminTeoremas	420	14	;	2
992		AT.54	f	AdminTeoremas	421	14	;	2
993		AT.56	f	AdminTeoremas	422	14	;	2
994		AT.57	f	AdminTeoremas	423	14	;	2
995		AT.58	f	AdminTeoremas	424	14	;	2
996		AT.59	f	AdminTeoremas	425	14	;	2
997		AT.60	f	AdminTeoremas	426	14	;	2
998		AT.61	f	AdminTeoremas	427	14	;	2
999		AT.62	f	AdminTeoremas	428	14	;	2
1000		AT.63	f	AdminTeoremas	429	14	;	2
1001		AT.65	f	AdminTeoremas	430	14	;	2
1002		AT.66	f	AdminTeoremas	431	14	;	2
1003		AT.67	f	AdminTeoremas	432	14	;	2
1004		AT.68	f	AdminTeoremas	433	14	;	2
1005		AT.69	f	AdminTeoremas	434	14	;	2
1006		AT.70	f	AdminTeoremas	435	14	;	2
1007		AT.71	f	AdminTeoremas	436	14	;	2
1008		AT.72	f	AdminTeoremas	437	14	;	2
733		AT.73	f	AdminTeoremas	438	14	;	2
1009		AT.74	f	AdminTeoremas	439	14	;	2
1010		AT.75	f	AdminTeoremas	440	14	;	2
1011		AT.76	f	AdminTeoremas	441	14	;	2
1012		AT.77	f	AdminTeoremas	442	14	;	2
1013		AT.78	f	AdminTeoremas	443	14	;	2
1014		AT.79	f	AdminTeoremas	444	14	;	2
1015		AT.80	f	AdminTeoremas	445	14	;	2
1016		AT.81	f	AdminTeoremas	446	14	;	2
1017		AT.82	f	federico	447	14	;	2
1018		AT.29	t	federico	398	14	;	2
1019		AT.30	t	federico	399	14	;	2
1020		AT.31	t	federico	400	14	;	2
1021		AT.32	t	federico	401	14	;	2
1022		AT.33	t	federico	402	14	;	2
1023		AT.34	t	federico	403	14	;	2
1026	Weakening/strengthening	3.76.d	t	federico	86	5	;q,p,r	1
1060	Identity of $\\wedge$	3.39.b	f	AdminTeoremas	462	4	;p	1
1039	Weakening/strengthening	3.76.e	t	federico	87	5	;r,q,p	1
1061	Zero of $\\vee$	3.29.a	t	federico	28	3	;p	1
1034		3.82.4	f	federico	292	5	;q,r,p	1
1035	Trading	9.3.a	t	federico	118	7	x,x,x,x;P,R	1
1036		9.6	t	federico	126	7	x,x,x,x;R,P	1
1041	Weakening/strengthening	3.76.g	f	AdminTeoremas	455	5	;p	1
1042	Weakening/strengthening	3.76.g	t	federico	455	5	;p	1
1030	Weakening/strengthening	3.76.f	t	federico	170	5	;q,p	1
1063	Identity of $\\vee$	3.30.a	t	federico	29	3	;p	1
1045		9.8	t	federico	116	7	x,x;R	1
1046	Instantiation	9.13	t	federico	132	7	x,x;P,e	1
1070		3.83.f	t	AdminTeoremas	466	6	;y,x	1
1048		10.1	t	federico	450	10	A,A,B,B,x,x,x,x;	2
1049		28	t	federico	182	10	;B,x,A	2
1050		29	t	federico	183	10	;B,x,A	2
1051		32	t	federico	186	10	;B,x,A	2
1052		35	f	federico	189	10	;A,B	2
1053		33	f	federico	187	10	;	2
1054		36	t	federico	190	10	;B,A	2
473		8.p	t	federico	236	8	x,y,x,x,x,x;Q,P	1
1058	Identity of $\\vee$	3.30.b	f	AdminTeoremas	460	3	;p	1
1059	Zero of $\\wedge$	3.40.b	f	AdminTeoremas	461	4	;p	1
1064	Identity of $\\vee$	3.30.b	t	federico	460	3	;p	1
1057	Zero of $\\vee$	3.29.b	f	AdminTeoremas	463	3	;p	1
1065	Zero of $\\vee$	3.29.b	t	federico	463	3	;p	1
1066		9.9	f	federico	128	7	x,x,x,x,x,x;R,Q,P	1
1071		37	t	federico	467	10	x,x;A	2
1068	Leibniz	3.83.e	t	AdminTeoremas	465	6	;E,f,e	1
1067	Leibniz	3.83.d	t	AdminTeoremas	464	6	;E,f,e	1
1072		39	f	federico	193	10	;B,A	2
1047	Extension	1.b	t	federico	449	9	x,x;B,A	2
1073	Trading	9.19	t	federico	137	8	x,x,x,x;P,R	1
1074	Trading	9.20	t	federico	138	8	x,x,x,x;Q,P,R	1
1075	Distributivity of $\\wedge$ over $\\exists$	9.21	t	federico	139	8	x,x,x,x;R,Q,P	1
1076		9.22	t	federico	140	8	x,x,x,x;R,P	1
1077		9.24	t	federico	142	8	x,x;R	1
1078	$\\exists$-Introduction	9.28	t	federico	146	8	x,x;P,E	1
1079	Distributivity of $\\wedge$ over $\\forall$	9.7	f	federico	127	7	x,x,x,x,x,x;R,Q,P	1
\.


--
-- Name: resuelve_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.resuelve_id_seq', 1079, true);


--
-- Data for Name: simbolo; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid, tipo) FROM stdin;
63	  	2	f	3	9	[ %(na2) \\ldots %(na1) ]	2	t->t->t
64	-	1	f	3	9	%(op) %(aa1)	2	t->t
65	<	2	f	3	7	%(na2) %(op) %(na1)	2	t->t->p
67	>	2	f	3	7	%(na2) %(op) %(na1)	2	t->t->p
68	\\geq	2	f	3	7	%(na2) %(op) %(na1)	2	t->t->p
66	\\leq	2	f	3	7	%(na2) %(op) %(na1)	2	t->t->p
12	\\neq	2	f	3	7	%(na2) %(op) %(na1)	1	t->t->p
13	\\star	2	f	3	9	%(na2) %(op) %(na1)	1	x1->x1->x1
2	\\Rightarrow	2	t	3	2	%(a2) %(op) %(aa1)	1	p->p->p
3	\\Leftarrow	2	t	0	2	%(aa2) %(op) %(a1)	1	p->p->p
4	\\vee	2	t	4	3	%(a2) %(op) %(a1)	1	p->p->p
5	\\wedge	2	t	4	3	%(a2) %(op) %(a1)	1	p->p->p
6	\\not\\equiv	2	t	3	4	%(a2) %(op) %(a1)	1	p->p->p
7	\\neg	1	f	1	5	%(op) %(aa1)	1	p->p
8	true	0	f	0	0	%(op)	1	p
9	false	0	f	0	0	%(op)	1	p
19		2	f	3	8	\\{%(v1) \\in %(na2) | %(na1) \\}	2	(t->p)->t->t
22	\\bigcup	1	f	3	8	%(op) %(a1)	2	t->t
38		2	f	3	9	%(a2)^{%(na1)}	2	t->t->t->t
20		1	f	3	8	\\{ %(na1) \\}	2	t->t
10		2	f	3	10	%(aa1) . %(a2) 	1	(x1->x2)->x1->x2
18	\\emptyset	0	f	3	0	%(op)	2	t
21	 	2	f	3	7	%(na2) , %(na1)	2	t->t->t
23	\\bigcap	1	f	3	8	%(op) %(a1)	2	t->t
24	\\cup	2	f	3	7	%(aa2) %(op) %(a1)	2	t->t->t
25	\\cap	2	f	3	7	%(aa2) %(op) %(a1)	2	t->t->t
30	\\setminus	2	f	3	8	%(a2) %(op) %(a1)	2	t->t->t
31	 	2	f	3	8	\\langle %(na2) , %(na1)\\rangle	2	t->t->t
32	\\times	2	f	3	8	%(a2) %(op) %(a1)	2	t->t->t
33	 	1	f	3	8	( %(na1) )	2	t->t
34	\\circ	2	f	3	9	%(a2) %(op) %(a1)	2	t->t->t
35	\\mathcal{P}	1	f	3	8	%(op) ( %(na1) )	2	t->t
36	\\mathbb{Z}	0	f	3	0	%(op)	2	t
37	\\mathbb{B}	0	f	3	0	%(op)	2	t
39	id	1	f	3	9	%(op)_{%(na1) }	2	t->t
40	abort	0	f	3	0	%(op)	2	t
41	 	1	f	3	9	%(a1)^{c}	2	t->t
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
69	-1	1	f	3	10	{%(a1)}^{%(op)}	1	(t->t)->(t->t)
61	Rg	1	f	3	9	%(op)(%(na1) )	2	t->t
62	\\star	3	f	3	11	(%(ea1) %(v1) |%(na2):%(na3))	1	(x1->x1->x1)->(t->p)->(t->x1)->x1
60	Dom	1	f	3	9	%(op)(%(na1) )	2	t->t
1	\\equiv	2	f	3	1	%(a2) %(op) %(a1)	1	p->p->p
15	=	2	f	3	7	%(na2) %(op) %(na1)	1	t->t->p
16	\\in	2	f	3	7	%(a2) %(op) %(a1)	2	t->t->p
17	\\notin	2	f	3	7	%(a2) %(op) %(a1)	2	t->t->p
26	\\subset	2	f	3	6	%(a2) %(op) %(a1)	2	t->t->p
27	\\subseteq	2	f	3	6	%(a2) %(op) %(a1)	2	t->t->p
28	\\supset	2	f	3	6	%(a2) %(op) %(a1)	2	t->t->p
29	\\supseteq	2	f	3	6	%(a2) %(op) %(a1)	2	t->t->p
\.


--
-- Name: simbolo_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.simbolo_id_seq', 69, true);


--
-- Data for Name: solucion; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.solucion (id, resuelveid, resuelto, demostracion, metodo) FROM stdin;
318	485	t	S (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{113} x_{112}) x_{112}),x_{113}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (I^{[x_{113},x_{112} := (c_{7} (c_{5} (c_{2} x_{113} x_{112}) x_{112})),(c_{7} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{4} (c_{7} (c_{5} (c_{2} x_{113} x_{112}) x_{112})) x_{122}} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{4} (c_{7} x_{122}) x_{113}} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{113}} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{113}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{114},x_{113},x_{112} := (c_{7} x_{112}),(c_{7} x_{113}),x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{7} x_{112}) x_{122}} (I^{[x_{112} := x_{113}]} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (I^{[x_{112},x_{113} := c_{8},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}})	CR DS
219	426	t	S (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}) (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})}))	SR
204	412	t	S (S (I^{[x_{113} := c_{8}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})})	DS
217	424	t	A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}	SL
208	416	t	S (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	SR
210	418	t	M_{4} (S (S (I^{[x_{114} := (c_{1} x_{112} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (M_{1}^{1} (A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})))	EO DS
211	419	t	M_{4} (S (I^{[x_{114},x_{112} := x_{112},(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (M_{1}^{1} (A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})))	EO DS
212	420	t	M_{4} (S (S (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} (I^{[x_{114} := x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (M_{1}^{1} (A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{cb} c_{1} (\\Phi_{(b,cb)} c_{1}))})))	EO DS
213	421	t	S A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})} (L^{\\lambda x_{122}.c_{7} x_{122}} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}) (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})	SL
221	428	t	L^{\\lambda x_{122}.c_{1} x_{114} x_{122}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})}))	SL
222	429	t	L^{\\lambda x_{122}.c_{1} x_{114} x_{122}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})})))	SL
223	430	t	S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} A^{= (c_{7} c_{8}) c_{9}} (I^{[x_{113} := (c_{7} c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{113},x_{112} := x_{112},c_{8}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})))	SR
216	423	t	L^{\\lambda x_{122}.c_{7} x_{122}} A^{= (c_{7} c_{8}) c_{9}} (I^{[x_{112} := c_{8}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})	SL
215	423	t	M_{4} (I^{[x_{112},x_{113} := c_{9},(c_{7} c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})} (S (I^{[x_{113},x_{112} := c_{9},c_{8}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{112},x_{113} := c_{8},c_{9}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{113},x_{112} := c_{8},c_{9}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}) (M_{1}^{1} (A^{= (c_{7} c_{8}) c_{9}})))	EO DT
224	431	t	M_{4} (S (I^{[x_{114},x_{113},x_{112} := c_{9},x_{112},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (M_{1}^{1} (A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})))	EO DS
209	417	t	M_{4} (S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{114},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (I^{[x_{114} := (c_{1} x_{112} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (M_{1}^{1} (A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})))	EO DS
813	1073	t	A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} c_{4}) \\Phi_{b})} (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{80} := (\\lambda x_{120}.c_{7} (x_{80} x_{120}))]} A^{= (\\Phi_{bb} (\\Phi_{bb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} c_{5}) \\Phi_{cbb} \\Phi_{b})})) (L^{\\lambda x_{122}.c_{7} (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122}))} (I^{[x_{113},x_{112} := (c_{7} (x_{80} x_{120})),(x_{82} x_{120})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{122}.c_{7} (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122}))} (I^{[x_{113},x_{112} := (x_{80} x_{120}),(x_{82} x_{120})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})}))) (S (I^{[x_{82},x_{80} := (\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{5} (x_{80} x_{120}) (x_{82} x_{120}))]} A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} c_{4}) \\Phi_{b})}))	SL
330	497	t	S (I^{[x_{113},x_{112} := (c_{1} x_{113} x_{112}),(c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112}))]} A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) x_{122}} (I^{[x_{114},x_{112},x_{113} := x_{113},(c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112})),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{4} x_{113} (c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112}))) x_{122})} (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112})),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{4} (c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112})) x_{112}))} (I^{[x_{112} := (c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{4} (c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112})) x_{113}) x_{122})} (I^{[x_{114},x_{113} := (c_{2} x_{112} x_{113}),(c_{2} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{112}) (c_{4} (c_{2} x_{113} x_{112}) x_{112})))} (I^{[x_{114},x_{112},x_{113} := (c_{2} x_{112} x_{113}),x_{113},(c_{2} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{112}) (c_{4} x_{122} x_{112})))} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} x_{122} x_{112}) (c_{4} (c_{4} x_{113} (c_{7} x_{112})) x_{112})))} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} (c_{4} x_{112} (c_{7} x_{113})) x_{112}) x_{122}))} (I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} (c_{4} x_{112} (c_{7} x_{113})) x_{112}) (c_{4} x_{113} x_{122})))} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} (c_{4} x_{112} (c_{7} x_{113})) x_{112}) x_{122}))} (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} (c_{4} x_{112} (c_{7} x_{113})) x_{112}) x_{122}))} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} x_{122} c_{8}))} (I^{[x_{113} := (c_{4} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} x_{122} c_{8}))} (I^{[x_{114},x_{113},x_{112} := x_{112},x_{112},(c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} x_{122} (c_{7} x_{113})) c_{8}))} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) x_{122})} (I^{[x_{112},x_{113} := c_{8},(c_{4} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) x_{122})} (I^{[x_{112} := (c_{4} x_{112} (c_{7} x_{113}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} x_{122} x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} x_{122} x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) x_{122}) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{114},x_{112} := (c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{7} x_{112}) x_{122})) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} x_{122} x_{113}) (c_{4} (c_{7} x_{112}) x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} x_{122} (c_{4} (c_{7} x_{112}) x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{114},x_{113},x_{112} := x_{112},(c_{7} x_{113}),x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} x_{112} x_{122}) (c_{4} (c_{7} x_{112}) x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{112} := x_{113}]} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} x_{122} (c_{4} (c_{7} x_{112}) x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{112},x_{113} := c_{8},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} x_{122} (c_{4} (c_{7} x_{112}) x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))}) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{112} := (c_{4} (c_{7} x_{112}) x_{113})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{4} (c_{7} x_{112}) x_{113}) x_{122})} (I^{[x_{113},x_{112} := x_{112},(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{1} c_{5})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{1} (c_{1} x_{112} (c_{7} x_{113})) (c_{5} x_{112} (c_{7} x_{113}))))} (I^{[x_{113},x_{112} := (c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{1} c_{5})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{1} (c_{1} x_{112} (c_{7} x_{113})) (c_{5} x_{112} (c_{7} x_{113}))))} (I^{[x_{112},x_{113} := (c_{5} (c_{7} x_{112}) x_{113}),(c_{1} (c_{7} x_{112}) x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{5} (c_{7} x_{112}) x_{113}) (c_{1} (c_{7} x_{112}) x_{113})),(c_{1} x_{112} (c_{7} x_{113})),(c_{5} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{5} x_{112} (c_{7} x_{113})))} (I^{[x_{114},x_{113},x_{112} := (c_{5} (c_{7} x_{112}) x_{113}),(c_{1} (c_{7} x_{112}) x_{113}),(c_{1} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{1} (c_{5} (c_{7} x_{112}) x_{113}) (c_{1} x_{122} (c_{1} x_{112} (c_{7} x_{113})))) (c_{5} x_{112} (c_{7} x_{113})))} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{1} (c_{5} (c_{7} x_{112}) x_{113}) x_{122}) (c_{5} x_{112} (c_{7} x_{113})))} (I^{[x_{113} := (c_{1} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{5} x_{112} (c_{7} x_{113})))} (I^{[x_{113} := (c_{5} (c_{7} x_{112}) x_{113})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{122}) (c_{1} (c_{5} (c_{7} x_{112}) x_{113}) (c_{5} x_{112} (c_{7} x_{113})))} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{5} (c_{7} x_{112}) x_{113}) (c_{5} x_{112} (c_{7} x_{113})))} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{5} (c_{7} x_{112}) x_{113}) (c_{5} x_{112} (c_{7} x_{113})))} (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{7} x_{112}) (c_{7} x_{113})),(c_{5} (c_{7} x_{112}) x_{113}),(c_{5} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{112} (c_{7} x_{113}))} (I^{[x_{114},x_{113},x_{112} := (c_{7} x_{112}),(c_{7} x_{113}),(c_{5} (c_{7} x_{112}) x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (I^{[x_{112},x_{113} := (c_{5} x_{112} (c_{7} x_{113})),(c_{1} (c_{7} x_{112}) (c_{1} (c_{7} x_{113}) (c_{5} (c_{7} x_{112}) x_{113})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{114},x_{113},x_{112} := (c_{5} x_{112} (c_{7} x_{113})),(c_{7} x_{112}),(c_{1} (c_{7} x_{113}) (c_{5} (c_{7} x_{112}) x_{113}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{7} x_{113}) (c_{5} (c_{7} x_{112}) x_{113}))} (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{5} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{7} x_{112}) x_{122}) (c_{1} (c_{7} x_{113}) (c_{5} (c_{7} x_{112}) x_{113}))} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{7} x_{112}) (c_{5} (c_{7} x_{113}) x_{112})) x_{122}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{cc(bbb,)} c_{7} c_{5} \\Phi_{bcbb} c_{1} c_{7}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{112} x_{113})} A^{= (\\Phi_{cc(bbb,)} c_{7} c_{5} \\Phi_{bcbb} c_{1} c_{7}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (I^{[x_{112},x_{113} := x_{113},x_{112}]} (M_{1}^{1} (A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})))	DS
727	919	t	S A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})} (L^{\\lambda x_{122}.c_{7} x_{122}} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}) (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})	SL
771	1034	f		
729	921	t	M_{4} (S (L^{\\lambda x_{122}.c_{1} c_{8} (c_{7} x_{122})} A^{= (c_{7} c_{8}) c_{9}}) (I^{[x_{112} := c_{8}]} (M_{1}^{1} (A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))))	EO DS
728	920	t	M_{4} (S (S (I^{[x_{113},x_{112} := x_{112},(c_{7} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{113} := (c_{7} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (I^{[x_{113} := (c_{7} x_{112})]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	EO DS
731	923	t	S (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (S A^{= (c_{7} c_{8}) c_{9}})	SL
730	922	t	A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}	SL
732	924	t	M_{4} (S (S (I^{[x_{114},x_{113},x_{112} := c_{9},x_{112},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (M_{1}^{1} (A^{= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})})))	EO DS
235	440	t	I^{[x_{113} := c_{9}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (S (L^{\\lambda x_{122}.c_{1} (c_{4} c_{9} x_{112}) x_{122}} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{7} x_{112})} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))}) (S (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (S A^{= (c_{7} c_{8}) c_{9}})	SL
233	438	t	I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{112} x_{112}) x_{122}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{113} := (c_{4} x_{112} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}) A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}	SL
228	434	t	S (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (S (I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}))) (I^{[x_{114},x_{113} := x_{112},(c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} (c_{7} x_{113}) x_{112})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})	SL
696	865	t	S (I^{[x_{97} := (c_{57} c_{42} x_{97})]} A^{= \\Phi_{} (\\Phi_{b} (c_{55} c_{42}))}) (S (L^{\\lambda x_{122}.c_{55} x_{122} (c_{57} c_{42} x_{97})} (I^{[x_{97} := (c_{57} c_{42} x_{97})]} A^{= (\\Phi_{K} c_{42}) (\\Phi_{(bb,)} c_{55} c_{64})}))) (S (I^{[x_{99},x_{98},x_{97} := (c_{64} (c_{57} c_{42} x_{97})),(c_{57} c_{42} x_{97}),(c_{57} c_{42} x_{97})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (S (L^{\\lambda x_{122}.c_{55} (c_{64} (c_{57} c_{42} x_{97})) x_{122}} (I^{[x_{99},x_{98} := c_{42},c_{42}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})}))) (L^{\\lambda x_{122}.c_{55} (c_{64} (c_{57} c_{42} x_{97})) (c_{57} x_{122} x_{97})} (I^{[x_{97} := c_{42}]} A^{= \\Phi_{} (\\Phi_{b} (c_{55} c_{42}))})) (I^{[x_{97} := (c_{57} c_{42} x_{97})]} A^{= (\\Phi_{K} c_{42}) (\\Phi_{(bb,)} c_{55} c_{64})})	SL
234	439	t	I^{[x_{113} := c_{8}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} c_{8} x_{112})} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))}) (L^{\\lambda x_{122}.c_{1} c_{8} x_{122}} (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} c_{8} x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})	SL
814	1074	t	I^{[x_{82} := (\\lambda x_{120}.c_{5} (x_{82} x_{120}) (x_{81} x_{120}))]} A^{= (\\Phi_{bb} (\\Phi_{bb} (c_{62} c_{4} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} c_{4}) \\Phi_{cbb} \\Phi_{b})} (L^{\\lambda x_{122}.c_{62} c_{4} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{114},x_{113},x_{112} := (x_{80} x_{120}),(x_{82} x_{120}),(x_{81} x_{120})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (S (I^{[x_{80},x_{82} := (\\lambda x_{120}.c_{5} (x_{80} x_{120}) (x_{82} x_{120})),(\\lambda x_{120}.x_{81} x_{120})]} A^{= (\\Phi_{bb} (\\Phi_{bb} (c_{62} c_{4} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} c_{4}) \\Phi_{cbb} \\Phi_{b})}))	SL
229	435	t	S (I^{[x_{114} := (c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}))) (S (L^{\\lambda x_{122}.c_{4} (c_{7} x_{122}) x_{112}} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})})) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (c_{7} c_{8}) c_{9}})) A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))}	SL
236	441	t	S (I^{[x_{114} := (c_{5} x_{114} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})} (S (L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}))) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{114} x_{122}) x_{112}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}) (S (I^{[x_{114},x_{113} := (c_{5} x_{114} x_{113}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{114} x_{113}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})}))	SR
231	436	t	A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{112} x_{113})} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}))	SL
237	442	t	I^{[x_{113} := (c_{7} x_{112})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{7} x_{112}) x_{112}) x_{122}} (I^{[x_{113} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{7} x_{112}) x_{112}) x_{122}} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})}) (L^{\\lambda x_{122}.c_{1} x_{122} c_{9}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112},x_{113} := c_{9},c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (S A^{= (c_{7} c_{8}) c_{9}})	SL
331	498	t	I^{[x_{112} := (c_{7} (c_{2} x_{112} (c_{5} x_{113} x_{112})))]} A^{= (\\Phi_{b} c_{7}) (\\Phi_{b} (c_{2} c_{9}))} (I^{[x_{112} := (c_{2} x_{112} (c_{5} x_{113} x_{112}))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (S (I^{[x_{112} := (c_{7} (c_{2} x_{112} (c_{5} x_{113} x_{112})))]} A^{= (\\Phi_{b} c_{7}) (\\Phi_{b} (c_{2} c_{9}))} (I^{[x_{112} := (c_{2} x_{112} (c_{5} x_{113} x_{112}))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{1}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{1} (c_{5} x_{113} x_{112}) x_{122}} (I^{[x_{114} := x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{5} x_{113} x_{112}) (c_{5} x_{122} x_{112})} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{5} x_{113} x_{112}) x_{122}} (I^{[x_{114},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}))) (L^{\\lambda x_{122}.c_{1} (c_{5} x_{113} x_{112}) (c_{5} x_{113} x_{122})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})})) (I^{[x_{113} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	CO DS
733	925	t	L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}) (I^{[x_{114},x_{113} := x_{112},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{112} x_{112}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (S (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))	SL
230	433	t	S (I^{[x_{114} := (c_{4} x_{114} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})} (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{4} (c_{4} x_{114} x_{122}) x_{112}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (S (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{113}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{4} x_{114} x_{113}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}))	SR
710	902	t	I^{[x_{112},x_{113} := (c_{2} (c_{4} x_{113} x_{114}) (c_{4} x_{112} x_{114})),(c_{2} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{3} x_{122} (c_{2} (c_{4} x_{113} x_{114}) (c_{4} x_{112} x_{114}))} (S A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{3} x_{122} (c_{2} (c_{4} x_{113} x_{114}) (c_{4} x_{112} x_{114}))} (S (L^{\\lambda x_{122}.c_{1} x_{113} x_{122}} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (I^{[x_{69},x_{101},x_{102} := (\\lambda x_{-126}.c_{3} (c_{1} x_{113} (c_{4} x_{112} x_{113})) x_{-126}),(c_{2} (c_{4} x_{113} x_{114}) (c_{4} x_{112} x_{114})),(c_{4} x_{114} (c_{1} x_{113} (c_{4} x_{112} x_{113})))]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))} (M_{1}^{1} (I^{[x_{113},x_{112} := (c_{4} x_{113} x_{114}),(c_{4} x_{112} x_{114})]} A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{114}) (c_{4} (c_{4} x_{113} x_{114}) x_{122})} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{114}) x_{122}} (I^{[x_{114},x_{113} := (c_{4} x_{113} x_{114}),x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{122} x_{112})} (I^{[x_{114},x_{113},x_{112} := x_{113},x_{114},x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{114}) (c_{4} (c_{4} x_{113} x_{122}) x_{112})} (I^{[x_{112} := x_{114}]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{114}) x_{122}} (I^{[x_{113} := (c_{4} x_{113} x_{114})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{114}) x_{122}} (I^{[x_{114},x_{112} := x_{112},x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (S (I^{[x_{114},x_{112},x_{113} := x_{113},x_{114},(c_{4} x_{112} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (I^{[x_{112},x_{113} := x_{114},(c_{1} x_{113} (c_{4} x_{112} x_{113}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (I^{[x_{112},x_{113} := (c_{1} x_{113} (c_{4} x_{112} x_{113})),x_{114}]} (M_{7}^{2} (A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{4})}))))))	WR
737	928	t	M_{4} (S (S (I^{[x_{114},x_{113},x_{112} := x_{112},(c_{4} (c_{7} x_{113}) x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (M_{1}^{1} (A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(ccb,)} c_{4} c_{7} c_{4} (\\Phi_{(bcbb,cb)} c_{1}))})))	EO DS
735	927	t	S (L^{\\lambda x_{122}.c_{4} (c_{4} x_{114} x_{113}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{113}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113} := (c_{4} x_{114} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{114},x_{113},x_{112} := x_{112},x_{114},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{4} x_{122} x_{113}) x_{112}} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{114} := (c_{4} x_{114} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))	SL
736	929	t	S (I^{[x_{114} := (c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})})) A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))}	SL
734	926	t	M_{4} (S (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} c_{9} x_{112})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (S (I^{[x_{114},x_{113} := x_{112},c_{9}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112},x_{113} := c_{9},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})}))) A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})	EO DS
739	931	t	M_{4} (S (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{113} x_{112})} (I^{[x_{114} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (M_{1}^{1} (A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})))	EO DS
715	911	t	S (L^{\\lambda x_{122}.c_{5} (x_{69} x_{101}) x_{122}} (I^{[x_{112} := (c_{1} x_{102} x_{101})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (S (L^{\\lambda x_{122}.c_{5} (x_{69} x_{101}) (c_{5} x_{122} (c_{1} x_{102} x_{101}))} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})})))) (L^{\\lambda x_{122}.c_{5} (x_{69} x_{101}) x_{122}} (I^{[x_{113},x_{112} := (c_{1} (x_{69} x_{102}) (x_{69} x_{101})),(c_{1} x_{102} x_{101})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})})) (I^{[x_{114},x_{113},x_{112} := (x_{69} x_{101}),(c_{1} (x_{69} x_{102}) (x_{69} x_{101})),(c_{1} x_{102} x_{101})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}) (S (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{1} (x_{69} x_{102}) (x_{69} x_{101}))) (c_{1} x_{102} x_{101})} (I^{[x_{113} := (x_{69} x_{101})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{1} x_{102} x_{101})} (I^{[x_{113},x_{114},x_{112} := (x_{69} x_{102}),c_{8},(x_{69} x_{101})]} A^{= (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{1} c_{1}) (\\Phi_{ccbb} (\\Phi_{(bcb,b)} c_{5}) c_{1} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{1} (x_{69} x_{102}) (x_{69} x_{101}))) (c_{1} x_{102} x_{101})} (I^{[x_{113} := (x_{69} x_{102})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (S (I^{[x_{114},x_{113},x_{112} := (x_{69} x_{102}),(c_{1} (x_{69} x_{102}) (x_{69} x_{101})),(c_{1} x_{102} x_{101})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (S (L^{\\lambda x_{122}.c_{5} (x_{69} x_{102}) x_{122}} (I^{[x_{113},x_{112} := (c_{1} (x_{69} x_{102}) (x_{69} x_{101})),(c_{1} x_{102} x_{101})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})}))) (L^{\\lambda x_{122}.c_{5} (x_{69} x_{102}) (c_{5} x_{122} (c_{1} x_{102} x_{101}))} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})}))) (L^{\\lambda x_{122}.c_{5} (x_{69} x_{102}) x_{122}} (I^{[x_{112} := (c_{1} x_{102} x_{101})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}))	SL
740	932	t	M_{4} (S (I^{[x_{114},x_{113},x_{112} := (c_{4} x_{113} x_{112}),(c_{1} x_{113} x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (M_{1}^{1} (A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})))	EO DS
741	933	t	M_{4} (S (I^{[x_{114},x_{112} := (c_{4} x_{113} x_{112}),(c_{1} x_{112} (c_{5} x_{113} x_{112}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (M_{1}^{1} (A^{= (\\Phi_{(cb,b)} c_{1} \\Phi_{cbb} c_{4}) (\\Phi_{bb} (\\Phi_{(b,b)} c_{1}) c_{5})})))	EO DS
738	930	t	M_{4} (S (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} x_{113} x_{112}) x_{113}),x_{112},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})} (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{113} x_{112})} (I^{[x_{114} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})))) (M_{1}^{1} (A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})))	EO DS
787	1030	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{2} (c_{5} x_{113} x_{112}) x_{112}) (c_{2} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{2} x_{113} x_{112}),(c_{2} (c_{5} x_{113} x_{112}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := (c_{2} (c_{5} x_{113} x_{112}) x_{112}),(c_{2} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (I^{[x_{112} := (c_{2} (c_{2} (c_{5} x_{113} x_{112}) x_{112}) (c_{2} x_{113} x_{112}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{2} (c_{5} x_{113} x_{112}) x_{112}) (c_{2} x_{113} x_{112}))} (S (M_{3} (S (I^{[x_{112},x_{113} := (c_{2} x_{113} x_{112}),(c_{2} (c_{5} x_{113} x_{112}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{69},x_{101},x_{102} := (\\lambda x_{-126}.c_{2} (c_{2} x_{113} x_{112}) x_{-126}),(c_{2} (c_{5} x_{113} x_{112}) x_{112}),(c_{2} (c_{5} x_{112} x_{113}) x_{112})]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))} (M_{1}^{1} (L^{\\lambda x_{122}.c_{2} x_{122} x_{112}} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (I^{[x_{113},x_{114},x_{112} := x_{113},x_{112},(c_{5} x_{112} x_{113})]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} (\\Phi_{(bbcb,b)} c_{2}) c_{2} \\Phi_{cc(bbb,)} c_{2} c_{2})} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})}))))))) (S (I^{[x_{112},x_{113} := (c_{2} x_{113} x_{112}),(c_{2} (c_{5} x_{113} x_{112}) x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (I^{[x_{69},x_{101},x_{102} := (\\lambda x_{-126}.c_{2} (c_{7} (c_{2} x_{113} x_{112})) x_{-126}),(c_{7} (c_{2} (c_{5} x_{113} x_{112}) x_{112})),(c_{7} (c_{2} x_{113} x_{112}))]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))} (M_{1}^{1} (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (S (L^{\\lambda x_{122}.c_{7} (c_{4} (c_{5} x_{113} x_{122}) (c_{7} x_{112}))} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cbb} c_{7} (\\Phi_{(bbb,)} c_{4}) c_{5})})) (S (L^{\\lambda x_{122}.c_{7} x_{122}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})))) (I^{[x_{112} := (c_{7} (c_{2} x_{113} x_{112}))]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{2})})))))	EO (MI (AI (CR WL) WR))
804	1063	t	M_{4} (S (L^{\\lambda x_{122}.c_{1} x_{112} (c_{4} x_{122} x_{112})} A^{= (c_{7} c_{8}) c_{9}} (L^{\\lambda x_{122}.c_{1} x_{112} (c_{4} (c_{7} x_{122}) x_{112})} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})})) (L^{\\lambda x_{122}.c_{1} x_{112} (c_{4} x_{122} x_{112})} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} (I^{[x_{114},x_{113} := x_{112},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{1} x_{112} (c_{1} x_{122} (c_{4} (c_{7} x_{112}) x_{112}))} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (I^{[x_{114},x_{113},x_{112} := x_{112},x_{112},(c_{4} (c_{7} x_{112}) x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} (c_{7} x_{112}) x_{112})} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{112},x_{113} := (c_{4} (c_{7} x_{112}) x_{112}),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113} := (c_{4} (c_{7} x_{112}) x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})	EO DS
742	934	t	A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{112} x_{113})} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}))	SL
805	1064	t	I^{[x_{112},x_{113} := c_{9},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))}	SL
743	935	t	I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{112} x_{112}) x_{122}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{113} := (c_{4} x_{112} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}) A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}	SL
232	437	t	I^{[x_{113},x_{112} := x_{114},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} x_{122}) (c_{1} x_{114} (c_{5} x_{113} x_{112}))} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{5} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{1} (c_{4} x_{113} x_{112}) (c_{1} x_{113} x_{112})),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{5} x_{113} x_{112}))} (I^{[x_{114},x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{114},(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{113} x_{112}) x_{114}) x_{122}) (c_{1} x_{114} (c_{5} x_{113} x_{112}))} (I^{[x_{114},x_{112},x_{113} := x_{113},x_{114},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{112} x_{114}))) (c_{1} x_{114} (c_{5} x_{113} x_{112}))} (I^{[x_{112},x_{113} := x_{114},(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{112} x_{114}))) (c_{1} x_{114} (c_{5} x_{113} x_{112}))} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) x_{122})) (c_{1} x_{114} (c_{5} x_{113} x_{112}))} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{114} x_{112}))) (c_{1} x_{114} x_{122})} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{114} x_{112}))) x_{122}} (I^{[x_{113},x_{112} := (c_{4} x_{113} x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{114} x_{112}))) (c_{1} x_{122} (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{114} x_{112}))) x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{4} x_{113} x_{112}),x_{114},(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{114} x_{112}))),(c_{4} x_{113} x_{112}),(c_{1} x_{114} (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{4} x_{113} x_{112})) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{4} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{114}),(c_{4} x_{114} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{4} x_{113} x_{114})),(c_{4} x_{114} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{4} x_{113} x_{114})) x_{122}) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{4} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{114}),(c_{4} (c_{1} x_{114} x_{113}) x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) x_{122}) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{4} (c_{1} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{114})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{4} x_{114} x_{113}) x_{112}),(c_{4} (c_{1} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{114})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{4} x_{113} x_{114})) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{113}),(c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{122} x_{112}) (c_{4} x_{113} x_{114})) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{5} x_{114} x_{113}) x_{112}) (c_{4} x_{113} x_{114})) x_{122}} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (I^{[x_{114},x_{113} := (c_{1} (c_{4} (c_{5} x_{114} x_{113}) x_{112}) (c_{4} x_{113} x_{114})),(c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{5} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{114}),(c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{5} x_{114} x_{113}) x_{112}) (c_{1} x_{122} (c_{1} x_{114} x_{113}))) x_{112}} (I^{[x_{112} := x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{5} x_{114} x_{113}) x_{112}) x_{122}) x_{112}} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}))) (S (I^{[x_{114},x_{113} := (c_{4} (c_{5} x_{114} x_{113}) x_{112}),(c_{5} x_{114} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (I^{[x_{113} := (c_{5} x_{114} x_{113})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}))	SL
806	1065	t	I^{[x_{112},x_{113} := c_{8},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))}	SL
275	470	t	S (L^{\\lambda x_{122}.c_{1} (c_{7} x_{112}) x_{122}} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{(cb,b)} c_{1} (\\Phi_{(bcbb,)} c_{1}) c_{4}) (\\Phi_{bb} \\Phi_{b} c_{5})}) (I^{[x_{112},x_{113} := (c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{7} x_{113})) x_{112}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{7} x_{113})),x_{112},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{7} x_{113})) x_{122}} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})}) (I^{[x_{112},x_{113} := c_{9},(c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{7} x_{113}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{112} := (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{7} x_{113}))]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (S (L^{\\lambda x_{122}.c_{7} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) x_{122})} (I^{[x_{112} := (c_{7} x_{113})]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}))) (L^{\\lambda x_{122}.c_{7} (c_{1} x_{122} (c_{4} (c_{7} x_{113}) (c_{7} x_{113})))} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{114},x_{112},x_{113} := x_{112},(c_{7} x_{113}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{7} (c_{4} x_{122} (c_{7} x_{113}))} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}))) (I^{[x_{113},x_{112} := (c_{7} (c_{1} x_{112} x_{113})),(c_{7} x_{113})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{7} (c_{7} (c_{1} x_{112} x_{113}))) x_{122}} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{5} x_{122} x_{113}} (I^{[x_{112} := (c_{1} x_{112} x_{113})]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{5} x_{122} x_{113}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{1} (\\Phi_{(bcb,)} c_{5}))}) (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))	SR
408	533	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))} (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := x_{112},(c_{5} (c_{2} x_{112} x_{113}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (I^{[x_{112} := (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))} (S (M_{3} (S (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (I^{[x_{112},x_{113} := x_{112},(c_{5} (c_{2} x_{112} x_{113}) x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}))) (S (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{2} (c_{7} x_{112}) (c_{7} (c_{5} x_{122} x_{112}))} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{2} (c_{7} x_{112}) (c_{7} (c_{5} x_{122} x_{112}))} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{7} x_{112}) (c_{7} x_{122})} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{4} c_{5} \\Phi_{cbcb})})) (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})})) A^{= T c_{8}}))))) (S (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (L^{\\lambda x_{122}.c_{2} (c_{7} (c_{5} x_{122} x_{112})) (c_{7} x_{112})} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{2} (c_{7} (c_{5} x_{122} x_{112})) (c_{7} x_{112})} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{7} x_{122}) (c_{7} x_{112})} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{4} c_{5} \\Phi_{cbcb})})) (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})})) A^{= T c_{8}}))))	EO (MI (AI (CR DS) (CR DS)))
257	462	t	M_{4} (S (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{122}} (I^{[x_{113},x_{112} := (c_{1} x_{112} x_{114}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{(cb,b)} c_{1} (\\Phi_{(bcbb,)} c_{1}) c_{4}) (\\Phi_{bb} \\Phi_{b} c_{5})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{112} x_{114})) (c_{1} x_{113} x_{112}))} (I^{[x_{113},x_{112} := (c_{1} x_{113} x_{114}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{(cb,b)} c_{1} (\\Phi_{(bcbb,)} c_{1}) c_{4}) (\\Phi_{bb} \\Phi_{b} c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{113} x_{114})) (c_{1} x_{113} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),(c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{112} x_{114}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{113} x_{114})) (c_{1} x_{113} x_{112})),(c_{1} x_{113} x_{112}),(c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{112} x_{114}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{112} x_{114}))} (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{113} x_{114})),(c_{1} x_{113} x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{113} x_{114})) x_{122}) (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{112} x_{114}))} (I^{[x_{113} := (c_{1} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{112} x_{114}))} (I^{[x_{113} := (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{113} x_{114}))]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{113} x_{114})) x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})),x_{112},x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) x_{112}) x_{114})} (I^{[x_{114},x_{112} := (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})),x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113}) x_{114}) x_{122}} (I^{[x_{112},x_{113} := x_{114},(c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113}) x_{114}),x_{114},(c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) x_{112})} (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113}),x_{114},x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113}) x_{122}) (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) x_{112})} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) x_{112})} (I^{[x_{113} := (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113}) x_{122}} (I^{[x_{113} := (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113}),x_{112},(c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112}))} (I^{[x_{114} := (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),(c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (I^{[x_{114},x_{113},x_{112} := (c_{1} x_{113} x_{112}),(c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})),(c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) x_{122}} (I^{[x_{114},x_{112},x_{113} := (c_{1} x_{113} x_{114}),(c_{1} x_{113} x_{112}),(c_{1} x_{112} x_{114})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{4} (c_{1} (c_{1} x_{113} x_{114}) x_{122}) (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{4} x_{122} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113} := (c_{1} x_{113} x_{114}),x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{4} (c_{1} x_{122} x_{112}) (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113},x_{112} := x_{113},x_{114},x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{4} (c_{1} (c_{1} x_{113} x_{122}) x_{112}) (c_{1} x_{113} x_{112}))} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{4} (c_{1} x_{122} x_{112}) (c_{1} x_{113} x_{112}))} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (I^{[x_{112} := (c_{1} x_{113} x_{112})]} (M_{1}^{1} (A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}))))	EO DS
815	1075	t	S (I^{[x_{80} := (\\lambda x_{120}.c_{5} (x_{81} x_{120}) x_{80})]} A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} c_{4}) \\Phi_{b})} (L^{\\lambda x_{122}.c_{7} (c_{62} c_{5} (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.x_{122}))} (I^{[x_{113},x_{112} := (x_{81} x_{120}),x_{80}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})})) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{81},x_{80} := (\\lambda x_{120}.c_{7} (x_{81} x_{120})),(c_{7} x_{80})]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} c_{5}) \\Phi_{b})}))) (I^{[x_{113},x_{112} := (c_{62} c_{5} (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.c_{7} (x_{81} x_{120}))),(c_{7} x_{80})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{7} (c_{62} c_{5} (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.c_{7} (x_{81} x_{120})))) x_{122}} (I^{[x_{112} := x_{80}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (S (L^{\\lambda x_{122}.c_{5} x_{122} x_{80}} (I^{[x_{80} := (\\lambda x_{120}.x_{81} x_{120})]} A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} c_{4}) \\Phi_{b})}))))	SR
259	464	t	S (L^{\\lambda x_{122}.c_{5} (x_{69} x_{112}) x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (S (L^{\\lambda x_{122}.c_{5} (x_{69} x_{112}) x_{122}} (I^{[x_{112} := (c_{1} x_{112} c_{8})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}))) (S (L^{\\lambda x_{122}.c_{5} (x_{69} x_{112}) (c_{5} x_{122} (c_{1} x_{112} c_{8}))} (I^{[x_{102},x_{101} := x_{112},c_{8}]} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})}))))) (L^{\\lambda x_{122}.c_{5} (x_{69} x_{112}) x_{122}} (I^{[x_{113},x_{112} := (c_{1} (x_{69} x_{112}) (x_{69} c_{8})),(c_{1} x_{112} c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})})) (I^{[x_{114},x_{113},x_{112} := (x_{69} x_{112}),(c_{1} (x_{69} x_{112}) (x_{69} c_{8})),(c_{1} x_{112} c_{8})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}) (S (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{1} (x_{69} x_{112}) (x_{69} c_{8}))) (c_{1} x_{112} c_{8})} (I^{[x_{113} := (x_{69} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))) (L^{\\lambda x_{122}.c_{5} (c_{5} (c_{1} (x_{69} x_{112}) c_{8}) x_{122}) (c_{1} x_{112} c_{8})} (I^{[x_{112},x_{113} := (x_{69} c_{8}),(x_{69} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{1} x_{112} c_{8})} (I^{[x_{113},x_{114},x_{112} := (x_{69} c_{8}),c_{8},(x_{69} x_{112})]} A^{= (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{1} c_{1}) (\\Phi_{ccbb} (\\Phi_{(bcb,b)} c_{5}) c_{1} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{1} (x_{69} c_{8}) (x_{69} x_{112}))) (c_{1} x_{112} c_{8})} (I^{[x_{113} := (x_{69} c_{8})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (S (I^{[x_{114},x_{113},x_{112} := (x_{69} c_{8}),(c_{1} (x_{69} c_{8}) (x_{69} x_{112})),(c_{1} x_{112} c_{8})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (S (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) x_{122}} (I^{[x_{113},x_{112} := (c_{1} (x_{69} c_{8}) (x_{69} x_{112})),(c_{1} x_{112} c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})}))) (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) (c_{5} (c_{2} x_{122} (c_{1} x_{112} c_{8})) (c_{1} x_{112} c_{8}))} (I^{[x_{112},x_{113} := (x_{69} x_{112}),(x_{69} c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) (c_{5} x_{122} (c_{1} x_{112} c_{8}))} (I^{[x_{102},x_{101} := x_{112},c_{8}]} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})})))) (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) x_{122}} (I^{[x_{112} := (c_{1} x_{112} c_{8})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))	SL
772	1035	t	A^{= (\\Phi_{bb} (\\Phi_{bb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} c_{5}) \\Phi_{cbb} \\Phi_{b})} (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{113},x_{112} := (x_{80} x_{120}),(x_{82} x_{120})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))	SL
807	1066	f	S (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{62} c_{5} (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.x_{81} x_{120})) (c_{62} c_{5} (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.x_{80} x_{120}))) (c_{62} c_{5} (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.x_{122}))} (I^{[x_{113},x_{112} := (x_{81} x_{120}),(x_{80} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})})) (S (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{62} c_{5} (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.x_{81} x_{120})) (c_{62} c_{5} (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.x_{80} x_{120}))) x_{122}} (I^{[x_{115},x_{81},x_{80} := c_{5},(\\lambda x_{120}.c_{2} (x_{80} x_{120}) (x_{81} x_{120})),(\\lambda x_{120}.c_{2} (x_{81} x_{120}) (x_{80} x_{120}))]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})})))	DS
773	1036	t	I^{[x_{80} := (\\lambda x_{120}.x_{80})]} A^{= (\\Phi_{bcb} (\\Phi_{bb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) c_{7} (\\Phi_{(bb,bb)} c_{4})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} c_{5}) \\Phi_{cbb} \\Phi_{b})} (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{112},x_{113} := (c_{7} (x_{82} x_{120})),x_{80}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{82},x_{81} := (\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{7} (x_{82} x_{120}))]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} c_{5}) \\Phi_{b})}))	SL
238	443	t	L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}) (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{113}),(c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) x_{122}} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} x_{114} x_{112}) (c_{4} x_{113} x_{112}))} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{4}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{4})}) (S (I^{[x_{113},x_{112} := (c_{4} x_{114} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}))	SL
799	1052	f	S (I^{[x_{66},x_{65} := (c_{24} x_{65} x_{66}),(c_{24} x_{66} x_{65})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{1}) c_{16})}) (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{68}.c_{8}) (\\lambda x_{68}.c_{1} (c_{16} (c_{24} x_{65} x_{66}) x_{68}) x_{122})} (I^{[x_{120} := x_{68}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{16} \\Phi_{bcb} c_{4}) c_{16}) (\\Phi_{ccbb} \\Phi_{cbb} c_{16} \\Phi_{ccb} c_{24})})) (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{68}.c_{8}) (\\lambda x_{68}.c_{1} x_{122} (c_{4} (c_{16} x_{66} x_{68}) (c_{16} x_{65} x_{68})))} (I^{[x_{66},x_{120},x_{65} := x_{65},x_{68},x_{66}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{16} \\Phi_{bcb} c_{4}) c_{16}) (\\Phi_{ccbb} \\Phi_{cbb} c_{16} \\Phi_{ccb} c_{24})})) (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{68}.c_{8}) (\\lambda x_{68}.c_{1} x_{122} (c_{4} (c_{16} x_{66} x_{68}) (c_{16} x_{65} x_{68})))} (I^{[x_{112},x_{113} := (c_{16} x_{66} x_{68}),(c_{16} x_{65} x_{68})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{68}.c_{8}) (\\lambda x_{68}.x_{122})} (I^{[x_{113} := (c_{4} (c_{16} x_{66} x_{68}) (c_{16} x_{65} x_{68}))]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})})))	EO DS
789	861	f		
241	446	t	A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(cbbb,b)} c_{7} (\\Phi_{(bbb,b)} c_{4}) c_{5} c_{7} c_{5}) (\\Phi_{bb} \\Phi_{b} c_{1})}) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) (c_{7} (c_{4} x_{113} x_{112}))) x_{122}} (I^{[x_{112} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) (c_{7} (c_{4} x_{113} x_{112}))) x_{122}} (I^{[x_{114},x_{112},x_{113} := x_{113},x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) (c_{7} (c_{4} x_{113} x_{112}))) (c_{4} x_{122} (c_{5} x_{112} x_{113}))} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) (c_{7} (c_{4} x_{113} x_{112}))) x_{122}} (I^{[x_{112} := (c_{5} x_{112} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) (c_{7} (c_{4} x_{113} x_{112}))) x_{122}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{5} c_{4} \\Phi_{cbcb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) x_{122}) x_{113}} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{113}} (I^{[x_{114},x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{122} (c_{7} x_{112})) x_{113}} (I^{[x_{112} := (c_{7} x_{113})]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{113}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (I^{[x_{113},x_{112} := (c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cbb} c_{7} (\\Phi_{(bbb,)} c_{4}) c_{5})}) (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})	SL
240	445	t	I^{[x_{113} := (c_{1} x_{112} x_{113})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) x_{122}} (I^{[x_{113} := (c_{1} x_{112} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) x_{122}} (I^{[x_{114},x_{113},x_{112} := x_{112},x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) (c_{1} x_{122} x_{113})} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) x_{122}} (I^{[x_{112},x_{113} := x_{113},c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) x_{122}} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} x_{113}} (I^{[x_{114} := x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{4} x_{113} x_{112})) x_{113}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{1} x_{122} x_{113}} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (I^{[x_{114},x_{113},x_{112} := (c_{4} x_{113} x_{112}),x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})	SL
261	466	t	S (I^{[x_{112} := (c_{4} (x_{69} x_{112}) x_{112})]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := (x_{69} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})})) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} x_{112})) x_{122})} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})}) (S (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} x_{112})) x_{122})} (I^{[x_{112} := (c_{1} c_{9} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}))) (S (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} x_{112})) (c_{5} x_{122} (c_{1} c_{9} x_{112})))} (I^{[x_{102},x_{101} := c_{9},x_{112}]} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})}))))) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} x_{112})) x_{122})} (I^{[x_{113},x_{112} := (c_{1} (x_{69} c_{9}) (x_{69} x_{112})),(c_{1} c_{9} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})})) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{7} (x_{69} x_{112})),(c_{1} (x_{69} c_{9}) (x_{69} x_{112})),(c_{1} c_{9} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{5} x_{122} (c_{1} (x_{69} c_{9}) (x_{69} x_{112}))) (c_{1} c_{9} x_{112}))} (I^{[x_{112} := (x_{69} x_{112})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{5} x_{122} (c_{1} (x_{69} c_{9}) (x_{69} x_{112}))) (c_{1} c_{9} x_{112}))} (I^{[x_{112},x_{113} := (x_{69} x_{112}),c_{9}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{7} (c_{5} x_{122} (c_{1} c_{9} x_{112}))} (I^{[x_{113},x_{114},x_{112} := (x_{69} c_{9}),c_{9},(x_{69} x_{112})]} A^{= (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{1} c_{1}) (\\Phi_{ccbb} (\\Phi_{(bcb,b)} c_{5}) c_{1} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{5} x_{122} (c_{1} (x_{69} c_{9}) (x_{69} x_{112}))) (c_{1} c_{9} x_{112}))} (I^{[x_{112},x_{113} := c_{9},(x_{69} c_{9})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{5} x_{122} (c_{1} (x_{69} c_{9}) (x_{69} x_{112}))) (c_{1} c_{9} x_{112}))} (I^{[x_{112} := (x_{69} c_{9})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})}))) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{7} (x_{69} c_{9})),(c_{1} (x_{69} c_{9}) (x_{69} x_{112})),(c_{1} c_{9} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}))) (S (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} c_{9})) x_{122})} (I^{[x_{113},x_{112} := (c_{1} (x_{69} c_{9}) (x_{69} x_{112})),(c_{1} c_{9} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})}))) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} c_{9})) (c_{5} x_{122} (c_{1} c_{9} x_{112})))} (I^{[x_{102},x_{101} := c_{9},x_{112}]} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})})))) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} c_{9})) x_{122})} (I^{[x_{112} := (c_{1} c_{9} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (S (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} c_{9})) x_{122})} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (I^{[x_{113},x_{112} := (c_{7} (x_{69} c_{9})),(c_{7} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})}) (L^{\\lambda x_{122}.c_{4} (c_{7} (c_{7} (x_{69} c_{9}))) x_{122}} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112} := (x_{69} c_{9})]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))	SL
676	861	t	I^{[x_{99},x_{97},x_{98} := c_{44},c_{42},c_{43}]} (M_{6} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{65}) c_{65} c_{65})})) A^{= T (c_{65} c_{43} c_{42})} A^{= T (c_{65} c_{44} c_{43})}	TL
584	729	t	I^{[x_{98} := c_{42}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{55}) (\\Phi_{cb} c_{55} \\Phi_{cb})} A^{= \\Phi_{} (\\Phi_{cb} c_{42} c_{55})}	SL
258	463	t	A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S A^{= (\\Phi_{(cb,b)} c_{1} \\Phi_{cbb} c_{4}) (\\Phi_{bb} (\\Phi_{(b,b)} c_{1}) c_{5})})	SL
816	1076	t	S (I^{[x_{82},x_{81} := (\\lambda x_{120}.c_{8}),(\\lambda x_{120}.x_{82} x_{120})]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{5}) \\Phi_{bccb} (c_{62} c_{4}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{5}) (c_{62} c_{4}) \\Phi_{b})} (L^{\\lambda x_{122}.c_{62} c_{4} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{112},x_{113} := x_{80},(x_{82} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (I^{[x_{80} := (\\lambda x_{120}.x_{80})]} A^{= (\\Phi_{bb} (\\Phi_{bb} (c_{62} c_{4} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} c_{4}) \\Phi_{cbb} \\Phi_{b})})))	SR
790	863	t	I^{[x_{116},x_{119} := c_{44},c_{42}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{66}) (\\Phi_{cb} c_{68} \\Phi_{cb})} (I^{[x_{122},x_{120},x_{121} := c_{42},c_{44},c_{43}]} (M_{6} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{68}) c_{68} c_{68})})) A^{= T (c_{68} c_{43} c_{44})} A^{= T (c_{68} c_{42} c_{43})})	TR
677	861	t	I^{[x_{112},x_{113} := c_{44},c_{42}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{65}) (\\Phi_{cb} c_{67} \\Phi_{cb})} (I^{[x_{99},x_{97},x_{98} := c_{42},c_{44},c_{43}]} (M_{6} (M_{8}^{65} (A^{= (\\Phi_{bb} \\Phi_{b} c_{65}) (\\Phi_{cb} c_{67} \\Phi_{cb})}))) (M_{7}^{65} (A^{= T (c_{65} c_{44} c_{43})})) (M_{7}^{65} (A^{= T (c_{65} c_{43} c_{42})})))	TR
678	862	t	I^{[x_{99},x_{97},x_{98} := c_{42},c_{44},c_{43}]} (M_{6} (M_{8}^{65} (A^{= (\\Phi_{bb} \\Phi_{b} c_{65}) (\\Phi_{cb} c_{67} \\Phi_{cb})}))) (M_{7}^{65} (A^{= T (c_{65} c_{44} c_{43})})) (M_{7}^{65} (A^{= T (c_{65} c_{43} c_{42})}))	TL
679	862	t	S (I^{[x_{112},x_{113} := c_{44},c_{42}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{65}) (\\Phi_{cb} c_{67} \\Phi_{cb})}) (I^{[x_{99},x_{97},x_{98} := c_{44},c_{42},c_{43}]} (M_{6} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{65}) c_{65} c_{65})})) A^{= T (c_{65} c_{43} c_{42})} A^{= T (c_{65} c_{44} c_{43})})	TR
817	1077	t	I^{[x_{80} := (\\lambda x_{120}.c_{9})]} A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} c_{4}) \\Phi_{b})} (L^{\\lambda x_{122}.c_{7} (c_{62} c_{5} (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.x_{122}))} A^{= c_{8} (c_{7} c_{9})}) (L^{\\lambda x_{122}.c_{7} x_{122}} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} c_{5}) \\Phi_{b})}) (S A^{= (c_{7} c_{8}) c_{9}})	SL
680	863	t	I^{[x_{122},x_{120},x_{121} := c_{44},c_{42},c_{43}]} (M_{6} (M_{8}^{68} (S A^{= (\\Phi_{bb} \\Phi_{b} c_{66}) (\\Phi_{cb} c_{68} \\Phi_{cb})}))) (M_{7}^{68} (A^{= T (c_{68} c_{42} c_{43})})) (M_{7}^{68} (A^{= T (c_{68} c_{43} c_{44})}))	TL
682	863	t	I^{[x_{116},x_{119} := c_{44},c_{42}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{66}) (\\Phi_{cb} c_{68} \\Phi_{cb})} (I^{[x_{122},x_{120},x_{121} := c_{42},c_{44},c_{43}]} (M_{6} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{68}) c_{68} c_{68})})) A^{= T (c_{68} c_{43} c_{44})} A^{= T (c_{68} c_{42} c_{43})})	TR
791	863	f	M_{7}^{65} (A^{= T (c_{65} c_{44} c_{43})})	TR
260	465	t	L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})}) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} x_{112}) x_{122}} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}) (I^{[x_{112},x_{113} := c_{9},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{5} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})	SL
400	533	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))} (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := x_{112},(c_{5} (c_{2} x_{112} x_{113}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (I^{[x_{112} := (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))} (S (M_{3} (S (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{2} (c_{5} x_{122} x_{112}) x_{112}} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{2} (c_{5} x_{122} x_{112}) x_{112}} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} x_{122} x_{112}} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{4} c_{5} \\Phi_{cbcb})})) A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})}) A^{= T c_{8}})))) (S (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (I^{[x_{113},x_{112} := (c_{7} (c_{5} (c_{2} x_{112} x_{113}) x_{112})),(c_{7} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{4} (c_{7} (c_{5} (c_{2} x_{112} x_{113}) x_{112})) x_{122}} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113} := (c_{2} x_{112} x_{113})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})})) (S (I^{[x_{114},x_{113} := (c_{7} (c_{2} x_{112} x_{113})),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{7} (c_{2} x_{112} x_{113})) x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112},x_{113} := c_{8},(c_{7} (c_{2} x_{112} x_{113}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{7} (c_{2} x_{112} x_{113}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}}))))	EO (MI (AI (CR DS) DS))
585	730	t	I^{[x_{97},x_{98} := c_{43},x_{97}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{57}) (\\Phi_{cb} c_{57} \\Phi_{cb})} A^{= \\Phi_{} (\\Phi_{b} (c_{57} c_{43}))}	SL
818	1078	t	S (I^{[x_{112},x_{113} := (x_{80} x_{69}),(c_{62} c_{4} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{80} x_{120}))]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (I^{[x_{69},x_{101},x_{102} := (\\lambda x_{-126}.c_{2} (c_{7} (x_{80} x_{69})) x_{-126}),(c_{7} (c_{62} c_{4} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{80} x_{120}))),(c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{7} (x_{80} x_{120})))]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))} (M_{1}^{1} (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} c_{4}) \\Phi_{b})}) (I^{[x_{112} := (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{7} (x_{80} x_{120})))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))) (I^{[x_{80},x_{101} := (\\lambda x_{120}.c_{7} (x_{80} x_{120})),x_{69}]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(cbbb,)} c_{2} \\Phi_{cbb} (c_{62} c_{5} (\\Phi_{K} c_{8})) \\Phi_{b})}))	CR WL
586	731	t	I^{[x_{97},x_{98} := (c_{55} x_{99} x_{98}),x_{97}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{57}) (\\Phi_{cb} c_{57} \\Phi_{cb})} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})} (L^{\\lambda x_{122}.c_{55} (c_{57} x_{99} x_{97}) x_{122}} A^{= (\\Phi_{bb} \\Phi_{b} c_{57}) (\\Phi_{cb} c_{57} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{55} x_{122} (c_{57} x_{97} x_{98})} (I^{[x_{98} := x_{99}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{57}) (\\Phi_{cb} c_{57} \\Phi_{cb})}))	SL
683	856	t	I^{[x_{114},x_{112},x_{113} := (c_{4} x_{113} x_{112}),(c_{5} x_{113} x_{112}),x_{112}]} (M_{6} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{2}) c_{2} c_{2})})) A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{4})}	WL
254	459	t	S (S (I^{[x_{112} := (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})})) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (c_{7} x_{113})) x_{122})} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{7} (c_{5} x_{122} x_{112})} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})))	SR
792	1045	t	I^{[x_{80} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{bcb} (\\Phi_{bb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) c_{7} (\\Phi_{(bb,bb)} c_{4})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} c_{5}) \\Phi_{cbb} \\Phi_{b})} (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{112},x_{113} := (c_{7} (x_{82} x_{120})),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{82},x_{81},x_{80} := (\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{7} (x_{82} x_{120})),c_{8}]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} c_{5}) \\Phi_{b})})) (I^{[x_{112},x_{113} := c_{8},(c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{7} (x_{82} x_{120})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{7} (x_{82} x_{120})))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})	SL
255	460	t	S (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{7} x_{113}) (c_{7} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{7} x_{113}) (c_{7} x_{112})),(c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) (c_{7} x_{112})) x_{122}) (c_{7} x_{113})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}))) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{7} x_{113})} (I^{[x_{114},x_{112},x_{113} := (c_{7} x_{113}),(c_{7} x_{112}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{122} (c_{7} x_{112})) (c_{7} x_{113})} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{122} x_{112}) (c_{7} x_{112})) (c_{7} x_{113})} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{7} x_{113})} (I^{[x_{114},x_{112},x_{113} := x_{113},(c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{113} (c_{7} x_{112})) x_{122}) (c_{7} x_{113})} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{113} (c_{7} x_{112})) x_{122}) (c_{7} x_{113})} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{7} x_{113})} (I^{[x_{113} := (c_{4} x_{113} (c_{7} x_{112}))]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (S (I^{[x_{113},x_{112} := (c_{4} x_{113} (c_{7} x_{112})),x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (L^{\\lambda x_{122}.c_{7} (c_{1} x_{122} x_{113})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{7} (c_{1} (c_{4} (c_{7} x_{112}) x_{113}) x_{122})} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}))) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{114},x_{112} := (c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{7} (c_{4} x_{122} x_{113})} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{114},x_{112},x_{113} := x_{112},x_{113},(c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{7} (c_{1} (c_{4} x_{112} x_{113}) x_{122})} (I^{[x_{112} := x_{113}]} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := (c_{4} x_{112} x_{113})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})))	SR
793	1046	t	I^{[x_{69},x_{101},x_{102} := (\\lambda x_{-126}.c_{2} (x_{80} x_{101}) x_{-126}),(c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{80} x_{120})),(c_{5} (c_{62} c_{5} (\\lambda x_{120}.c_{7} (c_{15} x_{101} x_{120})) (\\lambda x_{120}.x_{80} x_{120})) (x_{80} x_{101}))]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))} (M_{1}^{1} (S (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.x_{122}) (\\lambda x_{120}.x_{80} x_{120})} (I^{[x_{112} := (c_{15} x_{101} x_{120})]} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (I^{[x_{81},x_{82} := (\\lambda x_{120}.c_{7} (c_{15} x_{101} x_{120})),(\\lambda x_{120}.c_{15} x_{101} x_{120})]} A^{= (\\Phi_{ccbbb} \\Phi_{b} \\Phi_{b} (\\Phi_{cc(bbbb,b)} \\Phi_{b} (c_{62} c_{5}) \\Phi_{bcbb} c_{5}) (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cccbb} \\Phi_{b} \\Phi_{cbb} (c_{62} c_{5}) \\Phi_{ccbb} (\\Phi_{(bb,b)} c_{4}))}) (L^{\\lambda x_{122}.c_{5} (c_{62} c_{5} (\\lambda x_{120}.c_{7} (c_{15} x_{101} x_{120})) (\\lambda x_{120}.x_{80} x_{120})) x_{122}} (I^{[x_{69},x_{115} := x_{101},c_{5}]} A^{= (\\Phi_{b} (\\Phi_{bb} \\Phi_{K})) (\\Phi_{ccbbb} c_{15} \\Phi_{b} (\\Phi_{cbbb} c_{62}) \\Phi_{ccb} \\Phi_{b})})))) (I^{[x_{112},x_{113} := (x_{80} x_{101}),(c_{62} c_{5} (\\lambda x_{120}.c_{7} (c_{15} x_{101} x_{120})) (\\lambda x_{120}.x_{80} x_{120}))]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})})	WL
308	476	t	S (I^{[x_{113},x_{112} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{4} (c_{7} x_{112}) x_{122}} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))	SR
248	453	t	S (S (I^{[x_{113},x_{112} := (c_{5} (c_{7} x_{113}) (c_{7} x_{112})),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(cbb,b)} c_{1} \\Phi_{b(b,b)} c_{1} c_{5})}) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) x_{122}))} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) x_{122})} (I^{[x_{114},x_{113},x_{112} := (c_{5} (c_{7} x_{113}) (c_{7} x_{112})),x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (S (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) (c_{5} x_{122} x_{113}))} (I^{[x_{114},x_{113} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}))) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) (c_{5} (c_{5} (c_{7} x_{113}) x_{122}) x_{113}))} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) (c_{5} x_{122} x_{113}))} (I^{[x_{112},x_{113} := c_{9},(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) (c_{5} x_{122} x_{113}))} (I^{[x_{112} := (c_{7} x_{113})]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{5} c_{9}))})) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) x_{122})} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{5} c_{9}))})) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) x_{122}} (I^{[x_{112},x_{113} := c_{9},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) x_{122}} (I^{[x_{112} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})}))) (I^{[x_{113},x_{112} := (c_{5} (c_{7} x_{113}) (c_{7} x_{112})),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{113} x_{112})} (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{7} (c_{7} x_{113})) x_{122}) (c_{5} x_{113} x_{112})} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{122} x_{112}) (c_{5} x_{113} x_{112})} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{113} x_{112})} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{113} x_{112}) x_{122}) (c_{5} x_{113} x_{112})} (I^{[x_{113} := (c_{1} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})})) (S (I^{[x_{114},x_{113},x_{112} := (c_{4} x_{113} x_{112}),(c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{113} x_{112})),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{1} x_{113} x_{112}),(c_{1} x_{113} x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) (c_{1} (c_{1} x_{113} x_{112}) x_{122})} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{1} c_{5})}) (I^{[x_{112},x_{113} := (c_{1} (c_{1} x_{113} x_{112}) (c_{4} x_{113} x_{112})),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{114},x_{113},x_{112} := (c_{1} x_{113} x_{112}),(c_{4} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) x_{122}} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{113} := (c_{1} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))	SR
249	454	t	I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{112}) x_{112})} (I^{[x_{114},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{122}) (c_{1} (c_{4} x_{113} x_{112}) x_{112})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (I^{[x_{114},x_{113} := (c_{4} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})	SL
288	474	t	M_{4} (S (L^{\\lambda x_{122}.c_{1} c_{8} x_{122}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{1} c_{8} x_{122}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} c_{8} x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	EO DS
310	478	t	S (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (S (I^{[x_{114},x_{113},x_{112} := x_{113},x_{112},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} x_{113} x_{122}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} x_{113} x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}}	DS
309	477	t	S (L^{\\lambda x_{122}.c_{1} (c_{5} x_{114} x_{112}) x_{122}} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{112}) (c_{1} x_{113} x_{112}))} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) (c_{1} x_{114} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} x_{114} x_{112}) (c_{1} x_{114} x_{112})),(c_{1} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} x_{113} x_{112})} (I^{[x_{114},x_{113},x_{112} := (c_{4} x_{114} x_{112}),(c_{1} x_{114} x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) (c_{1} (c_{1} x_{114} x_{112}) x_{122})) (c_{4} x_{113} x_{112})} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) x_{122}) (c_{4} x_{113} x_{112})} (I^{[x_{114},x_{113},x_{112} := (c_{1} x_{114} x_{112}),x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) (c_{1} x_{122} x_{113})) (c_{4} x_{113} x_{112})} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) (c_{1} (c_{1} x_{114} x_{122}) x_{113})) (c_{4} x_{113} x_{112})} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) (c_{1} x_{122} x_{113})) (c_{4} x_{113} x_{112})} (I^{[x_{113} := x_{114}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} x_{113} x_{112})} (I^{[x_{112},x_{113} := (c_{1} x_{114} x_{113}),(c_{4} x_{114} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (I^{[x_{114},x_{113},x_{112} := (c_{1} x_{114} x_{113}),(c_{4} x_{114} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{114} x_{113}) x_{122}} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (S (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})))	SR
256	461	t	A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} (S A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}) (L^{\\lambda x_{122}.c_{7} x_{122}} A^{= (\\Phi_{(cbbb,b)} c_{7} (\\Phi_{(bbb,b)} c_{4}) c_{5} c_{7} c_{5}) (\\Phi_{bb} \\Phi_{b} c_{1})}) (I^{[x_{113},x_{112} := (c_{5} (c_{7} x_{113}) (c_{7} x_{112})),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{7} (c_{5} (c_{7} x_{113}) (c_{7} x_{112}))) x_{122}} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))} (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{7} (c_{7} x_{113})) x_{122}) (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{122} x_{112}) (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (I^{[x_{114},x_{112},x_{113} := x_{113},(c_{4} (c_{7} x_{113}) (c_{7} x_{112})),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})}) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))) x_{122}} (I^{[x_{112},x_{113} := (c_{4} (c_{7} x_{113}) (c_{7} x_{112})),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))) x_{122}} (I^{[x_{114},x_{113} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))) (c_{4} (c_{5} (c_{7} x_{113}) x_{112}) x_{122})} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))) x_{122}} (I^{[x_{112},x_{113} := c_{9},(c_{5} (c_{7} x_{113}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))) x_{122}} (I^{[x_{112} := (c_{5} (c_{7} x_{113}) x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{5} (c_{7} x_{113}) x_{112})} (I^{[x_{112} := (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{5} (c_{7} x_{113}) x_{112})} (I^{[x_{114},x_{112},x_{113} := (c_{7} x_{113}),x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{4} x_{122} (c_{5} (c_{7} x_{112}) x_{113})) (c_{5} (c_{7} x_{113}) x_{112})} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{5} (c_{7} x_{113}) x_{112})} (I^{[x_{112} := (c_{5} (c_{7} x_{112}) x_{113})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{5} (c_{7} x_{113}) x_{112})} (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (I^{[x_{112},x_{113} := (c_{5} (c_{7} x_{113}) x_{112}),(c_{5} x_{113} (c_{7} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})	SL
289	475	t	I^{[x_{113} := c_{8}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})	SL
801	1054	t	I^{[x_{69},x_{101},x_{102} := (\\lambda x_{-126}.c_{2} (c_{15} x_{66} x_{65}) x_{-126}),(c_{5} (c_{27} x_{65} x_{66}) (c_{27} x_{66} x_{65})),(c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120})))]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))} (M_{1}^{1} (L^{\\lambda x_{122}.c_{5} (c_{27} x_{65} x_{66}) x_{122}} A^{= (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{27})} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{2} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120})))} (I^{[x_{66},x_{65} := x_{65},x_{66}]} A^{= (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{27})})) (I^{[x_{115},x_{82},x_{81},x_{80} := c_{5},(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{2} (c_{16} x_{65} x_{120}) (c_{16} x_{66} x_{120})),(\\lambda x_{120}.c_{2} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})}) (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{113},x_{112} := (c_{16} x_{66} x_{120}),(c_{16} x_{65} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})})))) A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(cbb,bb)} c_{16} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{(bb,bbb)} c_{2}) c_{15} (\\Phi_{(bb,b)} c_{1}) c_{16})}	WL
685	864	t	S (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{114},x_{112},x_{113} := (c_{4} x_{113} x_{112}),(c_{5} x_{113} x_{112}),x_{112}]} (M_{6} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{2}) c_{2} c_{2})})) A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{4})})	WR
819	1079	f	L^{\\lambda x_{122}.c_{2} (c_{1} (c_{5} (c_{62} c_{5} (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.x_{81} x_{120})) x_{80}) (c_{62} c_{5} (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.c_{5} (x_{81} x_{120}) x_{80}))) x_{122}} (I^{[x_{82},x_{80} := (\\lambda x_{120}.c_{8}),(\\lambda x_{120}.x_{82} x_{120})]} A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} c_{4}) \\Phi_{b})}) (I^{[x_{113},x_{112} := (c_{1} (c_{5} (c_{62} c_{5} (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.x_{81} x_{120})) x_{80}) (c_{62} c_{5} (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.c_{5} (x_{81} x_{120}) x_{80}))),(c_{7} (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{7} (x_{82} x_{120}))))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{4} (c_{1} (c_{5} (c_{62} c_{5} (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.x_{81} x_{120})) x_{80}) (c_{62} c_{5} (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.c_{5} (x_{81} x_{120}) x_{80}))) x_{122}} (I^{[x_{112} := (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{7} (x_{82} x_{120})))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))	DS
776	1039	t	S (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),(c_{5} (c_{4} x_{114} x_{113}) x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (I^{[x_{112},x_{113} := (c_{7} (c_{5} x_{113} x_{112})),(c_{7} (c_{5} (c_{4} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (I^{[x_{113},x_{112} := (c_{5} (c_{4} x_{114} x_{113}) x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{3} c_{7}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{113},x_{114},x_{112} := (c_{4} x_{114} x_{113}),x_{112},x_{113}]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} (\\Phi_{(bbcb,b)} c_{2}) c_{5} \\Phi_{cc(bbb,)} c_{2} c_{5})} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{4})}))))	CR WR
588	734	t	S (I^{[x_{97} := (c_{55} c_{43} c_{51})]} A^{= \\Phi_{} (\\Phi_{b} (c_{57} c_{43}))}) (S (I^{[x_{97} := (c_{57} c_{43} (c_{55} c_{43} c_{51}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{55} c_{42}))})) (S (I^{[x_{98},x_{97} := c_{42},c_{43}]} A^{= (\\Phi_{ccbb} c_{57} (c_{55} c_{43} c_{51}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}))	SL
589	736	t	A^{= (\\Phi_{ccbb} c_{57} (c_{55} c_{43} c_{51}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{55} x_{98} (c_{57} x_{97} x_{122})} A^{= (c_{54} c_{43} c_{42}) (c_{55} c_{43} c_{51})})	SL
524	650	t	L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{114},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{7} x_{113}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))	SL
239	444	t	S (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})} (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{114},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) (c_{5} (c_{4} x_{113} x_{112}) x_{122})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) (c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{112}) x_{112}))} (I^{[x_{114},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) (c_{1} (c_{4} x_{113} x_{122}) (c_{1} (c_{4} x_{113} x_{112}) x_{112}))} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{114},x_{113} := (c_{4} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) (c_{1} x_{122} x_{112})} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} (I^{[x_{114},x_{112},x_{113} := x_{113},x_{114},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{4} x_{112} x_{114})) x_{112}} (I^{[x_{112} := x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{113}),(c_{4} x_{112} x_{114})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) x_{122}} (I^{[x_{113} := (c_{4} x_{112} x_{114})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} (c_{4} x_{122} x_{112}) (c_{1} (c_{4} x_{112} x_{114}) x_{112}))} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} x_{122} (c_{1} (c_{4} x_{112} x_{114}) x_{112}))} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} (c_{4} x_{114} x_{122}) (c_{1} (c_{4} x_{112} x_{114}) x_{112}))} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} (c_{4} x_{114} x_{112}) (c_{1} x_{122} x_{112}))} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) x_{122}} (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{112}),(c_{4} x_{114} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} x_{122} x_{112})} (I^{[x_{113} := (c_{4} x_{114} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) x_{122}} (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})))	SR
526	644	t	I^{[x_{113},x_{112} := x_{114},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{4} x_{114} x_{122}} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})}) (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (S (L^{\\lambda x_{122}.c_{4} x_{122} (c_{7} x_{112})} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))) (S (I^{[x_{113} := (c_{2} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))	SL
686	864	t	I^{[x_{114},x_{112},x_{113} := (c_{5} x_{113} x_{112}),(c_{4} x_{113} x_{112}),x_{112}]} (M_{6} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{3}) c_{3} c_{3})})) (M_{7}^{2} (A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{4})})) (M_{7}^{2} (A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})}))	WL
687	856	t	M_{7}^{3} (A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{3}) c_{5} c_{4})})	WL
321	488	t	I^{[x_{113} := c_{9}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})	SL
688	856	t	I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{3}) c_{5} c_{4})}	WR
251	456	t	I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})} (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} x_{112}) x_{122}} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}) (I^{[x_{112},x_{113} := c_{9},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{5} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})	SL
243	448	t	M_{4} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{113} x_{112})} (I^{[x_{114} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} x_{113} x_{112}) x_{113}),x_{112},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (M_{1}^{1} (A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})))	EO DT
252	457	t	I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})} (L^{\\lambda x_{122}.c_{5} (c_{4} x_{113} x_{112}) x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112},x_{113} := c_{8},(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}) (I^{[x_{112} := (c_{4} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})	SL
244	449	t	M_{4} (S (S (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} x_{113} x_{112}) x_{113}),x_{112},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (M_{1}^{1} (A^{= (\\Phi_{(cb,b)} c_{1} \\Phi_{cbb} c_{4}) (\\Phi_{bb} (\\Phi_{(b,b)} c_{1}) c_{5})})))	EO DS
245	450	t	M_{4} (S (I^{[x_{114},x_{113},x_{112} := (c_{4} x_{113} x_{112}),(c_{1} x_{113} x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (M_{1}^{1} (A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})))	EO DS
246	451	t	M_{4} (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{114},x_{113},x_{112} := x_{113},x_{112},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (M_{1}^{1} (A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{1} c_{5})})))	EO DS
689	864	t	M_{7}^{2} (A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{2}) c_{4} c_{5})})	WL
539	662	t	I^{[x_{113},x_{112} := x_{112},c_{9}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{4} x_{112} x_{122}} A^{= c_{8} (c_{7} c_{9})}) (I^{[x_{112},x_{113} := c_{8},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))}	SL
705	897	t	S (S (L^{\\lambda x_{122}.c_{62} x_{115} (\\lambda x_{121}.x_{82} (x_{102} x_{121})) (\\lambda x_{121}.x_{122})} (I^{[x_{69} := (x_{102} x_{121})]} A^{= (\\Phi_{b} (\\Phi_{bb} \\Phi_{K})) (\\Phi_{ccbbb} c_{15} \\Phi_{b} (\\Phi_{cbbb} c_{62}) \\Phi_{ccb} \\Phi_{b})})) (S (I^{[x_{82},x_{81},x_{80} := (\\lambda x_{121}.x_{82} (x_{102} x_{121})),(\\lambda x_{121}.\\lambda x_{120}.c_{15} (x_{102} x_{121}) x_{120}),(\\lambda x_{120}.\\lambda x_{121}.x_{80} x_{121})]} A^{= (\\Phi_{c(cccbcbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bcb} \\Phi_{b} \\Phi_{ccbbbb} \\Phi_{b} \\Phi_{(bbb,bb)} c_{62} c_{62}) (\\Phi_{(bcbbcb,ccbb)} \\Phi_{bb} \\Phi_{b} \\Phi_{bcb} \\Phi_{bb} (\\Phi_{K} c_{8}) c_{62} \\Phi_{cbb} c_{5} \\Phi_{(b(cbb,b),bb)} c_{62})})) (L^{\\lambda x_{122}.c_{62} x_{115} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{62} x_{115} (\\lambda x_{121}.x_{122}) (\\lambda x_{121}.x_{80} x_{121}))} (I^{[x_{112},x_{113} := (x_{82} (x_{102} x_{120})),(c_{15} (x_{102} x_{120}) x_{121})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{62} x_{115} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{62} x_{115} (\\lambda x_{121}.x_{122}) (\\lambda x_{121}.x_{80} x_{121}))} (I^{[x_{113},x_{112} := (x_{82} (x_{102} x_{120})),(c_{15} (x_{102} x_{120}) x_{121})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})}))) (S (L^{\\lambda x_{122}.c_{62} x_{115} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{62} x_{115} (\\lambda x_{121}.c_{5} x_{122} (c_{15} (x_{102} x_{120}) x_{121})) (\\lambda x_{121}.x_{80} x_{121}))} (I^{[x_{69},x_{102},x_{101} := (\\lambda x_{120}.x_{82} x_{120}),(x_{102} x_{120}),x_{121}]} A^{= (\\Phi_{cb} c_{15} (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2})) (\\Phi_{cbb} c_{15} \\Phi_{bb} (\\Phi_{(bb,b)} c_{2}))}))) (L^{\\lambda x_{122}.c_{62} x_{115} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{62} x_{115} (\\lambda x_{121}.x_{122}) (\\lambda x_{121}.x_{80} x_{121}))} (I^{[x_{113},x_{112} := (x_{82} x_{121}),(c_{15} (x_{102} x_{120}) x_{121})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})})) (L^{\\lambda x_{122}.c_{62} x_{115} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{62} x_{115} (\\lambda x_{121}.x_{122}) (\\lambda x_{121}.x_{80} x_{121}))} (I^{[x_{112},x_{113} := (c_{15} (x_{102} x_{120}) x_{121}),(x_{82} x_{121})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (I^{[x_{81},x_{80} := (\\lambda x_{121}.\\lambda x_{120}.c_{5} (c_{15} (x_{102} x_{120}) x_{121}) (x_{82} x_{121})),(\\lambda x_{121}.\\lambda x_{120}.x_{80} x_{121})]} A^{= (\\Phi_{(cbcbcb,bb)} \\Phi_{cb} \\Phi_{bcb} \\Phi_{cb} \\Phi_{bcb} (\\Phi_{K} c_{8}) c_{62} \\Phi_{(bcb,cb)} c_{62}) (\\Phi_{(cbbcb,cbb)} \\Phi_{b} \\Phi_{bcb} \\Phi_{bb} (\\Phi_{K} c_{8}) c_{62} \\Phi_{b} \\Phi_{(bbb,bb)} c_{62})})) (I^{[x_{81},x_{80} := (\\lambda x_{121}.\\lambda x_{120}.c_{15} (x_{102} x_{120}) x_{121}),(\\lambda x_{120}.\\lambda x_{121}.x_{80} x_{120})]} A^{= (\\Phi_{c(cccbcbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bcb} \\Phi_{b} \\Phi_{ccbbbb} \\Phi_{b} \\Phi_{(bbb,bb)} c_{62} c_{62}) (\\Phi_{(bcbbcb,ccbb)} \\Phi_{bb} \\Phi_{b} \\Phi_{bcb} \\Phi_{bb} (\\Phi_{K} c_{8}) c_{62} \\Phi_{cbb} c_{5} \\Phi_{(b(cbb,b),bb)} c_{62})}) (L^{\\lambda x_{122}.c_{62} x_{115} (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.c_{62} x_{115} (\\lambda x_{121}.x_{122}) (\\lambda x_{121}.x_{80} x_{120}))} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{15}) c_{69}) (\\Phi_{ccb} \\Phi_{cbb} c_{15} \\Phi_{ccb})}) (L^{\\lambda x_{122}.c_{62} x_{115} (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.x_{122})} (I^{[x_{80},x_{69} := (\\lambda x_{121}.x_{80} x_{120}),(c_{69} x_{102} x_{120})]} A^{= (\\Phi_{b} (\\Phi_{bb} \\Phi_{K})) (\\Phi_{ccbbb} c_{15} \\Phi_{b} (\\Phi_{cbbb} c_{62}) \\Phi_{ccb} \\Phi_{b})})))	SR
802	473	t	L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{113},x_{112} := x_{81},(x_{80} x_{120})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{112},x_{113} := (c_{7} (x_{80} x_{120})),x_{81}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{82},x_{81},x_{80} := (\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{7} (x_{80} x_{120})),x_{81}]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} c_{5}) \\Phi_{b})})) (I^{[x_{112},x_{113} := x_{81},(c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{7} (x_{80} x_{120})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (L^{\\lambda x_{122}.c_{4} x_{81} x_{122}} (I^{[x_{112} := (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{7} (x_{80} x_{120})))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))) (S (I^{[x_{113},x_{112} := x_{81},(c_{7} (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{7} (x_{80} x_{120}))))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{122}.c_{2} x_{81} x_{122}} (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} c_{4}) \\Phi_{b})})))	SL
744	936	t	L^{\\lambda x_{122}.c_{5} x_{114} x_{122}} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (I^{[x_{113},x_{112} := x_{114},(c_{1} (c_{4} x_{113} x_{112}) (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{1} (c_{4} x_{113} x_{112}) (c_{1} x_{113} x_{112})))} (I^{[x_{112},x_{113} := (c_{1} (c_{4} x_{113} x_{112}) (c_{1} x_{113} x_{112})),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{1} (c_{4} x_{113} x_{112}) (c_{1} x_{113} x_{112})))} (I^{[x_{114},x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{114},(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{4} (c_{1} x_{113} x_{112}) x_{114})) (c_{1} x_{114} (c_{1} (c_{4} x_{113} x_{112}) (c_{1} x_{113} x_{112})))} (I^{[x_{112},x_{113} := x_{114},(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{4} (c_{1} x_{113} x_{112}) x_{114})) (c_{1} x_{114} (c_{1} (c_{4} x_{113} x_{112}) (c_{1} x_{113} x_{112})))} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{4} (c_{1} x_{113} x_{112}) x_{114})) x_{122}} (I^{[x_{113},x_{112} := (c_{4} x_{113} x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{4} (c_{1} x_{113} x_{112}) x_{114})) (c_{1} x_{122} (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{4} (c_{1} x_{113} x_{112}) x_{114})) x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{4} x_{113} x_{112}),x_{114},(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{4} (c_{1} x_{113} x_{112}) x_{114})),(c_{4} x_{113} x_{112}),(c_{1} x_{114} (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{4} x_{114} x_{113}) x_{112}),(c_{4} (c_{1} x_{113} x_{112}) x_{114}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) x_{122}) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),(c_{4} (c_{1} x_{113} x_{112}) x_{114})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{4} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{112}),(c_{4} (c_{1} x_{113} x_{112}) x_{114})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{4} (c_{1} x_{113} x_{112}) x_{114})) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114} := (c_{4} x_{114} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{1} (c_{4} x_{114} x_{113}) x_{113}) x_{112}) x_{122}) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{112},x_{113} := x_{113},x_{114},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{1} (c_{4} x_{114} x_{113}) x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) x_{122})) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{1} (c_{4} x_{114} x_{113}) x_{113}) x_{112}) x_{122}) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{4} x_{114} x_{112}),(c_{4} x_{113} x_{114})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{1} (c_{4} x_{114} x_{113}) x_{113}) x_{112}),(c_{4} x_{114} x_{112}),(c_{4} x_{113} x_{114})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{4} x_{113} x_{114})) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113} := (c_{1} (c_{4} x_{114} x_{113}) x_{113}),x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{122} x_{112}) (c_{4} x_{113} x_{114})) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{112} := (c_{4} x_{114} x_{113}),x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{1} (c_{4} x_{114} x_{113}) x_{122}) x_{112}) (c_{4} x_{113} x_{114})) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{112} := x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{122} x_{112}) (c_{4} x_{113} x_{114})) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}))) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{5} x_{114} x_{113}) x_{112}) (c_{4} x_{113} x_{114})),x_{114},(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (I^{[x_{114} := (c_{1} (c_{1} (c_{4} (c_{5} x_{114} x_{113}) x_{112}) (c_{4} x_{113} x_{114})) x_{114})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{5} x_{114} x_{113}) x_{112}) (c_{4} x_{113} x_{114})),x_{114},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{5} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{114}),(c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{5} x_{114} x_{113}) x_{112}) (c_{1} x_{122} (c_{1} x_{114} x_{113}))) x_{112}} (I^{[x_{112} := x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{5} x_{114} x_{113}) x_{112}) x_{122}) x_{112}} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}))) (S (I^{[x_{113} := (c_{5} x_{114} x_{113})]} A^{= (\\Phi_{(cb,b)} c_{1} (\\Phi_{(bcbb,)} c_{1}) c_{4}) (\\Phi_{bb} \\Phi_{b} c_{5})}))	SL
746	938	t	A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{1} x_{113} x_{122}} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{1} x_{113} x_{122}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{cc(bb,)} c_{7} c_{4} \\Phi_{bcbb} c_{1}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} x_{113} (c_{1} x_{113} x_{122})} (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (I^{[x_{114},x_{112} := x_{113},(c_{4} x_{113} (c_{7} x_{112}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} x_{113} (c_{7} x_{112}))} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})})) (I^{[x_{112},x_{113} := (c_{4} x_{113} (c_{7} x_{112})),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113} := (c_{4} x_{113} (c_{7} x_{112}))]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})	SL
745	937	t	I^{[x_{113} := c_{8}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} (c_{4} c_{8} x_{112}) x_{122}} (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} c_{8} x_{112}) x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))}) (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})	SL
780	1042	t	S A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})} A^{= T c_{8}}	DS
690	864	t	S (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{2}) c_{4} c_{5})}	WR
618	805	t	S (I^{[x_{114},x_{113},x_{112} := (c_{2} x_{114} x_{112}),(c_{2} x_{114} x_{113}),(c_{2} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{2}) c_{2}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{2})} (I^{[x_{113},x_{112} := (c_{2} (c_{2} x_{114} x_{112}) (c_{2} x_{114} x_{113})),(c_{2} x_{113} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{4} (c_{2} (c_{2} x_{114} x_{112}) (c_{2} x_{114} x_{113})) (c_{7} x_{122})} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{4} (c_{2} (c_{2} x_{114} x_{112}) (c_{2} x_{114} x_{113})) x_{122}} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{5} (c_{7} x_{113}) (c_{7} (c_{7} x_{112})))} (I^{[x_{113},x_{112} := (c_{2} x_{114} x_{112}),(c_{2} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{2} x_{114} x_{112}) (c_{7} x_{122})) (c_{5} (c_{7} x_{113}) (c_{7} (c_{7} x_{112})))} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{4} (c_{4} (c_{2} x_{114} x_{112}) x_{122}) (c_{5} (c_{7} x_{113}) (c_{7} (c_{7} x_{112})))} (I^{[x_{113},x_{112} := x_{114},(c_{7} x_{113})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{4} x_{122} (c_{5} (c_{7} x_{114}) (c_{7} (c_{7} x_{113})))) (c_{5} (c_{7} x_{113}) (c_{7} (c_{7} x_{112})))} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{5} (c_{7} x_{113}) (c_{7} (c_{7} x_{112})))} (I^{[x_{112},x_{113} := (c_{5} (c_{7} x_{114}) (c_{7} (c_{7} x_{113}))),(c_{4} x_{114} (c_{7} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{4} x_{122} (c_{4} x_{114} (c_{7} x_{112}))) (c_{5} (c_{7} x_{113}) (c_{7} (c_{7} x_{112})))} (I^{[x_{112},x_{113} := (c_{7} (c_{7} x_{113})),(c_{7} x_{114})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{5} (c_{7} x_{113}) (c_{7} (c_{7} x_{112})))} (I^{[x_{114},x_{113},x_{112} := (c_{5} (c_{7} (c_{7} x_{113})) (c_{7} x_{114})),x_{114},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{4} x_{122} (c_{7} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} (c_{7} x_{112})))} (I^{[x_{113},x_{112} := (c_{7} (c_{7} x_{113})),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cbb} c_{7} (\\Phi_{(bbb,)} c_{4}) c_{5})})) (L^{\\lambda x_{122}.c_{4} (c_{4} x_{122} (c_{7} x_{112})) (c_{5} (c_{7} x_{113}) (c_{7} (c_{7} x_{112})))} (I^{[x_{112},x_{113} := x_{114},(c_{7} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{4} x_{122} (c_{5} (c_{7} x_{113}) (c_{7} (c_{7} x_{112})))} (I^{[x_{113},x_{112} := (c_{7} (c_{7} x_{113})),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (S (I^{[x_{113},x_{112} := (c_{4} (c_{7} (c_{7} x_{113})) (c_{7} x_{112})),(c_{5} (c_{7} x_{113}) (c_{7} (c_{7} x_{112})))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (S (L^{\\lambda x_{122}.c_{4} x_{114} (c_{4} x_{122} (c_{5} (c_{7} x_{113}) (c_{7} (c_{7} x_{112}))))} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})}))) (L^{\\lambda x_{122}.c_{4} x_{114} (c_{4} (c_{7} (c_{5} (c_{7} x_{113}) x_{112})) (c_{5} (c_{7} x_{113}) x_{122}))} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{4} x_{114} x_{122}} (I^{[x_{112} := (c_{5} (c_{7} x_{113}) x_{112})]} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (I^{[x_{112},x_{113} := c_{8},x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := x_{114}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}}	DS
803	1061	t	L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}) (I^{[x_{114},x_{113} := x_{112},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{112} x_{112}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (S (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))	SL
663	856	t	I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (I^{[x_{114},x_{112},x_{113} := (c_{5} x_{113} x_{112}),(c_{4} x_{113} x_{112}),x_{112}]} (M_{6} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{3}) c_{3} c_{3})})) (M_{7}^{2} (A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{4})})) (M_{7}^{2} (A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})})))	WR
747	939	f	L^{\\lambda x_{122}.c_{2} (c_{2} x_{114} x_{112}) (c_{5} (c_{2} x_{114} x_{113}) x_{122})} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{2} (c_{2} x_{114} x_{112}) (c_{5} x_{122} (c_{4} x_{113} (c_{7} x_{112})))} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{2} x_{122} (c_{5} (c_{4} x_{114} (c_{7} x_{113})) (c_{4} x_{113} (c_{7} x_{112})))} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (I^{[x_{113},x_{112} := (c_{4} x_{114} (c_{7} x_{112})),(c_{5} (c_{4} x_{114} (c_{7} x_{113})) (c_{4} x_{113} (c_{7} x_{112})))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})	DS
811	1071	t	I^{[x_{121},x_{120} := c_{18},x_{65}]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{15}) (\\Phi_{bb} \\Phi_{b} c_{12})} (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{66} := c_{18}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{1}) c_{16})}))) (L^{\\lambda x_{122}.c_{7} (c_{62} c_{5} (\\lambda x_{67}.c_{8}) (\\lambda x_{67}.c_{1} x_{122} (c_{16} x_{65} x_{67})))} (I^{[x_{120} := x_{67}]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{16} c_{18}))})) (S (L^{\\lambda x_{122}.c_{7} (c_{62} c_{5} (\\lambda x_{67}.c_{8}) (\\lambda x_{67}.x_{122}))} (I^{[x_{112} := (c_{16} x_{65} x_{67})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})}))) (S (I^{[x_{82},x_{80} := (\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{16} x_{65} x_{120})]} A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} c_{4}) \\Phi_{b})}))	SL
812	1072	f	L^{\\lambda x_{122}.c_{5} x_{122} (c_{27} x_{66} x_{65})} A^{= (\\Phi_{bbb} (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{b} c_{16}) (\\Phi_{b} (c_{12} c_{18}))} (L^{\\lambda x_{122}.c_{5} (c_{62} c_{4} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{16} x_{65} x_{120})) x_{122}} A^{= (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{27})})	WL
619	804	t	S (L^{\\lambda x_{122}.c_{2} (c_{3} x_{114} x_{112}) (c_{5} (c_{3} x_{114} x_{113}) x_{122})} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{2} (c_{3} x_{114} x_{112}) (c_{5} x_{122} (c_{2} x_{112} x_{113}))} (I^{[x_{112},x_{113} := x_{113},x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} x_{122} (c_{5} (c_{2} x_{113} x_{114}) (c_{2} x_{112} x_{113}))} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{2} x_{112} x_{114}) x_{122}} (I^{[x_{112},x_{113} := (c_{2} x_{112} x_{113}),(c_{2} x_{113} x_{114})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (I^{[x_{114},x_{112} := x_{112},x_{114}]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{2}) c_{2} c_{2})})	DS
566	689	t	S (S (L^{\\lambda x_{122}.c_{2} x_{122} (c_{1} x_{102} x_{101})} (I^{[x_{112} := (c_{2} (x_{69} x_{101}) (x_{69} x_{102}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (L^{\\lambda x_{122}.c_{2} x_{122} (c_{1} x_{102} x_{101})} (I^{[x_{112},x_{113} := (c_{2} (x_{69} x_{101}) (x_{69} x_{102})),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{2} (c_{5} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) x_{122}) (c_{1} x_{102} x_{101})} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})})))) (S (L^{\\lambda x_{122}.c_{2} (c_{5} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{2} x_{122} (c_{1} x_{102} x_{101}))) (c_{1} x_{102} x_{101})} (I^{[x_{113},x_{112} := (x_{69} x_{102}),(x_{69} x_{101})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}))) (L^{\\lambda x_{122}.c_{2} (c_{5} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) x_{122}) (c_{1} x_{102} x_{101})} (I^{[x_{113},x_{112} := (c_{5} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{2} (x_{69} x_{102}) (x_{69} x_{101}))),(c_{1} x_{102} x_{101})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{2} (c_{5} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) x_{122}) (c_{1} x_{102} x_{101})} (I^{[x_{114},x_{112},x_{113} := (c_{2} (x_{69} x_{101}) (x_{69} x_{102})),(c_{7} (c_{1} x_{102} x_{101})),(c_{2} (x_{69} x_{102}) (x_{69} x_{101}))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (I^{[x_{113},x_{112} := (c_{5} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101}))))),(c_{1} x_{102} x_{101})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (I^{[x_{114},x_{112},x_{113} := (c_{2} (x_{69} x_{101}) (x_{69} x_{102})),(c_{7} (c_{1} x_{102} x_{101})),(c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101}))))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) x_{122}} (I^{[x_{114},x_{112},x_{113} := (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))),(c_{7} (c_{1} x_{102} x_{101})),(c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101})))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{5} (c_{4} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{7} (c_{1} x_{102} x_{101}))) x_{122})} (I^{[x_{114},x_{113},x_{112} := (c_{2} (x_{69} x_{102}) (x_{69} x_{101})),(c_{7} (c_{1} x_{102} x_{101})),(c_{7} (c_{1} x_{102} x_{101}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{5} (c_{4} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{7} (c_{1} x_{102} x_{101}))) (c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) x_{122}))} (I^{[x_{112} := (c_{7} (c_{1} x_{102} x_{101}))]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{5} x_{122} (c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101}))))} (I^{[x_{114},x_{113},x_{112} := (c_{2} (x_{69} x_{101}) (x_{69} x_{102})),(c_{7} (c_{1} x_{102} x_{101})),(c_{7} (c_{1} x_{102} x_{101}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) x_{122}) (c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101}))))} (I^{[x_{112} := (c_{7} (c_{1} x_{102} x_{101}))]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})) (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))),(c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))),(c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101})))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101})))} (I^{[x_{112} := (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101})))]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})})) (S (I^{[x_{114},x_{112},x_{113} := (c_{2} (x_{69} x_{101}) (x_{69} x_{102})),(c_{7} (c_{1} x_{102} x_{101})),(c_{2} (x_{69} x_{102}) (x_{69} x_{101}))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{7} (c_{1} x_{102} x_{101}))} (I^{[x_{113},x_{112} := (x_{69} x_{102}),(x_{69} x_{101})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})})) (S (I^{[x_{113},x_{112} := (c_{1} (x_{69} x_{102}) (x_{69} x_{101})),(c_{1} x_{102} x_{101})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))) A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})}	DS
592	742	t	I^{[x_{97},x_{98} := c_{42},x_{97}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{57}) (\\Phi_{cb} c_{57} \\Phi_{cb})} A^{= (\\Phi_{K} c_{42}) (\\Phi_{b} (c_{57} c_{42}))}	SL
754	1017	f	L^{\\lambda x_{122}.c_{55} (c_{54} c_{49} c_{44}) x_{122}} (I^{[x_{98},x_{97} := c_{43},(c_{54} c_{45} c_{46})]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{55} x_{122} (c_{55} c_{43} (c_{57} (c_{54} c_{45} c_{46}) (c_{54} c_{43} c_{42})))} (I^{[x_{98},x_{97} := c_{44},c_{49}]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})})) (I^{[x_{99},x_{98},x_{97} := (c_{55} c_{44} (c_{57} c_{49} (c_{54} c_{43} c_{42}))),c_{43},(c_{57} (c_{54} c_{45} c_{46}) (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}) (L^{\\lambda x_{122}.c_{55} x_{122} (c_{57} (c_{54} c_{45} c_{46}) (c_{54} c_{43} c_{42}))} (I^{[x_{97},x_{98} := c_{43},(c_{55} c_{44} (c_{57} c_{49} (c_{54} c_{43} c_{42})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{55}) (\\Phi_{cb} c_{55} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{55} x_{122} (c_{57} (c_{54} c_{45} c_{46}) (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{98},x_{97} := c_{43},c_{44},(c_{57} c_{49} (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (S (L^{\\lambda x_{122}.c_{55} (c_{55} x_{122} (c_{57} c_{49} (c_{54} c_{43} c_{42}))) (c_{57} (c_{54} c_{45} c_{46}) (c_{54} c_{43} c_{42}))} A^{= (c_{55} c_{43} c_{44}) c_{45}})) (S (I^{[x_{99},x_{98},x_{97} := c_{45},(c_{57} c_{49} (c_{54} c_{43} c_{42})),(c_{57} (c_{54} c_{45} c_{46}) (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (S (L^{\\lambda x_{122}.c_{55} c_{45} x_{122}} (I^{[x_{99},x_{97},x_{98} := c_{49},(c_{54} c_{43} c_{42}),(c_{54} c_{45} c_{46})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})}))) (L^{\\lambda x_{122}.c_{55} c_{45} (c_{57} (c_{55} c_{49} x_{122}) (c_{54} c_{43} c_{42}))} (I^{[x_{98},x_{97} := c_{46},c_{45}]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{55} c_{45} (c_{57} x_{122} (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{98},x_{97} := c_{49},c_{46},(c_{57} c_{45} (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (S (L^{\\lambda x_{122}.c_{55} c_{45} (c_{57} (c_{55} x_{122} (c_{57} c_{45} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} A^{= (c_{55} c_{49} c_{46}) (c_{54} c_{43} c_{43})})) (L^{\\lambda x_{122}.c_{55} c_{45} (c_{57} (c_{55} x_{122} (c_{57} c_{45} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} (I^{[x_{98},x_{97} := c_{43},c_{43}]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{55} c_{45} (c_{57} x_{122} (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{98},x_{97} := c_{43},(c_{57} c_{43} (c_{54} c_{43} c_{42})),(c_{57} c_{45} (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}))) (S (L^{\\lambda x_{122}.c_{55} c_{45} (c_{57} (c_{55} c_{43} x_{122}) (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{97},x_{98} := c_{43},(c_{54} c_{43} c_{42}),c_{45}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})}))) (S (L^{\\lambda x_{122}.c_{55} c_{45} (c_{57} (c_{55} c_{43} (c_{57} x_{122} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} A^{= (c_{55} c_{43} c_{45}) c_{46}}))	SL
758	1021	t	S (L^{\\lambda x_{122}.c_{55} x_{122} c_{46}} A^{= (c_{55} c_{43} c_{46}) c_{47}} (S (I^{[x_{99},x_{98},x_{97} := c_{43},c_{46},c_{46}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (S (L^{\\lambda x_{122}.c_{55} c_{43} x_{122}} A^{= (c_{55} c_{46} c_{46}) c_{50}})) (S A^{= (c_{55} c_{43} c_{50}) c_{51}}))	SR
755	1018	t	S (L^{\\lambda x_{122}.c_{55} x_{122} c_{46}} A^{= (c_{55} c_{43} c_{43}) c_{44}} (S (I^{[x_{99},x_{98},x_{97} := c_{43},c_{43},c_{46}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (S (L^{\\lambda x_{122}.c_{55} c_{43} x_{122}} A^{= (c_{55} c_{43} c_{46}) c_{47}})) (S A^{= (c_{55} c_{43} c_{47}) c_{48}}))	SR
691	861	t	M_{7}^{67} (A^{= T (c_{67} c_{42} c_{44})})	TL
692	861	t	I^{[x_{112},x_{113} := c_{44},c_{42}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{65}) (\\Phi_{cb} c_{67} \\Phi_{cb})} A^{= T (c_{67} c_{42} c_{44})}	TR
760	1023	t	S (L^{\\lambda x_{122}.c_{55} x_{122} c_{46}} A^{= (c_{55} c_{43} c_{48}) c_{49}} (S (I^{[x_{99},x_{98},x_{97} := c_{43},c_{48},c_{46}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (S (L^{\\lambda x_{122}.c_{55} c_{43} x_{122}} A^{= (c_{55} c_{48} c_{46}) (c_{54} c_{43} c_{42})})) (S (L^{\\lambda x_{122}.c_{55} c_{43} x_{122}} (I^{[x_{97} := (c_{54} c_{43} c_{42})]} A^{= \\Phi_{} (\\Phi_{b} (c_{57} c_{43}))}))) (S (I^{[x_{98},x_{97} := c_{43},c_{43}]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})})))	SR
756	1019	t	S (L^{\\lambda x_{122}.c_{55} x_{122} c_{46}} A^{= (c_{55} c_{43} c_{44}) c_{45}} (S (I^{[x_{99},x_{98},x_{97} := c_{43},c_{44},c_{46}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (S (L^{\\lambda x_{122}.c_{55} c_{43} x_{122}} A^{= (c_{55} c_{44} c_{46}) c_{48}})) (S A^{= (c_{55} c_{43} c_{48}) c_{49}}))	SR
693	862	t	M_{7}^{65} (A^{= T (c_{65} c_{44} c_{42})})	TL
694	862	t	S (I^{[x_{112},x_{113} := c_{44},c_{42}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{65}) (\\Phi_{cb} c_{67} \\Phi_{cb})}) A^{= T (c_{65} c_{44} c_{42})}	TR
367	523	f	S (I^{[x_{112} := (c_{2} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))} (S (M_{3} (S (S (L^{\\lambda x_{122}.c_{3} (c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112})) x_{122}} A^{= (c_{7} c_{8}) c_{9}}) (I^{[x_{112},x_{113} := c_{9},(c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{112} := (c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))]} A^{= (\\Phi_{b} c_{7}) (\\Phi_{b} (c_{2} c_{9}))}) (I^{[x_{112} := (c_{4} (c_{2} x_{113} x_{112}) x_{112})]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (S (I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} x_{113} x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}})))) (S (I^{[x_{112},x_{113} := (c_{4} (c_{2} x_{113} x_{112}) x_{112}),c_{8}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (S (L^{\\lambda x_{122}.c_{2} (c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112})) x_{122}} A^{= (c_{7} c_{8}) c_{9}}) (I^{[x_{113},x_{112} := (c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112})),c_{9}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{4} (c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112})) x_{122}} A^{= c_{8} (c_{7} c_{9})}) (I^{[x_{112},x_{113} := c_{8},(c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}}))	EO (MI (AI (CR DS) (CR DS)))
759	1022	t	S (L^{\\lambda x_{122}.c_{55} x_{122} c_{46}} A^{= (c_{55} c_{43} c_{47}) c_{48}} (S (I^{[x_{99},x_{98},x_{97} := c_{43},c_{47},c_{46}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (S (L^{\\lambda x_{122}.c_{55} c_{43} x_{122}} A^{= (c_{55} c_{47} c_{46}) c_{51}})) A^{= (c_{54} c_{43} c_{42}) (c_{55} c_{43} c_{51})})	SR
757	1020	t	S (L^{\\lambda x_{122}.c_{55} x_{122} c_{46}} A^{= (c_{55} c_{43} c_{45}) c_{46}} (S (I^{[x_{99},x_{98},x_{97} := c_{43},c_{45},c_{46}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (S (L^{\\lambda x_{122}.c_{55} c_{43} x_{122}} A^{= (c_{55} c_{45} c_{46}) c_{49}})) (S A^{= (c_{55} c_{43} c_{49}) c_{50}}))	SR
371	526	t	I^{[x_{113},x_{112} := x_{112},c_{8}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (S (L^{\\lambda x_{122}.c_{4} x_{112} x_{122}} A^{= (c_{7} c_{8}) c_{9}})) (I^{[x_{112},x_{113} := c_{9},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))}	SL
214	422	t	M_{4} (S (S (I^{[x_{113},x_{112} := x_{112},(c_{7} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{113} := (c_{7} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (I^{[x_{113} := (c_{7} x_{112})]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	EO DS
220	427	t	L^{\\lambda x_{122}.c_{6} x_{114} x_{122}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} (I^{[x_{113},x_{112} := x_{114},(c_{1} x_{113} (c_{7} x_{112}))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})}) (L^{\\lambda x_{122}.c_{1} x_{114} x_{122}} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (L^{\\lambda x_{122}.c_{1} x_{114} x_{122}} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})})) (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{7} x_{112})} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})}))) (S (I^{[x_{113} := (c_{6} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})}))	SL
227	433	t	S (L^{\\lambda x_{122}.c_{4} (c_{4} x_{114} x_{113}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{113}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{114},x_{113} := (c_{4} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (I^{[x_{112},x_{113} := (c_{4} x_{114} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})	SL
407	533	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))} (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := x_{112},(c_{5} (c_{2} x_{112} x_{113}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (I^{[x_{112} := (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))} (S (M_{3} (S (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (I^{[x_{112},x_{113} := x_{112},(c_{5} (c_{2} x_{112} x_{113}) x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}))) (S (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{2} (c_{7} x_{112}) (c_{7} (c_{5} x_{122} x_{112}))} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{2} (c_{7} x_{112}) (c_{7} (c_{5} x_{122} x_{112}))} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{7} x_{112}) (c_{7} x_{122})} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{4} c_{5} \\Phi_{cbcb})})) (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})})) A^{= T c_{8}}))))) (S (L^{\\lambda x_{122}.c_{2} x_{112} (c_{5} x_{122} x_{112})} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (I^{[x_{113} := (c_{4} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})}))))	EO (MI (AI DS (CR DS)))
796	1049	t	L^{\\lambda x_{122}.c_{16} x_{122} x_{120}} A^{= (\\Phi_{bb} (\\Phi_{bbb} c_{22} c_{20}) c_{21}) (\\Phi_{bb} \\Phi_{b} c_{24})} (I^{[x_{66} := (c_{20} (c_{21} x_{66} x_{65}))]} A^{= (\\Phi_{ccbbbb} \\Phi_{cb} c_{16} \\Phi_{bcb} (c_{62} c_{4}) \\Phi_{b} c_{16}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{22})}) (L^{\\lambda x_{122}.c_{62} c_{4} (\\lambda x_{67}.x_{122}) (\\lambda x_{67}.c_{16} x_{67} x_{120})} (I^{[x_{98},x_{120},x_{97} := x_{66},x_{67},x_{65}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{15} \\Phi_{bcb} c_{4}) c_{15}) (\\Phi_{cccbb} \\Phi_{cbbb} c_{16} c_{20} \\Phi_{cccb} c_{21})})) (I^{[x_{115},x_{83},x_{80},x_{82} := c_{4},(\\lambda x_{68}.c_{15} x_{66} x_{68}),(\\lambda x_{68}.c_{16} x_{68} x_{120}),(\\lambda x_{68}.c_{15} x_{65} x_{68})]} A^{= (\\Phi_{c(b(cbb,),b)} \\Phi_{b} (\\Phi_{ccbbb} \\Phi_{b} \\Phi_{b}) \\Phi_{bcbb} (\\Phi_{cc(bbbb,b)} \\Phi_{b}) c_{62} c_{62}) (\\Phi_{ccbb} (\\Phi_{(bb,b)} c_{4}) \\Phi_{ccbb} (\\Phi_{cccbb} \\Phi_{b} \\Phi_{cbb}) c_{62})}) (L^{\\lambda x_{122}.c_{4} (c_{62} c_{4} (\\lambda x_{121}.c_{15} x_{66} x_{121}) (\\lambda x_{121}.c_{16} x_{121} x_{120})) x_{122}} (I^{[x_{80},x_{69},x_{115} := (\\lambda x_{121}.c_{16} x_{121} x_{120}),x_{65},c_{4}]} A^{= (\\Phi_{b} (\\Phi_{bb} \\Phi_{K})) (\\Phi_{ccbbb} c_{15} \\Phi_{b} (\\Phi_{cbbb} c_{62}) \\Phi_{ccb} \\Phi_{b})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{16} x_{65} x_{120})} (I^{[x_{80},x_{69},x_{115} := (\\lambda x_{121}.c_{16} x_{121} x_{120}),x_{66},c_{4}]} A^{= (\\Phi_{b} (\\Phi_{bb} \\Phi_{K})) (\\Phi_{ccbbb} c_{15} \\Phi_{b} (\\Phi_{cbbb} c_{62}) \\Phi_{ccb} \\Phi_{b})}))	SL
250	455	t	S (I^{[x_{113} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{1} c_{5})}) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{5} x_{113} x_{112}) x_{112}) x_{122}} (I^{[x_{114},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{5}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{5} x_{113} x_{112}) x_{112}) (c_{5} (c_{5} x_{113} x_{112}) x_{122})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})}) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{5} x_{113} x_{112}) x_{112}) x_{122}} (I^{[x_{114},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{5} x_{113} x_{112}) x_{112}) (c_{5} x_{113} x_{122})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{113} x_{112})} (I^{[x_{113} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (I^{[x_{114},x_{113},x_{112} := x_{112},(c_{5} x_{113} x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} (I^{[x_{113} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})	SL
595	745	t	L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) x_{112}) x_{122}} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{112}) (c_{1} x_{113} x_{112}))} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{1} (c_{7} x_{113}) x_{112})),(c_{4} x_{113} x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{113} x_{112})} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{7} x_{113}) x_{112}),(c_{1} (c_{7} x_{113}) x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) x_{122}) (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),(c_{1} (c_{7} x_{113}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{113} x_{112})} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{7} x_{113}) x_{112}),(c_{4} x_{113} x_{112}),(c_{1} (c_{7} x_{113}) x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112})),(c_{1} (c_{7} x_{113}) x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112})) (c_{1} x_{122} (c_{1} x_{113} x_{112}))} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112})) (c_{1} x_{122} (c_{1} x_{113} x_{112}))} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),(c_{7} (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112})) x_{122}} (I^{[x_{112} := (c_{1} x_{113} x_{112})]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})})) (I^{[x_{112},x_{113} := c_{9},(c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{112} := (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112}))]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{114} := (c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (L^{\\lambda x_{122}.c_{7} (c_{4} x_{122} x_{112})} (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{7} (c_{4} x_{122} x_{112})} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})})) (L^{\\lambda x_{122}.c_{7} x_{122}} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})	SL
363	523	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))} (I^{[x_{112},x_{113} := (c_{4} (c_{2} x_{113} x_{112}) x_{112}),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := c_{8},(c_{4} (c_{2} x_{113} x_{112}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (L^{\\lambda x_{122}.c_{5} (c_{3} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112})) x_{122}} (I^{[x_{112} := (c_{4} (c_{2} x_{113} x_{112}) x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} c_{8}} (I^{[x_{112},x_{113} := (c_{4} (c_{2} x_{113} x_{112}) x_{112}),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{2} (c_{4} x_{122} x_{112}) c_{8}) c_{8}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (S (L^{\\lambda x_{122}.c_{5} (c_{2} x_{122} c_{8}) c_{8}} (I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{5} (c_{2} (c_{4} x_{113} x_{122}) c_{8}) c_{8}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (L^{\\lambda x_{122}.c_{5} (c_{2} x_{122} c_{8}) c_{8}} (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{2} x_{122} c_{8}) c_{8}} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) (L^{\\lambda x_{122}.c_{5} x_{122} c_{8}} (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) (I^{[x_{112} := c_{8}]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) A^{= T c_{8}}))	EO (MI DS)
762	1026	t	I^{[x_{113},x_{114},x_{112} := x_{113},x_{112},(c_{5} x_{114} x_{113})]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} (\\Phi_{(bbcb,b)} c_{2}) c_{4} \\Phi_{cc(bbb,)} c_{2} c_{4})} (I^{[x_{112},x_{113} := x_{113},x_{114}]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})})	WL
583	705	t	M_{4} (I^{[x_{69},x_{101},x_{102} := (\\lambda x_{-126}.c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) x_{-126}),(c_{5} (c_{5} (c_{5} (c_{5} (c_{5} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} c_{8}))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{9})) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{8})) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})),(c_{5} (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))} (M_{1}^{1} (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} (c_{5} (c_{5} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} c_{8}))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{9})) x_{-126}) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (I^{[x_{113},x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),c_{8}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} c_{8}),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} (c_{5} (c_{5} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} c_{8}))) x_{-126}) (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (I^{[x_{113},x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),c_{9}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} c_{9}),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} (c_{5} (c_{5} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))) x_{-126}) (c_{4} (c_{7} c_{9}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (I^{[x_{113},x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} c_{8})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} (c_{7} c_{8})),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} (c_{5} (c_{5} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))) x_{-126}) (c_{4} (c_{7} (c_{7} c_{8})) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{9}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (I^{[x_{113},x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} (c_{7} c_{9}))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} (c_{7} (c_{7} c_{9}))),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} (c_{5} (c_{5} x_{-126} (c_{4} (c_{7} (c_{7} (c_{7} c_{9}))) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} (c_{7} c_{8})) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{9}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (I^{[x_{113},x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} (c_{5} x_{-126} (c_{4} (c_{7} (c_{7} c_{8})) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{9}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (S (I^{[x_{114},x_{112},x_{113} := (c_{7} (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} (c_{7} (c_{7} c_{9})))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}) (S (L^{\\lambda x_{-126}.c_{4} x_{-126} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))} (I^{[x_{113},x_{112} := (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))),(c_{7} (c_{7} c_{9}))]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}))))) (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} x_{-126} (c_{4} (c_{7} c_{9}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (S (I^{[x_{114},x_{112},x_{113} := (c_{7} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9})))),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} (c_{7} c_{8}))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}) (S (L^{\\lambda x_{-126}.c_{4} x_{-126} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))} (I^{[x_{113},x_{112} := (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))),(c_{7} c_{8})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}))))) (L^{\\lambda x_{-126}.c_{5} (c_{5} x_{-126} (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (S (I^{[x_{114},x_{112},x_{113} := (c_{7} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8}))),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} c_{9})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}) (S (L^{\\lambda x_{-126}.c_{4} x_{-126} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))} (I^{[x_{113},x_{112} := (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})),c_{9}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}))))) (L^{\\lambda x_{-126}.c_{5} x_{-126} (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (S (I^{[x_{114},x_{112},x_{113} := (c_{7} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9})),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} c_{8})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}) (S (L^{\\lambda x_{-126}.c_{4} x_{-126} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))} (I^{[x_{113},x_{112} := (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}),c_{8}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}))))) (L^{\\lambda x_{-126}.c_{5} x_{-126} (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (I^{[x_{112},x_{113} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (I^{[x_{113},x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cbb} c_{7} (\\Phi_{(bbb,)} c_{5}) c_{4})}) (I^{[x_{112},x_{113} := (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8}),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (I^{[x_{112},x_{113} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})}) (S (I^{[x_{112} := (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (S (M_{3} (S (I^{[x_{112} := (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{8})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{8})} (S (M_{3} (S (I^{[x_{112} := (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{9})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{9})} (S (M_{3} (S (I^{[x_{112} := (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} c_{8}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} c_{8}))} (S (M_{3} (S (I^{[x_{112} := (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))} (S (M_{3} (S (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} x_{122}))} (I^{[x_{112} := c_{9}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) x_{122}} (I^{[x_{112} := c_{9}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (I^{[x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{9} c_{2})})) A^{= T c_{8}})))) (S (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) x_{122}} (I^{[x_{112} := c_{9}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (I^{[x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{9} c_{2})})) A^{= T c_{8}}))))) (S (S (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) x_{122}} A^{= (c_{7} c_{8}) c_{9}}) (I^{[x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{9} c_{2})})) A^{= T c_{8}}))))) (S (I^{[x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{9} c_{2})}) A^{= T c_{8}}))))) (S (I^{[x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{2})} (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) x_{122}} (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) x_{122}} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{1} (c_{4} x_{114} (c_{7} x_{112})) x_{122})} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{1} x_{122} (c_{2} x_{113} x_{112}))} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})))) (I^{[x_{113} := (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112}))]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})})))))) (S (I^{[x_{112},x_{113} := c_{8},(c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})} (I^{[x_{112} := (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}})))	EO (CA (AI DS (AI DS (AI DS (AI DS (AI DS DS)))))):c_{5} (c_{5} (c_{5} (c_{5} (c_{5} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} c_{8}))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{9})) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{8})) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})
594	744	t	M_{4} (I^{[x_{69},x_{101},x_{102} := (\\lambda x_{-126}.c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) x_{-126}),(c_{5} (c_{5} (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{17} c_{18} x_{120})) (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{16} c_{18} x_{120}))) (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))),(c_{5} (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120})) (c_{1} c_{9} (c_{16} c_{18} x_{120})))]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))} (M_{1}^{1} (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{17} c_{18} x_{120})) x_{-126}) (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))} (I^{[x_{113},x_{112} := (c_{1} c_{9} (c_{16} c_{18} x_{120})),(c_{16} c_{18} x_{120})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} (c_{16} c_{18} x_{120})),(c_{1} c_{9} (c_{16} c_{18} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{-126}.c_{5} (c_{5} x_{-126} (c_{4} (c_{7} (c_{16} c_{18} x_{120})) (c_{1} c_{9} (c_{16} c_{18} x_{120})))) (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))} (I^{[x_{113},x_{112} := (c_{1} c_{9} (c_{16} c_{18} x_{120})),(c_{17} c_{18} x_{120})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} (c_{17} c_{18} x_{120})),(c_{1} c_{9} (c_{16} c_{18} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (L^{\\lambda x_{-126}.c_{5} x_{-126} (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))} (S (I^{[x_{114},x_{112},x_{113} := (c_{7} (c_{17} c_{18} x_{120})),(c_{1} c_{9} (c_{16} c_{18} x_{120})),(c_{7} (c_{16} c_{18} x_{120}))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}) (S (L^{\\lambda x_{-126}.c_{4} x_{-126} (c_{1} c_{9} (c_{16} c_{18} x_{120}))} (I^{[x_{113},x_{112} := (c_{17} c_{18} x_{120}),(c_{16} c_{18} x_{120})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}))))) (L^{\\lambda x_{-126}.c_{5} x_{-126} (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))} (I^{[x_{112},x_{113} := (c_{1} c_{9} (c_{16} c_{18} x_{120})),(c_{7} (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (I^{[x_{113},x_{112} := (c_{1} c_{9} (c_{16} c_{18} x_{120})),(c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cbb} c_{7} (\\Phi_{(bbb,)} c_{5}) c_{4})}) (I^{[x_{112},x_{113} := (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120})),(c_{1} c_{9} (c_{16} c_{18} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (I^{[x_{112},x_{113} := (c_{1} c_{9} (c_{16} c_{18} x_{120})),(c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})}) (S (I^{[x_{112} := (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))} (S (M_{3} (S (I^{[x_{112} := (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{16} c_{18} x_{120}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{16} c_{18} x_{120}))} (S (M_{3} (S (S (L^{\\lambda x_{122}.c_{2} x_{122} (c_{17} c_{18} x_{120})} (I^{[x_{112} := (c_{16} c_{18} x_{120})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (S (L^{\\lambda x_{122}.c_{2} x_{122} (c_{17} c_{18} x_{120})} (I^{[x_{65} := c_{18}]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})}))) (I^{[x_{112} := (c_{17} c_{18} x_{120})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})})) A^{= T c_{8}})))) (S (I^{[x_{114},x_{112},x_{113} := c_{9},(c_{16} c_{18} x_{120}),(c_{16} c_{18} x_{120})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{1}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{2} \\Phi_{ccb} c_{1})} (L^{\\lambda x_{122}.c_{1} (c_{5} c_{9} (c_{16} c_{18} x_{120})) x_{122}} (I^{[x_{112} := (c_{16} c_{18} x_{120})]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{16} c_{18} x_{120})} (I^{[x_{112} := (c_{16} c_{18} x_{120})]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{5} c_{9}))})) (S (I^{[x_{112} := (c_{16} c_{18} x_{120})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (S (I^{[x_{65} := c_{18}]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})}))) A^{= (\\Phi_{K} T) (\\Phi_{b} (c_{17} c_{18}))}))))) (S (L^{\\lambda x_{122}.c_{4} x_{122} (c_{16} c_{18} x_{120})} (I^{[x_{65} := c_{18}]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})})) (I^{[x_{112} := (c_{16} c_{18} x_{120})]} A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))))	EO (CA (AI DS (AI DS DS))):c_{5} (c_{5} (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{17} c_{18} x_{120})) (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{16} c_{18} x_{120}))) (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))
763	1026	f	c_{4} x_{113} x_{112}	WR
784	1039	t	I^{[x_{112},x_{113} := (c_{5} (c_{4} x_{114} x_{113}) x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (S (I^{[x_{112},x_{113} := (c_{5} (c_{4} x_{114} x_{113}) x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{114},x_{112} := (c_{4} x_{114} x_{113}),x_{112},x_{113}]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} (\\Phi_{(bbcb,b)} c_{2}) c_{5} \\Phi_{cc(bbb,)} c_{2} c_{5})} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{4})})))	WR
767	1030	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{2} (c_{5} x_{113} x_{112}) x_{112}) (c_{2} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{2} x_{113} x_{112}),(c_{2} (c_{5} x_{113} x_{112}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := (c_{2} (c_{5} x_{113} x_{112}) x_{112}),(c_{2} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (I^{[x_{112} := (c_{2} (c_{2} (c_{5} x_{113} x_{112}) x_{112}) (c_{2} x_{113} x_{112}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{2} (c_{5} x_{113} x_{112}) x_{112}) (c_{2} x_{113} x_{112}))} (S (M_{3} (S (I^{[x_{112},x_{113} := (c_{2} x_{113} x_{112}),(c_{2} (c_{5} x_{113} x_{112}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (I^{[x_{112},x_{113} := (c_{2} (c_{5} x_{113} x_{112}) x_{112}),(c_{2} x_{113} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (I^{[x_{112},x_{113} := (c_{7} (c_{2} (c_{5} x_{113} x_{112}) x_{112})),(c_{7} (c_{2} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}))) (S (L^{\\lambda x_{122}.c_{3} (c_{7} x_{122}) (c_{7} (c_{2} (c_{5} x_{113} x_{112}) x_{112}))} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{3} (c_{7} (c_{4} x_{113} (c_{7} x_{112}))) (c_{7} x_{122})} (I^{[x_{113} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{122}.c_{3} (c_{7} (c_{4} x_{113} (c_{7} x_{112}))) (c_{7} (c_{4} (c_{5} x_{113} x_{122}) (c_{7} x_{112})))} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{3} (c_{7} (c_{4} x_{113} (c_{7} x_{112}))) (c_{7} x_{122})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cbb} c_{7} (\\Phi_{(bbb,)} c_{4}) c_{5})})) (I^{[x_{112},x_{113} := (c_{7} (c_{4} x_{113} (c_{7} x_{112}))),(c_{7} (c_{4} x_{113} (c_{7} x_{112})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{112} := (c_{7} (c_{4} x_{113} (c_{7} x_{112})))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})})) A^{= T c_{8}}))))) (S (L^{\\lambda x_{122}.c_{2} x_{122} (c_{2} x_{113} x_{112})} (I^{[x_{113} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (S (L^{\\lambda x_{122}.c_{2} (c_{4} (c_{5} x_{113} x_{122}) (c_{7} x_{112})) (c_{2} x_{113} x_{112})} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{2} x_{122} (c_{2} x_{113} x_{112})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cbb} c_{7} (\\Phi_{(bbb,)} c_{4}) c_{5})})) (S (L^{\\lambda x_{122}.c_{2} x_{122} (c_{2} x_{113} x_{112})} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (I^{[x_{112} := (c_{2} x_{113} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})})) A^{= T c_{8}})))	EO (MI (AI DS (CR DS)))
708	900	t	I^{[x_{112},x_{113} := (c_{2} (c_{4} x_{114} x_{113}) (c_{4} x_{114} x_{112})),(c_{2} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{3} x_{122} (c_{2} (c_{4} x_{114} x_{113}) (c_{4} x_{114} x_{112}))} (S A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (I^{[x_{69},x_{101},x_{102} := (\\lambda x_{-126}.c_{3} (c_{1} x_{113} (c_{4} x_{113} x_{112})) x_{-126}),(c_{2} (c_{4} x_{114} x_{113}) (c_{4} x_{114} x_{112})),(c_{4} x_{114} (c_{1} x_{113} (c_{4} x_{113} x_{112})))]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))} (M_{1}^{1} (I^{[x_{113},x_{112} := (c_{4} x_{114} x_{113}),(c_{4} x_{114} x_{112})]} A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} x_{113}) (c_{4} x_{122} (c_{4} x_{114} x_{112}))} (I^{[x_{112},x_{113} := x_{113},x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} x_{113}) x_{122}} (I^{[x_{114},x_{113} := (c_{4} x_{113} x_{114}),x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} x_{113}) (c_{4} x_{122} x_{112})} (I^{[x_{114},x_{113},x_{112} := x_{113},x_{114},x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} x_{113}) (c_{4} (c_{4} x_{113} x_{122}) x_{112})} (I^{[x_{112} := x_{114}]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} (c_{4} x_{113} x_{114}) x_{112})} (I^{[x_{112},x_{113} := x_{113},x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{122} x_{112})} (I^{[x_{112} := x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{114}) x_{122}} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{114}) x_{122}} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{114},x_{112},x_{113} := x_{113},x_{114},(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (I^{[x_{112},x_{113} := x_{114},(c_{1} x_{113} (c_{4} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (I^{[x_{112},x_{113} := (c_{1} x_{113} (c_{4} x_{113} x_{112})),x_{114}]} (M_{7}^{2} (A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{4})})))))	WR
706	900	t	L^{\\lambda x_{122}.c_{2} (c_{2} x_{122} (c_{4} x_{114} x_{112})) (c_{2} x_{113} x_{112})} (I^{[x_{112} := x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{2} x_{122} (c_{2} x_{113} x_{112})} (S (I^{[x_{113},x_{112} := (c_{4} x_{113} x_{114}),(c_{4} x_{114} x_{112})]} A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{122} (c_{4} x_{114} x_{112}))) (c_{2} x_{113} x_{112})} (I^{[x_{112},x_{113} := x_{113},x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{4} x_{113} x_{114}) x_{122}) (c_{2} x_{113} x_{112})} (I^{[x_{112} := (c_{4} x_{114} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{114} (c_{4} x_{113} x_{122}))) (c_{2} x_{113} x_{112})} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{2} x_{122} (c_{2} x_{113} x_{112})} (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{114} x_{122})} (I^{[x_{114},x_{113},x_{112} := x_{113},x_{112},x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{4} x_{113} x_{114}) x_{122}) (c_{2} x_{113} x_{112})} (I^{[x_{112},x_{113} := x_{114},(c_{4} (c_{4} x_{113} x_{112}) x_{114})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{4} x_{113} x_{114}) x_{122}) (c_{2} x_{113} x_{112})} (I^{[x_{114},x_{113},x_{112} := (c_{4} x_{113} x_{112}),x_{114},x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (L^{\\lambda x_{122}.c_{2} x_{122} (c_{2} x_{113} x_{112})} (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{114}) (c_{4} (c_{4} x_{113} x_{112}) x_{122})} (I^{[x_{112} := x_{114}]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}))) (L^{\\lambda x_{122}.c_{2} x_{122} (c_{2} x_{113} x_{112})} (I^{[x_{114},x_{112},x_{113} := x_{113},x_{114},(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{2} x_{122} (c_{2} x_{113} x_{112})} (I^{[x_{112},x_{113} := (c_{1} x_{113} (c_{4} x_{113} x_{112})),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{69},x_{101},x_{102} := (\\lambda x_{-126}.c_{2} (c_{4} x_{114} (c_{1} x_{113} (c_{4} x_{113} x_{112}))) x_{-126}),(c_{2} x_{113} x_{112}),(c_{1} x_{113} (c_{4} x_{113} x_{112}))]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))} (M_{1}^{1} (A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (I^{[x_{113},x_{112} := x_{114},(c_{1} x_{113} (c_{4} x_{113} x_{112}))]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{4})}))))))))))))	WL
797	1050	t	L^{\\lambda x_{122}.c_{16} x_{122} x_{120}} A^{= (\\Phi_{(cbbb,b)} c_{16} (\\Phi_{(bbb,b)} c_{19}) (\\Phi_{(bb,b)} c_{5}) c_{16} c_{24}) (\\Phi_{bb} \\Phi_{b} c_{25})} (I^{[x_{80},x_{121},x_{85} := (\\lambda x_{120}.\\lambda x_{85}.c_{5} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120})),x_{120},(c_{24} x_{66} x_{65})]} A^{= (\\Phi_{b} (\\Phi_{c(bb,)} c_{16} (\\Phi_{(bb,cb)} c_{5}))) (\\Phi_{cccb} \\Phi_{cb(bcb,)} c_{16} c_{19} (\\Phi_{ccccb} \\Phi_{cb}))}) (L^{\\lambda x_{122}.c_{5} (c_{5} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120})) x_{122}} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{16} \\Phi_{bcb} c_{4}) c_{16}) (\\Phi_{ccbb} \\Phi_{cbb} c_{16} \\Phi_{ccb} c_{24})}) (I^{[x_{112},x_{113} := (c_{4} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120})),(c_{5} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}) (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120})),(c_{16} x_{66} x_{120}),(c_{16} x_{65} x_{120})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}) (I^{[x_{69},x_{112} := (\\lambda x_{112}.c_{5} (c_{4} (c_{16} x_{66} x_{120}) x_{112}) (c_{16} x_{66} x_{120})),(c_{16} x_{65} x_{120})]} A^{= (\\Phi_{bbc} \\Phi_{b} c_{5} c_{8}) (\\Phi_{b} (\\Phi_{(bb,)} c_{5}))}) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{16} x_{66} x_{120})) (c_{16} x_{65} x_{120})} (I^{[x_{112},x_{113} := c_{8},(c_{16} x_{66} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{16} x_{66} x_{120})) (c_{16} x_{65} x_{120})} (I^{[x_{112} := (c_{16} x_{66} x_{120})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{16} x_{65} x_{120})} (I^{[x_{112} := (c_{16} x_{66} x_{120})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}))	SL
798	1051	t	L^{\\lambda x_{122}.c_{16} x_{122} x_{120}} A^{= (\\Phi_{cbbb} c_{16} (\\Phi_{(bbb,)} c_{19}) (\\Phi_{(bb,b)} c_{5}) c_{17}) (\\Phi_{bb} \\Phi_{b} c_{30})} (I^{[x_{80},x_{121},x_{85} := (\\lambda x_{120}.\\lambda x_{85}.c_{5} (c_{17} x_{66} x_{120}) (c_{16} x_{65} x_{120})),x_{120},x_{65}]} A^{= (\\Phi_{b} (\\Phi_{c(bb,)} c_{16} (\\Phi_{(bb,cb)} c_{5}))) (\\Phi_{cccb} \\Phi_{cb(bcb,)} c_{16} c_{19} (\\Phi_{ccccb} \\Phi_{cb}))}) (S (I^{[x_{114},x_{113},x_{112} := (c_{17} x_{66} x_{120}),(c_{16} x_{65} x_{120}),(c_{16} x_{65} x_{120})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{17} x_{66} x_{120}) x_{122}} (I^{[x_{112} := (c_{16} x_{65} x_{120})]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})}))	SL
517	644	t	I^{[x_{113},x_{112} := x_{114},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{4} x_{114} x_{122}} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})}) (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (S (L^{\\lambda x_{122}.c_{4} x_{122} (c_{7} x_{112})} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))) (S (I^{[x_{113} := (c_{2} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))	SL
516	643	f	L^{\\lambda x_{122}.c_{5} (c_{5} (c_{2} x_{80} x_{68}) x_{122}) (c_{4} x_{68} x_{67})} (I^{[x_{113},x_{112} := x_{80},x_{67}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{4} x_{80} (c_{7} x_{67}))) (c_{4} x_{68} x_{67})} (I^{[x_{113},x_{112} := x_{80},x_{68}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{5} (c_{5} (c_{4} x_{80} (c_{7} x_{68})) x_{122}) (c_{4} x_{68} x_{67})} (I^{[x_{112},x_{113} := (c_{7} x_{67}),x_{80}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{4} (c_{7} x_{67}) x_{80})) (c_{4} x_{68} x_{67})} (I^{[x_{112},x_{113} := (c_{7} x_{68}),x_{80}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} x_{68} x_{67})} (I^{[x_{114},x_{112},x_{113} := (c_{7} x_{68}),x_{80},(c_{7} x_{67})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}))) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} x_{68} x_{67})} (I^{[x_{112},x_{113} := x_{80},(c_{5} (c_{7} x_{68}) (c_{7} x_{67}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} x_{80} x_{122}) (c_{4} x_{68} x_{67})} (I^{[x_{113},x_{112} := x_{68},x_{67}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})})))	SL
364	523	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))} (I^{[x_{112},x_{113} := (c_{4} (c_{2} x_{113} x_{112}) x_{112}),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := c_{8},(c_{4} (c_{2} x_{113} x_{112}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (I^{[x_{112} := (c_{2} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))} (S (M_{3} (S (L^{\\lambda x_{122}.c_{3} c_{8} (c_{4} x_{122} x_{112})} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (S (L^{\\lambda x_{122}.c_{3} c_{8} x_{122}} (I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{3} c_{8} (c_{4} x_{113} x_{122})} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (L^{\\lambda x_{122}.c_{3} c_{8} x_{122}} (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{3} c_{8} x_{122}} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) (I^{[x_{112},x_{113} := c_{8},c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) A^{= T c_{8}})))) (S (I^{[x_{112} := (c_{4} (c_{2} x_{113} x_{112}) x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))}) A^{= T c_{8}})))	EO (MI (AI DS DS))
712	416	f		
719	897	f	S (L^{\\lambda x_{122}.c_{62} x_{115} (\\lambda x_{121}.x_{82} (x_{102} x_{121})) (\\lambda x_{121}.x_{122})} (I^{[x_{69} := (x_{102} x_{121})]} A^{= (\\Phi_{b} (\\Phi_{bb} \\Phi_{K})) (\\Phi_{ccbbb} c_{15} \\Phi_{b} (\\Phi_{cbbb} c_{62}) \\Phi_{ccb} \\Phi_{b})})) (S (I^{[x_{82},x_{81},x_{80} := (\\lambda x_{121}.x_{82} (x_{102} x_{121})),(\\lambda x_{121}.\\lambda x_{122}.c_{15} (x_{102} x_{121}) x_{122}),(\\lambda x_{121}.\\lambda x_{122}.x_{80} x_{122})]} A^{= (\\Phi_{c(cccbcbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bcb} \\Phi_{b} \\Phi_{ccbbbb} \\Phi_{b} \\Phi_{(bbb,bb)} c_{62} c_{62}) (\\Phi_{(bcbbcb,ccbb)} \\Phi_{bb} \\Phi_{b} \\Phi_{bcb} \\Phi_{bb} (\\Phi_{K} c_{8}) c_{62} \\Phi_{cbb} c_{5} \\Phi_{(b(cbb,b),bb)} c_{62})})) (L^{\\lambda x_{122}.c_{62} x_{115} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{62} x_{115} (\\lambda x_{121}.x_{122}) (\\lambda x_{121}.x_{80} x_{121}))} (I^{[x_{112},x_{113} := (x_{82} (x_{102} x_{120})),(c_{15} (x_{102} x_{120}) x_{121})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))	SR
709	901	f	I^{[x_{112},x_{113} := (c_{5} x_{114} x_{112}),(c_{5} x_{114} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (I^{[x_{113},x_{112} := (c_{5} x_{114} x_{112}),(c_{5} x_{114} x_{113})]} A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{1} (c_{5} x_{114} x_{112}) (c_{4} (c_{5} x_{114} x_{112}) x_{122})} (I^{[x_{112},x_{113} := x_{113},x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{5} x_{114} x_{112}) (c_{4} x_{122} (c_{5} x_{113} x_{114}))} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{5} x_{114} x_{112}) x_{122}} (I^{[x_{114},x_{112} := x_{112},x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})})))	WR
714	774	f		
717	412	t	S (S (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}	DS
721	914	t	S (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	SR
722	915	t	S A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}	DS
723	915	t	S (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}) (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})})	DS
724	916	t	S (S (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}) (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))	SR
725	917	t	M_{4} (S (I^{[x_{114},x_{112} := x_{112},(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (M_{1}^{1} (A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})))	EO DS
726	918	t	M_{4} (S (I^{[x_{114},x_{113} := x_{112},(c_{1} x_{113} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (M_{1}^{1} (A^{= (\\Phi_{cbb} c_{1} \\Phi_{b(b,)} c_{1}) (\\Phi_{b} \\Phi_{K})})))	EO DS
795	1048	t	S (L^{\\lambda x_{-126}.c_{62} c_{5} (\\Phi_{K} c_{8}) (\\lambda x_{65}.x_{-126})} (M_{3} (S (L^{\\lambda x_{-126}.c_{62} c_{5} (\\Phi_{K} c_{8}) (\\lambda x_{66}.x_{-126})} (M_{3} (I^{[x_{114},x_{112},x_{113} := (c_{15} x_{66} x_{65}),(c_{5} (c_{62} c_{5} (\\lambda x_{65}.c_{8}) (\\lambda x_{67}.c_{17} x_{66} x_{67})) (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{17} x_{65} x_{120}))),(c_{62} c_{5} (\\lambda x_{66}.c_{8}) (\\lambda x_{67}.c_{1} (c_{16} x_{66} x_{67}) (c_{16} x_{65} x_{67})))]} (M_{6} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{2}) c_{2} c_{2})})) (I^{[x_{69},x_{101},x_{102} := (\\lambda x_{-126}.c_{2} (c_{62} c_{5} (\\lambda x_{66}.c_{8}) (\\lambda x_{67}.c_{1} (c_{16} x_{66} x_{67}) (c_{16} x_{65} x_{67}))) x_{-126}),(c_{5} (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{17} x_{66} x_{120})) (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{17} x_{65} x_{120}))),(c_{5} (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{17} x_{65} x_{120}) c_{8})) (c_{62} c_{5} (\\lambda x_{65}.c_{8}) (\\lambda x_{67}.c_{1} (c_{16} x_{66} x_{67}) (c_{16} x_{65} x_{67}))))]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))} (M_{1}^{1} (S (L^{\\lambda x_{122}.c_{5} (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{17} x_{66} x_{120})) (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122}))} (I^{[x_{113} := (c_{17} x_{65} x_{120})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (S (L^{\\lambda x_{122}.c_{5} (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})) (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{17} x_{65} x_{120}) c_{8}))} (I^{[x_{113} := (c_{17} x_{66} x_{120})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))) (I^{[x_{115},x_{82},x_{81},x_{80} := c_{5},(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{1} (c_{17} x_{66} x_{120}) c_{8}),(\\lambda x_{120}.c_{1} (c_{17} x_{65} x_{120}) c_{8})]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})}) (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{1} (c_{17} x_{65} x_{120}) c_{8}))} (I^{[x_{112},x_{113} := c_{8},(c_{17} x_{66} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{113},x_{114},x_{112} := (c_{17} x_{65} x_{120}),(c_{17} x_{66} x_{120}),c_{8}]} A^{= (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{1} c_{1}) (\\Phi_{ccbb} (\\Phi_{(bcb,b)} c_{5}) c_{1} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{1} (c_{17} x_{65} x_{120}) x_{122}) (c_{1} (c_{17} x_{65} x_{120}) c_{8}))} (I^{[x_{65} := x_{66}]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})})) (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{1} x_{122} (c_{7} (c_{16} x_{66} x_{120}))) (c_{1} (c_{17} x_{65} x_{120}) c_{8}))} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})}) (S (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{1} (c_{17} x_{65} x_{120}) c_{8}))} (I^{[x_{113},x_{112} := (c_{7} (c_{16} x_{65} x_{120})),(c_{16} x_{66} x_{120})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}))) (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{7} x_{122}) (c_{1} (c_{17} x_{65} x_{120}) c_{8}))} (I^{[x_{112},x_{113} := (c_{16} x_{66} x_{120}),(c_{7} (c_{16} x_{65} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{7} x_{122}) (c_{1} (c_{17} x_{65} x_{120}) c_{8}))} (I^{[x_{113},x_{112} := (c_{16} x_{66} x_{120}),(c_{16} x_{65} x_{120})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}))) (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{1} (c_{17} x_{65} x_{120}) c_{8}))} (I^{[x_{112} := (c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{112},x_{113} := (c_{1} (c_{17} x_{65} x_{120}) c_{8}),(c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (I^{[x_{115},x_{82},x_{81},x_{80} := c_{5},(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{1} (c_{17} x_{65} x_{120}) c_{8}),(\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})})))) (I^{[x_{112},x_{113} := (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))),(c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{17} x_{65} x_{120}) c_{8}))]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})})) A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(cbb,bb)} c_{16} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{(bb,bbb)} c_{2}) c_{15} (\\Phi_{(bb,b)} c_{1}) c_{16})})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} c_{5}) \\Phi_{b})})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} c_{5}) \\Phi_{b})})) A^{= T c_{8}}	GE (GE WL)
809	1047	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{15} x_{66} x_{65}) (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))))} (I^{[x_{112},x_{113} := (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))),(c_{15} x_{66} x_{65})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := (c_{15} x_{66} x_{65}),(c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (I^{[x_{112} := (c_{2} (c_{15} x_{66} x_{65}) (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{15} x_{66} x_{65}) (c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))))} (S (M_{3} (S (I^{[x_{112},x_{113} := (c_{62} c_{5} (\\lambda x_{68}.c_{8}) (\\lambda x_{68}.c_{1} (c_{16} x_{66} x_{68}) (c_{16} x_{65} x_{68}))),(c_{15} x_{66} x_{65})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{2} x_{122} (c_{15} x_{66} x_{65})} (I^{[x_{113} := (c_{62} c_{5} (\\lambda x_{68}.c_{8}) (\\lambda x_{68}.c_{1} (c_{16} x_{66} x_{68}) (c_{16} x_{65} x_{68})))]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}) (L^{\\lambda x_{122}.c_{2} x_{122} (c_{15} x_{66} x_{65})} (I^{[x_{112},x_{113} := (c_{62} c_{5} (\\lambda x_{68}.c_{8}) (\\lambda x_{68}.c_{1} (c_{16} x_{66} x_{68}) (c_{16} x_{65} x_{68}))),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{2} (c_{1} x_{122} (c_{62} c_{5} (\\lambda x_{68}.c_{8}) (\\lambda x_{68}.c_{1} (c_{16} x_{66} x_{68}) (c_{16} x_{65} x_{68})))) (c_{15} x_{66} x_{65})} (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} c_{5}) \\Phi_{b})}) (L^{\\lambda x_{122}.c_{2} x_{122} (c_{15} x_{66} x_{65})} (S (L^{\\lambda x_{122}.c_{1} (c_{62} c_{5} (\\lambda x_{67}.c_{8}) (\\lambda x_{67}.x_{122})) (c_{62} c_{5} (\\lambda x_{68}.c_{8}) (\\lambda x_{68}.c_{1} (c_{16} x_{66} x_{68}) (c_{16} x_{65} x_{68})))} (I^{[x_{113} := (c_{16} x_{66} x_{67})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{69},x_{102},x_{101} := (\\lambda x_{121}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{121} x_{120}))),x_{66},x_{65}]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{15} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})}))))))))) (S (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(cbb,bb)} c_{16} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{(bb,bbb)} c_{2}) c_{15} (\\Phi_{(bb,b)} c_{1}) c_{16})})) A^{= T c_{8}})))	EO (MI (AI DS WR))
800	1053	f	S (S (I^{[x_{66},x_{65} := c_{18},(c_{22} c_{18})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{1}) c_{16})}) (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} x_{122} (c_{16} (c_{22} c_{18}) x_{120}))} A^{= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{16} c_{18}))}) (S (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{112} := (c_{16} (c_{22} c_{18}) x_{120})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})}))) (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{7} x_{122})} (I^{[x_{66} := c_{18}]} A^{= (\\Phi_{ccbbbb} \\Phi_{cb} c_{16} \\Phi_{bcb} (c_{62} c_{4}) \\Phi_{b} c_{16}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{22})})) (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{7} (c_{62} c_{4} (\\lambda x_{67}.x_{122}) (\\lambda x_{67}.c_{16} x_{67} x_{120})))} (I^{[x_{120} := x_{67}]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{16} c_{18}))})) (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{7} x_{122})} (I^{[x_{117},x_{115},x_{80} := c_{9},c_{4},(\\lambda x_{68}.c_{16} x_{68} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{K} (\\Phi_{cbcb} \\Phi_{b} \\Phi_{bb} (\\Phi_{K} c_{9}) c_{62}))})) (L^{\\lambda x_{122}.c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} A^{= c_{8} (c_{7} c_{9})}) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} c_{5}) \\Phi_{b})})) A^{= T c_{8}}	EO DS
\.


--
-- Name: solucion_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.solucion_id_seq', 819, true);


--
-- Data for Name: teorema; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.teorema (id, enunciado, esquema, aliases, purecombstheoid, constlist) FROM stdin;
14	= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})	f		1	
15	= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})	f		2	
30	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{4}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{4})	f		36	
45	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{4} c_{5} \\Phi_{cbcb})	f		50	
49	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})	f		54	
69	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{1}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{2} \\Phi_{ccb} c_{1})	f		70	
87	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cbb} c_{5} (\\Phi_{(bbb,b)} (\\Phi_{(bb,b)} c_{2}) c_{5}) c_{4})	f		84	
99	= (\\Phi_{cb} c_{1} (\\Phi_{(cbbbb,b)} c_{5} \\Phi_{bbb} \\Phi_{bb} c_{2})) (\\Phi_{cbcb} c_{1} \\Phi_{bb} c_{5} (\\Phi_{(bbb,bb)} \\Phi_{bb} c_{2}))	f		95	
210	= (\\Phi_{bb} (\\Phi_{cbbbb} c_{15} \\Phi_{bb} \\Phi_{bb} c_{5}) c_{15}) (\\Phi_{ccccbb} c_{31} \\Phi_{cbbb} \\Phi_{bb} c_{15} \\Phi_{cccbb} c_{31})	f		170	31
186	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{16} \\Phi_{bcb} c_{5}) c_{17}) (\\Phi_{ccbb} \\Phi_{cbb} c_{16} \\Phi_{ccb} c_{30})	f		192	16,17,30
442	= (c_{55} c_{47} c_{51}) (c_{54} c_{43} c_{46})	f		316	55,47,51,54,43,46
295	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{3} (\\Phi_{(bbcb,b)} c_{2}) c_{3} \\Phi_{cc(bbb,)} c_{2} c_{3})	f		263	
306	= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{bb} \\Phi_{b} c_{3})	f		274	
321	= T (c_{66} c_{44} c_{42})	f		133	66,44,42
320	= T (c_{68} c_{43} c_{44})	f		133	68,43,44
330	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{3}) c_{5} c_{4})	f		281	
443	= (c_{55} c_{48} c_{51}) (c_{54} c_{43} c_{47})	f		316	55,48,51,54,43,47
444	= (c_{55} c_{49} c_{51}) (c_{54} c_{43} c_{48})	f		316	55,49,51,54,43,48
445	= (c_{55} c_{50} c_{51}) (c_{54} c_{43} c_{49})	f		316	55,50,51,54,43,49
446	= (c_{55} c_{51} c_{51}) (c_{54} c_{43} c_{50})	f		318	55,51,54,43,50
126	= (\\Phi_{bbbb} \\Phi_{b} c_{4} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{bb} c_{7})) (\\Phi_{cbbb} \\Phi_{K} \\Phi_{bb} (c_{62} c_{5}) \\Phi_{b})	f		331	
123	= (\\Phi_{ccbbbb} (\\Phi_{(bb,(bb,b))} c_{1}) c_{5} \\Phi_{(b,cb)} \\Phi_{bcb} (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{cbbcb} \\Phi_{b} \\Phi_{bb} (c_{62} c_{5})))	f		344	
167	= (\\Phi_{(cccccbbb,b)} c_{35} c_{35} c_{16} (\\Phi_{bcccb} (c_{62} c_{4} (\\Phi_{K} c_{8}))) c_{5} (\\Phi_{(bcccbb,bbb)} c_{19} (\\Phi_{bc(ccbbb,)} (c_{62} c_{4} (\\Phi_{K} c_{8})) c_{31} c_{15})) (\\Phi_{(bb,bcbcb)} c_{5}) c_{16} c_{24}) (\\Phi_{bb} \\Phi_{b} c_{32})	f		396	35,16,19,31,24,32
147	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{ccccc(bcbbb,cbbb)} \\Phi_{b} (c_{62} c_{4}) \\Phi_{b} (c_{62} c_{4}) \\Phi_{bcb} \\Phi_{c(bbbb,bb)} \\Phi_{b} \\Phi_{bbb} (c_{62} c_{5}) \\Phi_{b} \\Phi_{cb} (\\Phi_{(bbcb,bb)} c_{2}) (c_{62} c_{5}) \\Phi_{b})	f		358	
156	= (\\Phi_{(bccbbbb,b)} c_{19} \\Phi_{cb} c_{16} \\Phi_{bcb} (c_{62} c_{5}) \\Phi_{b} c_{16} c_{22}) (\\Phi_{b} c_{23})	f		398	19,16,22,23
113	= (\\Phi_{K} T) (\\Phi_{(b(bbb,cccbbb),b)} c_{2} (c_{62} c_{4}) \\Phi_{b} c_{16} c_{16} \\Phi_{b} (c_{62} c_{5}) \\Phi_{cbbb} \\Phi_{b} c_{17} (c_{12} c_{18}))	f		428	16,17,18
82	= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{9} c_{2})	f		3	
83	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{4})	f		4	
84	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})	f		5	
85	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{2}) c_{4} c_{5})	f		6	
447	= (c_{54} (c_{54} c_{46} c_{43}) c_{45}) (c_{55} (c_{54} c_{49} c_{44}) (c_{54} (c_{54} c_{45} c_{46}) c_{43}))	f		320	54,46,43,45,55,49,44
296	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbb,b)} c_{2} c_{3} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)} c_{2} c_{2})	f		264	
307	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{3}) c_{3} c_{3})	f		275	
350	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{K} (\\Phi_{cbcb} \\Phi_{b} \\Phi_{bb} (\\Phi_{K} c_{9}) c_{62}))	f		296	
460	= \\Phi_{} (\\Phi_{cb} c_{9} c_{4})	f		410	
461	= (\\Phi_{K} c_{9}) (\\Phi_{cb} c_{9} c_{5})	f		411	
462	= \\Phi_{} (\\Phi_{cb} c_{8} c_{5})	f		412	
463	= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{8} c_{4})	f		413	
143	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbbb,b)} (c_{62} c_{4}) (\\Phi_{(bbb,bb)} c_{2}) \\Phi_{b} (\\Phi_{cccbbb} \\Phi_{b}) (c_{62} c_{4}) \\Phi_{b} (\\Phi_{(bb,b)} c_{4}))	f		354	
146	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bbbb,)} \\Phi_{bb} c_{2} (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{b})	f		357	
353	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))) (\\Phi_{c(cccc(c(cb,b),b),b)} \\Phi_{b} (\\Phi_{(bb,b)} c_{4}) (\\Phi_{b(bb,b)} c_{7} c_{5}) \\Phi_{cccc(cc(bbbb,b),b)} (c_{62} c_{5} (\\Phi_{K} c_{8})) \\Phi_{b} (\\Phi_{(b(bbcbb,cbb),bb)} c_{2} c_{15}) (\\Phi_{ccc(ccccc(cbb,b),bb)} \\Phi_{b} \\Phi_{b} \\Phi_{b}) c_{62} c_{62} c_{62})	f		401	
392	= (c_{55} c_{46} c_{45}) c_{49}	f		34	55,46,45,49
297	= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{3} c_{7}) (\\Phi_{bb} \\Phi_{b} c_{2})	f		265	
308	= T (c_{65} c_{43} c_{42})	f		133	65,43,42
309	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{65}) c_{65} c_{65})	f		276	65
323	= T (c_{67} c_{42} c_{44})	f		133	67,42,44
142	= (\\Phi_{K} c_{9}) (\\Phi_{cbb} (\\Phi_{K} c_{9}) (c_{62} c_{4}) \\Phi_{b})	f		353	
351	= (\\Phi_{c(b(cbb,),b)} \\Phi_{b} (\\Phi_{ccbbb} \\Phi_{b} \\Phi_{b}) \\Phi_{bcbb} (\\Phi_{cc(bbbb,b)} \\Phi_{b}) c_{62} c_{62}) (\\Phi_{ccc((bb,b),b)} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{(bb,b)} c_{4}) \\Phi_{cc(ccbb,b)} (\\Phi_{cccc(cbb,b)} \\Phi_{b} \\Phi_{b}) \\Phi_{(bcbb,cbb)} c_{62} c_{62})	f		297	
352	= (\\Phi_{c(b(cbb,),b)} \\Phi_{b} (\\Phi_{ccbbb} \\Phi_{b} \\Phi_{b}) \\Phi_{bcbb} (\\Phi_{cc(bbbb,b)} \\Phi_{b}) c_{62} c_{62}) (\\Phi_{ccbb} (\\Phi_{(bb,b)} c_{4}) \\Phi_{ccbb} (\\Phi_{cccbb} \\Phi_{b} \\Phi_{cbb}) c_{62})	f		298	
374	= (c_{55} c_{44} c_{43}) c_{45}	f		34	55,44,43,45
375	= (c_{55} c_{45} c_{43}) c_{46}	f		34	55,45,43,46
376	= (c_{55} c_{46} c_{43}) c_{47}	f		34	55,46,43,47
377	= (c_{55} c_{47} c_{43}) c_{48}	f		34	55,47,43,48
378	= (c_{55} c_{48} c_{43}) c_{49}	f		34	55,48,43,49
379	= (c_{55} c_{49} c_{43}) c_{50}	f		34	55,49,43,50
380	= (c_{55} c_{50} c_{43}) c_{51}	f		34	55,50,43,51
381	= (c_{55} c_{51} c_{43}) (c_{54} c_{43} c_{42})	f		315	55,51,43,54,42
382	= (c_{55} c_{44} c_{44}) c_{46}	f		179	55,44,46
383	= (c_{55} c_{45} c_{44}) c_{47}	f		34	55,45,44,47
384	= (c_{55} c_{46} c_{44}) c_{48}	f		34	55,46,44,48
385	= (c_{55} c_{47} c_{44}) c_{49}	f		34	55,47,44,49
386	= (c_{55} c_{48} c_{44}) c_{50}	f		34	55,48,44,50
387	= (c_{55} c_{49} c_{44}) c_{51}	f		34	55,49,44,51
388	= (c_{55} c_{50} c_{44}) (c_{54} c_{43} c_{42})	f		316	55,50,44,54,43,42
389	= (c_{55} c_{51} c_{44}) (c_{54} c_{43} c_{43})	f		317	55,51,44,54,43
390	= (c_{55} c_{44} c_{45}) c_{47}	f		34	55,44,45,47
391	= (c_{55} c_{45} c_{45}) c_{48}	f		179	55,45,48
393	= (c_{55} c_{47} c_{45}) c_{50}	f		34	55,47,45,50
394	= (c_{55} c_{48} c_{45}) c_{51}	f		34	55,48,45,51
395	= (c_{55} c_{49} c_{45}) (c_{54} c_{43} c_{42})	f		316	55,49,45,54,43,42
396	= (c_{55} c_{50} c_{45}) (c_{54} c_{43} c_{43})	f		317	55,50,45,54,43
397	= (c_{55} c_{51} c_{45}) (c_{54} c_{43} c_{44})	f		316	55,51,45,54,43,44
398	= (c_{55} c_{44} c_{46}) c_{48}	f		34	55,44,46,48
399	= (c_{55} c_{45} c_{46}) c_{49}	f		34	55,45,46,49
400	= (c_{55} c_{46} c_{46}) c_{50}	f		179	55,46,50
401	= (c_{55} c_{47} c_{46}) c_{51}	f		34	55,47,46,51
402	= (c_{55} c_{48} c_{46}) (c_{54} c_{43} c_{42})	f		316	55,48,46,54,43,42
403	= (c_{55} c_{49} c_{46}) (c_{54} c_{43} c_{43})	f		317	55,49,46,54,43
404	= (c_{55} c_{50} c_{46}) (c_{54} c_{43} c_{44})	f		316	55,50,46,54,43,44
405	= (c_{55} c_{51} c_{46}) (c_{54} c_{43} c_{45})	f		316	55,51,46,54,43,45
406	= (c_{55} c_{44} c_{47}) c_{49}	f		34	55,44,47,49
407	= (c_{55} c_{45} c_{47}) c_{50}	f		34	55,45,47,50
408	= (c_{55} c_{46} c_{47}) c_{51}	f		34	55,46,47,51
409	= (c_{55} c_{47} c_{47}) (c_{54} c_{43} c_{42})	f		318	55,47,54,43,42
410	= (c_{55} c_{48} c_{47}) (c_{54} c_{43} c_{43})	f		317	55,48,47,54,43
411	= (c_{55} c_{49} c_{47}) (c_{54} c_{43} c_{44})	f		316	55,49,47,54,43,44
412	= (c_{55} c_{50} c_{47}) (c_{54} c_{43} c_{45})	f		316	55,50,47,54,43,45
413	= (c_{55} c_{51} c_{47}) (c_{54} c_{43} c_{46})	f		316	55,51,47,54,43,46
414	= (c_{55} c_{44} c_{48}) c_{50}	f		34	55,44,48,50
415	= (c_{55} c_{45} c_{48}) c_{51}	f		34	55,45,48,51
416	= (c_{55} c_{46} c_{48}) (c_{54} c_{43} c_{42})	f		316	55,46,48,54,43,42
417	= (c_{55} c_{47} c_{48}) (c_{54} c_{43} c_{43})	f		317	55,47,48,54,43
418	= (c_{55} c_{48} c_{48}) (c_{54} c_{43} c_{44})	f		318	55,48,54,43,44
419	= (c_{55} c_{49} c_{48}) (c_{54} c_{43} c_{45})	f		316	55,49,48,54,43,45
420	= (c_{55} c_{50} c_{48}) (c_{54} c_{43} c_{46})	f		316	55,50,48,54,43,46
421	= (c_{55} c_{51} c_{48}) (c_{54} c_{43} c_{47})	f		316	55,51,48,54,43,47
422	= (c_{55} c_{44} c_{49}) c_{51}	f		34	55,44,49,51
423	= (c_{55} c_{45} c_{49}) (c_{54} c_{43} c_{42})	f		316	55,45,49,54,43,42
424	= (c_{55} c_{46} c_{49}) (c_{54} c_{43} c_{43})	f		317	55,46,49,54,43
425	= (c_{55} c_{47} c_{49}) (c_{54} c_{43} c_{44})	f		316	55,47,49,54,43,44
426	= (c_{55} c_{48} c_{49}) (c_{54} c_{43} c_{45})	f		316	55,48,49,54,43,45
427	= (c_{55} c_{49} c_{49}) (c_{54} c_{43} c_{46})	f		318	55,49,54,43,46
428	= (c_{55} c_{50} c_{49}) (c_{54} c_{43} c_{47})	f		316	55,50,49,54,43,47
192	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{24} \\Phi_{bcb} c_{25}) c_{24}) (\\Phi_{ccbb} \\Phi_{cbb} c_{24} \\Phi_{ccb} c_{25})	f		12	24,25
198	= c_{18} (c_{23} (c_{20} c_{18}))	f		13	18,23,20
130	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbbb,bb)} \\Phi_{b} c_{2} \\Phi_{bbcb} (\\Phi_{c(cbbbb,)} (\\Phi_{(bb,b)} c_{5})) (c_{62} c_{5}) \\Phi_{b} (c_{62} c_{5}) \\Phi_{b})	f		336	
298	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbb,b)} c_{3} c_{3} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)} c_{5} c_{5})	f		266	
310	= (\\Phi_{bb} \\Phi_{b} c_{65}) (\\Phi_{cb} c_{67} \\Phi_{cb})	f		138	65,67
324	= (\\Phi_{K} T) (\\Phi_{(b,)} c_{66})	f		165	66
332	= (\\Phi_{ccbbb} \\Phi_{b} \\Phi_{b} (\\Phi_{cc(bbbb,b)} \\Phi_{b} (c_{62} c_{5}) \\Phi_{bcbb} c_{5}) (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cccbb} \\Phi_{b} \\Phi_{cbb} (c_{62} c_{5}) \\Phi_{ccbb} (\\Phi_{(bb,b)} c_{4}))	f		346	
141	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(c(bbb,ccbbb),bb)} \\Phi_{b} c_{4} (\\Phi_{cc(cbbbb,)} \\Phi_{cbb} c_{4}) (c_{62} c_{4}) \\Phi_{b} c_{1} c_{2} \\Phi_{cb(bb,bccb)} (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{b} (c_{62} c_{4}) \\Phi_{b})	f		352	
355	= (\\Phi_{c(ccccbb,b)} \\Phi_{b} \\Phi_{bcb} \\Phi_{cb} \\Phi_{bbbb} \\Phi_{bcb} (\\Phi_{cccbcbbb} \\Phi_{b}) c_{62} c_{62}) (\\Phi_{c(ccccbb,b)} \\Phi_{b} \\Phi_{bbb} \\Phi_{b} \\Phi_{cbbb} \\Phi_{bb} (\\Phi_{cccbcbbb} \\Phi_{b}) c_{62} c_{62})	f		301	
356	= (\\Phi_{cbbb} \\Phi_{bb} \\Phi_{bb} (\\Phi_{c(bbb,)} \\Phi_{bb} \\Phi_{bcb}) c_{62}) (\\Phi_{cbb} \\Phi_{b} (\\Phi_{bcbbb} \\Phi_{K} \\Phi_{b} \\Phi_{bb}) c_{62})	f		302	
357	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{15}) c_{69}) (\\Phi_{ccb} \\Phi_{cbb} c_{15} \\Phi_{ccb})	f		303	69
358	= (\\Phi_{c(cccbcbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bcb} \\Phi_{b} \\Phi_{ccbbbb} \\Phi_{b} \\Phi_{(bbb,bb)} c_{62} c_{62}) (\\Phi_{(bcbbcb,ccbb)} \\Phi_{bb} \\Phi_{b} \\Phi_{bcb} \\Phi_{bb} (\\Phi_{K} c_{8}) c_{62} \\Phi_{cbb} c_{5} \\Phi_{(b(cbb,b),bb)} c_{62})	f		304	
359	= (\\Phi_{(cbcbcb,bb)} \\Phi_{cb} \\Phi_{bcb} \\Phi_{cb} \\Phi_{bcb} (\\Phi_{K} c_{8}) c_{62} \\Phi_{(bcb,cb)} c_{62}) (\\Phi_{(cbbcb,cbb)} \\Phi_{b} \\Phi_{bcb} \\Phi_{bb} (\\Phi_{K} c_{8}) c_{62} \\Phi_{b} \\Phi_{(bbb,bb)} c_{62})	f		305	
429	= (c_{55} c_{51} c_{49}) (c_{54} c_{43} c_{48})	f		316	55,51,49,54,43,48
430	= (c_{55} c_{44} c_{50}) (c_{54} c_{43} c_{42})	f		316	55,44,50,54,43,42
431	= (c_{55} c_{45} c_{50}) (c_{54} c_{43} c_{43})	f		317	55,45,50,54,43
432	= (c_{55} c_{46} c_{50}) (c_{54} c_{43} c_{44})	f		316	55,46,50,54,43,44
433	= (c_{55} c_{47} c_{50}) (c_{54} c_{43} c_{45})	f		316	55,47,50,54,43,45
434	= (c_{55} c_{48} c_{50}) (c_{54} c_{43} c_{46})	f		316	55,48,50,54,43,46
435	= (c_{55} c_{49} c_{50}) (c_{54} c_{43} c_{47})	f		316	55,49,50,54,43,47
436	= (c_{55} c_{50} c_{50}) (c_{54} c_{43} c_{48})	f		318	55,50,54,43,48
437	= (c_{55} c_{51} c_{50}) (c_{54} c_{43} c_{49})	f		316	55,51,50,54,43,49
438	= (c_{55} c_{43} c_{51}) (c_{54} c_{43} c_{42})	f		221	55,43,51,54,42
439	= (c_{55} c_{44} c_{51}) (c_{54} c_{43} c_{43})	f		317	55,44,51,54,43
194	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c((cbbb,bbbb),)} c_{27} c_{23} (\\Phi_{(bbb,bcb)} c_{2}) c_{27} c_{23} c_{5} (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{b} c_{16})	f		378	27,23,16
464	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{15} c_{15} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})	f		414	
465	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{15} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})	f		415	
299	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbb,b)} c_{3} c_{3} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)} c_{4} c_{4})	f		267	
300	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbb,b)} c_{3} c_{3} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)} c_{3} c_{3})	f		268	
301	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{3} (\\Phi_{(bbcb,b)} c_{2}) c_{5} \\Phi_{cc(bbb,)} c_{3} c_{5})	f		269	
311	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{68}) c_{68} c_{68})	f		276	68
312	= (\\Phi_{bb} \\Phi_{b} c_{66}) (\\Phi_{cb} c_{68} \\Phi_{cb})	f		138	66,68
440	= (c_{55} c_{45} c_{51}) (c_{54} c_{43} c_{44})	f		316	55,45,51,54,43,44
441	= (c_{55} c_{46} c_{51}) (c_{54} c_{43} c_{45})	f		316	55,46,51,54,43,45
234	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(bcb,b)} (\\Phi_{(cb,b)} c_{5}) c_{5} (\\Phi_{b(ccccb,)} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{(b(b(bb,b),b),(bb,(bb,b)))} c_{1} c_{5} c_{5}))	f		324	
118	= (\\Phi_{bcb} (\\Phi_{bb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) c_{7} (\\Phi_{(bb,bb)} c_{4})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} c_{5}) \\Phi_{cbb} \\Phi_{b})	f		339	
122	= (\\Phi_{ccbbbb} (\\Phi_{(bb,bb)} c_{4}) c_{7} \\Phi_{bcb} \\Phi_{bb} (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cccb} \\Phi_{b} \\Phi_{cbcb} (c_{62} c_{5}) (\\Phi_{cccbb} (\\Phi_{(bb,b)} c_{5})))	f		343	
449	= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{1}) c_{16})	f		373	16
450	= T (c_{62} c_{5} (\\Phi_{K} c_{8}) (\\Phi_{bcccc(cb,bbb)} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{17} \\Phi_{b} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{5} c_{15} (\\Phi_{(bcb,cbbbb)} c_{2}) (c_{62} c_{5} (\\Phi_{K} c_{8})) \\Phi_{b} c_{17}))	f		387	17
451	= (\\Phi_{K} T) (\\Phi_{bcc(ccb,)} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{16} (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) c_{16} (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) (\\Phi_{bc(cccccb(cb,b),(cb,b))} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{16} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{(bcb,cbbbb)} c_{2}) c_{15} c_{5} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{bcccc(cb,bbb)} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{16})))	f		388	16
452	= T (c_{62} c_{5} (\\Phi_{K} c_{8}) (\\Phi_{bcc(ccbb,b)} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{15} (\\Phi_{(b(bb,b),b)} c_{1} c_{4}) c_{15} (\\Phi_{(b(bb,b),b)} c_{1} c_{4}) (\\Phi_{bc(cccccbcbb,cbb)} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{16} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{(bcb,cbbbb)} c_{2}) c_{15} c_{5} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{bcccc(cb,bbb)} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{16})) c_{15} c_{15}))	f		390	16
453	= T (c_{62} c_{5} (\\Phi_{K} c_{8}) (\\Phi_{bc(cccccbccbbbb,ccbbbb)} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{16} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{(bcb,cbbbb)} c_{2}) c_{15} c_{5} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{bcccc(cb,bbb)} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{16}) \\Phi_{cb} c_{16} (\\Phi_{(bbcb,b)} c_{1}) (c_{62} c_{4}) \\Phi_{b} c_{16} \\Phi_{cb} c_{16} (\\Phi_{(bbcb,b)} c_{1}) (c_{62} c_{4}) \\Phi_{b} c_{16}))	f		391	16
466	= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{15}) (\\Phi_{bb} \\Phi_{b} c_{12})	f		416	
467	= (\\Phi_{bbb} (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{b} c_{16}) (\\Phi_{b} (c_{12} c_{18}))	f		419	16,18
16	= c_{8} (c_{7} c_{9})	f		17	
17	= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})	f		18	
18	= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})	f		19	
19	= (\\Phi_{bb} \\Phi_{b} c_{6}) (\\Phi_{cb} c_{6} \\Phi_{cb})	f		20	
20	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{6}) c_{6}) (\\Phi_{cbbb} c_{6} \\Phi_{bb} \\Phi_{bb} c_{6})	f		21	
21	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{6}) c_{1}) (\\Phi_{cbbb} c_{6} \\Phi_{bb} \\Phi_{bb} c_{1})	f		22	
22	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{6}) (\\Phi_{cbbb} c_{6} \\Phi_{bb} \\Phi_{bb} c_{1})	f		23	
23	= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})	f		24	
229	= (\\Phi_{b} (\\Phi_{bb} \\Phi_{K})) (\\Phi_{ccbbb} c_{15} \\Phi_{b} (\\Phi_{cbbb} c_{62}) \\Phi_{ccb} \\Phi_{b})	f		25	
231	= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})	f		26	
24	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})	f		27	
25	= \\Phi_{} (\\Phi_{(b,)} c_{4})	f		28	
66	= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})	f		29	
67	= (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{1}) (\\Phi_{cb} c_{2} \\Phi_{cb})	f		30	
27	= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})	f		31	
28	= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))	f		32	
29	= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))	f		33	
263	= (c_{55} c_{43} c_{49}) c_{50}	f		34	55,43,49,50
50	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})	f		35	
261	= (c_{55} c_{43} c_{47}) c_{48}	f		34	55,43,47,48
289	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbb,b)} c_{2} c_{2} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)} c_{5} c_{5})	f		257	
302	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{3} (\\Phi_{(bbcb,b)} c_{2}) c_{4} \\Phi_{cc(bbb,)} c_{3} c_{4})	f		270	
303	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{3} (\\Phi_{(bbcb,b)} c_{2}) c_{2} \\Phi_{cc(bbb,)} c_{3} c_{2})	f		271	
304	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} (\\Phi_{(bbcb,b)} c_{2}) c_{3} \\Phi_{cc(bbb,)} c_{3} c_{3})	f		272	
314	= T (c_{65} c_{44} c_{43})	f		133	65,44,43
315	= T (c_{65} c_{44} c_{42})	f		133	65,44,42
455	= (\\Phi_{K} T) (\\Phi_{(b,)} c_{2})	f		403	
31	= (\\Phi_{cc(bb,)} c_{7} c_{4} \\Phi_{bcbb} c_{1}) (\\Phi_{cb} c_{4} \\Phi_{cb})	f		37	
32	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(ccb,)} c_{4} c_{7} c_{4} (\\Phi_{(bcbb,cb)} c_{1}))	f		38	
33	= (\\Phi_{(cb,b)} c_{1} \\Phi_{cbb} c_{4}) (\\Phi_{bb} (\\Phi_{(b,b)} c_{1}) c_{5})	f		39	
34	= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})	f		40	
35	= (\\Phi_{(cb,b)} c_{1} (\\Phi_{(bcbb,)} c_{1}) c_{4}) (\\Phi_{bb} \\Phi_{b} c_{5})	f		41	
36	= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{1} c_{5})	f		42	
37	= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(cbb,b)} c_{1} \\Phi_{b(b,b)} c_{1} c_{5})	f		43	
38	= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})	f		44	
39	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})	f		45	
40	= \\Phi_{} (\\Phi_{(b,)} c_{5})	f		46	
41	= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))	f		47	
42	= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{5} c_{9}))	f		48	
44	= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})	f		49	
46	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{5} c_{4} \\Phi_{cbcb})	f		51	
47	= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cbb} c_{7} (\\Phi_{(bbb,)} c_{5}) c_{4})	f		52	
48	= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cbb} c_{7} (\\Phi_{(bbb,)} c_{4}) c_{5})	f		53	
51	= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})	f		55	
52	= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})	f		56	
53	= (\\Phi_{cc(bbb,)} c_{7} c_{5} \\Phi_{bcbb} c_{1} c_{7}) (\\Phi_{cb} c_{5} \\Phi_{cb})	f		57	
54	= (\\Phi_{bb} \\Phi_{K} c_{7}) (\\Phi_{c(ccb,)} c_{5} c_{7} c_{5} (\\Phi_{(bcbb,cb)} c_{1}))	f		58	
56	= (\\Phi_{c(c(b,bb),)} c_{5} c_{1} (\\Phi_{ccbbcb} c_{5}) \\Phi_{bbcb} c_{1}) (\\Phi_{cbcb} c_{1} \\Phi_{bb} c_{5} \\Phi_{cbb})	f		59	
57	= (\\Phi_{c((ccb,b),)} c_{5} c_{1} \\Phi_{bcb} (\\Phi_{ccbbbcb} c_{5}) c_{1}) (\\Phi_{cbcb} c_{1} \\Phi_{bb} c_{5} \\Phi_{cbb})	f		60	
58	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{cc(cc(cb,),)} c_{1} c_{5} c_{1} (\\Phi_{(bbcb,cbb)} c_{1}) c_{5} (\\Phi_{(ccccbbcb,b)} c_{5}))	f		61	
59	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{cc(ccc(cb,),)} c_{1} c_{5} c_{1} \\Phi_{b(bcb,cbb)} c_{1} c_{5} (\\Phi_{(cccccbbcb,b)} c_{5}))	f		62	
60	= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{1} (\\Phi_{(bcb,)} c_{5}))	f		63	
61	= (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{1} c_{1}) (\\Phi_{ccbb} (\\Phi_{(bcb,b)} c_{5}) c_{1} \\Phi_{ccb} c_{1})	f		64	
62	= (\\Phi_{(cbbb,b)} c_{7} (\\Phi_{(bbb,b)} c_{4}) c_{5} c_{7} c_{5}) (\\Phi_{bb} \\Phi_{b} c_{1})	f		65	
63	= (\\Phi_{c(bbb,b)} c_{7} (\\Phi_{(bb,bb)} c_{4}) c_{5} c_{7} c_{5}) (\\Phi_{bb} \\Phi_{b} c_{6})	f		66	
64	= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})	f		67	
65	= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})	f		68	
68	= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})	f		69	
70	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{2} \\Phi_{bcb} c_{1}) c_{2}) (\\Phi_{ccbb} \\Phi_{cbb} c_{2} \\Phi_{ccb} c_{1})	f		71	
71	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{2} \\Phi_{bcb} c_{2}) c_{2}) (\\Phi_{ccbb} \\Phi_{cbb} c_{2} \\Phi_{ccb} c_{2})	f		72	
72	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{2}) c_{2}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{2})	f		73	
12	= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})	f		74	
4	= (\\Phi_{bb} (\\Phi_{(bb,)} c_{1}) c_{1}) (\\Phi_{b} \\Phi_{K})	f		75	
6	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{ccb} c_{1} c_{1} \\Phi_{cb(b,)})	f		76	
8	= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})	f		77	
5	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{cb} c_{1} (\\Phi_{(b,cb)} c_{1}))	f		78	
2	= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})	f		79	
9	= T c_{8}	f		80	
7	= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})	f		81	
11	= (c_{7} c_{8}) c_{9}	f		82	
13	= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})	f		83	
88	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(cbb,b)} c_{5} \\Phi_{b(bb,)} c_{2} c_{2})	f		85	
89	= (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{2}) (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{2} c_{2})	f		86	
90	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{(cbb,b)} c_{7} (\\Phi_{(bbb,b)} c_{5}) c_{2} c_{2})	f		87	
91	= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})	f		88	
92	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(c(cbb,),b)} c_{2} c_{5} (\\Phi_{(bb,(bcb,b))} c_{2}) c_{1} c_{2})	f		89	
93	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{2}) c_{2} c_{2})	f		90	
94	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{1}) c_{2} c_{2})	f		91	
95	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{2}) c_{1} c_{2})	f		92	
96	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})	f		93	
97	= (\\Phi_{cb} c_{1} (\\Phi_{(bbb,b)} \\Phi_{bb} c_{5})) (\\Phi_{cbb} c_{1} \\Phi_{bb} (\\Phi_{(bb,b)} c_{5}))	f		94	
100	= (\\Phi_{bbc} \\Phi_{b} c_{2} c_{8}) (\\Phi_{b} (\\Phi_{(bb,)} c_{2}))	f		96	
101	= (\\Phi_{cbbbc} c_{5} \\Phi_{bb} \\Phi_{bb} c_{2} c_{8}) (\\Phi_{cb} c_{5} (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2}))	f		97	
102	= (\\Phi_{cbb} c_{9} \\Phi_{bc} c_{2}) (\\Phi_{(bb,)} \\Phi_{bc} c_{2})	f		98	
103	= (\\Phi_{bb} (\\Phi_{cbbb} c_{9} \\Phi_{bc} c_{2}) c_{4}) (\\Phi_{bb} (\\Phi_{(bbb,)} \\Phi_{bc} c_{2}) c_{4})	f		99	
104	= (\\Phi_{bbc} \\Phi_{b} c_{5} c_{8}) (\\Phi_{b} (\\Phi_{(bb,)} c_{5}))	f		100	
105	= (\\Phi_{bbc} \\Phi_{b} c_{4} c_{9}) (\\Phi_{b} (\\Phi_{(bb,)} c_{4}))	f		101	
106	= (\\Phi_{(cbbc,bc)} c_{7} (\\Phi_{(bbb,b)} c_{4}) c_{5} c_{9} c_{5} c_{8}) (\\Phi_{b} \\Phi_{b})	f		102	
112	= (\\Phi_{K} T) (\\Phi_{bcbccbbbb} (c_{62} c_{4} (\\Phi_{K} c_{8})) c_{16} (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) \\Phi_{cb} c_{16} (\\Phi_{(bbcb,b)} c_{1}) (c_{62} c_{4}) \\Phi_{b} c_{16})	f		365	16
117	= (\\Phi_{bb} (\\Phi_{bb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} c_{5}) \\Phi_{cbb} \\Phi_{b})	f		329	
125	= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} c_{5}) \\Phi_{b})	f		330	
165	= T (c_{62} c_{5} (\\Phi_{K} c_{8}) (\\Phi_{bbb} (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{b} c_{17}))	f		389	17
153	= (\\Phi_{ccbbbb} \\Phi_{cb} c_{16} \\Phi_{bcb} (c_{62} c_{4}) \\Phi_{b} c_{16}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{22})	f		369	16,22
116	= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} c_{5}) \\Phi_{b})	f		333	
98	= (\\Phi_{cb} c_{15} (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2})) (\\Phi_{cbb} c_{15} \\Phi_{bb} (\\Phi_{(bb,b)} c_{2}))	f		107	
120	= (\\Phi_{b(cb,)} (\\Phi_{bb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) c_{4} (\\Phi_{(bb,(bb,b))} c_{1})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} c_{5}) \\Phi_{cbb} \\Phi_{b})	f		341	
124	= (\\Phi_{ccbbbb} (\\Phi_{(bb,(bb,b))} c_{1}) c_{4} \\Phi_{b(cb,)} \\Phi_{bb} (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cccb} \\Phi_{b} \\Phi_{cbcb} (c_{62} c_{5}) (\\Phi_{cccbb} (\\Phi_{(bb,b)} c_{5})))	f		345	
133	= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} c_{4}) \\Phi_{b})	f		347	
128	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cc(cbbb,bb),bb)} (\\Phi_{(bb,b)} c_{1}) \\Phi_{b} c_{1} (\\Phi_{(bbbb,bb)} c_{2}) \\Phi_{b} \\Phi_{(cccbbbb,b)} (c_{62} c_{5}) \\Phi_{b} (c_{62} c_{5}) \\Phi_{b} (c_{62} c_{5}) \\Phi_{b})	f		334	
129	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cccb,bb)} \\Phi_{b} \\Phi_{b} c_{2} \\Phi_{bcbcb} (c_{62} c_{5}) (\\Phi_{ccc(bbbb,b)} (\\Phi_{(bb,b)} c_{4})) (c_{62} c_{5}) \\Phi_{b})	f		335	
131	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cc(cbbb,bb),bb)} (\\Phi_{(bb,b)} c_{2}) \\Phi_{b} c_{2} (\\Phi_{(bbbb,bb)} c_{2}) \\Phi_{b} \\Phi_{(cccbbbb,b)} (c_{62} c_{5}) \\Phi_{b} (c_{62} c_{5}) \\Phi_{b} (c_{62} c_{5}) \\Phi_{b})	f		337	
114	= T (c_{62} c_{4} (\\Phi_{K} c_{8}) (\\Phi_{(bb(ccbb,b),cb)} c_{5} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{20} c_{24} (\\Phi_{(bb(bb,),b)} c_{2}) c_{16} c_{16} c_{18} c_{16}))	f		367	20,24,16,18
119	= (\\Phi_{(b,cb)} (\\Phi_{bcb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) c_{5} (\\Phi_{(bb,(bb,b))} c_{1})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} c_{5}) \\Phi_{b})	f		340	
10	= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})	f		117	
74	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{(cb,b)} c_{5} \\Phi_{cbb} c_{2})	f		118	
75	= (\\Phi_{K} (\\Phi_{K} c_{8})) (\\Phi_{bb} (\\Phi_{(bb,)} c_{4}) c_{2})	f		119	
76	= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{(cb,b)} c_{4} \\Phi_{cbb} c_{2})	f		120	
77	= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{2}) c_{5} c_{4})	f		121	
78	= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})	f		122	
79	= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))	f		123	
80	= \\Phi_{} (\\Phi_{cb} c_{8} c_{2})	f		124	
81	= (\\Phi_{b} c_{7}) (\\Phi_{b} (c_{2} c_{9}))	f		125	
145	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cc(cbbb,bb),bb)} (\\Phi_{(bb,b)} c_{2}) \\Phi_{b} c_{2} (\\Phi_{(bbbb,bb)} c_{2}) \\Phi_{b} \\Phi_{(cccbbbb,b)} (c_{62} c_{5}) \\Phi_{b} (c_{62} c_{4}) \\Phi_{b} (c_{62} c_{4}) \\Phi_{b})	f		356	
108	= T (c_{62} c_{4} (\\Phi_{K} c_{8}) (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{bb} c_{7}) c_{16}))	f		362	16
152	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{15} \\Phi_{bcb} c_{4}) c_{15}) (\\Phi_{cccbb} \\Phi_{cbbb} c_{16} c_{20} \\Phi_{cccb} c_{21})	f		404	16,20,21
148	= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})	f		130	16,17
151	= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{20})	f		131	16,20
149	= (\\Phi_{K} T) (\\Phi_{b} (c_{17} c_{18}))	f		133	17,18
154	= (\\Phi_{bb} (\\Phi_{bbb} c_{22} c_{20}) c_{21}) (\\Phi_{bb} \\Phi_{b} c_{24})	f		134	22,20,21,24
159	= (\\Phi_{bb} \\Phi_{b} c_{27}) (\\Phi_{cb} c_{29} \\Phi_{cb})	f		138	27,29
161	= (\\Phi_{bb} \\Phi_{b} c_{26}) (\\Phi_{cb} c_{28} \\Phi_{cb})	f		138	26,28
162	= (\\Phi_{cbb} c_{20} (\\Phi_{b(bbb,b)} c_{20} c_{21} c_{20}) c_{21}) (\\Phi_{bb} \\Phi_{b} c_{31})	f		140	20,21,31
163	= (\\Phi_{bb} \\Phi_{b} c_{27}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{35})	f		141	27,16,35
164	= (\\Phi_{(bb,)} c_{24} c_{20}) (\\Phi_{b} c_{52})	f		142	24,20,52
170	= (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{5}) (\\Phi_{bb} \\Phi_{b} c_{2})	f		143	
155	= (\\Phi_{(cbbb,b)} c_{16} (\\Phi_{(bbb,b)} c_{19}) (\\Phi_{(bb,b)} c_{5}) c_{16} c_{24}) (\\Phi_{bb} \\Phi_{b} c_{25})	f		399	16,19,24,25
144	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(bbb,bbb)} (\\Phi_{(bb,b)} c_{4}) (\\Phi_{ccbb} \\Phi_{b}) (c_{62} c_{4}) \\Phi_{b} (\\Phi_{(bbb,bb)} c_{2}) (c_{62} c_{4}) \\Phi_{b})	f		355	
157	= (\\Phi_{cbbb} c_{16} (\\Phi_{(bbb,)} c_{19}) (\\Phi_{(bb,b)} c_{5}) c_{17}) (\\Phi_{bb} \\Phi_{b} c_{30})	f		397	16,19,17,30
169	= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})	f		147	
150	= (\\Phi_{b} (\\Phi_{c(bb,)} c_{16} (\\Phi_{(bb,cb)} c_{5}))) (\\Phi_{cccb} \\Phi_{cb(bcb,)} c_{16} c_{19} (\\Phi_{ccccb} \\Phi_{cb}))	f		394	16,19
160	= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{5}) c_{12} c_{27}) (\\Phi_{bb} \\Phi_{b} c_{26})	f		427	27,26
132	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(cbbb,)} c_{2} \\Phi_{cbb} (c_{62} c_{5} (\\Phi_{K} c_{8})) \\Phi_{b})	f		338	
135	= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) \\Phi_{bb} (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) (c_{62} c_{4}) \\Phi_{b})	f		360	
136	= (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) \\Phi_{bb} (c_{62} c_{4}) \\Phi_{b})	f		361	
185	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(cc(ccbb,bbb),bb)} \\Phi_{cb} c_{16} c_{1} c_{2} \\Phi_{cb(bbcb,b)} (c_{12} c_{18}) (c_{62} c_{5}) \\Phi_{b} c_{16} c_{16} c_{23})	f		417	16,18,23
138	= (\\Phi_{cbbbb} (\\Phi_{(bb,b)} c_{5}) \\Phi_{bb} \\Phi_{bb} (c_{62} c_{4}) \\Phi_{b}) (\\Phi_{cccb} \\Phi_{b} \\Phi_{cbcb} (c_{62} c_{4}) (\\Phi_{cccbb} (\\Phi_{(bb,b)} c_{5})))	f		349	
139	= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{5}) \\Phi_{bccb} (c_{62} c_{4}) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{5}) (c_{62} c_{4}) \\Phi_{b})	f		350	
140	= (\\Phi_{bbbb} \\Phi_{b} c_{5} (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{K} \\Phi_{bb} (c_{62} c_{4}) \\Phi_{b})	f		351	
134	= (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} c_{4}) \\Phi_{b})	f		359	
121	= (\\Phi_{cbbbb} (\\Phi_{(bb,b)} c_{2}) \\Phi_{bb} (\\Phi_{bbb} \\Phi_{K}) (c_{62} c_{5}) \\Phi_{b}) (\\Phi_{ccb} \\Phi_{cccb} \\Phi_{K} (\\Phi_{cccb} (\\Phi_{(bb(bb,b),bb)} (c_{62} c_{5}) \\Phi_{K} c_{5})))	f		342	
195	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(cc(ccbbb,b),)} c_{27} (c_{12} c_{18}) c_{5} c_{5} c_{23} (\\Phi_{(bbb,(bcbb,cb))} c_{2}) c_{27} c_{23} (c_{12} c_{18}))	f		421	27,18,23
196	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2} (c_{12} c_{18}) c_{16})	f		422	18,16
199	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bb} (\\Phi_{bbb} (c_{12} c_{18}) c_{20}) c_{21})	f		423	18,20,21
197	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cccccbb,b)} c_{16} c_{23} (c_{15} c_{18}) c_{2} \\Phi_{b(bbb,b)} c_{5} (c_{15} c_{18}) \\Phi_{(cccbbbbb,b)} c_{25} c_{25})	f		160	16,23,18,25
201	= (\\Phi_{K} T) (\\Phi_{bb} (c_{12} c_{18}) c_{20})	f		424	18,20
200	= (\\Phi_{bb} \\Phi_{b} c_{25}) (\\Phi_{bb} (\\Phi_{bbb} c_{23} c_{20}) c_{21})	f		162	25,23,20,21
208	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(c(bb,),)} c_{12} c_{31} (\\Phi_{(b(bb,cb),cb)} c_{2} c_{12}) c_{31})	f		425	31
202	= \\Phi_{} (\\Phi_{bb} c_{23} c_{20})	f		164	23,20
203	= (\\Phi_{K} T) (\\Phi_{(b,)} c_{17})	f		165	17
255	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})	f		12	57,55
206	= (\\Phi_{bb} (\\Phi_{bb} c_{20}) c_{21}) (\\Phi_{bb} (\\Phi_{bb} c_{22}) c_{31})	f		166	20,21,22,31
207	= (\\Phi_{bb} \\Phi_{K} c_{20}) (\\Phi_{cb} c_{31} (\\Phi_{bcb} c_{23}))	f		167	20,31,23
209	= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{cbbb} c_{20} \\Phi_{bb} c_{15} c_{20})	f		169	20
212	= (\\Phi_{bb} (\\Phi_{cbbbb} c_{16} \\Phi_{bb} \\Phi_{bb} c_{5}) c_{16}) (\\Phi_{ccccbb} c_{31} \\Phi_{cbbb} \\Phi_{bb} c_{16} \\Phi_{cccbb} c_{32})	f		171	16,31,32
213	= (\\Phi_{cbbb} (c_{15} c_{18}) \\Phi_{bb} c_{4} (c_{15} c_{18})) (\\Phi_{bb} (\\Phi_{bb} (c_{15} c_{18})) c_{32})	f		172	18,32
215	= (\\Phi_{c(bb,bb)} (c_{15} c_{18}) (\\Phi_{(bb,bb)} c_{4}) c_{15} c_{4} (c_{15} c_{18})) (\\Phi_{(cb,b)} c_{32} (\\Phi_{(bcb,b)} c_{15}) c_{32})	f		173	18,32
225	= (\\Phi_{cbbb} c_{31} (\\Phi_{bbb} (c_{62} c_{4} (\\Phi_{K} c_{8}))) \\Phi_{bb} c_{16}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{61})	f		386	31,16,61
217	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{32} \\Phi_{bcb} c_{25}) c_{32}) (\\Phi_{ccbb} \\Phi_{cbb} c_{32} \\Phi_{ccb} c_{25})	f		12	32,25
218	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cbb,b)} c_{16} (\\Phi_{(bbbbb,bb)} (\\Phi_{(bb,b)} c_{2}) c_{16} c_{22} c_{22}) c_{24} c_{34})	f		175	16,22,24,34
223	= (\\Phi_{(bcbbb,bb)} c_{19} c_{31} (\\Phi_{bbb} (c_{62} c_{4} (\\Phi_{K} c_{8}))) \\Phi_{bb} c_{16} c_{22} c_{22}) (\\Phi_{b} c_{61})	f		395	19,31,16,22,61
220	= (\\Phi_{(ccbb,b)} c_{24} \\Phi_{bb} \\Phi_{cbbb} c_{34} c_{34}) (\\Phi_{cbbb} c_{24} \\Phi_{bb} \\Phi_{bb} c_{34})	f		177	24,34
256	= (\\Phi_{(ccbb,b)} c_{55} \\Phi_{bb} \\Phi_{cbbb} c_{57} c_{57}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{57})	f		177	55,57
190	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(c(cbb,),b)} c_{27} c_{5} (\\Phi_{(bb,(bcb,b))} c_{2}) c_{15} c_{27})	f		178	27
257	= (c_{55} c_{43} c_{43}) c_{44}	f		179	55,43,44
43	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{5}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{5})	f		180	
137	= (\\Phi_{bb} (\\Phi_{bb} (c_{62} c_{4} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} c_{4}) \\Phi_{cbb} \\Phi_{b})	f		348	
193	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(ccbbb,b)} (c_{12} c_{18}) c_{5} \\Phi_{b(bb,b)} c_{2} (c_{12} c_{18}) c_{27})	f		420	18,27
73	= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})	f		184	
86	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccb,b)} c_{2} \\Phi_{bcbcb} c_{4} (\\Phi_{ccc(bbb,)} c_{5}) c_{4})	f		185	
224	= (\\Phi_{bbb} (\\Phi_{bcb} (c_{62} c_{4} (\\Phi_{K} c_{8})) c_{31}) \\Phi_{bcb} c_{16}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{60})	f		385	31,16,60
182	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{16} \\Phi_{bcb} c_{4}) c_{16}) (\\Phi_{ccbb} \\Phi_{cbb} c_{16} \\Phi_{ccb} c_{24})	f		187	16,24
226	= (\\Phi_{(b,)} c_{15}) (\\Phi_{K} c_{8})	f		188	
183	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{16} \\Phi_{bcb} c_{5}) c_{16}) (\\Phi_{ccbb} \\Phi_{cbb} c_{16} \\Phi_{ccb} c_{25})	f		189	16,25
184	= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{16} c_{18}))	f		190	16,18
236	= (\\Phi_{ccbb} \\Phi_{b} (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{bbb} c_{2}) (\\Phi_{bbb} (\\Phi_{bb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) \\Phi_{bb} c_{2})	f		328	
235	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{cccbb(b,)} c_{15} \\Phi_{b} (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{bbbb} c_{2} c_{15})	f		325	
238	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cbbbb} (\\Phi_{(b(bb,b),(bb,b))} c_{1} c_{5}) (\\Phi_{(cb,b)} c_{5}) \\Phi_{bc(cb,)} (c_{62} c_{5}) \\Phi_{b})	f		326	
187	= c_{18} (c_{22} c_{18})	f		193	18,22
188	= c_{18} (c_{23} c_{18})	f		193	18,23
221	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(ccbbb,b)} c_{60} c_{60} (\\Phi_{(bbb,bb)} c_{27}) c_{25} c_{60} c_{25})	f		194	60,27,25
189	= (\\Phi_{bb} \\Phi_{b} c_{24}) (\\Phi_{cb} c_{24} \\Phi_{cb})	f		195	24
111	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{ccb} c_{16} (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) (\\Phi_{bcb(cb,b)} (c_{62} c_{4} (\\Phi_{K} c_{8})) c_{16} (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8})))))	f		363	16
239	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{cccccbb(b,)} c_{15} \\Phi_{b} \\Phi_{cb} c_{15} (c_{62} c_{4}) \\Phi_{b(bcb,bb)} c_{2} c_{15})	f		327	
211	= (\\Phi_{ccccbb} c_{16} (\\Phi_{bccccb} (c_{62} c_{4} (\\Phi_{K} c_{8}))) (\\Phi_{(bcbb,cbcb)} c_{5}) c_{5} (\\Phi_{ccccbb} (\\Phi_{bc(ccccbb,)} (c_{62} c_{4} (\\Phi_{K} c_{8})) c_{31} c_{15})) c_{16}) (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{16}) c_{32})	f		381	16,31,32
127	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(c(bbb,ccbbb),bb)} \\Phi_{b} c_{5} (\\Phi_{cc(cbbbb,)} \\Phi_{cbb} c_{5}) (c_{62} c_{5}) \\Phi_{b} c_{1} c_{2} \\Phi_{cb(bb,bccb)} (c_{62} c_{4} (\\Phi_{K} c_{8})) \\Phi_{b} (c_{62} c_{5}) \\Phi_{b})	f		405	
216	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cbc(bbbbcb,)} c_{32} \\Phi_{bb} c_{16} \\Phi_{bcbb} c_{2} (c_{62} c_{4} (\\Phi_{K} c_{8})) (\\Phi_{bcb} (c_{62} c_{4} (\\Phi_{K} c_{8})) c_{31}) c_{15} \\Phi_{cbcb})	f		383	32,16,31
237	= (\\Phi_{(bbbb,bb)} c_{19} (\\Phi_{bcb} (c_{62} c_{4} (\\Phi_{K} c_{8})) c_{31}) \\Phi_{bcb} c_{16} c_{22} c_{22}) (\\Phi_{b} c_{60})	f		400	19,31,16,22,60
242	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{c(ccbb,b)} c_{4} c_{5} (\\Phi_{(bbb,b)} c_{5}) \\Phi_{(cbbb,b)} c_{2} c_{2})	f		206	
243	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))	f		207	
244	= \\Phi_{} (\\Phi_{cb} c_{42} c_{55})	f		208	42,55
245	= \\Phi_{} (\\Phi_{b} (c_{55} c_{42}))	f		209	55,42
248	= (\\Phi_{bb} \\Phi_{b} c_{55}) (\\Phi_{cb} c_{55} \\Phi_{cb})	f		195	55
249	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})	f		210	55
250	= (\\Phi_{K} c_{42}) (\\Phi_{(bb,)} c_{55} c_{64})	f		211	42,55,64
251	= \\Phi_{} (\\Phi_{b} (c_{57} c_{43}))	f		209	57,43
252	= \\Phi_{} (\\Phi_{cb} c_{43} c_{57})	f		208	43,57
253	= (\\Phi_{bb} \\Phi_{b} c_{57}) (\\Phi_{cb} c_{57} \\Phi_{cb})	f		195	57
254	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{57}) c_{57}) (\\Phi_{cbbb} c_{57} \\Phi_{bb} \\Phi_{bb} c_{57})	f		210	57
232	= (\\Phi_{cbb} c_{1} \\Phi_{b(b,)} c_{1}) (\\Phi_{b} \\Phi_{K})	f		212	
107	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(cbb,bb)} c_{16} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{(bb,bbb)} c_{2}) c_{15} (\\Phi_{(bb,b)} c_{1}) c_{16})	f		372	16
110	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{cbbb} c_{15} (\\Phi_{bcbbb} (c_{62} c_{4} (\\Phi_{K} c_{8})) c_{16} (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8})))) (\\Phi_{(b(bb,b),b)} c_{1} c_{4}) c_{15})	f		364	16
115	= (\\Phi_{K} T) (\\Phi_{bcbbb} (c_{62} c_{4} (\\Phi_{K} c_{8})) c_{16} (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{1}) c_{27})	f		368	16,27
158	= (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{27})	f		370	16,27
181	= T (c_{62} c_{5} (\\Phi_{K} c_{8}) (\\Phi_{bc(cccccbbb,bb)} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{16} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{(bcb,cbbbb)} c_{2}) c_{15} c_{5} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{bcccc(cb,bbb)} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{16}) (\\Phi_{(bb,b)} c_{1}) c_{27} (\\Phi_{(bb,b)} c_{1}) c_{27}))	f		392	16,27
267	= (c_{54} c_{43} c_{42}) (c_{55} c_{43} c_{51})	f		221	54,43,42,55,51
268	= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})	f		224	57,54,43,42,55
270	= (\\Phi_{K} c_{42}) (\\Phi_{b} (c_{57} c_{42}))	f		225	42,57
204	= T (c_{7} (c_{62} c_{4} (\\Phi_{K} c_{8}) (\\Phi_{bc(bb,)} (c_{62} c_{4} (\\Phi_{K} c_{8})) c_{16} (\\Phi_{(bb,cb)} c_{5}) c_{16})))	f		379	16
205	= T (c_{7} (c_{62} c_{4} (\\Phi_{K} c_{8}) (\\Phi_{bc(cccbb,)} (c_{62} c_{4} (\\Phi_{K} c_{8})) c_{16} \\Phi_{cb(bb,cb)} c_{5} c_{5} (\\Phi_{bc(cccbcb,)} (c_{62} c_{4} (\\Phi_{K} c_{8})) c_{16}) c_{16})))	f		380	16
258	= (c_{55} c_{43} c_{44}) c_{45}	f		34	55,43,44,45
265	= (\\Phi_{ccbb} c_{57} (c_{55} c_{43} c_{51}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})	f		231	57,55,43,51,54
271	= (\\Phi_{K} c_{42}) (\\Phi_{cb} c_{42} c_{57})	f		235	42,57
26	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})	f		236	
259	= (c_{55} c_{43} c_{45}) c_{46}	f		34	55,43,45,46
260	= (c_{55} c_{43} c_{46}) c_{47}	f		34	55,43,46,47
262	= (c_{55} c_{43} c_{48}) c_{49}	f		34	55,43,48,49
55	= (\\Phi_{c(bb,)} c_{5} (\\Phi_{bbcb} \\Phi_{K}) c_{1}) (\\Phi_{cbc(cb,)} c_{1} \\Phi_{bb} c_{5} c_{5} (\\Phi_{(bcb,cbb)} c_{1}))	f		237	
1	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})	f		238	
264	= (c_{55} c_{43} c_{50}) c_{51}	f		34	55,43,50,51
219	= (\\Phi_{ccbbb} c_{16} (\\Phi_{bccccb} (c_{62} c_{4} (\\Phi_{K} c_{8})) (\\Phi_{(bbcccbb,cbcb)} c_{5} (c_{62} c_{4} (\\Phi_{K} c_{8})) c_{31})) (\\Phi_{cccbb} (\\Phi_{bc(cccccb,)} (c_{62} c_{4} (\\Phi_{K} c_{8})) c_{31} c_{15}) c_{31}) (\\Phi_{(bbb,bcb)} c_{5}) c_{16}) (\\Phi_{cb} c_{34} (\\Phi_{bbcb} \\Phi_{b} c_{16}))	f		384	16,31,34
214	= (\\Phi_{c(ccbbb,bb)} c_{16} (c_{62} c_{4} (\\Phi_{K} c_{8})) c_{17} (\\Phi_{(bbbb,bbb)} c_{4} (c_{62} c_{4} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5}) c_{16} (\\Phi_{(bb,b)} c_{5}) c_{17}) (\\Phi_{bb} \\Phi_{b} c_{12})	f		426	16,17
290	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbb,b)} c_{2} c_{2} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)} c_{4} c_{4})	f		258	
291	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbb,b)} c_{2} c_{2} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)} c_{3} c_{3})	f		259	
292	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} (\\Phi_{(bbcb,b)} c_{2}) c_{5} \\Phi_{cc(bbb,)} c_{2} c_{5})	f		260	
293	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} (\\Phi_{(bbcb,b)} c_{2}) c_{4} \\Phi_{cc(bbb,)} c_{2} c_{4})	f		261	
294	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} (\\Phi_{(bbcb,b)} c_{2}) c_{2} \\Phi_{cc(bbb,)} c_{2} c_{2})	f		262	
305	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbb,b)} c_{3} c_{2} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)} c_{2} c_{2})	f		273	
319	= T (c_{68} c_{42} c_{43})	f		133	68,42,43
\.


--
-- Name: teorema_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.teorema_id_seq', 467, true);


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
federico	Federico	Flaviani	federico.flaviani@gmail.com	4b39bf2b2076bb3aec161cfd09ca0614a65f3c0adadb80ff443b8434237ad0a2745018653685a9811f2335dd0b314427ff7568592cd3856ef67ddb0315da4627	1	f	t	2
AdminTeoremas	Admin	Teoremas	admin@teoremas.gries	4b39bf2b2076bb3aec161cfd09ca0614a65f3c0adadb80ff443b8434237ad0a2745018653685a9811f2335dd0b314427ff7568592cd3856ef67ddb0315da4627	1	t	f	1
prueba	Prueba	Prueba	prueb@uno	f0d3681727786fb9ea201a8b1c354bdc54128a43eed37bfdbf7fa849db99020d5c413a0808547470f373190b50ecc291d0a77806a108b84e9881f078b7fe4e99	1	f	t	1
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
-- Name: purecombstheorems purecombstheorems_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.purecombstheorems
    ADD CONSTRAINT "purecombstheorems_PK" PRIMARY KEY (id);


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
-- Name: teorema purecombstheorems_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.teorema
    ADD CONSTRAINT "purecombstheorems_FK" FOREIGN KEY (purecombstheoid) REFERENCES userdb.purecombstheorems(id);


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

