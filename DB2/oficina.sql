DROP DATABASE IF EXISTS  oficina;
CREATE DATABASE IF NOT EXISTS oficina;
USE oficina;

CREATE TABLE Clientes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(250) NOT NULL,
    identificador VARCHAR(29) NOT NULL UNIQUE,
    endereco VARCHAR(280) NOT NULL,
    criado DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Veiculos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    fabricante VARCHAR(25) NOT NULL,
    modelo VARCHAR(25) NOT NULL,
    cor VARCHAR(25) NOT NULL,
    tipo ENUM('Carro','Moto','Van','Caminhão') NOT NULL DEFAULT 'Carro',
    ano INT NOT NULL CHECK (ano >= 1920),
    idCliente INT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Clientes(id),
    criado DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Itens(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(25) NOT NULL,
    fabricante VARCHAR(25) NOT NULL,
    descricao VARCHAR(25) NOT NULL,
    modelo_ref VARCHAR(25) NOT NULL,
    quantidade INT NOT NULL,
    valor_uni DECIMAL(7, 2) NOT NULL CHECK (valor_uni >= 0)
);

CREATE TABLE Servicos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(25) NOT NULL,
    descricao VARCHAR(25) NOT NULL,
    prazo DATE NOT NULL,
    tipo VARCHAR(25) NOT NULL,
    valor DECIMAL(7, 2) NOT NULL CHECK (valor >= 0)
);

CREATE TABLE Funcionarios(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(25) NOT NULL,
    cargo VARCHAR(25) NOT NULL,
    admissao date NOT NULL
);

CREATE TABLE Equipes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    funcao VARCHAR(25) NOT NULL,
    idServico INT NOT NULL,
    FOREIGN KEY (idServico) REFERENCES Servicos(id)
);

CREATE TABLE EquipesFuncionarios(
    id INT AUTO_INCREMENT PRIMARY KEY,
    funcao VARCHAR(45) NOT NULL,
    mao_de_obra DECIMAL(7,2) NOT NULL,
    idFuncionario INT NOT NULL,
    FOREIGN KEY (idFuncionario) REFERENCES Funcionarios(id),
    idEquipe INT NOT NULL,
    FOREIGN KEY (idEquipe) REFERENCES Equipes(id),
    _status TINYINT NOT NULL
);


CREATE TABLE OrdensServicos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    criacao  DATETIME DEFAULT CURRENT_TIMESTAMP,
    idVeiculo INT NOT NULL,
    FOREIGN KEY (idVeiculo) REFERENCES Veiculos(id),
    idServico INT NOT NULL,
    FOREIGN KEY (idServico) REFERENCES Servicos(id),
    idEquipe INT NOT NULL,
    FOREIGN KEY (idEquipe) REFERENCES Equipes(id),
    valorTotal DECIMAL(7,2) NOT NULL,
    finalizacao DATE NOT NULL,
    criado DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ItensReposicao(
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantidade INT NOT NULL,
    idOrdemServico INT NOT NULL,
    FOREIGN KEY (idOrdemServico) REFERENCES OrdensServicos(id),
    idItem INT NOT NULL,
    FOREIGN KEY (idItem) REFERENCES Itens(id)
);

CREATE TABLE Relatorios(
    id INT AUTO_INCREMENT PRIMARY KEY,
    idOrdemServico INT NOT NULL,
    FOREIGN KEY (idOrdemServico) REFERENCES OrdensServicos(id),
    idServico INT NOT NULL,
    FOREIGN KEY (idServico) REFERENCES Servicos(id),
    contetudo VARCHAR(1000) NOT NULL,
    responsavel INT NOT NULL,
    FOREIGN KEY (responsavel) REFERENCES Funcionarios(id)
);

















