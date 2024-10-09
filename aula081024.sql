
-- Selecione todos os eventos que têm mais de 2 atrações.
select evento.id, evento.nome as qtde from evento inner join evento_atracao on (evento.id = evento_atracao.evento_id) GROUP BY evento.id having count(*) > 2;


-- selecione todas as atrações que têm cachê maior que a média.
CREATE VIEW media_cache as select cast(avg(cast(cache as 
numeric(8,2))) as money)as media from atracao; 

select * from atracao where cache > (select media from media_cache);

-- exemplo case when -> materia nova junto de jdbc + schemas 
select *,   CASE 
         WHEN cast(cache as numeric(8,2)) > 1000 THEN 'caro' 
         WHEN cast(cache as numeric(8,2)) < 10 THEN 'barato'
       ELSE 'n sei' END as perspectiva_david from atracao;

-- Selecione todos os lotes que têm mais de 50 ingressos vendidos.
select lote_id, count(*) from ingresso group by lote_id having count(*) > 50;

-- Selecione todos os funcionários que trabalharam em mais de um evento.
select evento_id, evento.nome, count(*) from evento_funcionario inner join evento on (evento.id = evento_funcionario.evento_id) group by evento_id, evento.nome having count(*) > 1;


-- Selecione todos os eventos que têm lotes com valor médio maior que 15.
select evento_id, avg(valor::numeric(8,2))::money from lote group by evento_id having avg(valor::numeric(8,2))::money > 15::money;


 select evento_id, cast(avg(cast(valor as numeric(8,2))) as money) from lote group by evento_id having avg(cast(valor as numeric(8,2))) > avg(cast(15 as numeric(8,2)));


-- Selecione todos os eventos que têm funcionários recebendo mais de 100 em cachê.                           
select * from evento where evento.id in (select evento_id from evento_funcionario where valor_recebido::numeric(8,2) > 100);

-- Selecione todos os lotes que têm ingressos com observações específicas.
-- distinct faz com que o lote_id n se repita
SELECT distinct lote_id from ingresso where observacao is not null;

-- Selecione todos os eventos que têm atrações com cachê maior que 2000.
select * from atracao where cache > cast(2000 as money);

