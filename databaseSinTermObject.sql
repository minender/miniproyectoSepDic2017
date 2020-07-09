--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;

CREATE SCHEMA userdb;

ALTER SCHEMA userdb OWNER TO postgres;

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';

SET default_tablespace = '';

SET default_with_oids = false;


-- Domains 

--
-- Name: alias_list
--
CREATE DOMAIN userdb."alias_list" AS
  TEXT NOT NULL CHECK ( (value ~ '(^(([A-Z][a-z]*:(1|2)*),\s)*([A-Z][a-z]*:(1|2)*))$') or (value LIKE '') );

--
-- Name: categoria; Type: TABLE; Schema: userdb; Owner: userdb; Tablespace: 
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
-- Name: categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userdb
--

ALTER SEQUENCE userdb.categoria_id_seq OWNED BY userdb.categoria.id;


--
-- Name: dispone; Type: TABLE; Schema: userdb; Owner: userdb; Tablespace: 
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
-- Name: materia; Type: TABLE; Schema: userdb; Owner: userdb; Tablespace: 
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
-- Name: metateorema; Type: TABLE; Schema: userdb; Owner: userdb; Tablespace: 
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
-- Name: predicado; Type: TABLE; Schema: userdb; Owner: userdb; Tablespace: 
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
-- Name: publicacion; Type: TABLE; Schema: userdb; Owner: userdb; Tablespace: 
--

CREATE TABLE userdb.publicacion (
    alias text,
    login text
);


ALTER TABLE userdb.publicacion OWNER TO userdb;

--
-- Name: resuelve; Type: TABLE; Schema: userdb; Owner: userdb; Tablespace: 
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
-- Name: solucion; Type: TABLE; Schema: userdb; Owner: userdb; Tablespace: 
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
-- Name: teorema; Type: TABLE; Schema: userdb; Owner: userdb; Tablespace: 
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
-- Name: termino; Type: TABLE; Schema: userdb; Owner: userdb; Tablespace: 
--

CREATE TABLE userdb.termino (
    combinador text NOT NULL,
    serializado bytea NOT NULL,
    alias text NOT NULL,
    login text NOT NULL
);


ALTER TABLE userdb.termino OWNER TO userdb;

--
-- Name: usuario; Type: TABLE; Schema: userdb; Owner: userdb; Tablespace: 
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

CREATE TABLE userdb.teoria (
    id integer NOT NULL,
    nombre text NOT NULL
);

ALTER TABLE userdb.teoria OWNER TO userdb;

CREATE SEQUENCE userdb.teoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE userdb.teoria_id_seq OWNER TO userdb;

ALTER SEQUENCE userdb.teoria_id_seq OWNED BY userdb.teoria.id;


CREATE TABLE userdb.simbolo (
    id integer NOT NULL,
    notacion_latex text NOT NULL,
    argumentos integer,
    esInfijo boolean DEFAULT false NOT NULL,
    asociatividad integer,
    precedencia integer NOT NULL,
    notacion text NOT NULL,
    teoriaid integer NOT NULL
);

ALTER TABLE userdb.simbolo OWNER TO userdb;

CREATE SEQUENCE userdb.simbolo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE userdb.simbolo_id_seq OWNER TO userdb;

ALTER SEQUENCE userdb.simbolo_id_seq OWNED BY userdb.simbolo.id;

CREATE TABLE userdb.mostrarCategoria (
    id integer NOT NULL,
    categoriaid integer NOT NULL,
    usuariologin text NOT NULL
);

ALTER TABLE userdb.mostrarCategoria OWNER TO userdb;

CREATE SEQUENCE userdb.mostrarCategoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE userdb.mostrarCategoria_id_seq OWNER TO userdb;

--
-- Name: id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.categoria ALTER COLUMN id SET DEFAULT nextval('userdb.categoria_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.dispone ALTER COLUMN id SET DEFAULT nextval('userdb.dispone_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.metateorema ALTER COLUMN id SET DEFAULT nextval('userdb.metateorema_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.resuelve ALTER COLUMN id SET DEFAULT nextval('userdb.resuelve_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.solucion ALTER COLUMN id SET DEFAULT nextval('userdb.solucion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.teorema ALTER COLUMN id SET DEFAULT nextval('userdb.teorema_id_seq'::regclass);


ALTER TABLE ONLY userdb.teoria ALTER COLUMN id SET DEFAULT nextval('userdb.teoria_id_seq'::regclass);

ALTER TABLE ONLY userdb.simbolo ALTER COLUMN id SET DEFAULT nextval('userdb.simbolo_id_seq'::regclass);

ALTER TABLE ONLY userdb.mostrarCategoria ALTER COLUMN id SET DEFAULT nextval('userdb.simbolo_id_seq'::regclass);

insert into userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) values (1,'\equiv', 2, TRUE, 0, 1,'%(aa2) %(op) %(a1)',1);
insert into userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) values (2,'\Rightarrow', 2, TRUE, 1, 2,'%(a2) %(op) %(aa1)', 1);
insert into userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) values (3,'\Leftarrow', 2,TRUE,0,2,'%(aa2) %(op) %(a1)',1);
insert into userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) values (4,'\vee', 2, TRUE, 0, 3,'%(aa2) %(op) %(a1)',1);
insert into userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) values (5,'\wedge', 2, TRUE, 0, 3,'%(aa2) %(op) %(a1)',1);
insert into userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) values (6,'\not\equiv', 2, TRUE, 0, 4,'%(a2) %(op) %(a1)',1);
insert into userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) values (7,'\neg', 1, TRUE, 1, 5,'%(op) %(aa1)',1);
insert into userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) values (8,'true', 0, TRUE, 0, 0,'%(op)',1);
insert into userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) values (9,'false', 0, TRUE, 0, 0,'%(op)',1);
insert into userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) values (10,'=', 2, TRUE, 0, 5,'%(a2) %(op) %(a1)',1);
insert into userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) values (11,'+', 2, TRUE, 0, 6,'%(a2) %(op) %(a1)',1);
insert into userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) values (12,'-', 2, TRUE, 0, 6,'%(a2) %(op) %(a1)',1);
insert into userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) values (13,'.', 2, TRUE, 0, 7,'%(aa2) %(op) %(a1)',1);
insert into userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) values (14,' ', 2, TRUE, 0, 7,'\frac{%(na2)}{%(na1)}',1);
insert into userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) values (15,'-', 1, TRUE, 0, 8,'%(op)%(a1)',1);
insert into userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) values (16,'^', 1, TRUE, 0, 9,'%(a2)%(op){%(a1)}',1);
insert into userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) values (17,'0', 0, TRUE, 0, 0,'%(op)',1);
insert into userdb.simbolo (id, notacion_latex, argumentos, esinfijo, asociatividad, precedencia, notacion, teoriaid) values (18,'1', 0, TRUE, 0, 0,'%(op)',1);

--
-- Name: simbolo_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.simbolo_id_seq', 18, true);

--
-- Data for Name: categoria; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.categoria (id, nombre) FROM stdin;
1	Equivalencia
2	Negación
3	Disyunción
4	Conjunción
5	Implicación
\.


--
-- Name: categoria_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.categoria_id_seq', 5, true);


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
1	Lógica Simbólica Ene-Mar 2018
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
-- Data for Name: predicado; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.predicado (predicado, alias, login, argumentos) FROM stdin;
\.


--
-- Data for Name: publicacion; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.publicacion (alias, login) FROM stdin;
\.


--
-- Data for Name: resuelve; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.resuelve (id, nombreteorema, numeroteorema, resuelto, loginusuario, teoremaid) FROM stdin;
\.


--
-- Name: resuelve_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.resuelve_id_seq', 1, false);


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
\.


--
-- Name: teorema_id_seq; Type: SEQUENCE SET; Schema: userdb; Owner: userdb
--

SELECT pg_catalog.setval('userdb.teorema_id_seq', 1, false);


--
-- Data for Name: termino; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.termino (combinador, serializado, alias, login) FROM stdin;
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: userdb; Owner: userdb
--

COPY userdb.usuario (login, nombre, apellido, correo, password, materiaid, admin) FROM stdin;
admin	Admin	Admin	correodem@asiado.falso	1f0d65c78b2350520c7bb6409104226063e3d9b05cb0a31ba497f489f98ef6bb8c92cd81ba298543d4fb1b293e139d12f4a7110adb157c75075d8a582e1fe97d	1	t
AdminTeoremas	Admin	Teoremas	admin@teoremas.gries	4b39bf2b2076bb3aec161cfd09ca0614a65f3c0adadb80ff443b8434237ad0a2745018653685a9811f2335dd0b314427ff7568592cd3856ef67ddb0315da4627	1	t
\.

COPY userdb.teoria (id, nombre) FROM stdin;
1	Lógica proposicional
\.


--
-- Name: categoria_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb; Tablespace: 
--

ALTER TABLE ONLY userdb.categoria
    ADD CONSTRAINT "categoria_PK" PRIMARY KEY (id);


--
-- Name: categoria_UNIQUE; Type: CONSTRAINT; Schema: userdb; Owner: userdb; Tablespace: 
--

ALTER TABLE ONLY userdb.categoria
    ADD CONSTRAINT "categoria_UNIQUE" UNIQUE (nombre);


--
-- Name: dispone_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb; Tablespace: 
--

ALTER TABLE ONLY userdb.dispone
    ADD CONSTRAINT "dispone_PK" PRIMARY KEY (id);


--
-- Name: dispone_metateorema_y_usuario_UNIQUE; Type: CONSTRAINT; Schema: userdb; Owner: userdb; Tablespace: 
--

ALTER TABLE ONLY userdb.dispone
    ADD CONSTRAINT "dispone_metateorema_y_usuario_UNIQUE" UNIQUE (loginusuario, metateoremaid);


--
-- Name: materia_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb; Tablespace: 
--

ALTER TABLE ONLY userdb.materia
    ADD CONSTRAINT "materia_PK" PRIMARY KEY (id);


--
-- Name: materia_UNIQUE; Type: CONSTRAINT; Schema: userdb; Owner: userdb; Tablespace: 
--

ALTER TABLE ONLY userdb.materia
    ADD CONSTRAINT "materia_UNIQUE" UNIQUE (nombre);


--
-- Name: metateorema_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb; Tablespace: 
--

ALTER TABLE ONLY userdb.metateorema
    ADD CONSTRAINT "metateorema_PK" PRIMARY KEY (id);


--
-- Name: predicado_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb; Tablespace: 
--

ALTER TABLE ONLY userdb.predicado
    ADD CONSTRAINT "predicado_PK" PRIMARY KEY (alias, login);


--
-- Name: predicado_alias_UNIQUE; Type: CONSTRAINT; Schema: userdb; Owner: userdb; Tablespace: 
--

ALTER TABLE ONLY userdb.predicado
    ADD CONSTRAINT "predicado_alias_UNIQUE" UNIQUE (predicado, login);


--
-- Name: resuelve_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb; Tablespace: 
--

ALTER TABLE ONLY userdb.resuelve
    ADD CONSTRAINT "resuelve_PK" PRIMARY KEY (id);


--
-- Name: resuelve_teorema_y_usuario_UNIQUE; Type: CONSTRAINT; Schema: userdb; Owner: userdb; Tablespace: 
--

ALTER TABLE ONLY userdb.resuelve
    ADD CONSTRAINT "resuelve_teorema_y_usuario_UNIQUE" UNIQUE (loginusuario, teoremaid);


--
-- Name: solucion_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb; Tablespace: 
--

ALTER TABLE ONLY userdb.solucion
    ADD CONSTRAINT "solucion_PK" PRIMARY KEY (id);


--
-- Name: teorema_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb; Tablespace: 
--

ALTER TABLE ONLY userdb.teorema
    ADD CONSTRAINT "teorema_PK" PRIMARY KEY (id);


--
-- Name: termino_PK; Type: CONSTRAINT; Schema: userdb; Owner: userdb; Tablespace: 
--

ALTER TABLE ONLY userdb.termino
    ADD CONSTRAINT "termino_PK" PRIMARY KEY (alias, login);


--
-- Name: termino_UNIQUE; Type: CONSTRAINT; Schema: userdb; Owner: userdb; Tablespace: 
--

ALTER TABLE ONLY userdb.termino
    ADD CONSTRAINT "termino_UNIQUE" UNIQUE (combinador, login);


--
-- Name: usuario_pk; Type: CONSTRAINT; Schema: userdb; Owner: userdb; Tablespace: 
--

ALTER TABLE ONLY userdb.usuario
    ADD CONSTRAINT usuario_pk PRIMARY KEY (login);


ALTER TABLE ONLY userdb.teoria
    ADD CONSTRAINT "teoria_pk" PRIMARY KEY (id);

ALTER TABLE ONLY userdb.simbolo
    ADD CONSTRAINT "simbolo_pk" PRIMARY KEY (id);   
--
-- Name: dispone_metateorema_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.dispone
    ADD CONSTRAINT "dispone_metateorema_FK" FOREIGN KEY (metateoremaid) REFERENCES userdb.metateorema(id);


--
-- Name: dispone_usuario_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.dispone
    ADD CONSTRAINT "dispone_usuario_FK" FOREIGN KEY (loginusuario) REFERENCES userdb.usuario(login);


--
-- Name: predicado_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.predicado
    ADD CONSTRAINT "predicado_FK" FOREIGN KEY (login) REFERENCES userdb.usuario(login);


--
-- Name: resuelve_teorema_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.resuelve
    ADD CONSTRAINT "resuelve_teorema_FK" FOREIGN KEY (teoremaid) REFERENCES userdb.teorema(id);


--
-- Name: resuelve_usuario_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.resuelve
    ADD CONSTRAINT "resuelve_usuario_FK" FOREIGN KEY (loginusuario) REFERENCES userdb.usuario(login);


--
-- Name: solucion_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.solucion
    ADD CONSTRAINT "solucion_FK" FOREIGN KEY (resuelveid) REFERENCES userdb.resuelve(id);


--
--
-- Name: termino_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.termino
    ADD CONSTRAINT "termino_FK" FOREIGN KEY (login) REFERENCES userdb.usuario(login);


--
-- Name: usuario_FK; Type: FK CONSTRAINT; Schema: userdb; Owner: userdb
--

ALTER TABLE ONLY userdb.usuario
    ADD CONSTRAINT "usuario_FK" FOREIGN KEY (materiaid) REFERENCES userdb.materia(id);

ALTER TABLE ONLY userdb.resuelve
    ADD CONSTRAINT "categoria_FK" FOREIGN KEY (categoriaid) REFERENCES userdb.categoria(id);
--
-- Name: userdb; Type: ACL; Schema: -; Owner: userdb

ALTER TABLE ONLY userdb.simbolo
    ADD CONSTRAINT "teoria_FK" FOREIGN KEY (teoriaid) REFERENCES userdb.teoria(id);
--

ALTER TABLE ONLY userdb.mostrarCategoria
    ADD CONSTRAINT "mostrarCategoria_PK" PRIMARY KEY (id);

ALTER TABLE ONLY userdb.mostrarCategoria
    ADD CONSTRAINT "categoria_FK" FOREIGN KEY (categoriaid) REFERENCES userdb.categoria(id);

ALTER TABLE ONLY userdb.mostrarCategoria
    ADD CONSTRAINT "usuario_FK" FOREIGN KEY (usuariologin) REFERENCES userdb.usuario(login);

GRANT ALL ON SCHEMA userdb TO userdb;
REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

