USE jdbc_test;

CREATE TABLE IF NOT EXISTS employees(
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    salary DECIMAL(10,2),
    birthday TIMESTAMP NOT NULL,
    PRIMARY KEY(id)
)engine=InnoDB default charset=utf8;