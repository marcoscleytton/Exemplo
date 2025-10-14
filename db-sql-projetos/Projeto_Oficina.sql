CREATE DATABASE Projeto_Oficina

USE Projeto_Oficina

CREATE TABLE Cliente (
    cliente_id INT PRIMARY KEY,
    nome VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE Veiculo (
    veiculo_id INT PRIMARY KEY,
    placa VARCHAR(10),
    modelo VARCHAR(50),
    ano INT,
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id)
);

CREATE TABLE Servico (
    servico_id INT PRIMARY KEY,
    descricao VARCHAR(200),
    preco DECIMAL(10, 2)
);

CREATE TABLE OrdemServico (
    ordem_id INT PRIMARY KEY,
    data DATE,
    veiculo_id INT,
    FOREIGN KEY (veiculo_id) REFERENCES Veiculo(veiculo_id)
);

CREATE TABLE ItemServico (
    item_id INT PRIMARY KEY,
    ordem_id INT,
    servico_id INT,
    FOREIGN KEY (ordem_id) REFERENCES OrdemServico(ordem_id),
    FOREIGN KEY (servico_id) REFERENCES Servico(servico_id)
);


-- Recuperação simples de clientes e seus veículos
SELECT c.nome AS cliente, v.placa, v.modelo
FROM Cliente c
INNER JOIN Veiculo v ON c.cliente_id = v.cliente_id;

-- Filtro de serviços com preço:
SELECT descricao, preco
FROM Servico
WHERE preco > 0;

-- Total gasto por cliente em serviços:
SELECT c.nome AS cliente, SUM(s.preco) AS total_gasto
FROM Cliente c
INNER JOIN Veiculo v ON c.cliente_id = v.cliente_id
INNER JOIN OrdemServico os ON v.veiculo_id = os.veiculo_id
INNER JOIN ItemServico isv ON os.ordem_id = isv.ordem_id
INNER JOIN Servico s ON isv.servico_id = s.servico_id
GROUP BY c.nome;

-- Serviços mais caros ordenados por preço:
SELECT descricao, preco
FROM Servico
ORDER BY preco DESC;

-- Quantidade de serviços por veículo:
SELECT v.placa, COUNT(isv.item_id) AS total_servicos
FROM Veiculo v
LEFT JOIN OrdemServico os ON v.veiculo_id = os.veiculo_id
LEFT JOIN ItemServico isv ON os.ordem_id = isv.ordem_id
GROUP BY v.placa;
