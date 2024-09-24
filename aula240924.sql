--Gabarito Lista 1

--Presentes:
--Jaifer
--Gustavo
--Doris
--Lucena
--Felipe
--Evelyn


-- Consultas Básicas
select * from evento;
select * from atracao;
select * from lote;
select * from ingresso;
select * from funcionario;

-- Filtros e Condições 
SELECT * FROM evento where cast(data_hora_inicio as date) > '2024-09-13'; 
SELECT * FROM evento where data_hora_inicio  > '2024-09-13'; 
select * from atracao where cache > cast(1000 as money);
select * from atracao where cast(cache as numeric(10,2)) > 1000;
select * from lote where qtde > 100;
select * from ingresso where upper(observacao) = upper('Quem comprou: Ronaldo');
select * from funcionario where data_nascimento > '2000-01-01';

-- Ordenação e Limitação
-- Selecione todos os eventos ordenados pelo nome.
select * from evento order by nome;
-- Selecione as 3 atrações mais caras.
select * from atracao order by cache DESC LIMIT 3;
-- Selecione os 5 lotes com menor valor.
select * from lote order by valor ASC LIMIT 5;
-- Selecione os 10 ingressos mais recentes.
SELECT * FROM ingresso order by id desc limit 10;
--Selecione todos os funcionários ordenados pela data de nascimento.
select * from funcionario order by data_nascimento;

--Funções de Agregação
-- Conte o número total de eventos.
select count(*) from evento;
--Conte o número total de atrações.
select count(*) as quantidade from atracao;
--Calcule o valor médio dos lotes.
select cast(avg(cast(valor as numeric(10,2))) as money) as valor_medio from lote;
-- Encontre o evento com a maior quantidade de lotes.
INSERT INTO lote (nro, evento_id, valor, qtde) VALUES (3, 1, 25.00, 50);
INSERT INTO lote (nro, evento_id, valor, qtde) VALUES (4, 1, 30.00, 50);
-- desconsiderando empate: limitando o resultado em uma unica tupla
select evento_id, count(*) as qtde from lote group by evento_id order by qtde DESC LIMIT 1;
INSERT INTO lote (nro, evento_id, valor, qtde) VALUES (3, 2, 25.00, 50);
INSERT INTO lote (nro, evento_id, valor, qtde) VALUES (4, 2, 30.00, 50);
-- considerando empate
SELECT evento_id, count(*) from lote group by evento_id having count(*) = (SELECT COUNT(*) as qtde FROM lote group by evento_id order by qtde desc limit 1) order by evento_id; 
-- Calcule o número total de ingressos vendidos.
select count(*) from ingresso;
--off: topic: 
select lote_id, count(*) from ingresso group by lote_id having count(*) >= 3;

--Junções (JOIN)
-- Selecione todas as atrações junto com o nome do evento correspondente.
SELECT evento.nome, atracao.nome FROM evento INNER JOIN evento_atracao ON (evento.id = evento_atracao.evento_id) INNER JOIN atracao ON (atracao.id = evento_atracao.atracao_id);
-- Selecione todos os lotes junto com o nome do evento correspondente.
select evento.id, evento.nome, lote.nro from evento inner join lote on (evento.id = lote.evento_id) order by evento.id, lote.nro;
-- OFF-TOPIC: STRING_AGG: https://www.postgresqltutorial.com/postgresql-aggregate-functions/postgresql-string_agg-function/ 
select evento.id, evento.nome, string_agg(cast(lote.nro as text), ',') as lotes from evento inner join lote on (evento.id = lote.evento_id) group by evento.id, evento.nome order by evento.id, evento.nome;
-- Selecione todos os ingressos junto com o número do lote correspondente.
select lote.nro, ingresso.id from lote inner join ingresso on (lote.id = ingresso.lote_id) order by lote.nro;
-- Selecione todos os funcionários junto com o nome do evento em que trabalharam.
select evento.id, evento.nome, funcionario.id, funcionario.nome from evento inner join evento_funcionario on (evento.id = evento_funcionario.evento_id) inner join funcionario on (funcionario.id = evento_funcionario.funcionario_id) order by evento.id, funcionario.nome;
-- Selecione todas as atrações de um evento específico.
SELECT evento.id, evento.nome, atracao.id, atracao.nome from evento inner join evento_atracao on (evento.id = evento_atracao.evento_id) inner join atracao on (atracao.id = evento_atracao.atracao_id) where evento.id = 1;
-- OFF-TOPIC: STRING_AGG: https://www.postgresqltutorial.com/postgresql-aggregate-functions/postgresql-string_agg-function/ 
select evento.id, evento.nome, string_agg(cast(atracao.nome as text), ',') as atracoes from evento inner join evento_atracao on (evento.id = evento_atracao.evento_id) inner join atracao on (atracao.id = evento_atracao.atracao_id) where evento.id = 1 group by evento.id, evento.nome;

--Subconsultas
--Selecione todos os eventos que têm mais de 2 atrações.
select evento.id, evento.nome, count(*) as qtde from evento inner join evento_atracao on (evento.id = evento_atracao.evento_id) group by evento.id having count(*) > 2;
--Selecione todas as atrações que têm cachê maior que a média.
select * from atracao where cache > (select cast(avg(cast(cache as numeric(10,2))) as money) from atracao);
--Selecione todos os lotes que têm mais de 50 ingressos vendidos.
select lote_id, count(*) from ingresso group by lote_id having count(*) > 2;
-- off-topic: mostrando o nro do lote e o id do evento
select evento_id, lote.nro, count(*) as qtde from lote inner join ingresso on (lote.id = ingresso.lote_id) group by evento_id, lote.nro having count(*) > 2;
--Selecione todos os funcionários que trabalharam em mais de um evento.
select funcionario_id, count(evento_id) from evento_funcionario group by funcionario_id having count(evento_id) > 1;
-- Selecione todos os eventos que têm lotes com valor médio maior que 15.
select evento_id, cast(avg(cast(valor as numeric(10,2))) as money) as valor_medio from lote group by evento_id having avg(cast(valor as numeric(10,2))) > 15 order by evento_id;


--Consultas de Manipulação de Dados
--Atualize o valor dos lotes do evento 'HALLOWEEN' para 15.
UPDATE lote SET valor = 15 where evento_id = 1;
UPDATE lote SET valor = 15 where evento_id = (select id from evento where nome = 'HALLOWEEN');
--Delete todos os funcionários nascidos antes de 2000.
BEGIN;
DELETE FROM evento_funcionario where funcionario_id in (select funcionario.id from funcionario where extract(year from data_nascimento) > 2000);
DELETE FROM funcionario where extract(year from data_nascimento) > 2000;
COMMIT;
--Adicione uma nova atração 'BANDA XYZ' com cachê de 3000.00.
INSERT INTO atracao (nome, cache) VALUES
('BANDA XYZ', 3000.00);
--Crie uma nova tabela 'venda' com as colunas 'id', 'ingresso_id', 'data_venda' e 'valor_venda'.
CREATE TABLE venda (
    id serial primary key,
    ingresso_id integer references ingresso (id),
    data_venda date,
    valor_venda money
);
--Insira uma nova venda na tabela 'venda' para um ingresso específico.
BEGIN;
INSERT INTO ingresso (lote_id, observacao) values
(3, 'Quem comprou: Ronaldo');
INSERT INTO venda (ingresso_id, data_venda, valor_venda) values
(6, CURRENT_DATE, (SELECT valor from lote where lote.id = 3));
COMMIT;


--LEFT/RIGHT JOIN
--Selecione todos os eventos e, se houver, as atrações associadas a cada evento.
SELECT evento.id, evento.nome, atracao.id, atracao.nome FROM evento LEFT JOIN evento_atracao ON (evento.id = evento_atracao.evento_id) LEFT JOIN atracao on 
(atracao.id = evento_atracao.atracao_id) order by evento.id;
--Selecione todos os lotes e, se houver, os ingressos associados a cada lote.
select lote.id, lote.nro, ingresso.id from lote left join ingresso on (lote.id = ingresso.lote_id) order by evento_id, lote.id, lote.nro;
--Selecione todos os funcionários e, se houver, os eventos em que trabalharam.
INSERT INTO funcionario (nome, data_nascimento) VALUES
('FULANO', '2000-01-01');
select funcionario.id, funcionario.nome, evento.id, evento.nome from funcionario left join evento_funcionario on (funcionario.id = evento_funcionario.funcionario_id) left join evento on (evento.id = evento_funcionario.evento_id);
--Selecione todas as atrações e, se houver, os eventos em que se apresentaram.
INSERT INTO evento_atracao(evento_id, atracao_id, cache_recebido) VALUES
(2,3, 1.99);
select atracao.id, atracao.nome, evento.id, evento.nome from atracao left join evento_atracao on (atracao.id = evento_atracao.atracao_id) left join evento on (evento.id = evento_atracao.evento_id);

