-- group by e formatcao de datas
select to_char(data_hora_inicio::date, 'dd/mm/yyyy') as data_evento, count(*) as qtde from evento group by data_evento order by data_evento desc;

INSERT INTO evento(data_hora_inicio, nome) values ('2024-09-13 13:00:00', 'show da xuxa');

-- exemplo view
CREATE VIEW cache_total_por_atracao AS select atracao_id, atracao.nome, sum(cache_recebido) as total from evento_atracao inner join atracao on (atracao.id = evento_atracao.atracao_id) group by atracao_id, atracao.nome order by atracao_id asc;

-- count()
select evento_id, evento.nome, count(*) from lote inner join evento on (lote.evento_id = evento.id) group by evento_id, evento.nome order by evento.nome;

select evento.nome as evento_nome, atracao.nome as atracao_nome from evento inner join evento_atracao on (evento.id = evento_atracao.evento_id) inner join atracao on (atracao.id = evento_atracao.atracao_id) order by evento.id, atracao.id;

-- string_Agg
select evento.nome as evento_nome, STRING_AGG(atracao.nome, ',') as atracao_nome from evento inner join evento_atracao on (evento.id = evento_atracao.evento_id) inner join atracao on (atracao.id = evento_atracao.atracao_id) GROUP BY evento_nome;

-- exemplo de duas formas de casting
select atracao_id, cast(avg(cache_recebido::numeric(8,2)) as money) as media from evento_atracao group by atracao_id;

-- possibilidade 1 - coalesce (retorna o primeiro valor n nulo entre parenteses)
select evento.id, evento.nome, coalesce(sum(qtde*valor), 0::money) from evento left join lote on (evento.id = lote.evento_id) group by evento.id, evento.nome order by evento.nome;


-- possibilidade 2 - case when (if)
select evento.id, evento.nome, case when sum(qtde*valor) > 0::money then sum(qtde*valor) else 0::money end from evento left join lote on (evento.id = lote.evento_id) group by evento.id, evento.nome order by evento.nome;


-- possibilidade 3 - concatenacao do cifrao
select evento.id, evento.nome, 'R$ '||case when sum(qtde*valor::numeric(8,2)) > 0 then sum(qtde*valor::numeric(8,2))::text else 0::numeric(8,2)::text end from evento left join lote on (evento.id = lote.evento_id) group by evento.id, evento.nome order by evento.nome;

 select evento_id, count(*) from lote inner join  ingresso on (lote.id = ingresso.lote_id) group by evento_id;

-- possibilidade 1: Materia nova - Common Table Expressions
WITH tabela_aux AS (
     select 
        evento_id, 
        evento.nome,
        count(*)*valor as sub_total 
    from evento inner join lote on (evento.id = lote.evento_id) 
        inner join ingresso on (lote.id = ingresso.lote_id) 
    group by evento_id, evento.nome, lote.id
) 
SELECT evento_id, nome, SUM(sub_total) as total from tabela_aux group by evento_id, nome;

-- possibilidade 2 (com view)
 CREATE VIEW tabela_aux as select 
        evento_id, 
        evento.nome,
        count(*)*valor as sub_total 
    from evento inner join lote on (evento.id = lote.evento_id) 
        inner join ingresso on (lote.id = ingresso.lote_id) 
    group by evento_id, evento.nome, lote.id;

 SELECT evento_id, nome, SUM(sub_total) as total from tabela_aux group by evento_id, nome;






