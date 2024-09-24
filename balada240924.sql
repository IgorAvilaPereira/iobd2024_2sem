DROP DATABASE IF EXISTS balada;

CREATE DATABASE balada;

\c balada;

CREATE TABLE evento (
    id serial primary key,
    nome character varying(200) not null,
    data_hora_inicio timestamp,
    data_hora_fim timestamp
);
INSERT INTO evento (nome, data_hora_inicio) VALUES
('HALLOWEEN', '2024-09-13'),
('REVIVAL EMO', '2024-09-14'),
('PAGODE DO IGOR', '2024-09-20');

CREATE TABLE atracao (
    id serial primary key,
    nome text not null,
    cache money
);
INSERT INTO atracao (nome, cache) VALUES
('MEGADEATH COVER', 1000.00),
('FRESNO COVER', 2000.00),
('IGOR VOZ E VIOLÃO', 0.00),
('DANÇA TÍPICA BY RAFAEL BETITO', 1.99),
('DJ DAVID', 20.00);

CREATE TABLE evento_atracao (
    evento_id integer references evento (id),
    atracao_id integer references atracao (id),
    data_hora_inicio timestamp,
    data_hora_fim timestamp,
    cache_recebido money,
    primary key (evento_id, atracao_id)
);
INSERT INTO evento_atracao(evento_id, atracao_id, cache_recebido, data_hora_inicio, data_hora_fim) VALUES
(1,1, 1000.00, '2024-09-13 19:30:00', '2024-09-14 02:00:00'),
(2,2, 2500.00, NULL, NULL),
(1,3, 1.99, '2024-09-13 19:00:00', '2024-09-13 19:05:00');

CREATE TABLE lote (
    id serial primary key,
    nro integer check (nro > 0),
    evento_id integer references evento (id),
    valor money,
    qtde integer check (qtde > 0),
    unique (nro, evento_id)
);
INSERT INTO lote (nro, evento_id, valor, qtde) VALUES
(1, 1, 10, 100),
(2, 1, 20, 150),
(1, 2, 5, 100),
(2, 2, 10, 100);


CREATE TABLE ingresso (
    id serial primary key,
    lote_id integer references lote (id),
    observacao text
);
INSERT INTO ingresso (lote_id, observacao) values
(3, 'Quem comprou: Ronaldo'),
(3, 'Quem comprou: Ronaldo'),
(4, 'Quem comprou: Ronaldo'),
(4, 'Quem comprou: Ronaldo'),
(4, 'Quem comprou: Ronaldo');

CREATE TABLE funcionario (
    id serial primary key,
    nome character varying(200) not null,
    data_nascimento date 
);
INSERT INTO funcionario (nome, data_nascimento) VALUES
('JULIA', '2000-01-01'),
('JOÃO', '2001-12-12');

CREATE TABLE evento_funcionario (
    evento_id integer references evento (id),
    funcionario_id integer references funcionario (id),
    data_hora_entrada timestamp,
    data_hora_saida timestamp,
    valor_recebido money,
    primary key (evento_id, funcionario_id)
);

INSERT INTO evento_funcionario (evento_id, funcionario_id, valor_recebido) values
(1, 1, 1.99),
(2, 2, 1.99);

-- select atracao.nome, evento.nome from atracao inner join evento_atracao on atracao.id = evento_atracao.atracao_id inner join evento on evento.id = evento_atracao.evento_id  where evento_atracao.evento_id = 1;

-- select atracao.nome, evento.nome from atracao left join evento_atracao on atracao.id = evento_atracao.atracao_id left join evento on evento.id = evento_atracao.evento_id;

-- SELECT * from funcionario inner join evento_funcionario on (funcionario.id = evento_funcionario.funcionario_id) inner join evento on (evento.id = evento_funcionario.evento_id) where evento.nome ILIKE 'H%';

-- SELECT funcionario.nome, evento.nome from funcionario inner join evento_funcionario on (funcionario.id = evento_funcionario.funcionario_id) inner join evento on (evento.id = evento_funcionario.evento_id);

-- SELECT evento.nome FROM evento LEFT JOIN evento_funcionario on (evento.id = evento_funcionario.evento_id) WHERE evento_funcionario.evento_id is null;


