CREATE DATABASE uber;

-- Criando as tabelas:
CREATE TABLE motoristas (
id INT NOT NULL AUTO_INCREMENT UNIQUE,
nome VARCHAR(30) NOT NULL,
placa_veiculo VARCHAR(7) NOT NULL,
avaliacao_media DECIMAL(3,2) NOT NULL,

PRIMARY KEY (id)
);

CREATE TABLE passageiros (
id INT NOT NULL AUTO_INCREMENT UNIQUE,
nome VARCHAR(30) NOT NULL,
telefone VARCHAR(14) NOT NULL,

PRIMARY KEY (id)
);

CREATE TABLE viagens (
id INT NOT NULL AUTO_INCREMENT UNIQUE,
id_motorista INT NOT NULL,
id_passageiro INT NOT NULL,
data_hora DATETIME NOT NULL,
origem VARCHAR(30) NOT NULL,
destino VARCHAR(30) NOT NULL,
distancia_km INT NOT NULL,
preco DECIMAL(5,2) NOT NULL,

FOREIGN KEY (id_motorista) REFERENCES motoristas(id),
FOREIGN KEY (id_passageiro) REFERENCES passageiros(id),
PRIMARY KEY (id)
);


-- Inserindo valores às tabelas:
INSERT INTO motoristas VALUES
(DEFAULT, 'Fernando', 'ABC1D23', 4.77),
(DEFAULT, 'Roberta', 'EFG4H56', 5.00),
(DEFAULT, 'Lucas', 'IJK78L9', 3.00),
(DEFAULT, 'Mariana', 'ZDB6E87', 4.55),
(DEFAULT, 'Nicolas', 'LQG3P54', 2.80)
;

SELECT * FROM motoristas;

INSERT INTO passageiros VALUES
(DEFAULT, 'Vitor', '(51)99999-9999'),
(DEFAULT, 'Laura', '(51)98888-8888'),
(DEFAULT, 'Heitor', '(51)97777-7777'),
(DEFAULT, 'Gabriela', '(51)96666-6666'),
(DEFAULT, 'Michel', '(51)95555-5555'),
(DEFAULT, 'Nicole', '(51)94444-4444'),
(DEFAULT, 'Benjamin', '(51)93333-3333')
;

SELECT * FROM passageiros;

INSERT INTO viagens VALUES
(DEFAULT, 1, 1, '2023-01-30 10:00:00', 'São Leopoldo', 'Canudos', 11.8, 22.90),
(DEFAULT, 1, 2, '2023-02-27 11:00:00', 'Esteio', 'Caxias do Sul', 104.0, 158.58),
(DEFAULT, 1, 3, '2023-03-25 12:00:00', 'Erechim', 'Estância Velha', 337.0, 469.96),
(DEFAULT, 2, 4, '2023-04-20 13:00:00', 'Guaíba', 'Gravataí', 49.90, 69.93),
(DEFAULT, 2, 5, '2023-05-17 14:00:00', 'Viamão', 'Cachoeirinha', 18.2, 31.47),
(DEFAULT, 2, 6, '2023-06-15 15:00:00', 'Alvorada', 'Eldorado do Sul', 28.0, 34.99),
(DEFAULT, 2, 7, '2023-07-10 16:00:00', 'Sapiranga', 'Novo Hamburgo', 16.6, 26.90),
(DEFAULT, 4, 3, '2023-08-07 17:00:00', 'Parobé', 'Ivoti', 41.4, 63.85),
(DEFAULT, 4, 4, '2023-09-05 18:00:00', 'Montenegro', 'Portão', 27.8, 49.97),
(DEFAULT, 4, 5, '2023-10-03 19:00:00', 'Canela', 'Campo Bom', 74.8, 140.48)
;

SELECT * FROM viagens;


-- Atualizando as tabelas:
SET SQL_SAFE_UPDATES = 0;
UPDATE motoristas SET placa_veiculo = 'DEF789' WHERE nome = 'Róger';
UPDATE motoristas SET avaliacao_media = 0.5 WHERE avaliacao_media >= 4.0;
UPDATE viagens SET preco = 20.0 WHERE data_hora < '2023-06-01';
UPDATE viagens SET destino = 'Porto Alegre' WHERE origem = 'São Leopoldo';
UPDATE viagens SET preco = 250.00 WHERE id_motorista = 1 AND id_passageiro = 2;
UPDATE passageiros SET telefone = '(51)91111-1111' WHERE nome = 'Vitor';
UPDATE passageiros SET nome = 'Isabela' WHERE telefone = '(51)96666-6666';


-- Selecionando e retornando valores das tabelas:
-- Retornando o nome do motorista, o nome do passageiro e a distância percorrida para todas as viagens com mais de 10 km.
SELECT m.nome AS nome_motorista, p.nome AS nome_passageiro, v.distancia_km FROM viagens v
JOIN motoristas m ON v.id_motorista = m.id
JOIN passageiros p ON v.id_passageiro = p.id WHERE CAST(v.distancia_km AS DECIMAL(8,2)) > 40.0;

-- Retornando a avaliação média dos motoristas:
SELECT AVG(avaliacao_media) FROM motoristas;

-- Listando todos os motoristas que ainda não fizeram nenhuma viagem:
SELECT m.nome FROM motoristas m LEFT JOIN viagens v ON m.id = v.id_motorista WHERE v.id IS NULL;

-- Listando a média de distância percorrida por todas as viagens e a média de preço das viagens:
SELECT AVG(distancia_km), AVG(preco) FROM viagens;


-- Deletando viagens:
DELETE FROM viagens WHERE distancia_km < 5.0;
DELETE FROM viagens WHERE data_hora < '2023-08-30 15:30:00';
DELETE FROM motoristas WHERE nome = 'Lucas';
DELETE FROM passageiros WHERE telefone = '(51)94444-4444';
DELETE FROM viagens WHERE preco > 200.00;
DELETE FROM viagens WHERE id_motorista = 1;

DELETE FROM viagens;

SELECT * FROM viagens;
