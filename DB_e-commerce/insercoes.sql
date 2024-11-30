USE ecommerce;

-- Problemas:
-- Não sendo uma base de dados real, não é consistenete nem para a maioria dos casos de teste, tendo apenas um avalor demonstrativo

SET foreign_key_checks = 0;

TRUNCATE TABLE Clientes;
INSERT INTO Clientes (nome, identificador, _status)
VALUES
  -- Pessoa Física
      ('João Silva', '123.456.789-00', TRUE),                                      -- 01
      ('Maria Oliveira', '987.654.321-00', TRUE),                                  -- 02
      ('Carlos Almeida', '111.222.333-44', TRUE),                                  -- 03
      ('Ana Pereira', '222.333.444-75', TRUE),                                     -- 04
      ('Roberto Lima', '333.444.555-67', FALSE),                                   -- 05
      ('Fernanda Costa', '444.555.666-77', FALSE),                                 -- 06
      ('Luciana Santos', '555.666.777-88', FALSE),                                 -- 07
      ('Paulo Souza', '666.777.888-99', FALSE),                                    -- 08
      ('Renato Torres', '777.888.999-00', TRUE),                                   -- 09
      ('Beatriz Lopes', '888.999.000-11', TRUE),                                   -- 10
      ('Pedro Gomes', '999.000.111-22', TRUE),                                     -- 11
      ('Tatiane Rocha', '000.111.222-33', TRUE),                                   -- 12
      ('Ricardo Mendes', '111.222.333-54', TRUE),                                  -- 13
      ('Carolina Andrade', '222.333.444-55', TRUE),                                -- 14
      ('Gabriel Fernandes', '333.444.555-66', TRUE),                               -- 15

  -- Pessoa Jurídica
      ('A&F Revenda Material de Escritório', '11.111.111/0001-99', TRUE),          -- 16   CAT 1
      ('Overclock Informática LTDA', '22.222.222/0002-88', TRUE),                  -- 17   CAT 1 2
      ('DasPrints Tonners e Tintas', '33.333.333/0003-77', TRUE),                  -- 18   CAT 1
      ('WarLoard Games &CO', '44.444.444/0004-66', TRUE),                          -- 19   CAT 1 5
      ('ElectroHouse', '55.555.555/0005-44', FALSE),                               -- 20   CAT 1 2 6
      ('Killing Giants', '66.666.666/0006-33', FALSE),                             -- 21   CAT 5
      ('MotherBoard .inc', '77.777.777/0007-22', FALSE),                           -- 22   CAT 1
      ('Beauty and Co', '88.888.888/0008-11', FALSE),                              -- 23   CAT 4
      ('Doginho is Life Petshop', '99.999.999/0009-10', TRUE),                     -- 24   CAT 3
      ('Casa e Co', '10.101.010/0010-01', TRUE),                                   -- 25   CAT 6
      ('Player House', '20.202.020/0020-02', TRUE),                                -- 26   CAT 1 2
      ('Small Idols ActionFigures', '30.303.030/0030-03', TRUE),                   -- 27   CAT 5
      ('The Band', '40.404.040/0040-04', TRUE),                                    -- 28   CAT 4
      ('JFF Informática', '50.505.050/0050-05', TRUE),                             -- 29   CAT 1
      ('The Big O', '60.606.060/0060-06', TRUE);                                   -- 30   CAT 6

TRUNCATE TABLE PessoaFisica;
INSERT INTO PessoaFisica(dataNascimento, sexo, idCliente)
VALUES
    ('1964-11-28','M',1),
    ('1963-11-28','F',2),
    ('2011-11-28','M',3),
    ('2001-11-28','F',4),
    ('2002-11-28','M',5),
    ('1993-11-28','F',6),
    ('2005-11-28','F',7),
    ('1994-11-28','M',8),
    ('2014-11-28','M',9),
    ('2006-11-28','F',10),
    ('2009-11-28','M',11),
    ('1998-11-28','F',12),
    ('2010-11-28','M',13),
    ('1992-11-28','F',14),
    ('2013-11-28','M',15);

TRUNCATE TABLE PessoaJuridica;
INSERT INTO PessoaJuridica(razaoSocial, inscricaoEstadual, idCliente)
VALUES
    ('Empresa A','002909389',16),
    ('Empresa B','339889988',17),
    ('Empresa C','553444451',18),
    ('Empresa D','773565555',19),
    ('Empresa E','144242445',20),
    ('Empresa F','553444444',21),
    ('Empresa G','535442566',22),
    ('Empresa H','132345236',23),
    ('Empresa I','134256627',24),
    ('Empresa J','245637667',25),
    ('Empresa K','453465666',26),
    ('Empresa L','233666666',27),
    ('Empresa M','987666666',28),
    ('Empresa N','123333333',29),
    ('Empresa O','444345565',30);

TRUNCATE TABLE Enderecos;
INSERT INTO Enderecos (estado, cidade, bairro, rua, numero, complemento, CEP, tipo, _status, idCliente)
VALUES
    ('AM', 'Manaus', 'Adrianópolis', 'Rua L', 369, 'Bloco A', '69001-000', 'Residencial', TRUE, 12),
    ('AM', 'Manaus', 'Centro', 'Rua X', 159, NULL, '69001-001', 'Residencial', TRUE, 24),
    ('BA', 'Salvador', 'Barra', 'Av. D', 321, NULL, '40001-000', 'Comercial', TRUE, 4),
    ('BA', 'Salvador', 'Itapuã', 'Av. Q', 258, 'Bloco C', '40001-001', 'Comercial', TRUE, 17),
    ('BA', 'Salvador', 'Stella Maris', 'Rua BB', 456, 'Bloco D', '40001-002', 'Residencial', TRUE, 28),
    ('CE', 'Fortaleza', 'Aldeota', 'Rua F', 987, NULL, '60001-000', 'Residencial', TRUE, 6),
    ('CE', 'Fortaleza', 'Meireles', 'Rua R', 369, 'Apto 401', '60001-001', 'Residencial', TRUE, 18),
    ('CE', 'Fortaleza', 'Montese', 'Av. CC', 789, NULL, '60001-002', 'Comercial', TRUE, 29),
    ('DF', 'Brasília', 'Asa Norte', 'Rua S', 951, NULL, '70001-001', 'Residencial', TRUE, 19),
    ('DF', 'Brasília', 'Asa Sul', 'Av. G', 159, 'Sala 202', '70001-000', 'Comercial', TRUE, 7),
    ('DF', 'Brasília', 'Lago Sul', 'Rua DD', 159, 'Apto 604', '70001-002', 'Residencial', TRUE, 30),
    ('MG', 'Belo Horizonte', 'Buritis', 'Rua P', 147, 'Casa', '30301-000', 'Residencial', TRUE, 16),
    ('MG', 'Belo Horizonte', 'Lourdes', 'Rua AA', 357, 'Casa', '30301-001', 'Residencial', TRUE, 27),
    ('MG', 'Belo Horizonte', 'Savassi', 'Rua C', 789, 'Casa', '30101-000', 'Residencial', TRUE, 3),
    ('MT', 'Cuiabá', 'Areão', 'Rua W', 789, 'Bloco B', '78001-001', 'Residencial', TRUE, 23),
    ('MT', 'Cuiabá', 'Centro', 'Av. K', 258, NULL, '78001-000', 'Comercial', TRUE, 11),
    ('PE', 'Recife', 'Boa Viagem', 'Rua E', 654, 'Bloco 2', '50001-000', 'Residencial', TRUE, 5),
    ('PE', 'Recife', 'Pina', 'Rua M', 741, 'Apto 305', '50001-001', 'Residencial', TRUE, 13),
    ('PI', 'Teresina', 'Centro', 'Rua J', 357, 'Casa', '64001-000', 'Residencial', TRUE, 10),
    ('PI', 'Teresina', 'Zona Sul', 'Rua V', 456, 'Casa', '64001-001', 'Residencial', TRUE, 22),
    ('PR', 'Curitiba', 'Centro', 'Rua H', 753, 'Apto 202', '80001-000', 'Residencial', TRUE, 8),
    ('PR', 'Curitiba', 'Jardim Botânico', 'Rua T', 753, 'Apto 402', '80001-001', 'Residencial', TRUE, 20),
    ('RJ', 'Rio de Janeiro', 'Barra da Tijuca', 'Av. N', 852, NULL, '22701-000', 'Comercial', TRUE, 14),
    ('RJ', 'Rio de Janeiro', 'Copacabana', 'Av. B', 456, NULL, '20001-000', 'Comercial', TRUE, 2),
    ('RJ', 'Rio de Janeiro', 'Tijuca', 'Rua Y', 951, 'Apto 503', '22701-001', 'Residencial', TRUE, 25),
    ('RS', 'Porto Alegre', 'Cidade Baixa', 'Av. U', 357, NULL, '90001-001', 'Comercial', TRUE, 21),
    ('RS', 'Porto Alegre', 'Moinhos', 'Rua I', 951, NULL, '90001-000', 'Residencial', TRUE, 9),
    ('SC', 'Florianópolis', 'Centro', 'Rua O', 963, NULL, '88001-000', 'Residencial', TRUE, 15),
    ('SC', 'Florianópolis', 'Santa Rosa', 'Av. do cascalho Branco', 17, NULL, '88001-101', 'Comercial', FALSE, 26),
    ('SC', 'Florianópolis', 'Trindade', 'Av. Z', 753, NULL, '88001-001', 'Comercial', TRUE, 26),
    ('SP', 'São Paulo', 'Centro', 'Rua A', 123, 'Apto 101', '01001-000', 'Residencial', TRUE, 1);

TRUNCATE TABLE Contatos;
INSERT INTO Contatos (tipo, publico, detalhes, _status, idCliente)
VALUES
    ('e-mail', 0, 'Contato de marketing.', 1, 19),
    ('e-mail', 0, 'Contato para assuntos gerais.', 1, 1),
    ('e-mail', 0, 'Coordenação de eventos.', 1, 25),
    ('e-mail', 0, 'Gerência financeira.', 1, 13),
    ('e-mail', 0, 'Utilizar para envio de documentos.', 1, 7),
    ('e-mail', 1, 'Comunicação institucional.', 1, 28),
    ('e-mail', 1, 'Contato exclusivo para clientes.', 1, 4),
    ('e-mail', 1, 'Envio de propostas comerciais.', 1, 22),
    ('e-mail', 1, 'Informações administrativas.', 1, 10),
    ('e-mail', 1, 'Para questões contratuais.', 1, 16),
    ('qq', 0, 'Acesso restrito para parceiros.', 1, 21),
    ('qq', 0, 'Apenas para suporte técnico.', 1, 3),
    ('qq', 0, 'Canal exclusivo para fornecedores.', 1, 15),
    ('qq', 0, 'Contato reservado para emergências.', 1, 9),
    ('qq', 0, 'Dúvidas sobre logística.', 1, 27),
    ('qq', 1, 'Apoio ao cliente internacional.', 1, 30),
    ('qq', 1, 'Atendimento 24h.', 1, 6),
    ('qq', 1, 'Canal de suporte internacional.', 1, 18),
    ('qq', 1, 'Canal para feedback.', 1, 24),
    ('qq', 1, 'Contato de diretoria.', 1, 12),
    ('zap', 0, 'Apenas mensagens curtas.', 1, 11),
    ('zap', 0, 'Canal de comunicação rápida.', 1, 29),
    ('zap', 0, 'Contato de suporte técnico.', 1, 23),
    ('zap', 0, 'Dúvidas gerais.', 1, 17),
    ('zap', 0, 'Resposta rápida em horários comerciais.', 1, 5),
    ('zap', 1, 'Assistência para novos projetos.', 1, 26),
    ('zap', 1, 'Atendimento ao cliente VIP.', 1, 14),
    ('zap', 1, 'Disponível das 9h às 18h.', 1, 2),
    ('zap', 1, 'Para suporte prioritário.', 1, 8),
    ('zap', 1, 'Suporte para campanhas.', 1, 20);

TRUNCATE TABLE FormasPagamento;
INSERT INTO FormasPagamento (metodo, detalhes, idCliente, _status)
VALUES
    ('PAYPAL', 'Atendimento a vendedores externos.', 9, TRUE),
    ('PAYPAL', 'Conta PayPal vinculada para transações online.', 3, TRUE),
    ('PAYPAL', 'Conta certificada para marketplaces.', 24, TRUE),
    ('PAYPAL', 'Conta com suporte internacional.', 6, TRUE),
    ('PAYPAL', 'Conta configurada para compras rápidas.', 30, TRUE),
    ('PAYPAL', 'Conta configurada para devoluções rápidas.', 18, TRUE),
    ('PAYPAL', 'Pagamento seguro via integração API.', 15, TRUE),
    ('PAYPAL', 'Pagamentos recorrentes configurados.', 27, TRUE),
    ('PAYPAL', 'Transações com clientes internacionais.', 21, TRUE),
    ('PAYPAL', 'Transações de baixo custo operacional.', 12, TRUE),
    ('PIX', 'Chave cadastrada para pagamentos instantâneos.', 1, TRUE),
    ('PIX', 'Chave para liquidação de contratos.', 13, TRUE),
    ('PIX', 'Chave para pagamentos entre parceiros.', 10, TRUE),
    ('PIX', 'Chave para recebimento exclusivo de clientes.', 16, TRUE),
    ('PIX', 'Chave vinculada ao CNPJ da empresa.', 7, TRUE),
    ('PIX', 'Pagamento direto e sem tarifas adicionais.', 22, TRUE),
    ('PIX', 'Pagamento exclusivo para fornecedores.', 28, TRUE),
    ('PIX', 'Pagamento para uso em operações rápidas.', 4, TRUE),
    ('PIX', 'Usado para operações em feriados.', 25, TRUE),
    ('PIX', 'Uso em promoções e eventos especiais.', 19, TRUE),
    ('TRANSFER', 'Banco com limite diário alto.', 20, TRUE),
    ('TRANSFER', 'Banco intermediário para remessas.', 11, TRUE),
    ('TRANSFER', 'Banco que oferece conciliação automática.', 29, TRUE),
    ('TRANSFER', 'Conta bancária para fornecedores locais.', 14, TRUE),
    ('TRANSFER', 'Conta bancária para transferências.', 2, TRUE),
    ('TRANSFER', 'Conta com isenção de tarifas.', 26, TRUE),
    ('TRANSFER', 'Conta exclusiva para clientes corporativos.', 8, TRUE),
    ('TRANSFER', 'Conta para operações de câmbio.', 17, TRUE),
    ('TRANSFER', 'Operações centralizadas em banco parceiro.', 23, TRUE),
    ('TRANSFER', 'Usar apenas em transações acima de R$1.000.', 5, TRUE);

TRUNCATE TABLE Categorias;
INSERT INTO Categorias(nome)
VALUES
    ('Informatica'),            -- 1
    ('SmartPhone'),             -- 2
    ('Gamer'),                  -- 3
    ('Pet Shop'),               -- 4
    ('Vestuário'),              -- 5
    ('Action Figure'),          -- 6
    ('Eletro Domestico'),       -- 7
    ('Cama Mesa e Banho');      -- 8

TRUNCATE TABLE Produtos;
INSERT INTO Produtos(nome,categoria,descricao,unidade_referencia,fabricante)
VALUES
    ('Notebook Dell Inspiron', 1, 'Notebook para uso geral', 'UNIDADE', 'Dell'),
    ('Macbook Pro', 1, 'Laptop Apple de alto desempenho', 'UNIDADE', 'Apple'),
    ('Teclado Mecânico Corsair', 1, 'Teclado mecânico RGB', 'UNIDADE', 'Corsair'),
    ('Mouse Logitech G502', 1, 'Mouse com alta precisão', 'UNIDADE', 'Logitech'),
    ('Monitor LG 27" UltraWide', 1, 'Monitor ultrawide 2560x1080', 'UNIDADE', 'LG'),
    ('Smartphone Samsung Galaxy S23', 2, 'Smartphone topo de linha', 'UNIDADE', 'Samsung'),
    ('iPhone 14 Pro', 2, 'Smartphone Apple de alta performance', 'UNIDADE', 'Apple'),
    ('Xiaomi Redmi Note 12', 2, 'Smartphone intermediário com boa performance', 'UNIDADE', 'Xiaomi'),
    ('Fone de ouvido Bluetooth Sony WH-1000XM5', 2, 'Fone de ouvido com cancelamento de ruído', 'UNIDADE', 'Sony'),
    ('Carregador Samsung 25W', 2, 'Carregador rápido USB-C', 'UNIDADE', 'Samsung'),
    ('PC Gamer Ryzen 7 5800X', 3, 'PC gamer de alto desempenho', 'UNIDADE', 'Alienware'),
    ('Placa de Vídeo Nvidia RTX 3080', 3, 'Placa de vídeo topo de linha para gamers', 'UNIDADE', 'Nvidia'),
    ('Memória RAM Corsair 16GB DDR4', 3, 'Memória RAM de alta velocidade', 'UNIDADE', 'Corsair'),
    ('Headset HyperX Cloud II', 3, 'Headset gamer com som surround', 'UNIDADE', 'HyperX'),
    ('Teclado Mecânico Razer Huntsman', 3, 'Teclado gamer com switch opto-mecânico', 'UNIDADE', 'Razer'),
    ('Ração Royal Canin Cachorro', 4, 'Ração para cães de porte médio', 'QUILO', 'Royal Canin'),
    ('Coleira de Cães PetSafe', 4, 'Coleira ajustável para cães', 'UNIDADE', 'PetSafe'),
    ('Cama Pet Orthopet', 4, 'Cama ortopédica para cães', 'UNIDADE', 'Orthopet'),
    ('Brinquedo Interativo para Gatos', 4, 'Brinquedo para estimular gatos', 'UNIDADE', 'Cat Toys'),
    ('Ração Friskies para Gatos', 4, 'Ração para gatos', 'QUILO', 'Friskies'),
    ('Camisa Polo Masculina', 5, 'Camisa polo para uso casual', 'UNIDADE', 'Lacoste'),
    ('Calça Jeans Feminina Levi\'s', 5, 'Calça jeans feminina de corte reto', 'UNIDADE', 'Levi\'s'),
    ('Tênis Adidas Ultraboost', 5, 'Tênis esportivo com alta absorção de impacto', 'UNIDADE', 'Adidas'),
    ('Saia de Couro Feminina', 5, 'Saia de couro para uso casual', 'UNIDADE', 'Zara'),
    ('Blusa de Frio Masculina', 5, 'Blusa de frio de tecido leve', 'UNIDADE', 'Columbia'),
    ('Action Figure Homem de Ferro', 6, 'Action figure detalhado do Homem de Ferro', 'UNIDADE', 'Hot Toys'),
    ('Action Figure Batman', 6, 'Figura de ação do Batman, colecionável', 'UNIDADE', 'DC Collectibles'),
    ('Action Figure Star Wars Yoda', 6, 'Figura de ação Yoda com articulações', 'UNIDADE', 'Hasbro'),
    ('Action Figure Deadpool', 6, 'Action figure articulada do Deadpool', 'UNIDADE', 'Hasbro'),
    ('Action Figure Spider-Man', 6, 'Figura de ação do Homem-Aranha, colecionável', 'UNIDADE', 'Hot Toys'),
    ('Geladeira Brastemp 500L', 7, 'Geladeira com capacidade de 500 litros', 'UNIDADE', 'Brastemp'),
    ('Micro-ondas Panasonic 30L', 7, 'Micro-ondas de 30L com várias funções', 'UNIDADE', 'Panasonic'),
    ('Máquina de Lavar LG 10kg', 7, 'Máquina de lavar roupas de 10kg', 'UNIDADE', 'LG'),
    ('Liquidificador Philips Walita 600W', 7, 'Liquidificador potente de 600W', 'UNIDADE', 'Philips Walita'),
    ('Ferro de Passar Philco', 7, 'Ferro de passar a vapor', 'UNIDADE', 'Philco'),
    ('Notebook Lenovo Ideapad', 1, 'Notebook de entrada com boa performance', 'UNIDADE', 'Lenovo'),
    ('Tablet Samsung Galaxy Tab S8', 1, 'Tablet Android de alto desempenho', 'UNIDADE', 'Samsung'),
    ('Placa Mãe Asus ROG Strix', 1, 'Placa mãe para PC gamer', 'UNIDADE', 'Asus'),
    ('Cadeira Gamer DXRacer', 3, 'Cadeira gamer ergonômica', 'UNIDADE', 'DXRacer'),
    ('Câmera de Segurança Intelbras', 1, 'Câmera de segurança com alta resolução', 'UNIDADE', 'Intelbras'),
    ('Smartphone Motorola Edge 30', 2, 'Smartphone com câmera de alta performance', 'UNIDADE', 'Motorola'),
    ('Smartwatch Apple Watch Series 8', 2, 'Relógio inteligente com monitoramento de saúde', 'UNIDADE', 'Apple'),
    ('Projetor Epson Full HD', 1, 'Projetor com resolução Full HD', 'UNIDADE', 'Epson'),
    ('Impressora HP DeskJet 3630', 1, 'Impressora multifuncional', 'UNIDADE', 'HP'),
    ('Kit Gamer Logitech', 3, 'Kit completo com teclado, mouse e fones', 'UNIDADE', 'Logitech'),
    ('Smartphone OnePlus 11', 2, 'Smartphone com tela de 120Hz', 'UNIDADE', 'OnePlus'),
    ('Console Playstation 5', 3, 'Console de última geração', 'UNIDADE', 'Sony'),
    ('Console Xbox Series X', 3, 'Console de última geração da Microsoft', 'UNIDADE', 'Microsoft'),
    ('Almofada Pet para Cães', 4, 'Almofada confortável para cães', 'UNIDADE', 'PetComfort'),
    ('Petisqueira para Gatos', 4, 'Petisqueira para gatos', 'UNIDADE', 'CatLife'),
    ('Coleira para Gato', 4, 'Coleira ajustável para gatos', 'UNIDADE', 'PetSafe'),
    ('Ração Special Dog', 4, 'Ração para cães de porte grande', 'QUILO', 'Special Dog'),
    ('Vestuário Feminino da Zara', 5, 'Vestuário feminino com design moderno', 'UNIDADE', 'Zara'),
    ('Vestido de Festa', 5, 'Vestido de festa elegante', 'UNIDADE', 'C&A'),
    ('Bermuda Masculina Hering', 5, 'Bermuda masculina casual', 'UNIDADE', 'Hering'),
    ('Blazer Feminino', 5, 'Blazer feminino de tecido leve', 'UNIDADE', 'TNG'),
    ('Action Figure Thor', 6, 'Figura de ação do Thor, Marvel', 'UNIDADE', 'Hasbro'),
    ('Action Figure Mulher Maravilha', 6, 'Figura de ação da Mulher Maravilha', 'UNIDADE', 'DC Collectibles'),
    ('Cafeteira Nespresso', 7, 'Cafeteira automática de cápsulas', 'UNIDADE', 'Nespresso'),
    ('Batedeira KitchenAid', 7, 'Batedeira de alta potência', 'UNIDADE', 'KitchenAid'),
    ('Aspirador de Pó Electrolux', 7, 'Aspirador de pó com filtro HEPA', 'UNIDADE', 'Electrolux'),
    ('Secador de Cabelo Taiff', 7, 'Secador de cabelo com 2000W', 'UNIDADE', 'Taiff');

TRUNCATE TABLE Estoque;
INSERT INTO Estoque(unidade_preco, quantidade, idVendedor, idProduto)
VALUES
    (5800,15,29,2),
    (6300,4,17,2),
    (3200,40,16,1),
    (2890,29,22,1),
    (3390,80,17,1),
    (3400,23,16,36),
    (3340,23,22,36),
    (240,300,16,3),
    (189,24,29,3),
    (129,300,17,3),
    (127,38,22,3),
    (120,300,17,4),
    (79.90,200,29,4),
    (123,40,16,4),
    (120,56,20,4),
    (1400,15,19,5),
    (1560,21,26,5),
    (2120,3,20,37),
    (2000,12,19,37),
    (1670,21,17,38),
    (1290,8,16,40),
    (1780,6,18,43),
    (1800,2,16,43),
    (2000,4,18,44),
    (10.50, 0, 18, 57),
    (10.50, 3, 27, 58),
    (10.50, 12, 18, 30),
    (10.50, 10, 27, 29),
    (10.50, 2, 18, 28),
    (10.50, 20, 27, 27),
    (10.50, 12, 18, 26),
    (10.50, 9, 27, 57),
    (10.50, 23, 18, 58),
    (10.50, 67, 27, 30),
    (10.50, 3, 18, 29),
    (10.50, 4, 27, 28),
    (10.50, 2, 18, 27),
    (10.50, 3, 27, 26),
    (10.50, 1, 18, 57),
    (10.50, 2, 27, 58),
    (10.50, 2, 18, 30),
    (10.50, 2, 27, 29),
    (10.50, 1, 18, 28),
    (10.50, 2, 27, 27),
    (10.50, 4, 18, 26),
    (10.50, 3, 27, 57),
    (10.50, 4, 18, 58),
    (10.50, 7, 27, 30),
    (10.50, 10, 18, 29),
    (10.50, 3, 27, 28),
    (10.50, 2, 18, 27),
    (10.50, 1, 27, 26),
    (10.50, 1, 18, 57),
    (10.50, 6, 27, 58),
    (10.50, 5, 18, 30),
    (10.50, 6, 27, 29),
    (10.50, 5, 18, 28),
    (10.50, 1, 27, 27),
    (10.50, 2, 18, 26),
    (10.50, 9, 27, 57),
    (10.50, 4, 18, 58),
    (10.50, 3, 27, 30),
    (10.50, 1, 18, 29),
    (10.50, 12, 27, 28),
    (10.50, 2, 18, 27),
    (10.50, 3, 27, 26),
    (10.50, 9, 18, 57),
    (10.50, 8, 27, 58),
    (10.50, 12, 18, 30),
    (10.50, 3, 27, 29),
    (10.50, 0, 18, 28),
    (10.50, 2, 27, 27),
    (100.50, 0, 23, 16),
    (120.00, 3, 23, 17),
    (89.99, 12, 23, 18),
    (150.75, 10, 23, 19),
    (72.50, 2, 23, 20),
    (55.00, 20, 23, 49),
    (45.99, 12, 23, 50),
    (32.99, 9, 23, 51),
    (60.00, 23, 23, 52),
    (110.75, 67, 28, 16),
    (125.00, 3, 28, 17),
    (95.50, 4, 28, 18),
    (140.25, 2, 28, 19),
    (78.90, 3, 28, 20),
    (50.00, 1, 28, 49),
    (49.50, 2, 28, 50),
    (29.99, 2, 28, 51),
    (59.99, 2, 28, 52),
    (115.00, 1, 23, 16),
    (130.00, 2, 23, 17),
    (87.99, 4, 23, 18),
    (155.00, 3, 23, 19),
    (75.25, 4, 23, 20),
    (58.90, 7, 23, 49),
    (48.50, 10, 23, 50),
    (31.25, 3, 23, 51),
    (63.00, 2, 23, 52),
    (112.75, 1, 28, 16),
    (122.99, 1, 28, 17),
    (91.75, 6, 28, 18),
    (145.90, 5, 28, 19),
    (80.50, 6, 28, 20),
    (52.00, 5, 28, 49),
    (46.75, 1, 28, 50),
    (33.50, 2, 28, 51),
    (64.99, 9, 28, 52),
    (108.50, 4, 23, 16),
    (128.00, 3, 23, 17),
    (85.99, 1, 23, 18),
    (160.00, 12, 23, 19),
    (70.00, 2, 23, 20),
    (56.75, 3, 23, 49),
    (47.50, 9, 23, 50),
    (30.99, 8, 23, 51),
    (62.50, 12, 23, 52),
    (105.00, 3, 28, 16),
    (118.75, 0, 28, 17),
    (90.25, 2, 28, 18),
    (143.99, 3, 28, 19),
    (76.90, 9, 28, 20),
    (53.25, 8, 28, 49),
    (44.75, 12, 28, 50),
    (35.00, 3, 28, 51),
    (65.75, 0, 28, 52),
    (800, ROUND(RAND() * 200 + 1), 27, 9),
    (820, ROUND(RAND() * 200 + 1), 20, 9),
    (810, ROUND(RAND() * 200 + 1), 26, 9),
    (500, ROUND(RAND() * 200 + 1), 27, 10),
    (510, ROUND(RAND() * 200 + 1), 20, 10),
    (495, ROUND(RAND() * 200 + 1), 26, 10),
    (3500, ROUND(RAND() * 200 + 1), 27, 46),
    (3550, ROUND(RAND() * 200 + 1), 20, 46),
    (3480, ROUND(RAND() * 200 + 1), 26, 46),
    (2500, ROUND(RAND() * 200 + 1), 27, 8),
    (2550, ROUND(RAND() * 200 + 1), 20, 8),
    (2450, ROUND(RAND() * 200 + 1), 26, 8),
    (6000, ROUND(RAND() * 200 + 1), 27, 7),
    (6100, ROUND(RAND() * 200 + 1), 20, 7),
    (5950, ROUND(RAND() * 200 + 1), 26, 7),
    (4000, ROUND(RAND() * 200 + 1), 27, 42),
    (4050, ROUND(RAND() * 200 + 1), 20, 42),
    (3950, ROUND(RAND() * 200 + 1), 26, 42),
    (3000, ROUND(RAND() * 200 + 1), 27, 41),
    (3100, ROUND(RAND() * 200 + 1), 20, 41),
    (2950, ROUND(RAND() * 200 + 1), 26, 41),
    (4500, ROUND(RAND() * 200 + 1), 27, 6),
    (4600, ROUND(RAND() * 200 + 1), 20, 6),
    (4400, ROUND(RAND() * 200 + 1), 26, 6),
    (700, ROUND(RAND() * 200 + 1), 27, 45),
    (710, ROUND(RAND() * 200 + 1), 20, 45),
    (690, ROUND(RAND() * 200 + 1), 26, 45),
    (1200, ROUND(RAND() * 200 + 1), 27, 39),
    (1250, ROUND(RAND() * 200 + 1), 20, 39),
    (1180, ROUND(RAND() * 200 + 1), 26, 39),
    (4500, ROUND(RAND() * 200 + 1), 27, 48),
    (4600, ROUND(RAND() * 200 + 1), 20, 48),
    (4450, ROUND(RAND() * 200 + 1), 26, 48),
    (4700, ROUND(RAND() * 200 + 1), 27, 47),
    (4800, ROUND(RAND() * 200 + 1), 20, 47),
    (4650, ROUND(RAND() * 200 + 1), 26, 47),
    (8000, ROUND(RAND() * 200 + 1), 27, 11),
    (8100, ROUND(RAND() * 200 + 1), 20, 11),
    (7900, ROUND(RAND() * 200 + 1), 26, 11),
    (2500, ROUND(RAND() * 200 + 1), 27, 12),
    (2600, ROUND(RAND() * 200 + 1), 20, 12),
    (2450, ROUND(RAND() * 200 + 1), 26, 12),
    (900, ROUND(RAND() * 200 + 1), 27, 13),
    (920, ROUND(RAND() * 200 + 1), 20, 13),
    (890, ROUND(RAND() * 200 + 1), 26, 13),
    (400, ROUND(RAND() * 200 + 1), 27, 14),
    (410, ROUND(RAND() * 200 + 1), 20, 14),
    (390, ROUND(RAND() * 200 + 1), 26, 14),
    (800, ROUND(RAND() * 200 + 1), 27, 15),
    (810, ROUND(RAND() * 200 + 1), 20, 15),
    (780, ROUND(RAND() * 200 + 1), 26, 15);

TRUNCATE TABLE Pedidos;
INSERT INTO Pedidos (idCliente, idFormaPagamento, _status)
VALUES
    (1, 11, 'Em Aberto'),
    (2, 25, 'Concluído'),
    (3, 2, 'Cancelado'),
    (4, 18, 'Devolvido'),
    (5, 30, 'Concluído'),
    (6, 4, 'Em Aberto'),
    (7, 15, 'Cancelado'),
    (8, 27, 'Concluído'),
    (9, 1, 'Devolvido'),
    (10, 13, 'Concluído'),
    (11, 22, 'Em Aberto'),
    (12, 10, 'Concluído'),
    (13, 12, 'Cancelado'),
    (14, 24, 'Devolvido'),
    (15, 7, 'Em Aberto'),
    (1, 11, 'Concluído'),
    (2, 25, 'Devolvido'),
    (3, 2, 'Em Aberto'),
    (4, 18, 'Concluído'),
    (5, 30, 'Cancelado'),
    (6, 4, 'Devolvido'),
    (7, 15, 'Concluído'),
    (8, 27, 'Cancelado'),
    (9, 1, 'Concluído'),
    (10, 13, 'Devolvido'),
    (11, 22, 'Cancelado'),
    (12, 10, 'Devolvido'),
    (13, 12, 'Concluído'),
    (14, 24, 'Em Aberto'),
    (15, 7, 'Cancelado'),
    (1, 11, 'Devolvido'),
    (2, 25, 'Cancelado'),
    (3, 2, 'Concluído'),
    (4, 18, 'Em Aberto'),
    (5, 30, 'Devolvido'),
    (6, 4, 'Cancelado'),
    (7, 15, 'Em Aberto'),
    (8, 27, 'Devolvido'),
    (9, 1, 'Em Aberto'),
    (10, 13, 'Cancelado');

TRUNCATE TABLE PedidoItens;
INSERT INTO PedidoItens(idPedido, idEstoque,quantidade,impostos,frete_item)
VALUES
    (2, 1, 2, 0.0, 12.38),
    (2, 2, 3, 0.5, 10.50),
    (5, 1, 3, 1.0, 15.00),
    (8, 36, 3, 1.5, 20.00),
    (8, 3, 1, 0.5, 12.00),
    (10, 4, 3, 2.0, 18.50),
    (12, 5, 1, 0.5, 10.00),
    (16, 37, 3, 1.5, 15.00),
    (19, 38, 3, 1.5, 15.00),
    (22, 40, 1, 0.5, 10.00),
    (24, 43, 1, 0.5, 10.00),
    (28, 44, 1, 0.5, 10.00),
    (33, 58, 1, 0.5, 10.00),
    (33, 30, 3, 1.0, 12.50);

TRUNCATE TABLE Pagamentos;
INSERT INTO Pagamentos(idcliente, idpedido,valor_total, data_pagamento,idFormaPagamento)
VALUES
    (2,2,55318.14,'2024-12-23',1),
    (5,5,28485.00,'2024-12-23',2),
    (8,8,20993.00,'2024-12-23',10),
    (10,10,1402.70,'2024-12-23',11),
    (12,12,2980.00,'2024-12-23',12),
    (1,16,12390.00,'2024-12-23',13),
    (4,19,5025.00,'2024-12-23',15),
    (7,22,1300.00,'2024-12-23',18),
    (9,24,3600.00,'2024-12-23',25),
    (13,28,2010.00,'2024-12-23',27),
    (3,33,451.50,'2024-12-23',30);

INSERT INTO Entregas (idPedido, idItem, codRastreio, clienteEndereco, remetenteEndereco, quantidade)
SELECT
    P.id AS idPedido,
    PI.id AS idPedidoItem,
    CONCAT('RASTREIO_', P.id, '_', E.idVendedor),
    EC.id AS clienteEndereco,
    ER.id AS remetenteEndereco,
    PI.quantidade
FROM
    Pedidos P
JOIN  PedidoItens AS PI ON P.id = PI.idPedido
JOIN  Estoque AS E ON PI.idEstoque = E.id AND E._status=TRUE
JOIN  Enderecos AS EC ON EC.idCliente = P.idCliente
JOIN  Enderecos As ER ON ER.idCliente = E.idVendedor;

-- Updates para homogenizar as tabelas?

-- Atualizar Produtos._status
-- UPDATE Produtos AS P
-- SET P._status = False
-- WHERE P.id IN (
--    SELECT E.idProduto FROM Estoque AS E
--    WHERE E.quantidade = 0
-- );
