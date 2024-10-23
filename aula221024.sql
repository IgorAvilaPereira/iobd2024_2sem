-- exe1
select id, nome, 
    to_char(data_nascimento, 'dd/mm/yyyy') as dt_nascimento,            
    extract(year from age(data_nascimento)) as idade,     
    case
        when extract(dow from data_nascimento) = 0 then 'domingo'
        when extract(dow from data_nascimento) = 1 then 'segunda'
        when extract(dow from data_nascimento) = 2 then 'terça'
        when extract(dow from data_nascimento) = 3 then 'quarta'
        when extract(dow from data_nascimento) = 4 then 'quinta'
        when extract(dow from data_nascimento) = 5 then 'sexta'
        when extract(dow from data_nascimento) = 6 then 'sábado' 
    end as dia_semana 
from funcionario;

-- exe2
select * from evento where data_hora_inicio > CURRENT_DATE;


-- exe3
UPDATE evento SET data_hora_fim = data_hora_inicio + INTERVAL '10 hours';
select evento.nome, data_hora_fim - data_hora_inicio as duracao from evento;
ALTER TABLE ingresso ADD COLUMN data_venda date DEFAULT CURRENT_DATE;

-- exe4
select extract(month from data_venda) as mes, count(*) as qtde from ingresso group by extract(month from data_venda) order by extract(month from data_venda);

-- exe5
select funcionario.nome from evento_funcionario inner join funcionario on (funcionario.id = evento_funcionario.funcionario_id) inner join evento on (evento.id = evento_funcionario.evento_id) where extract(year from data_hora_inicio) = EXTRACT(YEAR from current_Date) - 1;

-- ok!
SELECT * FROM evento where extract(month from data_hora_inicio) = 9 and extract(year from data_hora_inicio) = 2024;

-- talvez
select * from evento where data_hora_inicio between '2024-09-01' and '2024-09-30';

-- N recomendamos
SELECT * FROM evento where data_hora_inicio::TEXT LIKE '2024-09-%';

-- exe7
select atracao.nome, data_hora_fim - data_hora_inicio as duracao from atracao join evento_atracao on (atracao.id = evento_atracao.atracao_id); 

balada=# UPDATE evento_funcionario SET data_hora_entrada = CURRENT_TIMESTAMP, data_hora_saida = CURRENT_TIMESTAMP + INTERVAL '3 Hours';

select funcionario.id, funcionario.nome, sum(data_hora_saida - data_hora_entrada) as duracao from funcionario inner join evento_funcionario on (funcionario.id = evento_funcionario.funcionario_id) group by funcionario.id, funcionario.nome -- having extract(hour from sum(data_hora_saida - data_hora_entrada)) >= 13 order by funcionario.id; 



