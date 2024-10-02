-- Lista 2 - SQL

-- Selecione todos os eventos que não têm atrações associadas.
-- subselect
select evento.id, evento.nome from evento where evento.id not in (select evento_id from evento_atracao);
--  Execution Time: 0.088 ms

-- left join 
select * from evento left join evento_atracao on (evento.id = evento_atracao.evento_id) where evento_atracao.evento_id is null;
-- Execution Time: 0.069 ms


-- except
select evento.id, evento.nome from evento EXCEPT SELECT evento.id, evento.nome from evento inner join evento_atracao on (evento.id = evento_atracao.evento_id);
-- Execution Time: 0.110 ms

--Selecione todos os funcionários que não trabalharam em nenhum evento.
-- subselect
select funcionario.id, funcioario.nome from funcionario where funcionario.id not in (select funcionario_id from evento_funcionario);


-- Selecione todos os eventos que têm atrações associadas.
-- inner join
SELECT DISTINCT evento.id, evento.nome from evento inner join evento_atracao on (evento.id = evento_atracao.evento_id) order by evento.nome ASC;

-- subselect
SELECT evento.id, evento.nome from evento where evento.id in (select evento_atracao.evento_id from evento_atracao);

-- exemplo intersect. obs: neste caso não faz muito sentido kkkkk
SELECT evento.id, evento.nome FROM evento INTERSECT SELECT evento.id, evento.nome from evento inner join evento_atracao on (evento.id = evento_atracao.evento_id);

-- Selecione todos os funcionários que trabalharam em eventos.
--INSERT INTO funcionario (nome, data_nascimento) values ('ronaldo', '2001-07-12');
--SELECT funcionario.id, funcionario.nome FROM funcionario INNER JOIN evento_funcionario ON funcionario.id = evento_funcionario.funcionario_id;

-- view
-- CREATE VIEW consulta_ronaldo AS SELECT funcionario.id, funcionario.nome FROM funcionario INNER JOIN evento_funcionario ON funcionario.id = evento_funcionario.funcionario_id;
-- Select * from consulta_ronaldo where nome ILIKE 'J%';
-- mostra tudo 
--\d+ consulta_ronaldo 


-- Selecione todos os eventos e todas as atrações.
-- SELECT id, nome from evento UNION select id, nome from atracao;

--Selecione todos os eventos e todas as atrações, incluindo duplicatas.
-- SELECT id, nome from evento UNION all select id, nome from atracao;

--Selecione todos os lotes que não têm ingressos associados.
--select * from lote where id not in (select lote_id from ingresso);
--select lote.id from lote except select lote.id from lote inner join ingresso on (lote.id = ingresso.lote_id);

--Selecione todos os eventos e todos os funcionários.
--SELECT nome from evento UNION select nome from funcionario;

--Selecione todos os eventos e todos os funcionários, incluindo duplicatas.
--SELECT nome from evento UNION all select nome from funcionario;
