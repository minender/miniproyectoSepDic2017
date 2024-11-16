<<<<<<< Updated upstream
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
9	AdminTeoremas
10	AdminTeoremas
9	federico
5	federico
6	federico
1	federico
7	federico
13	federico
13	AdminTeoremas
14	AdminTeoremas
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
7	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(c(bbb,ccbbb),bb)} \\Phi_{b} c_{4} (\\Phi_{cc(cbbbb,)} \\Phi_{cbb} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} c_{1} c_{2} \\Phi_{cb(bb,bccb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
8	= (\\Phi_{K} c_{9}) (\\Phi_{cbb} (\\Phi_{K} c_{9}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
9	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) (\\Phi_{(bbb,bb)} c_{2}) \\Phi_{b} (\\Phi_{cccbbb} \\Phi_{b}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} (\\Phi_{(bb,b)} c_{4}))
10	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bbbb,)} \\Phi_{bb} c_{2} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b})
11	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))) (\\Phi_{(cb,b)} (\\Phi_{(bbb,bcb)} c_{2}) (\\Phi_{bccc(ccb,)} \\Phi_{b} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{5}) \\Phi_{c((cbbb,bbbb),)})
12	= (\\Phi_{(cb,cb)} \\Phi_{bb} \\Phi_{cbb} \\Phi_{bcb} \\Phi_{c(bbb,)}) (\\Phi_{bcb} \\Phi_{b} \\Phi_{ccb} (\\Phi_{ccbb} \\Phi_{cbb}))
13	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{cb} \\Phi_{bc} \\Phi_{cb})
14	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(bcb,b)} (\\Phi_{(cb,b)} c_{5}) c_{5} (\\Phi_{b(ccccb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(b(b(bb,b),b),(bb,(bb,b)))} c_{1} c_{5} c_{5}))
15	= (\\Phi_{bcb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) c_{7} (\\Phi_{(bb,bb)} c_{4})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbb} \\Phi_{b})
16	= (\\Phi_{ccbbbb} (\\Phi_{(bb,bb)} c_{4}) c_{7} \\Phi_{bcb} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cccb} \\Phi_{b} \\Phi_{cbcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) (\\Phi_{cccbb} (\\Phi_{(bb,b)} c_{5})))
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
103	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))) (\\Phi_{bcccc(b,)} (\\Phi_{bbb} \\Phi_{b} \\Phi_{bb}) \\Phi_{b} \\Phi_{cbbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (\\Phi_{(b(bbb,cccbbb),b)} c_{2} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b}))
104	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(ccc(ccb,),)} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) (\\Phi_{(bbcb,b)} c_{1}) \\Phi_{cb} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{bcbccbbbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))))
105	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))) (\\Phi_{bb} (\\Phi_{bcb} (\\Phi_{(b,(b,))} (\\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})))) (\\Phi_{(bb(bb,),b)} c_{2})) (\\Phi_{(bb(ccbb,b),cb)} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))))
106	= (\\Phi_{bb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbb} \\Phi_{b})
107	= (\\Phi_{cb} c_{15} (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2})) (\\Phi_{cbb} c_{15} \\Phi_{bb} (\\Phi_{(bb,b)} c_{2}))
108	= (\\Phi_{(b,cb)} (\\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) c_{5} (\\Phi_{(bb,(bb,b))} c_{1})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
109	= (\\Phi_{b(cb,)} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) c_{4} (\\Phi_{(bb,(bb,b))} c_{1})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbb} \\Phi_{b})
110	= (\\Phi_{ccbbbb} (\\Phi_{(bb,(bb,b))} c_{1}) c_{5} \\Phi_{(b,cb)} \\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{cbbcb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}))))
111	= (\\Phi_{ccbbbb} (\\Phi_{(bb,(bb,b))} c_{1}) c_{4} \\Phi_{b(cb,)} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cccb} \\Phi_{b} \\Phi_{cbcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) (\\Phi_{cccbb} (\\Phi_{(bb,b)} c_{5})))
112	= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
113	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cc(cbbb,bb),bb)} (\\Phi_{(bb,b)} c_{1}) \\Phi_{b} c_{1} (\\Phi_{(bbbb,bb)} c_{2}) \\Phi_{b} \\Phi_{(cccbbbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
114	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cccb,bb)} \\Phi_{b} \\Phi_{b} c_{2} \\Phi_{bcbcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) (\\Phi_{ccc(bbbb,b)} (\\Phi_{(bb,b)} c_{4})) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
115	= (\\Phi_{K} T) (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bb} c_{7})))
116	= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
117	= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})
119	= (\\Phi_{K} (\\Phi_{K} c_{8})) (\\Phi_{bb} (\\Phi_{(bb,)} c_{4}) c_{2})
120	= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{(cb,b)} c_{4} \\Phi_{cbb} c_{2})
121	= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{2}) c_{5} c_{4})
122	= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})
123	= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))
124	= \\Phi_{} (\\Phi_{cb} c_{8} c_{2})
125	= (\\Phi_{b} c_{7}) (\\Phi_{b} (c_{2} c_{9}))
126	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(bbb,bbb)} (\\Phi_{(bb,b)} c_{4}) (\\Phi_{ccbb} \\Phi_{b}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} (\\Phi_{(bbb,bb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
127	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cc(cbbb,bb),bb)} (\\Phi_{(bb,b)} c_{2}) \\Phi_{b} c_{2} (\\Phi_{(bbbb,bb)} c_{2}) \\Phi_{b} \\Phi_{(cccbbbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
128	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{ccccc(bcbbb,cbbb)} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{bcb} \\Phi_{c(bbbb,bb)} \\Phi_{b} \\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} \\Phi_{cb} (\\Phi_{(bbcb,bb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
129	= (\\Phi_{b(cccb,)} \\Phi_{K} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{bcb} (\\Phi_{ccbbbb} \\Phi_{cb})) (\\Phi_{bb} \\Phi_{b} (\\Phi_{bbb} \\Phi_{b}))
130	= (\\Phi_{bb} \\Phi_{K} (\\Phi_{bb} (\\Phi_{bb} c_{7}))) (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))
131	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} c_{15}))) (\\Phi_{bb} \\Phi_{b} (\\Phi_{bbb} \\Phi_{b}))
132	= (\\Phi_{bb(bccb,)} \\Phi_{K} \\Phi_{K} \\Phi_{bb} c_{4} \\Phi_{bcb} \\Phi_{c(bbb,)}) (\\Phi_{bb} (\\Phi_{bcb} \\Phi_{b} \\Phi_{cccb}) (\\Phi_{cccbb} \\Phi_{cbbb}))
133	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))
134	= (\\Phi_{bb} (\\Phi_{bbb} (\\Phi_{bb} \\Phi_{K}) \\Phi_{bb}) \\Phi_{bbb}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))))
135	= (\\Phi_{c(cb,b)} \\Phi_{(bbb,bb)} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{bccbb} (\\Phi_{bb} \\Phi_{K})) (\\Phi_{(ccbbb,b)} \\Phi_{K})) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))))
136	= (\\Phi_{cbb} \\Phi_{(bbb,b)} (\\Phi_{bcbb} (\\Phi_{bb} \\Phi_{K}) (\\Phi_{(bb,b)} c_{5})) (\\Phi_{ccbbb} \\Phi_{K})) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))))
137	= (\\Phi_{K} T) (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b}))
138	= (\\Phi_{bb} \\Phi_{K} (\\Phi_{bb} \\Phi_{b})) (\\Phi_{K} (\\Phi_{cb} \\Phi_{cb} \\Phi_{cb}))
139	= (\\Phi_{bb} (\\Phi_{bb} \\Phi_{K}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{5}))) (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))))
140	= (\\Phi_{((bb,),b)} (\\Phi_{b(bcb,)} \\Phi_{K}) \\Phi_{cbb} \\Phi_{b(bbb,b)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))))
141	= (\\Phi_{bbb} \\Phi_{K} \\Phi_{K} (\\Phi_{bb} \\Phi_{b})) (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} (\\Phi_{bbb} \\Phi_{b})))
142	= (\\Phi_{bb} (\\Phi_{bb} \\Phi_{K}) \\Phi_{(bb,)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} \\Phi_{b})))
143	= (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{5}) (\\Phi_{bb} \\Phi_{b} c_{2})
144	= (\\Phi_{bbcb} \\Phi_{K} \\Phi_{b} (\\Phi_{(bb,cb)} c_{5}) \\Phi_{c(bb,)}) (\\Phi_{bb} (\\Phi_{cb} (\\Phi_{cccccb} \\Phi_{K} \\Phi_{cb})) (\\Phi_{cccb} \\Phi_{cb(bcb,b)}))
145	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cc(cbbb,bb),bb)} (\\Phi_{(bb,b)} c_{2}) \\Phi_{b} c_{2} (\\Phi_{(bbbb,bb)} c_{2}) \\Phi_{b} \\Phi_{(cccbbbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
146	= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
147	= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})
148	= (\\Phi_{bcb} (\\Phi_{bc(cccb,)} (\\Phi_{bb} \\Phi_{K}) \\Phi_{K} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{bcb}) \\Phi_{cb} \\Phi_{(bccbbbb,bb)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} \\Phi_{b}))))
149	= (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
150	= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
151	= (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
152	= (\\Phi_{bb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{cbb} \\Phi_{b})
153	= (\\Phi_{cbbbb} (\\Phi_{(bb,b)} c_{5}) \\Phi_{bb} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b}) (\\Phi_{cccb} \\Phi_{b} \\Phi_{cbcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) (\\Phi_{cccbb} (\\Phi_{(bb,b)} c_{5})))
154	= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{5}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{5}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
155	= (\\Phi_{bbbb} \\Phi_{b} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{K} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
156	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(cbbb,)} c_{2} \\Phi_{cbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) \\Phi_{b})
157	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))) (\\Phi_{(b,)} (\\Phi_{b(cccbb,b)} \\Phi_{b} c_{2} \\Phi_{b(bb,b)} c_{5} \\Phi_{(ccbbb,b)}))
158	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))))) (\\Phi_{(ccbb,cb)} c_{5} c_{5} \\Phi_{(cccb,)} \\Phi_{c(cc(ccbbb,b),)} \\Phi_{c(ccb,)} (\\Phi_{(ccbb,ccbb)} (\\Phi_{(bbb,(bcbb,cb))} c_{2})))
159	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))) (\\Phi_{b} (\\Phi_{bbb} \\Phi_{b} (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2})))
160	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))))) (\\Phi_{bb} (\\Phi_{ccbb} c_{15} c_{15} (\\Phi_{bc(cccbb,b)} \\Phi_{(b,)} \\Phi_{(cccbbbbb,b)} c_{5} \\Phi_{b(bbb,b)} c_{2})) \\Phi_{cc(cccccbb,b)})
161	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))))) (\\Phi_{b} (\\Phi_{bbb} (\\Phi_{bbb} \\Phi_{b} \\Phi_{bb}) \\Phi_{bbb}))
162	= (\\Phi_{bbbb} \\Phi_{K} \\Phi_{K} \\Phi_{K} (\\Phi_{bb} \\Phi_{b})) (\\Phi_{K} (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} \\Phi_{bb}) \\Phi_{bbb}))
163	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))) (\\Phi_{b} (\\Phi_{bbb} \\Phi_{b} \\Phi_{bb}))
164	= (\\Phi_{K} (\\Phi_{K} \\Phi_{})) (\\Phi_{bb} \\Phi_{b} \\Phi_{bb})
165	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{b} \\Phi_{(b,)})
166	= (\\Phi_{bbb} (\\Phi_{bbb} \\Phi_{K} \\Phi_{K}) \\Phi_{bb} \\Phi_{bb}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{bbb} \\Phi_{b} \\Phi_{bb} \\Phi_{bb})))
167	= (\\Phi_{bbb} \\Phi_{K} \\Phi_{K} (\\Phi_{bb} \\Phi_{K})) (\\Phi_{K} (\\Phi_{cbb} \\Phi_{bcb} \\Phi_{bb} \\Phi_{cb}))
168	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))) (\\Phi_{(bb,b)} \\Phi_{(cb,)} (\\Phi_{(b(bb,cb),cb)} c_{2}) \\Phi_{c(c(bb,),)})
169	= (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} c_{15})) (\\Phi_{(ccb,)} c_{15} \\Phi_{bb} \\Phi_{cbbb})
170	= (\\Phi_{K} (\\Phi_{bb} (\\Phi_{cbbbb} c_{15} \\Phi_{bb} \\Phi_{bb} c_{5}) c_{15})) (\\Phi_{(ccccb,)} \\Phi_{cccbb} c_{15} \\Phi_{bb} \\Phi_{cbbb} \\Phi_{ccccbb})
171	= (\\Phi_{bb(bcccb,)} \\Phi_{K} \\Phi_{K} \\Phi_{bb} c_{5} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb}) (\\Phi_{cccb} \\Phi_{ccccbb} \\Phi_{cbbb} \\Phi_{bb} (\\Phi_{bccccb} \\Phi_{b} \\Phi_{cccbb}))
172	= (\\Phi_{b(ccbb,b)} \\Phi_{K} c_{4} \\Phi_{bb} \\Phi_{cbbb} c_{15} c_{15}) (\\Phi_{bbbb} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} c_{15})
173	= (\\Phi_{b(cccbb,b)} \\Phi_{K} c_{4} c_{15} (\\Phi_{(bb,bb)} c_{4}) \\Phi_{c(bb,bb)} c_{15} c_{15}) (\\Phi_{K} (\\Phi_{(cb,)} (\\Phi_{(bcb,b)} c_{15}) \\Phi_{(cb,b)}))
174	= (\\Phi_{bcbb} (\\Phi_{bb} \\Phi_{K}) \\Phi_{bcb} \\Phi_{bbb} (\\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})))) (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} (\\Phi_{bbb} \\Phi_{b})))
175	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))))) (\\Phi_{(bb,b)} (\\Phi_{bb(b,)} (\\Phi_{bb} \\Phi_{b})) \\Phi_{(cbb,b)} (\\Phi_{(bbbbb,bb)} (\\Phi_{(bb,b)} c_{2})))
176	= (\\Phi_{bccb} (\\Phi_{bb} \\Phi_{K}) \\Phi_{bb} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) \\Phi_{cbbb}) (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} (\\Phi_{bbb} \\Phi_{b})))
177	= (\\Phi_{bccb} \\Phi_{(b,)} \\Phi_{cbbb} \\Phi_{bb} \\Phi_{(ccbb,b)}) (\\Phi_{bccb} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbb})
178	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccb,)} c_{15} (\\Phi_{(bb,(bcb,b))} c_{2}) c_{5} \\Phi_{(c(cbb,),b)})
179	= (\\Phi_{b} (\\Phi_{b(b,)} \\Phi_{K})) (\\Phi_{K} (\\Phi_{K} \\Phi_{}))
180	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{5}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{5})
181	= (\\Phi_{cbbbb} (\\Phi_{(bb,b)} c_{2}) \\Phi_{bb} (\\Phi_{bbb} \\Phi_{K}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{ccb} \\Phi_{cccb} \\Phi_{K} (\\Phi_{cccb} (\\Phi_{(bb(bb,b),bb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{K} c_{5})))
182	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbbb,bb)} \\Phi_{b} c_{2} \\Phi_{bbcb} (\\Phi_{c(cbbbb,)} (\\Phi_{(bb,b)} c_{5})) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
183	= (\\Phi_{bb} (\\Phi_{bccb} (\\Phi_{bcb} (\\Phi_{b(b,)} \\Phi_{K}) \\Phi_{K}) \\Phi_{bb} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})))) \\Phi_{(bcbbb,bbb)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} \\Phi_{b})))))
184	= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})
185	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccb,b)} c_{2} \\Phi_{bcbcb} c_{4} (\\Phi_{ccc(bbb,)} c_{5}) c_{4})
186	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))))) (\\Phi_{b(cc(b,),cccb)} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (\\Phi_{bccccbb} \\Phi_{b}) \\Phi_{cb(bbcb,b)} c_{2} c_{1} (\\Phi_{(cc(ccbb,bbb),bb)} \\Phi_{cb}))
187	= (\\Phi_{b(bccb,)} \\Phi_{K} \\Phi_{bb} c_{4} \\Phi_{bcb} \\Phi_{c(bbb,)}) (\\Phi_{bcb} \\Phi_{b} \\Phi_{ccb} (\\Phi_{ccbb} \\Phi_{cbb}))
188	= (\\Phi_{(b,)} c_{15}) (\\Phi_{K} c_{8})
189	= (\\Phi_{b(bccb,)} \\Phi_{K} \\Phi_{bb} c_{5} \\Phi_{bcb} \\Phi_{c(bbb,)}) (\\Phi_{bcb} \\Phi_{b} \\Phi_{ccb} (\\Phi_{ccbb} \\Phi_{cbb}))
190	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} c_{9}))) (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))
191	= (\\Phi_{bbb} \\Phi_{K} \\Phi_{K} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b})) (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))
192	= (\\Phi_{bbccb} (\\Phi_{bb} \\Phi_{K}) \\Phi_{bb} c_{5} \\Phi_{bcb} \\Phi_{c(bbb,)}) (\\Phi_{bbcb} \\Phi_{K} \\Phi_{b} \\Phi_{ccb} (\\Phi_{ccbb} \\Phi_{cbb}))
193	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{b} \\Phi_{c})
194	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))) (\\Phi_{c(bb,(b,))} \\Phi_{(bbb,bb)} \\Phi_{bbb} \\Phi_{(cb,)} \\Phi_{(ccbbb,b)})
195	= (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})) (\\Phi_{cb} \\Phi_{cb} \\Phi_{cb})
196	= (\\Phi_{bbbb} \\Phi_{b} c_{4} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bb} c_{7})) (\\Phi_{cbbb} \\Phi_{K} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
197	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(c(bbb,ccbbbb),bb)} \\Phi_{b} c_{5} (\\Phi_{cc(cbbbb,)} \\Phi_{cbb} c_{5}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} c_{1} c_{2} \\Phi_{cb(bb,bccb)} c_{7} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
198	= (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{bbb} c_{2}) (\\Phi_{bbb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) \\Phi_{bb} c_{2})
199	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{cccbb(b,)} c_{15} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{bbbb} c_{2} c_{15})
200	= (\\Phi_{bc(b,)} (\\Phi_{cb(cb,ccb)} \\Phi_{(bcccbb,bbbb)} (\\Phi_{ccbb} (\\Phi_{bc(ccbbb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) c_{15}) (\\Phi_{(bb,bcbcb)} c_{5}) (\\Phi_{bccbbcb} (\\Phi_{bb} \\Phi_{K})) c_{5} (\\Phi_{bcccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})))) \\Phi_{K} \\Phi_{(ccccccbbb,b)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))))))
201	= (\\Phi_{cbb} (\\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{bcbb} (\\Phi_{bcb} (\\Phi_{b(b,)} \\Phi_{K}) \\Phi_{K}) \\Phi_{bcb}) \\Phi_{(bbbb,bbb)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} \\Phi_{b})))))
202	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cbbbb} (\\Phi_{(b(bb,b),(bb,b))} c_{1} c_{5}) (\\Phi_{(cb,b)} c_{5}) \\Phi_{bc(cb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
203	= (\\Phi_{ccc(b,cccb)} (\\Phi_{bc(ccccbb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) c_{15} \\Phi_{ccccbb} (\\Phi_{bcbbcb} \\Phi_{K}) c_{5} (\\Phi_{(bcbb,cbcb)} c_{5}) (\\Phi_{bccccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) \\Phi_{ccccbb}) (\\Phi_{bbbb} \\Phi_{K} \\Phi_{b} \\Phi_{bb} (\\Phi_{bbb} \\Phi_{b}))
204	= (\\Phi_{K} T) (\\Phi_{b(ccc(c(ccc(c(cccccb,b),),),),)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) (\\Phi_{(bbcb,b)} c_{1}) \\Phi_{cb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) (\\Phi_{(bbcb,b)} c_{1}) \\Phi_{cb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{5} c_{15} (\\Phi_{(bcb,cbbbb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bc(cccccbccbbbb,ccbbbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))))
205	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bc(cccccb,b)} (\\Phi_{b(cb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{(bb,b)} c_{1})) (\\Phi_{(bb,b)} c_{1}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{5} c_{15} (\\Phi_{(bcb,cbbbb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bc(cccccbbb,bb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))))
206	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{c(ccbb,b)} c_{4} c_{5} (\\Phi_{(bbb,b)} c_{5}) \\Phi_{(cbbb,b)} c_{2} c_{2})
207	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))
208	= (\\Phi_{K} (\\Phi_{K} \\Phi_{})) (\\Phi_{bb} \\Phi_{b} \\Phi_{cb})
209	= (\\Phi_{K} (\\Phi_{K} \\Phi_{})) (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))
210	= (\\Phi_{(bb,)} \\Phi_{bb} (\\Phi_{bbb} \\Phi_{b})) (\\Phi_{(ccb,)} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbb})
211	= (\\Phi_{bbb} \\Phi_{K} \\Phi_{K} \\Phi_{K}) (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} \\Phi_{(bb,)}))
212	= (\\Phi_{cbb} c_{1} \\Phi_{b(b,)} c_{1}) (\\Phi_{b} \\Phi_{K})
213	= (\\Phi_{b(ccb,)} \\Phi_{K} (\\Phi_{(bb,b)} c_{2}) (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) \\Phi_{cbbb}) (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))
214	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{cccccbb(b,)} c_{15} \\Phi_{b} \\Phi_{cb} c_{15} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b(bcb,bb)} c_{2} c_{15})
215	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{ccbcb} c_{15} (\\Phi_{(b(bb,b),b)} c_{1} c_{4}) (\\Phi_{cbbb} c_{15}) (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{bcbbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))))
216	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{bccb} \\Phi_{b} (\\Phi_{(bb,b)} c_{1}) (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{bcbbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))))
217	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccccb,)} (\\Phi_{(bb,b)} c_{1}) c_{15} (\\Phi_{(bb,bbb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) \\Phi_{c(cbb,bb)})
218	= (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} c_{15})) (\\Phi_{(ccb,)} (\\Phi_{(bb,b)} c_{1}) (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) \\Phi_{cbbb})
219	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))))) (\\Phi_{bcb} (\\Phi_{cbcccb} (\\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{ccbb} \\Phi_{cbcb} c_{15}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{2} \\Phi_{bcbb}) \\Phi_{bb} \\Phi_{cbc(bbbbcb,)})
220	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})
221	= (\\Phi_{b} (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{K} \\Phi_{K}))) (\\Phi_{K} (\\Phi_{bb} \\Phi_{K} (\\Phi_{bc} \\Phi_{b})))
222	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cb,cb)} (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) \\Phi_{ccb} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{bcb(cb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))))
223	= (\\Phi_{K} T) (\\Phi_{bccb(cccccb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{15} c_{15} (\\Phi_{bcc(ccbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{15} (\\Phi_{(b(bb,b),b)} c_{1} c_{4}) c_{15} (\\Phi_{(b(bb,b),b)} c_{1} c_{4})) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{5} c_{15} (\\Phi_{(bcb,cbbbb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bc(cccccbcbb,cbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))))
224	= (\\Phi_{bbbb} \\Phi_{b} \\Phi_{bb} (\\Phi_{bcbb} \\Phi_{b} \\Phi_{bcb}) \\Phi_{ccbb}) (\\Phi_{K} (\\Phi_{bbbcb} \\Phi_{K} \\Phi_{K} \\Phi_{K} \\Phi_{cb} \\Phi_{cb}))
225	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{b} (\\Phi_{bc} \\Phi_{b}))
226	= (\\Phi_{((b,b),)} \\Phi_{(cb,b)} (\\Phi_{bbcbb} (\\Phi_{bbb} \\Phi_{K} \\Phi_{K}))) (\\Phi_{b(cc(b,),b)} \\Phi_{K} \\Phi_{bb(b(b,),)} \\Phi_{cbcb} \\Phi_{cccbb} \\Phi_{ccb})
227	= (\\Phi_{(bb,)} \\Phi_{bb} (\\Phi_{bbb} (\\Phi_{bbbb} \\Phi_{K} \\Phi_{K} \\Phi_{K}))) (\\Phi_{((cccb,b),)} \\Phi_{bcbbb} \\Phi_{bb} \\Phi_{cbbcb} (\\Phi_{b(cccbb,b)} \\Phi_{K}) \\Phi_{ccb})
228	= (\\Phi_{(ccb,cb)} (\\Phi_{(bbbb,bbb)} c_{4} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5}) (\\Phi_{b(ccccb,)} \\Phi_{K} (\\Phi_{(bb,b)} c_{5})) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{c(ccbbb,bb)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))))
229	= (\\Phi_{ccccc(cb,b)} (\\Phi_{bc(cccccb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) c_{15} \\Phi_{cccbb} (\\Phi_{(bbcccbb,cbcb)} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{bccccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{(bbb,bcb)} c_{5}) (\\Phi_{bcc(bbb,(bcb,))} \\Phi_{K}) \\Phi_{ccbbb}) (\\Phi_{bcbb} \\Phi_{K} \\Phi_{cb} \\Phi_{cb} (\\Phi_{bbcb} \\Phi_{b}))
230	= (\\Phi_{K} T) (\\Phi_{b(cccccccb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{(bcb,cbbbb)} c_{2}) c_{15} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) \\Phi_{b} (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))))
231	= (\\Phi_{ccbb} (\\Phi_{bccbb} \\Phi_{K}) \\Phi_{bcb} (\\Phi_{(bccb,)} \\Phi_{bb}) \\Phi_{ccbb}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{cb} \\Phi_{cb} \\Phi_{cb})))))
232	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(c(cb,),(cccccb,b))} (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) (\\Phi_{bcc(ccb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{5} c_{15} (\\Phi_{(bcb,cbbbb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bc(cccccb(cb,b),(cb,b))} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))))
233	= (\\Phi_{K} T) (\\Phi_{bb(cb,)} c_{7} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) (\\Phi_{(bb,cb)} c_{5}) (\\Phi_{bc(bb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))))
234	= (\\Phi_{K} T) (\\Phi_{bb((cccb,b),)} c_{7} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{5} c_{5} \\Phi_{cb(bb,cb)} (\\Phi_{bc(cccbb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{bc(cccbcb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))))
235	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{bb} \\Phi_{b} \\Phi_{cb})
236	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})
237	= (\\Phi_{c(bb,)} c_{5} (\\Phi_{bbcb} \\Phi_{K}) c_{1}) (\\Phi_{cbc(cb,)} c_{1} \\Phi_{bb} c_{5} c_{5} (\\Phi_{(bcb,cbb)} c_{1}))
238	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})
\.


--
-- Name: purecombstheorems_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.purecombstheorems_id_seq', 255, true);


--
-- Data for Name: resuelve; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.resuelve (id, nombreteorema, numeroteorema, resuelto, loginusuario, teoremaid, categoriaid, variables, teoriaid) FROM stdin;
7	Identity of $\\equiv$	3.3.a	f	AdminTeoremas	7	1	;q	1
146	Distributivity of $\\vee$ over $\\exists$	9.23	f	AdminTeoremas	141	8	x,y,x,x,x,y,x,x,x,y,x,x;R,Q,P	1
127	Trading	9.4.b	f	AdminTeoremas	122	7	x,y,x,x,x,y,x,x;Q,P,R	1
8	Identity of $\\equiv$	3.3.b	t	AdminTeoremas	8	1	;q	1
135	Body weakening/strengthening	9.11	f	AdminTeoremas	130	7	x,y,x,x,x,y,x,x;R,P,Q	1
128	Trading	9.4.c	f	AdminTeoremas	123	7	x,y,x,x,x,y,x,x;Q,R,P	1
11	Definition of $false$	3.8	t	AdminTeoremas	11	2	;	1
132	Distributivity of $\\wedge$ over $\\forall$	9.7	f	AdminTeoremas	127	7	x,y,x,x,x,y,x,x,x,y,x,x;R,Q,P	1
129	Trading	9.4.d	f	AdminTeoremas	124	7	x,y,x,x,x,y,x,x;Q,P,R	1
133		9.9	f	AdminTeoremas	128	7	x,y,x,x,x,y,x,x,x,y,x,x;R,Q,P	1
147		9.24	f	AdminTeoremas	142	8	x,y,x,x;R	1
150	Monotonicity of $\\exists$	9.27	f	AdminTeoremas	145	8	x,y,x,x,x,y,x,x,x,y,x,x;R,P,Q	1
136	Monotonicity of $\\forall$	9.12	f	AdminTeoremas	131	7	x,y,x,x,x,y,x,x,x,y,x,x;R,P,Q	1
151	$\\exists$-Introduction	9.28	f	AdminTeoremas	146	8	x,y,x,x;P,E	1
488		3.74	t	federico	81	5	;p	1
165		21	t	AdminTeoremas	160	9	;B,A	2
161		17	t	AdminTeoremas	156	9	x,x,y,C,C,x;B	2
134	Range weakening/strengthening	9.10	f	AdminTeoremas	129	7	x,y,x,x,x,y,x,x;Q,P,R	1
457	Absorption	3.44.b	t	federico	48	4	;q,p	1
139	Generalized De Morgan	9.18.a	f	AdminTeoremas	134	8	x,y,x,x,x,y,x,x;R,P	1
137	Instantiation	9.13	f	AdminTeoremas	132	7	x,y,x,x;P,e	1
143	Trading	9.20	f	AdminTeoremas	138	8	x,y,x,x,x,y,x,x;Q,P,R	1
140	Generalized De Morgan	9.18.b	f	AdminTeoremas	135	8	x,y,x,x,x,y,x,x;R,P	1
148	Range weakening/strengthening	9.25	f	AdminTeoremas	143	8	x,y,x,x,x,y,x,x;R,Q,P	1
141	Generalized De Morgan	9.18.c	f	AdminTeoremas	136	8	x,y,x,x,x,y,x,x;R,P	1
144	Distributivity of $\\wedge$ over $\\exists$	9.21	f	AdminTeoremas	139	8	x,y,x,x,x,y,x,x;R,Q,P	1
152	Interchange of quantifications	9.29	f	AdminTeoremas	147	8	x,y,y,y,x,y,x,x,x,y,x,x,x,y,y,y;Q,R,P	1
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
145		9.22	f	AdminTeoremas	140	8	x,y,x,x,x,y,x,x;R,P	1
17		3.14	f	AdminTeoremas	17	2	;q,p	1
18		3.15.a	f	AdminTeoremas	18	2	;p	1
19	Symmetry of $\\not\\equiv$	3.16	f	AdminTeoremas	19	2	;p,q	1
462	Replacement	3.51	t	federico	61	4	;q,r,p	1
498	Weakening/strengthening	3.76.b	t	federico	84	5	;p,q	1
20	Associativity of $\\not\\equiv$	3.17	f	AdminTeoremas	20	2	;r,q,p	1
464	Replace by $true$	3.87	t	federico	104	6	;E,p	1
149	Body weakening/strengthening	9.26	f	AdminTeoremas	144	8	x,y,x,x,x,y,x,x;R,Q,P	1
21	Mutual associativity	3.18	f	AdminTeoremas	21	2	;r,q,p	1
466	Replace by $false$	3.88	t	federico	105	6	;E,p	1
142	Trading	9.19	f	AdminTeoremas	137	8	x,y,x,x,x,y,x,x;P,R	1
22	Mutual interchangeability	3.19	f	AdminTeoremas	22	2	;r,q,p	1
23	Symmetry of $\\vee$	3.24	t	AdminTeoremas	23	3	;p,q	1
24	Associativity of $\\vee$	3.25	t	AdminTeoremas	24	3	;r,q,p	1
25	Idempotency of $\\vee$	3.26	t	AdminTeoremas	25	3	;p	1
10	Reflexivity of $\\equiv$	3.5	t	AdminTeoremas	10	1	;q	1
122	Trading	9.2	t	AdminTeoremas	117	7	x,y,x,x,x,y,x,x;P,R	1
130	Distributivity of $\\vee$ over $\\forall$	9.5	t	AdminTeoremas	125	7	x,y,x,x,x,y,x,x;R,Q,P	1
123	Trading	9.3.a	f	AdminTeoremas	118	7	x,y,x,x,x,y,x,x;P,R	1
138	Generalized De Morgan	9.17	t	AdminTeoremas	133	8	x,y,x,x,x,y,x,x;R,P	1
124	Trading	9.3.b	f	AdminTeoremas	119	7	x,y,x,x,x,y,x,x;R,P	1
131		9.6	f	AdminTeoremas	126	7	x,y,x,x,x,y,x,x;R,P	1
125	Trading	9.3.c	f	AdminTeoremas	120	7	x,y,x,x,x,y,x,x;P,R	1
126	Trading	9.4.a	f	AdminTeoremas	121	7	x,y,x,x,x,y,y,y;Q,P,R,x	1
688		3.83.b	f	AdminTeoremas	243	6	;E,e,f	1
689		3.83.b	t	federico	243	6	;E,e,f	1
107	Extension	1.a	t	AdminTeoremas	107	9	x,y,x,x;B,A	2
473		8.p	t	federico	236	8	x,y,x,x,x,y,x,x;Q,P	1
624		PCA	f	federico	241	5	;P,C	1
527		88	t	federico	238	12	x,y,x,x;P,Q,R	1
743		10.3	t	federico	178	10	x,y,U,U,x,y,A,A,x,y,B,B,x,y,x,x,x,y,x,x;P	2
744		30	t	federico	184	10	;x	2
745		3.48.b	t	federico	54	4	;p,q	1
1	Associativity of $\\equiv$	3.1	t	AdminTeoremas	1	1	;r,q,p	1
2	Symmetry of $\\equiv$	3.2.a	t	AdminTeoremas	2	1	;p,q	1
28	Zero of $\\vee$	3.29	f	AdminTeoremas	28	3	;p	1
29	Identity of $\\vee$	3.30	f	AdminTeoremas	29	3	;p	1
30	Distributivity of $\\vee$ over $\\vee$	3.31	f	AdminTeoremas	30	3	;r,p,q	1
39	Associativity of $\\wedge$	3.37	f	AdminTeoremas	39	4	;r,q,p	1
72	Shunting	3.65	f	AdminTeoremas	72	5	;r,q,p	1
73		3.66	f	AdminTeoremas	73	5	;q,p	1
166		22	t	AdminTeoremas	161	9	;A,B	2
474	Reflexivity of $\\Rightarrow$	3.71	t	federico	78	5	;p	1
4	Symmetry of $\\equiv$	3.2.c	f	AdminTeoremas	4	1	;p,q	1
5	Symmetry of $\\equiv$	3.2.d	f	AdminTeoremas	5	1	;p,q	1
31		3.32.a	f	AdminTeoremas	31	3	;p,q	1
475	Right zero of $\\Rightarrow$	3.72	t	federico	79	5	;p	1
32		3.32.b	f	AdminTeoremas	32	3	;p,q	1
33	Golden rule	3.35.a	f	AdminTeoremas	33	4	;q,p	1
34	Golden rule	3.35.b	t	AdminTeoremas	34	4	;q,p	1
35	Golden rule	3.35.c	f	AdminTeoremas	35	4	;q,p	1
6	Symmetry of $\\equiv$	3.2.e	f	AdminTeoremas	6	1	;p,q	1
9		3.3	f	AdminTeoremas	9	1	;	1
26	Distributivity of $\\vee$ over $\\equiv$	3.27	t	AdminTeoremas	26	3	;r,p,q	1
66	Definition of Implication	3.59	f	AdminTeoremas	66	5	;q,p	1
167		23	t	AdminTeoremas	162	9	;b,a	2
528		99	t	federico	239	12	x,y,x,x;x,y	1
170	Extension	1.b	f	AdminTeoremas	240	9	x,y,x,x;B,A	2
67	Definition of Implication	3.60	f	AdminTeoremas	67	5	;p,q	1
27	Excluded Middle	3.28	t	AdminTeoremas	27	3	;p	1
168		25	t	AdminTeoremas	163	9	;A,B	2
169		27	t	AdminTeoremas	164	9	;x	2
36	Golden rule	3.35.d	f	AdminTeoremas	36	4	;q,p	1
650		3.69	t	federico	76	5	;p,q	1
37	Golden rule	3.35.e	f	AdminTeoremas	37	4	;q,p	1
417	Symmetry of $\\equiv$	3.2.b	t	federico	232	1	;p,q	1
649		10.1	t	federico	177	10	x,y,A,A,x,y,B,B,x,y,x,x,x,y,x,x;	2
171		10.2	f	AdminTeoremas	165	10	x,y,B,B,x,y,A,A;	2
38	Symmetry of $\\wedge$	3.36	f	AdminTeoremas	38	4	;p,q	1
163		19	t	AdminTeoremas	158	9	x,y,x,x;B,A	2
40	Idempotency of $\\wedge$	3.38	f	AdminTeoremas	40	4	;p	1
109	Empty set	2	t	AdminTeoremas	108	9	x,y,A,A,x,y,x,x;	2
41	Identity of $\\wedge$	3.39	f	AdminTeoremas	41	4	;p	1
111	Pairs	4	t	AdminTeoremas	110	9	x,y,A,A,x,y,x,x;b,a	2
42	Zero of $\\wedge$	3.40	f	AdminTeoremas	42	4	;p	1
653		10.4	t	federico	179	10	x,y,a,a,x,y,b,b,x,y,A,A,x,y,B,B,x,y,x,x,x,y,x,x;	2
43	Distributivity of $\\wedge$ over $\\wedge$	3.41	f	AdminTeoremas	43	4	;r,p,q	1
44	Contradiction	3.42	f	AdminTeoremas	44	4	;p	1
173		26	t	AdminTeoremas	167	9	x,x,y,a,a,x,y,b,b,x;B,A	2
45	Absorption	3.43.a	f	AdminTeoremas	45	4	;p,q	1
46	Absorption	3.43.b	f	AdminTeoremas	46	4	;p,q	1
154	Empty symbol	11	t	AdminTeoremas	149	9	;x	2
47	Absorption	3.44.a	f	AdminTeoremas	47	4	;q,p	1
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
162		18	t	AdminTeoremas	157	9	x,x;B,A	2
164		20	t	AdminTeoremas	159	9	;A,B	2
705	Distributivity of $\\Rightarrow$ over $\\equiv$	3.63	t	federico	70	5	;r,p,q	1
746	Weakening/strengthening	3.76.c	f	federico	85	5	;q,p	1
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
115	Infinity	7	t	AdminTeoremas	114	9	x,y,A,A,x,y,x,x;	2
86	Weakening/strengthening	3.76.d	f	AdminTeoremas	86	5	;q,p,r	1
412		3.3	t	federico	9	1	;	1
87	Weakening/strengthening	3.76.e	f	AdminTeoremas	87	5	;r,q,p	1
105	Replace by $false$	3.88	f	AdminTeoremas	105	6	;E,p	1
106	Shannon	3.89	f	AdminTeoremas	106	6	;E,p	1
98	Substitution	3.84.b	t	AdminTeoremas	98	6	;E,f,e	1
156		13.a	t	AdminTeoremas	151	9	;a,x	2
157		13.b	t	AdminTeoremas	152	9	;b,x,a	2
159		15	t	AdminTeoremas	154	9	;B,A	2
160		16	t	AdminTeoremas	155	9	x,x;B,A	2
155		12	t	AdminTeoremas	150	9	x,x;P,y,U	2
235		3.15.b	f	AdminTeoremas	169	2	;p	1
88	Modus ponens	3.77	f	AdminTeoremas	88	5	;q,p	1
237	Weakening/strengthening	3.76.f	f	AdminTeoremas	170	5	;q,p	1
158		14	t	AdminTeoremas	153	9	x,y,C,C;B,x	2
89		3.78	f	AdminTeoremas	89	5	;r,q,p	1
706		A.1	t	AdminTeoremas	244	13	;a	2
90		3.79	f	AdminTeoremas	90	5	;r,p	1
418	Symmetry of $\\equiv$	3.2.c	t	federico	4	1	;p,q	1
419	Symmetry of $\\equiv$	3.2.d	t	federico	5	1	;p,q	1
121		9.8	f	AdminTeoremas	116	7	x,y,x,x;R	1
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
469		8	t	federico	234	12	y,x,x,x;Q,R,P	1
523		3.68	t	federico	75	5	;q,p	1
113	Union	5	t	AdminTeoremas	112	9	x,y,A,A,x,y,x,x,x,y,C,C;B	2
114	Foundation	6	t	AdminTeoremas	113	9	x,y,B,B,x,y,x,x;A	2
116	Parts	8	t	AdminTeoremas	115	9	x,y,A,A,x,y,x,x;B	2
112	Separation	3	t	AdminTeoremas	111	9	x,y,A,A,x,y,x,x;P,U	2
333		57	f	AdminTeoremas	211	10	x,y,a,a,x,y,b,b;B,A,x	2
301		10.4	f	AdminTeoremas	179	10	x,y,a,a,x,y,b,b,x,y,A,A,x,y,B,B,x,y,x,x,x,y,x,x;	2
302		10.5	f	AdminTeoremas	180	10	x,y,B,B,x,y,A,A,x,y,D,D,x,y,x,x,x,y,C,C,x,y,x,x,x,y,C,C;	2
304		28	f	AdminTeoremas	182	10	;B,x,A	2
305		29	f	AdminTeoremas	183	10	;B,x,A	2
306		30	f	AdminTeoremas	184	10	;x	2
308		32	f	AdminTeoremas	186	10	;B,x,A	2
309		33	f	AdminTeoremas	187	10	;	2
310		34	f	AdminTeoremas	188	10	;	2
311		35	f	AdminTeoremas	189	10	;A,B	2
312		36	f	AdminTeoremas	190	10	;B,A	2
336		60	f	AdminTeoremas	214	10	x,y,x,x,x,y,x,x;B,A	2
314		38	f	AdminTeoremas	192	10	;C,A,B	2
315		39	f	AdminTeoremas	193	10	;B,A	2
317		41	f	AdminTeoremas	195	10	;A,B	2
318		42	f	AdminTeoremas	196	10	;B,A	2
319		43	f	AdminTeoremas	197	10	;C,B,A	2
320		44	f	AdminTeoremas	198	10	;	2
321		45	f	AdminTeoremas	199	10	;B,A	2
322		46	f	AdminTeoremas	200	10	;B,A	2
323		47	f	AdminTeoremas	201	10	;A	2
324		48	f	AdminTeoremas	202	10	;A	2
325		49	f	AdminTeoremas	203	10	;A	2
662		3.75	t	federico	82	5	;p	1
328		52	f	AdminTeoremas	206	10	;b,a	2
329		53	f	AdminTeoremas	207	10	;a,b	2
330		54	f	AdminTeoremas	208	10	;a,b	2
331		55	f	AdminTeoremas	209	10	;b,a	2
332		56	f	AdminTeoremas	210	10	;d,b,c,a	2
338		62	f	AdminTeoremas	216	10	x,y,a,a,y,x,b,b;x,B,A	2
334		58	f	AdminTeoremas	212	10	;B,b,A,a	2
335		59	f	AdminTeoremas	213	10	;B,A	2
303		10.6	f	AdminTeoremas	181	10	x,y,B,B,x,y,A,A,x,y,C,C,x,y,x,x,x,y,x,x;	2
337		61	f	AdminTeoremas	215	10	;B,A	2
339		63	f	AdminTeoremas	217	10	;C,A,B	2
340		64	f	AdminTeoremas	218	10	;S,R,w	2
326		50	f	AdminTeoremas	204	10	x,y,A,A,x,y,B,B;	2
342		66	f	AdminTeoremas	220	10	;A,C,B	2
343		67	f	AdminTeoremas	221	10	;S,R	2
350	Reflexivity of $=$	3.83.c	t	AdminTeoremas	226	6	;q	1
341		65	f	AdminTeoremas	219	10	x,y,x,x,x,y,y,y,x,y,z,z;S,R,w	2
327		51	f	AdminTeoremas	205	10	x,y,A,A,x,y,B,B,x,y,C,C;	2
470		3.48.a	t	federico	53	4	;p,q	1
428	Mutual associativity	3.18	t	federico	21	2	;r,q,p	1
429	Mutual interchangeability	3.19	t	federico	22	2	;r,q,p	1
430		3.15.a	t	federico	18	2	;p	1
485	Modus ponens	3.77	t	federico	88	5	;q,p	1
431		3.15.b	t	federico	169	2	;p	1
710		A.3	t	AdminTeoremas	248	13	;a,b	2
425	Zero of $\\vee$	3.29	t	federico	28	3	;p	1
711		A.4	t	AdminTeoremas	249	13	;c,b,a	2
712		A.5	t	AdminTeoremas	250	13	;a	2
432	Identity of $\\vee$	3.30	t	federico	29	3	;p	1
420	Symmetry of $\\equiv$	3.2.e	t	federico	6	1	;p,q	1
421		3.11	t	federico	14	2	;q,p	1
422	Double negation	3.12	t	federico	15	2	;p	1
423	Negation of $false$	3.13	t	federico	16	2	;	1
424		3.14	t	federico	17	2	;q,p	1
713		A.6	t	AdminTeoremas	251	13	;a	2
426	Symmetry of $\\not\\equiv$	3.16	t	federico	19	2	;p,q	1
427	Associativity of $\\not\\equiv$	3.17	t	federico	20	2	;r,q,p	1
434		3.32.a	t	federico	31	3	;p,q	1
435		3.32.b	t	federico	32	3	;p,q	1
433	Distributivity of $\\vee$ over $\\vee$	3.31	t	federico	30	3	;r,p,q	1
530		9.8	t	federico	116	7	x,y,x,x;R	1
344		27.a	f	AdminTeoremas	237	9	x,x,y,y,y,x;R	2
346		68	f	AdminTeoremas	224	10	x,y,y,y;R,z	2
345		27.b	f	AdminTeoremas	223	9	y,x,y,x,x,y;R	2
307		31	f	AdminTeoremas	185	10	x,y,C,C;B,x	2
347		69	f	AdminTeoremas	225	10	x,y,x,x;R,z	2
313		37	f	AdminTeoremas	191	10	x,y,x,x;A	2
471		9.6	t	federico	126	7	x,y,x,x,x,y,x,x;R,P	1
316		40	f	AdminTeoremas	194	10	x,y,C,C;A,B	2
715		A.8	t	AdminTeoremas	253	13	;a,b	2
716		A.9	t	AdminTeoremas	254	13	;c,b,a	2
717		A.10	t	AdminTeoremas	255	13	;c,a,b	2
299		10.1	f	AdminTeoremas	177	10	x,y,A,A,x,y,B,B,x,y,x,x,x,y,x,x;	2
718		A.11	f	AdminTeoremas	256	13	;a,c,b	2
300		10.3	f	AdminTeoremas	178	10	x,y,U,U,x,y,A,A,x,y,B,B,x,y,x,x,x,y,x,x;P	2
714		A.7	f	AdminTeoremas	252	13	;a	2
707		A.2	f	AdminTeoremas	245	13	;a	2
719		A.12	t	AdminTeoremas	257	13	;	2
720		A.13	t	AdminTeoremas	258	13	;	2
721		A.14	t	AdminTeoremas	259	13	;	2
722		A.15	t	AdminTeoremas	260	13	;	2
723		A.16	t	AdminTeoremas	261	13	;	2
724		A.17	t	AdminTeoremas	262	13	;	2
725		A.18	t	AdminTeoremas	263	13	;	2
726		A.19	t	AdminTeoremas	264	13	;	2
727		A.20	t	AdminTeoremas	265	13	;b,a	2
728		AT.1	f	AdminTeoremas	266	14	;	2
729		A.2	t	federico	245	13	;a	2
748	Extension	1.b	t	federico	240	9	x,y,x,x;B,A	2
12	Distributivity of $\\neg$ over $\\equiv$	3.9	t	AdminTeoremas	12	2	;q,p	1
370	One-point rule	8.14	t	AdminTeoremas	229	12	x,x,x;P,E,s	1
453	Definition of $\\equiv$	3.52	t	federico	62	4	;q,p	1
446	Definition of Implication	3.59	t	federico	66	5	;q,p	1
644	Shunting	3.65	t	federico	72	5	;r,q,p	1
533		3.67	t	federico	74	5	;p,q	1
472		9	t	federico	235	12	x,y,x,x;x,y	1
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
526	Left identity of $\\Rightarrow$	3.73	t	federico	80	5	;p	1
730		A.7	t	federico	252	13	;a	2
643		PCA2	f	federico	242	5	;P,D,C	1
731		A.11	t	federico	256	13	;a,c,b	2
733		A.21	f	AdminTeoremas	267	13	;	2
734		A.21	t	federico	267	13	;	2
735		A.22	f	AdminTeoremas	268	13	;b,a	2
736		A.22	t	federico	268	13	;b,a	2
732		AT.1	t	federico	266	14	;	2
737		AT.2	f	AdminTeoremas	269	14	;	2
739		A.23	f	AdminTeoremas	270	13	;a	2
740		A.24	f	AdminTeoremas	271	13	;a	2
741		A.23	t	federico	270	13	;a	2
742		A.24	t	federico	271	13	;a	2
738		AT.2	t	federico	269	14	;	2
\.


--
-- Name: resuelve_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.resuelve_id_seq', 764, true);


--
-- Data for Name: simbolo; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid, tipo) FROM stdin;
2	\\Rightarrow	2	t	3	2	%(a2) %(op) %(aa1)	1	b->b->b
3	\\Leftarrow	2	t	3	2	%(aa2) %(op) %(a1)	1	b->b->b
4	\\vee	2	t	4	3	%(a2) %(op) %(a1)	1	b->b->b
5	\\wedge	2	t	4	3	%(a2) %(op) %(a1)	1	b->b->b
6	\\not\\equiv	2	t	3	4	%(a2) %(op) %(a1)	1	b->b->b
7	\\neg	1	f	1	5	%(op) %(aa1)	1	b->b
8	true	0	f	0	0	%(op)	1	b
9	false	0	f	0	0	%(op)	1	b
19	 	2	f	3	7	\\{%(v1) \\in %(na2) | %(na1) \\}	2	(t->b)->(t->t)->t
63	  	2	f	3	9	[ %(na2) \\ldots %(na1) ]	2	t->t->t
64	-	1	f	3	9	%(op) %(aa1)	2	t->t
65	<	2	f	3	7	%(na2) %(op) %(na1)	2	t->t->p
67	>	2	f	3	7	%(na2) %(op) %(na1)	2	t->t->p
68	\\geq	2	f	3	7	%(na2) %(op) %(na1)	2	t->t->p
66	\\leq	2	f	3	7	%(na2) %(op) %(na1)	2	t->t->p
22	\\bigcup	1	f	3	8	%(op) %(a1)	2	t->t
38		2	f	3	9	%(a2)^{%(na1)}	2	t->t->t->t
1	\\equiv	2	f	3	1	%(a2) %(op) %(a1)	1	b->b->b
15	=	2	f	3	7	%(na2) %(op) %(na1)	1	t->t->b
16	\\in	2	f	3	7	%(a2) %(op) %(a1)	2	t->t->b
17	\\notin	2	f	3	7	%(a2) %(op) %(a1)	2	t->t->b
18	\\emptyset	0	f	3	0	%(op)	2	t
20	 	1	f	3	7	\\{ %(na1) \\}	2	t->t
21	 	2	f	3	7	%(na2) , %(na1)	2	t->t->t
23	\\bigcap	1	f	3	8	%(op) %(a1)	2	t->t
24	\\cup	2	f	3	7	%(aa2) %(op) %(a1)	2	t->t->t
25	\\cap	2	f	3	7	%(aa2) %(op) %(a1)	2	t->t->t
26	\\subset	2	f	3	6	%(a2) %(op) %(a1)	2	t->t->b
27	\\subseteq	2	f	3	6	%(a2) %(op) %(a1)	2	t->t->b
28	\\supset	2	f	3	6	%(a2) %(op) %(a1)	2	t->t->b
29	\\supseteq	2	f	3	6	%(a2) %(op) %(a1)	2	t->t->b
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
59	\\neq	2	f	3	7	%(na2) %(op) %(na1)	2	t->t->b
61	Rg	1	f	3	9	%(op)(%(na1) )	2	t->t
62	\\star	3	f	3	11	(%(ea1) %(v1) |%(na2):%(na3))	1	(x1->x1->x1)->(t->p)->(t->x1)->x1
60	Dom	1	f	3	9	%(op)(%(na1) )	2	t->t
10		2	f	3	7	%(aa1) [ %(a2) ]	1	(x1->x2)->x1->x2
\.


--
-- Name: simbolo_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.simbolo_id_seq', 68, true);


--
-- Data for Name: solucion; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.solucion (id, resuelveid, resuelto, demostracion, metodo) FROM stdin;
496	624	f	L^{\\lambda x_{122}.c_{5} x_{122} x_{67}} (I^{[x_{113},x_{112} := x_{80},x_{67}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{5} x_{122} x_{67}} (I^{[x_{112},x_{113} := (c_{7} x_{67}),x_{80}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))	SS
219	426	t	I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}) (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})})	SS
216	423	t	L^{\\lambda x_{122}.c_{7} x_{122}} A^{= (c_{7} c_{8}) c_{9}} (I^{[x_{112} := c_{8}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})	SS
208	416	t	S (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	SS
209	417	t	M_{4} (S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{114},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (I^{[x_{114} := (c_{1} x_{112} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (M_{1}^{1} (A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})))	EO DM
210	418	t	M_{4} (S (S (I^{[x_{114} := (c_{1} x_{112} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (M_{1}^{1} (A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})))	EO DM
211	419	t	M_{4} (S (I^{[x_{114},x_{112} := x_{112},(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (M_{1}^{1} (A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})))	EO DM
212	420	t	M_{4} (S (S (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} (I^{[x_{114} := x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (M_{1}^{1} (A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{cb} c_{1} (\\Phi_{(b,cb)} c_{1}))})))	EO DM
217	424	t	A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}	SS
213	421	t	S A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})} (L^{\\lambda x_{122}.c_{7} x_{122}} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}) (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})	SS
220	427	t	L^{\\lambda x_{122}.c_{6} x_{114} x_{122}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} (I^{[x_{113},x_{112} := x_{114},(c_{1} x_{113} (c_{7} x_{112}))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})}) (L^{\\lambda x_{122}.c_{1} x_{114} x_{122}} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (L^{\\lambda x_{122}.c_{1} x_{114} x_{122}} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})})) (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{7} x_{112})} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})}))) (S (I^{[x_{113} := (c_{6} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})}))	SS
222	429	t	L^{\\lambda x_{122}.c_{1} x_{114} x_{122}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})})))	SS
214	422	t	M_{4} (S (S (I^{[x_{113},x_{112} := x_{112},(c_{7} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{113} := (c_{7} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (I^{[x_{113} := (c_{7} x_{112})]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	EO DM
218	425	t	L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}) (I^{[x_{114},x_{113} := x_{112},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{112} x_{112}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (S (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))	SS
215	423	t	M_{4} (I^{[x_{112},x_{113} := c_{9},(c_{7} c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})} (S (I^{[x_{113},x_{112} := c_{9},c_{8}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{112},x_{113} := c_{8},c_{9}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{113},x_{112} := c_{8},c_{9}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}) (M_{1}^{1} (A^{= (c_{7} c_{8}) c_{9}})))	EO DM
221	428	t	L^{\\lambda x_{122}.c_{1} x_{114} x_{122}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})}))	SS
223	430	t	S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} A^{= (c_{7} c_{8}) c_{9}} (I^{[x_{113} := (c_{7} c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{113},x_{112} := x_{112},c_{8}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})))	SS
224	431	t	M_{4} (S (I^{[x_{114},x_{113},x_{112} := c_{9},x_{112},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (M_{1}^{1} (A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})))	EO DM
204	412	t	S (S (I^{[x_{113} := c_{8}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})})	DM
376	469	t	S (L^{\\lambda x_{126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{120}.x_{126})} (M_{3} (M_{1}^{1} (I^{[x_{114},x_{113},x_{112} := (x_{82} x_{120}),(x_{81} x_{120}),(x_{80} x_{120})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})} (L^{\\lambda x_{122}.c_{5} x_{122} (x_{80} x_{120})} (I^{[x_{112},x_{113} := (x_{81} x_{120}),(x_{82} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))))) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}}	GE (OE SS)
330	497	t	S (I^{[x_{113},x_{112} := (c_{1} x_{113} x_{112}),(c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112}))]} A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) x_{122}} (I^{[x_{114},x_{112},x_{113} := x_{113},(c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112})),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{4} x_{113} (c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112}))) x_{122})} (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112})),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{4} (c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112})) x_{112}))} (I^{[x_{112} := (c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{4} (c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112})) x_{113}) x_{122})} (I^{[x_{114},x_{113} := (c_{2} x_{112} x_{113}),(c_{2} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{112}) (c_{4} (c_{2} x_{113} x_{112}) x_{112})))} (I^{[x_{114},x_{112},x_{113} := (c_{2} x_{112} x_{113}),x_{113},(c_{2} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{112}) (c_{4} x_{122} x_{112})))} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} x_{122} x_{112}) (c_{4} (c_{4} x_{113} (c_{7} x_{112})) x_{112})))} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} (c_{4} x_{112} (c_{7} x_{113})) x_{112}) x_{122}))} (I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} (c_{4} x_{112} (c_{7} x_{113})) x_{112}) (c_{4} x_{113} x_{122})))} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} (c_{4} x_{112} (c_{7} x_{113})) x_{112}) x_{122}))} (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} (c_{4} x_{112} (c_{7} x_{113})) x_{112}) x_{122}))} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} x_{122} c_{8}))} (I^{[x_{113} := (c_{4} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} x_{122} c_{8}))} (I^{[x_{114},x_{113},x_{112} := x_{112},x_{112},(c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} x_{122} (c_{7} x_{113})) c_{8}))} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) x_{122})} (I^{[x_{112},x_{113} := c_{8},(c_{4} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) x_{122})} (I^{[x_{112} := (c_{4} x_{112} (c_{7} x_{113}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} x_{122} x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} x_{122} x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) x_{122}) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{114},x_{112} := (c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{7} x_{112}) x_{122})) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} x_{122} x_{113}) (c_{4} (c_{7} x_{112}) x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} x_{122} (c_{4} (c_{7} x_{112}) x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{114},x_{113},x_{112} := x_{112},(c_{7} x_{113}),x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} x_{112} x_{122}) (c_{4} (c_{7} x_{112}) x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{112} := x_{113}]} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} x_{122} (c_{4} (c_{7} x_{112}) x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{112},x_{113} := c_{8},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} x_{122} (c_{4} (c_{7} x_{112}) x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))}) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{112} := (c_{4} (c_{7} x_{112}) x_{113})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{4} (c_{7} x_{112}) x_{113}) x_{122})} (I^{[x_{113},x_{112} := x_{112},(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{1} c_{5})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{1} (c_{1} x_{112} (c_{7} x_{113})) (c_{5} x_{112} (c_{7} x_{113}))))} (I^{[x_{113},x_{112} := (c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{1} c_{5})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{1} (c_{1} x_{112} (c_{7} x_{113})) (c_{5} x_{112} (c_{7} x_{113}))))} (I^{[x_{112},x_{113} := (c_{5} (c_{7} x_{112}) x_{113}),(c_{1} (c_{7} x_{112}) x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{5} (c_{7} x_{112}) x_{113}) (c_{1} (c_{7} x_{112}) x_{113})),(c_{1} x_{112} (c_{7} x_{113})),(c_{5} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{5} x_{112} (c_{7} x_{113})))} (I^{[x_{114},x_{113},x_{112} := (c_{5} (c_{7} x_{112}) x_{113}),(c_{1} (c_{7} x_{112}) x_{113}),(c_{1} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{1} (c_{5} (c_{7} x_{112}) x_{113}) (c_{1} x_{122} (c_{1} x_{112} (c_{7} x_{113})))) (c_{5} x_{112} (c_{7} x_{113})))} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{1} (c_{5} (c_{7} x_{112}) x_{113}) x_{122}) (c_{5} x_{112} (c_{7} x_{113})))} (I^{[x_{113} := (c_{1} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{5} x_{112} (c_{7} x_{113})))} (I^{[x_{113} := (c_{5} (c_{7} x_{112}) x_{113})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{122}) (c_{1} (c_{5} (c_{7} x_{112}) x_{113}) (c_{5} x_{112} (c_{7} x_{113})))} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{5} (c_{7} x_{112}) x_{113}) (c_{5} x_{112} (c_{7} x_{113})))} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{5} (c_{7} x_{112}) x_{113}) (c_{5} x_{112} (c_{7} x_{113})))} (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{7} x_{112}) (c_{7} x_{113})),(c_{5} (c_{7} x_{112}) x_{113}),(c_{5} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{112} (c_{7} x_{113}))} (I^{[x_{114},x_{113},x_{112} := (c_{7} x_{112}),(c_{7} x_{113}),(c_{5} (c_{7} x_{112}) x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (I^{[x_{112},x_{113} := (c_{5} x_{112} (c_{7} x_{113})),(c_{1} (c_{7} x_{112}) (c_{1} (c_{7} x_{113}) (c_{5} (c_{7} x_{112}) x_{113})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{114},x_{113},x_{112} := (c_{5} x_{112} (c_{7} x_{113})),(c_{7} x_{112}),(c_{1} (c_{7} x_{113}) (c_{5} (c_{7} x_{112}) x_{113}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{7} x_{113}) (c_{5} (c_{7} x_{112}) x_{113}))} (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{5} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{7} x_{112}) x_{122}) (c_{1} (c_{7} x_{113}) (c_{5} (c_{7} x_{112}) x_{113}))} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{7} x_{112}) (c_{5} (c_{7} x_{113}) x_{112})) x_{122}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{cc(bbb,)} c_{7} c_{5} \\Phi_{bcbb} c_{1} c_{7}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{112} x_{113})} A^{= (\\Phi_{cc(bbb,)} c_{7} c_{5} \\Phi_{bcbb} c_{1} c_{7}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (I^{[x_{112},x_{113} := x_{113},x_{112}]} (M_{1}^{1} (A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})))	DM
225	425	t	M_{4} (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})} (L^{\\lambda x_{122}.c_{4} (c_{1} x_{122} x_{112}) x_{112}} A^{= (c_{7} c_{8}) c_{9}}) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113} := (c_{7} x_{112}),c_{8}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} c_{8} x_{112})} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})	EO DM
395	473	t	L^{\\lambda x_{122}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{113},x_{112} := x_{81},(x_{80} x_{120})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{112},x_{113} := (c_{7} (x_{80} x_{120})),x_{81}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{82},x_{81},x_{80} := (\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{7} (x_{80} x_{120})),x_{81}]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) (I^{[x_{112},x_{113} := x_{81},(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{7} (x_{80} x_{120})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (L^{\\lambda x_{122}.c_{4} x_{81} x_{122}} (I^{[x_{112} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{7} (x_{80} x_{120})))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))) (S (I^{[x_{113},x_{112} := x_{81},(c_{7} (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{7} (x_{80} x_{120}))))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{122}.c_{2} x_{81} x_{122}} (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})})))	SS
396	530	t	S (L^{\\lambda x_{122}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.x_{122})} (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) (S (I^{[x_{81},x_{80} := (\\lambda x_{120}.c_{8}),c_{8}]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) (I^{[x_{112},x_{113} := c_{8},(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.c_{8}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.c_{8}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})	SS
233	438	t	I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{112} x_{112}) x_{122}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{113} := (c_{4} x_{112} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}) A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}	SS
231	436	t	A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{112} x_{113})} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}))	SS
226	432	t	L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (c_{7} c_{8}) c_{9}} (L^{\\lambda x_{122}.c_{4} (c_{7} x_{122}) x_{112}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (I^{[x_{114},x_{113} := x_{112},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} (c_{7} x_{112}) x_{112})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})	SS
229	435	t	S (I^{[x_{114} := (c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}))) (S (L^{\\lambda x_{122}.c_{4} (c_{7} x_{122}) x_{112}} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})})) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (c_{7} c_{8}) c_{9}})) A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))}	SS
227	433	t	S (L^{\\lambda x_{122}.c_{4} (c_{4} x_{114} x_{113}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{113}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{114},x_{113} := (c_{4} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (I^{[x_{112},x_{113} := (c_{4} x_{114} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})	SS
236	441	t	S (I^{[x_{114} := (c_{5} x_{114} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})} (S (L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}))) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{114} x_{122}) x_{112}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}) (S (I^{[x_{114},x_{113} := (c_{5} x_{114} x_{113}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{114} x_{113}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})}))	SS
228	434	t	S (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (S (I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}))) (I^{[x_{114},x_{113} := x_{112},(c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} (c_{7} x_{113}) x_{112})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})	SS
237	442	t	I^{[x_{113} := (c_{7} x_{112})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{7} x_{112}) x_{112}) x_{122}} (I^{[x_{113} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{7} x_{112}) x_{112}) x_{122}} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})}) (L^{\\lambda x_{122}.c_{1} x_{122} c_{9}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112},x_{113} := c_{9},c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (S A^{= (c_{7} c_{8}) c_{9}})	SS
234	439	t	I^{[x_{113} := c_{8}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} c_{8} x_{112})} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))}) (L^{\\lambda x_{122}.c_{1} c_{8} x_{122}} (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} c_{8} x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})	SS
235	440	t	I^{[x_{113} := c_{9}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (S (L^{\\lambda x_{122}.c_{1} (c_{4} c_{9} x_{112}) x_{122}} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{7} x_{112})} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))}) (S (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (S A^{= (c_{7} c_{8}) c_{9}})	SS
331	498	t	I^{[x_{112} := (c_{7} (c_{2} x_{112} (c_{5} x_{113} x_{112})))]} A^{= (\\Phi_{b} c_{7}) (\\Phi_{b} (c_{2} c_{9}))} (I^{[x_{112} := (c_{2} x_{112} (c_{5} x_{113} x_{112}))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (S (I^{[x_{112} := (c_{7} (c_{2} x_{112} (c_{5} x_{113} x_{112})))]} A^{= (\\Phi_{b} c_{7}) (\\Phi_{b} (c_{2} c_{9}))} (I^{[x_{112} := (c_{2} x_{112} (c_{5} x_{113} x_{112}))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{1}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{1} (c_{5} x_{113} x_{112}) x_{122}} (I^{[x_{114} := x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{5} x_{113} x_{112}) (c_{5} x_{122} x_{112})} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{5} x_{113} x_{112}) x_{122}} (I^{[x_{114},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}))) (L^{\\lambda x_{122}.c_{1} (c_{5} x_{113} x_{112}) (c_{5} x_{113} x_{122})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})})) (I^{[x_{113} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	CO DM
230	433	t	S (I^{[x_{114} := (c_{4} x_{114} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})} (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{4} (c_{4} x_{114} x_{122}) x_{112}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (S (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{113}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{4} x_{114} x_{113}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}))	SS
232	437	t	I^{[x_{113},x_{112} := x_{114},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} x_{122}) (c_{1} x_{114} (c_{5} x_{113} x_{112}))} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{5} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{1} (c_{4} x_{113} x_{112}) (c_{1} x_{113} x_{112})),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{5} x_{113} x_{112}))} (I^{[x_{114},x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{114},(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{113} x_{112}) x_{114}) x_{122}) (c_{1} x_{114} (c_{5} x_{113} x_{112}))} (I^{[x_{114},x_{112},x_{113} := x_{113},x_{114},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{112} x_{114}))) (c_{1} x_{114} (c_{5} x_{113} x_{112}))} (I^{[x_{112},x_{113} := x_{114},(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{112} x_{114}))) (c_{1} x_{114} (c_{5} x_{113} x_{112}))} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) x_{122})) (c_{1} x_{114} (c_{5} x_{113} x_{112}))} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{114} x_{112}))) (c_{1} x_{114} x_{122})} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{114} x_{112}))) x_{122}} (I^{[x_{113},x_{112} := (c_{4} x_{113} x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{114} x_{112}))) (c_{1} x_{122} (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{114} x_{112}))) x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{4} x_{113} x_{112}),x_{114},(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{114} x_{112}))),(c_{4} x_{113} x_{112}),(c_{1} x_{114} (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{4} x_{113} x_{112})) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{4} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{114}),(c_{4} x_{114} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{4} x_{113} x_{114})),(c_{4} x_{114} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{4} x_{113} x_{114})) x_{122}) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{4} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{114}),(c_{4} (c_{1} x_{114} x_{113}) x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) x_{122}) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{4} (c_{1} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{114})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{4} x_{114} x_{113}) x_{112}),(c_{4} (c_{1} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{114})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{4} x_{113} x_{114})) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{113}),(c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{122} x_{112}) (c_{4} x_{113} x_{114})) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{5} x_{114} x_{113}) x_{112}) (c_{4} x_{113} x_{114})) x_{122}} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (I^{[x_{114},x_{113} := (c_{1} (c_{4} (c_{5} x_{114} x_{113}) x_{112}) (c_{4} x_{113} x_{114})),(c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{5} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{114}),(c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{5} x_{114} x_{113}) x_{112}) (c_{1} x_{122} (c_{1} x_{114} x_{113}))) x_{112}} (I^{[x_{112} := x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{5} x_{114} x_{113}) x_{112}) x_{122}) x_{112}} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}))) (S (I^{[x_{114},x_{113} := (c_{4} (c_{5} x_{114} x_{113}) x_{112}),(c_{5} x_{114} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (I^{[x_{113} := (c_{5} x_{114} x_{113})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}))	SS
408	533	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))} (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := x_{112},(c_{5} (c_{2} x_{112} x_{113}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (I^{[x_{112} := (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))} (S (M_{3} (S (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (I^{[x_{112},x_{113} := x_{112},(c_{5} (c_{2} x_{112} x_{113}) x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}))) (S (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{2} (c_{7} x_{112}) (c_{7} (c_{5} x_{122} x_{112}))} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{2} (c_{7} x_{112}) (c_{7} (c_{5} x_{122} x_{112}))} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{7} x_{112}) (c_{7} x_{122})} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{4} c_{5} \\Phi_{cbcb})})) (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})})) A^{= T c_{8}}))))) (S (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (L^{\\lambda x_{122}.c_{2} (c_{7} (c_{5} x_{122} x_{112})) (c_{7} x_{112})} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{2} (c_{7} (c_{5} x_{122} x_{112})) (c_{7} x_{112})} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{7} x_{122}) (c_{7} x_{112})} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{4} c_{5} \\Phi_{cbcb})})) (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})})) A^{= T c_{8}}))))	EO (MI (AI (CR DM) (CR DM)))
275	470	t	S (L^{\\lambda x_{122}.c_{1} (c_{7} x_{112}) x_{122}} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{(cb,b)} c_{1} (\\Phi_{(bcbb,)} c_{1}) c_{4}) (\\Phi_{bb} \\Phi_{b} c_{5})}) (I^{[x_{112},x_{113} := (c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{7} x_{113})) x_{112}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{7} x_{113})),x_{112},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{7} x_{113})) x_{122}} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})}) (I^{[x_{112},x_{113} := c_{9},(c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{7} x_{113}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{112} := (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{7} x_{113}))]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (S (L^{\\lambda x_{122}.c_{7} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) x_{122})} (I^{[x_{112} := (c_{7} x_{113})]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}))) (L^{\\lambda x_{122}.c_{7} (c_{1} x_{122} (c_{4} (c_{7} x_{113}) (c_{7} x_{113})))} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{114},x_{112},x_{113} := x_{112},(c_{7} x_{113}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{7} (c_{4} x_{122} (c_{7} x_{113}))} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}))) (I^{[x_{113},x_{112} := (c_{7} (c_{1} x_{112} x_{113})),(c_{7} x_{113})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{7} (c_{7} (c_{1} x_{112} x_{113}))) x_{122}} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{5} x_{122} x_{113}} (I^{[x_{112} := (c_{1} x_{112} x_{113})]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{5} x_{122} x_{113}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{1} (\\Phi_{(bcb,)} c_{5}))}) (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))	SS
238	443	t	L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}) (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{113}),(c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) x_{122}} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} x_{114} x_{112}) (c_{4} x_{113} x_{112}))} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{4}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{4})}) (S (I^{[x_{113},x_{112} := (c_{4} x_{114} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}))	SS
276	471	t	I^{[x_{80} := (\\lambda x_{120}.x_{80})]} A^{= (\\Phi_{bb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbb} \\Phi_{b})} (L^{\\lambda x_{122}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{113},x_{112} := x_{80},(x_{82} x_{120})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{122}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{112},x_{113} := x_{80},(c_{7} (x_{82} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (S (I^{[x_{82},x_{81} := (\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{7} (x_{82} x_{120}))]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})}))	SS
259	464	t	S (L^{\\lambda x_{122}.c_{5} (x_{69} x_{112}) x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (S (L^{\\lambda x_{122}.c_{5} (x_{69} x_{112}) x_{122}} (I^{[x_{112} := (c_{1} x_{112} c_{8})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}))) (S (L^{\\lambda x_{122}.c_{5} (x_{69} x_{112}) (c_{5} x_{122} (c_{1} x_{112} c_{8}))} (I^{[x_{102},x_{101} := x_{112},c_{8}]} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})}))))) (L^{\\lambda x_{122}.c_{5} (x_{69} x_{112}) x_{122}} (I^{[x_{113},x_{112} := (c_{1} (x_{69} x_{112}) (x_{69} c_{8})),(c_{1} x_{112} c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})})) (I^{[x_{114},x_{113},x_{112} := (x_{69} x_{112}),(c_{1} (x_{69} x_{112}) (x_{69} c_{8})),(c_{1} x_{112} c_{8})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}) (S (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{1} (x_{69} x_{112}) (x_{69} c_{8}))) (c_{1} x_{112} c_{8})} (I^{[x_{113} := (x_{69} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))) (L^{\\lambda x_{122}.c_{5} (c_{5} (c_{1} (x_{69} x_{112}) c_{8}) x_{122}) (c_{1} x_{112} c_{8})} (I^{[x_{112},x_{113} := (x_{69} c_{8}),(x_{69} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{1} x_{112} c_{8})} (I^{[x_{113},x_{114},x_{112} := (x_{69} c_{8}),c_{8},(x_{69} x_{112})]} A^{= (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{1} c_{1}) (\\Phi_{ccbb} (\\Phi_{(bcb,b)} c_{5}) c_{1} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{1} (x_{69} c_{8}) (x_{69} x_{112}))) (c_{1} x_{112} c_{8})} (I^{[x_{113} := (x_{69} c_{8})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (S (I^{[x_{114},x_{113},x_{112} := (x_{69} c_{8}),(c_{1} (x_{69} c_{8}) (x_{69} x_{112})),(c_{1} x_{112} c_{8})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (S (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) x_{122}} (I^{[x_{113},x_{112} := (c_{1} (x_{69} c_{8}) (x_{69} x_{112})),(c_{1} x_{112} c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})}))) (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) (c_{5} (c_{2} x_{122} (c_{1} x_{112} c_{8})) (c_{1} x_{112} c_{8}))} (I^{[x_{112},x_{113} := (x_{69} x_{112}),(x_{69} c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) (c_{5} x_{122} (c_{1} x_{112} c_{8}))} (I^{[x_{102},x_{101} := x_{112},c_{8}]} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})})))) (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) x_{122}} (I^{[x_{112} := (c_{1} x_{112} c_{8})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))	SS
257	462	t	M_{4} (S (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{122}} (I^{[x_{113},x_{112} := (c_{1} x_{112} x_{114}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{(cb,b)} c_{1} (\\Phi_{(bcbb,)} c_{1}) c_{4}) (\\Phi_{bb} \\Phi_{b} c_{5})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{112} x_{114})) (c_{1} x_{113} x_{112}))} (I^{[x_{113},x_{112} := (c_{1} x_{113} x_{114}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{(cb,b)} c_{1} (\\Phi_{(bcbb,)} c_{1}) c_{4}) (\\Phi_{bb} \\Phi_{b} c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{113} x_{114})) (c_{1} x_{113} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),(c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{112} x_{114}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{113} x_{114})) (c_{1} x_{113} x_{112})),(c_{1} x_{113} x_{112}),(c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{112} x_{114}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{112} x_{114}))} (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{113} x_{114})),(c_{1} x_{113} x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{113} x_{114})) x_{122}) (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{112} x_{114}))} (I^{[x_{113} := (c_{1} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{112} x_{114}))} (I^{[x_{113} := (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{113} x_{114}))]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{113} x_{114})) x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})),x_{112},x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) x_{112}) x_{114})} (I^{[x_{114},x_{112} := (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})),x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113}) x_{114}) x_{122}} (I^{[x_{112},x_{113} := x_{114},(c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113}) x_{114}),x_{114},(c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) x_{112})} (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113}),x_{114},x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113}) x_{122}) (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) x_{112})} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) x_{112})} (I^{[x_{113} := (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113}) x_{122}} (I^{[x_{113} := (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113}),x_{112},(c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112}))} (I^{[x_{114} := (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),(c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (I^{[x_{114},x_{113},x_{112} := (c_{1} x_{113} x_{112}),(c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})),(c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) x_{122}} (I^{[x_{114},x_{112},x_{113} := (c_{1} x_{113} x_{114}),(c_{1} x_{113} x_{112}),(c_{1} x_{112} x_{114})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{4} (c_{1} (c_{1} x_{113} x_{114}) x_{122}) (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{4} x_{122} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113} := (c_{1} x_{113} x_{114}),x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{4} (c_{1} x_{122} x_{112}) (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113},x_{112} := x_{113},x_{114},x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{4} (c_{1} (c_{1} x_{113} x_{122}) x_{112}) (c_{1} x_{113} x_{112}))} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{4} (c_{1} x_{122} x_{112}) (c_{1} x_{113} x_{112}))} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (I^{[x_{112} := (c_{1} x_{113} x_{112})]} (M_{1}^{1} (A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}))))	EO DM
521	528	t	L^{\\lambda x_{-126}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.x_{-126})} (I^{[x_{113},x_{112} := (c_{15} x_{120} x_{120}),(c_{5} (c_{15} x_{121} x_{122}) (c_{15} x_{122} x_{121}))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{-126}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.x_{-126})} (I^{[x_{112},x_{113} := (c_{7} (c_{5} (c_{15} x_{121} x_{122}) (c_{15} x_{122} x_{121}))),(c_{15} x_{120} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{82},x_{81},x_{80} := (\\lambda x_{122}.c_{8}),(\\lambda x_{122}.c_{7} (c_{5} (c_{15} x_{121} x_{122}) (c_{15} x_{122} x_{121}))),(c_{15} x_{120} x_{120})]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) (I^{[x_{112},x_{113} := (c_{15} x_{120} x_{120}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{7} (c_{5} (c_{15} x_{121} x_{122}) (c_{15} x_{122} x_{121}))))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (L^{\\lambda x_{-126}.c_{4} (c_{15} x_{120} x_{120}) x_{-126}} (I^{[x_{112} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{7} (c_{5} (c_{15} x_{121} x_{122}) (c_{15} x_{122} x_{121}))))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))) (S (L^{\\lambda x_{-126}.c_{4} (c_{15} x_{120} x_{120}) (c_{7} x_{-126})} (I^{[x_{82},x_{80} := (\\lambda x_{122}.c_{8}),(\\lambda x_{122}.c_{5} (c_{15} x_{121} x_{122}) (c_{15} x_{122} x_{121}))]} A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})}))) (S (I^{[x_{113},x_{112} := (c_{15} x_{120} x_{120}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{4} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{5} (c_{15} x_{121} x_{122}) (c_{15} x_{122} x_{121})))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{-126}.c_{2} (c_{15} x_{120} x_{120}) x_{-126}} (I^{[x_{80},x_{82} := (\\lambda x_{122}.c_{15} x_{121} x_{122}),(\\lambda x_{122}.c_{15} x_{122} x_{121})]} A^{= (\\Phi_{bb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{cbb} \\Phi_{b})}))) (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{122}.x_{-126})} (M_{3} (S (S (L^{\\lambda x_{119}.c_{2} x_{119} (c_{5} (c_{15} x_{121} x_{122}) (c_{15} x_{122} x_{121}))} (I^{[x_{113} := x_{120}]} A^{= (\\Phi_{(b,)} c_{15}) (\\Phi_{K} c_{8})})) (I^{[x_{112} := (c_{5} (c_{15} x_{121} x_{122}) (c_{15} x_{122} x_{121}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})	WI DM
380	527	t	S (L^{\\lambda x_{126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{120}.x_{126})} (M_{3} (S (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{5} (x_{81} x_{120}) (x_{82} x_{120})) x_{122}) (x_{80} x_{120})} (I^{[x_{112},x_{113} := (x_{81} x_{120}),(x_{82} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}) (S (L^{\\lambda x_{122}.c_{2} x_{122} (x_{80} x_{120})} (I^{[x_{113} := (c_{5} (x_{81} x_{120}) (x_{82} x_{120}))]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{112} := (x_{80} x_{120})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) (S (I^{[x_{80},x_{82} := (\\lambda x_{120}.c_{1} (c_{5} (x_{81} x_{120}) (x_{82} x_{120})) (c_{5} (x_{82} x_{120}) (x_{81} x_{120}))),(\\lambda x_{120}.x_{80} x_{120})]} A^{= (\\Phi_{bb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbb} \\Phi_{b})})) A^{= T c_{8}}	GE DM
583	705	t	M_{4} (I^{[x_{69},x_{101},x_{102} := (\\lambda x_{-126}.c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) x_{-126}),(c_{5} (c_{5} (c_{5} (c_{5} (c_{5} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} c_{8}))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{9})) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{8})) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})),(c_{5} (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))} (M_{1}^{1} (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} (c_{5} (c_{5} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} c_{8}))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{9})) x_{-126}) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (I^{[x_{113},x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),c_{8}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} c_{8}),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} (c_{5} (c_{5} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} c_{8}))) x_{-126}) (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (I^{[x_{113},x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),c_{9}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} c_{9}),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} (c_{5} (c_{5} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))) x_{-126}) (c_{4} (c_{7} c_{9}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (I^{[x_{113},x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} c_{8})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} (c_{7} c_{8})),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} (c_{5} (c_{5} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))) x_{-126}) (c_{4} (c_{7} (c_{7} c_{8})) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{9}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (I^{[x_{113},x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} (c_{7} c_{9}))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} (c_{7} (c_{7} c_{9}))),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} (c_{5} (c_{5} x_{-126} (c_{4} (c_{7} (c_{7} (c_{7} c_{9}))) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} (c_{7} c_{8})) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{9}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (I^{[x_{113},x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} (c_{5} x_{-126} (c_{4} (c_{7} (c_{7} c_{8})) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{9}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (S (I^{[x_{114},x_{112},x_{113} := (c_{7} (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} (c_{7} (c_{7} c_{9})))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}) (S (L^{\\lambda x_{-126}.c_{4} x_{-126} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))} (I^{[x_{113},x_{112} := (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))),(c_{7} (c_{7} c_{9}))]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}))))) (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} x_{-126} (c_{4} (c_{7} c_{9}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (S (I^{[x_{114},x_{112},x_{113} := (c_{7} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9})))),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} (c_{7} c_{8}))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}) (S (L^{\\lambda x_{-126}.c_{4} x_{-126} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))} (I^{[x_{113},x_{112} := (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))),(c_{7} c_{8})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}))))) (L^{\\lambda x_{-126}.c_{5} (c_{5} x_{-126} (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (S (I^{[x_{114},x_{112},x_{113} := (c_{7} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8}))),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} c_{9})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}) (S (L^{\\lambda x_{-126}.c_{4} x_{-126} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))} (I^{[x_{113},x_{112} := (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})),c_{9}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}))))) (L^{\\lambda x_{-126}.c_{5} x_{-126} (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (S (I^{[x_{114},x_{112},x_{113} := (c_{7} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9})),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} c_{8})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}) (S (L^{\\lambda x_{-126}.c_{4} x_{-126} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))} (I^{[x_{113},x_{112} := (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}),c_{8}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}))))) (L^{\\lambda x_{-126}.c_{5} x_{-126} (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (I^{[x_{112},x_{113} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (I^{[x_{113},x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cbb} c_{7} (\\Phi_{(bbb,)} c_{5}) c_{4})}) (I^{[x_{112},x_{113} := (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8}),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (I^{[x_{112},x_{113} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})}) (S (I^{[x_{112} := (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (S (M_{3} (S (I^{[x_{112} := (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{8})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{8})} (S (M_{3} (S (I^{[x_{112} := (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{9})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{9})} (S (M_{3} (S (I^{[x_{112} := (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} c_{8}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} c_{8}))} (S (M_{3} (S (I^{[x_{112} := (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))} (S (M_{3} (S (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} x_{122}))} (I^{[x_{112} := c_{9}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) x_{122}} (I^{[x_{112} := c_{9}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (I^{[x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{9} c_{2})})) A^{= T c_{8}})))) (S (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) x_{122}} (I^{[x_{112} := c_{9}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (I^{[x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{9} c_{2})})) A^{= T c_{8}}))))) (S (S (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) x_{122}} A^{= (c_{7} c_{8}) c_{9}}) (I^{[x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{9} c_{2})})) A^{= T c_{8}}))))) (S (I^{[x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{9} c_{2})}) A^{= T c_{8}}))))) (S (I^{[x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{2})} (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) x_{122}} (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) x_{122}} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{1} (c_{4} x_{114} (c_{7} x_{112})) x_{122})} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{1} x_{122} (c_{2} x_{113} x_{112}))} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})))) (I^{[x_{113} := (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112}))]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})})))))) (S (I^{[x_{112},x_{113} := c_{8},(c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})} (I^{[x_{112} := (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}})))	EO (CA (AI DM (AI DM (AI DM (AI DM (AI DM DM)))))):c_{5} (c_{5} (c_{5} (c_{5} (c_{5} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} c_{8}))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{9})) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{8})) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})
240	445	t	I^{[x_{113} := (c_{1} x_{112} x_{113})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) x_{122}} (I^{[x_{113} := (c_{1} x_{112} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) x_{122}} (I^{[x_{114},x_{113},x_{112} := x_{112},x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) (c_{1} x_{122} x_{113})} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) x_{122}} (I^{[x_{112},x_{113} := x_{113},c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) x_{122}} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} x_{113}} (I^{[x_{114} := x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{4} x_{113} x_{112})) x_{113}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{1} x_{122} x_{113}} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (I^{[x_{114},x_{113},x_{112} := (c_{4} x_{113} x_{112}),x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})	SS
241	446	t	A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(cbbb,b)} c_{7} (\\Phi_{(bbb,b)} c_{4}) c_{5} c_{7} c_{5}) (\\Phi_{bb} \\Phi_{b} c_{1})}) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) (c_{7} (c_{4} x_{113} x_{112}))) x_{122}} (I^{[x_{112} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) (c_{7} (c_{4} x_{113} x_{112}))) x_{122}} (I^{[x_{114},x_{112},x_{113} := x_{113},x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) (c_{7} (c_{4} x_{113} x_{112}))) (c_{4} x_{122} (c_{5} x_{112} x_{113}))} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) (c_{7} (c_{4} x_{113} x_{112}))) x_{122}} (I^{[x_{112} := (c_{5} x_{112} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) (c_{7} (c_{4} x_{113} x_{112}))) x_{122}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{5} c_{4} \\Phi_{cbcb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) x_{122}) x_{113}} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{113}} (I^{[x_{114},x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{122} (c_{7} x_{112})) x_{113}} (I^{[x_{112} := (c_{7} x_{113})]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{113}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (I^{[x_{113},x_{112} := (c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cbb} c_{7} (\\Phi_{(bbb,)} c_{4}) c_{5})}) (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})	SS
258	463	t	A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S A^{= (\\Phi_{(cb,b)} c_{1} \\Phi_{cbb} c_{4}) (\\Phi_{bb} (\\Phi_{(b,b)} c_{1}) c_{5})})	SS
261	466	t	S (I^{[x_{112} := (c_{4} (x_{69} x_{112}) x_{112})]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := (x_{69} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})})) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} x_{112})) x_{122})} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})}) (S (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} x_{112})) x_{122})} (I^{[x_{112} := (c_{1} c_{9} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}))) (S (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} x_{112})) (c_{5} x_{122} (c_{1} c_{9} x_{112})))} (I^{[x_{102},x_{101} := c_{9},x_{112}]} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})}))))) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} x_{112})) x_{122})} (I^{[x_{113},x_{112} := (c_{1} (x_{69} c_{9}) (x_{69} x_{112})),(c_{1} c_{9} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})})) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{7} (x_{69} x_{112})),(c_{1} (x_{69} c_{9}) (x_{69} x_{112})),(c_{1} c_{9} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{5} x_{122} (c_{1} (x_{69} c_{9}) (x_{69} x_{112}))) (c_{1} c_{9} x_{112}))} (I^{[x_{112} := (x_{69} x_{112})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{5} x_{122} (c_{1} (x_{69} c_{9}) (x_{69} x_{112}))) (c_{1} c_{9} x_{112}))} (I^{[x_{112},x_{113} := (x_{69} x_{112}),c_{9}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{7} (c_{5} x_{122} (c_{1} c_{9} x_{112}))} (I^{[x_{113},x_{114},x_{112} := (x_{69} c_{9}),c_{9},(x_{69} x_{112})]} A^{= (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{1} c_{1}) (\\Phi_{ccbb} (\\Phi_{(bcb,b)} c_{5}) c_{1} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{5} x_{122} (c_{1} (x_{69} c_{9}) (x_{69} x_{112}))) (c_{1} c_{9} x_{112}))} (I^{[x_{112},x_{113} := c_{9},(x_{69} c_{9})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{5} x_{122} (c_{1} (x_{69} c_{9}) (x_{69} x_{112}))) (c_{1} c_{9} x_{112}))} (I^{[x_{112} := (x_{69} c_{9})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})}))) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{7} (x_{69} c_{9})),(c_{1} (x_{69} c_{9}) (x_{69} x_{112})),(c_{1} c_{9} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}))) (S (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} c_{9})) x_{122})} (I^{[x_{113},x_{112} := (c_{1} (x_{69} c_{9}) (x_{69} x_{112})),(c_{1} c_{9} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})}))) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} c_{9})) (c_{5} x_{122} (c_{1} c_{9} x_{112})))} (I^{[x_{102},x_{101} := c_{9},x_{112}]} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})})))) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} c_{9})) x_{122})} (I^{[x_{112} := (c_{1} c_{9} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (S (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} c_{9})) x_{122})} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (I^{[x_{113},x_{112} := (c_{7} (x_{69} c_{9})),(c_{7} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})}) (L^{\\lambda x_{122}.c_{4} (c_{7} (c_{7} (x_{69} c_{9}))) x_{122}} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112} := (x_{69} c_{9})]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))	SS
584	729	t	I^{[x_{98} := c_{42}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{55}) (\\Phi_{cb} c_{55} \\Phi_{cb})} A^{= \\Phi_{} (\\Phi_{cb} c_{42} c_{55})}	SS
255	460	t	S (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{7} x_{113}) (c_{7} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{7} x_{113}) (c_{7} x_{112})),(c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) (c_{7} x_{112})) x_{122}) (c_{7} x_{113})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}))) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{7} x_{113})} (I^{[x_{114},x_{112},x_{113} := (c_{7} x_{113}),(c_{7} x_{112}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{122} (c_{7} x_{112})) (c_{7} x_{113})} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{122} x_{112}) (c_{7} x_{112})) (c_{7} x_{113})} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{7} x_{113})} (I^{[x_{114},x_{112},x_{113} := x_{113},(c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{113} (c_{7} x_{112})) x_{122}) (c_{7} x_{113})} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{113} (c_{7} x_{112})) x_{122}) (c_{7} x_{113})} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{7} x_{113})} (I^{[x_{113} := (c_{4} x_{113} (c_{7} x_{112}))]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (S (I^{[x_{113},x_{112} := (c_{4} x_{113} (c_{7} x_{112})),x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (L^{\\lambda x_{122}.c_{7} (c_{1} x_{122} x_{113})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{7} (c_{1} (c_{4} (c_{7} x_{112}) x_{113}) x_{122})} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}))) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{114},x_{112} := (c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{7} (c_{4} x_{122} x_{113})} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{114},x_{112},x_{113} := x_{112},x_{113},(c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{7} (c_{1} (c_{4} x_{112} x_{113}) x_{122})} (I^{[x_{112} := x_{113}]} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := (c_{4} x_{112} x_{113})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})))	SS
260	465	t	L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})}) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} x_{112}) x_{122}} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}) (I^{[x_{112},x_{113} := c_{9},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{5} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})	SS
585	730	t	I^{[x_{97},x_{98} := c_{43},x_{97}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{57}) (\\Phi_{cb} c_{57} \\Phi_{cb})} A^{= \\Phi_{} (\\Phi_{b} (c_{57} c_{43}))}	SS
308	476	t	S (I^{[x_{113},x_{112} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{4} (c_{7} x_{112}) x_{122}} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))	SS
400	533	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))} (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := x_{112},(c_{5} (c_{2} x_{112} x_{113}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (I^{[x_{112} := (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))} (S (M_{3} (S (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{2} (c_{5} x_{122} x_{112}) x_{112}} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{2} (c_{5} x_{122} x_{112}) x_{112}} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} x_{122} x_{112}} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{4} c_{5} \\Phi_{cbcb})})) A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})}) A^{= T c_{8}})))) (S (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (I^{[x_{113},x_{112} := (c_{7} (c_{5} (c_{2} x_{112} x_{113}) x_{112})),(c_{7} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{4} (c_{7} (c_{5} (c_{2} x_{112} x_{113}) x_{112})) x_{122}} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113} := (c_{2} x_{112} x_{113})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})})) (S (I^{[x_{114},x_{113} := (c_{7} (c_{2} x_{112} x_{113})),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{7} (c_{2} x_{112} x_{113})) x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112},x_{113} := c_{8},(c_{7} (c_{2} x_{112} x_{113}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{7} (c_{2} x_{112} x_{113}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}}))))	EO (MI (AI (CR DM) DM))
586	731	t	I^{[x_{97},x_{98} := (c_{55} x_{99} x_{98}),x_{97}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{57}) (\\Phi_{cb} c_{57} \\Phi_{cb})} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})} (L^{\\lambda x_{122}.c_{55} (c_{57} x_{99} x_{97}) x_{122}} A^{= (\\Phi_{bb} \\Phi_{b} c_{57}) (\\Phi_{cb} c_{57} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{55} x_{122} (c_{57} x_{97} x_{98})} (I^{[x_{98} := x_{99}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{57}) (\\Phi_{cb} c_{57} \\Phi_{cb})}))	SS
254	459	t	S (S (I^{[x_{112} := (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})})) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (c_{7} x_{113})) x_{122})} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{7} (c_{5} x_{122} x_{112})} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})))	SS
248	453	t	S (S (I^{[x_{113},x_{112} := (c_{5} (c_{7} x_{113}) (c_{7} x_{112})),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(cbb,b)} c_{1} \\Phi_{b(b,b)} c_{1} c_{5})}) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) x_{122}))} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) x_{122})} (I^{[x_{114},x_{113},x_{112} := (c_{5} (c_{7} x_{113}) (c_{7} x_{112})),x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (S (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) (c_{5} x_{122} x_{113}))} (I^{[x_{114},x_{113} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}))) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) (c_{5} (c_{5} (c_{7} x_{113}) x_{122}) x_{113}))} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) (c_{5} x_{122} x_{113}))} (I^{[x_{112},x_{113} := c_{9},(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) (c_{5} x_{122} x_{113}))} (I^{[x_{112} := (c_{7} x_{113})]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{5} c_{9}))})) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) x_{122})} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{5} c_{9}))})) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) x_{122}} (I^{[x_{112},x_{113} := c_{9},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) x_{122}} (I^{[x_{112} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})}))) (I^{[x_{113},x_{112} := (c_{5} (c_{7} x_{113}) (c_{7} x_{112})),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{113} x_{112})} (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{7} (c_{7} x_{113})) x_{122}) (c_{5} x_{113} x_{112})} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{122} x_{112}) (c_{5} x_{113} x_{112})} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{113} x_{112})} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{113} x_{112}) x_{122}) (c_{5} x_{113} x_{112})} (I^{[x_{113} := (c_{1} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})})) (S (I^{[x_{114},x_{113},x_{112} := (c_{4} x_{113} x_{112}),(c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{113} x_{112})),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{1} x_{113} x_{112}),(c_{1} x_{113} x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) (c_{1} (c_{1} x_{113} x_{112}) x_{122})} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{1} c_{5})}) (I^{[x_{112},x_{113} := (c_{1} (c_{1} x_{113} x_{112}) (c_{4} x_{113} x_{112})),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{114},x_{113},x_{112} := (c_{1} x_{113} x_{112}),(c_{4} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) x_{122}} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{113} := (c_{1} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))	SS
256	461	t	A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} (S A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}) (L^{\\lambda x_{122}.c_{7} x_{122}} A^{= (\\Phi_{(cbbb,b)} c_{7} (\\Phi_{(bbb,b)} c_{4}) c_{5} c_{7} c_{5}) (\\Phi_{bb} \\Phi_{b} c_{1})}) (I^{[x_{113},x_{112} := (c_{5} (c_{7} x_{113}) (c_{7} x_{112})),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{7} (c_{5} (c_{7} x_{113}) (c_{7} x_{112}))) x_{122}} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))} (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{7} (c_{7} x_{113})) x_{122}) (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{122} x_{112}) (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (I^{[x_{114},x_{112},x_{113} := x_{113},(c_{4} (c_{7} x_{113}) (c_{7} x_{112})),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})}) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))) x_{122}} (I^{[x_{112},x_{113} := (c_{4} (c_{7} x_{113}) (c_{7} x_{112})),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))) x_{122}} (I^{[x_{114},x_{113} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))) (c_{4} (c_{5} (c_{7} x_{113}) x_{112}) x_{122})} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))) x_{122}} (I^{[x_{112},x_{113} := c_{9},(c_{5} (c_{7} x_{113}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))) x_{122}} (I^{[x_{112} := (c_{5} (c_{7} x_{113}) x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{5} (c_{7} x_{113}) x_{112})} (I^{[x_{112} := (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{5} (c_{7} x_{113}) x_{112})} (I^{[x_{114},x_{112},x_{113} := (c_{7} x_{113}),x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{4} x_{122} (c_{5} (c_{7} x_{112}) x_{113})) (c_{5} (c_{7} x_{113}) x_{112})} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{5} (c_{7} x_{113}) x_{112})} (I^{[x_{112} := (c_{5} (c_{7} x_{112}) x_{113})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{5} (c_{7} x_{113}) x_{112})} (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (I^{[x_{112},x_{113} := (c_{5} (c_{7} x_{113}) x_{112}),(c_{5} x_{113} (c_{7} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})	SS
288	474	t	M_{4} (S (L^{\\lambda x_{122}.c_{1} c_{8} x_{122}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{1} c_{8} x_{122}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} c_{8} x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	EO DM
318	485	t	S (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{113} x_{112}) x_{112}),x_{113}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (I^{[x_{113},x_{112} := (c_{7} (c_{5} (c_{2} x_{113} x_{112}) x_{112})),(c_{7} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{4} (c_{7} (c_{5} (c_{2} x_{113} x_{112}) x_{112})) x_{122}} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{4} (c_{7} x_{122}) x_{113}} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{113}} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{113}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{114},x_{113},x_{112} := (c_{7} x_{112}),(c_{7} x_{113}),x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{7} x_{112}) x_{122}} (I^{[x_{112} := x_{113}]} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (I^{[x_{112},x_{113} := c_{8},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}})	CR DM
289	475	t	I^{[x_{113} := c_{8}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})	SS
309	477	t	S (L^{\\lambda x_{122}.c_{1} (c_{5} x_{114} x_{112}) x_{122}} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{112}) (c_{1} x_{113} x_{112}))} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) (c_{1} x_{114} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} x_{114} x_{112}) (c_{1} x_{114} x_{112})),(c_{1} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} x_{113} x_{112})} (I^{[x_{114},x_{113},x_{112} := (c_{4} x_{114} x_{112}),(c_{1} x_{114} x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) (c_{1} (c_{1} x_{114} x_{112}) x_{122})) (c_{4} x_{113} x_{112})} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) x_{122}) (c_{4} x_{113} x_{112})} (I^{[x_{114},x_{113},x_{112} := (c_{1} x_{114} x_{112}),x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) (c_{1} x_{122} x_{113})) (c_{4} x_{113} x_{112})} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) (c_{1} (c_{1} x_{114} x_{122}) x_{113})) (c_{4} x_{113} x_{112})} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) (c_{1} x_{122} x_{113})) (c_{4} x_{113} x_{112})} (I^{[x_{113} := x_{114}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} x_{113} x_{112})} (I^{[x_{112},x_{113} := (c_{1} x_{114} x_{113}),(c_{4} x_{114} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (I^{[x_{114},x_{113},x_{112} := (c_{1} x_{114} x_{113}),(c_{4} x_{114} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{114} x_{113}) x_{122}} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (S (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})))	SS
249	454	t	I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{112}) x_{112})} (I^{[x_{114},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{122}) (c_{1} (c_{4} x_{113} x_{112}) x_{112})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (I^{[x_{114},x_{113} := (c_{4} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})	SS
310	478	t	S (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (S (I^{[x_{114},x_{113},x_{112} := x_{113},x_{112},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} x_{113} x_{122}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} x_{113} x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}}	DM
523	649	t	S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{65}.x_{-126})} (M_{3} (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{66}.x_{-126})} (M_{3} (S (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{115},x_{82},x_{81},x_{80} := (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}),(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{17} x_{66} x_{120}),(\\lambda x_{120}.c_{17} x_{65} x_{120})]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{17} x_{66} x_{120}) x_{122}))} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{7} (c_{16} x_{65} x_{120}))))} (I^{[x_{65} := x_{66}]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{7} (c_{16} x_{66} x_{120})) x_{122}))} (I^{[x_{112} := (c_{16} x_{65} x_{120})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{1} c_{9} (c_{16} x_{65} x_{120}))))} (I^{[x_{112} := (c_{16} x_{66} x_{120})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{1} c_{9} (c_{16} x_{66} x_{120})) x_{122}))} (I^{[x_{112},x_{113} := (c_{16} x_{65} x_{120}),c_{9}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122}))} (I^{[x_{113},x_{114},x_{112} := (c_{16} x_{65} x_{120}),(c_{16} x_{66} x_{120}),c_{9}]} A^{= (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{1} c_{1}) (\\Phi_{ccbb} (\\Phi_{(bcb,b)} c_{5}) c_{1} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{1} (c_{16} x_{65} x_{120}) c_{9})))} (I^{[x_{112},x_{113} := (c_{16} x_{66} x_{120}),(c_{16} x_{65} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{115},x_{82},x_{81},x_{80} := (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}),(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120})),(\\lambda x_{120}.c_{1} (c_{16} x_{65} x_{120}) c_{9})]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})}))) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{5} x_{122} (c_{62} (\\lambda x_{66}.\\lambda x_{65}.c_{5} x_{66} x_{65}) (\\lambda x_{121}.c_{8}) (\\lambda x_{121}.c_{1} (c_{16} x_{65} x_{121}) c_{9})))} A^{= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{1}) c_{16})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{112},x_{113} := (c_{62} (\\lambda x_{66}.\\lambda x_{65}.c_{5} x_{66} x_{65}) (\\lambda x_{121}.c_{8}) (\\lambda x_{121}.c_{1} (c_{16} x_{65} x_{121}) c_{9})),(c_{15} x_{66} x_{65})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (I^{[x_{112},x_{113} := (c_{15} x_{66} x_{65}),(c_{62} (\\lambda x_{66}.\\lambda x_{65}.c_{5} x_{66} x_{65}) (\\lambda x_{121}.c_{8}) (\\lambda x_{121}.c_{1} (c_{16} x_{65} x_{121}) c_{9}))]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})}))) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}}	GE (GE DM)
588	734	t	S (I^{[x_{97} := (c_{55} c_{43} c_{51})]} A^{= \\Phi_{} (\\Phi_{b} (c_{57} c_{43}))}) (S (I^{[x_{97} := (c_{57} c_{43} (c_{55} c_{43} c_{51}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{55} c_{42}))})) (S (I^{[x_{98},x_{97} := c_{42},c_{43}]} A^{= (\\Phi_{ccbb} c_{57} (c_{55} c_{43} c_{51}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}))	SS
527	472	t	L^{\\lambda x_{-126}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.x_{-126})} (I^{[x_{113},x_{112} := (c_{15} x_{120} x_{120}),(c_{15} x_{121} x_{122})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{-126}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.x_{-126})} (I^{[x_{112},x_{113} := (c_{7} (c_{15} x_{121} x_{122})),(c_{15} x_{120} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{82},x_{81},x_{80} := (\\lambda x_{122}.c_{8}),(\\lambda x_{122}.c_{7} (c_{15} x_{121} x_{122})),(c_{15} x_{120} x_{120})]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) (I^{[x_{112},x_{113} := (c_{15} x_{120} x_{120}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{7} (c_{15} x_{121} x_{122})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (L^{\\lambda x_{-126}.c_{4} (c_{15} x_{120} x_{120}) x_{-126}} (I^{[x_{112} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{7} (c_{15} x_{121} x_{122})))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))) (S (L^{\\lambda x_{-126}.c_{4} (c_{15} x_{120} x_{120}) (c_{7} x_{-126})} (I^{[x_{82},x_{80} := (\\lambda x_{122}.c_{8}),(\\lambda x_{122}.c_{15} x_{121} x_{122})]} A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})}))) (S (I^{[x_{113},x_{112} := (c_{15} x_{120} x_{120}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{4} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{15} x_{121} x_{122}))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{122}.x_{-126})} (M_{3} (S (S (L^{\\lambda x_{119}.c_{2} x_{119} (c_{15} x_{121} x_{122})} (I^{[x_{113} := x_{120}]} A^{= (\\Phi_{(b,)} c_{15}) (\\Phi_{K} c_{8})})) (I^{[x_{112} := (c_{15} x_{121} x_{122})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})	WI DM
526	644	t	I^{[x_{113},x_{112} := x_{114},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{4} x_{114} x_{122}} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})}) (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (S (L^{\\lambda x_{122}.c_{4} x_{122} (c_{7} x_{112})} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))) (S (I^{[x_{113} := (c_{2} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))	SS
524	650	t	L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{114},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{7} x_{113}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))	SS
239	444	t	S (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})} (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{114},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) (c_{5} (c_{4} x_{113} x_{112}) x_{122})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) (c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{112}) x_{112}))} (I^{[x_{114},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) (c_{1} (c_{4} x_{113} x_{122}) (c_{1} (c_{4} x_{113} x_{112}) x_{112}))} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{114},x_{113} := (c_{4} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) (c_{1} x_{122} x_{112})} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} (I^{[x_{114},x_{112},x_{113} := x_{113},x_{114},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{4} x_{112} x_{114})) x_{112}} (I^{[x_{112} := x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{113}),(c_{4} x_{112} x_{114})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) x_{122}} (I^{[x_{113} := (c_{4} x_{112} x_{114})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} (c_{4} x_{122} x_{112}) (c_{1} (c_{4} x_{112} x_{114}) x_{112}))} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} x_{122} (c_{1} (c_{4} x_{112} x_{114}) x_{112}))} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} (c_{4} x_{114} x_{122}) (c_{1} (c_{4} x_{112} x_{114}) x_{112}))} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} (c_{4} x_{114} x_{112}) (c_{1} x_{122} x_{112}))} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) x_{122}} (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{112}),(c_{4} x_{114} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} x_{122} x_{112})} (I^{[x_{113} := (c_{4} x_{114} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) x_{122}} (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})))	SS
528	472	t	L^{\\lambda x_{-126}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.x_{-126})} (I^{[x_{113},x_{112} := (c_{15} x_{120} x_{120}),(c_{15} x_{121} x_{122})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{-126}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.x_{-126})} (I^{[x_{112},x_{113} := (c_{7} (c_{15} x_{121} x_{122})),(c_{15} x_{120} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{82},x_{81},x_{80} := (\\lambda x_{122}.c_{8}),(\\lambda x_{122}.c_{7} (c_{15} x_{121} x_{122})),(c_{15} x_{120} x_{120})]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) (I^{[x_{112},x_{113} := (c_{15} x_{120} x_{120}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{7} (c_{15} x_{121} x_{122})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (L^{\\lambda x_{-126}.c_{4} (c_{15} x_{120} x_{120}) x_{-126}} (I^{[x_{112} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{7} (c_{15} x_{121} x_{122})))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))) (S (L^{\\lambda x_{-126}.c_{4} (c_{15} x_{120} x_{120}) (c_{7} x_{-126})} (I^{[x_{82},x_{80} := (\\lambda x_{122}.c_{8}),(\\lambda x_{122}.c_{15} x_{121} x_{122})]} A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})}))) (S (I^{[x_{113},x_{112} := (c_{15} x_{120} x_{120}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{4} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{15} x_{121} x_{122}))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{122}.x_{-126})} (M_{3} (S (S (L^{\\lambda x_{119}.c_{2} x_{119} (c_{15} x_{121} x_{122})} (I^{[x_{113} := x_{120}]} A^{= (\\Phi_{(b,)} c_{15}) (\\Phi_{K} c_{8})})) (I^{[x_{112} := (c_{15} x_{121} x_{122})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})	WI DM
589	736	t	A^{= (\\Phi_{ccbb} c_{57} (c_{55} c_{43} c_{51}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{55} x_{98} (c_{57} x_{97} x_{122})} A^{= (c_{54} c_{43} c_{42}) (c_{55} c_{43} c_{51})})	SS
250	455	t	S (I^{[x_{113} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{1} c_{5})}) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{5} x_{113} x_{112}) x_{112}) x_{122}} (I^{[x_{114},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{5}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{5} x_{113} x_{112}) x_{112}) (c_{5} (c_{5} x_{113} x_{112}) x_{122})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})}) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{5} x_{113} x_{112}) x_{112}) x_{122}} (I^{[x_{114},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{5} x_{113} x_{112}) x_{112}) (c_{5} x_{113} x_{122})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{113} x_{112})} (I^{[x_{113} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (I^{[x_{114},x_{113},x_{112} := x_{112},(c_{5} x_{113} x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} (I^{[x_{113} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})	SS
243	448	t	M_{4} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{113} x_{112})} (I^{[x_{114} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} x_{113} x_{112}) x_{113}),x_{112},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (M_{1}^{1} (A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})))	EO DM
244	449	t	M_{4} (S (S (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} x_{113} x_{112}) x_{113}),x_{112},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (M_{1}^{1} (A^{= (\\Phi_{(cb,b)} c_{1} \\Phi_{cbb} c_{4}) (\\Phi_{bb} (\\Phi_{(b,b)} c_{1}) c_{5})})))	EO DM
245	450	t	M_{4} (S (I^{[x_{114},x_{113},x_{112} := (c_{4} x_{113} x_{112}),(c_{1} x_{113} x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (M_{1}^{1} (A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})))	EO DM
246	451	t	M_{4} (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{114},x_{113},x_{112} := x_{113},x_{112},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (M_{1}^{1} (A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{1} c_{5})})))	EO DM
251	456	t	I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})} (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} x_{112}) x_{122}} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}) (I^{[x_{112},x_{113} := c_{9},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{5} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})	SS
321	488	t	I^{[x_{113} := c_{9}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})	SS
252	457	t	I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})} (L^{\\lambda x_{122}.c_{5} (c_{4} x_{113} x_{112}) x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112},x_{113} := c_{8},(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}) (I^{[x_{112} := (c_{4} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})	SS
531	653	t	S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{97}.x_{-126})} (M_{3} (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{98}.x_{-126})} (M_{3} (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{65}.x_{-126})} (M_{3} (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{66}.x_{-126})} (M_{3} (S (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{115},x_{82},x_{81},x_{80} := (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}),(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{1} (c_{4} (c_{15} x_{98} x_{120}) (c_{15} x_{97} x_{120})) (c_{16} x_{66} x_{120})),(\\lambda x_{120}.c_{1} (c_{4} (c_{15} x_{98} x_{120}) (c_{15} x_{97} x_{120})) (c_{16} x_{65} x_{120}))]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{1} (c_{4} (c_{15} x_{98} x_{120}) (c_{15} x_{97} x_{120})) (c_{16} x_{66} x_{120})) x_{122}))} (I^{[x_{112},x_{113} := (c_{16} x_{65} x_{120}),(c_{4} (c_{15} x_{98} x_{120}) (c_{15} x_{97} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122}))} (I^{[x_{113},x_{114},x_{112} := (c_{16} x_{65} x_{120}),(c_{16} x_{66} x_{120}),(c_{4} (c_{15} x_{98} x_{120}) (c_{15} x_{97} x_{120}))]} A^{= (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{1} c_{1}) (\\Phi_{ccbb} (\\Phi_{(bcb,b)} c_{5}) c_{1} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{1} (c_{16} x_{65} x_{120}) (c_{4} (c_{15} x_{98} x_{120}) (c_{15} x_{97} x_{120})))))} (I^{[x_{112},x_{113} := (c_{16} x_{66} x_{120}),(c_{16} x_{65} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{115},x_{82},x_{81},x_{80} := (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}),(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120})),(\\lambda x_{120}.c_{1} (c_{16} x_{65} x_{120}) (c_{4} (c_{15} x_{98} x_{120}) (c_{15} x_{97} x_{120})))]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})}))) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{5} x_{122} (c_{62} (\\lambda x_{66}.\\lambda x_{65}.c_{5} x_{66} x_{65}) (\\lambda x_{99}.c_{8}) (\\lambda x_{99}.c_{1} (c_{16} x_{65} x_{99}) (c_{4} (c_{15} x_{98} x_{99}) (c_{15} x_{97} x_{99})))))} A^{= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{1}) c_{16})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{112},x_{113} := (c_{62} (\\lambda x_{66}.\\lambda x_{65}.c_{5} x_{66} x_{65}) (\\lambda x_{99}.c_{8}) (\\lambda x_{99}.c_{1} (c_{16} x_{65} x_{99}) (c_{4} (c_{15} x_{98} x_{99}) (c_{15} x_{97} x_{99})))),(c_{15} x_{66} x_{65})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (I^{[x_{112},x_{113} := (c_{15} x_{66} x_{65}),(c_{62} (\\lambda x_{66}.\\lambda x_{65}.c_{5} x_{66} x_{65}) (\\lambda x_{99}.c_{8}) (\\lambda x_{99}.c_{1} (c_{16} x_{65} x_{99}) (c_{4} (c_{15} x_{98} x_{99}) (c_{15} x_{97} x_{99}))))]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})}))) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}}	GE (GE (GE (GE DM)))
530	649	t	S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{65}.x_{-126})} (M_{3} (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{66}.x_{-126})} (M_{3} (S (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{115},x_{82},x_{81},x_{80} := (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}),(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{17} x_{66} x_{120}),(\\lambda x_{120}.c_{17} x_{65} x_{120})]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{17} x_{66} x_{120}) x_{122}))} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{7} (c_{16} x_{65} x_{120}))))} (I^{[x_{65} := x_{66}]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{7} (c_{16} x_{66} x_{120})) x_{122}))} (I^{[x_{112} := (c_{16} x_{65} x_{120})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{1} c_{9} (c_{16} x_{65} x_{120}))))} (I^{[x_{112} := (c_{16} x_{66} x_{120})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{1} c_{9} (c_{16} x_{66} x_{120})) x_{122}))} (I^{[x_{112},x_{113} := (c_{16} x_{65} x_{120}),c_{9}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122}))} (I^{[x_{113},x_{114},x_{112} := (c_{16} x_{65} x_{120}),(c_{16} x_{66} x_{120}),c_{9}]} A^{= (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{1} c_{1}) (\\Phi_{ccbb} (\\Phi_{(bcb,b)} c_{5}) c_{1} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{1} (c_{16} x_{65} x_{120}) c_{9})))} (I^{[x_{112},x_{113} := (c_{16} x_{66} x_{120}),(c_{16} x_{65} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{115},x_{82},x_{81},x_{80} := (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}),(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120})),(\\lambda x_{120}.c_{1} (c_{16} x_{65} x_{120}) c_{9})]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})}))) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{5} x_{122} (c_{62} (\\lambda x_{66}.\\lambda x_{65}.c_{5} x_{66} x_{65}) (\\lambda x_{121}.c_{8}) (\\lambda x_{121}.c_{1} (c_{16} x_{65} x_{121}) c_{9})))} A^{= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{1}) c_{16})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{112},x_{113} := (c_{62} (\\lambda x_{66}.\\lambda x_{65}.c_{5} x_{66} x_{65}) (\\lambda x_{121}.c_{8}) (\\lambda x_{121}.c_{1} (c_{16} x_{65} x_{121}) c_{9})),(c_{15} x_{66} x_{65})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (I^{[x_{112},x_{113} := (c_{15} x_{66} x_{65}),(c_{62} (\\lambda x_{66}.\\lambda x_{65}.c_{5} x_{66} x_{65}) (\\lambda x_{121}.c_{8}) (\\lambda x_{121}.c_{1} (c_{16} x_{65} x_{121}) c_{9}))]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})}))) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}}	GE (GE DM)
539	662	t	I^{[x_{113},x_{112} := x_{112},c_{9}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{4} x_{112} x_{122}} A^{= c_{8} (c_{7} c_{9})}) (I^{[x_{112},x_{113} := c_{8},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))}	SS
598	748	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))))} (I^{[x_{112},x_{113} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))),(c_{15} x_{66} x_{65})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := (c_{15} x_{66} x_{65}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (I^{[x_{112} := (c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))))} (S (M_{3} (S (I^{[x_{112},x_{113} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))),(c_{15} x_{66} x_{65})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (I^{[x_{69},x_{102},x_{101} := (\\lambda x_{122}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{122} x_{120}))),x_{66},x_{65}]} A^{= (\\Phi_{cb} c_{15} (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2})) (\\Phi_{cbb} c_{15} \\Phi_{bb} (\\Phi_{(bb,b)} c_{2}))}) (L^{\\lambda x_{122}.c_{2} (c_{62} (\\lambda x_{65}.\\lambda x_{66}.c_{5} x_{65} x_{66}) (\\lambda x_{65}.c_{8}) (\\lambda x_{65}.x_{122})) (c_{15} x_{66} x_{65})} (I^{[x_{112},x_{113} := (c_{16} x_{66} x_{65}),(c_{16} x_{66} x_{65})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{2} (c_{62} (\\lambda x_{65}.\\lambda x_{66}.c_{5} x_{65} x_{66}) (\\lambda x_{65}.c_{8}) (\\lambda x_{65}.x_{122})) (c_{15} x_{66} x_{65})} (I^{[x_{113} := (c_{16} x_{66} x_{65})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{2} x_{122} (c_{15} x_{66} x_{65})} (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) (I^{[x_{112} := (c_{15} x_{66} x_{65})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) A^{= T c_{8}})))) (S (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(cbb,bb)} c_{16} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{(bb,bbb)} c_{2}) c_{15} (\\Phi_{(bb,b)} c_{1}) c_{16})})) A^{= T c_{8}})))	EO (MI (AI DM DM))
587	732	t	L^{\\lambda x_{122}.c_{55} (c_{54} c_{44} c_{45}) x_{122}} (I^{[x_{98},x_{97} := c_{43},(c_{54} c_{45} c_{46})]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{55} x_{122} (c_{55} c_{43} (c_{57} (c_{54} c_{45} c_{46}) (c_{54} c_{43} c_{42})))} (I^{[x_{98},x_{97} := c_{45},c_{44}]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})})) (I^{[x_{99},x_{98},x_{97} := (c_{55} c_{45} (c_{57} c_{44} (c_{54} c_{43} c_{42}))),c_{43},(c_{57} (c_{54} c_{45} c_{46}) (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}) (L^{\\lambda x_{122}.c_{55} x_{122} (c_{57} (c_{54} c_{45} c_{46}) (c_{54} c_{43} c_{42}))} (I^{[x_{97},x_{98} := c_{43},(c_{55} c_{45} (c_{57} c_{44} (c_{54} c_{43} c_{42})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{55}) (\\Phi_{cb} c_{55} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{55} x_{122} (c_{57} (c_{54} c_{45} c_{46}) (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{98},x_{97} := c_{43},c_{45},(c_{57} c_{44} (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (S (L^{\\lambda x_{122}.c_{55} (c_{55} x_{122} (c_{57} c_{44} (c_{54} c_{43} c_{42}))) (c_{57} (c_{54} c_{45} c_{46}) (c_{54} c_{43} c_{42}))} A^{= (c_{55} c_{43} c_{45}) c_{46}})) (S (I^{[x_{99},x_{98},x_{97} := c_{46},(c_{57} c_{44} (c_{54} c_{43} c_{42})),(c_{57} (c_{54} c_{45} c_{46}) (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (S (L^{\\lambda x_{122}.c_{55} c_{46} x_{122}} (I^{[x_{99},x_{97},x_{98} := c_{44},(c_{54} c_{43} c_{42}),(c_{54} c_{45} c_{46})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})}))) (L^{\\lambda x_{122}.c_{55} c_{46} (c_{57} (c_{55} c_{44} x_{122}) (c_{54} c_{43} c_{42}))} (I^{[x_{98},x_{97} := c_{46},c_{45}]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{55} c_{46} (c_{57} x_{122} (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{98},x_{97} := c_{44},c_{46},(c_{57} c_{45} (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (L^{\\lambda x_{122}.c_{55} c_{46} (c_{57} (c_{55} (c_{55} x_{122} c_{46}) (c_{57} c_{45} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} A^{= (c_{55} c_{43} c_{43}) c_{44}}) (S (L^{\\lambda x_{122}.c_{55} c_{46} (c_{57} (c_{55} x_{122} (c_{57} c_{45} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{98},x_{97} := c_{43},c_{43},c_{46}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}))) (S (L^{\\lambda x_{122}.c_{55} c_{46} (c_{57} (c_{55} (c_{55} c_{43} x_{122}) (c_{57} c_{45} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} A^{= (c_{55} c_{43} c_{46}) c_{47}})) (S (L^{\\lambda x_{122}.c_{55} c_{46} (c_{57} (c_{55} x_{122} (c_{57} c_{45} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} A^{= (c_{55} c_{43} c_{47}) c_{48}})) (S (L^{\\lambda x_{122}.c_{55} c_{46} (c_{57} x_{122} (c_{54} c_{43} c_{42}))} (I^{[x_{98},x_{97} := c_{48},c_{45}]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}))) (S (I^{[x_{98},x_{97} := c_{46},(c_{54} c_{45} c_{48})]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}))	SS
367	523	f	S (I^{[x_{112} := (c_{2} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))} (S (M_{3} (S (S (L^{\\lambda x_{122}.c_{3} (c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112})) x_{122}} A^{= (c_{7} c_{8}) c_{9}}) (I^{[x_{112},x_{113} := c_{9},(c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{112} := (c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))]} A^{= (\\Phi_{b} c_{7}) (\\Phi_{b} (c_{2} c_{9}))}) (I^{[x_{112} := (c_{4} (c_{2} x_{113} x_{112}) x_{112})]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (S (I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} x_{113} x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}})))) (S (I^{[x_{112},x_{113} := (c_{4} (c_{2} x_{113} x_{112}) x_{112}),c_{8}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (S (L^{\\lambda x_{122}.c_{2} (c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112})) x_{122}} A^{= (c_{7} c_{8}) c_{9}}) (I^{[x_{113},x_{112} := (c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112})),c_{9}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{4} (c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112})) x_{122}} A^{= c_{8} (c_{7} c_{9})}) (I^{[x_{112},x_{113} := c_{8},(c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}}))	EO (MI (AI (CR DM) (CR DM)))
591	741	t	S (I^{[x_{97} := (c_{57} c_{42} x_{97})]} A^{= \\Phi_{} (\\Phi_{b} (c_{55} c_{42}))}) (S (L^{\\lambda x_{122}.c_{55} x_{122} (c_{57} c_{42} x_{97})} (I^{[x_{97} := (c_{57} c_{42} x_{97})]} A^{= (\\Phi_{K} c_{42}) (\\Phi_{(bb,)} c_{55} c_{60})}))) (S (I^{[x_{99},x_{98},x_{97} := (c_{60} (c_{57} c_{42} x_{97})),(c_{57} c_{42} x_{97}),(c_{57} c_{42} x_{97})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (S (L^{\\lambda x_{122}.c_{55} (c_{60} (c_{57} c_{42} x_{97})) x_{122}} (I^{[x_{99},x_{98} := c_{42},c_{42}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})}))) (L^{\\lambda x_{122}.c_{55} (c_{60} (c_{57} c_{42} x_{97})) (c_{57} x_{122} x_{97})} (I^{[x_{97} := c_{42}]} A^{= \\Phi_{} (\\Phi_{cb} c_{42} c_{55})})) (I^{[x_{97} := (c_{57} c_{42} x_{97})]} A^{= (\\Phi_{K} c_{42}) (\\Phi_{(bb,)} c_{55} c_{60})})	SS
592	742	t	I^{[x_{97},x_{98} := c_{42},x_{97}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{57}) (\\Phi_{cb} c_{57} \\Phi_{cb})} A^{= (\\Phi_{K} c_{42}) (\\Phi_{b} (c_{57} c_{42}))}	SS
590	738	t	L^{\\lambda x_{122}.c_{55} (c_{54} c_{44} c_{42}) x_{122}} (I^{[x_{98},x_{97} := c_{51},(c_{54} c_{51} c_{51})]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{55} x_{122} (c_{55} c_{51} (c_{57} (c_{54} c_{51} c_{51}) (c_{54} c_{43} c_{42})))} (I^{[x_{98},x_{97} := c_{42},c_{44}]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})})) (I^{[x_{99},x_{98},x_{97} := (c_{55} c_{42} (c_{57} c_{44} (c_{54} c_{43} c_{42}))),c_{51},(c_{57} (c_{54} c_{51} c_{51}) (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}) (L^{\\lambda x_{122}.c_{55} x_{122} (c_{57} (c_{54} c_{51} c_{51}) (c_{54} c_{43} c_{42}))} (I^{[x_{97},x_{98} := c_{51},(c_{55} c_{42} (c_{57} c_{44} (c_{54} c_{43} c_{42})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{55}) (\\Phi_{cb} c_{55} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{55} x_{122} (c_{57} (c_{54} c_{51} c_{51}) (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{98},x_{97} := c_{51},c_{42},(c_{57} c_{44} (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (L^{\\lambda x_{122}.c_{55} (c_{55} x_{122} (c_{57} c_{44} (c_{54} c_{43} c_{42}))) (c_{57} (c_{54} c_{51} c_{51}) (c_{54} c_{43} c_{42}))} (I^{[x_{97} := c_{51}]} A^{= \\Phi_{} (\\Phi_{cb} c_{42} c_{55})})) (S (I^{[x_{99},x_{98},x_{97} := c_{51},(c_{57} c_{44} (c_{54} c_{43} c_{42})),(c_{57} (c_{54} c_{51} c_{51}) (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (S (L^{\\lambda x_{122}.c_{55} c_{51} x_{122}} (I^{[x_{99},x_{97},x_{98} := c_{44},(c_{54} c_{43} c_{42}),(c_{54} c_{51} c_{51})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})}))) (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} (c_{55} c_{44} x_{122}) (c_{54} c_{43} c_{42}))} (I^{[x_{98},x_{97} := c_{51},c_{51}]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} x_{122} (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{98},x_{97} := c_{44},c_{51},(c_{57} c_{51} (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} (c_{55} (c_{55} x_{122} c_{51}) (c_{57} c_{51} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} A^{= (c_{55} c_{43} c_{43}) c_{44}}) (S (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} (c_{55} x_{122} (c_{57} c_{51} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{98},x_{97} := c_{43},c_{43},c_{51}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}))) (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} (c_{55} (c_{55} c_{43} x_{122}) (c_{57} c_{51} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} A^{= (c_{54} c_{43} c_{42}) (c_{55} c_{43} c_{51})}) (S (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} x_{122} (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{98},x_{97} := c_{43},(c_{54} c_{43} c_{42}),(c_{57} c_{51} (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}))) (S (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} (c_{55} c_{43} (c_{55} x_{122} (c_{57} c_{51} (c_{54} c_{43} c_{42})))) (c_{54} c_{43} c_{42}))} (I^{[x_{97} := (c_{54} c_{43} c_{42})]} A^{= \\Phi_{} (\\Phi_{b} (c_{57} c_{43}))}))) (S (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} (c_{55} c_{43} x_{122}) (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{97},x_{98} := c_{43},(c_{54} c_{43} c_{42}),c_{51}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})}))) (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} (c_{55} c_{43} (c_{57} x_{122} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} A^{= (c_{54} c_{43} c_{42}) (c_{55} c_{43} c_{51})}) (S (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} x_{122} (c_{54} c_{43} c_{42}))} (I^{[x_{98},x_{97} := c_{43},(c_{54} c_{43} c_{42})]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}))) (S (I^{[x_{98},x_{97} := c_{51},(c_{54} (c_{54} c_{43} c_{42}) c_{43})]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}))	SS
566	689	t	S (S (L^{\\lambda x_{122}.c_{2} x_{122} (c_{1} x_{102} x_{101})} (I^{[x_{112} := (c_{2} (x_{69} x_{101}) (x_{69} x_{102}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (L^{\\lambda x_{122}.c_{2} x_{122} (c_{1} x_{102} x_{101})} (I^{[x_{112},x_{113} := (c_{2} (x_{69} x_{101}) (x_{69} x_{102})),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{2} (c_{5} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) x_{122}) (c_{1} x_{102} x_{101})} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})})))) (S (L^{\\lambda x_{122}.c_{2} (c_{5} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{2} x_{122} (c_{1} x_{102} x_{101}))) (c_{1} x_{102} x_{101})} (I^{[x_{113},x_{112} := (x_{69} x_{102}),(x_{69} x_{101})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}))) (L^{\\lambda x_{122}.c_{2} (c_{5} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) x_{122}) (c_{1} x_{102} x_{101})} (I^{[x_{113},x_{112} := (c_{5} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{2} (x_{69} x_{102}) (x_{69} x_{101}))),(c_{1} x_{102} x_{101})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{2} (c_{5} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) x_{122}) (c_{1} x_{102} x_{101})} (I^{[x_{114},x_{112},x_{113} := (c_{2} (x_{69} x_{101}) (x_{69} x_{102})),(c_{7} (c_{1} x_{102} x_{101})),(c_{2} (x_{69} x_{102}) (x_{69} x_{101}))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (I^{[x_{113},x_{112} := (c_{5} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101}))))),(c_{1} x_{102} x_{101})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (I^{[x_{114},x_{112},x_{113} := (c_{2} (x_{69} x_{101}) (x_{69} x_{102})),(c_{7} (c_{1} x_{102} x_{101})),(c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101}))))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) x_{122}} (I^{[x_{114},x_{112},x_{113} := (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))),(c_{7} (c_{1} x_{102} x_{101})),(c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101})))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{5} (c_{4} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{7} (c_{1} x_{102} x_{101}))) x_{122})} (I^{[x_{114},x_{113},x_{112} := (c_{2} (x_{69} x_{102}) (x_{69} x_{101})),(c_{7} (c_{1} x_{102} x_{101})),(c_{7} (c_{1} x_{102} x_{101}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{5} (c_{4} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{7} (c_{1} x_{102} x_{101}))) (c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) x_{122}))} (I^{[x_{112} := (c_{7} (c_{1} x_{102} x_{101}))]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{5} x_{122} (c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101}))))} (I^{[x_{114},x_{113},x_{112} := (c_{2} (x_{69} x_{101}) (x_{69} x_{102})),(c_{7} (c_{1} x_{102} x_{101})),(c_{7} (c_{1} x_{102} x_{101}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) x_{122}) (c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101}))))} (I^{[x_{112} := (c_{7} (c_{1} x_{102} x_{101}))]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})) (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))),(c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))),(c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101})))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101})))} (I^{[x_{112} := (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101})))]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})})) (S (I^{[x_{114},x_{112},x_{113} := (c_{2} (x_{69} x_{101}) (x_{69} x_{102})),(c_{7} (c_{1} x_{102} x_{101})),(c_{2} (x_{69} x_{102}) (x_{69} x_{101}))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{7} (c_{1} x_{102} x_{101}))} (I^{[x_{113},x_{112} := (x_{69} x_{102}),(x_{69} x_{101})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})})) (S (I^{[x_{113},x_{112} := (c_{1} (x_{69} x_{102}) (x_{69} x_{101})),(c_{1} x_{102} x_{101})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))) A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})}	DM
407	533	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))} (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := x_{112},(c_{5} (c_{2} x_{112} x_{113}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (I^{[x_{112} := (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))} (S (M_{3} (S (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (I^{[x_{112},x_{113} := x_{112},(c_{5} (c_{2} x_{112} x_{113}) x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}))) (S (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{2} (c_{7} x_{112}) (c_{7} (c_{5} x_{122} x_{112}))} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{2} (c_{7} x_{112}) (c_{7} (c_{5} x_{122} x_{112}))} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{7} x_{112}) (c_{7} x_{122})} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{4} c_{5} \\Phi_{cbcb})})) (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})})) A^{= T c_{8}}))))) (S (L^{\\lambda x_{122}.c_{2} x_{112} (c_{5} x_{122} x_{112})} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (I^{[x_{113} := (c_{4} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})}))))	EO (MI (AI DM (CR DM)))
593	743	t	S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{85}.x_{-126})} (M_{3} (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{65}.x_{-126})} (M_{3} (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{66}.x_{-126})} (M_{3} (S (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{115},x_{82},x_{81},x_{80} := (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}),(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{1} (c_{5} (x_{80} x_{120} x_{85}) (c_{16} x_{85} x_{120})) (c_{16} x_{66} x_{120})),(\\lambda x_{120}.c_{1} (c_{5} (x_{80} x_{120} x_{85}) (c_{16} x_{85} x_{120})) (c_{16} x_{65} x_{120}))]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{1} (c_{5} (x_{80} x_{120} x_{85}) (c_{16} x_{85} x_{120})) (c_{16} x_{66} x_{120})) x_{122}))} (I^{[x_{112},x_{113} := (c_{16} x_{65} x_{120}),(c_{5} (x_{80} x_{120} x_{85}) (c_{16} x_{85} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122}))} (I^{[x_{113},x_{114},x_{112} := (c_{16} x_{65} x_{120}),(c_{16} x_{66} x_{120}),(c_{5} (x_{80} x_{120} x_{85}) (c_{16} x_{85} x_{120}))]} A^{= (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{1} c_{1}) (\\Phi_{ccbb} (\\Phi_{(bcb,b)} c_{5}) c_{1} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{1} (c_{16} x_{65} x_{120}) (c_{5} (x_{80} x_{120} x_{85}) (c_{16} x_{85} x_{120})))))} (I^{[x_{112},x_{113} := (c_{16} x_{66} x_{120}),(c_{16} x_{65} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{115},x_{82},x_{81},x_{80} := (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}),(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120})),(\\lambda x_{120}.c_{1} (c_{16} x_{65} x_{120}) (c_{5} (x_{80} x_{120} x_{85}) (c_{16} x_{85} x_{120})))]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})}))) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{5} x_{122} (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{86}.c_{8}) (\\lambda x_{86}.c_{1} (c_{16} x_{65} x_{86}) (c_{5} (x_{80} x_{86} x_{85}) (c_{16} x_{85} x_{86})))))} A^{= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{1}) c_{16})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{112},x_{113} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{86}.c_{8}) (\\lambda x_{86}.c_{1} (c_{16} x_{65} x_{86}) (c_{5} (x_{80} x_{86} x_{85}) (c_{16} x_{85} x_{86})))),(c_{15} x_{66} x_{65})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (I^{[x_{112},x_{113} := (c_{15} x_{66} x_{65}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{86}.c_{8}) (\\lambda x_{86}.c_{1} (c_{16} x_{65} x_{86}) (c_{5} (x_{80} x_{86} x_{85}) (c_{16} x_{85} x_{86}))))]} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})})))) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}}	GE (GE (GE DM))
391	472	t	L^{\\lambda x_{126}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.x_{126})} (I^{[x_{113},x_{112} := (c_{15} x_{120} x_{120}),(c_{15} x_{121} x_{122})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{126}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.x_{126})} (I^{[x_{112},x_{113} := (c_{7} (c_{15} x_{121} x_{122})),(c_{15} x_{120} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{82},x_{81},x_{80} := (\\lambda x_{122}.c_{8}),(\\lambda x_{122}.c_{7} (c_{15} x_{121} x_{122})),(c_{15} x_{120} x_{120})]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) (I^{[x_{112},x_{113} := (c_{15} x_{120} x_{120}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{7} (c_{15} x_{121} x_{122})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (L^{\\lambda x_{126}.c_{4} (c_{15} x_{120} x_{120}) x_{126}} (I^{[x_{112} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{7} (c_{15} x_{121} x_{122})))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))) (S (L^{\\lambda x_{126}.c_{4} (c_{15} x_{120} x_{120}) (c_{7} x_{126})} (I^{[x_{82},x_{80} := (\\lambda x_{122}.c_{8}),(\\lambda x_{122}.c_{15} x_{121} x_{122})]} A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})}))) (S (I^{[x_{113},x_{112} := (c_{15} x_{120} x_{120}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{4} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{15} x_{121} x_{122}))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{122}.x_{126})} (M_{3} (S (S (L^{\\lambda x_{119}.c_{2} x_{119} (c_{15} x_{121} x_{122})} (I^{[x_{113} := x_{120}]} A^{= (\\Phi_{(b,)} c_{15}) (\\Phi_{K} c_{8})})) (I^{[x_{112} := (c_{15} x_{121} x_{122})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})	WI DM
371	526	t	I^{[x_{113},x_{112} := x_{112},c_{8}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (S (L^{\\lambda x_{122}.c_{4} x_{112} x_{122}} A^{= (c_{7} c_{8}) c_{9}})) (I^{[x_{112},x_{113} := c_{9},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))}	SS
594	744	t	M_{4} (I^{[x_{69},x_{101},x_{102} := (\\lambda x_{-126}.c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) x_{-126}),(c_{5} (c_{5} (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{17} c_{18} x_{120})) (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{16} c_{18} x_{120}))) (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))),(c_{5} (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120})) (c_{1} c_{9} (c_{16} c_{18} x_{120})))]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))} (M_{1}^{1} (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{17} c_{18} x_{120})) x_{-126}) (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))} (I^{[x_{113},x_{112} := (c_{1} c_{9} (c_{16} c_{18} x_{120})),(c_{16} c_{18} x_{120})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} (c_{16} c_{18} x_{120})),(c_{1} c_{9} (c_{16} c_{18} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{-126}.c_{5} (c_{5} x_{-126} (c_{4} (c_{7} (c_{16} c_{18} x_{120})) (c_{1} c_{9} (c_{16} c_{18} x_{120})))) (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))} (I^{[x_{113},x_{112} := (c_{1} c_{9} (c_{16} c_{18} x_{120})),(c_{17} c_{18} x_{120})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} (c_{17} c_{18} x_{120})),(c_{1} c_{9} (c_{16} c_{18} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (L^{\\lambda x_{-126}.c_{5} x_{-126} (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))} (S (I^{[x_{114},x_{112},x_{113} := (c_{7} (c_{17} c_{18} x_{120})),(c_{1} c_{9} (c_{16} c_{18} x_{120})),(c_{7} (c_{16} c_{18} x_{120}))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}) (S (L^{\\lambda x_{-126}.c_{4} x_{-126} (c_{1} c_{9} (c_{16} c_{18} x_{120}))} (I^{[x_{113},x_{112} := (c_{17} c_{18} x_{120}),(c_{16} c_{18} x_{120})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}))))) (L^{\\lambda x_{-126}.c_{5} x_{-126} (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))} (I^{[x_{112},x_{113} := (c_{1} c_{9} (c_{16} c_{18} x_{120})),(c_{7} (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (I^{[x_{113},x_{112} := (c_{1} c_{9} (c_{16} c_{18} x_{120})),(c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cbb} c_{7} (\\Phi_{(bbb,)} c_{5}) c_{4})}) (I^{[x_{112},x_{113} := (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120})),(c_{1} c_{9} (c_{16} c_{18} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (I^{[x_{112},x_{113} := (c_{1} c_{9} (c_{16} c_{18} x_{120})),(c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})}) (S (I^{[x_{112} := (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))} (S (M_{3} (S (I^{[x_{112} := (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{16} c_{18} x_{120}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{16} c_{18} x_{120}))} (S (M_{3} (S (S (L^{\\lambda x_{122}.c_{2} x_{122} (c_{17} c_{18} x_{120})} (I^{[x_{112} := (c_{16} c_{18} x_{120})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (S (L^{\\lambda x_{122}.c_{2} x_{122} (c_{17} c_{18} x_{120})} (I^{[x_{65} := c_{18}]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})}))) (I^{[x_{112} := (c_{17} c_{18} x_{120})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})})) A^{= T c_{8}})))) (S (I^{[x_{114},x_{112},x_{113} := c_{9},(c_{16} c_{18} x_{120}),(c_{16} c_{18} x_{120})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{1}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{2} \\Phi_{ccb} c_{1})} (L^{\\lambda x_{122}.c_{1} (c_{5} c_{9} (c_{16} c_{18} x_{120})) x_{122}} (I^{[x_{112} := (c_{16} c_{18} x_{120})]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{16} c_{18} x_{120})} (I^{[x_{112} := (c_{16} c_{18} x_{120})]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{5} c_{9}))})) (S (I^{[x_{112} := (c_{16} c_{18} x_{120})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (S (I^{[x_{65} := c_{18}]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})}))) A^{= (\\Phi_{K} T) (\\Phi_{b} (c_{17} c_{18}))}))))) (S (L^{\\lambda x_{122}.c_{4} x_{122} (c_{16} c_{18} x_{120})} (I^{[x_{65} := c_{18}]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})})) (I^{[x_{112} := (c_{16} c_{18} x_{120})]} A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))))	EO (CA (AI DM (AI DM DM))):c_{5} (c_{5} (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{17} c_{18} x_{120})) (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{16} c_{18} x_{120}))) (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))
595	745	t	L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) x_{112}) x_{122}} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{112}) (c_{1} x_{113} x_{112}))} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{1} (c_{7} x_{113}) x_{112})),(c_{4} x_{113} x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{113} x_{112})} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{7} x_{113}) x_{112}),(c_{1} (c_{7} x_{113}) x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) x_{122}) (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),(c_{1} (c_{7} x_{113}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{113} x_{112})} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{7} x_{113}) x_{112}),(c_{4} x_{113} x_{112}),(c_{1} (c_{7} x_{113}) x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112})),(c_{1} (c_{7} x_{113}) x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112})) (c_{1} x_{122} (c_{1} x_{113} x_{112}))} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112})) (c_{1} x_{122} (c_{1} x_{113} x_{112}))} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),(c_{7} (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112})) x_{122}} (I^{[x_{112} := (c_{1} x_{113} x_{112})]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})})) (I^{[x_{112},x_{113} := c_{9},(c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{112} := (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112}))]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{114} := (c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (L^{\\lambda x_{122}.c_{7} (c_{4} x_{122} x_{112})} (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{7} (c_{4} x_{122} x_{112})} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})})) (L^{\\lambda x_{122}.c_{7} x_{122}} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})	SS
596	746	f	c_{5} x_{113} x_{112}	WE
363	523	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))} (I^{[x_{112},x_{113} := (c_{4} (c_{2} x_{113} x_{112}) x_{112}),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := c_{8},(c_{4} (c_{2} x_{113} x_{112}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (L^{\\lambda x_{122}.c_{5} (c_{3} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112})) x_{122}} (I^{[x_{112} := (c_{4} (c_{2} x_{113} x_{112}) x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} c_{8}} (I^{[x_{112},x_{113} := (c_{4} (c_{2} x_{113} x_{112}) x_{112}),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{2} (c_{4} x_{122} x_{112}) c_{8}) c_{8}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (S (L^{\\lambda x_{122}.c_{5} (c_{2} x_{122} c_{8}) c_{8}} (I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{5} (c_{2} (c_{4} x_{113} x_{122}) c_{8}) c_{8}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (L^{\\lambda x_{122}.c_{5} (c_{2} x_{122} c_{8}) c_{8}} (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{2} x_{122} c_{8}) c_{8}} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) (L^{\\lambda x_{122}.c_{5} x_{122} c_{8}} (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) (I^{[x_{112} := c_{8}]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) A^{= T c_{8}}))	EO (MI DM)
364	523	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))} (I^{[x_{112},x_{113} := (c_{4} (c_{2} x_{113} x_{112}) x_{112}),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := c_{8},(c_{4} (c_{2} x_{113} x_{112}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (I^{[x_{112} := (c_{2} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))} (S (M_{3} (S (L^{\\lambda x_{122}.c_{3} c_{8} (c_{4} x_{122} x_{112})} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (S (L^{\\lambda x_{122}.c_{3} c_{8} x_{122}} (I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{3} c_{8} (c_{4} x_{113} x_{122})} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (L^{\\lambda x_{122}.c_{3} c_{8} x_{122}} (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{3} c_{8} x_{122}} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) (I^{[x_{112},x_{113} := c_{8},c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) A^{= T c_{8}})))) (S (I^{[x_{112} := (c_{4} (c_{2} x_{113} x_{112}) x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))}) A^{= T c_{8}})))	EO (MI (AI DM DM))
516	643	f	L^{\\lambda x_{122}.c_{5} (c_{5} (c_{2} x_{80} x_{68}) x_{122}) (c_{4} x_{68} x_{67})} (I^{[x_{113},x_{112} := x_{80},x_{67}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{4} x_{80} (c_{7} x_{67}))) (c_{4} x_{68} x_{67})} (I^{[x_{113},x_{112} := x_{80},x_{68}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{5} (c_{5} (c_{4} x_{80} (c_{7} x_{68})) x_{122}) (c_{4} x_{68} x_{67})} (I^{[x_{112},x_{113} := (c_{7} x_{67}),x_{80}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{4} (c_{7} x_{67}) x_{80})) (c_{4} x_{68} x_{67})} (I^{[x_{112},x_{113} := (c_{7} x_{68}),x_{80}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} x_{68} x_{67})} (I^{[x_{114},x_{112},x_{113} := (c_{7} x_{68}),x_{80},(c_{7} x_{67})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}))) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} x_{68} x_{67})} (I^{[x_{112},x_{113} := x_{80},(c_{5} (c_{7} x_{68}) (c_{7} x_{67}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} x_{80} x_{122}) (c_{4} x_{68} x_{67})} (I^{[x_{113},x_{112} := x_{68},x_{67}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})})))	SS
517	644	t	I^{[x_{113},x_{112} := x_{114},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{4} x_{114} x_{122}} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})}) (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (S (L^{\\lambda x_{122}.c_{4} x_{122} (c_{7} x_{112})} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))) (S (I^{[x_{113} := (c_{2} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))	SS
\.


--
-- Name: solucion_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.solucion_id_seq', 599, true);


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
113	= (\\Phi_{K} T) (\\Phi_{(b(bbb,cccbbb),b)} c_{2} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} c_{16} c_{16} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbbb} \\Phi_{b} c_{17} (c_{59} c_{18}))	f		103	16,17,59,18
123	= (\\Phi_{ccbbbb} (\\Phi_{(bb,(bb,b))} c_{1}) c_{5} \\Phi_{(b,cb)} \\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{cbbcb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}))))	f		110	
147	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{ccccc(bcbbb,cbbb)} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{bcb} \\Phi_{c(bbbb,bb)} \\Phi_{b} \\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} \\Phi_{cb} (\\Phi_{(bbcb,bb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		128	
156	= (\\Phi_{(bccbbbb,bb)} c_{19} \\Phi_{cb} c_{16} \\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} c_{16} \\Phi_{K} c_{22}) (\\Phi_{b} c_{23})	f		148	19,16,22,23
210	= (\\Phi_{bb} (\\Phi_{cbbbb} c_{15} \\Phi_{bb} \\Phi_{bb} c_{5}) c_{15}) (\\Phi_{ccccbb} c_{31} \\Phi_{cbbb} \\Phi_{bb} c_{15} \\Phi_{cccbb} c_{31})	f		170	31
186	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{16} \\Phi_{bcb} c_{5}) c_{17}) (\\Phi_{ccbb} \\Phi_{cbb} c_{16} \\Phi_{ccb} c_{30})	f		192	16,17,30
126	= (\\Phi_{bbbb} \\Phi_{b} c_{4} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bb} c_{7})) (\\Phi_{cbbb} \\Phi_{K} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		196	
167	= (\\Phi_{(ccccccbbb,b)} c_{35} c_{35} \\Phi_{K} c_{16} (\\Phi_{bcccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) c_{5} (\\Phi_{(bcccbb,bbbb)} c_{19} (\\Phi_{bc(ccbbb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{31} c_{15})) (\\Phi_{(bb,bcbcb)} c_{5}) c_{16} c_{24}) (\\Phi_{bb} \\Phi_{b} c_{32})	f		200	35,16,19,31,24,32
82	= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{9} c_{2})	f		3	
83	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{4})	f		4	
84	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})	f		5	
85	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{2}) c_{4} c_{5})	f		6	
141	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(c(bbb,ccbbb),bb)} \\Phi_{b} c_{4} (\\Phi_{cc(cbbbb,)} \\Phi_{cbb} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} c_{1} c_{2} \\Phi_{cb(bb,bccb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		7	
142	= (\\Phi_{K} c_{9}) (\\Phi_{cbb} (\\Phi_{K} c_{9}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		8	
143	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) (\\Phi_{(bbb,bb)} c_{2}) \\Phi_{b} (\\Phi_{cccbbb} \\Phi_{b}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} (\\Phi_{(bb,b)} c_{4}))	f		9	
146	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bbbb,)} \\Phi_{bb} c_{2} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b})	f		10	
194	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c((cbbb,bbbb),)} c_{27} c_{23} (\\Phi_{(bbb,bcb)} c_{2}) c_{27} c_{23} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b} c_{16})	f		11	27,23,16
192	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{24} \\Phi_{bcb} c_{25}) c_{24}) (\\Phi_{ccbb} \\Phi_{cbb} c_{24} \\Phi_{ccb} c_{25})	f		12	24,25
198	= c_{18} (c_{23} (c_{20} c_{18}))	f		13	18,23,20
234	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(bcb,b)} (\\Phi_{(cb,b)} c_{5}) c_{5} (\\Phi_{b(ccccb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(b(b(bb,b),b),(bb,(bb,b)))} c_{1} c_{5} c_{5}))	f		14	
118	= (\\Phi_{bcb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) c_{7} (\\Phi_{(bb,bb)} c_{4})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbb} \\Phi_{b})	f		15	
122	= (\\Phi_{ccbbbb} (\\Phi_{(bb,bb)} c_{4}) c_{7} \\Phi_{bcb} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cccb} \\Phi_{b} \\Phi_{cbcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) (\\Phi_{cccbb} (\\Phi_{(bb,b)} c_{5})))	f		16	
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
112	= (\\Phi_{K} T) (\\Phi_{bcbccbbbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) \\Phi_{cb} c_{16} (\\Phi_{(bbcb,b)} c_{1}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} c_{16})	f		104	16
114	= T (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}) (\\Phi_{(bb(ccbb,b),cb)} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{20} c_{24} (\\Phi_{(bb(bb,),b)} c_{2}) c_{16} c_{16} c_{18} c_{16}))	f		105	20,24,16,18
117	= (\\Phi_{bb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbb} \\Phi_{b})	f		106	
98	= (\\Phi_{cb} c_{15} (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2})) (\\Phi_{cbb} c_{15} \\Phi_{bb} (\\Phi_{(bb,b)} c_{2}))	f		107	
119	= (\\Phi_{(b,cb)} (\\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) c_{5} (\\Phi_{(bb,(bb,b))} c_{1})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		108	
120	= (\\Phi_{b(cb,)} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) c_{4} (\\Phi_{(bb,(bb,b))} c_{1})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbb} \\Phi_{b})	f		109	
124	= (\\Phi_{ccbbbb} (\\Phi_{(bb,(bb,b))} c_{1}) c_{4} \\Phi_{b(cb,)} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cccb} \\Phi_{b} \\Phi_{cbcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) (\\Phi_{cccbb} (\\Phi_{(bb,b)} c_{5})))	f		111	
125	= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		112	
128	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cc(cbbb,bb),bb)} (\\Phi_{(bb,b)} c_{1}) \\Phi_{b} c_{1} (\\Phi_{(bbbb,bb)} c_{2}) \\Phi_{b} \\Phi_{(cccbbbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		113	
129	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cccb,bb)} \\Phi_{b} \\Phi_{b} c_{2} \\Phi_{bcbcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) (\\Phi_{ccc(bbbb,b)} (\\Phi_{(bb,b)} c_{4})) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		114	
108	= T (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}) (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bb} c_{7}) c_{16}))	f		115	16
116	= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		116	
10	= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})	f		117	
74	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{(cb,b)} c_{5} \\Phi_{cbb} c_{2})	f		118	
75	= (\\Phi_{K} (\\Phi_{K} c_{8})) (\\Phi_{bb} (\\Phi_{(bb,)} c_{4}) c_{2})	f		119	
76	= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{(cb,b)} c_{4} \\Phi_{cbb} c_{2})	f		120	
77	= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{2}) c_{5} c_{4})	f		121	
78	= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})	f		122	
79	= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))	f		123	
80	= \\Phi_{} (\\Phi_{cb} c_{8} c_{2})	f		124	
81	= (\\Phi_{b} c_{7}) (\\Phi_{b} (c_{2} c_{9}))	f		125	
144	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(bbb,bbb)} (\\Phi_{(bb,b)} c_{4}) (\\Phi_{ccbb} \\Phi_{b}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} (\\Phi_{(bbb,bb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		126	
145	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cc(cbbb,bb),bb)} (\\Phi_{(bb,b)} c_{2}) \\Phi_{b} c_{2} (\\Phi_{(bbbb,bb)} c_{2}) \\Phi_{b} \\Phi_{(cccbbbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		127	
153	= (\\Phi_{ccbbbb} \\Phi_{cb} c_{16} \\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} c_{16}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{22})	f		129	16,22
148	= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})	f		130	16,17
151	= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{20})	f		131	16,20
152	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{16} \\Phi_{bcb} c_{4}) c_{16}) (\\Phi_{cccbb} \\Phi_{cbbb} c_{16} c_{20} \\Phi_{cccb} c_{21})	f		132	16,20,21
149	= (\\Phi_{K} T) (\\Phi_{b} (c_{17} c_{18}))	f		133	17,18
154	= (\\Phi_{bb} (\\Phi_{bbb} c_{22} c_{20}) c_{21}) (\\Phi_{bb} \\Phi_{b} c_{24})	f		134	22,20,21,24
155	= (\\Phi_{(ccbbb,b)} \\Phi_{K} c_{16} (\\Phi_{(bbb,bb)} c_{19}) (\\Phi_{(bb,b)} c_{5}) c_{16} c_{24}) (\\Phi_{bb} \\Phi_{b} c_{25})	f		135	16,19,24,25
157	= (\\Phi_{ccbbb} \\Phi_{K} c_{16} (\\Phi_{(bbb,b)} c_{19}) (\\Phi_{(bb,b)} c_{5}) c_{17}) (\\Phi_{bb} \\Phi_{b} c_{30})	f		136	16,19,17,30
165	= T (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b} c_{17}))	f		137	17
159	= (\\Phi_{bb} \\Phi_{b} c_{27}) (\\Phi_{cb} c_{29} \\Phi_{cb})	f		138	27,29
160	= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{5}) c_{59} c_{27}) (\\Phi_{bb} \\Phi_{b} c_{26})	f		139	59,27,26
161	= (\\Phi_{bb} \\Phi_{b} c_{26}) (\\Phi_{cb} c_{28} \\Phi_{cb})	f		138	26,28
162	= (\\Phi_{cbb} c_{20} (\\Phi_{b(bbb,b)} c_{20} c_{21} c_{20}) c_{21}) (\\Phi_{bb} \\Phi_{b} c_{31})	f		140	20,21,31
163	= (\\Phi_{bb} \\Phi_{b} c_{27}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{35})	f		141	27,16,35
164	= (\\Phi_{(bb,)} c_{24} c_{20}) (\\Phi_{b} c_{52})	f		142	24,20,52
170	= (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{5}) (\\Phi_{bb} \\Phi_{b} c_{2})	f		143	
150	= (\\Phi_{b} (\\Phi_{c(bb,)} c_{16} (\\Phi_{(bb,cb)} c_{5}))) (\\Phi_{cccb} \\Phi_{cb(bcb,b)} c_{16} c_{19} (\\Phi_{cccccb} \\Phi_{K} \\Phi_{cb}))	f		144	16,19
131	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cc(cbbb,bb),bb)} (\\Phi_{(bb,b)} c_{2}) \\Phi_{b} c_{2} (\\Phi_{(bbbb,bb)} c_{2}) \\Phi_{b} \\Phi_{(cccbbbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		145	
133	= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		146	
169	= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})	f		147	
134	= (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		149	
135	= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		150	
136	= (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		151	
137	= (\\Phi_{bb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{cbb} \\Phi_{b})	f		152	
138	= (\\Phi_{cbbbb} (\\Phi_{(bb,b)} c_{5}) \\Phi_{bb} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b}) (\\Phi_{cccb} \\Phi_{b} \\Phi_{cbcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) (\\Phi_{cccbb} (\\Phi_{(bb,b)} c_{5})))	f		153	
139	= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{5}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{5}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		154	
140	= (\\Phi_{bbbb} \\Phi_{b} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{K} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		155	
132	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(cbbb,)} c_{2} \\Phi_{cbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) \\Phi_{b})	f		156	
193	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(ccbbb,b)} (c_{59} c_{18}) c_{5} \\Phi_{b(bb,b)} c_{2} (c_{59} c_{18}) c_{27})	f		157	59,18,27
195	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(cc(ccbbb,b),)} c_{27} (c_{59} c_{18}) c_{5} c_{5} c_{23} (\\Phi_{(bbb,(bcbb,cb))} c_{2}) c_{27} c_{23} (c_{59} c_{18}))	f		158	27,59,18,23
196	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2} (c_{59} c_{18}) c_{16})	f		159	59,18,16
197	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cccccbb,b)} c_{16} c_{23} (c_{15} c_{18}) c_{2} \\Phi_{b(bbb,b)} c_{5} (c_{15} c_{18}) \\Phi_{(cccbbbbb,b)} c_{25} c_{25})	f		160	16,23,18,25
199	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bb} (\\Phi_{bbb} (c_{59} c_{18}) c_{20}) c_{21})	f		161	59,18,20,21
200	= (\\Phi_{bb} \\Phi_{b} c_{25}) (\\Phi_{bb} (\\Phi_{bbb} c_{23} c_{20}) c_{21})	f		162	25,23,20,21
201	= (\\Phi_{K} T) (\\Phi_{bb} (c_{59} c_{18}) c_{20})	f		163	59,18,20
202	= \\Phi_{} (\\Phi_{bb} c_{23} c_{20})	f		164	23,20
203	= (\\Phi_{K} T) (\\Phi_{(b,)} c_{17})	f		165	17
255	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})	f		12	57,55
206	= (\\Phi_{bb} (\\Phi_{bb} c_{20}) c_{21}) (\\Phi_{bb} (\\Phi_{bb} c_{22}) c_{31})	f		166	20,21,22,31
207	= (\\Phi_{bb} \\Phi_{K} c_{20}) (\\Phi_{cb} c_{31} (\\Phi_{bcb} c_{23}))	f		167	20,31,23
208	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(c(bb,),)} c_{59} c_{31} (\\Phi_{(b(bb,cb),cb)} c_{2} c_{59}) c_{31})	f		168	59,31
209	= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{cbbb} c_{20} \\Phi_{bb} c_{15} c_{20})	f		169	20
212	= (\\Phi_{bb} (\\Phi_{cbbbb} c_{16} \\Phi_{bb} \\Phi_{bb} c_{5}) c_{16}) (\\Phi_{ccccbb} c_{31} \\Phi_{cbbb} \\Phi_{bb} c_{16} \\Phi_{cccbb} c_{32})	f		171	16,31,32
213	= (\\Phi_{cbbb} (c_{15} c_{18}) \\Phi_{bb} c_{4} (c_{15} c_{18})) (\\Phi_{bb} (\\Phi_{bb} (c_{15} c_{18})) c_{32})	f		172	18,32
215	= (\\Phi_{c(bb,bb)} (c_{15} c_{18}) (\\Phi_{(bb,bb)} c_{4}) c_{15} c_{4} (c_{15} c_{18})) (\\Phi_{(cb,b)} c_{32} (\\Phi_{(bcb,b)} c_{15}) c_{32})	f		173	18,32
224	= (\\Phi_{bbb} (\\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{31}) \\Phi_{bcb} c_{16}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{60})	f		174	31,16,60
217	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{32} \\Phi_{bcb} c_{25}) c_{32}) (\\Phi_{ccbb} \\Phi_{cbb} c_{32} \\Phi_{ccb} c_{25})	f		12	32,25
218	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cbb,b)} c_{16} (\\Phi_{(bbbbb,bb)} (\\Phi_{(bb,b)} c_{2}) c_{16} c_{22} c_{22}) c_{24} c_{34})	f		175	16,22,24,34
225	= (\\Phi_{cbbb} c_{31} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) \\Phi_{bb} c_{16}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{61})	f		176	31,16,61
220	= (\\Phi_{(ccbb,b)} c_{24} \\Phi_{bb} \\Phi_{cbbb} c_{34} c_{34}) (\\Phi_{cbbb} c_{24} \\Phi_{bb} \\Phi_{bb} c_{34})	f		177	24,34
256	= (\\Phi_{(ccbb,b)} c_{55} \\Phi_{bb} \\Phi_{cbbb} c_{57} c_{57}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{57})	f		177	55,57
190	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(c(cbb,),b)} c_{27} c_{5} (\\Phi_{(bb,(bcb,b))} c_{2}) c_{15} c_{27})	f		178	27
257	= (c_{55} c_{43} c_{43}) c_{44}	f		179	55,43,44
43	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{5}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{5})	f		180	
121	= (\\Phi_{cbbbb} (\\Phi_{(bb,b)} c_{2}) \\Phi_{bb} (\\Phi_{bbb} \\Phi_{K}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{ccb} \\Phi_{cccb} \\Phi_{K} (\\Phi_{cccb} (\\Phi_{(bb(bb,b),bb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{K} c_{5})))	f		181	
130	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbbb,bb)} \\Phi_{b} c_{2} \\Phi_{bbcb} (\\Phi_{c(cbbbb,)} (\\Phi_{(bb,b)} c_{5})) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		182	
223	= (\\Phi_{(bcbbb,bbb)} c_{19} c_{31} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) \\Phi_{bb} c_{16} \\Phi_{K} c_{22} c_{22}) (\\Phi_{b} c_{61})	f		183	19,31,16,22,61
73	= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})	f		184	
86	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccb,b)} c_{2} \\Phi_{bcbcb} c_{4} (\\Phi_{ccc(bbb,)} c_{5}) c_{4})	f		185	
185	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(cc(ccbb,bbb),bb)} \\Phi_{cb} c_{16} c_{1} c_{2} \\Phi_{cb(bbcb,b)} (c_{59} c_{18}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} c_{16} c_{16} c_{23})	f		186	16,59,18,23
182	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{16} \\Phi_{bcb} c_{4}) c_{16}) (\\Phi_{ccbb} \\Phi_{cbb} c_{16} \\Phi_{ccb} c_{24})	f		187	16,24
226	= (\\Phi_{(b,)} c_{15}) (\\Phi_{K} c_{8})	f		188	
183	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{16} \\Phi_{bcb} c_{5}) c_{16}) (\\Phi_{ccbb} \\Phi_{cbb} c_{16} \\Phi_{ccb} c_{25})	f		189	16,25
184	= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{16} c_{18}))	f		190	16,18
191	= (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b} c_{16}) (\\Phi_{b} (c_{59} c_{18}))	f		191	16,59,18
187	= c_{18} (c_{22} c_{18})	f		193	18,22
188	= c_{18} (c_{23} c_{18})	f		193	18,23
221	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(ccbbb,b)} c_{60} c_{60} (\\Phi_{(bbb,bb)} c_{27}) c_{25} c_{60} c_{25})	f		194	60,27,25
189	= (\\Phi_{bb} \\Phi_{b} c_{24}) (\\Phi_{cb} c_{24} \\Phi_{cb})	f		195	24
127	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(c(bbb,ccbbbb),bb)} \\Phi_{b} c_{5} (\\Phi_{cc(cbbbb,)} \\Phi_{cbb} c_{5}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} c_{1} c_{2} \\Phi_{cb(bb,bccb)} c_{7} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		197	
236	= (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{bbb} c_{2}) (\\Phi_{bbb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) \\Phi_{bb} c_{2})	f		198	
235	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{cccbb(b,)} c_{15} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{bbbb} c_{2} c_{15})	f		199	
237	= (\\Phi_{(bbbb,bbb)} c_{19} (\\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{31}) \\Phi_{bcb} c_{16} \\Phi_{K} c_{22} c_{22}) (\\Phi_{b} c_{60})	f		201	19,31,16,22,60
238	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cbbbb} (\\Phi_{(b(bb,b),(bb,b))} c_{1} c_{5}) (\\Phi_{(cb,b)} c_{5}) \\Phi_{bc(cb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		202	
211	= (\\Phi_{ccccbb} c_{16} (\\Phi_{bccccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{(bcbb,cbcb)} c_{5}) c_{5} (\\Phi_{ccccbb} (\\Phi_{bc(ccccbb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{31} c_{15})) c_{16}) (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{16}) c_{32})	f		203	16,31,32
180	= T (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\Phi_{bc(cccccbccbbbb,ccbbbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{16} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{(bcb,cbbbb)} c_{2}) c_{15} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{16}) \\Phi_{cb} c_{16} (\\Phi_{(bbcb,b)} c_{1}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} c_{16} \\Phi_{cb} c_{16} (\\Phi_{(bbcb,b)} c_{1}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} c_{16}))	f		204	16
181	= T (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\Phi_{bc(cccccbbb,bb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{16} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{(bcb,cbbbb)} c_{2}) c_{15} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{16}) (\\Phi_{(bb,b)} c_{1}) c_{27} (\\Phi_{(bb,b)} c_{1}) c_{27}))	f		205	16,27
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
158	= (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{27})	f		213	16,27
239	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{cccccbb(b,)} c_{15} \\Phi_{b} \\Phi_{cb} c_{15} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b(bcb,bb)} c_{2} c_{15})	f		214	
110	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{cbbb} c_{15} (\\Phi_{bcbbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})))) (\\Phi_{(b(bb,b),b)} c_{1} c_{4}) c_{15})	f		215	16
115	= (\\Phi_{K} T) (\\Phi_{bcbbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{1}) c_{27})	f		216	16,27
107	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(cbb,bb)} c_{16} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{(bb,bbb)} c_{2}) c_{15} (\\Phi_{(bb,b)} c_{1}) c_{16})	f		217	16
240	= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{1}) c_{16})	f		218	16
216	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cbc(bbbbcb,)} c_{32} \\Phi_{bb} c_{16} \\Phi_{bcbb} c_{2} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) (\\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{31}) c_{15} \\Phi_{cbcb})	f		219	32,16,31
241	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})	f		220	
267	= (c_{54} c_{43} c_{42}) (c_{55} c_{43} c_{51})	f		221	54,43,42,55,51
111	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{ccb} c_{16} (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) (\\Phi_{bcb(cb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})))))	f		222	16
179	= T (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\Phi_{bcc(ccbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{15} (\\Phi_{(b(bb,b),b)} c_{1} c_{4}) c_{15} (\\Phi_{(b(bb,b),b)} c_{1} c_{4}) (\\Phi_{bc(cccccbcbb,cbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{16} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{(bcb,cbbbb)} c_{2}) c_{15} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{16})) c_{15} c_{15}))	f		223	16
268	= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})	f		224	57,54,43,42,55
270	= (\\Phi_{K} c_{42}) (\\Phi_{b} (c_{57} c_{42}))	f		225	42,57
269	= (c_{54} (c_{54} (c_{54} c_{43} c_{42}) c_{43}) c_{51}) (c_{55} (c_{54} c_{44} c_{42}) (c_{54} (c_{54} c_{51} c_{51}) c_{51}))	f		226	54,43,42,51,55,44
266	= (c_{54} (c_{54} c_{45} c_{48}) c_{46}) (c_{55} (c_{54} c_{44} c_{45}) (c_{54} (c_{54} c_{45} c_{46}) c_{43}))	f		227	54,45,48,46,55,44,43
214	= (\\Phi_{c(ccbbb,bb)} c_{16} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{17} (\\Phi_{(bbbb,bbb)} c_{4} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5}) c_{16} (\\Phi_{(bb,b)} c_{5}) c_{17}) (\\Phi_{bb} \\Phi_{b} c_{59})	f		228	16,17,59
219	= (\\Phi_{ccbbb} c_{16} (\\Phi_{bccccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) (\\Phi_{(bbcccbb,cbcb)} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{31})) (\\Phi_{cccbb} (\\Phi_{bc(cccccb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{31} c_{15}) c_{31}) (\\Phi_{(bbb,bcb)} c_{5}) c_{16}) (\\Phi_{cb} c_{34} (\\Phi_{bbcb} \\Phi_{b} c_{16}))	f		229	16,31,34
177	= T (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{17} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{5} c_{15} (\\Phi_{(bcb,cbbbb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) \\Phi_{b} c_{17}))	f		230	17
258	= (c_{55} c_{43} c_{44}) c_{45}	f		34	55,43,44,45
265	= (\\Phi_{ccbb} c_{57} (c_{55} c_{43} c_{51}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})	f		231	57,55,43,51,54
178	= (\\Phi_{K} T) (\\Phi_{bcc(ccb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{16} (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) c_{16} (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) (\\Phi_{bc(cccccb(cb,b),(cb,b))} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{16} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{(bcb,cbbbb)} c_{2}) c_{15} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{16})))	f		232	16
204	= T (c_{7} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}) (\\Phi_{bc(bb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{16} (\\Phi_{(bb,cb)} c_{5}) c_{16})))	f		233	16
205	= T (c_{7} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}) (\\Phi_{bc(cccbb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{16} \\Phi_{cb(bb,cb)} c_{5} c_{5} (\\Phi_{bc(cccbcb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{16}) c_{16})))	f		234	16
271	= (\\Phi_{K} c_{42}) (\\Phi_{cb} c_{42} c_{57})	f		235	42,57
26	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})	f		236	
259	= (c_{55} c_{43} c_{45}) c_{46}	f		34	55,43,45,46
260	= (c_{55} c_{43} c_{46}) c_{47}	f		34	55,43,46,47
262	= (c_{55} c_{43} c_{48}) c_{49}	f		34	55,43,48,49
55	= (\\Phi_{c(bb,)} c_{5} (\\Phi_{bbcb} \\Phi_{K}) c_{1}) (\\Phi_{cbc(cb,)} c_{1} \\Phi_{bb} c_{5} c_{5} (\\Phi_{(bcb,cbb)} c_{1}))	f		237	
1	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})	f		238	
264	= (c_{55} c_{43} c_{50}) c_{51}	f		34	55,43,50,51
\.


--
-- Name: teorema_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.teorema_id_seq', 287, true);


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
AdminTeoremas	Admin	Teoremas	admin@teoremas.gries	4b39bf2b2076bb3aec161cfd09ca0614a65f3c0adadb80ff443b8434237ad0a2745018653685a9811f2335dd0b314427ff7568592cd3856ef67ddb0315da4627	1	t	f	2
federico	Federico	Flaviani	federico.flaviani@gmail.com	4b39bf2b2076bb3aec161cfd09ca0614a65f3c0adadb80ff443b8434237ad0a2745018653685a9811f2335dd0b314427ff7568592cd3856ef67ddb0315da4627	1	f	t	2
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

=======
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
9	AdminTeoremas
10	AdminTeoremas
9	federico
5	federico
6	federico
1	federico
7	federico
13	federico
13	AdminTeoremas
14	AdminTeoremas
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
7	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(c(bbb,ccbbb),bb)} \\Phi_{b} c_{4} (\\Phi_{cc(cbbbb,)} \\Phi_{cbb} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} c_{1} c_{2} \\Phi_{cb(bb,bccb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
8	= (\\Phi_{K} c_{9}) (\\Phi_{cbb} (\\Phi_{K} c_{9}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
9	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) (\\Phi_{(bbb,bb)} c_{2}) \\Phi_{b} (\\Phi_{cccbbb} \\Phi_{b}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} (\\Phi_{(bb,b)} c_{4}))
10	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bbbb,)} \\Phi_{bb} c_{2} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b})
11	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))) (\\Phi_{(cb,b)} (\\Phi_{(bbb,bcb)} c_{2}) (\\Phi_{bccc(ccb,)} \\Phi_{b} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{5}) \\Phi_{c((cbbb,bbbb),)})
12	= (\\Phi_{(cb,cb)} \\Phi_{bb} \\Phi_{cbb} \\Phi_{bcb} \\Phi_{c(bbb,)}) (\\Phi_{bcb} \\Phi_{b} \\Phi_{ccb} (\\Phi_{ccbb} \\Phi_{cbb}))
13	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{cb} \\Phi_{bc} \\Phi_{cb})
14	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(bcb,b)} (\\Phi_{(cb,b)} c_{5}) c_{5} (\\Phi_{b(ccccb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(b(b(bb,b),b),(bb,(bb,b)))} c_{1} c_{5} c_{5}))
15	= (\\Phi_{bcb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) c_{7} (\\Phi_{(bb,bb)} c_{4})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbb} \\Phi_{b})
16	= (\\Phi_{ccbbbb} (\\Phi_{(bb,bb)} c_{4}) c_{7} \\Phi_{bcb} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cccb} \\Phi_{b} \\Phi_{cbcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) (\\Phi_{cccbb} (\\Phi_{(bb,b)} c_{5})))
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
103	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))) (\\Phi_{bcccc(b,)} (\\Phi_{bbb} \\Phi_{b} \\Phi_{bb}) \\Phi_{b} \\Phi_{cbbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (\\Phi_{(b(bbb,cccbbb),b)} c_{2} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b}))
104	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(ccc(ccb,),)} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) (\\Phi_{(bbcb,b)} c_{1}) \\Phi_{cb} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{bcbccbbbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))))
105	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))) (\\Phi_{bb} (\\Phi_{bcb} (\\Phi_{(b,(b,))} (\\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})))) (\\Phi_{(bb(bb,),b)} c_{2})) (\\Phi_{(bb(ccbb,b),cb)} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))))
106	= (\\Phi_{bb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbb} \\Phi_{b})
107	= (\\Phi_{cb} c_{15} (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2})) (\\Phi_{cbb} c_{15} \\Phi_{bb} (\\Phi_{(bb,b)} c_{2}))
108	= (\\Phi_{(b,cb)} (\\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) c_{5} (\\Phi_{(bb,(bb,b))} c_{1})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
109	= (\\Phi_{b(cb,)} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) c_{4} (\\Phi_{(bb,(bb,b))} c_{1})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbb} \\Phi_{b})
110	= (\\Phi_{ccbbbb} (\\Phi_{(bb,(bb,b))} c_{1}) c_{5} \\Phi_{(b,cb)} \\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{cbbcb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}))))
111	= (\\Phi_{ccbbbb} (\\Phi_{(bb,(bb,b))} c_{1}) c_{4} \\Phi_{b(cb,)} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cccb} \\Phi_{b} \\Phi_{cbcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) (\\Phi_{cccbb} (\\Phi_{(bb,b)} c_{5})))
112	= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
113	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cc(cbbb,bb),bb)} (\\Phi_{(bb,b)} c_{1}) \\Phi_{b} c_{1} (\\Phi_{(bbbb,bb)} c_{2}) \\Phi_{b} \\Phi_{(cccbbbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
114	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cccb,bb)} \\Phi_{b} \\Phi_{b} c_{2} \\Phi_{bcbcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) (\\Phi_{ccc(bbbb,b)} (\\Phi_{(bb,b)} c_{4})) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
115	= (\\Phi_{K} T) (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bb} c_{7})))
116	= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
117	= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})
119	= (\\Phi_{K} (\\Phi_{K} c_{8})) (\\Phi_{bb} (\\Phi_{(bb,)} c_{4}) c_{2})
120	= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{(cb,b)} c_{4} \\Phi_{cbb} c_{2})
121	= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{2}) c_{5} c_{4})
122	= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})
123	= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))
124	= \\Phi_{} (\\Phi_{cb} c_{8} c_{2})
125	= (\\Phi_{b} c_{7}) (\\Phi_{b} (c_{2} c_{9}))
126	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(bbb,bbb)} (\\Phi_{(bb,b)} c_{4}) (\\Phi_{ccbb} \\Phi_{b}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} (\\Phi_{(bbb,bb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
127	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cc(cbbb,bb),bb)} (\\Phi_{(bb,b)} c_{2}) \\Phi_{b} c_{2} (\\Phi_{(bbbb,bb)} c_{2}) \\Phi_{b} \\Phi_{(cccbbbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
128	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{ccccc(bcbbb,cbbb)} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{bcb} \\Phi_{c(bbbb,bb)} \\Phi_{b} \\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} \\Phi_{cb} (\\Phi_{(bbcb,bb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
129	= (\\Phi_{b(cccb,)} \\Phi_{K} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{bcb} (\\Phi_{ccbbbb} \\Phi_{cb})) (\\Phi_{bb} \\Phi_{b} (\\Phi_{bbb} \\Phi_{b}))
130	= (\\Phi_{bb} \\Phi_{K} (\\Phi_{bb} (\\Phi_{bb} c_{7}))) (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))
131	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} c_{15}))) (\\Phi_{bb} \\Phi_{b} (\\Phi_{bbb} \\Phi_{b}))
132	= (\\Phi_{bb(bccb,)} \\Phi_{K} \\Phi_{K} \\Phi_{bb} c_{4} \\Phi_{bcb} \\Phi_{c(bbb,)}) (\\Phi_{bb} (\\Phi_{bcb} \\Phi_{b} \\Phi_{cccb}) (\\Phi_{cccbb} \\Phi_{cbbb}))
133	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))
134	= (\\Phi_{bb} (\\Phi_{bbb} (\\Phi_{bb} \\Phi_{K}) \\Phi_{bb}) \\Phi_{bbb}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))))
135	= (\\Phi_{c(cb,b)} \\Phi_{(bbb,bb)} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{bccbb} (\\Phi_{bb} \\Phi_{K})) (\\Phi_{(ccbbb,b)} \\Phi_{K})) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))))
136	= (\\Phi_{cbb} \\Phi_{(bbb,b)} (\\Phi_{bcbb} (\\Phi_{bb} \\Phi_{K}) (\\Phi_{(bb,b)} c_{5})) (\\Phi_{ccbbb} \\Phi_{K})) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))))
137	= (\\Phi_{K} T) (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b}))
138	= (\\Phi_{bb} \\Phi_{K} (\\Phi_{bb} \\Phi_{b})) (\\Phi_{K} (\\Phi_{cb} \\Phi_{cb} \\Phi_{cb}))
139	= (\\Phi_{bb} (\\Phi_{bb} \\Phi_{K}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{5}))) (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))))
140	= (\\Phi_{((bb,),b)} (\\Phi_{b(bcb,)} \\Phi_{K}) \\Phi_{cbb} \\Phi_{b(bbb,b)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))))
141	= (\\Phi_{bbb} \\Phi_{K} \\Phi_{K} (\\Phi_{bb} \\Phi_{b})) (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} (\\Phi_{bbb} \\Phi_{b})))
142	= (\\Phi_{bb} (\\Phi_{bb} \\Phi_{K}) \\Phi_{(bb,)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} \\Phi_{b})))
143	= (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{5}) (\\Phi_{bb} \\Phi_{b} c_{2})
144	= (\\Phi_{bbcb} \\Phi_{K} \\Phi_{b} (\\Phi_{(bb,cb)} c_{5}) \\Phi_{c(bb,)}) (\\Phi_{bb} (\\Phi_{cb} (\\Phi_{cccccb} \\Phi_{K} \\Phi_{cb})) (\\Phi_{cccb} \\Phi_{cb(bcb,b)}))
145	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cc(cbbb,bb),bb)} (\\Phi_{(bb,b)} c_{2}) \\Phi_{b} c_{2} (\\Phi_{(bbbb,bb)} c_{2}) \\Phi_{b} \\Phi_{(cccbbbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
146	= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
147	= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})
148	= (\\Phi_{bcb} (\\Phi_{bc(cccb,)} (\\Phi_{bb} \\Phi_{K}) \\Phi_{K} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{bcb}) \\Phi_{cb} \\Phi_{(bccbbbb,bb)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} \\Phi_{b}))))
149	= (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
150	= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
151	= (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
152	= (\\Phi_{bb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{cbb} \\Phi_{b})
153	= (\\Phi_{cbbbb} (\\Phi_{(bb,b)} c_{5}) \\Phi_{bb} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b}) (\\Phi_{cccb} \\Phi_{b} \\Phi_{cbcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) (\\Phi_{cccbb} (\\Phi_{(bb,b)} c_{5})))
154	= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{5}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{5}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
155	= (\\Phi_{bbbb} \\Phi_{b} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{K} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})
156	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(cbbb,)} c_{2} \\Phi_{cbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) \\Phi_{b})
157	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))) (\\Phi_{(b,)} (\\Phi_{b(cccbb,b)} \\Phi_{b} c_{2} \\Phi_{b(bb,b)} c_{5} \\Phi_{(ccbbb,b)}))
158	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))))) (\\Phi_{(ccbb,cb)} c_{5} c_{5} \\Phi_{(cccb,)} \\Phi_{c(cc(ccbbb,b),)} \\Phi_{c(ccb,)} (\\Phi_{(ccbb,ccbb)} (\\Phi_{(bbb,(bcbb,cb))} c_{2})))
159	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))) (\\Phi_{b} (\\Phi_{bbb} \\Phi_{b} (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2})))
160	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))))) (\\Phi_{bb} (\\Phi_{ccbb} c_{15} c_{15} (\\Phi_{bc(cccbb,b)} \\Phi_{(b,)} \\Phi_{(cccbbbbb,b)} c_{5} \\Phi_{b(bbb,b)} c_{2})) \\Phi_{cc(cccccbb,b)})
161	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))))) (\\Phi_{b} (\\Phi_{bbb} (\\Phi_{bbb} \\Phi_{b} \\Phi_{bb}) \\Phi_{bbb}))
162	= (\\Phi_{bbbb} \\Phi_{K} \\Phi_{K} \\Phi_{K} (\\Phi_{bb} \\Phi_{b})) (\\Phi_{K} (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} \\Phi_{bb}) \\Phi_{bbb}))
163	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))) (\\Phi_{b} (\\Phi_{bbb} \\Phi_{b} \\Phi_{bb}))
164	= (\\Phi_{K} (\\Phi_{K} \\Phi_{})) (\\Phi_{bb} \\Phi_{b} \\Phi_{bb})
165	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{b} \\Phi_{(b,)})
166	= (\\Phi_{bbb} (\\Phi_{bbb} \\Phi_{K} \\Phi_{K}) \\Phi_{bb} \\Phi_{bb}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{bbb} \\Phi_{b} \\Phi_{bb} \\Phi_{bb})))
167	= (\\Phi_{bbb} \\Phi_{K} \\Phi_{K} (\\Phi_{bb} \\Phi_{K})) (\\Phi_{K} (\\Phi_{cbb} \\Phi_{bcb} \\Phi_{bb} \\Phi_{cb}))
168	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))) (\\Phi_{(bb,b)} \\Phi_{(cb,)} (\\Phi_{(b(bb,cb),cb)} c_{2}) \\Phi_{c(c(bb,),)})
169	= (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} c_{15})) (\\Phi_{(ccb,)} c_{15} \\Phi_{bb} \\Phi_{cbbb})
170	= (\\Phi_{K} (\\Phi_{bb} (\\Phi_{cbbbb} c_{15} \\Phi_{bb} \\Phi_{bb} c_{5}) c_{15})) (\\Phi_{(ccccb,)} \\Phi_{cccbb} c_{15} \\Phi_{bb} \\Phi_{cbbb} \\Phi_{ccccbb})
171	= (\\Phi_{bb(bcccb,)} \\Phi_{K} \\Phi_{K} \\Phi_{bb} c_{5} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb}) (\\Phi_{cccb} \\Phi_{ccccbb} \\Phi_{cbbb} \\Phi_{bb} (\\Phi_{bccccb} \\Phi_{b} \\Phi_{cccbb}))
172	= (\\Phi_{b(ccbb,b)} \\Phi_{K} c_{4} \\Phi_{bb} \\Phi_{cbbb} c_{15} c_{15}) (\\Phi_{bbbb} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} c_{15})
173	= (\\Phi_{b(cccbb,b)} \\Phi_{K} c_{4} c_{15} (\\Phi_{(bb,bb)} c_{4}) \\Phi_{c(bb,bb)} c_{15} c_{15}) (\\Phi_{K} (\\Phi_{(cb,)} (\\Phi_{(bcb,b)} c_{15}) \\Phi_{(cb,b)}))
174	= (\\Phi_{bcbb} (\\Phi_{bb} \\Phi_{K}) \\Phi_{bcb} \\Phi_{bbb} (\\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})))) (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} (\\Phi_{bbb} \\Phi_{b})))
175	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))))) (\\Phi_{(bb,b)} (\\Phi_{bb(b,)} (\\Phi_{bb} \\Phi_{b})) \\Phi_{(cbb,b)} (\\Phi_{(bbbbb,bb)} (\\Phi_{(bb,b)} c_{2})))
176	= (\\Phi_{bccb} (\\Phi_{bb} \\Phi_{K}) \\Phi_{bb} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) \\Phi_{cbbb}) (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} (\\Phi_{bbb} \\Phi_{b})))
177	= (\\Phi_{bccb} \\Phi_{(b,)} \\Phi_{cbbb} \\Phi_{bb} \\Phi_{(ccbb,b)}) (\\Phi_{bccb} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbb})
178	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccb,)} c_{15} (\\Phi_{(bb,(bcb,b))} c_{2}) c_{5} \\Phi_{(c(cbb,),b)})
179	= (\\Phi_{b} (\\Phi_{b(b,)} \\Phi_{K})) (\\Phi_{K} (\\Phi_{K} \\Phi_{}))
180	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{5}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{5})
181	= (\\Phi_{cbbbb} (\\Phi_{(bb,b)} c_{2}) \\Phi_{bb} (\\Phi_{bbb} \\Phi_{K}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{ccb} \\Phi_{cccb} \\Phi_{K} (\\Phi_{cccb} (\\Phi_{(bb(bb,b),bb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{K} c_{5})))
182	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbbb,bb)} \\Phi_{b} c_{2} \\Phi_{bbcb} (\\Phi_{c(cbbbb,)} (\\Phi_{(bb,b)} c_{5})) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
183	= (\\Phi_{bb} (\\Phi_{bccb} (\\Phi_{bcb} (\\Phi_{b(b,)} \\Phi_{K}) \\Phi_{K}) \\Phi_{bb} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})))) \\Phi_{(bcbbb,bbb)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} \\Phi_{b})))))
184	= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})
185	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccb,b)} c_{2} \\Phi_{bcbcb} c_{4} (\\Phi_{ccc(bbb,)} c_{5}) c_{4})
186	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))))) (\\Phi_{b(cc(b,),cccb)} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (\\Phi_{bccccbb} \\Phi_{b}) \\Phi_{cb(bbcb,b)} c_{2} c_{1} (\\Phi_{(cc(ccbb,bbb),bb)} \\Phi_{cb}))
187	= (\\Phi_{b(bccb,)} \\Phi_{K} \\Phi_{bb} c_{4} \\Phi_{bcb} \\Phi_{c(bbb,)}) (\\Phi_{bcb} \\Phi_{b} \\Phi_{ccb} (\\Phi_{ccbb} \\Phi_{cbb}))
188	= (\\Phi_{(b,)} c_{15}) (\\Phi_{K} c_{8})
189	= (\\Phi_{b(bccb,)} \\Phi_{K} \\Phi_{bb} c_{5} \\Phi_{bcb} \\Phi_{c(bbb,)}) (\\Phi_{bcb} \\Phi_{b} \\Phi_{ccb} (\\Phi_{ccbb} \\Phi_{cbb}))
190	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} c_{9}))) (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))
191	= (\\Phi_{bbb} \\Phi_{K} \\Phi_{K} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b})) (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))
192	= (\\Phi_{bbccb} (\\Phi_{bb} \\Phi_{K}) \\Phi_{bb} c_{5} \\Phi_{bcb} \\Phi_{c(bbb,)}) (\\Phi_{bbcb} \\Phi_{K} \\Phi_{b} \\Phi_{ccb} (\\Phi_{ccbb} \\Phi_{cbb}))
193	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{b} \\Phi_{c})
194	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))))) (\\Phi_{c(bb,(b,))} \\Phi_{(bbb,bb)} \\Phi_{bbb} \\Phi_{(cb,)} \\Phi_{(ccbbb,b)})
195	= (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})) (\\Phi_{cb} \\Phi_{cb} \\Phi_{cb})
196	= (\\Phi_{bbbb} \\Phi_{b} c_{4} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bb} c_{7})) (\\Phi_{cbbb} \\Phi_{K} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
197	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(c(bbb,ccbbbb),bb)} \\Phi_{b} c_{5} (\\Phi_{cc(cbbbb,)} \\Phi_{cbb} c_{5}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} c_{1} c_{2} \\Phi_{cb(bb,bccb)} c_{7} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
198	= (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{bbb} c_{2}) (\\Phi_{bbb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) \\Phi_{bb} c_{2})
199	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{cccbb(b,)} c_{15} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{bbbb} c_{2} c_{15})
200	= (\\Phi_{bc(b,)} (\\Phi_{cb(cb,ccb)} \\Phi_{(bcccbb,bbbb)} (\\Phi_{ccbb} (\\Phi_{bc(ccbbb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) c_{15}) (\\Phi_{(bb,bcbcb)} c_{5}) (\\Phi_{bccbbcb} (\\Phi_{bb} \\Phi_{K})) c_{5} (\\Phi_{bcccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})))) \\Phi_{K} \\Phi_{(ccccccbbb,b)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))))))
201	= (\\Phi_{cbb} (\\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{bcbb} (\\Phi_{bcb} (\\Phi_{b(b,)} \\Phi_{K}) \\Phi_{K}) \\Phi_{bcb}) \\Phi_{(bbbb,bbb)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} \\Phi_{b})))))
202	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cbbbb} (\\Phi_{(b(bb,b),(bb,b))} c_{1} c_{5}) (\\Phi_{(cb,b)} c_{5}) \\Phi_{bc(cb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})
203	= (\\Phi_{ccc(b,cccb)} (\\Phi_{bc(ccccbb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) c_{15} \\Phi_{ccccbb} (\\Phi_{bcbbcb} \\Phi_{K}) c_{5} (\\Phi_{(bcbb,cbcb)} c_{5}) (\\Phi_{bccccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) \\Phi_{ccccbb}) (\\Phi_{bbbb} \\Phi_{K} \\Phi_{b} \\Phi_{bb} (\\Phi_{bbb} \\Phi_{b}))
204	= (\\Phi_{K} T) (\\Phi_{b(ccc(c(ccc(c(cccccb,b),),),),)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) (\\Phi_{(bbcb,b)} c_{1}) \\Phi_{cb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) (\\Phi_{(bbcb,b)} c_{1}) \\Phi_{cb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{5} c_{15} (\\Phi_{(bcb,cbbbb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bc(cccccbccbbbb,ccbbbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))))
205	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bc(cccccb,b)} (\\Phi_{b(cb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{(bb,b)} c_{1})) (\\Phi_{(bb,b)} c_{1}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{5} c_{15} (\\Phi_{(bcb,cbbbb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bc(cccccbbb,bb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))))
206	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{c(ccbb,b)} c_{4} c_{5} (\\Phi_{(bbb,b)} c_{5}) \\Phi_{(cbbb,b)} c_{2} c_{2})
207	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))
208	= (\\Phi_{K} (\\Phi_{K} \\Phi_{})) (\\Phi_{bb} \\Phi_{b} \\Phi_{cb})
209	= (\\Phi_{K} (\\Phi_{K} \\Phi_{})) (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))
210	= (\\Phi_{(bb,)} \\Phi_{bb} (\\Phi_{bbb} \\Phi_{b})) (\\Phi_{(ccb,)} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbb})
211	= (\\Phi_{bbb} \\Phi_{K} \\Phi_{K} \\Phi_{K}) (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} \\Phi_{(bb,)}))
212	= (\\Phi_{cbb} c_{1} \\Phi_{b(b,)} c_{1}) (\\Phi_{b} \\Phi_{K})
213	= (\\Phi_{b(ccb,)} \\Phi_{K} (\\Phi_{(bb,b)} c_{2}) (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) \\Phi_{cbbb}) (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b})))
214	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{cccccbb(b,)} c_{15} \\Phi_{b} \\Phi_{cb} c_{15} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b(bcb,bb)} c_{2} c_{15})
215	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{ccbcb} c_{15} (\\Phi_{(b(bb,b),b)} c_{1} c_{4}) (\\Phi_{cbbb} c_{15}) (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{bcbbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))))
216	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{bccb} \\Phi_{b} (\\Phi_{(bb,b)} c_{1}) (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{bcbbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))))
217	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccccb,)} (\\Phi_{(bb,b)} c_{1}) c_{15} (\\Phi_{(bb,bbb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) \\Phi_{c(cbb,bb)})
218	= (\\Phi_{K} (\\Phi_{bb} \\Phi_{b} c_{15})) (\\Phi_{(ccb,)} (\\Phi_{(bb,b)} c_{1}) (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) \\Phi_{cbbb})
219	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T)))))) (\\Phi_{bcb} (\\Phi_{cbcccb} (\\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{ccbb} \\Phi_{cbcb} c_{15}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{2} \\Phi_{bcbb}) \\Phi_{bb} \\Phi_{cbc(bbbbcb,)})
220	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})
221	= (\\Phi_{b} (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{K} \\Phi_{K}))) (\\Phi_{K} (\\Phi_{bb} \\Phi_{K} (\\Phi_{bc} \\Phi_{b})))
222	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cb,cb)} (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) \\Phi_{ccb} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{bcb(cb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))))
223	= (\\Phi_{K} T) (\\Phi_{bccb(cccccb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{15} c_{15} (\\Phi_{bcc(ccbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{15} (\\Phi_{(b(bb,b),b)} c_{1} c_{4}) c_{15} (\\Phi_{(b(bb,b),b)} c_{1} c_{4})) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{5} c_{15} (\\Phi_{(bcb,cbbbb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bc(cccccbcbb,cbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))))
224	= (\\Phi_{bbbb} \\Phi_{b} \\Phi_{bb} (\\Phi_{bcbb} \\Phi_{b} \\Phi_{bcb}) \\Phi_{ccbb}) (\\Phi_{K} (\\Phi_{bbbcb} \\Phi_{K} \\Phi_{K} \\Phi_{K} \\Phi_{cb} \\Phi_{cb}))
225	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{b} (\\Phi_{bc} \\Phi_{b}))
226	= (\\Phi_{((b,b),)} \\Phi_{(cb,b)} (\\Phi_{bbcbb} (\\Phi_{bbb} \\Phi_{K} \\Phi_{K}))) (\\Phi_{b(cc(b,),b)} \\Phi_{K} \\Phi_{bb(b(b,),)} \\Phi_{cbcb} \\Phi_{cccbb} \\Phi_{ccb})
227	= (\\Phi_{(bb,)} \\Phi_{bb} (\\Phi_{bbb} (\\Phi_{bbbb} \\Phi_{K} \\Phi_{K} \\Phi_{K}))) (\\Phi_{((cccb,b),)} \\Phi_{bcbbb} \\Phi_{bb} \\Phi_{cbbcb} (\\Phi_{b(cccbb,b)} \\Phi_{K}) \\Phi_{ccb})
228	= (\\Phi_{(ccb,cb)} (\\Phi_{(bbbb,bbb)} c_{4} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5}) (\\Phi_{b(ccccb,)} \\Phi_{K} (\\Phi_{(bb,b)} c_{5})) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{c(ccbbb,bb)}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{b} (\\Phi_{bb} \\Phi_{b}))))
229	= (\\Phi_{ccccc(cb,b)} (\\Phi_{bc(cccccb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) c_{15} \\Phi_{cccbb} (\\Phi_{(bbcccbb,cbcb)} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{bccccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{(bbb,bcb)} c_{5}) (\\Phi_{bcc(bbb,(bcb,))} \\Phi_{K}) \\Phi_{ccbbb}) (\\Phi_{bcbb} \\Phi_{K} \\Phi_{cb} \\Phi_{cb} (\\Phi_{bbcb} \\Phi_{b}))
230	= (\\Phi_{K} T) (\\Phi_{b(cccccccb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{(bcb,cbbbb)} c_{2}) c_{15} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) \\Phi_{b} (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))))
231	= (\\Phi_{ccbb} (\\Phi_{bccbb} \\Phi_{K}) \\Phi_{bcb} (\\Phi_{(bccb,)} \\Phi_{bb}) \\Phi_{ccbb}) (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} (\\Phi_{cb} \\Phi_{cb} \\Phi_{cb})))))
232	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(c(cb,),(cccccb,b))} (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) (\\Phi_{bcc(ccb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{5} c_{15} (\\Phi_{(bcb,cbbbb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bc(cccccb(cb,b),(cb,b))} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))))
233	= (\\Phi_{K} T) (\\Phi_{bb(cb,)} c_{7} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) (\\Phi_{(bb,cb)} c_{5}) (\\Phi_{bc(bb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))))
234	= (\\Phi_{K} T) (\\Phi_{bb((cccb,b),)} c_{7} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{5} c_{5} \\Phi_{cb(bb,cb)} (\\Phi_{bc(cccbb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{bc(cccbcb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))))
235	= (\\Phi_{bb} \\Phi_{K} \\Phi_{K}) (\\Phi_{bb} \\Phi_{b} \\Phi_{cb})
236	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})
237	= (\\Phi_{c(bb,)} c_{5} (\\Phi_{bbcb} \\Phi_{K}) c_{1}) (\\Phi_{cbc(cb,)} c_{1} \\Phi_{bb} c_{5} c_{5} (\\Phi_{(bcb,cbb)} c_{1}))
238	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})
\.


--
-- Name: purecombstheorems_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.purecombstheorems_id_seq', 255, true);


--
-- Data for Name: resuelve; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.resuelve (id, nombreteorema, numeroteorema, resuelto, loginusuario, teoremaid, categoriaid, variables, teoriaid) FROM stdin;
7	Identity of $\\equiv$	3.3.a	f	AdminTeoremas	7	1	;q	1
146	Distributivity of $\\vee$ over $\\exists$	9.23	f	AdminTeoremas	141	8	x,y,x,x,x,y,x,x,x,y,x,x;R,Q,P	1
127	Trading	9.4.b	f	AdminTeoremas	122	7	x,y,x,x,x,y,x,x;Q,P,R	1
8	Identity of $\\equiv$	3.3.b	t	AdminTeoremas	8	1	;q	1
135	Body weakening/strengthening	9.11	f	AdminTeoremas	130	7	x,y,x,x,x,y,x,x;R,P,Q	1
128	Trading	9.4.c	f	AdminTeoremas	123	7	x,y,x,x,x,y,x,x;Q,R,P	1
11	Definition of $false$	3.8	t	AdminTeoremas	11	2	;	1
132	Distributivity of $\\wedge$ over $\\forall$	9.7	f	AdminTeoremas	127	7	x,y,x,x,x,y,x,x,x,y,x,x;R,Q,P	1
129	Trading	9.4.d	f	AdminTeoremas	124	7	x,y,x,x,x,y,x,x;Q,P,R	1
133		9.9	f	AdminTeoremas	128	7	x,y,x,x,x,y,x,x,x,y,x,x;R,Q,P	1
147		9.24	f	AdminTeoremas	142	8	x,y,x,x;R	1
150	Monotonicity of $\\exists$	9.27	f	AdminTeoremas	145	8	x,y,x,x,x,y,x,x,x,y,x,x;R,P,Q	1
136	Monotonicity of $\\forall$	9.12	f	AdminTeoremas	131	7	x,y,x,x,x,y,x,x,x,y,x,x;R,P,Q	1
151	$\\exists$-Introduction	9.28	f	AdminTeoremas	146	8	x,y,x,x;P,E	1
488		3.74	t	federico	81	5	;p	1
165		21	t	AdminTeoremas	160	9	;B,A	2
161		17	t	AdminTeoremas	156	9	x,x,y,C,C,x;B	2
134	Range weakening/strengthening	9.10	f	AdminTeoremas	129	7	x,y,x,x,x,y,x,x;Q,P,R	1
457	Absorption	3.44.b	t	federico	48	4	;q,p	1
139	Generalized De Morgan	9.18.a	f	AdminTeoremas	134	8	x,y,x,x,x,y,x,x;R,P	1
137	Instantiation	9.13	f	AdminTeoremas	132	7	x,y,x,x;P,e	1
143	Trading	9.20	f	AdminTeoremas	138	8	x,y,x,x,x,y,x,x;Q,P,R	1
140	Generalized De Morgan	9.18.b	f	AdminTeoremas	135	8	x,y,x,x,x,y,x,x;R,P	1
148	Range weakening/strengthening	9.25	f	AdminTeoremas	143	8	x,y,x,x,x,y,x,x;R,Q,P	1
141	Generalized De Morgan	9.18.c	f	AdminTeoremas	136	8	x,y,x,x,x,y,x,x;R,P	1
144	Distributivity of $\\wedge$ over $\\exists$	9.21	f	AdminTeoremas	139	8	x,y,x,x,x,y,x,x;R,Q,P	1
152	Interchange of quantifications	9.29	f	AdminTeoremas	147	8	x,y,y,y,x,y,x,x,x,y,x,x,x,y,y,y;Q,R,P	1
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
145		9.22	f	AdminTeoremas	140	8	x,y,x,x,x,y,x,x;R,P	1
17		3.14	f	AdminTeoremas	17	2	;q,p	1
18		3.15.a	f	AdminTeoremas	18	2	;p	1
19	Symmetry of $\\not\\equiv$	3.16	f	AdminTeoremas	19	2	;p,q	1
462	Replacement	3.51	t	federico	61	4	;q,r,p	1
498	Weakening/strengthening	3.76.b	t	federico	84	5	;p,q	1
20	Associativity of $\\not\\equiv$	3.17	f	AdminTeoremas	20	2	;r,q,p	1
464	Replace by $true$	3.87	t	federico	104	6	;E,p	1
149	Body weakening/strengthening	9.26	f	AdminTeoremas	144	8	x,y,x,x,x,y,x,x;R,Q,P	1
21	Mutual associativity	3.18	f	AdminTeoremas	21	2	;r,q,p	1
466	Replace by $false$	3.88	t	federico	105	6	;E,p	1
142	Trading	9.19	f	AdminTeoremas	137	8	x,y,x,x,x,y,x,x;P,R	1
22	Mutual interchangeability	3.19	f	AdminTeoremas	22	2	;r,q,p	1
23	Symmetry of $\\vee$	3.24	t	AdminTeoremas	23	3	;p,q	1
24	Associativity of $\\vee$	3.25	t	AdminTeoremas	24	3	;r,q,p	1
25	Idempotency of $\\vee$	3.26	t	AdminTeoremas	25	3	;p	1
10	Reflexivity of $\\equiv$	3.5	t	AdminTeoremas	10	1	;q	1
122	Trading	9.2	t	AdminTeoremas	117	7	x,y,x,x,x,y,x,x;P,R	1
130	Distributivity of $\\vee$ over $\\forall$	9.5	t	AdminTeoremas	125	7	x,y,x,x,x,y,x,x;R,Q,P	1
123	Trading	9.3.a	f	AdminTeoremas	118	7	x,y,x,x,x,y,x,x;P,R	1
138	Generalized De Morgan	9.17	t	AdminTeoremas	133	8	x,y,x,x,x,y,x,x;R,P	1
124	Trading	9.3.b	f	AdminTeoremas	119	7	x,y,x,x,x,y,x,x;R,P	1
131		9.6	f	AdminTeoremas	126	7	x,y,x,x,x,y,x,x;R,P	1
125	Trading	9.3.c	f	AdminTeoremas	120	7	x,y,x,x,x,y,x,x;P,R	1
126	Trading	9.4.a	f	AdminTeoremas	121	7	x,y,x,x,x,y,y,y;Q,P,R,x	1
688		3.83.b	f	AdminTeoremas	243	6	;E,e,f	1
689		3.83.b	t	federico	243	6	;E,e,f	1
107	Extension	1.a	t	AdminTeoremas	107	9	x,y,x,x;B,A	2
473		8.p	t	federico	236	8	x,y,x,x,x,y,x,x;Q,P	1
624		PCA	f	federico	241	5	;P,C	1
527		88	t	federico	238	12	x,y,x,x;P,Q,R	1
743		10.3	t	federico	178	10	x,y,U,U,x,y,A,A,x,y,B,B,x,y,x,x,x,y,x,x;P	2
744		30	t	federico	184	10	;x	2
745		3.48.b	t	federico	54	4	;p,q	1
1	Associativity of $\\equiv$	3.1	t	AdminTeoremas	1	1	;r,q,p	1
2	Symmetry of $\\equiv$	3.2.a	t	AdminTeoremas	2	1	;p,q	1
28	Zero of $\\vee$	3.29	f	AdminTeoremas	28	3	;p	1
29	Identity of $\\vee$	3.30	f	AdminTeoremas	29	3	;p	1
30	Distributivity of $\\vee$ over $\\vee$	3.31	f	AdminTeoremas	30	3	;r,p,q	1
39	Associativity of $\\wedge$	3.37	f	AdminTeoremas	39	4	;r,q,p	1
72	Shunting	3.65	f	AdminTeoremas	72	5	;r,q,p	1
73		3.66	f	AdminTeoremas	73	5	;q,p	1
166		22	t	AdminTeoremas	161	9	;A,B	2
474	Reflexivity of $\\Rightarrow$	3.71	t	federico	78	5	;p	1
4	Symmetry of $\\equiv$	3.2.c	f	AdminTeoremas	4	1	;p,q	1
5	Symmetry of $\\equiv$	3.2.d	f	AdminTeoremas	5	1	;p,q	1
31		3.32.a	f	AdminTeoremas	31	3	;p,q	1
475	Right zero of $\\Rightarrow$	3.72	t	federico	79	5	;p	1
32		3.32.b	f	AdminTeoremas	32	3	;p,q	1
33	Golden rule	3.35.a	f	AdminTeoremas	33	4	;q,p	1
34	Golden rule	3.35.b	t	AdminTeoremas	34	4	;q,p	1
35	Golden rule	3.35.c	f	AdminTeoremas	35	4	;q,p	1
6	Symmetry of $\\equiv$	3.2.e	f	AdminTeoremas	6	1	;p,q	1
9		3.3	f	AdminTeoremas	9	1	;	1
26	Distributivity of $\\vee$ over $\\equiv$	3.27	t	AdminTeoremas	26	3	;r,p,q	1
66	Definition of Implication	3.59	f	AdminTeoremas	66	5	;q,p	1
167		23	t	AdminTeoremas	162	9	;b,a	2
528		99	t	federico	239	12	x,y,x,x;x,y	1
170	Extension	1.b	f	AdminTeoremas	240	9	x,y,x,x;B,A	2
67	Definition of Implication	3.60	f	AdminTeoremas	67	5	;p,q	1
27	Excluded Middle	3.28	t	AdminTeoremas	27	3	;p	1
168		25	t	AdminTeoremas	163	9	;A,B	2
169		27	t	AdminTeoremas	164	9	;x	2
36	Golden rule	3.35.d	f	AdminTeoremas	36	4	;q,p	1
650		3.69	t	federico	76	5	;p,q	1
37	Golden rule	3.35.e	f	AdminTeoremas	37	4	;q,p	1
417	Symmetry of $\\equiv$	3.2.b	t	federico	232	1	;p,q	1
649		10.1	t	federico	177	10	x,y,A,A,x,y,B,B,x,y,x,x,x,y,x,x;	2
171		10.2	f	AdminTeoremas	165	10	x,y,B,B,x,y,A,A;	2
38	Symmetry of $\\wedge$	3.36	f	AdminTeoremas	38	4	;p,q	1
163		19	t	AdminTeoremas	158	9	x,y,x,x;B,A	2
40	Idempotency of $\\wedge$	3.38	f	AdminTeoremas	40	4	;p	1
109	Empty set	2	t	AdminTeoremas	108	9	x,y,A,A,x,y,x,x;	2
41	Identity of $\\wedge$	3.39	f	AdminTeoremas	41	4	;p	1
111	Pairs	4	t	AdminTeoremas	110	9	x,y,A,A,x,y,x,x;b,a	2
42	Zero of $\\wedge$	3.40	f	AdminTeoremas	42	4	;p	1
653		10.4	t	federico	179	10	x,y,a,a,x,y,b,b,x,y,A,A,x,y,B,B,x,y,x,x,x,y,x,x;	2
43	Distributivity of $\\wedge$ over $\\wedge$	3.41	f	AdminTeoremas	43	4	;r,p,q	1
44	Contradiction	3.42	f	AdminTeoremas	44	4	;p	1
173		26	t	AdminTeoremas	167	9	x,x,y,a,a,x,y,b,b,x;B,A	2
45	Absorption	3.43.a	f	AdminTeoremas	45	4	;p,q	1
46	Absorption	3.43.b	f	AdminTeoremas	46	4	;p,q	1
154	Empty symbol	11	t	AdminTeoremas	149	9	;x	2
47	Absorption	3.44.a	f	AdminTeoremas	47	4	;q,p	1
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
162		18	t	AdminTeoremas	157	9	x,x;B,A	2
164		20	t	AdminTeoremas	159	9	;A,B	2
705	Distributivity of $\\Rightarrow$ over $\\equiv$	3.63	t	federico	70	5	;r,p,q	1
746	Weakening/strengthening	3.76.c	f	federico	85	5	;q,p	1
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
115	Infinity	7	t	AdminTeoremas	114	9	x,y,A,A,x,y,x,x;	2
86	Weakening/strengthening	3.76.d	f	AdminTeoremas	86	5	;q,p,r	1
412		3.3	t	federico	9	1	;	1
87	Weakening/strengthening	3.76.e	f	AdminTeoremas	87	5	;r,q,p	1
105	Replace by $false$	3.88	f	AdminTeoremas	105	6	;E,p	1
106	Shannon	3.89	f	AdminTeoremas	106	6	;E,p	1
98	Substitution	3.84.b	t	AdminTeoremas	98	6	;E,f,e	1
156		13.a	t	AdminTeoremas	151	9	;a,x	2
157		13.b	t	AdminTeoremas	152	9	;b,x,a	2
159		15	t	AdminTeoremas	154	9	;B,A	2
160		16	t	AdminTeoremas	155	9	x,x;B,A	2
155		12	t	AdminTeoremas	150	9	x,x;P,y,U	2
235		3.15.b	f	AdminTeoremas	169	2	;p	1
88	Modus ponens	3.77	f	AdminTeoremas	88	5	;q,p	1
237	Weakening/strengthening	3.76.f	f	AdminTeoremas	170	5	;q,p	1
158		14	t	AdminTeoremas	153	9	x,y,C,C;B,x	2
89		3.78	f	AdminTeoremas	89	5	;r,q,p	1
706		A.1	t	AdminTeoremas	244	13	;a	2
90		3.79	f	AdminTeoremas	90	5	;r,p	1
418	Symmetry of $\\equiv$	3.2.c	t	federico	4	1	;p,q	1
419	Symmetry of $\\equiv$	3.2.d	t	federico	5	1	;p,q	1
121		9.8	f	AdminTeoremas	116	7	x,y,x,x;R	1
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
469		8	t	federico	234	12	y,x,x,x;Q,R,P	1
523		3.68	t	federico	75	5	;q,p	1
113	Union	5	t	AdminTeoremas	112	9	x,y,A,A,x,y,x,x,x,y,C,C;B	2
114	Foundation	6	t	AdminTeoremas	113	9	x,y,B,B,x,y,x,x;A	2
116	Parts	8	t	AdminTeoremas	115	9	x,y,A,A,x,y,x,x;B	2
112	Separation	3	t	AdminTeoremas	111	9	x,y,A,A,x,y,x,x;P,U	2
333		57	f	AdminTeoremas	211	10	x,y,a,a,x,y,b,b;B,A,x	2
301		10.4	f	AdminTeoremas	179	10	x,y,a,a,x,y,b,b,x,y,A,A,x,y,B,B,x,y,x,x,x,y,x,x;	2
302		10.5	f	AdminTeoremas	180	10	x,y,B,B,x,y,A,A,x,y,D,D,x,y,x,x,x,y,C,C,x,y,x,x,x,y,C,C;	2
304		28	f	AdminTeoremas	182	10	;B,x,A	2
305		29	f	AdminTeoremas	183	10	;B,x,A	2
306		30	f	AdminTeoremas	184	10	;x	2
308		32	f	AdminTeoremas	186	10	;B,x,A	2
309		33	f	AdminTeoremas	187	10	;	2
310		34	f	AdminTeoremas	188	10	;	2
311		35	f	AdminTeoremas	189	10	;A,B	2
312		36	f	AdminTeoremas	190	10	;B,A	2
336		60	f	AdminTeoremas	214	10	x,y,x,x,x,y,x,x;B,A	2
314		38	f	AdminTeoremas	192	10	;C,A,B	2
315		39	f	AdminTeoremas	193	10	;B,A	2
317		41	f	AdminTeoremas	195	10	;A,B	2
318		42	f	AdminTeoremas	196	10	;B,A	2
319		43	f	AdminTeoremas	197	10	;C,B,A	2
320		44	f	AdminTeoremas	198	10	;	2
321		45	f	AdminTeoremas	199	10	;B,A	2
322		46	f	AdminTeoremas	200	10	;B,A	2
323		47	f	AdminTeoremas	201	10	;A	2
324		48	f	AdminTeoremas	202	10	;A	2
325		49	f	AdminTeoremas	203	10	;A	2
662		3.75	t	federico	82	5	;p	1
328		52	f	AdminTeoremas	206	10	;b,a	2
329		53	f	AdminTeoremas	207	10	;a,b	2
330		54	f	AdminTeoremas	208	10	;a,b	2
331		55	f	AdminTeoremas	209	10	;b,a	2
332		56	f	AdminTeoremas	210	10	;d,b,c,a	2
338		62	f	AdminTeoremas	216	10	x,y,a,a,y,x,b,b;x,B,A	2
334		58	f	AdminTeoremas	212	10	;B,b,A,a	2
335		59	f	AdminTeoremas	213	10	;B,A	2
303		10.6	f	AdminTeoremas	181	10	x,y,B,B,x,y,A,A,x,y,C,C,x,y,x,x,x,y,x,x;	2
337		61	f	AdminTeoremas	215	10	;B,A	2
339		63	f	AdminTeoremas	217	10	;C,A,B	2
340		64	f	AdminTeoremas	218	10	;S,R,w	2
326		50	f	AdminTeoremas	204	10	x,y,A,A,x,y,B,B;	2
342		66	f	AdminTeoremas	220	10	;A,C,B	2
343		67	f	AdminTeoremas	221	10	;S,R	2
350	Reflexivity of $=$	3.83.c	t	AdminTeoremas	226	6	;q	1
341		65	f	AdminTeoremas	219	10	x,y,x,x,x,y,y,y,x,y,z,z;S,R,w	2
327		51	f	AdminTeoremas	205	10	x,y,A,A,x,y,B,B,x,y,C,C;	2
470		3.48.a	t	federico	53	4	;p,q	1
428	Mutual associativity	3.18	t	federico	21	2	;r,q,p	1
429	Mutual interchangeability	3.19	t	federico	22	2	;r,q,p	1
430		3.15.a	t	federico	18	2	;p	1
485	Modus ponens	3.77	t	federico	88	5	;q,p	1
431		3.15.b	t	federico	169	2	;p	1
710		A.3	t	AdminTeoremas	248	13	;a,b	2
425	Zero of $\\vee$	3.29	t	federico	28	3	;p	1
711		A.4	t	AdminTeoremas	249	13	;c,b,a	2
712		A.5	t	AdminTeoremas	250	13	;a	2
432	Identity of $\\vee$	3.30	t	federico	29	3	;p	1
420	Symmetry of $\\equiv$	3.2.e	t	federico	6	1	;p,q	1
421		3.11	t	federico	14	2	;q,p	1
422	Double negation	3.12	t	federico	15	2	;p	1
423	Negation of $false$	3.13	t	federico	16	2	;	1
424		3.14	t	federico	17	2	;q,p	1
713		A.6	t	AdminTeoremas	251	13	;a	2
426	Symmetry of $\\not\\equiv$	3.16	t	federico	19	2	;p,q	1
427	Associativity of $\\not\\equiv$	3.17	t	federico	20	2	;r,q,p	1
434		3.32.a	t	federico	31	3	;p,q	1
435		3.32.b	t	federico	32	3	;p,q	1
433	Distributivity of $\\vee$ over $\\vee$	3.31	t	federico	30	3	;r,p,q	1
530		9.8	t	federico	116	7	x,y,x,x;R	1
344		27.a	f	AdminTeoremas	237	9	x,x,y,y,y,x;R	2
346		68	f	AdminTeoremas	224	10	x,y,y,y;R,z	2
345		27.b	f	AdminTeoremas	223	9	y,x,y,x,x,y;R	2
307		31	f	AdminTeoremas	185	10	x,y,C,C;B,x	2
347		69	f	AdminTeoremas	225	10	x,y,x,x;R,z	2
313		37	f	AdminTeoremas	191	10	x,y,x,x;A	2
471		9.6	t	federico	126	7	x,y,x,x,x,y,x,x;R,P	1
316		40	f	AdminTeoremas	194	10	x,y,C,C;A,B	2
715		A.8	t	AdminTeoremas	253	13	;a,b	2
716		A.9	t	AdminTeoremas	254	13	;c,b,a	2
717		A.10	t	AdminTeoremas	255	13	;c,a,b	2
299		10.1	f	AdminTeoremas	177	10	x,y,A,A,x,y,B,B,x,y,x,x,x,y,x,x;	2
718		A.11	f	AdminTeoremas	256	13	;a,c,b	2
300		10.3	f	AdminTeoremas	178	10	x,y,U,U,x,y,A,A,x,y,B,B,x,y,x,x,x,y,x,x;P	2
714		A.7	f	AdminTeoremas	252	13	;a	2
707		A.2	f	AdminTeoremas	245	13	;a	2
719		A.12	t	AdminTeoremas	257	13	;	2
720		A.13	t	AdminTeoremas	258	13	;	2
721		A.14	t	AdminTeoremas	259	13	;	2
722		A.15	t	AdminTeoremas	260	13	;	2
723		A.16	t	AdminTeoremas	261	13	;	2
724		A.17	t	AdminTeoremas	262	13	;	2
725		A.18	t	AdminTeoremas	263	13	;	2
726		A.19	t	AdminTeoremas	264	13	;	2
727		A.20	t	AdminTeoremas	265	13	;b,a	2
728		AT.1	f	AdminTeoremas	266	14	;	2
729		A.2	t	federico	245	13	;a	2
748	Extension	1.b	t	federico	240	9	x,y,x,x;B,A	2
12	Distributivity of $\\neg$ over $\\equiv$	3.9	t	AdminTeoremas	12	2	;q,p	1
370	One-point rule	8.14	t	AdminTeoremas	229	12	x,x,x;P,E,s	1
453	Definition of $\\equiv$	3.52	t	federico	62	4	;q,p	1
446	Definition of Implication	3.59	t	federico	66	5	;q,p	1
644	Shunting	3.65	t	federico	72	5	;r,q,p	1
533		3.67	t	federico	74	5	;p,q	1
472		9	t	federico	235	12	x,y,x,x;x,y	1
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
526	Left identity of $\\Rightarrow$	3.73	t	federico	80	5	;p	1
730		A.7	t	federico	252	13	;a	2
643		PCA2	f	federico	242	5	;P,D,C	1
731		A.11	t	federico	256	13	;a,c,b	2
733		A.21	f	AdminTeoremas	267	13	;	2
734		A.21	t	federico	267	13	;	2
735		A.22	f	AdminTeoremas	268	13	;b,a	2
736		A.22	t	federico	268	13	;b,a	2
732		AT.1	t	federico	266	14	;	2
737		AT.2	f	AdminTeoremas	269	14	;	2
739		A.23	f	AdminTeoremas	270	13	;a	2
740		A.24	f	AdminTeoremas	271	13	;a	2
741		A.23	t	federico	270	13	;a	2
742		A.24	t	federico	271	13	;a	2
738		AT.2	t	federico	269	14	;	2
\.


--
-- Name: resuelve_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.resuelve_id_seq', 764, true);


--
-- Data for Name: simbolo; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid, tipo) FROM stdin;
2	\\Rightarrow	2	t	3	2	%(a2) %(op) %(aa1)	1	b->b->b
3	\\Leftarrow	2	t	3	2	%(aa2) %(op) %(a1)	1	b->b->b
4	\\vee	2	t	4	3	%(a2) %(op) %(a1)	1	b->b->b
5	\\wedge	2	t	4	3	%(a2) %(op) %(a1)	1	b->b->b
6	\\not\\equiv	2	t	3	4	%(a2) %(op) %(a1)	1	b->b->b
7	\\neg	1	f	1	5	%(op) %(aa1)	1	b->b
8	true	0	f	0	0	%(op)	1	b
9	false	0	f	0	0	%(op)	1	b
19	 	2	f	3	7	\\{%(v1) \\in %(na2) | %(na1) \\}	2	(t->b)->(t->t)->t
63	  	2	f	3	9	[ %(na2) \\ldots %(na1) ]	2	t->t->t
64	-	1	f	3	9	%(op) %(aa1)	2	t->t
65	<	2	f	3	7	%(na2) %(op) %(na1)	2	t->t->p
67	>	2	f	3	7	%(na2) %(op) %(na1)	2	t->t->p
68	\\geq	2	f	3	7	%(na2) %(op) %(na1)	2	t->t->p
66	\\leq	2	f	3	7	%(na2) %(op) %(na1)	2	t->t->p
22	\\bigcup	1	f	3	8	%(op) %(a1)	2	t->t
38		2	f	3	9	%(a2)^{%(na1)}	2	t->t->t->t
1	\\equiv	2	f	3	1	%(a2) %(op) %(a1)	1	b->b->b
15	=	2	f	3	7	%(na2) %(op) %(na1)	1	t->t->b
16	\\in	2	f	3	7	%(a2) %(op) %(a1)	2	t->t->b
17	\\notin	2	f	3	7	%(a2) %(op) %(a1)	2	t->t->b
18	\\emptyset	0	f	3	0	%(op)	2	t
20	 	1	f	3	7	\\{ %(na1) \\}	2	t->t
21	 	2	f	3	7	%(na2) , %(na1)	2	t->t->t
23	\\bigcap	1	f	3	8	%(op) %(a1)	2	t->t
24	\\cup	2	f	3	7	%(aa2) %(op) %(a1)	2	t->t->t
25	\\cap	2	f	3	7	%(aa2) %(op) %(a1)	2	t->t->t
26	\\subset	2	f	3	6	%(a2) %(op) %(a1)	2	t->t->b
27	\\subseteq	2	f	3	6	%(a2) %(op) %(a1)	2	t->t->b
28	\\supset	2	f	3	6	%(a2) %(op) %(a1)	2	t->t->b
29	\\supseteq	2	f	3	6	%(a2) %(op) %(a1)	2	t->t->b
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
59	\\neq	2	f	3	7	%(na2) %(op) %(na1)	2	t->t->b
61	Rg	1	f	3	9	%(op)(%(na1) )	2	t->t
62	\\star	3	f	3	11	(%(ea1) %(v1) |%(na2):%(na3))	1	(x1->x1->x1)->(t->p)->(t->x1)->x1
60	Dom	1	f	3	9	%(op)(%(na1) )	2	t->t
10		2	f	3	7	%(aa1) [ %(a2) ]	1	(x1->x2)->x1->x2
\.


--
-- Name: simbolo_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.simbolo_id_seq', 68, true);


--
-- Data for Name: solucion; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.solucion (id, resuelveid, resuelto, demostracion, metodo) FROM stdin;
496	624	f	L^{\\lambda x_{122}.c_{5} x_{122} x_{67}} (I^{[x_{113},x_{112} := x_{80},x_{67}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{5} x_{122} x_{67}} (I^{[x_{112},x_{113} := (c_{7} x_{67}),x_{80}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))	SS
219	426	t	I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}) (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})})	SS
216	423	t	L^{\\lambda x_{122}.c_{7} x_{122}} A^{= (c_{7} c_{8}) c_{9}} (I^{[x_{112} := c_{8}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})	SS
208	416	t	S (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	SS
209	417	t	M_{4} (S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{114},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (I^{[x_{114} := (c_{1} x_{112} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (M_{1}^{1} (A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})))	EO DM
210	418	t	M_{4} (S (S (I^{[x_{114} := (c_{1} x_{112} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (M_{1}^{1} (A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})))	EO DM
211	419	t	M_{4} (S (I^{[x_{114},x_{112} := x_{112},(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (M_{1}^{1} (A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})))	EO DM
212	420	t	M_{4} (S (S (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} (I^{[x_{114} := x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (M_{1}^{1} (A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{cb} c_{1} (\\Phi_{(b,cb)} c_{1}))})))	EO DM
217	424	t	A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}	SS
213	421	t	S A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})} (L^{\\lambda x_{122}.c_{7} x_{122}} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}) (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})	SS
220	427	t	L^{\\lambda x_{122}.c_{6} x_{114} x_{122}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} (I^{[x_{113},x_{112} := x_{114},(c_{1} x_{113} (c_{7} x_{112}))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})}) (L^{\\lambda x_{122}.c_{1} x_{114} x_{122}} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (L^{\\lambda x_{122}.c_{1} x_{114} x_{122}} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})})) (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{7} x_{112})} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})}))) (S (I^{[x_{113} := (c_{6} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})}))	SS
222	429	t	L^{\\lambda x_{122}.c_{1} x_{114} x_{122}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})})))	SS
214	422	t	M_{4} (S (S (I^{[x_{113},x_{112} := x_{112},(c_{7} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{113} := (c_{7} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (I^{[x_{113} := (c_{7} x_{112})]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	EO DM
218	425	t	L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}) (I^{[x_{114},x_{113} := x_{112},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{112} x_{112}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (S (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))	SS
215	423	t	M_{4} (I^{[x_{112},x_{113} := c_{9},(c_{7} c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})} (S (I^{[x_{113},x_{112} := c_{9},c_{8}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{112},x_{113} := c_{8},c_{9}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{113},x_{112} := c_{8},c_{9}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}) (M_{1}^{1} (A^{= (c_{7} c_{8}) c_{9}})))	EO DM
221	428	t	L^{\\lambda x_{122}.c_{1} x_{114} x_{122}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})}))	SS
223	430	t	S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} A^{= (c_{7} c_{8}) c_{9}} (I^{[x_{113} := (c_{7} c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{113},x_{112} := x_{112},c_{8}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})))	SS
224	431	t	M_{4} (S (I^{[x_{114},x_{113},x_{112} := c_{9},x_{112},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (M_{1}^{1} (A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})))	EO DM
204	412	t	S (S (I^{[x_{113} := c_{8}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})})	DM
376	469	t	S (L^{\\lambda x_{126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{120}.x_{126})} (M_{3} (M_{1}^{1} (I^{[x_{114},x_{113},x_{112} := (x_{82} x_{120}),(x_{81} x_{120}),(x_{80} x_{120})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})} (L^{\\lambda x_{122}.c_{5} x_{122} (x_{80} x_{120})} (I^{[x_{112},x_{113} := (x_{81} x_{120}),(x_{82} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))))) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}}	GE (OE SS)
330	497	t	S (I^{[x_{113},x_{112} := (c_{1} x_{113} x_{112}),(c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112}))]} A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) x_{122}} (I^{[x_{114},x_{112},x_{113} := x_{113},(c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112})),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{4} x_{113} (c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112}))) x_{122})} (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112})),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{4} (c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112})) x_{112}))} (I^{[x_{112} := (c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{4} (c_{5} (c_{2} x_{112} x_{113}) (c_{2} x_{113} x_{112})) x_{113}) x_{122})} (I^{[x_{114},x_{113} := (c_{2} x_{112} x_{113}),(c_{2} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{112}) (c_{4} (c_{2} x_{113} x_{112}) x_{112})))} (I^{[x_{114},x_{112},x_{113} := (c_{2} x_{112} x_{113}),x_{113},(c_{2} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{112}) (c_{4} x_{122} x_{112})))} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} x_{122} x_{112}) (c_{4} (c_{4} x_{113} (c_{7} x_{112})) x_{112})))} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} (c_{4} x_{112} (c_{7} x_{113})) x_{112}) x_{122}))} (I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} (c_{4} x_{112} (c_{7} x_{113})) x_{112}) (c_{4} x_{113} x_{122})))} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} (c_{4} x_{112} (c_{7} x_{113})) x_{112}) x_{122}))} (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} (c_{4} x_{112} (c_{7} x_{113})) x_{112}) x_{122}))} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} x_{122} c_{8}))} (I^{[x_{113} := (c_{4} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} x_{122} c_{8}))} (I^{[x_{114},x_{113},x_{112} := x_{112},x_{112},(c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) (c_{5} (c_{4} x_{122} (c_{7} x_{113})) c_{8}))} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) x_{122})} (I^{[x_{112},x_{113} := c_{8},(c_{4} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{2} x_{113} x_{112}) x_{113})) x_{122})} (I^{[x_{112} := (c_{4} x_{112} (c_{7} x_{113}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} x_{122} x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} x_{122} x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) x_{122}) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{114},x_{112} := (c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} (c_{2} x_{112} x_{113}) x_{113}) (c_{4} (c_{7} x_{112}) x_{122})) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} x_{122} x_{113}) (c_{4} (c_{7} x_{112}) x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} x_{122} (c_{4} (c_{7} x_{112}) x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{114},x_{113},x_{112} := x_{112},(c_{7} x_{113}),x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} (c_{4} x_{112} x_{122}) (c_{4} (c_{7} x_{112}) x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{112} := x_{113}]} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} x_{122} (c_{4} (c_{7} x_{112}) x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{112},x_{113} := c_{8},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{5} x_{122} (c_{4} (c_{7} x_{112}) x_{113})) (c_{4} x_{112} (c_{7} x_{113})))} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))}) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{4} x_{112} (c_{7} x_{113})))} (I^{[x_{112} := (c_{4} (c_{7} x_{112}) x_{113})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{4} (c_{7} x_{112}) x_{113}) x_{122})} (I^{[x_{113},x_{112} := x_{112},(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{1} c_{5})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{1} (c_{1} x_{112} (c_{7} x_{113})) (c_{5} x_{112} (c_{7} x_{113}))))} (I^{[x_{113},x_{112} := (c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{1} c_{5})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{1} (c_{1} x_{112} (c_{7} x_{113})) (c_{5} x_{112} (c_{7} x_{113}))))} (I^{[x_{112},x_{113} := (c_{5} (c_{7} x_{112}) x_{113}),(c_{1} (c_{7} x_{112}) x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{5} (c_{7} x_{112}) x_{113}) (c_{1} (c_{7} x_{112}) x_{113})),(c_{1} x_{112} (c_{7} x_{113})),(c_{5} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{5} x_{112} (c_{7} x_{113})))} (I^{[x_{114},x_{113},x_{112} := (c_{5} (c_{7} x_{112}) x_{113}),(c_{1} (c_{7} x_{112}) x_{113}),(c_{1} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{1} (c_{5} (c_{7} x_{112}) x_{113}) (c_{1} x_{122} (c_{1} x_{112} (c_{7} x_{113})))) (c_{5} x_{112} (c_{7} x_{113})))} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} (c_{1} (c_{5} (c_{7} x_{112}) x_{113}) x_{122}) (c_{5} x_{112} (c_{7} x_{113})))} (I^{[x_{113} := (c_{1} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{122} (c_{5} x_{112} (c_{7} x_{113})))} (I^{[x_{113} := (c_{5} (c_{7} x_{112}) x_{113})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{122}) (c_{1} (c_{5} (c_{7} x_{112}) x_{113}) (c_{5} x_{112} (c_{7} x_{113})))} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{5} (c_{7} x_{112}) x_{113}) (c_{5} x_{112} (c_{7} x_{113})))} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{5} (c_{7} x_{112}) x_{113}) (c_{5} x_{112} (c_{7} x_{113})))} (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{7} x_{112}) (c_{7} x_{113})),(c_{5} (c_{7} x_{112}) x_{113}),(c_{5} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{112} (c_{7} x_{113}))} (I^{[x_{114},x_{113},x_{112} := (c_{7} x_{112}),(c_{7} x_{113}),(c_{5} (c_{7} x_{112}) x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (I^{[x_{112},x_{113} := (c_{5} x_{112} (c_{7} x_{113})),(c_{1} (c_{7} x_{112}) (c_{1} (c_{7} x_{113}) (c_{5} (c_{7} x_{112}) x_{113})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{114},x_{113},x_{112} := (c_{5} x_{112} (c_{7} x_{113})),(c_{7} x_{112}),(c_{1} (c_{7} x_{113}) (c_{5} (c_{7} x_{112}) x_{113}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{7} x_{113}) (c_{5} (c_{7} x_{112}) x_{113}))} (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{5} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{7} x_{112}) x_{122}) (c_{1} (c_{7} x_{113}) (c_{5} (c_{7} x_{112}) x_{113}))} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{7} x_{112}) (c_{5} (c_{7} x_{113}) x_{112})) x_{122}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{cc(bbb,)} c_{7} c_{5} \\Phi_{bcbb} c_{1} c_{7}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{112} x_{113})} A^{= (\\Phi_{cc(bbb,)} c_{7} c_{5} \\Phi_{bcbb} c_{1} c_{7}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (I^{[x_{112},x_{113} := x_{113},x_{112}]} (M_{1}^{1} (A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})))	DM
225	425	t	M_{4} (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})} (L^{\\lambda x_{122}.c_{4} (c_{1} x_{122} x_{112}) x_{112}} A^{= (c_{7} c_{8}) c_{9}}) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113} := (c_{7} x_{112}),c_{8}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} c_{8} x_{112})} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})	EO DM
395	473	t	L^{\\lambda x_{122}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{113},x_{112} := x_{81},(x_{80} x_{120})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{112},x_{113} := (c_{7} (x_{80} x_{120})),x_{81}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{82},x_{81},x_{80} := (\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{7} (x_{80} x_{120})),x_{81}]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) (I^{[x_{112},x_{113} := x_{81},(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{7} (x_{80} x_{120})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (L^{\\lambda x_{122}.c_{4} x_{81} x_{122}} (I^{[x_{112} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{7} (x_{80} x_{120})))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))) (S (I^{[x_{113},x_{112} := x_{81},(c_{7} (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{7} (x_{80} x_{120}))))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{122}.c_{2} x_{81} x_{122}} (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})})))	SS
396	530	t	S (L^{\\lambda x_{122}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.x_{122})} (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) (S (I^{[x_{81},x_{80} := (\\lambda x_{120}.c_{8}),c_{8}]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) (I^{[x_{112},x_{113} := c_{8},(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.c_{8}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.c_{8}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})	SS
233	438	t	I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{112} x_{112}) x_{122}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{113} := (c_{4} x_{112} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}) A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}	SS
231	436	t	A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{112} x_{113})} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}))	SS
226	432	t	L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (c_{7} c_{8}) c_{9}} (L^{\\lambda x_{122}.c_{4} (c_{7} x_{122}) x_{112}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (I^{[x_{114},x_{113} := x_{112},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} (c_{7} x_{112}) x_{112})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})	SS
229	435	t	S (I^{[x_{114} := (c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}))) (S (L^{\\lambda x_{122}.c_{4} (c_{7} x_{122}) x_{112}} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})})) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (c_{7} c_{8}) c_{9}})) A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))}	SS
227	433	t	S (L^{\\lambda x_{122}.c_{4} (c_{4} x_{114} x_{113}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{113}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{114},x_{113} := (c_{4} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (I^{[x_{112},x_{113} := (c_{4} x_{114} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})	SS
236	441	t	S (I^{[x_{114} := (c_{5} x_{114} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})} (S (L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}))) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{114} x_{122}) x_{112}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}) (S (I^{[x_{114},x_{113} := (c_{5} x_{114} x_{113}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{114} x_{113}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})}))	SS
228	434	t	S (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (S (I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}))) (I^{[x_{114},x_{113} := x_{112},(c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} (c_{7} x_{113}) x_{112})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})	SS
237	442	t	I^{[x_{113} := (c_{7} x_{112})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{7} x_{112}) x_{112}) x_{122}} (I^{[x_{113} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{7} x_{112}) x_{112}) x_{122}} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})}) (L^{\\lambda x_{122}.c_{1} x_{122} c_{9}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112},x_{113} := c_{9},c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (S A^{= (c_{7} c_{8}) c_{9}})	SS
234	439	t	I^{[x_{113} := c_{8}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} c_{8} x_{112})} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))}) (L^{\\lambda x_{122}.c_{1} c_{8} x_{122}} (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} c_{8} x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})	SS
235	440	t	I^{[x_{113} := c_{9}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (S (L^{\\lambda x_{122}.c_{1} (c_{4} c_{9} x_{112}) x_{122}} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{7} x_{112})} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))}) (S (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (S A^{= (c_{7} c_{8}) c_{9}})	SS
331	498	t	I^{[x_{112} := (c_{7} (c_{2} x_{112} (c_{5} x_{113} x_{112})))]} A^{= (\\Phi_{b} c_{7}) (\\Phi_{b} (c_{2} c_{9}))} (I^{[x_{112} := (c_{2} x_{112} (c_{5} x_{113} x_{112}))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (S (I^{[x_{112} := (c_{7} (c_{2} x_{112} (c_{5} x_{113} x_{112})))]} A^{= (\\Phi_{b} c_{7}) (\\Phi_{b} (c_{2} c_{9}))} (I^{[x_{112} := (c_{2} x_{112} (c_{5} x_{113} x_{112}))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{1}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{1} (c_{5} x_{113} x_{112}) x_{122}} (I^{[x_{114} := x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{5} x_{113} x_{112}) (c_{5} x_{122} x_{112})} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{5} x_{113} x_{112}) x_{122}} (I^{[x_{114},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}))) (L^{\\lambda x_{122}.c_{1} (c_{5} x_{113} x_{112}) (c_{5} x_{113} x_{122})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})})) (I^{[x_{113} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	CO DM
230	433	t	S (I^{[x_{114} := (c_{4} x_{114} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})} (S (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{4} (c_{4} x_{114} x_{122}) x_{112}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (S (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{113}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{4} x_{114} x_{113}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}))	SS
232	437	t	I^{[x_{113},x_{112} := x_{114},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} (c_{4} x_{114} x_{122}) (c_{1} x_{114} (c_{5} x_{113} x_{112}))} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{5} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{1} (c_{4} x_{113} x_{112}) (c_{1} x_{113} x_{112})),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{5} x_{113} x_{112}))} (I^{[x_{114},x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{114},(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{113} x_{112}) x_{114}) x_{122}) (c_{1} x_{114} (c_{5} x_{113} x_{112}))} (I^{[x_{114},x_{112},x_{113} := x_{113},x_{114},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{112} x_{114}))) (c_{1} x_{114} (c_{5} x_{113} x_{112}))} (I^{[x_{112},x_{113} := x_{114},(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{112} x_{114}))) (c_{1} x_{114} (c_{5} x_{113} x_{112}))} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) x_{122})) (c_{1} x_{114} (c_{5} x_{113} x_{112}))} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{114} x_{112}))) (c_{1} x_{114} x_{122})} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{114} x_{112}))) x_{122}} (I^{[x_{113},x_{112} := (c_{4} x_{113} x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{114} x_{112}))) (c_{1} x_{122} (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{114} x_{112}))) x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{4} x_{113} x_{112}),x_{114},(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{1} (c_{4} x_{113} x_{114}) (c_{4} x_{114} x_{112}))),(c_{4} x_{113} x_{112}),(c_{1} x_{114} (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{4} x_{113} x_{112})) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{4} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{114}),(c_{4} x_{114} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{4} x_{113} x_{114})),(c_{4} x_{114} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) (c_{4} x_{113} x_{114})) x_{122}) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{4} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{114}),(c_{4} (c_{1} x_{114} x_{113}) x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) x_{122}) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{4} (c_{1} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{114})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{4} x_{114} x_{113}) x_{112}),(c_{4} (c_{1} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{114})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{4} x_{113} x_{114})) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{113}),(c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{122} x_{112}) (c_{4} x_{113} x_{114})) (c_{1} x_{114} (c_{1} x_{113} x_{112}))} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{5} x_{114} x_{113}) x_{112}) (c_{4} x_{113} x_{114})) x_{122}} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (I^{[x_{114},x_{113} := (c_{1} (c_{4} (c_{5} x_{114} x_{113}) x_{112}) (c_{4} x_{113} x_{114})),(c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{5} x_{114} x_{113}) x_{112}),(c_{4} x_{113} x_{114}),(c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{5} x_{114} x_{113}) x_{112}) (c_{1} x_{122} (c_{1} x_{114} x_{113}))) x_{112}} (I^{[x_{112} := x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{5} x_{114} x_{113}) x_{112}) x_{122}) x_{112}} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}))) (S (I^{[x_{114},x_{113} := (c_{4} (c_{5} x_{114} x_{113}) x_{112}),(c_{5} x_{114} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (I^{[x_{113} := (c_{5} x_{114} x_{113})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}))	SS
408	533	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))} (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := x_{112},(c_{5} (c_{2} x_{112} x_{113}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (I^{[x_{112} := (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))} (S (M_{3} (S (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (I^{[x_{112},x_{113} := x_{112},(c_{5} (c_{2} x_{112} x_{113}) x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}))) (S (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{2} (c_{7} x_{112}) (c_{7} (c_{5} x_{122} x_{112}))} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{2} (c_{7} x_{112}) (c_{7} (c_{5} x_{122} x_{112}))} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{7} x_{112}) (c_{7} x_{122})} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{4} c_{5} \\Phi_{cbcb})})) (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})})) A^{= T c_{8}}))))) (S (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (L^{\\lambda x_{122}.c_{2} (c_{7} (c_{5} x_{122} x_{112})) (c_{7} x_{112})} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{2} (c_{7} (c_{5} x_{122} x_{112})) (c_{7} x_{112})} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{7} x_{122}) (c_{7} x_{112})} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{4} c_{5} \\Phi_{cbcb})})) (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})})) A^{= T c_{8}}))))	EO (MI (AI (CR DM) (CR DM)))
275	470	t	S (L^{\\lambda x_{122}.c_{1} (c_{7} x_{112}) x_{122}} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{(cb,b)} c_{1} (\\Phi_{(bcbb,)} c_{1}) c_{4}) (\\Phi_{bb} \\Phi_{b} c_{5})}) (I^{[x_{112},x_{113} := (c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{7} x_{113})) x_{112}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{7} x_{113})),x_{112},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{7} x_{113})) x_{122}} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})}) (I^{[x_{112},x_{113} := c_{9},(c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{7} x_{113}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{112} := (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{7} x_{113}))]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (S (L^{\\lambda x_{122}.c_{7} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) x_{122})} (I^{[x_{112} := (c_{7} x_{113})]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}))) (L^{\\lambda x_{122}.c_{7} (c_{1} x_{122} (c_{4} (c_{7} x_{113}) (c_{7} x_{113})))} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{114},x_{112},x_{113} := x_{112},(c_{7} x_{113}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{7} (c_{4} x_{122} (c_{7} x_{113}))} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}))) (I^{[x_{113},x_{112} := (c_{7} (c_{1} x_{112} x_{113})),(c_{7} x_{113})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{7} (c_{7} (c_{1} x_{112} x_{113}))) x_{122}} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{5} x_{122} x_{113}} (I^{[x_{112} := (c_{1} x_{112} x_{113})]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{5} x_{122} x_{113}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{1} (\\Phi_{(bcb,)} c_{5}))}) (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))	SS
238	443	t	L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}) (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{113}),(c_{1} x_{114} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{4} x_{114} x_{113}) x_{112}) x_{122}} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} x_{114} x_{112}) (c_{4} x_{113} x_{112}))} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{4}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{4})}) (S (I^{[x_{113},x_{112} := (c_{4} x_{114} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})}))	SS
276	471	t	I^{[x_{80} := (\\lambda x_{120}.x_{80})]} A^{= (\\Phi_{bb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbb} \\Phi_{b})} (L^{\\lambda x_{122}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{113},x_{112} := x_{80},(x_{82} x_{120})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{122}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122})} (I^{[x_{112},x_{113} := x_{80},(c_{7} (x_{82} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (S (I^{[x_{82},x_{81} := (\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{7} (x_{82} x_{120}))]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})}))	SS
259	464	t	S (L^{\\lambda x_{122}.c_{5} (x_{69} x_{112}) x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (S (L^{\\lambda x_{122}.c_{5} (x_{69} x_{112}) x_{122}} (I^{[x_{112} := (c_{1} x_{112} c_{8})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}))) (S (L^{\\lambda x_{122}.c_{5} (x_{69} x_{112}) (c_{5} x_{122} (c_{1} x_{112} c_{8}))} (I^{[x_{102},x_{101} := x_{112},c_{8}]} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})}))))) (L^{\\lambda x_{122}.c_{5} (x_{69} x_{112}) x_{122}} (I^{[x_{113},x_{112} := (c_{1} (x_{69} x_{112}) (x_{69} c_{8})),(c_{1} x_{112} c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})})) (I^{[x_{114},x_{113},x_{112} := (x_{69} x_{112}),(c_{1} (x_{69} x_{112}) (x_{69} c_{8})),(c_{1} x_{112} c_{8})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}) (S (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{1} (x_{69} x_{112}) (x_{69} c_{8}))) (c_{1} x_{112} c_{8})} (I^{[x_{113} := (x_{69} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))) (L^{\\lambda x_{122}.c_{5} (c_{5} (c_{1} (x_{69} x_{112}) c_{8}) x_{122}) (c_{1} x_{112} c_{8})} (I^{[x_{112},x_{113} := (x_{69} c_{8}),(x_{69} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{1} x_{112} c_{8})} (I^{[x_{113},x_{114},x_{112} := (x_{69} c_{8}),c_{8},(x_{69} x_{112})]} A^{= (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{1} c_{1}) (\\Phi_{ccbb} (\\Phi_{(bcb,b)} c_{5}) c_{1} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{1} (x_{69} c_{8}) (x_{69} x_{112}))) (c_{1} x_{112} c_{8})} (I^{[x_{113} := (x_{69} c_{8})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (S (I^{[x_{114},x_{113},x_{112} := (x_{69} c_{8}),(c_{1} (x_{69} c_{8}) (x_{69} x_{112})),(c_{1} x_{112} c_{8})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (S (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) x_{122}} (I^{[x_{113},x_{112} := (c_{1} (x_{69} c_{8}) (x_{69} x_{112})),(c_{1} x_{112} c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})}))) (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) (c_{5} (c_{2} x_{122} (c_{1} x_{112} c_{8})) (c_{1} x_{112} c_{8}))} (I^{[x_{112},x_{113} := (x_{69} x_{112}),(x_{69} c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) (c_{5} x_{122} (c_{1} x_{112} c_{8}))} (I^{[x_{102},x_{101} := x_{112},c_{8}]} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})})))) (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) x_{122}} (I^{[x_{112} := (c_{1} x_{112} c_{8})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (L^{\\lambda x_{122}.c_{5} (x_{69} c_{8}) x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))	SS
257	462	t	M_{4} (S (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{122}} (I^{[x_{113},x_{112} := (c_{1} x_{112} x_{114}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{(cb,b)} c_{1} (\\Phi_{(bcbb,)} c_{1}) c_{4}) (\\Phi_{bb} \\Phi_{b} c_{5})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{112} x_{114})) (c_{1} x_{113} x_{112}))} (I^{[x_{113},x_{112} := (c_{1} x_{113} x_{114}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{(cb,b)} c_{1} (\\Phi_{(bcbb,)} c_{1}) c_{4}) (\\Phi_{bb} \\Phi_{b} c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{113} x_{114})) (c_{1} x_{113} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),(c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{112} x_{114}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{113} x_{114})) (c_{1} x_{113} x_{112})),(c_{1} x_{113} x_{112}),(c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{112} x_{114}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{112} x_{114}))} (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{113} x_{114})),(c_{1} x_{113} x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{113} x_{114})) x_{122}) (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{112} x_{114}))} (I^{[x_{113} := (c_{1} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{112} x_{114}))} (I^{[x_{113} := (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{113} x_{114}))]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) (c_{1} x_{113} x_{114})) x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})),x_{112},x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) x_{112}) x_{114})} (I^{[x_{114},x_{112} := (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})),x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113}) x_{114}) x_{122}} (I^{[x_{112},x_{113} := x_{114},(c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113}) x_{114}),x_{114},(c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) x_{112})} (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113}),x_{114},x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113}) x_{122}) (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) x_{112})} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112})) x_{112})} (I^{[x_{113} := (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113}) x_{122}} (I^{[x_{113} := (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})) x_{113}),x_{112},(c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112}))} (I^{[x_{114} := (c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),(c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (I^{[x_{114},x_{113},x_{112} := (c_{1} x_{113} x_{112}),(c_{4} (c_{1} x_{113} x_{114}) (c_{1} x_{113} x_{112})),(c_{4} (c_{1} x_{112} x_{114}) (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) x_{122}} (I^{[x_{114},x_{112},x_{113} := (c_{1} x_{113} x_{114}),(c_{1} x_{113} x_{112}),(c_{1} x_{112} x_{114})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{4} (c_{1} (c_{1} x_{113} x_{114}) x_{122}) (c_{1} x_{113} x_{112}))} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{4} x_{122} (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113} := (c_{1} x_{113} x_{114}),x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{4} (c_{1} x_{122} x_{112}) (c_{1} x_{113} x_{112}))} (I^{[x_{114},x_{113},x_{112} := x_{113},x_{114},x_{114}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{4} (c_{1} (c_{1} x_{113} x_{122}) x_{112}) (c_{1} x_{113} x_{112}))} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) (c_{4} (c_{1} x_{122} x_{112}) (c_{1} x_{113} x_{112}))} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (I^{[x_{112} := (c_{1} x_{113} x_{112})]} (M_{1}^{1} (A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}))))	EO DM
521	528	t	L^{\\lambda x_{-126}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.x_{-126})} (I^{[x_{113},x_{112} := (c_{15} x_{120} x_{120}),(c_{5} (c_{15} x_{121} x_{122}) (c_{15} x_{122} x_{121}))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{-126}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.x_{-126})} (I^{[x_{112},x_{113} := (c_{7} (c_{5} (c_{15} x_{121} x_{122}) (c_{15} x_{122} x_{121}))),(c_{15} x_{120} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{82},x_{81},x_{80} := (\\lambda x_{122}.c_{8}),(\\lambda x_{122}.c_{7} (c_{5} (c_{15} x_{121} x_{122}) (c_{15} x_{122} x_{121}))),(c_{15} x_{120} x_{120})]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) (I^{[x_{112},x_{113} := (c_{15} x_{120} x_{120}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{7} (c_{5} (c_{15} x_{121} x_{122}) (c_{15} x_{122} x_{121}))))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (L^{\\lambda x_{-126}.c_{4} (c_{15} x_{120} x_{120}) x_{-126}} (I^{[x_{112} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{7} (c_{5} (c_{15} x_{121} x_{122}) (c_{15} x_{122} x_{121}))))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))) (S (L^{\\lambda x_{-126}.c_{4} (c_{15} x_{120} x_{120}) (c_{7} x_{-126})} (I^{[x_{82},x_{80} := (\\lambda x_{122}.c_{8}),(\\lambda x_{122}.c_{5} (c_{15} x_{121} x_{122}) (c_{15} x_{122} x_{121}))]} A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})}))) (S (I^{[x_{113},x_{112} := (c_{15} x_{120} x_{120}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{4} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{5} (c_{15} x_{121} x_{122}) (c_{15} x_{122} x_{121})))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{-126}.c_{2} (c_{15} x_{120} x_{120}) x_{-126}} (I^{[x_{80},x_{82} := (\\lambda x_{122}.c_{15} x_{121} x_{122}),(\\lambda x_{122}.c_{15} x_{122} x_{121})]} A^{= (\\Phi_{bb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{cbb} \\Phi_{b})}))) (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{122}.x_{-126})} (M_{3} (S (S (L^{\\lambda x_{119}.c_{2} x_{119} (c_{5} (c_{15} x_{121} x_{122}) (c_{15} x_{122} x_{121}))} (I^{[x_{113} := x_{120}]} A^{= (\\Phi_{(b,)} c_{15}) (\\Phi_{K} c_{8})})) (I^{[x_{112} := (c_{5} (c_{15} x_{121} x_{122}) (c_{15} x_{122} x_{121}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})	WI DM
380	527	t	S (L^{\\lambda x_{126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{120}.x_{126})} (M_{3} (S (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{5} (x_{81} x_{120}) (x_{82} x_{120})) x_{122}) (x_{80} x_{120})} (I^{[x_{112},x_{113} := (x_{81} x_{120}),(x_{82} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}) (S (L^{\\lambda x_{122}.c_{2} x_{122} (x_{80} x_{120})} (I^{[x_{113} := (c_{5} (x_{81} x_{120}) (x_{82} x_{120}))]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{112} := (x_{80} x_{120})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) (S (I^{[x_{80},x_{82} := (\\lambda x_{120}.c_{1} (c_{5} (x_{81} x_{120}) (x_{82} x_{120})) (c_{5} (x_{82} x_{120}) (x_{81} x_{120}))),(\\lambda x_{120}.x_{80} x_{120})]} A^{= (\\Phi_{bb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbb} \\Phi_{b})})) A^{= T c_{8}}	GE DM
583	705	t	M_{4} (I^{[x_{69},x_{101},x_{102} := (\\lambda x_{-126}.c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) x_{-126}),(c_{5} (c_{5} (c_{5} (c_{5} (c_{5} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} c_{8}))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{9})) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{8})) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})),(c_{5} (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))} (M_{1}^{1} (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} (c_{5} (c_{5} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} c_{8}))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{9})) x_{-126}) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (I^{[x_{113},x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),c_{8}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} c_{8}),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} (c_{5} (c_{5} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} c_{8}))) x_{-126}) (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (I^{[x_{113},x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),c_{9}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} c_{9}),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} (c_{5} (c_{5} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))) x_{-126}) (c_{4} (c_{7} c_{9}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (I^{[x_{113},x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} c_{8})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} (c_{7} c_{8})),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} (c_{5} (c_{5} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))) x_{-126}) (c_{4} (c_{7} (c_{7} c_{8})) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{9}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (I^{[x_{113},x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} (c_{7} c_{9}))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} (c_{7} (c_{7} c_{9}))),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} (c_{5} (c_{5} x_{-126} (c_{4} (c_{7} (c_{7} (c_{7} c_{9}))) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} (c_{7} c_{8})) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{9}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (I^{[x_{113},x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} (c_{5} x_{-126} (c_{4} (c_{7} (c_{7} c_{8})) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{9}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (S (I^{[x_{114},x_{112},x_{113} := (c_{7} (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} (c_{7} (c_{7} c_{9})))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}) (S (L^{\\lambda x_{-126}.c_{4} x_{-126} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))} (I^{[x_{113},x_{112} := (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))),(c_{7} (c_{7} c_{9}))]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}))))) (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{5} x_{-126} (c_{4} (c_{7} c_{9}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (S (I^{[x_{114},x_{112},x_{113} := (c_{7} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9})))),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} (c_{7} c_{8}))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}) (S (L^{\\lambda x_{-126}.c_{4} x_{-126} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))} (I^{[x_{113},x_{112} := (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))),(c_{7} c_{8})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}))))) (L^{\\lambda x_{-126}.c_{5} (c_{5} x_{-126} (c_{4} (c_{7} c_{8}) (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})))) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (S (I^{[x_{114},x_{112},x_{113} := (c_{7} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8}))),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} c_{9})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}) (S (L^{\\lambda x_{-126}.c_{4} x_{-126} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))} (I^{[x_{113},x_{112} := (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})),c_{9}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}))))) (L^{\\lambda x_{-126}.c_{5} x_{-126} (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (S (I^{[x_{114},x_{112},x_{113} := (c_{7} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9})),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} c_{8})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}) (S (L^{\\lambda x_{-126}.c_{4} x_{-126} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))} (I^{[x_{113},x_{112} := (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}),c_{8}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}))))) (L^{\\lambda x_{-126}.c_{5} x_{-126} (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (I^{[x_{112},x_{113} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{7} (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (I^{[x_{113},x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cbb} c_{7} (\\Phi_{(bbb,)} c_{5}) c_{4})}) (I^{[x_{112},x_{113} := (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8}),(c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (I^{[x_{112},x_{113} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})),(c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})}) (S (I^{[x_{112} := (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})} (S (M_{3} (S (I^{[x_{112} := (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{8})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{8})} (S (M_{3} (S (I^{[x_{112} := (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{9})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{9})} (S (M_{3} (S (I^{[x_{112} := (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} c_{8}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} c_{8}))} (S (M_{3} (S (I^{[x_{112} := (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))} (S (M_{3} (S (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} x_{122}))} (I^{[x_{112} := c_{9}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) x_{122}} (I^{[x_{112} := c_{9}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (I^{[x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{9} c_{2})})) A^{= T c_{8}})))) (S (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) x_{122}} (I^{[x_{112} := c_{9}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (I^{[x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{9} c_{2})})) A^{= T c_{8}}))))) (S (S (L^{\\lambda x_{122}.c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) x_{122}} A^{= (c_{7} c_{8}) c_{9}}) (I^{[x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{9} c_{2})})) A^{= T c_{8}}))))) (S (I^{[x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{9} c_{2})}) A^{= T c_{8}}))))) (S (I^{[x_{112} := (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112}))]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{2})} (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) x_{122}} (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) x_{122}} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{1} (c_{4} x_{114} (c_{7} x_{112})) x_{122})} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{1} x_{122} (c_{2} x_{113} x_{112}))} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})))) (I^{[x_{113} := (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112}))]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})})))))) (S (I^{[x_{112},x_{113} := c_{8},(c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})} (I^{[x_{112} := (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}})))	EO (CA (AI DM (AI DM (AI DM (AI DM (AI DM DM)))))):c_{5} (c_{5} (c_{5} (c_{5} (c_{5} (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} (c_{7} (c_{7} c_{9}))))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} (c_{7} c_{9})))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) (c_{7} c_{8}))) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{9})) (c_{2} (c_{1} (c_{1} (c_{2} x_{114} x_{112}) (c_{2} x_{113} x_{112})) (c_{2} (c_{1} x_{114} x_{113}) x_{112})) c_{8})) (c_{4} (c_{4} (c_{4} (c_{4} (c_{7} (c_{7} (c_{7} (c_{7} c_{9})))) (c_{7} (c_{7} c_{9}))) (c_{7} c_{8})) c_{9}) c_{8})
240	445	t	I^{[x_{113} := (c_{1} x_{112} x_{113})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) x_{122}} (I^{[x_{113} := (c_{1} x_{112} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) x_{122}} (I^{[x_{114},x_{113},x_{112} := x_{112},x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) (c_{1} x_{122} x_{113})} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) x_{122}} (I^{[x_{112},x_{113} := x_{113},c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{112} x_{113}) x_{112}) x_{122}} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} x_{113}} (I^{[x_{114} := x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} x_{122} (c_{4} x_{113} x_{112})) x_{113}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{1} x_{122} x_{113}} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (I^{[x_{114},x_{113},x_{112} := (c_{4} x_{113} x_{112}),x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})	SS
241	446	t	A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(cbbb,b)} c_{7} (\\Phi_{(bbb,b)} c_{4}) c_{5} c_{7} c_{5}) (\\Phi_{bb} \\Phi_{b} c_{1})}) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) (c_{7} (c_{4} x_{113} x_{112}))) x_{122}} (I^{[x_{112} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) (c_{7} (c_{4} x_{113} x_{112}))) x_{122}} (I^{[x_{114},x_{112},x_{113} := x_{113},x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) (c_{7} (c_{4} x_{113} x_{112}))) (c_{4} x_{122} (c_{5} x_{112} x_{113}))} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) (c_{7} (c_{4} x_{113} x_{112}))) x_{122}} (I^{[x_{112} := (c_{5} x_{112} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) (c_{7} (c_{4} x_{113} x_{112}))) x_{122}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{5} c_{4} \\Phi_{cbcb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} (c_{7} x_{113}) x_{122}) x_{113}} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{113}} (I^{[x_{114},x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{122} (c_{7} x_{112})) x_{113}} (I^{[x_{112} := (c_{7} x_{113})]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})})) (L^{\\lambda x_{122}.c_{4} x_{122} x_{113}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (I^{[x_{113},x_{112} := (c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cbb} c_{7} (\\Phi_{(bbb,)} c_{4}) c_{5})}) (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})	SS
258	463	t	A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S A^{= (\\Phi_{(cb,b)} c_{1} \\Phi_{cbb} c_{4}) (\\Phi_{bb} (\\Phi_{(b,b)} c_{1}) c_{5})})	SS
261	466	t	S (I^{[x_{112} := (c_{4} (x_{69} x_{112}) x_{112})]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := (x_{69} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})})) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} x_{112})) x_{122})} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})}) (S (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} x_{112})) x_{122})} (I^{[x_{112} := (c_{1} c_{9} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}))) (S (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} x_{112})) (c_{5} x_{122} (c_{1} c_{9} x_{112})))} (I^{[x_{102},x_{101} := c_{9},x_{112}]} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})}))))) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} x_{112})) x_{122})} (I^{[x_{113},x_{112} := (c_{1} (x_{69} c_{9}) (x_{69} x_{112})),(c_{1} c_{9} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})})) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{7} (x_{69} x_{112})),(c_{1} (x_{69} c_{9}) (x_{69} x_{112})),(c_{1} c_{9} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{5} x_{122} (c_{1} (x_{69} c_{9}) (x_{69} x_{112}))) (c_{1} c_{9} x_{112}))} (I^{[x_{112} := (x_{69} x_{112})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{5} x_{122} (c_{1} (x_{69} c_{9}) (x_{69} x_{112}))) (c_{1} c_{9} x_{112}))} (I^{[x_{112},x_{113} := (x_{69} x_{112}),c_{9}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{7} (c_{5} x_{122} (c_{1} c_{9} x_{112}))} (I^{[x_{113},x_{114},x_{112} := (x_{69} c_{9}),c_{9},(x_{69} x_{112})]} A^{= (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{1} c_{1}) (\\Phi_{ccbb} (\\Phi_{(bcb,b)} c_{5}) c_{1} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{5} x_{122} (c_{1} (x_{69} c_{9}) (x_{69} x_{112}))) (c_{1} c_{9} x_{112}))} (I^{[x_{112},x_{113} := c_{9},(x_{69} c_{9})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{5} x_{122} (c_{1} (x_{69} c_{9}) (x_{69} x_{112}))) (c_{1} c_{9} x_{112}))} (I^{[x_{112} := (x_{69} c_{9})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})}))) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{7} (x_{69} c_{9})),(c_{1} (x_{69} c_{9}) (x_{69} x_{112})),(c_{1} c_{9} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}))) (S (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} c_{9})) x_{122})} (I^{[x_{113},x_{112} := (c_{1} (x_{69} c_{9}) (x_{69} x_{112})),(c_{1} c_{9} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})}))) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} c_{9})) (c_{5} x_{122} (c_{1} c_{9} x_{112})))} (I^{[x_{102},x_{101} := c_{9},x_{112}]} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})})))) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} c_{9})) x_{122})} (I^{[x_{112} := (c_{1} c_{9} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (S (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (x_{69} c_{9})) x_{122})} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (I^{[x_{113},x_{112} := (c_{7} (x_{69} c_{9})),(c_{7} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})}) (L^{\\lambda x_{122}.c_{4} (c_{7} (c_{7} (x_{69} c_{9}))) x_{122}} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112} := (x_{69} c_{9})]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))	SS
584	729	t	I^{[x_{98} := c_{42}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{55}) (\\Phi_{cb} c_{55} \\Phi_{cb})} A^{= \\Phi_{} (\\Phi_{cb} c_{42} c_{55})}	SS
255	460	t	S (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{7} x_{113}) (c_{7} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{7} x_{113}) (c_{7} x_{112})),(c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) (c_{7} x_{112})) x_{122}) (c_{7} x_{113})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}))) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{7} x_{113})} (I^{[x_{114},x_{112},x_{113} := (c_{7} x_{113}),(c_{7} x_{112}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{122} (c_{7} x_{112})) (c_{7} x_{113})} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{1} x_{122} x_{112}) (c_{7} x_{112})) (c_{7} x_{113})} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{7} x_{113})} (I^{[x_{114},x_{112},x_{113} := x_{113},(c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{113} (c_{7} x_{112})) x_{122}) (c_{7} x_{113})} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{113} (c_{7} x_{112})) x_{122}) (c_{7} x_{113})} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{7} x_{113})} (I^{[x_{113} := (c_{4} x_{113} (c_{7} x_{112}))]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (S (I^{[x_{113},x_{112} := (c_{4} x_{113} (c_{7} x_{112})),x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (L^{\\lambda x_{122}.c_{7} (c_{1} x_{122} x_{113})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{7} (c_{1} (c_{4} (c_{7} x_{112}) x_{113}) x_{122})} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}))) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{114},x_{112} := (c_{7} x_{112}),x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{7} (c_{4} x_{122} x_{113})} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{114},x_{112},x_{113} := x_{112},x_{113},(c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{7} (c_{1} (c_{4} x_{112} x_{113}) x_{122})} (I^{[x_{112} := x_{113}]} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113} := (c_{4} x_{112} x_{113})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{112},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})))	SS
260	465	t	L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})}) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} x_{112}) x_{122}} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}) (I^{[x_{112},x_{113} := c_{9},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{5} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})	SS
585	730	t	I^{[x_{97},x_{98} := c_{43},x_{97}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{57}) (\\Phi_{cb} c_{57} \\Phi_{cb})} A^{= \\Phi_{} (\\Phi_{b} (c_{57} c_{43}))}	SS
308	476	t	S (I^{[x_{113},x_{112} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{4} (c_{7} x_{112}) x_{122}} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))	SS
400	533	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))} (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := x_{112},(c_{5} (c_{2} x_{112} x_{113}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (I^{[x_{112} := (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))} (S (M_{3} (S (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{2} (c_{5} x_{122} x_{112}) x_{112}} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{2} (c_{5} x_{122} x_{112}) x_{112}} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} x_{122} x_{112}} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{4} c_{5} \\Phi_{cbcb})})) A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})}) A^{= T c_{8}})))) (S (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (I^{[x_{113},x_{112} := (c_{7} (c_{5} (c_{2} x_{112} x_{113}) x_{112})),(c_{7} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{4} (c_{7} (c_{5} (c_{2} x_{112} x_{113}) x_{112})) x_{122}} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113} := (c_{2} x_{112} x_{113})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})})) (S (I^{[x_{114},x_{113} := (c_{7} (c_{2} x_{112} x_{113})),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{7} (c_{2} x_{112} x_{113})) x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112},x_{113} := c_{8},(c_{7} (c_{2} x_{112} x_{113}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{7} (c_{2} x_{112} x_{113}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}}))))	EO (MI (AI (CR DM) DM))
586	731	t	I^{[x_{97},x_{98} := (c_{55} x_{99} x_{98}),x_{97}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{57}) (\\Phi_{cb} c_{57} \\Phi_{cb})} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})} (L^{\\lambda x_{122}.c_{55} (c_{57} x_{99} x_{97}) x_{122}} A^{= (\\Phi_{bb} \\Phi_{b} c_{57}) (\\Phi_{cb} c_{57} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{55} x_{122} (c_{57} x_{97} x_{98})} (I^{[x_{98} := x_{99}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{57}) (\\Phi_{cb} c_{57} \\Phi_{cb})}))	SS
254	459	t	S (S (I^{[x_{112} := (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})})) (L^{\\lambda x_{122}.c_{7} (c_{5} (c_{7} (c_{7} x_{113})) x_{122})} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{7} (c_{5} x_{122} x_{112})} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})))	SS
248	453	t	S (S (I^{[x_{113},x_{112} := (c_{5} (c_{7} x_{113}) (c_{7} x_{112})),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(cbb,b)} c_{1} \\Phi_{b(b,b)} c_{1} c_{5})}) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) (c_{5} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) x_{122}))} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) x_{122})} (I^{[x_{114},x_{113},x_{112} := (c_{5} (c_{7} x_{113}) (c_{7} x_{112})),x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (S (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) (c_{5} x_{122} x_{113}))} (I^{[x_{114},x_{113} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}))) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) (c_{5} (c_{5} (c_{7} x_{113}) x_{122}) x_{113}))} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) (c_{5} x_{122} x_{113}))} (I^{[x_{112},x_{113} := c_{9},(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) (c_{5} x_{122} x_{113}))} (I^{[x_{112} := (c_{7} x_{113})]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{5} c_{9}))})) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) (c_{1} (c_{5} x_{113} x_{112}) x_{122})} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{5} c_{9}))})) (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) x_{122}} (I^{[x_{112},x_{113} := c_{9},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) (c_{7} x_{112})) x_{122}} (I^{[x_{112} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})}))) (I^{[x_{113},x_{112} := (c_{5} (c_{7} x_{113}) (c_{7} x_{112})),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{113} x_{112})} (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{4} (c_{7} (c_{7} x_{113})) x_{122}) (c_{5} x_{113} x_{112})} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{122} x_{112}) (c_{5} x_{113} x_{112})} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{113} x_{112})} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{113} x_{112}) x_{122}) (c_{5} x_{113} x_{112})} (I^{[x_{113} := (c_{1} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})})) (S (I^{[x_{114},x_{113},x_{112} := (c_{4} x_{113} x_{112}),(c_{1} (c_{1} x_{113} x_{112}) (c_{1} x_{113} x_{112})),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{114},x_{113},x_{112} := (c_{1} x_{113} x_{112}),(c_{1} x_{113} x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) (c_{1} (c_{1} x_{113} x_{112}) x_{122})} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{1} c_{5})}) (I^{[x_{112},x_{113} := (c_{1} (c_{1} x_{113} x_{112}) (c_{4} x_{113} x_{112})),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{114},x_{113},x_{112} := (c_{1} x_{113} x_{112}),(c_{4} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{113} x_{112}) x_{122}} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{113} := (c_{1} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))	SS
256	461	t	A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{6})} (S A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})}) (L^{\\lambda x_{122}.c_{7} x_{122}} A^{= (\\Phi_{(cbbb,b)} c_{7} (\\Phi_{(bbb,b)} c_{4}) c_{5} c_{7} c_{5}) (\\Phi_{bb} \\Phi_{b} c_{1})}) (I^{[x_{113},x_{112} := (c_{5} (c_{7} x_{113}) (c_{7} x_{112})),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{7} (c_{5} (c_{7} x_{113}) (c_{7} x_{112}))) x_{122}} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))} (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{7} (c_{7} x_{113})) x_{122}) (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{122} x_{112}) (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (I^{[x_{114},x_{112},x_{113} := x_{113},(c_{4} (c_{7} x_{113}) (c_{7} x_{112})),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})}) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))) x_{122}} (I^{[x_{112},x_{113} := (c_{4} (c_{7} x_{113}) (c_{7} x_{112})),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))) x_{122}} (I^{[x_{114},x_{113} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))) (c_{4} (c_{5} (c_{7} x_{113}) x_{112}) x_{122})} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))) x_{122}} (I^{[x_{112},x_{113} := c_{9},(c_{5} (c_{7} x_{113}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))) x_{122}} (I^{[x_{112} := (c_{5} (c_{7} x_{113}) x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{5} (c_{7} x_{113}) x_{112})} (I^{[x_{112} := (c_{4} (c_{7} x_{113}) (c_{7} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{5} (c_{7} x_{113}) x_{112})} (I^{[x_{114},x_{112},x_{113} := (c_{7} x_{113}),x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{4} x_{122} (c_{5} (c_{7} x_{112}) x_{113})) (c_{5} (c_{7} x_{113}) x_{112})} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{5} (c_{7} x_{113}) x_{112})} (I^{[x_{112} := (c_{5} (c_{7} x_{112}) x_{113})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{5} (c_{7} x_{113}) x_{112})} (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (I^{[x_{112},x_{113} := (c_{5} (c_{7} x_{113}) x_{112}),(c_{5} x_{113} (c_{7} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})	SS
288	474	t	M_{4} (S (L^{\\lambda x_{122}.c_{1} c_{8} x_{122}} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{1} c_{8} x_{122}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} c_{8} x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}))	EO DM
318	485	t	S (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{113} x_{112}) x_{112}),x_{113}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (I^{[x_{113},x_{112} := (c_{7} (c_{5} (c_{2} x_{113} x_{112}) x_{112})),(c_{7} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{4} (c_{7} (c_{5} (c_{2} x_{113} x_{112}) x_{112})) x_{122}} (I^{[x_{112} := x_{113}]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})})) (L^{\\lambda x_{122}.c_{4} (c_{7} x_{122}) x_{113}} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{113}} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{113}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{114},x_{113},x_{112} := (c_{7} x_{112}),(c_{7} x_{113}),x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{7} x_{112}) x_{122}} (I^{[x_{112} := x_{113}]} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (I^{[x_{112},x_{113} := c_{8},(c_{7} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}})	CR DM
289	475	t	I^{[x_{113} := c_{8}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})	SS
309	477	t	S (L^{\\lambda x_{122}.c_{1} (c_{5} x_{114} x_{112}) x_{122}} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{112}) (c_{1} x_{113} x_{112}))} (I^{[x_{113} := x_{114}]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) (c_{1} x_{114} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} x_{114} x_{112}) (c_{1} x_{114} x_{112})),(c_{1} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} x_{113} x_{112})} (I^{[x_{114},x_{113},x_{112} := (c_{4} x_{114} x_{112}),(c_{1} x_{114} x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) (c_{1} (c_{1} x_{114} x_{112}) x_{122})) (c_{4} x_{113} x_{112})} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) x_{122}) (c_{4} x_{113} x_{112})} (I^{[x_{114},x_{113},x_{112} := (c_{1} x_{114} x_{112}),x_{112},x_{113}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) (c_{1} x_{122} x_{113})) (c_{4} x_{113} x_{112})} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) (c_{1} (c_{1} x_{114} x_{122}) x_{113})) (c_{4} x_{113} x_{112})} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} x_{114} x_{112}) (c_{1} x_{122} x_{113})) (c_{4} x_{113} x_{112})} (I^{[x_{113} := x_{114}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{4} x_{113} x_{112})} (I^{[x_{112},x_{113} := (c_{1} x_{114} x_{113}),(c_{4} x_{114} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (I^{[x_{114},x_{113},x_{112} := (c_{1} x_{114} x_{113}),(c_{4} x_{114} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} x_{114} x_{113}) x_{122}} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})})) (S (I^{[x_{113} := (c_{1} x_{114} x_{113})]} A^{= (\\Phi_{(bb,b)} \\Phi_{bb} c_{1} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})))	SS
249	454	t	I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{112}) x_{112})} (I^{[x_{114},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{122}) (c_{1} (c_{4} x_{113} x_{112}) x_{112})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (I^{[x_{114},x_{113} := (c_{4} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} x_{112}} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})	SS
310	478	t	S (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (S (I^{[x_{114},x_{113},x_{112} := x_{113},x_{112},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} x_{113} x_{122}} (I^{[x_{112},x_{113} := (c_{7} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{4} x_{113} x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}}	DM
523	649	t	S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{65}.x_{-126})} (M_{3} (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{66}.x_{-126})} (M_{3} (S (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{115},x_{82},x_{81},x_{80} := (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}),(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{17} x_{66} x_{120}),(\\lambda x_{120}.c_{17} x_{65} x_{120})]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{17} x_{66} x_{120}) x_{122}))} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{7} (c_{16} x_{65} x_{120}))))} (I^{[x_{65} := x_{66}]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{7} (c_{16} x_{66} x_{120})) x_{122}))} (I^{[x_{112} := (c_{16} x_{65} x_{120})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{1} c_{9} (c_{16} x_{65} x_{120}))))} (I^{[x_{112} := (c_{16} x_{66} x_{120})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{1} c_{9} (c_{16} x_{66} x_{120})) x_{122}))} (I^{[x_{112},x_{113} := (c_{16} x_{65} x_{120}),c_{9}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122}))} (I^{[x_{113},x_{114},x_{112} := (c_{16} x_{65} x_{120}),(c_{16} x_{66} x_{120}),c_{9}]} A^{= (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{1} c_{1}) (\\Phi_{ccbb} (\\Phi_{(bcb,b)} c_{5}) c_{1} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{1} (c_{16} x_{65} x_{120}) c_{9})))} (I^{[x_{112},x_{113} := (c_{16} x_{66} x_{120}),(c_{16} x_{65} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{115},x_{82},x_{81},x_{80} := (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}),(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120})),(\\lambda x_{120}.c_{1} (c_{16} x_{65} x_{120}) c_{9})]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})}))) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{5} x_{122} (c_{62} (\\lambda x_{66}.\\lambda x_{65}.c_{5} x_{66} x_{65}) (\\lambda x_{121}.c_{8}) (\\lambda x_{121}.c_{1} (c_{16} x_{65} x_{121}) c_{9})))} A^{= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{1}) c_{16})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{112},x_{113} := (c_{62} (\\lambda x_{66}.\\lambda x_{65}.c_{5} x_{66} x_{65}) (\\lambda x_{121}.c_{8}) (\\lambda x_{121}.c_{1} (c_{16} x_{65} x_{121}) c_{9})),(c_{15} x_{66} x_{65})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (I^{[x_{112},x_{113} := (c_{15} x_{66} x_{65}),(c_{62} (\\lambda x_{66}.\\lambda x_{65}.c_{5} x_{66} x_{65}) (\\lambda x_{121}.c_{8}) (\\lambda x_{121}.c_{1} (c_{16} x_{65} x_{121}) c_{9}))]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})}))) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}}	GE (GE DM)
588	734	t	S (I^{[x_{97} := (c_{55} c_{43} c_{51})]} A^{= \\Phi_{} (\\Phi_{b} (c_{57} c_{43}))}) (S (I^{[x_{97} := (c_{57} c_{43} (c_{55} c_{43} c_{51}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{55} c_{42}))})) (S (I^{[x_{98},x_{97} := c_{42},c_{43}]} A^{= (\\Phi_{ccbb} c_{57} (c_{55} c_{43} c_{51}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}))	SS
527	472	t	L^{\\lambda x_{-126}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.x_{-126})} (I^{[x_{113},x_{112} := (c_{15} x_{120} x_{120}),(c_{15} x_{121} x_{122})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{-126}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.x_{-126})} (I^{[x_{112},x_{113} := (c_{7} (c_{15} x_{121} x_{122})),(c_{15} x_{120} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{82},x_{81},x_{80} := (\\lambda x_{122}.c_{8}),(\\lambda x_{122}.c_{7} (c_{15} x_{121} x_{122})),(c_{15} x_{120} x_{120})]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) (I^{[x_{112},x_{113} := (c_{15} x_{120} x_{120}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{7} (c_{15} x_{121} x_{122})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (L^{\\lambda x_{-126}.c_{4} (c_{15} x_{120} x_{120}) x_{-126}} (I^{[x_{112} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{7} (c_{15} x_{121} x_{122})))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))) (S (L^{\\lambda x_{-126}.c_{4} (c_{15} x_{120} x_{120}) (c_{7} x_{-126})} (I^{[x_{82},x_{80} := (\\lambda x_{122}.c_{8}),(\\lambda x_{122}.c_{15} x_{121} x_{122})]} A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})}))) (S (I^{[x_{113},x_{112} := (c_{15} x_{120} x_{120}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{4} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{15} x_{121} x_{122}))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{122}.x_{-126})} (M_{3} (S (S (L^{\\lambda x_{119}.c_{2} x_{119} (c_{15} x_{121} x_{122})} (I^{[x_{113} := x_{120}]} A^{= (\\Phi_{(b,)} c_{15}) (\\Phi_{K} c_{8})})) (I^{[x_{112} := (c_{15} x_{121} x_{122})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})	WI DM
526	644	t	I^{[x_{113},x_{112} := x_{114},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{4} x_{114} x_{122}} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})}) (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (S (L^{\\lambda x_{122}.c_{4} x_{122} (c_{7} x_{112})} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))) (S (I^{[x_{113} := (c_{2} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))	SS
524	650	t	L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{114},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} (c_{7} x_{113}) x_{122}} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))	SS
239	444	t	S (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})} (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{114},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) (c_{5} (c_{4} x_{113} x_{112}) x_{122})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) (c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{112}) x_{112}))} (I^{[x_{114},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) (c_{1} (c_{4} x_{113} x_{122}) (c_{1} (c_{4} x_{113} x_{112}) x_{112}))} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{114},x_{113} := (c_{4} x_{113} x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) (c_{1} x_{122} x_{112})} (I^{[x_{113} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} (c_{5} x_{113} x_{112})) x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})) (L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} (I^{[x_{112},x_{113} := (c_{5} x_{113} x_{112}),x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} x_{122} x_{112}} (I^{[x_{114},x_{112},x_{113} := x_{113},x_{114},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{4} x_{112} x_{114})) x_{112}} (I^{[x_{112} := x_{114}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{113}),(c_{4} x_{112} x_{114})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) x_{122}} (I^{[x_{113} := (c_{4} x_{112} x_{114})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} (c_{4} x_{122} x_{112}) (c_{1} (c_{4} x_{112} x_{114}) x_{112}))} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} x_{122} (c_{1} (c_{4} x_{112} x_{114}) x_{112}))} (I^{[x_{113} := x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} (c_{4} x_{114} x_{122}) (c_{1} (c_{4} x_{112} x_{114}) x_{112}))} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})}) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} (c_{4} x_{114} x_{112}) (c_{1} x_{122} x_{112}))} (I^{[x_{112},x_{113} := x_{114},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) x_{122}} (I^{[x_{114},x_{113} := (c_{4} x_{114} x_{112}),(c_{4} x_{114} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) (c_{1} x_{122} x_{112})} (I^{[x_{113} := (c_{4} x_{114} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) x_{122}} (I^{[x_{113} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{4} x_{114} x_{113}) x_{122}} (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})))	SS
528	472	t	L^{\\lambda x_{-126}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.x_{-126})} (I^{[x_{113},x_{112} := (c_{15} x_{120} x_{120}),(c_{15} x_{121} x_{122})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{-126}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.x_{-126})} (I^{[x_{112},x_{113} := (c_{7} (c_{15} x_{121} x_{122})),(c_{15} x_{120} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{82},x_{81},x_{80} := (\\lambda x_{122}.c_{8}),(\\lambda x_{122}.c_{7} (c_{15} x_{121} x_{122})),(c_{15} x_{120} x_{120})]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) (I^{[x_{112},x_{113} := (c_{15} x_{120} x_{120}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{7} (c_{15} x_{121} x_{122})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (L^{\\lambda x_{-126}.c_{4} (c_{15} x_{120} x_{120}) x_{-126}} (I^{[x_{112} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{7} (c_{15} x_{121} x_{122})))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))) (S (L^{\\lambda x_{-126}.c_{4} (c_{15} x_{120} x_{120}) (c_{7} x_{-126})} (I^{[x_{82},x_{80} := (\\lambda x_{122}.c_{8}),(\\lambda x_{122}.c_{15} x_{121} x_{122})]} A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})}))) (S (I^{[x_{113},x_{112} := (c_{15} x_{120} x_{120}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{4} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{15} x_{121} x_{122}))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{122}.x_{-126})} (M_{3} (S (S (L^{\\lambda x_{119}.c_{2} x_{119} (c_{15} x_{121} x_{122})} (I^{[x_{113} := x_{120}]} A^{= (\\Phi_{(b,)} c_{15}) (\\Phi_{K} c_{8})})) (I^{[x_{112} := (c_{15} x_{121} x_{122})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})	WI DM
589	736	t	A^{= (\\Phi_{ccbb} c_{57} (c_{55} c_{43} c_{51}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{55} x_{98} (c_{57} x_{97} x_{122})} A^{= (c_{54} c_{43} c_{42}) (c_{55} c_{43} c_{51})})	SS
250	455	t	S (I^{[x_{113} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{1} c_{5})}) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{5} x_{113} x_{112}) x_{112}) x_{122}} (I^{[x_{114},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{5}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{5})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{5} x_{113} x_{112}) x_{112}) (c_{5} (c_{5} x_{113} x_{112}) x_{122})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})}) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{5} x_{113} x_{112}) x_{112}) x_{122}} (I^{[x_{114},x_{113} := x_{113},x_{112}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{5} x_{113} x_{112}) x_{112}) (c_{5} x_{113} x_{122})} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})}) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{113} x_{112})} (I^{[x_{113} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (I^{[x_{114},x_{113},x_{112} := x_{112},(c_{5} x_{113} x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} x_{112} x_{122}} (I^{[x_{113} := (c_{5} x_{113} x_{112})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (I^{[x_{113} := x_{112}]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})	SS
243	448	t	M_{4} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{5} x_{113} x_{112})} (I^{[x_{114} := (c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} x_{113} x_{112}) x_{113}),x_{112},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (M_{1}^{1} (A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})))	EO DM
244	449	t	M_{4} (S (S (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} x_{113} x_{112}) x_{113}),x_{112},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (M_{1}^{1} (A^{= (\\Phi_{(cb,b)} c_{1} \\Phi_{cbb} c_{4}) (\\Phi_{bb} (\\Phi_{(b,b)} c_{1}) c_{5})})))	EO DM
245	450	t	M_{4} (S (I^{[x_{114},x_{113},x_{112} := (c_{4} x_{113} x_{112}),(c_{1} x_{113} x_{112}),(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (M_{1}^{1} (A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})))	EO DM
246	451	t	M_{4} (S (L^{\\lambda x_{122}.c_{1} (c_{4} x_{113} x_{112}) x_{122}} (I^{[x_{114},x_{113},x_{112} := x_{113},x_{112},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (M_{1}^{1} (A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{1} c_{5})})))	EO DM
251	456	t	I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{4}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{4})} (L^{\\lambda x_{122}.c_{4} (c_{5} x_{113} x_{112}) x_{122}} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(bb,)} c_{5} c_{7})}) (I^{[x_{112},x_{113} := c_{9},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{5} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})	SS
321	488	t	I^{[x_{113} := c_{9}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112} := (c_{7} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})	SS
252	457	t	I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})} (L^{\\lambda x_{122}.c_{5} (c_{4} x_{113} x_{112}) x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112},x_{113} := c_{8},(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}) (I^{[x_{112} := (c_{4} x_{113} x_{112})]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})	SS
531	653	t	S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{97}.x_{-126})} (M_{3} (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{98}.x_{-126})} (M_{3} (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{65}.x_{-126})} (M_{3} (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{66}.x_{-126})} (M_{3} (S (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{115},x_{82},x_{81},x_{80} := (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}),(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{1} (c_{4} (c_{15} x_{98} x_{120}) (c_{15} x_{97} x_{120})) (c_{16} x_{66} x_{120})),(\\lambda x_{120}.c_{1} (c_{4} (c_{15} x_{98} x_{120}) (c_{15} x_{97} x_{120})) (c_{16} x_{65} x_{120}))]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{1} (c_{4} (c_{15} x_{98} x_{120}) (c_{15} x_{97} x_{120})) (c_{16} x_{66} x_{120})) x_{122}))} (I^{[x_{112},x_{113} := (c_{16} x_{65} x_{120}),(c_{4} (c_{15} x_{98} x_{120}) (c_{15} x_{97} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122}))} (I^{[x_{113},x_{114},x_{112} := (c_{16} x_{65} x_{120}),(c_{16} x_{66} x_{120}),(c_{4} (c_{15} x_{98} x_{120}) (c_{15} x_{97} x_{120}))]} A^{= (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{1} c_{1}) (\\Phi_{ccbb} (\\Phi_{(bcb,b)} c_{5}) c_{1} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{1} (c_{16} x_{65} x_{120}) (c_{4} (c_{15} x_{98} x_{120}) (c_{15} x_{97} x_{120})))))} (I^{[x_{112},x_{113} := (c_{16} x_{66} x_{120}),(c_{16} x_{65} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{115},x_{82},x_{81},x_{80} := (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}),(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120})),(\\lambda x_{120}.c_{1} (c_{16} x_{65} x_{120}) (c_{4} (c_{15} x_{98} x_{120}) (c_{15} x_{97} x_{120})))]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})}))) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{5} x_{122} (c_{62} (\\lambda x_{66}.\\lambda x_{65}.c_{5} x_{66} x_{65}) (\\lambda x_{99}.c_{8}) (\\lambda x_{99}.c_{1} (c_{16} x_{65} x_{99}) (c_{4} (c_{15} x_{98} x_{99}) (c_{15} x_{97} x_{99})))))} A^{= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{1}) c_{16})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{112},x_{113} := (c_{62} (\\lambda x_{66}.\\lambda x_{65}.c_{5} x_{66} x_{65}) (\\lambda x_{99}.c_{8}) (\\lambda x_{99}.c_{1} (c_{16} x_{65} x_{99}) (c_{4} (c_{15} x_{98} x_{99}) (c_{15} x_{97} x_{99})))),(c_{15} x_{66} x_{65})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (I^{[x_{112},x_{113} := (c_{15} x_{66} x_{65}),(c_{62} (\\lambda x_{66}.\\lambda x_{65}.c_{5} x_{66} x_{65}) (\\lambda x_{99}.c_{8}) (\\lambda x_{99}.c_{1} (c_{16} x_{65} x_{99}) (c_{4} (c_{15} x_{98} x_{99}) (c_{15} x_{97} x_{99}))))]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})}))) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}}	GE (GE (GE (GE DM)))
530	649	t	S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{65}.x_{-126})} (M_{3} (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{66}.x_{-126})} (M_{3} (S (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{115},x_{82},x_{81},x_{80} := (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}),(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{17} x_{66} x_{120}),(\\lambda x_{120}.c_{17} x_{65} x_{120})]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{17} x_{66} x_{120}) x_{122}))} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{7} (c_{16} x_{65} x_{120}))))} (I^{[x_{65} := x_{66}]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{7} (c_{16} x_{66} x_{120})) x_{122}))} (I^{[x_{112} := (c_{16} x_{65} x_{120})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{1} c_{9} (c_{16} x_{65} x_{120}))))} (I^{[x_{112} := (c_{16} x_{66} x_{120})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{1} c_{9} (c_{16} x_{66} x_{120})) x_{122}))} (I^{[x_{112},x_{113} := (c_{16} x_{65} x_{120}),c_{9}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122}))} (I^{[x_{113},x_{114},x_{112} := (c_{16} x_{65} x_{120}),(c_{16} x_{66} x_{120}),c_{9}]} A^{= (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{1} c_{1}) (\\Phi_{ccbb} (\\Phi_{(bcb,b)} c_{5}) c_{1} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{1} (c_{16} x_{65} x_{120}) c_{9})))} (I^{[x_{112},x_{113} := (c_{16} x_{66} x_{120}),(c_{16} x_{65} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{115},x_{82},x_{81},x_{80} := (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}),(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120})),(\\lambda x_{120}.c_{1} (c_{16} x_{65} x_{120}) c_{9})]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})}))) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{5} x_{122} (c_{62} (\\lambda x_{66}.\\lambda x_{65}.c_{5} x_{66} x_{65}) (\\lambda x_{121}.c_{8}) (\\lambda x_{121}.c_{1} (c_{16} x_{65} x_{121}) c_{9})))} A^{= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{1}) c_{16})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{112},x_{113} := (c_{62} (\\lambda x_{66}.\\lambda x_{65}.c_{5} x_{66} x_{65}) (\\lambda x_{121}.c_{8}) (\\lambda x_{121}.c_{1} (c_{16} x_{65} x_{121}) c_{9})),(c_{15} x_{66} x_{65})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (I^{[x_{112},x_{113} := (c_{15} x_{66} x_{65}),(c_{62} (\\lambda x_{66}.\\lambda x_{65}.c_{5} x_{66} x_{65}) (\\lambda x_{121}.c_{8}) (\\lambda x_{121}.c_{1} (c_{16} x_{65} x_{121}) c_{9}))]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})}))) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}}	GE (GE DM)
539	662	t	I^{[x_{113},x_{112} := x_{112},c_{9}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{4} x_{112} x_{122}} A^{= c_{8} (c_{7} c_{9})}) (I^{[x_{112},x_{113} := c_{8},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))}	SS
598	748	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))))} (I^{[x_{112},x_{113} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))),(c_{15} x_{66} x_{65})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := (c_{15} x_{66} x_{65}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (I^{[x_{112} := (c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))))} (S (M_{3} (S (I^{[x_{112},x_{113} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120}))),(c_{15} x_{66} x_{65})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (I^{[x_{69},x_{102},x_{101} := (\\lambda x_{122}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{122} x_{120}))),x_{66},x_{65}]} A^{= (\\Phi_{cb} c_{15} (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2})) (\\Phi_{cbb} c_{15} \\Phi_{bb} (\\Phi_{(bb,b)} c_{2}))}) (L^{\\lambda x_{122}.c_{2} (c_{62} (\\lambda x_{65}.\\lambda x_{66}.c_{5} x_{65} x_{66}) (\\lambda x_{65}.c_{8}) (\\lambda x_{65}.x_{122})) (c_{15} x_{66} x_{65})} (I^{[x_{112},x_{113} := (c_{16} x_{66} x_{65}),(c_{16} x_{66} x_{65})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{2} (c_{62} (\\lambda x_{65}.\\lambda x_{66}.c_{5} x_{65} x_{66}) (\\lambda x_{65}.c_{8}) (\\lambda x_{65}.x_{122})) (c_{15} x_{66} x_{65})} (I^{[x_{113} := (c_{16} x_{66} x_{65})]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))) (L^{\\lambda x_{122}.c_{2} x_{122} (c_{15} x_{66} x_{65})} (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) (I^{[x_{112} := (c_{15} x_{66} x_{65})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) A^{= T c_{8}})))) (S (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(cbb,bb)} c_{16} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{(bb,bbb)} c_{2}) c_{15} (\\Phi_{(bb,b)} c_{1}) c_{16})})) A^{= T c_{8}})))	EO (MI (AI DM DM))
587	732	t	L^{\\lambda x_{122}.c_{55} (c_{54} c_{44} c_{45}) x_{122}} (I^{[x_{98},x_{97} := c_{43},(c_{54} c_{45} c_{46})]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{55} x_{122} (c_{55} c_{43} (c_{57} (c_{54} c_{45} c_{46}) (c_{54} c_{43} c_{42})))} (I^{[x_{98},x_{97} := c_{45},c_{44}]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})})) (I^{[x_{99},x_{98},x_{97} := (c_{55} c_{45} (c_{57} c_{44} (c_{54} c_{43} c_{42}))),c_{43},(c_{57} (c_{54} c_{45} c_{46}) (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}) (L^{\\lambda x_{122}.c_{55} x_{122} (c_{57} (c_{54} c_{45} c_{46}) (c_{54} c_{43} c_{42}))} (I^{[x_{97},x_{98} := c_{43},(c_{55} c_{45} (c_{57} c_{44} (c_{54} c_{43} c_{42})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{55}) (\\Phi_{cb} c_{55} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{55} x_{122} (c_{57} (c_{54} c_{45} c_{46}) (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{98},x_{97} := c_{43},c_{45},(c_{57} c_{44} (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (S (L^{\\lambda x_{122}.c_{55} (c_{55} x_{122} (c_{57} c_{44} (c_{54} c_{43} c_{42}))) (c_{57} (c_{54} c_{45} c_{46}) (c_{54} c_{43} c_{42}))} A^{= (c_{55} c_{43} c_{45}) c_{46}})) (S (I^{[x_{99},x_{98},x_{97} := c_{46},(c_{57} c_{44} (c_{54} c_{43} c_{42})),(c_{57} (c_{54} c_{45} c_{46}) (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (S (L^{\\lambda x_{122}.c_{55} c_{46} x_{122}} (I^{[x_{99},x_{97},x_{98} := c_{44},(c_{54} c_{43} c_{42}),(c_{54} c_{45} c_{46})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})}))) (L^{\\lambda x_{122}.c_{55} c_{46} (c_{57} (c_{55} c_{44} x_{122}) (c_{54} c_{43} c_{42}))} (I^{[x_{98},x_{97} := c_{46},c_{45}]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{55} c_{46} (c_{57} x_{122} (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{98},x_{97} := c_{44},c_{46},(c_{57} c_{45} (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (L^{\\lambda x_{122}.c_{55} c_{46} (c_{57} (c_{55} (c_{55} x_{122} c_{46}) (c_{57} c_{45} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} A^{= (c_{55} c_{43} c_{43}) c_{44}}) (S (L^{\\lambda x_{122}.c_{55} c_{46} (c_{57} (c_{55} x_{122} (c_{57} c_{45} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{98},x_{97} := c_{43},c_{43},c_{46}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}))) (S (L^{\\lambda x_{122}.c_{55} c_{46} (c_{57} (c_{55} (c_{55} c_{43} x_{122}) (c_{57} c_{45} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} A^{= (c_{55} c_{43} c_{46}) c_{47}})) (S (L^{\\lambda x_{122}.c_{55} c_{46} (c_{57} (c_{55} x_{122} (c_{57} c_{45} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} A^{= (c_{55} c_{43} c_{47}) c_{48}})) (S (L^{\\lambda x_{122}.c_{55} c_{46} (c_{57} x_{122} (c_{54} c_{43} c_{42}))} (I^{[x_{98},x_{97} := c_{48},c_{45}]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}))) (S (I^{[x_{98},x_{97} := c_{46},(c_{54} c_{45} c_{48})]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}))	SS
367	523	f	S (I^{[x_{112} := (c_{2} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))} (S (M_{3} (S (S (L^{\\lambda x_{122}.c_{3} (c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112})) x_{122}} A^{= (c_{7} c_{8}) c_{9}}) (I^{[x_{112},x_{113} := c_{9},(c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{112} := (c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))]} A^{= (\\Phi_{b} c_{7}) (\\Phi_{b} (c_{2} c_{9}))}) (I^{[x_{112} := (c_{4} (c_{2} x_{113} x_{112}) x_{112})]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}) (L^{\\lambda x_{122}.c_{4} x_{122} x_{112}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (S (I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})})) (L^{\\lambda x_{122}.c_{4} x_{113} x_{122}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}})))) (S (I^{[x_{112},x_{113} := (c_{4} (c_{2} x_{113} x_{112}) x_{112}),c_{8}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (S (L^{\\lambda x_{122}.c_{2} (c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112})) x_{122}} A^{= (c_{7} c_{8}) c_{9}}) (I^{[x_{113},x_{112} := (c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112})),c_{9}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{4} (c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112})) x_{122}} A^{= c_{8} (c_{7} c_{9})}) (I^{[x_{112},x_{113} := c_{8},(c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (I^{[x_{112} := (c_{7} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) A^{= T c_{8}}))	EO (MI (AI (CR DM) (CR DM)))
591	741	t	S (I^{[x_{97} := (c_{57} c_{42} x_{97})]} A^{= \\Phi_{} (\\Phi_{b} (c_{55} c_{42}))}) (S (L^{\\lambda x_{122}.c_{55} x_{122} (c_{57} c_{42} x_{97})} (I^{[x_{97} := (c_{57} c_{42} x_{97})]} A^{= (\\Phi_{K} c_{42}) (\\Phi_{(bb,)} c_{55} c_{60})}))) (S (I^{[x_{99},x_{98},x_{97} := (c_{60} (c_{57} c_{42} x_{97})),(c_{57} c_{42} x_{97}),(c_{57} c_{42} x_{97})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (S (L^{\\lambda x_{122}.c_{55} (c_{60} (c_{57} c_{42} x_{97})) x_{122}} (I^{[x_{99},x_{98} := c_{42},c_{42}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})}))) (L^{\\lambda x_{122}.c_{55} (c_{60} (c_{57} c_{42} x_{97})) (c_{57} x_{122} x_{97})} (I^{[x_{97} := c_{42}]} A^{= \\Phi_{} (\\Phi_{cb} c_{42} c_{55})})) (I^{[x_{97} := (c_{57} c_{42} x_{97})]} A^{= (\\Phi_{K} c_{42}) (\\Phi_{(bb,)} c_{55} c_{60})})	SS
592	742	t	I^{[x_{97},x_{98} := c_{42},x_{97}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{57}) (\\Phi_{cb} c_{57} \\Phi_{cb})} A^{= (\\Phi_{K} c_{42}) (\\Phi_{b} (c_{57} c_{42}))}	SS
590	738	t	L^{\\lambda x_{122}.c_{55} (c_{54} c_{44} c_{42}) x_{122}} (I^{[x_{98},x_{97} := c_{51},(c_{54} c_{51} c_{51})]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}) (L^{\\lambda x_{122}.c_{55} x_{122} (c_{55} c_{51} (c_{57} (c_{54} c_{51} c_{51}) (c_{54} c_{43} c_{42})))} (I^{[x_{98},x_{97} := c_{42},c_{44}]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})})) (I^{[x_{99},x_{98},x_{97} := (c_{55} c_{42} (c_{57} c_{44} (c_{54} c_{43} c_{42}))),c_{51},(c_{57} (c_{54} c_{51} c_{51}) (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}) (L^{\\lambda x_{122}.c_{55} x_{122} (c_{57} (c_{54} c_{51} c_{51}) (c_{54} c_{43} c_{42}))} (I^{[x_{97},x_{98} := c_{51},(c_{55} c_{42} (c_{57} c_{44} (c_{54} c_{43} c_{42})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{55}) (\\Phi_{cb} c_{55} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{55} x_{122} (c_{57} (c_{54} c_{51} c_{51}) (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{98},x_{97} := c_{51},c_{42},(c_{57} c_{44} (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (L^{\\lambda x_{122}.c_{55} (c_{55} x_{122} (c_{57} c_{44} (c_{54} c_{43} c_{42}))) (c_{57} (c_{54} c_{51} c_{51}) (c_{54} c_{43} c_{42}))} (I^{[x_{97} := c_{51}]} A^{= \\Phi_{} (\\Phi_{cb} c_{42} c_{55})})) (S (I^{[x_{99},x_{98},x_{97} := c_{51},(c_{57} c_{44} (c_{54} c_{43} c_{42})),(c_{57} (c_{54} c_{51} c_{51}) (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (S (L^{\\lambda x_{122}.c_{55} c_{51} x_{122}} (I^{[x_{99},x_{97},x_{98} := c_{44},(c_{54} c_{43} c_{42}),(c_{54} c_{51} c_{51})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})}))) (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} (c_{55} c_{44} x_{122}) (c_{54} c_{43} c_{42}))} (I^{[x_{98},x_{97} := c_{51},c_{51}]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} x_{122} (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{98},x_{97} := c_{44},c_{51},(c_{57} c_{51} (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})})) (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} (c_{55} (c_{55} x_{122} c_{51}) (c_{57} c_{51} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} A^{= (c_{55} c_{43} c_{43}) c_{44}}) (S (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} (c_{55} x_{122} (c_{57} c_{51} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{98},x_{97} := c_{43},c_{43},c_{51}]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}))) (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} (c_{55} (c_{55} c_{43} x_{122}) (c_{57} c_{51} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} A^{= (c_{54} c_{43} c_{42}) (c_{55} c_{43} c_{51})}) (S (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} x_{122} (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{98},x_{97} := c_{43},(c_{54} c_{43} c_{42}),(c_{57} c_{51} (c_{54} c_{43} c_{42}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}))) (S (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} (c_{55} c_{43} (c_{55} x_{122} (c_{57} c_{51} (c_{54} c_{43} c_{42})))) (c_{54} c_{43} c_{42}))} (I^{[x_{97} := (c_{54} c_{43} c_{42})]} A^{= \\Phi_{} (\\Phi_{b} (c_{57} c_{43}))}))) (S (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} (c_{55} c_{43} x_{122}) (c_{54} c_{43} c_{42}))} (I^{[x_{99},x_{97},x_{98} := c_{43},(c_{54} c_{43} c_{42}),c_{51}]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})}))) (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} (c_{55} c_{43} (c_{57} x_{122} (c_{54} c_{43} c_{42}))) (c_{54} c_{43} c_{42}))} A^{= (c_{54} c_{43} c_{42}) (c_{55} c_{43} c_{51})}) (S (L^{\\lambda x_{122}.c_{55} c_{51} (c_{57} x_{122} (c_{54} c_{43} c_{42}))} (I^{[x_{98},x_{97} := c_{43},(c_{54} c_{43} c_{42})]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}))) (S (I^{[x_{98},x_{97} := c_{51},(c_{54} (c_{54} c_{43} c_{42}) c_{43})]} A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}))	SS
566	689	t	S (S (L^{\\lambda x_{122}.c_{2} x_{122} (c_{1} x_{102} x_{101})} (I^{[x_{112} := (c_{2} (x_{69} x_{101}) (x_{69} x_{102}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) (L^{\\lambda x_{122}.c_{2} x_{122} (c_{1} x_{102} x_{101})} (I^{[x_{112},x_{113} := (c_{2} (x_{69} x_{101}) (x_{69} x_{102})),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{2} (c_{5} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) x_{122}) (c_{1} x_{102} x_{101})} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})})))) (S (L^{\\lambda x_{122}.c_{2} (c_{5} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{2} x_{122} (c_{1} x_{102} x_{101}))) (c_{1} x_{102} x_{101})} (I^{[x_{113},x_{112} := (x_{69} x_{102}),(x_{69} x_{101})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}))) (L^{\\lambda x_{122}.c_{2} (c_{5} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) x_{122}) (c_{1} x_{102} x_{101})} (I^{[x_{113},x_{112} := (c_{5} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{2} (x_{69} x_{102}) (x_{69} x_{101}))),(c_{1} x_{102} x_{101})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{2} (c_{5} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) x_{122}) (c_{1} x_{102} x_{101})} (I^{[x_{114},x_{112},x_{113} := (c_{2} (x_{69} x_{101}) (x_{69} x_{102})),(c_{7} (c_{1} x_{102} x_{101})),(c_{2} (x_{69} x_{102}) (x_{69} x_{101}))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (I^{[x_{113},x_{112} := (c_{5} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101}))))),(c_{1} x_{102} x_{101})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (I^{[x_{114},x_{112},x_{113} := (c_{2} (x_{69} x_{101}) (x_{69} x_{102})),(c_{7} (c_{1} x_{102} x_{101})),(c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101}))))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) x_{122}} (I^{[x_{114},x_{112},x_{113} := (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))),(c_{7} (c_{1} x_{102} x_{101})),(c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101})))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{5} (c_{4} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{7} (c_{1} x_{102} x_{101}))) x_{122})} (I^{[x_{114},x_{113},x_{112} := (c_{2} (x_{69} x_{102}) (x_{69} x_{101})),(c_{7} (c_{1} x_{102} x_{101})),(c_{7} (c_{1} x_{102} x_{101}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{5} (c_{4} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{7} (c_{1} x_{102} x_{101}))) (c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) x_{122}))} (I^{[x_{112} := (c_{7} (c_{1} x_{102} x_{101}))]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{5} x_{122} (c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101}))))} (I^{[x_{114},x_{113},x_{112} := (c_{2} (x_{69} x_{101}) (x_{69} x_{102})),(c_{7} (c_{1} x_{102} x_{101})),(c_{7} (c_{1} x_{102} x_{101}))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))) (c_{5} (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) x_{122}) (c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101}))))} (I^{[x_{112} := (c_{7} (c_{1} x_{102} x_{101}))]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{4})})) (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))),(c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101}))),(c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101})))]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{5}) c_{5}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{5})}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} (c_{2} (x_{69} x_{102}) (x_{69} x_{101})) (c_{7} (c_{1} x_{102} x_{101})))} (I^{[x_{112} := (c_{4} (c_{2} (x_{69} x_{101}) (x_{69} x_{102})) (c_{7} (c_{1} x_{102} x_{101})))]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})})) (S (I^{[x_{114},x_{112},x_{113} := (c_{2} (x_{69} x_{101}) (x_{69} x_{102})),(c_{7} (c_{1} x_{102} x_{101})),(c_{2} (x_{69} x_{102}) (x_{69} x_{101}))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})})) (L^{\\lambda x_{122}.c_{4} x_{122} (c_{7} (c_{1} x_{102} x_{101}))} (I^{[x_{113},x_{112} := (x_{69} x_{102}),(x_{69} x_{101})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})})) (S (I^{[x_{113},x_{112} := (c_{1} (x_{69} x_{102}) (x_{69} x_{101})),(c_{1} x_{102} x_{101})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))) A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccb,)} c_{1} c_{1} (\\Phi_{(bbb,b)} c_{2}) \\Phi_{(cbbb,b)})}	DM
407	533	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))} (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := x_{112},(c_{5} (c_{2} x_{112} x_{113}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (I^{[x_{112} := (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} x_{112} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))} (S (M_{3} (S (I^{[x_{112},x_{113} := (c_{5} (c_{2} x_{112} x_{113}) x_{112}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (I^{[x_{112},x_{113} := x_{112},(c_{5} (c_{2} x_{112} x_{113}) x_{112})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{2} c_{7}) (\\Phi_{cb} c_{2} \\Phi_{cb})}) (S (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}))) (S (I^{[x_{112},x_{113} := (c_{7} x_{112}),(c_{7} (c_{5} (c_{2} x_{112} x_{113}) x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})} (L^{\\lambda x_{122}.c_{2} (c_{7} x_{112}) (c_{7} (c_{5} x_{122} x_{112}))} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{2} (c_{7} x_{112}) (c_{7} (c_{5} x_{122} x_{112}))} (I^{[x_{112},x_{113} := (c_{7} x_{113}),x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{7} x_{112}) (c_{7} x_{122})} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{b} \\Phi_{K}) (\\Phi_{c(cb,)} c_{4} c_{5} \\Phi_{cbcb})})) (I^{[x_{112} := (c_{7} x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})})) A^{= T c_{8}}))))) (S (L^{\\lambda x_{122}.c_{2} x_{112} (c_{5} x_{122} x_{112})} (I^{[x_{113},x_{112} := x_{112},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (I^{[x_{113} := (c_{4} x_{112} (c_{7} x_{113}))]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})}))))	EO (MI (AI DM (CR DM)))
593	743	t	S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{85}.x_{-126})} (M_{3} (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{65}.x_{-126})} (M_{3} (S (L^{\\lambda x_{-126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{66}.x_{-126})} (M_{3} (S (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{115},x_{82},x_{81},x_{80} := (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}),(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{1} (c_{5} (x_{80} x_{120} x_{85}) (c_{16} x_{85} x_{120})) (c_{16} x_{66} x_{120})),(\\lambda x_{120}.c_{1} (c_{5} (x_{80} x_{120} x_{85}) (c_{16} x_{85} x_{120})) (c_{16} x_{65} x_{120}))]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} (c_{1} (c_{5} (x_{80} x_{120} x_{85}) (c_{16} x_{85} x_{120})) (c_{16} x_{66} x_{120})) x_{122}))} (I^{[x_{112},x_{113} := (c_{16} x_{65} x_{120}),(c_{5} (x_{80} x_{120} x_{85}) (c_{16} x_{85} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.x_{122}))} (I^{[x_{113},x_{114},x_{112} := (c_{16} x_{65} x_{120}),(c_{16} x_{66} x_{120}),(c_{5} (x_{80} x_{120} x_{85}) (c_{16} x_{85} x_{120}))]} A^{= (\\Phi_{(ccbb,b)} c_{5} \\Phi_{bb} \\Phi_{cbbb} c_{1} c_{1}) (\\Phi_{ccbb} (\\Phi_{(bcb,b)} c_{5}) c_{1} \\Phi_{ccb} c_{1})})) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{5} x_{122} (c_{1} (c_{16} x_{65} x_{120}) (c_{5} (x_{80} x_{120} x_{85}) (c_{16} x_{85} x_{120})))))} (I^{[x_{112},x_{113} := (c_{16} x_{66} x_{120}),(c_{16} x_{65} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{115},x_{82},x_{81},x_{80} := (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}),(\\lambda x_{120}.c_{8}),(\\lambda x_{120}.c_{1} (c_{16} x_{66} x_{120}) (c_{16} x_{65} x_{120})),(\\lambda x_{120}.c_{1} (c_{16} x_{65} x_{120}) (c_{5} (x_{80} x_{120} x_{85}) (c_{16} x_{85} x_{120})))]} A^{= (\\Phi_{c(ccbb,b)} \\Phi_{b} \\Phi_{bb} \\Phi_{bb} \\Phi_{cbbbb} \\Phi_{(bb,b)} c_{62}) (\\Phi_{c(c(ccb,b),b)} \\Phi_{b} \\Phi_{b} (\\Phi_{ccbbbb} \\Phi_{b}) \\Phi_{bbb} (\\Phi_{c(ccbbb,bb)} \\Phi_{b}) c_{62} c_{62})}))) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) (c_{5} x_{122} (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{86}.c_{8}) (\\lambda x_{86}.c_{1} (c_{16} x_{65} x_{86}) (c_{5} (x_{80} x_{86} x_{85}) (c_{16} x_{85} x_{86})))))} A^{= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{1}) c_{16})}) (L^{\\lambda x_{122}.c_{2} (c_{15} x_{66} x_{65}) x_{122}} (I^{[x_{112},x_{113} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{86}.c_{8}) (\\lambda x_{86}.c_{1} (c_{16} x_{65} x_{86}) (c_{5} (x_{80} x_{86} x_{85}) (c_{16} x_{85} x_{86})))),(c_{15} x_{66} x_{65})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})})) (I^{[x_{112},x_{113} := (c_{15} x_{66} x_{65}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{86}.c_{8}) (\\lambda x_{86}.c_{1} (c_{16} x_{65} x_{86}) (c_{5} (x_{80} x_{86} x_{85}) (c_{16} x_{85} x_{86}))))]} (M_{3} (A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})})))) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}}	GE (GE (GE DM))
391	472	t	L^{\\lambda x_{126}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.x_{126})} (I^{[x_{113},x_{112} := (c_{15} x_{120} x_{120}),(c_{15} x_{121} x_{122})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{126}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.x_{126})} (I^{[x_{112},x_{113} := (c_{7} (c_{15} x_{121} x_{122})),(c_{15} x_{120} x_{120})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (I^{[x_{82},x_{81},x_{80} := (\\lambda x_{122}.c_{8}),(\\lambda x_{122}.c_{7} (c_{15} x_{121} x_{122})),(c_{15} x_{120} x_{120})]} A^{= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) (I^{[x_{112},x_{113} := (c_{15} x_{120} x_{120}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{7} (c_{15} x_{121} x_{122})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) (S (L^{\\lambda x_{126}.c_{4} (c_{15} x_{120} x_{120}) x_{126}} (I^{[x_{112} := (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{7} (c_{15} x_{121} x_{122})))]} A^{= \\Phi_{} (\\Phi_{bb} c_{7} c_{7})}))) (S (L^{\\lambda x_{126}.c_{4} (c_{15} x_{120} x_{120}) (c_{7} x_{126})} (I^{[x_{82},x_{80} := (\\lambda x_{122}.c_{8}),(\\lambda x_{122}.c_{15} x_{121} x_{122})]} A^{= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})}))) (S (I^{[x_{113},x_{112} := (c_{15} x_{120} x_{120}),(c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{4} x_{120} x_{121}) (\\lambda x_{122}.c_{8}) (\\lambda x_{122}.c_{15} x_{121} x_{122}))]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (S (L^{\\lambda x_{126}.c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\lambda x_{122}.x_{126})} (M_{3} (S (S (L^{\\lambda x_{119}.c_{2} x_{119} (c_{15} x_{121} x_{122})} (I^{[x_{113} := x_{120}]} A^{= (\\Phi_{(b,)} c_{15}) (\\Phi_{K} c_{8})})) (I^{[x_{112} := (c_{15} x_{121} x_{122})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) A^{= T c_{8}})) (I^{[x_{82} := (\\lambda x_{120}.c_{8})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})})) A^{= T c_{8}})	WI DM
371	526	t	I^{[x_{113},x_{112} := x_{112},c_{8}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (S (L^{\\lambda x_{122}.c_{4} x_{112} x_{122}} A^{= (c_{7} c_{8}) c_{9}})) (I^{[x_{112},x_{113} := c_{9},x_{112}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}) A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))}	SS
594	744	t	M_{4} (I^{[x_{69},x_{101},x_{102} := (\\lambda x_{-126}.c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) x_{-126}),(c_{5} (c_{5} (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{17} c_{18} x_{120})) (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{16} c_{18} x_{120}))) (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))),(c_{5} (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120})) (c_{1} c_{9} (c_{16} c_{18} x_{120})))]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))} (M_{1}^{1} (L^{\\lambda x_{-126}.c_{5} (c_{5} (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{17} c_{18} x_{120})) x_{-126}) (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))} (I^{[x_{113},x_{112} := (c_{1} c_{9} (c_{16} c_{18} x_{120})),(c_{16} c_{18} x_{120})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} (c_{16} c_{18} x_{120})),(c_{1} c_{9} (c_{16} c_{18} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{-126}.c_{5} (c_{5} x_{-126} (c_{4} (c_{7} (c_{16} c_{18} x_{120})) (c_{1} c_{9} (c_{16} c_{18} x_{120})))) (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))} (I^{[x_{113},x_{112} := (c_{1} c_{9} (c_{16} c_{18} x_{120})),(c_{17} c_{18} x_{120})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (I^{[x_{112},x_{113} := (c_{7} (c_{17} c_{18} x_{120})),(c_{1} c_{9} (c_{16} c_{18} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})}))) (L^{\\lambda x_{-126}.c_{5} x_{-126} (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))} (S (I^{[x_{114},x_{112},x_{113} := (c_{7} (c_{17} c_{18} x_{120})),(c_{1} c_{9} (c_{16} c_{18} x_{120})),(c_{7} (c_{16} c_{18} x_{120}))]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}) (S (L^{\\lambda x_{-126}.c_{4} x_{-126} (c_{1} c_{9} (c_{16} c_{18} x_{120}))} (I^{[x_{113},x_{112} := (c_{17} c_{18} x_{120}),(c_{16} c_{18} x_{120})]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})}))))) (L^{\\lambda x_{-126}.c_{5} x_{-126} (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))} (I^{[x_{112},x_{113} := (c_{1} c_{9} (c_{16} c_{18} x_{120})),(c_{7} (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120})))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (I^{[x_{113},x_{112} := (c_{1} c_{9} (c_{16} c_{18} x_{120})),(c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cbb} c_{7} (\\Phi_{(bbb,)} c_{5}) c_{4})}) (I^{[x_{112},x_{113} := (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120})),(c_{1} c_{9} (c_{16} c_{18} x_{120}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}))) (I^{[x_{112},x_{113} := (c_{1} c_{9} (c_{16} c_{18} x_{120})),(c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))]} A^{= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})}) (S (I^{[x_{112} := (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))} (S (M_{3} (S (I^{[x_{112} := (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{16} c_{18} x_{120}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{16} c_{18} x_{120}))} (S (M_{3} (S (S (L^{\\lambda x_{122}.c_{2} x_{122} (c_{17} c_{18} x_{120})} (I^{[x_{112} := (c_{16} c_{18} x_{120})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (S (L^{\\lambda x_{122}.c_{2} x_{122} (c_{17} c_{18} x_{120})} (I^{[x_{65} := c_{18}]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})}))) (I^{[x_{112} := (c_{17} c_{18} x_{120})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})})) A^{= T c_{8}})))) (S (I^{[x_{114},x_{112},x_{113} := c_{9},(c_{16} c_{18} x_{120}),(c_{16} c_{18} x_{120})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{1}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{2} \\Phi_{ccb} c_{1})} (L^{\\lambda x_{122}.c_{1} (c_{5} c_{9} (c_{16} c_{18} x_{120})) x_{122}} (I^{[x_{112} := (c_{16} c_{18} x_{120})]} A^{= \\Phi_{} (\\Phi_{(b,)} c_{5})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{16} c_{18} x_{120})} (I^{[x_{112} := (c_{16} c_{18} x_{120})]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{5} c_{9}))})) (S (I^{[x_{112} := (c_{16} c_{18} x_{120})]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (S (I^{[x_{65} := c_{18}]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})}))) A^{= (\\Phi_{K} T) (\\Phi_{b} (c_{17} c_{18}))}))))) (S (L^{\\lambda x_{122}.c_{4} x_{122} (c_{16} c_{18} x_{120})} (I^{[x_{65} := c_{18}]} A^{= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})})) (I^{[x_{112} := (c_{16} c_{18} x_{120})]} A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))))	EO (CA (AI DM (AI DM DM))):c_{5} (c_{5} (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{17} c_{18} x_{120})) (c_{2} (c_{1} c_{9} (c_{16} c_{18} x_{120})) (c_{16} c_{18} x_{120}))) (c_{4} (c_{17} c_{18} x_{120}) (c_{16} c_{18} x_{120}))
595	745	t	L^{\\lambda x_{122}.c_{1} (c_{5} (c_{7} x_{113}) x_{112}) x_{122}} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})} (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} (c_{4} x_{113} x_{112}) (c_{1} x_{113} x_{112}))} (I^{[x_{113} := (c_{7} x_{113})]} A^{= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{1}) c_{4} c_{1}) (\\Phi_{bb} \\Phi_{b} c_{5})})) (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{1} (c_{7} x_{113}) x_{112})),(c_{4} x_{113} x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}) (S (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{113} x_{112})} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{7} x_{113}) x_{112}),(c_{1} (c_{7} x_{113}) x_{112}),(c_{4} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})}))) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) x_{122}) (c_{1} x_{113} x_{112})} (I^{[x_{112},x_{113} := (c_{4} x_{113} x_{112}),(c_{1} (c_{7} x_{113}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} x_{122} (c_{1} x_{113} x_{112})} (I^{[x_{114},x_{113},x_{112} := (c_{4} (c_{7} x_{113}) x_{112}),(c_{4} x_{113} x_{112}),(c_{1} (c_{7} x_{113}) x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (I^{[x_{114},x_{113},x_{112} := (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112})),(c_{1} (c_{7} x_{113}) x_{112}),(c_{1} x_{113} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112})) (c_{1} x_{122} (c_{1} x_{113} x_{112}))} A^{= (\\Phi_{bbb} \\Phi_{b} c_{1} c_{7}) (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1})})) (S (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112})) (c_{1} x_{122} (c_{1} x_{113} x_{112}))} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{1}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{1})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112})) x_{122}} (I^{[x_{112},x_{113} := (c_{1} x_{113} x_{112}),(c_{7} (c_{1} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{1} (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112})) x_{122}} (I^{[x_{112} := (c_{1} x_{113} x_{112})]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})})) (I^{[x_{112},x_{113} := c_{9},(c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (S (I^{[x_{112} := (c_{1} (c_{4} (c_{7} x_{113}) x_{112}) (c_{4} x_{113} x_{112}))]} A^{= (\\Phi_{b} (c_{1} c_{9})) (\\Phi_{b} c_{7})})) (S (L^{\\lambda x_{122}.c_{7} x_{122}} (I^{[x_{114} := (c_{7} x_{113})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})}))) (L^{\\lambda x_{122}.c_{7} (c_{4} x_{122} x_{112})} (I^{[x_{112},x_{113} := x_{113},(c_{7} x_{113})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{7} (c_{4} x_{122} x_{112})} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})})) (L^{\\lambda x_{122}.c_{7} x_{122}} A^{= \\Phi_{} (\\Phi_{b} (c_{4} c_{9}))})	SS
596	746	f	c_{5} x_{113} x_{112}	WE
363	523	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))} (I^{[x_{112},x_{113} := (c_{4} (c_{2} x_{113} x_{112}) x_{112}),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := c_{8},(c_{4} (c_{2} x_{113} x_{112}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (L^{\\lambda x_{122}.c_{5} (c_{3} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112})) x_{122}} (I^{[x_{112} := (c_{4} (c_{2} x_{113} x_{112}) x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} c_{8}} (I^{[x_{112},x_{113} := (c_{4} (c_{2} x_{113} x_{112}) x_{112}),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{2} (c_{4} x_{122} x_{112}) c_{8}) c_{8}} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (S (L^{\\lambda x_{122}.c_{5} (c_{2} x_{122} c_{8}) c_{8}} (I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{5} (c_{2} (c_{4} x_{113} x_{122}) c_{8}) c_{8}} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (L^{\\lambda x_{122}.c_{5} (c_{2} x_{122} c_{8}) c_{8}} (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{2} x_{122} c_{8}) c_{8}} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) (L^{\\lambda x_{122}.c_{5} x_{122} c_{8}} (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) (I^{[x_{112} := c_{8}]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))})) A^{= T c_{8}}))	EO (MI DM)
364	523	t	M_{4} (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))} (I^{[x_{112},x_{113} := (c_{4} (c_{2} x_{113} x_{112}) x_{112}),c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{113},x_{112} := c_{8},(c_{4} (c_{2} x_{113} x_{112}) x_{112})]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(cb,b)} c_{2} (\\Phi_{(bcb,b)} c_{5}) c_{2})}) (S (I^{[x_{112} := (c_{2} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))]} A^{= \\Phi_{} (\\Phi_{b} (c_{5} c_{8}))}) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{2} c_{8} (c_{4} (c_{2} x_{113} x_{112}) x_{112}))} (S (M_{3} (S (L^{\\lambda x_{122}.c_{3} c_{8} (c_{4} x_{122} x_{112})} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (S (L^{\\lambda x_{122}.c_{3} c_{8} x_{122}} (I^{[x_{114},x_{113} := x_{113},(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}))) (L^{\\lambda x_{122}.c_{3} c_{8} (c_{4} x_{113} x_{122})} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})}))) (L^{\\lambda x_{122}.c_{3} c_{8} x_{122}} (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{3} c_{8} x_{122}} (I^{[x_{112} := x_{113}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{4} c_{8}))})) (I^{[x_{112},x_{113} := c_{8},c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{cb} c_{3} \\Phi_{cb})}) (I^{[x_{112} := c_{8}]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))})) A^{= T c_{8}})))) (S (I^{[x_{112} := (c_{4} (c_{2} x_{113} x_{112}) x_{112})]} A^{= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))}) A^{= T c_{8}})))	EO (MI (AI DM DM))
516	643	f	L^{\\lambda x_{122}.c_{5} (c_{5} (c_{2} x_{80} x_{68}) x_{122}) (c_{4} x_{68} x_{67})} (I^{[x_{113},x_{112} := x_{80},x_{67}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{4} x_{80} (c_{7} x_{67}))) (c_{4} x_{68} x_{67})} (I^{[x_{113},x_{112} := x_{80},x_{68}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})})) (L^{\\lambda x_{122}.c_{5} (c_{5} (c_{4} x_{80} (c_{7} x_{68})) x_{122}) (c_{4} x_{68} x_{67})} (I^{[x_{112},x_{113} := (c_{7} x_{67}),x_{80}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (L^{\\lambda x_{122}.c_{5} (c_{5} x_{122} (c_{4} (c_{7} x_{67}) x_{80})) (c_{4} x_{68} x_{67})} (I^{[x_{112},x_{113} := (c_{7} x_{68}),x_{80}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} x_{68} x_{67})} (I^{[x_{114},x_{112},x_{113} := (c_{7} x_{68}),x_{80},(c_{7} x_{67})]} A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{5}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{5})}))) (L^{\\lambda x_{122}.c_{5} x_{122} (c_{4} x_{68} x_{67})} (I^{[x_{112},x_{113} := x_{80},(c_{5} (c_{7} x_{68}) (c_{7} x_{67}))]} A^{= (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{cb} c_{4} \\Phi_{cb})})) (S (L^{\\lambda x_{122}.c_{5} (c_{4} x_{80} x_{122}) (c_{4} x_{68} x_{67})} (I^{[x_{113},x_{112} := x_{68},x_{67}]} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{5} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{4})})))	SS
517	644	t	I^{[x_{113},x_{112} := x_{114},(c_{5} x_{113} x_{112})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})} (L^{\\lambda x_{122}.c_{4} x_{114} x_{122}} A^{= (\\Phi_{cbbb} c_{7} \\Phi_{bb} c_{4} c_{7}) (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{5})}) (I^{[x_{113},x_{112} := (c_{7} x_{113}),(c_{7} x_{112})]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{4}) c_{4}) (\\Phi_{cbbb} c_{4} \\Phi_{bb} \\Phi_{bb} c_{4})}) (S (L^{\\lambda x_{122}.c_{4} x_{122} (c_{7} x_{112})} (I^{[x_{113},x_{112} := x_{114},x_{113}]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))) (S (I^{[x_{113} := (c_{2} x_{114} x_{113})]} A^{= (\\Phi_{cbb} c_{7} \\Phi_{bb} c_{4}) (\\Phi_{bb} \\Phi_{b} c_{2})}))	SS
\.


--
-- Name: solucion_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.solucion_id_seq', 599, true);


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
113	= (\\Phi_{K} T) (\\Phi_{(b(bbb,cccbbb),b)} c_{2} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} c_{16} c_{16} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbbb} \\Phi_{b} c_{17} (c_{59} c_{18}))	f		103	16,17,59,18
123	= (\\Phi_{ccbbbb} (\\Phi_{(bb,(bb,b))} c_{1}) c_{5} \\Phi_{(b,cb)} \\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cb} (\\Phi_{(bb,b)} c_{5}) (\\Phi_{cbbcb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}))))	f		110	
147	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{ccccc(bcbbb,cbbb)} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{bcb} \\Phi_{c(bbbb,bb)} \\Phi_{b} \\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} \\Phi_{cb} (\\Phi_{(bbcb,bb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		128	
156	= (\\Phi_{(bccbbbb,bb)} c_{19} \\Phi_{cb} c_{16} \\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} c_{16} \\Phi_{K} c_{22}) (\\Phi_{b} c_{23})	f		148	19,16,22,23
210	= (\\Phi_{bb} (\\Phi_{cbbbb} c_{15} \\Phi_{bb} \\Phi_{bb} c_{5}) c_{15}) (\\Phi_{ccccbb} c_{31} \\Phi_{cbbb} \\Phi_{bb} c_{15} \\Phi_{cccbb} c_{31})	f		170	31
186	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{16} \\Phi_{bcb} c_{5}) c_{17}) (\\Phi_{ccbb} \\Phi_{cbb} c_{16} \\Phi_{ccb} c_{30})	f		192	16,17,30
126	= (\\Phi_{bbbb} \\Phi_{b} c_{4} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bb} c_{7})) (\\Phi_{cbbb} \\Phi_{K} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		196	
167	= (\\Phi_{(ccccccbbb,b)} c_{35} c_{35} \\Phi_{K} c_{16} (\\Phi_{bcccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) c_{5} (\\Phi_{(bcccbb,bbbb)} c_{19} (\\Phi_{bc(ccbbb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{31} c_{15})) (\\Phi_{(bb,bcbcb)} c_{5}) c_{16} c_{24}) (\\Phi_{bb} \\Phi_{b} c_{32})	f		200	35,16,19,31,24,32
82	= (\\Phi_{K} c_{8}) (\\Phi_{cb} c_{9} c_{2})	f		3	
83	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{4})	f		4	
84	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(bb,)} c_{5} \\Phi_{bcb} c_{2})	f		5	
85	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{2}) c_{4} c_{5})	f		6	
141	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(c(bbb,ccbbb),bb)} \\Phi_{b} c_{4} (\\Phi_{cc(cbbbb,)} \\Phi_{cbb} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} c_{1} c_{2} \\Phi_{cb(bb,bccb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		7	
142	= (\\Phi_{K} c_{9}) (\\Phi_{cbb} (\\Phi_{K} c_{9}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		8	
143	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) (\\Phi_{(bbb,bb)} c_{2}) \\Phi_{b} (\\Phi_{cccbbb} \\Phi_{b}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} (\\Phi_{(bb,b)} c_{4}))	f		9	
146	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bbbb,)} \\Phi_{bb} c_{2} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b})	f		10	
194	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c((cbbb,bbbb),)} c_{27} c_{23} (\\Phi_{(bbb,bcb)} c_{2}) c_{27} c_{23} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b} c_{16})	f		11	27,23,16
192	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{24} \\Phi_{bcb} c_{25}) c_{24}) (\\Phi_{ccbb} \\Phi_{cbb} c_{24} \\Phi_{ccb} c_{25})	f		12	24,25
198	= c_{18} (c_{23} (c_{20} c_{18}))	f		13	18,23,20
234	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(bcb,b)} (\\Phi_{(cb,b)} c_{5}) c_{5} (\\Phi_{b(ccccb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(b(b(bb,b),b),(bb,(bb,b)))} c_{1} c_{5} c_{5}))	f		14	
118	= (\\Phi_{bcb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) c_{7} (\\Phi_{(bb,bb)} c_{4})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbb} \\Phi_{b})	f		15	
122	= (\\Phi_{ccbbbb} (\\Phi_{(bb,bb)} c_{4}) c_{7} \\Phi_{bcb} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cccb} \\Phi_{b} \\Phi_{cbcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) (\\Phi_{cccbb} (\\Phi_{(bb,b)} c_{5})))	f		16	
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
112	= (\\Phi_{K} T) (\\Phi_{bcbccbbbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) \\Phi_{cb} c_{16} (\\Phi_{(bbcb,b)} c_{1}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} c_{16})	f		104	16
114	= T (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}) (\\Phi_{(bb(ccbb,b),cb)} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{20} c_{24} (\\Phi_{(bb(bb,),b)} c_{2}) c_{16} c_{16} c_{18} c_{16}))	f		105	20,24,16,18
117	= (\\Phi_{bb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbb} \\Phi_{b})	f		106	
98	= (\\Phi_{cb} c_{15} (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2})) (\\Phi_{cbb} c_{15} \\Phi_{bb} (\\Phi_{(bb,b)} c_{2}))	f		107	
119	= (\\Phi_{(b,cb)} (\\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) c_{5} (\\Phi_{(bb,(bb,b))} c_{1})) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		108	
120	= (\\Phi_{b(cb,)} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) c_{4} (\\Phi_{(bb,(bb,b))} c_{1})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{cbb} \\Phi_{b})	f		109	
124	= (\\Phi_{ccbbbb} (\\Phi_{(bb,(bb,b))} c_{1}) c_{4} \\Phi_{b(cb,)} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cccb} \\Phi_{b} \\Phi_{cbcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) (\\Phi_{cccbb} (\\Phi_{(bb,b)} c_{5})))	f		111	
125	= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{4}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{4}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		112	
128	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cc(cbbb,bb),bb)} (\\Phi_{(bb,b)} c_{1}) \\Phi_{b} c_{1} (\\Phi_{(bbbb,bb)} c_{2}) \\Phi_{b} \\Phi_{(cccbbbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		113	
129	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cccb,bb)} \\Phi_{b} \\Phi_{b} c_{2} \\Phi_{bcbcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) (\\Phi_{ccc(bbbb,b)} (\\Phi_{(bb,b)} c_{4})) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		114	
108	= T (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}) (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bb} c_{7}) c_{16}))	f		115	16
116	= (\\Phi_{K} c_{8}) (\\Phi_{cbb} (\\Phi_{K} c_{8}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		116	
10	= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})	f		117	
74	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{(cb,b)} c_{5} \\Phi_{cbb} c_{2})	f		118	
75	= (\\Phi_{K} (\\Phi_{K} c_{8})) (\\Phi_{bb} (\\Phi_{(bb,)} c_{4}) c_{2})	f		119	
76	= (\\Phi_{bb} \\Phi_{b} c_{2}) (\\Phi_{(cb,b)} c_{4} \\Phi_{cbb} c_{2})	f		120	
77	= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{2}) c_{5} c_{4})	f		121	
78	= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{2})	f		122	
79	= (\\Phi_{K} c_{8}) (\\Phi_{b} (c_{2} c_{8}))	f		123	
80	= \\Phi_{} (\\Phi_{cb} c_{8} c_{2})	f		124	
81	= (\\Phi_{b} c_{7}) (\\Phi_{b} (c_{2} c_{9}))	f		125	
144	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(bbb,bbb)} (\\Phi_{(bb,b)} c_{4}) (\\Phi_{ccbb} \\Phi_{b}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} (\\Phi_{(bbb,bb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		126	
145	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cc(cbbb,bb),bb)} (\\Phi_{(bb,b)} c_{2}) \\Phi_{b} c_{2} (\\Phi_{(bbbb,bb)} c_{2}) \\Phi_{b} \\Phi_{(cccbbbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		127	
153	= (\\Phi_{ccbbbb} \\Phi_{cb} c_{16} \\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} c_{16}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{22})	f		129	16,22
148	= (\\Phi_{bb} (\\Phi_{bb} c_{7}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{17})	f		130	16,17
151	= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{20})	f		131	16,20
152	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{16} \\Phi_{bcb} c_{4}) c_{16}) (\\Phi_{cccbb} \\Phi_{cbbb} c_{16} c_{20} \\Phi_{cccb} c_{21})	f		132	16,20,21
149	= (\\Phi_{K} T) (\\Phi_{b} (c_{17} c_{18}))	f		133	17,18
154	= (\\Phi_{bb} (\\Phi_{bbb} c_{22} c_{20}) c_{21}) (\\Phi_{bb} \\Phi_{b} c_{24})	f		134	22,20,21,24
155	= (\\Phi_{(ccbbb,b)} \\Phi_{K} c_{16} (\\Phi_{(bbb,bb)} c_{19}) (\\Phi_{(bb,b)} c_{5}) c_{16} c_{24}) (\\Phi_{bb} \\Phi_{b} c_{25})	f		135	16,19,24,25
157	= (\\Phi_{ccbbb} \\Phi_{K} c_{16} (\\Phi_{(bbb,b)} c_{19}) (\\Phi_{(bb,b)} c_{5}) c_{17}) (\\Phi_{bb} \\Phi_{b} c_{30})	f		136	16,19,17,30
165	= T (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b} c_{17}))	f		137	17
159	= (\\Phi_{bb} \\Phi_{b} c_{27}) (\\Phi_{cb} c_{29} \\Phi_{cb})	f		138	27,29
160	= (\\Phi_{(bb,b)} (\\Phi_{(bb,b)} c_{5}) c_{59} c_{27}) (\\Phi_{bb} \\Phi_{b} c_{26})	f		139	59,27,26
161	= (\\Phi_{bb} \\Phi_{b} c_{26}) (\\Phi_{cb} c_{28} \\Phi_{cb})	f		138	26,28
162	= (\\Phi_{cbb} c_{20} (\\Phi_{b(bbb,b)} c_{20} c_{21} c_{20}) c_{21}) (\\Phi_{bb} \\Phi_{b} c_{31})	f		140	20,21,31
163	= (\\Phi_{bb} \\Phi_{b} c_{27}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{35})	f		141	27,16,35
164	= (\\Phi_{(bb,)} c_{24} c_{20}) (\\Phi_{b} c_{52})	f		142	24,20,52
170	= (\\Phi_{bb} (\\Phi_{(bb,)} c_{2}) c_{5}) (\\Phi_{bb} \\Phi_{b} c_{2})	f		143	
150	= (\\Phi_{b} (\\Phi_{c(bb,)} c_{16} (\\Phi_{(bb,cb)} c_{5}))) (\\Phi_{cccb} \\Phi_{cb(bcb,b)} c_{16} c_{19} (\\Phi_{cccccb} \\Phi_{K} \\Phi_{cb}))	f		144	16,19
131	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cc(cbbb,bb),bb)} (\\Phi_{(bb,b)} c_{2}) \\Phi_{b} c_{2} (\\Phi_{(bbbb,bb)} c_{2}) \\Phi_{b} \\Phi_{(cccbbbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		145	
133	= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		146	
169	= (\\Phi_{K} c_{9}) (\\Phi_{(b,b)} c_{1} c_{7})	f		147	
134	= (\\Phi_{cbbb} \\Phi_{b} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		149	
135	= (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		150	
136	= (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cbbb} (\\Phi_{bb} c_{7}) \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		151	
137	= (\\Phi_{bb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{cbb} \\Phi_{b})	f		152	
138	= (\\Phi_{cbbbb} (\\Phi_{(bb,b)} c_{5}) \\Phi_{bb} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b}) (\\Phi_{cccb} \\Phi_{b} \\Phi_{cbcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) (\\Phi_{cccbb} (\\Phi_{(bb,b)} c_{5})))	f		153	
139	= (\\Phi_{bbbb} (\\Phi_{ccb} \\Phi_{cbb} c_{5}) \\Phi_{bccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{b} (\\Phi_{bbbb} \\Phi_{b} c_{5}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		154	
140	= (\\Phi_{bbbb} \\Phi_{b} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b}) (\\Phi_{cbbb} \\Phi_{K} \\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b})	f		155	
132	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(cbbb,)} c_{2} \\Phi_{cbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) \\Phi_{b})	f		156	
193	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(ccbbb,b)} (c_{59} c_{18}) c_{5} \\Phi_{b(bb,b)} c_{2} (c_{59} c_{18}) c_{27})	f		157	59,18,27
195	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(cc(ccbbb,b),)} c_{27} (c_{59} c_{18}) c_{5} c_{5} c_{23} (\\Phi_{(bbb,(bcbb,cb))} c_{2}) c_{27} c_{23} (c_{59} c_{18}))	f		158	27,59,18,23
196	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(bbb,b)} \\Phi_{bb} c_{2} (c_{59} c_{18}) c_{16})	f		159	59,18,16
197	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cc(cccccbb,b)} c_{16} c_{23} (c_{15} c_{18}) c_{2} \\Phi_{b(bbb,b)} c_{5} (c_{15} c_{18}) \\Phi_{(cccbbbbb,b)} c_{25} c_{25})	f		160	16,23,18,25
199	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{bb} (\\Phi_{bbb} (c_{59} c_{18}) c_{20}) c_{21})	f		161	59,18,20,21
200	= (\\Phi_{bb} \\Phi_{b} c_{25}) (\\Phi_{bb} (\\Phi_{bbb} c_{23} c_{20}) c_{21})	f		162	25,23,20,21
201	= (\\Phi_{K} T) (\\Phi_{bb} (c_{59} c_{18}) c_{20})	f		163	59,18,20
202	= \\Phi_{} (\\Phi_{bb} c_{23} c_{20})	f		164	23,20
203	= (\\Phi_{K} T) (\\Phi_{(b,)} c_{17})	f		165	17
255	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})	f		12	57,55
206	= (\\Phi_{bb} (\\Phi_{bb} c_{20}) c_{21}) (\\Phi_{bb} (\\Phi_{bb} c_{22}) c_{31})	f		166	20,21,22,31
207	= (\\Phi_{bb} \\Phi_{K} c_{20}) (\\Phi_{cb} c_{31} (\\Phi_{bcb} c_{23}))	f		167	20,31,23
208	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(c(bb,),)} c_{59} c_{31} (\\Phi_{(b(bb,cb),cb)} c_{2} c_{59}) c_{31})	f		168	59,31
209	= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{cbbb} c_{20} \\Phi_{bb} c_{15} c_{20})	f		169	20
212	= (\\Phi_{bb} (\\Phi_{cbbbb} c_{16} \\Phi_{bb} \\Phi_{bb} c_{5}) c_{16}) (\\Phi_{ccccbb} c_{31} \\Phi_{cbbb} \\Phi_{bb} c_{16} \\Phi_{cccbb} c_{32})	f		171	16,31,32
213	= (\\Phi_{cbbb} (c_{15} c_{18}) \\Phi_{bb} c_{4} (c_{15} c_{18})) (\\Phi_{bb} (\\Phi_{bb} (c_{15} c_{18})) c_{32})	f		172	18,32
215	= (\\Phi_{c(bb,bb)} (c_{15} c_{18}) (\\Phi_{(bb,bb)} c_{4}) c_{15} c_{4} (c_{15} c_{18})) (\\Phi_{(cb,b)} c_{32} (\\Phi_{(bcb,b)} c_{15}) c_{32})	f		173	18,32
224	= (\\Phi_{bbb} (\\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{31}) \\Phi_{bcb} c_{16}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{60})	f		174	31,16,60
217	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{32} \\Phi_{bcb} c_{25}) c_{32}) (\\Phi_{ccbb} \\Phi_{cbb} c_{32} \\Phi_{ccb} c_{25})	f		12	32,25
218	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cbb,b)} c_{16} (\\Phi_{(bbbbb,bb)} (\\Phi_{(bb,b)} c_{2}) c_{16} c_{22} c_{22}) c_{24} c_{34})	f		175	16,22,24,34
225	= (\\Phi_{cbbb} c_{31} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) \\Phi_{bb} c_{16}) (\\Phi_{bbb} \\Phi_{b} c_{16} c_{61})	f		176	31,16,61
220	= (\\Phi_{(ccbb,b)} c_{24} \\Phi_{bb} \\Phi_{cbbb} c_{34} c_{34}) (\\Phi_{cbbb} c_{24} \\Phi_{bb} \\Phi_{bb} c_{34})	f		177	24,34
256	= (\\Phi_{(ccbb,b)} c_{55} \\Phi_{bb} \\Phi_{cbbb} c_{57} c_{57}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{57})	f		177	55,57
190	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(c(cbb,),b)} c_{27} c_{5} (\\Phi_{(bb,(bcb,b))} c_{2}) c_{15} c_{27})	f		178	27
257	= (c_{55} c_{43} c_{43}) c_{44}	f		179	55,43,44
43	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{5} \\Phi_{bcb} c_{5}) c_{5}) (\\Phi_{ccbb} \\Phi_{cbb} c_{5} \\Phi_{ccb} c_{5})	f		180	
121	= (\\Phi_{cbbbb} (\\Phi_{(bb,b)} c_{2}) \\Phi_{bb} (\\Phi_{bbb} \\Phi_{K}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{ccb} \\Phi_{cccb} \\Phi_{K} (\\Phi_{cccb} (\\Phi_{(bb(bb,b),bb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{K} c_{5})))	f		181	
130	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(ccbbb,bb)} \\Phi_{b} c_{2} \\Phi_{bbcb} (\\Phi_{c(cbbbb,)} (\\Phi_{(bb,b)} c_{5})) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		182	
223	= (\\Phi_{(bcbbb,bbb)} c_{19} c_{31} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) \\Phi_{bb} c_{16} \\Phi_{K} c_{22} c_{22}) (\\Phi_{b} c_{61})	f		183	19,31,16,22,61
73	= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})	f		184	
86	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccb,b)} c_{2} \\Phi_{bcbcb} c_{4} (\\Phi_{ccc(bbb,)} c_{5}) c_{4})	f		185	
185	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(cc(ccbb,bbb),bb)} \\Phi_{cb} c_{16} c_{1} c_{2} \\Phi_{cb(bbcb,b)} (c_{59} c_{18}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} c_{16} c_{16} c_{23})	f		186	16,59,18,23
182	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{16} \\Phi_{bcb} c_{4}) c_{16}) (\\Phi_{ccbb} \\Phi_{cbb} c_{16} \\Phi_{ccb} c_{24})	f		187	16,24
226	= (\\Phi_{(b,)} c_{15}) (\\Phi_{K} c_{8})	f		188	
183	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{16} \\Phi_{bcb} c_{5}) c_{16}) (\\Phi_{ccbb} \\Phi_{cbb} c_{16} \\Phi_{ccb} c_{25})	f		189	16,25
184	= (\\Phi_{K} c_{9}) (\\Phi_{b} (c_{16} c_{18}))	f		190	16,18
191	= (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{b} c_{16}) (\\Phi_{b} (c_{59} c_{18}))	f		191	16,59,18
187	= c_{18} (c_{22} c_{18})	f		193	18,22
188	= c_{18} (c_{23} c_{18})	f		193	18,23
221	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{(ccbbb,b)} c_{60} c_{60} (\\Phi_{(bbb,bb)} c_{27}) c_{25} c_{60} c_{25})	f		194	60,27,25
189	= (\\Phi_{bb} \\Phi_{b} c_{24}) (\\Phi_{cb} c_{24} \\Phi_{cb})	f		195	24
127	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{c(c(bbb,ccbbbb),bb)} \\Phi_{b} c_{5} (\\Phi_{cc(cbbbb,)} \\Phi_{cbb} c_{5}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b} c_{1} c_{2} \\Phi_{cb(bb,bccb)} c_{7} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bb} c_{7}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		197	
236	= (\\Phi_{ccbb} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{bbb} c_{2}) (\\Phi_{bbb} (\\Phi_{bb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) \\Phi_{bb} c_{2})	f		198	
235	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{cccbb(b,)} c_{15} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) \\Phi_{bbbb} c_{2} c_{15})	f		199	
237	= (\\Phi_{(bbbb,bbb)} c_{19} (\\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{31}) \\Phi_{bcb} c_{16} \\Phi_{K} c_{22} c_{22}) (\\Phi_{b} c_{60})	f		201	19,31,16,22,60
238	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cbbbb} (\\Phi_{(b(bb,b),(bb,b))} c_{1} c_{5}) (\\Phi_{(cb,b)} c_{5}) \\Phi_{bc(cb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b})	f		202	
211	= (\\Phi_{ccccbb} c_{16} (\\Phi_{bccccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{(bcbb,cbcb)} c_{5}) c_{5} (\\Phi_{ccccbb} (\\Phi_{bc(ccccbb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{31} c_{15})) c_{16}) (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{16}) c_{32})	f		203	16,31,32
180	= T (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\Phi_{bc(cccccbccbbbb,ccbbbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{16} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{(bcb,cbbbb)} c_{2}) c_{15} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{16}) \\Phi_{cb} c_{16} (\\Phi_{(bbcb,b)} c_{1}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} c_{16} \\Phi_{cb} c_{16} (\\Phi_{(bbcb,b)} c_{1}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b} c_{16}))	f		204	16
181	= T (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\Phi_{bc(cccccbbb,bb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{16} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{(bcb,cbbbb)} c_{2}) c_{15} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{16}) (\\Phi_{(bb,b)} c_{1}) c_{27} (\\Phi_{(bb,b)} c_{1}) c_{27}))	f		205	16,27
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
158	= (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2}) c_{16}) (\\Phi_{bb} \\Phi_{b} c_{27})	f		213	16,27
239	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{cccccbb(b,)} c_{15} \\Phi_{b} \\Phi_{cb} c_{15} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4})) \\Phi_{b(bcb,bb)} c_{2} c_{15})	f		214	
110	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{cbbb} c_{15} (\\Phi_{bcbbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})))) (\\Phi_{(b(bb,b),b)} c_{1} c_{4}) c_{15})	f		215	16
115	= (\\Phi_{K} T) (\\Phi_{bcbbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{1}) c_{27})	f		216	16,27
107	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{c(cbb,bb)} c_{16} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{(bb,bbb)} c_{2}) c_{15} (\\Phi_{(bb,b)} c_{1}) c_{16})	f		217	16
240	= (\\Phi_{bb} \\Phi_{b} c_{15}) (\\Phi_{cbbb} c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{1}) c_{16})	f		218	16
216	= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{cbc(bbbbcb,)} c_{32} \\Phi_{bb} c_{16} \\Phi_{bcbb} c_{2} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) (\\Phi_{bcb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{31}) c_{15} \\Phi_{cbcb})	f		219	32,16,31
241	= (\\Phi_{b} \\Phi_{K}) (\\Phi_{bb} (\\Phi_{(bb,)} c_{5}) c_{2})	f		220	
267	= (c_{54} c_{43} c_{42}) (c_{55} c_{43} c_{51})	f		221	54,43,42,55,51
111	= (\\Phi_{K} (\\Phi_{K} T)) (\\Phi_{ccb} c_{16} (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) (\\Phi_{bcb(cb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{16} (\\Phi_{bbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})))))	f		222	16
179	= T (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\Phi_{bcc(ccbb,b)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{15} (\\Phi_{(b(bb,b),b)} c_{1} c_{4}) c_{15} (\\Phi_{(b(bb,b),b)} c_{1} c_{4}) (\\Phi_{bc(cccccbcbb,cbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{16} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{(bcb,cbbbb)} c_{2}) c_{15} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{16})) c_{15} c_{15}))	f		223	16
268	= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})	f		224	57,54,43,42,55
270	= (\\Phi_{K} c_{42}) (\\Phi_{b} (c_{57} c_{42}))	f		225	42,57
269	= (c_{54} (c_{54} (c_{54} c_{43} c_{42}) c_{43}) c_{51}) (c_{55} (c_{54} c_{44} c_{42}) (c_{54} (c_{54} c_{51} c_{51}) c_{51}))	f		226	54,43,42,51,55,44
266	= (c_{54} (c_{54} c_{45} c_{48}) c_{46}) (c_{55} (c_{54} c_{44} c_{45}) (c_{54} (c_{54} c_{45} c_{46}) c_{43}))	f		227	54,45,48,46,55,44,43
214	= (\\Phi_{c(ccbbb,bb)} c_{16} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{17} (\\Phi_{(bbbb,bbb)} c_{4} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{5}) c_{16} (\\Phi_{(bb,b)} c_{5}) c_{17}) (\\Phi_{bb} \\Phi_{b} c_{59})	f		228	16,17,59
219	= (\\Phi_{ccbbb} c_{16} (\\Phi_{bccccb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) (\\Phi_{(bbcccbb,cbcb)} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{31})) (\\Phi_{cccbb} (\\Phi_{bc(cccccb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{31} c_{15}) c_{31}) (\\Phi_{(bbb,bcb)} c_{5}) c_{16}) (\\Phi_{cb} c_{34} (\\Phi_{bbcb} \\Phi_{b} c_{16}))	f		229	16,31,34
177	= T (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8}) (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{17} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{5} c_{15} (\\Phi_{(bcb,cbbbb)} c_{2}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) \\Phi_{b} c_{17}))	f		230	17
258	= (c_{55} c_{43} c_{44}) c_{45}	f		34	55,43,44,45
265	= (\\Phi_{ccbb} c_{57} (c_{55} c_{43} c_{51}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})	f		231	57,55,43,51,54
178	= (\\Phi_{K} T) (\\Phi_{bcc(ccb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{16} (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) c_{16} (\\Phi_{(b(bcb,b),b)} c_{1} c_{5}) (\\Phi_{bc(cccccb(cb,b),(cb,b))} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{16} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{(bcb,cbbbb)} c_{2}) c_{15} c_{5} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) (\\Phi_{bcccc(cb,bbb)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{K} c_{8})) c_{16})))	f		232	16
204	= T (c_{7} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}) (\\Phi_{bc(bb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{16} (\\Phi_{(bb,cb)} c_{5}) c_{16})))	f		233	16
205	= T (c_{7} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8}) (\\Phi_{bc(cccbb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{16} \\Phi_{cb(bb,cb)} c_{5} c_{5} (\\Phi_{bc(cccbcb,)} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{4}) (\\Phi_{K} c_{8})) c_{16}) c_{16})))	f		234	16
271	= (\\Phi_{K} c_{42}) (\\Phi_{cb} c_{42} c_{57})	f		235	42,57
26	= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{4} \\Phi_{bcb} c_{1}) c_{4}) (\\Phi_{ccbb} \\Phi_{cbb} c_{4} \\Phi_{ccb} c_{1})	f		236	
259	= (c_{55} c_{43} c_{45}) c_{46}	f		34	55,43,45,46
260	= (c_{55} c_{43} c_{46}) c_{47}	f		34	55,43,46,47
262	= (c_{55} c_{43} c_{48}) c_{49}	f		34	55,43,48,49
55	= (\\Phi_{c(bb,)} c_{5} (\\Phi_{bbcb} \\Phi_{K}) c_{1}) (\\Phi_{cbc(cb,)} c_{1} \\Phi_{bb} c_{5} c_{5} (\\Phi_{(bcb,cbb)} c_{1}))	f		237	
1	= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})	f		238	
264	= (c_{55} c_{43} c_{50}) c_{51}	f		34	55,43,50,51
\.


--
-- Name: teorema_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.teorema_id_seq', 287, true);


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
AdminTeoremas	Admin	Teoremas	admin@teoremas.gries	4b39bf2b2076bb3aec161cfd09ca0614a65f3c0adadb80ff443b8434237ad0a2745018653685a9811f2335dd0b314427ff7568592cd3856ef67ddb0315da4627	1	t	f	2
federico	Federico	Flaviani	federico.flaviani@gmail.com	4b39bf2b2076bb3aec161cfd09ca0614a65f3c0adadb80ff443b8434237ad0a2745018653685a9811f2335dd0b314427ff7568592cd3856ef67ddb0315da4627	1	f	t	2
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

>>>>>>> Stashed changes
