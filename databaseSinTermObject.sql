--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE categoria (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- Name: categoria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE categoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categoria_id_seq OWNER TO postgres;

--
-- Name: categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE categoria_id_seq OWNED BY categoria.id;


--
-- Name: dispone; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dispone (
    id integer NOT NULL,
    numerometateorema text,
    resuelto boolean DEFAULT false NOT NULL,
    loginusuario text NOT NULL,
    metateoremaid integer NOT NULL
);


ALTER TABLE public.dispone OWNER TO postgres;

--
-- Name: dispone_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE dispone_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dispone_id_seq OWNER TO postgres;

--
-- Name: dispone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE dispone_id_seq OWNED BY dispone.id;


--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO postgres;

--
-- Name: materia; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE materia (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.materia OWNER TO postgres;

--
-- Name: materia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE materia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.materia_id_seq OWNER TO postgres;

--
-- Name: materia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE materia_id_seq OWNED BY materia.id;


--
-- Name: metateorema; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE metateorema (
    id integer NOT NULL,
    enunciado text NOT NULL,
    metateoserializado bytea NOT NULL,
    categoriaid integer NOT NULL
);


ALTER TABLE public.metateorema OWNER TO postgres;

--
-- Name: metateorema_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE metateorema_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metateorema_id_seq OWNER TO postgres;

--
-- Name: metateorema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE metateorema_id_seq OWNED BY metateorema.id;


--
-- Name: predicado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE predicado (
    id text NOT NULL,
    predicado text NOT NULL,
    alias text NOT NULL,
    predserializado text NOT NULL,
    loginusuario text NOT NULL,
    numargumentos integer NOT NULL
);


ALTER TABLE public.predicado OWNER TO postgres;

--
-- Name: publicacion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE publicacion (
    alias text,
    login text
);


ALTER TABLE public.publicacion OWNER TO postgres;

--
-- Name: resuelve; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE resuelve (
    id integer NOT NULL,
    nombreteorema text,
    numeroteorema text NOT NULL,
    resuelto boolean DEFAULT false NOT NULL,
    loginusuario text NOT NULL,
    teoremaid integer NOT NULL
);


ALTER TABLE public.resuelve OWNER TO postgres;

--
-- Name: resuelve_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE resuelve_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resuelve_id_seq OWNER TO postgres;

--
-- Name: resuelve_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE resuelve_id_seq OWNED BY resuelve.id;


--
-- Name: solucion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE solucion (
    id integer NOT NULL,
    resuelveid integer NOT NULL,
    resuelto boolean DEFAULT false NOT NULL,
    arregloserializado bytea NOT NULL
);


ALTER TABLE public.solucion OWNER TO postgres;

--
-- Name: solucion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE solucion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solucion_id_seq OWNER TO postgres;

--
-- Name: solucion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE solucion_id_seq OWNED BY solucion.id;


--
-- Name: teorema; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE teorema (
    id integer NOT NULL,
    enunciado text NOT NULL,
    teoserializado bytea NOT NULL,
    categoriaid integer NOT NULL,
    esquema boolean NOT NULL
);


ALTER TABLE public.teorema OWNER TO postgres;

--
-- Name: teorema_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE teorema_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teorema_id_seq OWNER TO postgres;

--
-- Name: teorema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE teorema_id_seq OWNED BY teorema.id;


--
-- Name: termino; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE termino (
    combinador text NOT NULL,
    serializado bytea NOT NULL,
    alias text NOT NULL,
    login text NOT NULL
);


ALTER TABLE public.termino OWNER TO postgres;

--
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario (
    login text NOT NULL,
    nombre text NOT NULL,
    apellido text NOT NULL,
    correo text NOT NULL,
    password text NOT NULL,
    materiaid integer NOT NULL,
    admin boolean DEFAULT false NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoria ALTER COLUMN id SET DEFAULT nextval('categoria_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dispone ALTER COLUMN id SET DEFAULT nextval('dispone_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metateorema ALTER COLUMN id SET DEFAULT nextval('metateorema_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resuelve ALTER COLUMN id SET DEFAULT nextval('resuelve_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY solucion ALTER COLUMN id SET DEFAULT nextval('solucion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teorema ALTER COLUMN id SET DEFAULT nextval('teorema_id_seq'::regclass);


--
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categoria (id, nombre) FROM stdin;
1	Equivalencia
2	Negación
3	Disyunción
4	Conjunción
5	Implicación
\.


--
-- Name: categoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categoria_id_seq', 5, true);


--
-- Data for Name: dispone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dispone (id, numerometateorema, resuelto, loginusuario, metateoremaid) FROM stdin;
\.


--
-- Name: dispone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('dispone_id_seq', 1, false);


--
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hibernate_sequence', 1, false);


--
-- Data for Name: materia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY materia (id, nombre) FROM stdin;
1	Lógica Simbólica Ene-Mar 2018
\.


--
-- Name: materia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('materia_id_seq', 1, true);


--
-- Data for Name: metateorema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY metateorema (id, enunciado, metateoserializado, categoriaid) FROM stdin;
\.


--
-- Name: metateorema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('metateorema_id_seq', 1, false);


--
-- Data for Name: predicado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY predicado (id, predicado, alias, predserializado, loginusuario, numargumentos) FROM stdin;
\.


--
-- Data for Name: publicacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY publicacion (alias, login) FROM stdin;
\.


--
-- Data for Name: resuelve; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY resuelve (id, nombreteorema, numeroteorema, resuelto, loginusuario, teoremaid) FROM stdin;
\.


--
-- Name: resuelve_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('resuelve_id_seq', 1, false);


--
-- Data for Name: solucion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY solucion (id, resuelveid, resuelto, arregloserializado) FROM stdin;
\.


--
-- Name: solucion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('solucion_id_seq', 1, false);


--
-- Data for Name: teorema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY teorema (id, enunciado, teoserializado, categoriaid, esquema) FROM stdin;
\.


--
-- Name: teorema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('teorema_id_seq', 1, false);


--
-- Data for Name: termino; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY termino (combinador, serializado, alias, login) FROM stdin;
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuario (login, nombre, apellido, correo, password, materiaid, admin) FROM stdin;
admin	Admin	Admin	correodem@asiado.falso	1f0d65c78b2350520c7bb6409104226063e3d9b05cb0a31ba497f489f98ef6bb8c92cd81ba298543d4fb1b293e139d12f4a7110adb157c75075d8a582e1fe97d	1	t
AdminTeoremas	Admin	Teoremas	admin@teoremas.gries	4b39bf2b2076bb3aec161cfd09ca0614a65f3c0adadb80ff443b8434237ad0a2745018653685a9811f2335dd0b314427ff7568592cd3856ef67ddb0315da4627	1	t
\.


--
-- Name: categoria_PK; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categoria
    ADD CONSTRAINT "categoria_PK" PRIMARY KEY (id);


--
-- Name: categoria_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categoria
    ADD CONSTRAINT "categoria_UNIQUE" UNIQUE (nombre);


--
-- Name: dispone_PK; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dispone
    ADD CONSTRAINT "dispone_PK" PRIMARY KEY (id);


--
-- Name: dispone_metateorema_y_usuario_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dispone
    ADD CONSTRAINT "dispone_metateorema_y_usuario_UNIQUE" UNIQUE (loginusuario, metateoremaid);


--
-- Name: materia_PK; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY materia
    ADD CONSTRAINT "materia_PK" PRIMARY KEY (id);


--
-- Name: materia_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY materia
    ADD CONSTRAINT "materia_UNIQUE" UNIQUE (nombre);


--
-- Name: metateorema_PK; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY metateorema
    ADD CONSTRAINT "metateorema_PK" PRIMARY KEY (id);


--
-- Name: predicado_PK; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY predicado
    ADD CONSTRAINT "predicado_PK" PRIMARY KEY (id, loginusuario);


--
-- Name: predicado_alias_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY predicado
    ADD CONSTRAINT "predicado_alias_UNIQUE" UNIQUE (alias);


--
-- Name: predicado_predSerializado_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY predicado
    ADD CONSTRAINT "predicado_predSerializado_UNIQUE" UNIQUE (predserializado);


--
-- Name: resuelve_PK; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY resuelve
    ADD CONSTRAINT "resuelve_PK" PRIMARY KEY (id);


--
-- Name: resuelve_teorema_y_usuario_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY resuelve
    ADD CONSTRAINT "resuelve_teorema_y_usuario_UNIQUE" UNIQUE (loginusuario, teoremaid);


--
-- Name: solucion_PK; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY solucion
    ADD CONSTRAINT "solucion_PK" PRIMARY KEY (id);


--
-- Name: teorema_PK; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY teorema
    ADD CONSTRAINT "teorema_PK" PRIMARY KEY (id);


--
-- Name: termino_PK; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY termino
    ADD CONSTRAINT "termino_PK" PRIMARY KEY (alias, login);


--
-- Name: termino_UNIQUE; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY termino
    ADD CONSTRAINT "termino_UNIQUE" UNIQUE (combinador, login);


--
-- Name: usuario_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pk PRIMARY KEY (login);


--
-- Name: dispone_metateorema_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dispone
    ADD CONSTRAINT "dispone_metateorema_FK" FOREIGN KEY (metateoremaid) REFERENCES metateorema(id);


--
-- Name: dispone_usuario_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dispone
    ADD CONSTRAINT "dispone_usuario_FK" FOREIGN KEY (loginusuario) REFERENCES usuario(login);


--
-- Name: metateorema_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metateorema
    ADD CONSTRAINT "metateorema_FK" FOREIGN KEY (categoriaid) REFERENCES categoria(id);


--
-- Name: predicado_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY predicado
    ADD CONSTRAINT "predicado_FK" FOREIGN KEY (loginusuario) REFERENCES usuario(login);


--
-- Name: resuelve_teorema_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resuelve
    ADD CONSTRAINT "resuelve_teorema_FK" FOREIGN KEY (teoremaid) REFERENCES teorema(id);


--
-- Name: resuelve_usuario_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resuelve
    ADD CONSTRAINT "resuelve_usuario_FK" FOREIGN KEY (loginusuario) REFERENCES usuario(login);


--
-- Name: solucion_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY solucion
    ADD CONSTRAINT "solucion_FK" FOREIGN KEY (resuelveid) REFERENCES resuelve(id);


--
-- Name: teorema_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teorema
    ADD CONSTRAINT "teorema_FK" FOREIGN KEY (categoriaid) REFERENCES categoria(id);


--
-- Name: termino_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY termino
    ADD CONSTRAINT "termino_FK" FOREIGN KEY (login) REFERENCES usuario(login);


--
-- Name: usuario_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT "usuario_FK" FOREIGN KEY (materiaid) REFERENCES materia(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

