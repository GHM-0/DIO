DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Generaliza os Papeis de Vendedor e Cliente
CREATE TABLE Perfis(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(250) NOT NULL,                          -- Abstrai nome em 'Pessoa Física' e nome_fantasia em 'Pessoa Jurídica'
    identificador VARCHAR(29) NOT NULL UNIQUE,           -- Abstrai CPF em 'Pessoa Física' e CNPJ em 'Pessoa Jurídica'
    _status TINYINT DEFAULT TRUE,                        -- Ativo ou Inativo
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP           -- Data de criação do perfil
);

-- Desambiguação de Pessoa Física
CREATE TABLE PessoaFisica(
    idPerfil INT PRIMARY KEY,                            -- Referencia Perfil
    FOREIGN KEY (idPerfil) REFERENCES Perfis(id),
    dataNascimento DATE NOT NULL,                        -- Estabelece Faixa Etária
    sexo ENUM('M', 'F', 'O')                             -- Estabelece Genero
);

-- Desambiguação de Pessoa Jurídica
CREATE TABLE PessoaJuridica(
    idPerfil INT PRIMARY KEY,                            -- Referencia Perfil
    FOREIGN KEY (idPerfil) REFERENCES Perfis(id),
    razaoSocial VARCHAR(250) NOT NULL,                   -- Uma razaoSocial pode estar atrelada a várias nomes_fantasia
    -- nomeFantasia VARCHAR(250),                        Usar nome em Perfil
    estado ENUM( 'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA',
    'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN',
    'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO') NOT NULL,                -- Estado Cede
    inscricaoEstadual VARCHAR(20) NOT NULL               -- Cobrança de tributos
);

-- Tabelas Auxiliares para Perfis
CREATE TABLE Enderecos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    CEP VARCHAR(250) NOT NULL,
    estado ENUM( 'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA',
    'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN',
    'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO') NOT NULL,                -- 26 Estados + DF
    tipo ENUM('Residencial','Comercial') NOT NULL,       -- Podem Existir outros Tipos?
    cidade VARCHAR(250) NOT NULL,
    bairro VARCHAR(250) NOT NULL,
    rua VARCHAR(250) NOT NULL,
    numero INT,
    complemento VARCHAR(250) NULL,
    _status TINYINT DEFAULT TRUE,                        -- Para manter um Histórico
    idPerfil INT NOT NULL,                               -- Referencia Perfil
    FOREIGN KEY (idPerfil) REFERENCES Perfis(id)
);

-- Informações Auxiliares de Perfil
CREATE TABLE InformacoesPerfil(
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('e-mail','zap','qq') NOT NULL,
    publico  TINYINT DEFAULT FALSE,                      -- Vendedores Expõem os seus contato aos seus clientes
    detalhes VARCHAR(300) NOT NULL,                      -- Descricão de proposito/restrição de horários, Informações úteis para utilização
    _status TINYINT DEFAULT TRUE,                        -- Ativo ou Inativo, para fins de histórico
    idPerfil INT NOT NULL,                               -- Referencia Perfil
    FOREIGN KEY (idPerfil) REFERENCES Perfis(id)
);

-- Forma de Pagamento/Recebimento.
CREATE TABLE FormasPagamentos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    metodo ENUM('PIX','TRANSFER','PAYPAL') NOT NULL,
    detalhes VARCHAR(300) NOT NULL,
    idPerfil INT NOT NULL,                               -- Referencia Perfil
    FOREIGN KEY (idPerfil) REFERENCES Perfis(id),
    _status TINYINT DEFAULT TRUE,                        -- Ativo ou Inativo, para fins de histórico
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

--
CREATE TABLE Pedidos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    _status ENUM('Aguardando Pagamento','Aguardando Envio', 'Concluído', 'Cancelado','Devolvido') NOT NULL,
    idPerfil INT NOT NULL,
    FOREIGN KEY (idPerfil) REFERENCES Perfis(id),
    valor_total DECIMAL(7, 2) NOT NULL CHECK (valor_total >= 0),                    -- Incluí Fretes* e valores unitários * quantidade + tributos/impostos
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

--
CREATE TABLE Pagamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,                                              -- Identificador único do pagamento
    idPedido INT NOT NULL,                                                          -- Referência ao pedido
    FOREIGN KEY (idPedido) REFERENCES Pedidos(id),
    idFormaPagamento INT NOT NULL,                                                  -- Referência à forma de pagamento
    FOREIGN KEY (idFormaPagamento) REFERENCES FormasPagamentos(id),
    valor_total DECIMAL(10, 2) NOT NULL CHECK (valor_total > 0),                    -- Valor pago
    _status ENUM('Pendente', 'Aprovado', 'Rejeitado') NOT NULL,                     -- Status do pagamento
    data_pagamento DATE NOT NULL    -- Data do pagamento
);

--
CREATE TABLE Produtos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(250) NOT NULL,
    categoria ENUM('INFORMATICA','ELETRO-DOMESTICO','OTHER') NOT NULL,
    descricao VARCHAR(250) NOT NULL,
    uni_ref ENUM ('UNIDADE','grama','quilo','litro') NOT NULL,
    fabricante VARCHAR(250) NOT NULL,
    _status TINYINT DEFAULT TRUE,                                                    -- Há em estoque, TRIGGER --> ESTOQUE
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- verificar alternativas menos trabalhosas
CREATE TABLE ProdutosPrecos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    uni_preco DECIMAL(7, 2) NOT NULL CHECK (uni_preco >= 0),
    _status TINYINT DEFAULT TRUE,                                       -- Está ativo, idPerfil/idProduto só pode haver um apenas ativo
    idPerfil INT NOT NULL,
    FOREIGN KEY (idPerfil) REFERENCES Perfis(id),                       -- Referência Perfil
    idProduto INT NOT NULL,
    FOREIGN KEY (idProduto) REFERENCES Produtos(id),                    -- Referência Produto
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Estoque(
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantidade INT NOT NULL CHECK (quantidade >= 0),
    idProdutoPreco INT NOT NULL,
    FOREIGN KEY (idProdutoPreco) REFERENCES ProdutosPrecos(id),
--    idProduto INT NOT NULL,
--    FOREIGN KEY (idProduto) REFERENCES Produtos(id),
--    idPerfil INT NOT NULL,
--    FOREIGN KEY (idPerfil) REFERENCES Perfis(id),
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE PedidoItens(
    id INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES Pedidos(id),
--    idProduto INT NOT NULL,
--    FOREIGN KEY (idProduto) REFERENCES Produtos(id),
    idProdutoPreco INT NOT NULL,
    FOREIGN KEY (idProdutoPreco) REFERENCES ProdutosPrecos(id),
--    idPerfil INT NOT NULL,
--    FOREIGN KEY (idPerfil) REFERENCES Perfis(id),
    quantidade INT NOT NULL CHECK (quantidade >= 0),
    frete_item DECIMAL(10, 2) NOT NULL CHECK (frete_item >= 0),
    impostos DECIMAL(10, 2) NOT NULL CHECK (impostos >= 0),
    endereco_origem_id INT NOT NULL,                      -- Origem do item
    endereco_entrega_id INT NOT NULL                      -- Entrega do item
);

-- Mesclar Entregas+EntregaItens

CREATE TABLE Entregas(
    id INT AUTO_INCREMENT PRIMARY KEY,
    _status ENUM('Planejado', 'Enviado', 'Cancelado') NOT NULL,
    idPedido INT NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES Pedidos(id)
        ,
-- );

-- Um Pedido pode conter Produtos de N Vendedores com diferentes fretes + imposto cod_rastreio
-- CREATE TABLE EntregaItens (
--    id INT AUTO_INCREMENT PRIMARY KEY,
--    idEntrega INT NOT NULL,
--    FOREIGN KEY (idEntrega) REFERENCES Entregas(id),
    idItem INT NOT NULL,
    FOREIGN KEY (idItem) REFERENCES PedidoItens(id),
    codRastreio VARCHAR(250) NOT NULL,
    clienteEndereco INT NOT NULL,     -- Do cliente
    FOREIGN KEY (clienteEndereco) REFERENCES Enderecos(id),
    remetenteEndereco INT NOT NULL,     -- Do cliente
    FOREIGN KEY (remetenteEndereco) REFERENCES Enderecos(id),
    enviado DATETIME,
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    quantidade INT NOT NULL CHECK (quantidade >= 0)
);
