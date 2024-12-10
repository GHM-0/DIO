DROP DATABASE IF EXISTS  oficina;
CREATE DATABASE IF NOT EXISTS oficina;

USE oficina;

CREATE TABLE Clientes(

--  Generalização de Clientes
    nome VARCHAR(250) NOT NULL,                           -- Abstrai nome em 'Pessoa Física' e nome_fantasia em 'Pessoa Jurídica'
    identificador VARCHAR(29) NOT NULL UNIQUE,            -- Abstrai CPF em 'Pessoa Física' e CNPJ em 'Pessoa Jurídica', Considerar REGEX

    tipo ENUM('PF','PJ') NOT NULL,                        -- Atributo Seletor

    -- Pessoa Física
    dataNascimento DATE DEFAULT NULL,                     -- Estabelece Faixa Etária
    sexo ENUM('M', 'F', 'O') DEFAULT NULL,                -- Estabelece Gênero

    -- Pessoa Jurídica
    razaoSocial VARCHAR(250) DEFAULT NULL   ,             -- Poderia estar atrelada a várias nomes fantasia?
    inscricaoEstadual VARCHAR(20) DEFAULT NULL,

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    _status TINYINT DEFAULT TRUE,                         -- Ativo ou Inativo
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,           -- Data de criação
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP,         -- Data da ultima alteração

    CHECK (
        (tipo = 'PF' AND dataNascimento IS NOT NULL
                     AND sexo IS NOT NULL
                     AND razaoSocial IS NULL
                     AND inscricaoEstadual IS NULL
        )
        OR
        (tipo = 'PJ' AND razaoSocial IS NOT NULL
                     AND inscricaoEstadual IS NOT NULL
                     AND dataNascimento IS NULL
                     AND sexo IS NULL
        )
    )
);

CREATE TABLE Contatos(

-- Atributo Seletor
    tipo ENUM('e-mail','zap','qq','telefone') NOT NULL,
    detalhes VARCHAR(300) NOT NULL,

-- Metadata
    id INT AUTO_INCREMENT PRIMARY KEY,
    _status TINYINT DEFAULT TRUE,                          -- Ativo ou Inativo
    idCliente INT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Clientes(id),
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,            -- Data de criação
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP           -- Data da ultima Alteração
);

-- GPT hints
-- TRIGGER: Atualizar 'Alteracao' para a data atual quando um contato for alteracao (AFTER UPDATE).
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
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP         -- Data da ultima Alteração
);
-- GPT hints
-- TRIGGER: Atualizar `Alteração` para a data atual quando a forma de pagamento for alterada (AFTER UPDATE).
-- TRIGGER: Garantir unicidade para métodos de pagamento por cliente (BEFORE INSERT).

CREATE TABLE Enderecos(

    CEP VARCHAR(8) NOT NULL,
    estado ENUM('RJ','ES','SP') NOT NULL,
    tipo ENUM('Residencial','Comercial') NOT NULL,
    cidade VARCHAR(40) NOT NULL,
    bairro VARCHAR(40) NOT NULL,
    rua VARCHAR(40) NOT NULL,
    numero INT NOT NULL,
    complemento VARCHAR(250),

    id INT AUTO_INCREMENT PRIMARY KEY,
    _status TINYINT DEFAULT TRUE,
    idCliente INT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Clientes(id),
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Veiculos(

    fabricante VARCHAR(25) NOT NULL,
    modelo VARCHAR(25) NOT NULL,
    cor VARCHAR(25) NOT NULL,
    tipo ENUM('Carro','Moto','Van','Caminhão') NOT NULL DEFAULT 'Carro',
    ano INT UNSIGNED NOT NULL CHECK (ano >= 1920),
    placa VARCHAR (20) NOT NULL,

    id INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Clientes(id),
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Item(

    nome VARCHAR(25) NOT NULL,
    fabricante VARCHAR(25) NOT NULL,
    descricao VARCHAR(18) NOT NULL,
    modelo_ref VARCHAR(25) NOT NULL,
    quantidade INT NOT NULL,
    valor_uni DECIMAL(7, 2) UNSIGNED NOT NULL CHECK (valor_uni >= 0),

    id INT AUTO_INCREMENT PRIMARY KEY,
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Servicos(

    nome VARCHAR(45) NOT NULL,
    descricao VARCHAR(140) NOT NULL,
    prazo INT NOT NULL,
    tipo ENUM('Reparo','Substituição','Verificação','Higienização'),
    valor DECIMAL(7, 2) NOT NULL CHECK (valor >= 0),

    id INT AUTO_INCREMENT PRIMARY KEY,
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Funcionarios(

    nome VARCHAR(40) NOT NULL,
    cargo VARCHAR(40) NOT NULL,
    admissao date NOT NULL,

    id INT AUTO_INCREMENT PRIMARY KEY,
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Funcao(
    nome VARCHAR(68) NOT NULL,
    id INT AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE Equipes(

    id INT AUTO_INCREMENT PRIMARY KEY,
    idServico INT NOT NULL,
    FOREIGN KEY (idServico) REFERENCES Servicos(id),
    idFuncao INT NOT NULL,
    FOREIGN KEY (idFuncao) REFERENCES Funcao(id),
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE EquipeFuncionarios(

    funcao VARCHAR(30) NOT NULL,
    mao_de_obra DECIMAL(7,2) NOT NULL,

    id INT AUTO_INCREMENT PRIMARY KEY,
    idFuncionario INT NOT NULL,
    FOREIGN KEY (idFuncionario) REFERENCES Funcionarios(id),
    idEquipe INT NOT NULL,
    FOREIGN KEY (idEquipe) REFERENCES Equipes(id),
    responsavel TINYINT NOT NULL DEFAULT FALSE,
    _status TINYINT NOT NULL,
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE OrdensServicos(

    valor DECIMAL(7,2) UNSIGNED NOT NULL,
    finalizacao DATE NOT NULL,

    id INT AUTO_INCREMENT PRIMARY KEY,
    idVeiculo INT NOT NULL,
    FOREIGN KEY (idVeiculo) REFERENCES Veiculos(id),
    idServico INT NOT NULL,
    FOREIGN KEY (idServico) REFERENCES Servicos(id),
    idEquipe INT NOT NULL,
    FOREIGN KEY (idEquipe) REFERENCES Equipes(id),
    idCliente INT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Clientes(id),
    _status ENUM('Aguardando','Executando','Concluído') NOT NULL DEFAULT 'Aguardando',
    criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    alteracao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ItensReposicao(

    quantidade INT NOT NULL,

    id INT AUTO_INCREMENT PRIMARY KEY,
    idOrdemServico INT NOT NULL,
    FOREIGN KEY (idOrdemServico) REFERENCES OrdensServicos(id),
    idItem INT NULL DEFAULT NULL,
    FOREIGN KEY (idItem) REFERENCES Item(id)
);

CREATE TABLE Relatorios(

    conteudo VARCHAR(1000) NOT NULL,

    id INT AUTO_INCREMENT PRIMARY KEY,
    idOrdemServico INT NOT NULL,
    responsavel INT NOT NULL,
    FOREIGN KEY (responsavel) REFERENCES Funcionarios(id)
);

-- Onde colocar idOrdemServico
CREATE TABLE Pagamentos(

    valor_total DECIMAL(7,2),
    dataVencimento DATE NOT NULL,

    id INT AUTO_INCREMENT PRIMARY KEY,
    idFormaPagamento INT NOT NULL,
    FOREIGN KEY (idFormaPagamento) REFERENCES FormasPagamento(id),
    _status TINYINT NOT NULL
);

CREATE TABLE PagamentosOrdensServico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    idPagamento INT NOT NULL,
    idOrdemServico INT NOT NULL,
    FOREIGN KEY (idPagamento) REFERENCES Pagamentos(id),
    FOREIGN KEY (idOrdemServico) REFERENCES OrdensServicos(id)
);
