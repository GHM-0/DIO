DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Considerações
--  Granularidade mais alta que o desejável, JOINS mais complexos com menos campos nulos, embora queira evitar Overdesign
--  Os campos de '_status' quanto boleanos, 'criacao' e 'alteracao' visam registros históricos básicos, evitando tabelas auxiliares de resgistroModificações

-- Generaliza os Papeis de 'Vendedor e Cliente' mantém a distinção entre 'Pessoa Física' e 'Pessoa Jurídica'
CREATE TABLE Clientes(

--  Generalização de Clientes
    nome VARCHAR(250) NOT NULL,                           -- Abstrai nome em 'Pessoa Física' e nome_fantasia em 'Pessoa Jurídica'
    identificador VARCHAR(29) NOT NULL UNIQUE,            -- Abstrai CPF em 'Pessoa Física' e CNPJ em 'Pessoa Jurídica', Considerar REGEX

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    _status TINYINT DEFAULT TRUE,                         -- Ativo ou Inativo
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,           -- Data de criação
    Alteração DATETIME DEFAULT CURRENT_TIMESTAMP          -- Data da ultima alteração
);

-- GPT hints
-- TRIGGER: Atualizar `Alteração` para a data atual quando um cliente for alterado (AFTER UPDATE).
-- TRIGGER: Impedir exclusão se o cliente estiver relacionado a endereços, contatos ou pagamentos (BEFORE DELETE). ? ON DELETE CASCADE

CREATE TABLE PessoaFisica(

    dataNascimento DATE NOT NULL,                     -- Estabelece Faixa Etária

 -- Atributo Seletor
    sexo ENUM('M', 'F', 'O') NOT NULL,                -- Estabelece Genero

-- Metadata
    idCliente INT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Clientes(id)
);

-- GPT hints
-- TRIGGER: Garantir exclusividade entre `PessoaFisica` e `PessoaJuridica` para um mesmo `idCliente` (BEFORE INSERT).

CREATE TABLE PessoaJuridica(

--  Pessoa Jurídica
    razaoSocial VARCHAR(250) NOT NULL,           -- Poderia estar atrelada a várias nomes fantasia?
    inscricaoEstadual VARCHAR(20) NOT NULL UNIQUE,

-- Metadata
    idCliente INT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Clientes(id)
);

-- GPT hints
-- TRIGGER: Garantir exclusividade entre `PessoaFisica` e `PessoaJuridica`, para um mesmo `idCliente` (BEFORE INSERT).

-- Tabelas Auxiliares para Clientes 1:N
CREATE TABLE Enderecos(

-- Atributo Seletor
    tipo ENUM('Residêncial','Comercial') NOT NULL,                    -- Podem Existir Outros Tipos?
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
    idCliente INT NOT NULL,                                
    FOREIGN KEY (idCliente) REFERENCES Clientes(id),
    _status TINYINT DEFAULT TRUE,                          -- Ativo ou Inativo
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,            -- Data de criação
    Alteração DATETIME DEFAULT CURRENT_TIMESTAMP           -- Data da ultima Alteração
);

-- GPT hints
-- TRIGGER: Atualizar `Alteração` para a data atual quando (AFTER UPDATE).
-- TRIGGER: Garantir que somente um endereço residencial principal por cliente pode ser ativo (BEFORE INSERT/UPDATE). ?

CREATE TABLE Contatos(

-- Atributo Seletor     
    tipo ENUM('e-mail','zap','qq','telefone') NOT NULL,

    publico  TINYINT DEFAULT FALSE,                        -- Vendedores Expõem os seus contatos aos clientes
    detalhes VARCHAR(300) NOT NULL,                        -- Descrição de propósito/restrição de horários, Informações úteis à utilização

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    _status TINYINT DEFAULT TRUE,                          -- Ativo ou Inativo
    idCliente INT NOT NULL,                                
    FOREIGN KEY (idCliente) REFERENCES Clientes(id),
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,            -- Data de criação
    Alteração DATETIME DEFAULT CURRENT_TIMESTAMP           -- Data da ultima Alteração
);

-- GPT hints
-- TRIGGER: Atualizar 'Alteracao' para a data atual quando um contato for alterado (AFTER UPDATE).
-- TRIGGER: Impedir múltiplos contatos com o mesmo tipo e cliente ativo ao mesmo tempo (BEFORE INSERT/UPDATE).

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
    Alteração DATETIME DEFAULT CURRENT_TIMESTAMP         -- Data da ultima Alteração
);
-- GPT hints
-- TRIGGER: Atualizar `Alteração` para a data atual quando a forma de pagamento for alterada (AFTER UPDATE).
-- TRIGGER: Garantir unicidade para métodos de pagamento por cliente (BEFORE INSERT).

CREATE TABLE Categorias(

    nome VARCHAR(250) NOT NULL,

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    _status TINYINT DEFAULT TRUE,                        -- Ativo ou Inativo
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,          -- Data de Criação
    Alteração DATETIME DEFAULT CURRENT_TIMESTAMP         -- Data da ultima Alteração 
);

-- GPT hints
-- TRIGGER: Impedir exclusão de categorias associadas a produtos (BEFORE DELETE).

CREATE TABLE Produtos(

    nome VARCHAR(250) NOT NULL,
    descricao VARCHAR(250) NOT NULL,
    unidade_referencia ENUM ('UNIDADE','grama','quilo','litro') NOT NULL,
    fabricante VARCHAR(250) NOT NULL,

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    categoria INT,                                                                   -- Atributo Seletor
    FOREIGN KEY (categoria) REFERENCES Categorias(id),
    _status TINYINT DEFAULT TRUE,                                                    -- Existe nos Estoques?
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,                                      -- Data de Criação
    Alteração DATETIME DEFAULT CURRENT_TIMESTAMP                                     -- Data da ultima Alteração
);

-- GPT hints
-- TRIGGER: Atualizar `Alteração` para a data atual quando um produto for alterado (AFTER UPDATE).

CREATE TABLE Estoque(

    unidade_preco DECIMAL(10, 2) NOT NULL CHECK (unidade_preco >= 0),
    quantidade INT NOT NULL CHECK (quantidade >= 0),

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    idVendedor INT NOT NULL,
    FOREIGN KEY (idVendedor) REFERENCES Clientes(id),
    idProduto INT NOT NULL,
    FOREIGN KEY (idProduto) REFERENCES Produtos(id),
    _status TINYINT DEFAULT TRUE,                          -- Ativo ou Inativo
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,            -- Data de Criação
    Alteração DATETIME DEFAULT CURRENT_TIMESTAMP           -- Data da ultima Alteração
);

-- GPT hints
-- TRIGGER: Atualizar `Alteração` para a data atual quando o estoque for alterado (AFTER UPDATE).
-- TRIGGER: Impedir exclusão de estoques com produtos vinculados a pedidos pendentes (BEFORE DELETE).

--  _status Simplificado para fins de teste
CREATE TABLE Pedidos(

-- Atributo Seletor
    _status ENUM('Em Aberto','Concluído', 'Cancelado','Devolvido') NOT NULL,

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Clientes(id),
    idFormaPagamento INT NOT NULL,                                                  -- Referência à forma de pagamento
    FOREIGN KEY (idFormaPagamento) REFERENCES FormasPagamento(id),
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,                                     -- Data de Criação
    Alteração DATETIME DEFAULT CURRENT_TIMESTAMP                                    -- Data da ultima Alteração
);

-- GPT hints
-- TRIGGER: Atualizar `Alteração` para a data atual quando o pedido for alterado (AFTER UPDATE).

-- Exemplo de Estados no Pedido
-- Status	Descrição
-- CART	Pedido em construção (carrinho de compras).
-- INTENTION	Intenção de compra, sem confirmação.
-- PLACED	Pedido formalizado, aguardando pagamento.
-- AWAITING_PAYMENT	Aguardando confirmação do pagamento.
-- PAYMENT_CONFIRMED	Pagamento aprovado, aguardando processamento.
-- PROCESSING	Pedido em processamento para envio.
-- SHIPPED	Pedido enviado.
-- DELIVERED	Pedido entregue.
-- CANCELED	Pedido cancelado.
-- REFUNDED	Pedido devolvido ou reembolsado.

-- Pagamentos
CREATE TABLE Pagamentos(

-- Atributo Seletor
    _status ENUM('Em Aberto','Pendente', 'Aprovado', 'Rejeitado') NOT NULL DEFAULT 'Em Aberto',
    
    valor_total DECIMAL(10, 2) NOT NULL CHECK (valor_total >= 0),
    data_pagamento DATE NOT NULL,

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Clientes(id),
    idFormaPagamento INT NOT NULL,
    FOREIGN KEY (idFormaPagamento) REFERENCES FormasPagamento(id),
    idPedido INT NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES Pedidos(id),
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,                   -- Data de Criação
    Alteração DATETIME DEFAULT CURRENT_TIMESTAMP                  -- Data da ultima Alteração 
);

CREATE TABLE PedidoItens(

    quantidade INT NOT NULL CHECK (quantidade >= 0),
    impostos DECIMAL(10, 2) NOT NULL CHECK (impostos >= 0),
    frete_item DECIMAL(10, 2) NOT NULL CHECK (frete_item >= 0),

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES Pedidos(id),
    idEstoque INT NOT NULL,
    FOREIGN KEY (idEstoque) REFERENCES Estoque(id)
);

-- GPT hints
-- TRIGGER: Impedir adição de itens a pedidos concluídos ou cancelados (BEFORE INSERT).

-- Pedido Entregas 1:N
CREATE TABLE Entregas(

    _status ENUM('Aguardado Envio', 'Enviado', 'Cancelado','Devolvido') NOT NULL DEFAULT 'Aguardado Envio',
    codRastreio VARCHAR(250) NOT NULL,
    enviado DATETIME,
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    Alteração DATETIME DEFAULT CURRENT_TIMESTAMP,                   -- Data da ultima Alteração
    quantidade INT NOT NULL CHECK (quantidade >= 0),

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES Pedidos(id),
    idItem INT NOT NULL,
    FOREIGN KEY (idItem) REFERENCES PedidoItens(id),
    clienteEndereco INT NOT NULL,                                    -- Do Cliente
    FOREIGN KEY (clienteEndereco) REFERENCES Enderecos(id),
    remetenteEndereco INT NOT NULL,                                  -- Do Vendedor
    FOREIGN KEY (remetenteEndereco) REFERENCES Enderecos(id)
);

-- GPT hints
-- TRIGGER: Atualizar 'alteracao' para a data atual quando a entrega for alterada (AFTER UPDATE).
-- TRIGGER: Impedir alteração de '_status' para "Enviado" sem 'codRastreio' preenchido (BEFORE UPDATE).