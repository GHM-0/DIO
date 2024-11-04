DROP DATABASE ecommerce;
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

CREATE TABLE Perfis(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(250) NOT NULL,
    identificador VARCHAR(29) NOT NULL UNIQUE,
    ativo TINYINT DEFAULT TRUE,
    criado DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Enderecos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    CEP VARCHAR(250) NOT NULL,
    estado ENUM('RJ','ES','SP') NOT NULL,
    tipo ENUM('Residencial','Comercial') NOT NULL,
    cidade VARCHAR(250) NOT NULL,
    bairro VARCHAR(250) NOT NULL,
    rua VARCHAR(250) NOT NULL,
    numero INT NOT NULL,
    complemento VARCHAR(250) NOT NULL,
    ativo TINYINT DEFAULT TRUE,
    idPerfil INT NOT NULL,
    FOREIGN KEY (idPerfil) REFERENCES Perfis(id)
);

CREATE TABLE Contatos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('e-mail','zap','qq') NOT NULL,
    detalhes VARCHAR(300) NOT NULL,
    ativo TINYINT DEFAULT TRUE,
    idPerfil INT NOT NULL,
    FOREIGN KEY (idPerfil) REFERENCES Perfis(id)
);

CREATE TABLE Pagamentos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    metodo ENUM('PIX','TRANSFER','PAYPAL') NOT NULL,
    detalhes VARCHAR(300) NOT NULL,
    idPerfil INT NOT NULL,
    FOREIGN KEY (idPerfil) REFERENCES Perfis(id),
    criado DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Pedidos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    estatus ENUM('Aguardando', 'Concluido', 'Cancelado') NOT NULL,
    -- idPerfil INT NOT NULL,
    -- FOREIGN KEY (idPerfil) REFERENCES Perfis(id),
    idPagamento INT NOT NULL,
    FOREIGN KEY (idPagamento) REFERENCES Pagamentos(id),
    valor DECIMAL(7, 2) NOT NULL CHECK (valor >= 0),
    criado DATETIME DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Produtos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(250) NOT NULL,
    descricao VARCHAR(250) NOT NULL,
    uni_ref ENUM ('UNIDADE','grama','quilo','litro') NOT NULL,
    fabricante VARCHAR(250) NOT NULL,
    ativo TINYINT DEFAULT TRUE,
    criado DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Cotacoes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    uni_preco DECIMAL(7, 2) NOT NULL CHECK (uni_preco >= 0),
    ativo TINYINT DEFAULT TRUE,
    idPerfil INT NOT NULL,
    FOREIGN KEY (idPerfil) REFERENCES Perfis(id),
    idProduto INT NOT NULL,
    FOREIGN KEY (idProduto) REFERENCES Produtos(id),
    criado DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Estoque(
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantidade INT NOT NULL CHECK (quantidade >= 0),
    idCotacao INT NOT NULL,
    FOREIGN KEY (idCotacao) REFERENCES Cotacoes(id),
    idProduto INT NOT NULL,
    FOREIGN KEY (idProduto) REFERENCES Produtos(id),
    idPerfil INT NOT NULL,
    FOREIGN KEY (idPerfil) REFERENCES Perfis(id),
    criado DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Entregas(
    id INT AUTO_INCREMENT PRIMARY KEY,
    estatus ENUM('Planejado', 'Enviado', 'Cancelado') NOT NULL,
    codRastreio VARCHAR(250) NOT NULL,
    enviado DATETIME,
    idPedido INT NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES Pedidos(id),
    idEndereco INT NOT NULL,
    FOREIGN KEY (idEndereco) REFERENCES Enderecos(id),
    criado DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE PedidoItens(
    id INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES Pedidos(id),
    idProduto INT NOT NULL,
    FOREIGN KEY (idProduto) REFERENCES Produtos(id),
    idCotacao INT NOT NULL,
    FOREIGN KEY (idCotacao) REFERENCES Cotacoes(id),
    idPerfil INT NOT NULL,
    FOREIGN KEY (idPerfil) REFERENCES Perfis(id),
    quantidade INT NOT NULL CHECK (quantidade >= 0)
);

CREATE TABLE EntregaItens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    idEntrega INT NOT NULL,
    FOREIGN KEY (idEntrega) REFERENCES Entregas(id),
    idItem INT NOT NULL,
    FOREIGN KEY (idItem) REFERENCES PedidoItens(id),
    quantidade INT NOT NULL CHECK (quantidade >= 0)
);
