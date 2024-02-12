CREATE TABLE customer (
  id BIGINT AUTO_INCREMENT NOT NULL,
   first_name VARCHAR(255) NOT NULL,
   last_name VARCHAR(255) NOT NULL,
   cfp VARCHAR(255) NOT NULL,
   email VARCHAR(255) NOT NULL,
   password VARCHAR(255) NOT NULL,
   income DECIMAL NOT NULL,
   zip_code VARCHAR(255) NOT NULL,
   street VARCHAR(255) NOT NULL,
   number INT NULL,
   CONSTRAINT pk_customer PRIMARY KEY (id)
);

ALTER TABLE customer ADD CONSTRAINT uc_customer_cfp UNIQUE (cfp);

ALTER TABLE customer ADD CONSTRAINT uc_customer_email UNIQUE (email);

CREATE TABLE credit (
  id BIGINT AUTO_INCREMENT NOT NULL,
   credit_code BINARY(16) NOT NULL,
   customer_id BIGINT NOT NULL,
   credit_value DECIMAL NOT NULL,
   number_of_installments INT NOT NULL,
   day_first_installment date NOT NULL,
   status ENUM('IN_PROGRESS', 'APPROVED', 'REJECTED') NOT NULL DEFAULT 'IN_PROGRESS',
   CONSTRAINT pk_credit PRIMARY KEY (id)
);

ALTER TABLE credit ADD CONSTRAINT uc_credit_credit_code UNIQUE (credit_code);

ALTER TABLE credit ADD CONSTRAINT FK_CREDIT_ON_CUSTOMER FOREIGN KEY (customer_id) REFERENCES customer (id);