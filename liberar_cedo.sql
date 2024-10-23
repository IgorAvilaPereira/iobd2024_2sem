DROP DATABASE IF EXISTS liberar_cedo;

CREATE DATABASE liberar_cedo;

\c liberar_cedo;

CREATE SCHEMA interno;
CREATE SCHEMA externo;

SET search_path TO public, interno, externo;


CREATE TABLE externo.aluno (
    id uuid DEFAULT gen_random_uuid(),
    nome text not null
);

INSERT INTO externo.aluno (nome) VALUES
('DOUGLAS'), ('ADRIANO');

CREATE TYPE tamanho AS ENUM ('G', 'GG', 'M', 'P', 'PP', 'EG');

CREATE TABLE interno.professor (
    id uuid DEFAULT gen_random_uuid(),
    nome text not null,
    cpf character(11) not null,
    tamanho tamanho,
    unique(cpf)
);

INSERT INTO interno.professor (nome, cpf) VALUES
('IGOR', '11111111111');

CREATE TABLE public.log (
   id uuid DEFAULT gen_random_uuid(), 
   descricao json
);

INSERT INTO public.log (descricao) 
values ('{"observacao": "igor testando", "ip": "127.0.0.1"}'); 




