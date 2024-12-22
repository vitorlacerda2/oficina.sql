-- Criação do banco de dados e tabelas
CREATE DATABASE Oficina;
USE Oficina;

-- Tabela Cliente
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    endereco VARCHAR(255),
    telefone VARCHAR(15)
);

-- Tabela Veículo
CREATE TABLE Veiculo (
    id_veiculo INT PRIMARY KEY,
    id_cliente INT,
    modelo VARCHAR(100),
    ano INT,
    tipo VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabela Serviço
CREATE TABLE Servico (
    id_servico INT PRIMARY KEY,
    nome VARCHAR(100),
    descricao TEXT,
    preco DECIMAL(10, 2)
);

-- Tabela Ordem de Serviço
CREATE TABLE OrdemServico (
    id_ordem INT PRIMARY KEY,
    id_cliente INT,
    id_veiculo INT,
    data_criacao DATE,
    status VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
);

-- Tabela Item de Ordem
CREATE TABLE ItemOrdem (
    id_item INT PRIMARY KEY,
    id_ordem INT,
    id_servico INT,
    quantidade INT,
    valor DECIMAL(10, 2),
    FOREIGN KEY (id_ordem) REFERENCES OrdemServico(id_ordem),
    FOREIGN KEY (id_servico) REFERENCES Servico(id_servico)
);

-- Inserção de dados de teste
INSERT INTO Cliente (id_cliente, nome, endereco, telefone) VALUES
(1, 'João Silva', 'Rua A, 123', '111234567'),
(2, 'Maria Souza', 'Rua B, 456', '112345678');

INSERT INTO Veiculo (id_veiculo, id_cliente, modelo, ano, tipo) VALUES
(1, 1, 'Fusca', 1985, 'Carro'),
(2, 2, 'Gol', 2010, 'Carro');

INSERT INTO Servico (id_servico, nome, descricao, preco) VALUES
(1, 'Troca de Óleo', 'Troca do óleo do motor', 100.00),
(2, 'Balanceamento', 'Balanceamento das rodas', 50.00);

INSERT INTO OrdemServico (id_ordem, id_cliente, id_veiculo, data_criacao, status) VALUES
(1, 1, 1, '2024-12-22', 'Em andamento'),
(2, 2, 2, '2024-12-21', 'Finalizada');

INSERT INTO ItemOrdem (id_item, id_ordem, id_servico, quantidade, valor) VALUES
(1, 1, 1, 1, 100.00),
(2, 2, 2, 1, 50.00);

-- Consultas SQL Complexas

-- a) Recuperação Simples com SELECT:
SELECT nome, endereco FROM Cliente;

-- b) Filtros com WHERE:
SELECT nome, telefone FROM Cliente WHERE endereco LIKE 'Rua A%';

-- c) Expressões para Atributos Derivados:
SELECT nome, preco, preco * 1.10 AS preco_com_desconto FROM Servico;

-- d) Ordenação com ORDER BY:
SELECT nome, telefone FROM Cliente ORDER BY nome DESC;

-- e) Filtros em Grupos com HAVING:
SELECT nome, SUM(valor) AS total_servicos
FROM Servico
JOIN ItemOrdem ON Servico.id_servico = ItemOrdem.id_servico
GROUP BY nome
HAVING SUM(valor) > 100;

-- f) Junções entre Tabelas:
SELECT Cliente.nome, Veiculo.modelo, OrdemServico.status
FROM Cliente
JOIN Veiculo ON Cliente.id_cliente = Veiculo.id_cliente
JOIN OrdemServico ON Veiculo.id_veiculo = OrdemServico.id_veiculo
WHERE OrdemServico.status = 'Em andamento';

