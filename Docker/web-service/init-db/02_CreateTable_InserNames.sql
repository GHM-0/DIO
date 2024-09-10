
-- Crie a tabela names se não existir
CREATE TABLE names (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) UNIQUE NOT NULL
);

-- Insira dados na tabela names
INSERT INTO names (name) VALUES
('ana'),
('maria'),
('pedro'),
('leticia'),
('carlos')
ON CONFLICT (name) DO NOTHING;
