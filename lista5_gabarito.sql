CREATE DATABASE joao;

\c joao;

CREATE TABLE usuario (
    id serial primary key, 
    nome text not null, 
    email text unique
);

CREATE TABLE telefone (
    id serial primary key,
    nro text not null,
    usuario_id integer references usuario (id) 
);

-- tabela com json
CREATE TABLE dados_json (
    id serial primary key,
    dados json
);
-- inserts com json
INSERT INTO dados_json(dados) values ('{"nome": "Igor", "email": "igor.pereira@riogrande.ifrs.edu.br"}');

INSERT INTO dados_json(dados) values ('{"nome": "Igor", "email": "emaildoigor@mikrus.com"}');

-- trabalho select com coluna json
SELECT dados ->> 'nome' FROM dados_json;
SELECT * FROM dados_json where dados ->> 'nome' = 'Igor';
CREATE VIEW igor_lindo AS SELECT * FROM dados_json where dados ->> 'nome' = 'Igor';CREATE VIEW
SELECT * FROM igor_lindo;

-- add nova propriedae
UPDATE dados_json
SET dados = dados::jsonb || '{"cidade": "Rio Grande"}'::jsonb WHERE id = 1;

CREATE TABLE arquivos (
    id serial primary key,
    conteudo bytea
);

 INSERT INTO arquivos (conteudo) VALUES
(pg_read_binary_file('/tmp/guns_roses.png'));


CREATE TABLE pessoa (
    id serial primary key,
    nome text
);

CREATE TABLE funcionario (
    salario money
) INHERITS (pessoa);

SELECT * FROM ONLY pessoa;
SELECT * FROM funcionario;

CREATE TABLE conversadores (
    id uuid DEFAULT gen_random_uuid(),
    nome text not null,
    primary key (id)
);
INSERT INTO conversadores (nome) values ('felipe');
SELECT * FROM conversadores;
select * from conversadores where id = 'c6390e9a-d676-4d51-beea-3897633fc5a5';

-- tabela com id serial + identificador uuid (unique)
CREATE TABLE artigo (
    id serial primary key,
    titulo text not null,
    data_publicacao date,
    identificador uuid DEFAULT gen_random_uuid(),
    unique(identificador)    
);
-- exemplo insert
INSERT INTO artigo (titulo, data_publicacao) values
('calendário academico 2025', CURRENT_DATE),
('CALENDÁRIO EXAMES ', current_date - interval '7 days');

-- with
with artigos_recentes as (
    SELECT * FROM artigo where extract(month from data_publicacao) = extract(month from current_date) and extract(year from data_publicacao) = extract(year from current_date)
) select * from artigos_recentes;


with mais_que_1 AS (
    SELECT usuario_id, count(*) as qtde from telefone group by usuario_id
) select * from mais_que_1 where qtde > 1 ;

with mais_que_1 AS (
    SELECT usuario_id, count(*) as qtde from telefone group by usuario_id
) select usuario.id, usuario.nome, qtde from mais_que_1 inner join usuario on (mais_que_1.usuario_id = usuario.id) where qtde > 1 ;


with mais_que_1 AS (
    SELECT usuario_id, count(*) as qtde from telefone group by usuario_id
) select usuario.id, usuario.nome, STRING_AGG(telefone.nro, ',') as t, qtde from mais_que_1 inner join usuario on (mais_que_1.usuario_id = usuario.id) inner join telefone on (telefone.usuario_id = usuario.id) where qtde > 1  group by usuario.id, usuario.nome, qtde;

-- não está na 1fn
--id,nome,telefones
--1, igor pereira, 897598347-89234782347239-8943589345789

-- não está na 2fn
--pk (pedido_id, prod_id)
--pedido_id, prod_id, descricao_produto, qtde, preco
--1, 32,  'tv samsung', 100, 1.99

-- não está na 3fn
--codigo_depto (pk), nome_depto, codigo_gerente, nome_gerente
-- nome_gerente depende codigo_gerente (problema)


