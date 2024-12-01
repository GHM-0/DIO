DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Generaliza os Papeis de 'Vendedor e Cliente' mantém a distinção entre 'Pessoa Física e Pessoa Jurídica'
CREATE TABLE Clientes(
--  Dados Gereis de Clientes
    nome VARCHAR(250) NOT NULL,                           -- Abstrai nome em 'Pessoa Física' e nome_fantasia em 'Pessoa Jurídica'
    identificador VARCHAR(29) NOT NULL UNIQUE,            -- Abstrai CPF em 'Pessoa Física' e CNPJ em 'Pessoa Jurídica'  Considerar REGEX

--  Atributo Seletor
    tipo ENUM('Fisica','Juridica') NOT NULL,              -- Tipo de Entidade

--  Pessoa Física
    dataNascimento DATE DEFAULT NULL,                     -- Estabelece Faixa Etária
    sexo ENUM('M', 'F', 'O') DEFAULT NULL,                -- Estabelece Genero

--  Pessoa Jurídica
    razaoSocial VARCHAR(250) DEFAULT NULL,                -- Uma Razão Social "!Não pode estar atrelada a várias nomes fantasia?"
    inscricaoEstadual VARCHAR(20) DEFAULT NULL,           -- !Deveria garantir unicidade

-- Metadata de Cliente
    id INT AUTO_INCREMENT PRIMARY KEY,
    _status TINYINT DEFAULT TRUE,                         -- Ativo ou Inativo
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,           -- Data de criação do perfil
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP,         -- Data da ultima alteração

-- GPT hints, checa forma não Valida

    CONSTRAINT chk_tipo_nulidade
        CHECK (
            (tipo = 'Fisica' AND razaoSocial IS NULL AND inscricaoEstadual IS NULL
                 AND dataNascimento IS NOT NULL AND sexo IS NOT NULL  AND identificador REGEXP '^[0-9]{11}$'
            )
            OR
            (tipo = 'Juridica' AND dataNascimento IS NULL AND sexo IS NULL
                AND razaoSocial IS NOT NULL AND inscricaoEstadual IS NOT NULL AND identificador REGEXP '^[0-9]{14}$'
            )
        )
);

-- TRIGGER ou PROCEDURE se Clientes._status=FALSE não se pode fazer modificações ou inserções no db

-- Tabelas Auxiliares para Clientes 1:N
CREATE TABLE Enderecos(

--  Atributo Seletor
    tipo ENUM('Residêncial','Comercial') NOT NULL,       -- Podem Existir Outros Tipos?

    estado ENUM('AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA',
                'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN',
                'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO') NOT NULL,

    CEP VARCHAR(250) NOT NULL,
    cidade VARCHAR(250) NOT NULL,
    bairro VARCHAR(250) NOT NULL,
    rua VARCHAR(250) NOT NULL,
    numero INT,
    complemento VARCHAR(250) NULL,

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,                                -- Referencia Perfil
    FOREIGN KEY (idCliente) REFERENCES Clientes(id),
    _status TINYINT DEFAULT TRUE,                          -- Para manter um Histórico
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP           -- Data da ultima alteracao
);

CREATE TABLE Contatos(

--  Atributo Seletor
    tipo ENUM('e-mail','zap','qq') NOT NULL,

    publico  TINYINT DEFAULT FALSE,                      -- Vendedores Expõem os seus contato aos seus clientes
    detalhes VARCHAR(300) NOT NULL,                      -- Descricão de proposito/restrição de horários, Informações úteis para utilização

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    _status TINYINT DEFAULT TRUE,                         -- Ativo ou Inativo
    idCliente INT NOT NULL,                               -- Referencia Perfil
    FOREIGN KEY (idCliente) REFERENCES Clientes(id),
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP           -- Data da ultima alteracao
);

-- Forma de Pagamento/Recebimento.
CREATE TABLE FormasPagamento(

-- Atributo Seletor
    metodo ENUM('PIX','TRANSFER','PAYPAL','BOLETO') NOT NULL,

    detalhes VARCHAR(300) NOT NULL,

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,                              -- Referencia Perfil
    FOREIGN KEY (idCliente) REFERENCES Clientes(id),
    _status TINYINT DEFAULT TRUE,                        -- Ativo ou Inativo
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,          -- Data de Criação
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP         -- Data da ultima alteracao
);
--

--
CREATE TABLE Categorias(

    nome VARCHAR(250) NOT NULL,

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    _status TINYINT DEFAULT TRUE,
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Produtos(

    nome VARCHAR(250) NOT NULL,
    descricao VARCHAR(250) NOT NULL,
    unidade_referencia ENUM ('UNIDADE','grama','quilo','litro') NOT NULL,
    fabricante VARCHAR(250) NOT NULL,

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    categoria INT,
    FOREIGN KEY (categoria) REFERENCES Categorias(id),
    _status TINYINT DEFAULT TRUE,                                                    -- Ativo ou Inativo SE não existirem em Estoque
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Estoque(

    unidade_preco DECIMAL(7, 2) NOT NULL CHECK (unidade_preco >= 0),
    quantidade INT NOT NULL CHECK (quantidade >= 0),

-- Metadata
    idVendedor INT NOT NULL,
    FOREIGN KEY (idVendedor) REFERENCES Clientes(id),
    idProduto INT NOT NULL,
    FOREIGN KEY (idProduto) REFERENCES Produtos(id),
    _status TINYINT DEFAULT TRUE,
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP           -- Data da ultima alteracao
);

-- TRIGGER SE Estoque.quantidade = 0 Produtos._status=FALSE

--
CREATE TABLE Pedidos(

    _status ENUM('Pendente', 'Aprovado', 'Rejeitado','Aguardando Envio', 'Concluído', 'Cancelado','Devolvido') NOT NULL,
    valor_total DECIMAL(7, 2) NOT NULL CHECK (valor_total >= 0),
    data_pagamento DATE NOT NULL,

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Perfis(id),
    idFormaPagamento INT NOT NULL,                                                  -- Referência à forma de pagamento
    FOREIGN KEY (idFormaPagamento) REFERENCES FormasPagamento(id),
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP                                    -- Data da ultima alteracao
);

CREATE TABLE PedidoItens(

    quantidade INT NOT NULL CHECK (quantidade >= 0),
    impostos DECIMAL(10, 2) NOT NULL CHECK (impostos >= 0),
    frete_item DECIMAL(10, 2) NOT NULL CHECK (frete_item >= 0),

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES Pedidos(id),
    idProduto INT NOT NULL,
    FOREIGN KEY (idProduto) REFERENCES Produtos(id)
);

-- TRIGGER Pedidos._status='Aprovado' Estoque.quantidade - PedidoItens.quantidade LOGO Pedidos.quantidade não Pode exceder Estoque.quantidade


-- Pedido Entregas 1:N
CREATE TABLE Entregas(

    _status ENUM('Aguardado Envio', 'Enviado', 'Cancelado','Devolvido') NOT NULL,
    codRastreio VARCHAR(250) NOT NULL,
    enviado DATETIME,
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP,           -- Data da ultima alteracao
    quantidade INT NOT NULL CHECK (quantidade >= 0),

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES Pedidos(id),
    idItem INT NOT NULL,
    FOREIGN KEY (idItem) REFERENCES PedidoItens(id),
    clienteEndereco INT NOT NULL,     -- Do cliente
    FOREIGN KEY (clienteEndereco) REFERENCES Enderecos(id),
    remetenteEndereco INT NOT NULL,     -- Do cliente
    FOREIGN KEY (remetenteEndereco) REFERENCES Enderecos(id),
);
