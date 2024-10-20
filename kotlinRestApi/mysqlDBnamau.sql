show databases;
drop database restapi;
drop database restapi_test;


create database restapi;
create database restapi_test;

use restapi;
CREATE TABLE customers (
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

ALTER TABLE customers ADD CONSTRAINT uc_customer_cfp UNIQUE (cfp);

ALTER TABLE customers ADD CONSTRAINT uc_customer_email UNIQUE (email);

CREATE TABLE credits (
  id BIGINT AUTO_INCREMENT NOT NULL,
   credit_code BINARY(16) NOT NULL,
   customer_id BIGINT NOT NULL,
   credit_value DECIMAL NOT NULL,
   number_of_installments INT NOT NULL,
   day_first_installment date NOT NULL,
   status ENUM('IN_PROGRESS', 'APPROVED', 'REJECTED') NOT NULL DEFAULT 'IN_PROGRESS',
   CONSTRAINT pk_credit PRIMARY KEY (id)
);

ALTER TABLE credits ADD CONSTRAINT uc_credit_credit_code UNIQUE (credit_code);

ALTER TABLE credits ADD CONSTRAINT FK_CREDIT_ON_CUSTOMER FOREIGN KEY (customer_id) REFERENCES customers (id);


use restapi_test;
CREATE TABLE customers (
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

ALTER TABLE customers ADD CONSTRAINT uc_customer_cfp UNIQUE (cfp);

ALTER TABLE customers ADD CONSTRAINT uc_customer_email UNIQUE (email);

CREATE TABLE credits (
  id BIGINT AUTO_INCREMENT NOT NULL,
   credit_code BINARY(16) NOT NULL,
   customer_id BIGINT NOT NULL,
   credit_value DECIMAL NOT NULL,
   number_of_installments INT NOT NULL,
   day_first_installment date NOT NULL,
   status ENUM('IN_PROGRESS', 'APPROVED', 'REJECTED') NOT NULL DEFAULT 'IN_PROGRESS',
   CONSTRAINT pk_credit PRIMARY KEY (id)
);

ALTER TABLE credits ADD CONSTRAINT uc_credit_credit_code UNIQUE (credit_code);

ALTER TABLE credits ADD CONSTRAINT FK_CREDIT_ON_CUSTOMER FOREIGN KEY (customer_id) REFERENCES customers (id);

show databases;
show tables;
