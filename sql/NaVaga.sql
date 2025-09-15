--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-09-03 11:57:46

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 32974)
-- Name: historico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historico (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    vaga_id integer NOT NULL,
    data_entrada timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    data_saida timestamp without time zone
);


ALTER TABLE public.historico OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 32973)
-- Name: historico_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historico_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historico_id_seq OWNER TO postgres;

--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 223
-- Name: historico_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historico_id_seq OWNED BY public.historico.id;


--
-- TOC entry 222 (class 1259 OID 32958)
-- Name: sensores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sensores (
    id integer NOT NULL,
    codigo_sensor character varying(50) NOT NULL,
    vaga_id integer
);


ALTER TABLE public.sensores OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 32957)
-- Name: sensores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sensores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sensores_id_seq OWNER TO postgres;

--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 221
-- Name: sensores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sensores_id_seq OWNED BY public.sensores.id;


--
-- TOC entry 218 (class 1259 OID 32940)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    senha character varying(255) NOT NULL
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 32939)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 217
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- TOC entry 220 (class 1259 OID 32949)
-- Name: vagas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vagas (
    id integer NOT NULL,
    localizacao character varying(150) NOT NULL,
    status character varying(10) DEFAULT 'livre'::character varying,
    CONSTRAINT vagas_status_check CHECK (((status)::text = ANY ((ARRAY['livre'::character varying, 'ocupada'::character varying])::text[])))
);


ALTER TABLE public.vagas OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 32948)
-- Name: vagas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vagas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vagas_id_seq OWNER TO postgres;

--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 219
-- Name: vagas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vagas_id_seq OWNED BY public.vagas.id;


--
-- TOC entry 4761 (class 2604 OID 32977)
-- Name: historico id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico ALTER COLUMN id SET DEFAULT nextval('public.historico_id_seq'::regclass);


--
-- TOC entry 4760 (class 2604 OID 32961)
-- Name: sensores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sensores ALTER COLUMN id SET DEFAULT nextval('public.sensores_id_seq'::regclass);


--
-- TOC entry 4757 (class 2604 OID 32943)
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- TOC entry 4758 (class 2604 OID 32952)
-- Name: vagas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vagas ALTER COLUMN id SET DEFAULT nextval('public.vagas_id_seq'::regclass);


--
-- TOC entry 4933 (class 0 OID 32974)
-- Dependencies: 224
-- Data for Name: historico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historico (id, usuario_id, vaga_id, data_entrada, data_saida) FROM stdin;
1	1	2	2025-08-18 10:00:00	2025-08-18 12:00:00
2	2	3	2025-08-19 09:30:00	2025-08-19 10:15:00
3	3	4	2025-08-19 14:00:00	2025-08-19 16:00:00
4	4	1	2025-08-20 08:45:00	2025-08-20 09:50:00
5	5	5	2025-08-20 11:00:00	\N
\.


--
-- TOC entry 4931 (class 0 OID 32958)
-- Dependencies: 222
-- Data for Name: sensores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sensores (id, codigo_sensor, vaga_id) FROM stdin;
1	SENSOR001	1
2	SENSOR002	2
3	SENSOR003	3
4	SENSOR004	4
5	SENSOR005	5
\.


--
-- TOC entry 4927 (class 0 OID 32940)
-- Dependencies: 218
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, nome, email, senha) FROM stdin;
1	Gabriel Martins	gabriel.martins@email.com	123456
2	Gabriella Francisco	gabriella@email.com	abcdef
3	Heitor Rachadel	heitor@email.com	senha123
4	Gabriel Padilha	padilha@email.com	qwerty
5	Maria Silva	maria.silva@email.com	123abc
\.


--
-- TOC entry 4929 (class 0 OID 32949)
-- Dependencies: 220
-- Data for Name: vagas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vagas (id, localizacao, status) FROM stdin;
1	Shopping Beira-Mar - Piso 1	livre
2	Shopping Beira-Mar - Piso 2	ocupada
3	Centro - Rua XV de Novembro	livre
4	UFSC - Estacionamento CSE	ocupada
5	Lagoa da Conceição - Praça Central	livre
\.


--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 223-- Usuários do sistema
CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  senha VARCHAR(255) NOT NULL
);

-- Vagas de estacionamento
CREATE TABLE vagas (
  id SERIAL PRIMARY KEY,
  localizacao VARCHAR(150) NOT NULL,
  status VARCHAR(10) CHECK (status IN ('livre', 'ocupada')) DEFAULT 'livre'
);

-- Sensores vinculados a vagas
CREATE TABLE sensores (
  id SERIAL PRIMARY KEY,
  codigo_sensor VARCHAR(50) UNIQUE NOT NULL,
  vaga_id INT UNIQUE,
  FOREIGN KEY (vaga_id) REFERENCES vagas(id)
);

-- Histórico de uso das vagas
CREATE TABLE historico (
  id SERIAL PRIMARY KEY,
  usuario_id INT NOT NULL,
  vaga_id INT NOT NULL,
  data_entrada TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  data_saida TIMESTAMP NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
  FOREIGN KEY (vaga_id) REFERENCES vagas(id)
);
















INSERT INTO usuarios (nome, email, senha) VALUES
('Gabriel Martins', 'gabriel.martins@email.com', '123456'),
('Gabriella Francisco', 'gabriella@email.com', 'abcdef'),
('Heitor Rachadel', 'heitor@email.com', 'senha123'),
('Gabriel Padilha', 'padilha@email.com', 'qwerty'),
('Maria Silva', 'maria.silva@email.com', '123abc');


INSERT INTO vagas (localizacao, status) VALUES
('Shopping Beira-Mar - Piso 1', 'livre'),
('Shopping Beira-Mar - Piso 2', 'ocupada'),
('Centro - Rua XV de Novembro', 'livre'),
('UFSC - Estacionamento CSE', 'ocupada'),
('Lagoa da Conceição - Praça Central', 'livre');

INSERT INTO sensores (codigo_sensor, vaga_id) VALUES
('SENSOR001', 1),
('SENSOR002', 2),
('SENSOR003', 3),
('SENSOR004', 4),
('SENSOR005', 5);

INSERT INTO historico (usuario_id, vaga_id, data_entrada, data_saida) VALUES
(1, 2, '2025-08-18 10:00:00', '2025-08-18 12:00:00'),
(2, 3, '2025-08-19 09:30:00', '2025-08-19 10:15:00'),
(3, 4, '2025-08-19 14:00:00', '2025-08-19 16:00:00'),
(4, 1, '2025-08-20 08:45:00', '2025-08-20 09:50:00'),
(5, 5, '2025-08-20 11:00:00', NULL); -- NULL = usuário ainda está estacionado



-- Name: historico_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historico_id_seq', 5, true);


--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 221
-- Name: sensores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sensores_id_seq', 5, true);


--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 217
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 5, true);


--
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 219
-- Name: vagas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vagas_id_seq', 5, true);


--
-- TOC entry 4777 (class 2606 OID 32980)
-- Name: historico historico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico
    ADD CONSTRAINT historico_pkey PRIMARY KEY (id);


--
-- TOC entry 4771 (class 2606 OID 32965)
-- Name: sensores sensores_codigo_sensor_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sensores
    ADD CONSTRAINT sensores_codigo_sensor_key UNIQUE (codigo_sensor);


--
-- TOC entry 4773 (class 2606 OID 32963)
-- Name: sensores sensores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sensores
    ADD CONSTRAINT sensores_pkey PRIMARY KEY (id);


--
-- TOC entry 4775 (class 2606 OID 32967)
-- Name: sensores sensores_vaga_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sensores
    ADD CONSTRAINT sensores_vaga_id_key UNIQUE (vaga_id);


--
-- TOC entry 4765 (class 2606 OID 32947)
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- TOC entry 4767 (class 2606 OID 32945)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4769 (class 2606 OID 32956)
-- Name: vagas vagas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vagas
    ADD CONSTRAINT vagas_pkey PRIMARY KEY (id);


--
-- TOC entry 4779 (class 2606 OID 32981)
-- Name: historico historico_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico
    ADD CONSTRAINT historico_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);


--
-- TOC entry 4780 (class 2606 OID 32986)
-- Name: historico historico_vaga_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico
    ADD CONSTRAINT historico_vaga_id_fkey FOREIGN KEY (vaga_id) REFERENCES public.vagas(id);


--
-- TOC entry 4778 (class 2606 OID 32968)
-- Name: sensores sensores_vaga_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sensores
    ADD CONSTRAINT sensores_vaga_id_fkey FOREIGN KEY (vaga_id) REFERENCES public.vagas(id);


-- Completed on 2025-09-03 11:57:46

--
-- PostgreSQL database dump complete
--

