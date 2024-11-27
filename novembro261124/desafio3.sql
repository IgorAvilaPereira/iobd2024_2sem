--1 usuário que pode fazer tudo com a tabelas do banco
CREATE ROLE superusuario WITH PASSWORD '123' LOGIN SUPERUSER;
--1 usuário que só pode SELECT
CREATE ROLE sopodeselect WITH PASSWORD '123' LOGIN;
GRANT CONNECT on DATABASE novembro TO sopodeselect;
GRANT USAGE ON SCHEMA public TO sopodeselect;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO sopodeselect;
--1 usuário que não pode fazer DELETE
CREATE ROLE sonpodedeletar WITH PASSWORD '123' LOGIN;
GRANT CONNECT on DATABASE novembro TO sonpodedeletar;
GRANT USAGE ON SCHEMA public TO sonpodedeletar;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO sonpodedeletar;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO sonpodedeletar;
REVOKE DELETE ON ALL TABLES IN SCHEMA public FROM sonpodedeletar;
