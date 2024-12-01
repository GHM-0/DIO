-- Inserts BY GPT

USE ecommerce;

SET foreign_key_checks = 0;
-- SET foreign_key_checks = 1;

-- Perfis independentes do TIPO pode ser vendedores/clientes
-- Podem ter _status = FALSE para fins de Historico
TRUNCATE TABLE Perfis;
INSERT INTO Perfis (nome, identificador, tipo, sexo, dataNascimento, razaoSocial, inscricaoEstadual) VALUES
('Carlos Souza', '111.222.333-44', 'PessoaFisica', 'M', '1991-03-15', NULL, NULL),                           -- Cliente
('TechStore', '12.345.678/0001-11', 'PessoaJuridica', NULL, NULL, 'TechStore', '987654321234'),              -- Vendedor
('Ana Lima', '555.666.777-88', 'PessoaFisica', 'F', '1982-12-16', NULL, NULL),                               -- Cliente
('Loja Eletrônica', '98.765.432/0001-22', 'PessoaJuridica', NULL, NULL, 'Loja Eletrônica', '123456789001'),  -- Vendedor
('Lucas Silva', '333.444.555-66', 'PessoaFisica', 'M', '2002-05-23', NULL, NULL),                            -- Cliente
('MegaStore', '22.334.455/0001-33', 'PessoaJuridica', NULL, NULL, 'MegaStore', '564738290100'),              -- Vendedor
('Bruno Augusto Santos','12.534.315/4501-33','PessoaFisica','M','2000-01-23',NULL,NULL);                     -- Vendedor


-- Podem ter _status = FALSE para fins de Historico
TRUNCATE TABLE Enderecos;
INSERT INTO Enderecos (CEP, estado, tipo, cidade, bairro, rua, numero, idPerfil) VALUES
('01010-001', 'SP', 'Residencial', 'São Paulo', 'Centro', 'Avenida Paulista', 500, 1),  -- Cliente Carlos
('02020-002', 'RJ', 'Comercial', 'Rio de Janeiro', 'Copacabana', 'Rua das Flores', 800, 2),  -- Vendedor TechStore
('03030-003', 'MG', 'Residencial', 'Belo Horizonte', 'Funcionários', 'Rua Amazonas', 1000, 3),  -- Cliente Ana
('04040-004', 'RS', 'Comercial', 'Porto Alegre', 'Centro', 'Rua dos Andradas', 1500, 4),  -- Vendedor Loja Eletrônica
('05050-005', 'PR', 'Residencial', 'Curitiba', 'Santa Felicidade', 'Rua XV de Novembro', 1200, 5),  -- Cliente Lucas
('06060-006', 'SP', 'Comercial', 'São Paulo', 'Vila Progredior', 'Rua da Liberdade', 900, 6),
('11160-006', 'RJ', 'Residencial', 'Niteroi', 'Santa Ana', 'Rua da Italia', 010, 7);  -- Vendedor MegaStore

-- Podem ter _status = FALSE para fins de Historico
TRUNCATE TABLE Contatos;
INSERT INTO Contatos (tipo, publico, detalhes, idPerfil) VALUES
('e-mail', FALSE, 'carlos@example.com', 1),  -- Cliente Carlos
('zap', TRUE, '999888777', 2),  -- Vendedor TechStore
('e-mail', FALSE, 'ana@example.com', 3),  -- Cliente Ana
('zap', TRUE, '912345678', 4),  -- Vendedor Loja Eletrônica
('e-mail', FALSE, 'lucas@example.com', 5),  -- Cliente Lucas
('zap', TRUE, '998877665', 6), -- Vendedor MegaStore
('zap', TRUE, '991271635', 7);

-- Podem ter _status = FALSE para fins de Historico
TRUNCATE TABLE FormasPagamento;
INSERT INTO FormasPagamento (metodo, detalhes, idPerfil) VALUES
('PIX', 'Chave Pix: techstore.pix', 2),  -- TechStore
('TRANSFER', 'Banco: 1234-5678', 4),     -- Loja Eletrônica
('PAYPAL', 'Banco: 9876-5432', 6),
('PIX', 'Chave Pix: cpf.pix', 7);       -- MegaStore

-- Podem ter _status = FALSE para fins de Historico
TRUNCATE TABLE Produtos ;
INSERT INTO Produtos (nome, categoria, descricao, unidade_referencia, fabricante, unidade_preco, idVendedor) VALUES
('Smartphone X100', 'INFORMATICA', 'Smartphone 8GB de RAM, 128GB', 'UNIDADE', 'TechStore Electronics', 2200.00, 2),  -- TechStore
('Notebook Gamer', 'INFORMATICA', 'Notebook com placa de vídeo GTX 1660Ti', 'UNIDADE', 'MegaStore Tech', 5000.00, 6),  -- MegaStore
('Fone de Ouvido Bluetooth', 'ELETRODOMESTICOS', 'Fone sem fio, com cancelamento de ruído', 'UNIDADE', 'Loja Eletrônica', 600.00, 4),  -- Loja Eletrônica
('Smart TV 55"', 'ELETRODOMESTICOS', 'TV LED 55 polegadas, 4K', 'UNIDADE', 'TechStore Electronics', 3000.00, 2),  -- TechStore
('Geladeira Duplex', 'ELETRODOMESTICOS', 'Geladeira Frost Free 450L', 'UNIDADE', 'MegaStore Appliances', 2500.00, 6),
('Smart TV 75"', 'ELETRODOMESTICOS', 'TV LED 75 polegadas, 4K', 'UNIDADE', 'TechStore Electronics', 3000.00, 7);  -- MegaStore


-- Podem ter quantidade = 0, o que o torna indisponivel para venda
TRUNCATE TABLE Estoque;
INSERT INTO Estoque (idVendedor, idProduto, quantidade) VALUES
(2, 1, 120),  -- TechStore: Smartphone X100
(6, 2, 80),  -- MegaStore: Notebook Gamer
(4, 3, 150),  -- Loja Eletrônica: Fone de Ouvido
(2, 4, 50),  -- TechStore: Smart TV 55"
(2, 4, 50),
(6, 5, 60);  -- MegaStore: Geladeira Duplex

-- Pedidos com Vários Itens e Status Diferentes
TRUNCATE TABLE Pedidos;
INSERT INTO Pedidos (idCliente, _status, valor_total, idFormaPagamento, data_pagamento) VALUES
(1, 'Aprovado', 3200.00, 1, '2024-11-01'),  -- Pedido Carlos (PIX)
(3, 'Aprovado', 5600.00, 2, '2024-11-02'),  -- Pedido Ana (TRANSFER)
(5, 'Cancelado', 3000.00, 3, '2024-11-03');  -- Pedido Lucas (BOLETO)

--
TRUNCATE TABLE PedidoItens;
INSERT INTO PedidoItens (idPedido, idProduto, quantidade, impostos, frete_item) VALUES
(1, 1, 1, 200.00, 50.00),  -- Carlos: 1 Smartphone X100
(1, 4, 1, 300.00, 70.00),  -- Carlos: 1 Smart TV 55"
(2, 2, 1, 500.00, 100.00),  -- Ana: 1 Notebook Gamer
(2, 3, 2, 120.00, 40.00),  -- Ana: 2 Fones de Ouvido
(3, 5, 1, 250.00, 60.00);  -- Lucas: 1 Geladeira Duplex

--
TRUNCATE TABLE Entregas ;
INSERT INTO Entregas (idPedido, idItem, _status, codRastreio, clienteEndereco, remetenteEndereco, quantidade, enviado) VALUES
(1, 1, 'Enviado', 'ABC123XYZ', 1, 2, 1, '2024-11-02'),  -- Entrega Carlos: Smartphone
(1, 4, 'Enviado', 'XYZ789ABC', 1, 2, 1, '2024-11-03'),  -- Entrega Carlos: TV
(2, 2, 'Enviado', 'DEF456LMN', 3, 4, 1, '2024-11-04'),  -- Entrega Ana: Notebook
(2, 3, 'Enviado', 'DEF456LMN', 3, 4, 1, '2024-11-05'),  -- Entrega Ana: 1 Fone
(2, 3, 'Enviado', 'DEF457LMN', 3, 4, 1, '2024-11-06');  -- Entrega Ana: 1 Fone (parcial)


