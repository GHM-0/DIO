USE oficina;

-- Disable foreign key checks
SET foreign_key_checks = 0;

-- Clientes
TRUNCATE TABLE Clientes;
INSERT INTO Clientes (nome, identificador, tipo, dataNascimento, sexo, razaoSocial, inscricaoEstadual, _status) VALUES
('João Silva', '123.456.789-00', 'PF', '1980-01-01', 'M', NULL, NULL, TRUE),
('Maria Oliveira', '987.654.321-00', 'PF', '1990-02-02', 'F', NULL, NULL, TRUE),
('Empresa ABC Ltda', '12.345.678/0001-00', 'PJ', NULL, NULL, 'Empresa ABC Ltda', '123456789', TRUE),
('Empresa XYZ S.A.', '98.765.432/0001-00', 'PJ', NULL, NULL, 'Empresa XYZ S.A.', '987654321', TRUE);

-- Contatos
TRUNCATE TABLE Contatos;
INSERT INTO Contatos (tipo, detalhes, idCliente, _status) VALUES
('e-mail', 'joao.silva@example.com', 1, TRUE),
('zap', '(11) 99999-9999', 2, TRUE),
('e-mail', 'empresa.abc@example.com', 3, TRUE),
('telefone', '(31) 3333-3333', 4, TRUE);

-- FormasPagamento
TRUNCATE TABLE FormasPagamento;
INSERT INTO FormasPagamento (metodo, detalhes, idCliente, _status) VALUES
('PIX', '12345678901', 1, TRUE),
('TRANSFER', 'Banco do Brasil 123456-7', 2, TRUE),
('PAYPAL', 'empresa.abc@paypal.com', 3, TRUE),
('BOLETO', 'Empresa XYZ S.A.', 4, TRUE);

-- Enderecos
TRUNCATE TABLE Enderecos;
INSERT INTO Enderecos (CEP, estado, tipo, cidade, bairro, rua, numero, complemento, idCliente, _status) VALUES
('12345678', 'RJ', 'Residencial', 'Rio de Janeiro', 'Centro', 'Rua 1', 100, 'Apto 101', 1, TRUE),
('87654321', 'SP', 'Comercial', 'São Paulo', 'Jardins', 'Avenida Paulista', 200, NULL, 2, TRUE),
('11223344', 'ES', 'Comercial', 'Vitória', 'Praia do Canto', 'Rua 2', 300, 'Sala 202', 3, TRUE),
('44556677', 'RJ', 'Residencial', 'Niterói', 'Icaraí', 'Rua 3', 400, 'Casa 1', 4, TRUE);

-- Veiculos
TRUNCATE TABLE Veiculos;
INSERT INTO Veiculos (fabricante, modelo, cor, tipo, ano, placa, idCliente) VALUES
('Ford', 'Fiesta', 'Vermelho', 'Carro', 2010, 'ABC-1234', 1),
('Honda', 'Civic', 'Preto', 'Carro', 2015, 'DEF-5678', 2),
('Volkswagen', 'Gol', 'Branco', 'Carro', 2012, 'GHI-9012', 3),
('Toyota', 'Corolla', 'Prata', 'Carro', 2018, 'JKL-3456', 4),
('Volkswagen', 'Gol', 'Branco', 'Carro', 2015, 'HJK-0900', 4);

-- Itens
TRUNCATE TABLE Item;
INSERT INTO Item (nome, fabricante, descricao, modelo_ref, quantidade, valor_uni) VALUES
('Pneu', 'Michelin', 'Pneu aro 15', '155/70R13', 10, 250.00),
('Óleo', 'Castrol', 'Óleo 5W30', '5W30', 20, 50.00),
('Motor', 'Volkswagen', 'Motor Gol 2016', 'GOL20', 1, 6400.00);

-- Funcionarios
TRUNCATE TABLE Funcionarios;
INSERT INTO Funcionarios (nome, cargo, admissao) VALUES
('José Silva e Souza', 'Mecânico', '2020-01-01'),
('Ordowaldo Mendes Junior', 'Auxiliar Mecânico', '2020-02-13'),
('Ana Paula Brantes Lima Pacheco', 'Pintora veicular', '2020-04-14'),
('Jr. Souza Brasil', 'Auxiliar de Funilaria & Pintura', '2021-02-28'),
('Jose Geraldo Lima Onofre', 'Funileiro', '2020-01-12');

-- Serviços
TRUNCATE TABLE Servicos;
INSERT INTO Servicos (nome, descricao, prazo, tipo, valor) VALUES
('Troca de Pneu', 'Troca de pneu danificado', 1, 'Substituição', 50.00),
('Troca de Óleo', 'Troca de óleo do motor', 2, 'Substituição', 100.00),
('Verificação de Freios', 'Verificação dos freios do veículo', 1, 'Verificação', 30.00),
('Higienização', 'Higienização completa', 2, 'Higienização', 170.00);

-- Funções
TRUNCATE TABLE Funcao;
INSERT INTO Funcao (nome) VALUES
('Mecânica'),
('Higienização'),
('Pintura'),
('Lanternagem');

-- Equipes
TRUNCATE TABLE Equipes;
INSERT INTO Equipes (idFuncao, idServico) VALUES
(1, 1),
(1, 2),
(1, 3),                                          -- E1 S1 S2 S3
(2, 4);                                          -- E2 S4

-- mao_de_obra por hora
TRUNCATE TABLE EquipeFuncionarios;
INSERT INTO EquipeFuncionarios (funcao, mao_de_obra, idFuncionario, idEquipe, responsavel, _status) VALUES
('Mecânico', 50.00, 1, 1, TRUE, TRUE),
('Auxiliar', 30.00, 2, 1, FALSE, TRUE),
('Pintor', 40.00, 3, 2, TRUE, TRUE);


-- OrdensServicos
TRUNCATE TABLE OrdensServicos;
INSERT INTO OrdensServicos (valor, finalizacao, idVeiculo, idServico, idEquipe, idCliente, _status) VALUES
(50 + 30 + 50 + 250, '2023-01-01', 1, 1, 1, 1, 'Concluído'),  -- Troca de Pneu
(50 + 100 + 50, '2023-01-02', 2, 2, 1, 2, 'Aguardando'),     -- Troca de Óleo
(50 + 30 + 50 + 250, '2023-01-03', 3, 1, 1, 3, 'Concluído');  -- Troca de Pneu + Pneu

TRUNCATE TABLE Relatorios;
INSERT INTO Relatorios (conteudo, idOrdemServico, responsavel) VALUES
('Relatório sobre a manutenção do veículo Ford Fiesta, com revisão de motor e suspensão.', 1, 1),  -- Responsável: Funcionário com ID 1
('Relatório sobre a substituição de peças no Honda Civic, com troca de pastilhas de freio.', 2, 2),  -- Responsável: Funcionário com ID 2
('Relatório sobre a verificação do Volkswagen Gol, incluindo inspeção geral e troca de óleo.', 3, 3), -- Responsável: Funcionário com ID 3
('Relatório sobre a higienização do Toyota Corolla, com revisão de sistemas de ventilação.', 4, 4); -- Responsável: Funcionário com ID 4


TRUNCATE TABLE ItensReposicao;
INSERT INTO ItensReposicao(quantidade, idOrdemServico, idItem) VALUES
(1, 1, 1),   -- Ordem de Serviço 1: Pneu (1 unidade de Pneu)
(1, 2, 2),   -- Ordem de Serviço 2: Óleo (1 unidade de Óleo)
(1, 3, 1);   -- Ordem de Serviço 3: Pneu (1 unidade de Pneu)


TRUNCATE TABLE PagamentosOrdensServico;
INSERT INTO PagamentosOrdensServico (idPagamento, idOrdemServico) VALUES
(1, 1),  -- Pagamento 1 (Ordem de Serviço 1 - Troca de Pneu)
(2, 2),  -- Pagamento 2 (Ordem de Serviço 2 - Troca de Óleo)
(3, 3);  -- Pagamento 3 (Ordem de Serviço 3 - Troca de Pneu)

TRUNCATE TABLE Pagamentos;
INSERT INTO Pagamentos (idFormaPagamento, valor_total, dataVencimento, _status)
VALUES
(1, 430.00, '2023-01-01', TRUE),  -- Pagamento da Ordem de Serviço 1 (Troca de Pneu)
-- Pagamento para a Ordem de Serviço 2
(2, 180.00, '2023-01-02', FALSE),  -- Pagamento da Ordem de Serviço 2 (Troca de Óleo)
-- Pagamento para a Ordem de Serviço 3
(3, 430.00, '2023-01-03', TRUE);  -- Pagamento da Ordem de Serviço 3 (Troca de Pneu + Pneu)

-- Inserção de Pagamentos referentes a multiplas ordens de serviço
-- Criando duas novas Ordens de Serviço para o Cliente 1 (João Silva)
INSERT INTO OrdensServicos (valor, finalizacao, idVeiculo, idServico, idEquipe, idCliente, _status)
VALUES
(50 + 30 + 50 + 250, '2023-02-01', 1, 1, 1, 1, 'Aguardando'),  -- Ordem de Serviço 4 para Cliente 1
(100 + 50 + 50, '2023-02-02', 1, 2, 1, 1, 'Aguardando');       -- Ordem de Serviço 5 para Cliente 1

-- Associando o pagamento a essas duas Ordens de Serviço
INSERT INTO PagamentosOrdensServico (idPagamento, idOrdemServico)
VALUES
(4, 4),  -- Pagamento 4 (Ordem de Serviço 4 - Troca de Pneu)
(4, 5);  -- Pagamento 4 (Ordem de Serviço 5 - Troca de Óleo)

-- Criando um novo pagamento que será associado a ambas as ordens de serviço
INSERT INTO Pagamentos (idFormaPagamento, valor_total, dataVencimento, _status)
VALUES
(1, 50 + 30 + 50 + 250 + 100 + 50 + 50, '2023-02-03', TRUE);  -- Pagamento total para as ordens de serviço 4 e 5

