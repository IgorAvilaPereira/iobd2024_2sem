-- Questão 1
--Pergunta: Crie um usuário chamado usuario_teste com a senha senha123.
CREATE ROLE usuario_teste WITH PASSWORD 'senha123' LOGIN;

--Questão 2
--Pergunta: Conceda permissão de SELECT na tabela clientes para o usuário usuario_teste.
GRANT SELECT ON TABLE usuario TO usuario_teste;

--Questão 4
--Pergunta: Conceda permissão de INSERT e UPDATE na tabela produtos para o usuário usuario_teste.
GRANT INSERT ON TABLE usuario TO usuario_teste;
GRANT UPDATE ON TABLE usuario TO usuario_teste;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO usuario_teste;

--Questão 5
--Pergunta: Crie um papel (role) chamado gerente e conceda permissão de DELETE na tabela vendas para esse papel.
CREATE ROLE gerente_joao WITH PASSWORD 'senha123' LOGIN SUPERUSER;
GRANT DELETE ON TABLE usuario TO gerente_joao;

--Questão 6
--Pergunta: Atribua o papel gerente ao usuário usuario_teste.
GRANT gerente_joao TO usuario_teste;

--Questão 7
--Pergunta: Revogue o papel gerente do usuário usuario_teste.
REVOKE gerente_joao FROM usuario_teste;

--Questão 8
--Pergunta: Conceda permissão de EXECUTE em uma função chamada calcular_desconto para o usuário usuario_teste.
CREATE OR REPLACE FUNCTION exemplo() RETURNS text AS
$$
BEGIN
    RETURN 'Hello World';
END;
$$ LANGUAGE 'plpgsql';

GRANT EXECUTE ON FUNCTION exemplo() TO usuario_teste;

--Questão 9
--Pergunta: Crie um papel chamado leitor com permissão de SELECT em todas as tabelas do esquema public.
CREATE ROLE leitor;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO leitor;

--Questão 10
--Pergunta: Conceda permissão de USAGE no esquema financeiro para o usuário usuario_teste.
GRANT USAGE ON SCHEMA public TO usuario_teste;

--Questão 11
--Pergunta: Conceda permissão de USAGE e SELECT em uma sequence chamada clientes_id_seq para o usuário usuario_teste.
GRANT USAGE ON SEQUENCE usuario_id_seq TO usuario_teste;
GRANT SELECT ON TABLE usuario TO usuario_teste;

--Questão 12
--Pergunta: Conceda permissão de UPDATE em uma sequence chamada produtos_id_seq para o usuário usuario_teste.
GRANT USAGE ON SEQUENCE usuario_id_seq TO usuario_teste;
GRANT UPDATE ON SEQUENCE usuario_id_seq TO usuario_teste;

--Questão 13
--Pergunta: Revogue a permissão de USAGE em uma sequence chamada clientes_id_seq do usuário usuario_teste.
REVOKE USAGE ON SEQUENCE usuario_id_seq FROM usuario_teste;


--Questão 14
--Pergunta: Crie um papel chamado admin com permissão de USAGE e UPDATE em todas as sequences do esquema public.
CREATE ROLE administrador WITH PASSWORD 'senha123' LOGIN SUPERUSER;
GRANT USAGE, UPDATE ON ALL SEQUENCES IN SCHEMA public TO administrador;

--Questão 15
--Pergunta: Atribua o papel admin ao usuário usuario_teste.
GRANT administrador TO usuario_teste;
