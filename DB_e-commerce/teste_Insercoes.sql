USE ecommerce;

-- Pure GTP hints, Sobre os registros
SELECT 'Clientes' AS Tabela, COUNT(*) AS Quantidade_Total, SUM(CASE WHEN _status = TRUE THEN 1 ELSE 0 END) AS Ativo, SUM(CASE WHEN _status = FALSE THEN 1 ELSE 0 END) AS Inativos
FROM Clientes UNION ALL
SELECT'PessoaFisica',COUNT(*),NULL AS Ativos,NULL AS Inativos
FROM PessoaFisica UNION ALL
SELECT'PessoaJuridica',COUNT(*),NULL AS Ativos, NULL AS Inativos
FROM PessoaJuridica UNION ALL
SELECT'Enderecos',COUNT(*),SUM(CASE WHEN _status = TRUE THEN 1 ELSE 0 END),SUM(CASE WHEN _status = FALSE THEN 1 ELSE 0 END)
FROM Enderecos UNION ALL
SELECT'Contatos',COUNT(*),SUM(CASE WHEN _status = TRUE THEN 1 ELSE 0 END),SUM(CASE WHEN _status = FALSE THEN 1 ELSE 0 END)
FROM Contatos UNION ALL
SELECT'FormasPagamento',COUNT(*),SUM(CASE WHEN _status = TRUE THEN 1 ELSE 0 END) AS Ativo,SUM(CASE WHEN _status = FALSE THEN 1 ELSE 0 END)
FROM FormasPagamento UNION ALL
SELECT'Categorias',COUNT(*),SUM(CASE WHEN _status = TRUE THEN 1 ELSE 0 END),SUM(CASE WHEN _status = FALSE THEN 1 ELSE 0 END)
FROM Categorias UNION ALL
SELECT'Produtos',COUNT(*),SUM(CASE WHEN _status = TRUE THEN 1 ELSE 0 END),SUM(CASE WHEN _status = FALSE THEN 1 ELSE 0 END)
FROM Produtos UNION ALL
SELECT'Estoque',COUNT(*),SUM(CASE WHEN _status = TRUE THEN 1 ELSE 0 END),SUM(CASE WHEN _status = FALSE THEN 1 ELSE 0 END)
FROM Estoque UNION ALL
SELECT'Pedidos',COUNT(*),SUM(CASE WHEN _status = TRUE THEN 1 ELSE 0 END),SUM(CASE WHEN _status = FALSE THEN 1 ELSE 0 END)
FROM Pedidos UNION ALL
SELECT'PedidoItens',COUNT(*),NULL,NULL
FROM PedidoItens UNION ALL
SELECT'Pagamentos',COUNT(*),NULL,NULL
FROM Pagamentos UNION ALL
SELECT'Entregas',COUNT(*),NULL,NULL
FROM Entregas;

-- Pedidos por STATUS
SELECT P._status,COUNT(*) AS Pedidos FROM Pedidos AS P
GROUP BY P._status;

-- Entregas por STATUS
SELECT E._status,COUNT(*) AS Entregas FROM Entregas AS E
GROUP BY E._status;

-- Cliente Ativos com Endereço, Contato e Formas de Pagamento válidos;
SELECT C.nome, C.identificador,FP.metodo, FP.detalhes, E.tipo, E.estado, E.CEP,E.cidade,E.bairro,E.rua ,E.numero, E.complemento FROM Clientes AS C
LEFT JOIN Enderecos E ON E.idCliente = C.id
LEFT JOIN Contatos CO ON CO.idCliente = C.id
LEFT JOIN FormasPagamento FP ON FP.idCliente = C.id
WHERE C._status=TRUE AND E._status=TRUE AND CO._status=TRUE
ORDER BY FP.metodo;

-- Produtos por Categoria.
SELECT C.nome AS Categoria, count(*) AS Total_Produtos FROM Categorias AS C
LEFT JOIN Produtos AS P ON P.categoria = C.id
GROUP BY C.nome;

-- Produtos que Mais Vendem no Catálogo.
SELECT PR.nome AS Produto, SUM(PI.quantidade) AS Total_Vendas FROM Produtos AS PR
LEFT JOIN Estoque AS E ON PR.id = E.idProduto                     -- Alta Granularidade, Não!
LEFT JOIN PedidoItens AS PI ON E.id = PI.idEstoque
LEFT JOIN Pedidos AS P ON PI.idPedido = P.id
WHERE P._status='Concluído' AND PR._status=TRUE                            -- Logicamente devem haver em Estoque
GROUP BY PR.nome;


-- Produtos fora de catalogo
SELECT P.nome, E.quantidade, E.unidade_preco FROM Estoque AS E
JOIN Produtos AS P ON E.id = P.id
WHERE quantidade=0;

-- Que Clientes sem Estoque
SELECT C.nome,C.id FROM Clientes AS C
LEFT JOIN Estoque AS E ON C.id = E.idVendedor
WHERE E.idVendedor IS NULL;

--
SELECT C.id,C.nome,FP.metodo,FP.id FROM PessoaFisica as PF
LEFT JOIN Clientes C on PF.idCliente = C.id
LEFT JOIN FormasPagamento FP on C.id = FP.idCliente
WHERE FP._status=TRUE
ORDER BY FP.metodo;

-- Pessoas Físicas
SELECT * FROM PessoaFisica AS PF
LEFT JOIN Clientes AS C on PF.idCliente = C.id;

-- Calcular Valor_Total em Pagamento para Pedidos
SELECT
    PI.idPedido AS Pedido,
    E.idVendedor AS Vendedor,
    PR.id,
    PR.nome AS Produto,
    PI.quantidade AS Quantidade,
    P.idCliente AS Cliente,
    E.unidade_preco,
    PI.frete_item,
    PI.impostos,
    SUM((PI.quantidade * E.unidade_preco)+(PI.quantidade * PI.impostos) + PI.frete_item) AS Valor_Total      -- O frete deveria * ?
FROM Pedidos AS P
JOIN PedidoItens PI ON PI.idPedido = P.id
JOIN Produtos PR ON PR.id = PI.idEstoque
JOIN Estoque E ON E.id = PI.idEstoque
WHERE P._status = 'Concluído'
GROUP BY  E.idVendedor,PI.idPedido , PR.nome, PI.quantidade, PR.id ,  P.idCliente, E.unidade_preco, PI.frete_item, PI.impostos;


-- Clientes que possuem + de 1 endereço, ! distingue ativo/inativo
SELECT idCliente, COUNT(id) FROM Enderecos
GROUP BY idCliente
HAVING COUNT(id) > 1;

-- Vendedores com uma unidade de produto em Estoque
SELECT idVendedor,idProduto, quantidade AS TOTAL FROM Estoque AS E
WHERE E.quantidade = 1 AND E._status=TRUE;                               -- Lógica necessário pela ausência de Triggers


-- Número total de Produtos em Estoques por Produto
SELECT E.idProduto, PR.nome, SUM(E.quantidade) AS TOTAL_ESTOQUES FROM Estoque AS E
JOIN Produtos PR on E.idProduto = PR.id
WHERE E._status=TRUE
GROUP BY E.idProduto, PR.nome
ORDER BY  TOTAL_ESTOQUES DESC;


-- Quantos pedidos foram feitos por cada cliente?
SELECT C.id As ClienteID, COUNT(P.id) FROM Pedidos AS P
JOIN Clientes As C ON P.idCliente = C.id
WHERE P._status='Concluído'
GROUP BY C.id;

-- Quantos pedidos foram feitos por cada cliente? Por STATUS
SELECT P.idCliente, P._status AS status, COUNT(P.id) AS QTD_Pedidos
FROM Pedidos P
GROUP BY P.idCliente,P._status
ORDER BY P.idCliente,P._status;

-- Quantos pedidos foram feitos por cada cliente? Independente do STATUS
SELECT C.id As ClienteID, COUNT(P.id) FROM Pedidos AS P
JOIN Clientes As C ON P.idCliente = C.id
GROUP BY C.id;

-- Algum vendedor também é fornecedor? / algum Cliente e Vendedor
SELECT DISTINCT C.id AS ClienteID,E.idVendedor AS Vendedor,P.idCliente AS Cliente, C.nome AS Cliente FROM Clientes AS C
LEFT JOIN Estoque E ON C.id = E.idVendedor  -- Vendedores
LEFT JOIN Pedidos P ON C.id = P.idCliente   -- Clientes
WHERE (E.idVendedor IS NOT NULL) AND  (P.idCliente IS NOT NULL);                             -- Responde a essa pergunta

-- Responde Quais Clientes Não Possuem Pedidos ou Estoques
SELECT DISTINCT C.id AS ClienteID,E.idVendedor AS Vendedor,P.idCliente AS Cliente, C.nome AS Cliente FROM Clientes AS C
LEFT JOIN Estoque E ON C.id = E.idVendedor  -- Vendedores
LEFT JOIN Pedidos P ON C.id = P.idCliente   -- Clientes
WHERE (E.idVendedor IS NULL) AND  (P.idCliente IS NULL);


-- Responde Quais Clientes Não Possuem Pedidos ou Estoques  & Estão Inativos
SELECT DISTINCT C.id AS ClienteID,E.idVendedor AS Vendedor,P.idCliente AS Cliente, C.nome AS Cliente FROM Clientes AS C
LEFT JOIN Estoque E ON C.id = E.idVendedor  -- Vendedores
LEFT JOIN Pedidos P ON C.id = P.idCliente   -- Clientes
WHERE (E.idVendedor IS NULL) AND  (P.idCliente IS NULL)AND C._status=FALSE;

-- Relação de produtos fornecedores e estoques;
SELECT PR.nome,E.idVendedor,E.quantidade FROM Estoque AS E
JOIN Produtos AS PR ON E.idProduto = PR.id
JOIN Clientes AS C ON E.idVendedor = C.id
WHERE PR._status=TRUE AND E.quantidade>0
GROUP BY PR.nome,E.idVendedor,E.quantidade
ORDER BY  E.idVendedor;

-- Relação de nomes dos fornecedores e nomes dos produtos;
SELECT C.nome, PR.nome,E.quantidade FROM Estoque AS E
JOIN Produtos AS PR ON E.idProduto = PR.id
JOIN Clientes AS C ON E.idVendedor = C.id
WHERE PR._status=TRUE AND E.quantidade>0 AND E._status=TRUE AND C._status=TRUE
ORDER BY  C.nome;


