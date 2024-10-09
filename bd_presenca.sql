DROP DATABASE IF EXISTS bd_presenca;

CREATE DATABASE bd_presenca;

\c bd_presenca;

CREATE SCHEMA interno;
CREATE SCHEMA externo;

SET search_path TO public, interno, externo;


CREATE TABLE interno.professor (
    id serial primary key,
    nome text not null
);
INSERT INTO interno.professor (nome) values ('igor');

CREATE TABLE interno.aluno (
    id serial primary key,
    nome text not null,
    professor_id integer references professor (id)
);
INSERT INTO interno.aluno (nome, professor_id) values ('david', 1);

CREATE TABLE externo.aula (
    aluno_id integer references aluno (id),
    data date default current_date,
    presente boolean default false
);
INSERT INTO externo.aula (aluno_id, data) values (1, CURRENT_DATE - INTERVAL '7 days');

CREATE VIEW presencas_do_david AS SELECT * FROM externo.aula WHERE aluno_id = 1;
