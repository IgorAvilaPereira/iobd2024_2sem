DROP DATABASE IF EXISTS novembro;


CREATE DATABASE novembro;

\c novembro;

CREATE TABLE veiculo (
    id SERIAL PRIMARY KEY,
    placa VARCHAR(10),
    foto bytea, 
    ano INT
);

CREATE TABLE carro (
    numero_portas INT
) INHERITS (veiculo);

CREATE TABLE moto (
    cilindradas INT
) INHERITS (veiculo);



-- Inserir dados na superclasse
INSERT INTO veiculo (placa, ano) VALUES ('ABC1234', 2020);

-- Inserir dados nas subclasses
INSERT INTO carro (placa, ano, numero_portas) VALUES ('DEF5678', 2021, 4);

INSERT INTO moto (placa, ano, cilindradas) VALUES ('GHI9012', 2022, 150);

-- Consultar dados da superclasse (inclui dados das subclasses)
SELECT * FROM veiculo;

-- Consultar dados apenas da superclasse
SELECT * FROM ONLY veiculo;
