USE oficina;

SELECT 'Clientes' AS Clientes,COUNT(*)  FROM Clientes UNION ALL
SELECT 'Contatos' AS Contatos,COUNT(*)  FROM Contatos UNION ALL
SELECT 'Endereco' AS Enderecos,COUNT(*)  FROM Enderecos UNION ALL
SELECT 'Veiculos' AS Veiculos, COUNT(*)  FROM Veiculos UNION ALL
SELECT 'Equipes'  AS Equipes, COUNT(*)  FROM Equipes UNION ALL
SELECT 'EquipeFuncionarios' AS EquipeFuncionarios,COUNT(*)  FROM EquipeFuncionarios UNION ALL
SELECT 'FormasPagamento' AS FormasPagamento,COUNT(*)  FROM FormasPagamento UNION ALL
SELECT 'Funcionarios' AS Funcionarios,COUNT(*)  FROM Funcionarios UNION ALL
SELECT 'Item' AS Item,COUNT(*)  FROM Item UNION ALL
SELECT 'ItensReposicao' AS ItensReposicao,COUNT(*)  FROM ItensReposicao UNION ALL
SELECT 'OrdensServicos' AS OrdensServicos,COUNT(*) AS OrdensServicos FROM OrdensServicos UNION ALL
SELECT 'Relatorios' AS Relatorios,COUNT(*)  FROM Relatorios UNION ALL
SELECT 'Servicos' AS Servicos,COUNT(*)  FROM Servicos UNION ALL
SELECT 'Pagamentos' AS Pagamentos,COUNT(*)  FROM Pagamentos;

-- Veículos por Cliente
SELECT C.nome, C.tipo, V.fabricante, V.modelo, V.cor, V.tipo, V.ano FROM Clientes AS C
JOIN Veiculos AS V ON C.id = V.idCliente;

-- Ordens de Serviço por Pagamentos
SELECT POS.idPagamento AS Pagamento, S.id AS idOrdemServico, S.nome AS Servico, OS.valor AS ValorFinalServico FROM PagamentosOrdensServico POS
JOIN OrdensServicos OS ON POS.idOrdemServico = OS.id
JOIN Servicos S ON OS.idServico = S.id;

-- Pagamentos com multiplas Ordens de serviço
SELECT  P.id, P.valor_total, P.dataVencimento, COUNT(POS.idOrdemServico) AS OrdensServiço FROM Pagamentos P
JOIN PagamentosOrdensServico POS ON P.id = POS.idPagamento
GROUP BY P.id, P.valor_total, P.dataVencimento
HAVING COUNT(POS.idOrdemServico) > 1;


-- Itens Valor por Pagamento
SELECT P.id AS Pagamento, OS.id AS OrdemServico, IR.idItem, I.nome AS nomeItem, (I.valor_uni * IR.quantidade) AS precoItens, S.nome AS Servico,
OS.valor AS ValorFinal FROM PagamentosOrdensServico POS                 -- Granularidade Alta demais
JOIN Pagamentos P ON POS.idPagamento = P.id
JOIN OrdensServicos OS ON POS.idOrdemServico = OS.id
JOIN ItensReposicao IR ON OS.id = IR.idOrdemServico
JOIN Item I ON IR.idItem = I.id
JOIN Servicos S ON OS.idServico = S.id;

-- O Serviço Mais Comuns
SELECT count(*) Frequencia, S.nome AS Servico FROM PagamentosOrdensServico POS
JOIN OrdensServicos OS ON POS.idOrdemServico = OS.id
JOIN Servicos S ON OS.idServico = S.id
GROUP BY S.nome;

-- Os Clientes Mais frequentes
SELECT count(*) Frequencia, C.nome FROM Pagamentos P
JOIN FormasPagamento AS FP ON FP.id = P.idFormaPagamento             -- Granularidade alta, replicar idCliente em Pagamento
JOIN Clientes AS C ON FP.idCliente = C.id
GROUP BY C.nome;

-- Relatórios de Trocas de pneu
SELECT C.nome As Cliente, R.conteudo,S.nome AS Serviço, F.nome AS Responsavel FROM Relatorios AS R
JOIN OrdensServicos AS OS ON OS.id = R.idOrdemServico
JOIN Servicos AS S ON OS.idServico = S.id
JOIN Clientes AS C ON C.id = OS.idCliente
JOIN Funcionarios AS F ON F.id = R.responsavel
WHERE S.nome LIKE 'Troca de Pn%';

-- Ordens de Serviço por Cliente e _status de Pagamento
SELECT C.nome, OS.id AS OrdemServiço,P.valor_total, OS._status AS estatus FROM OrdensServicos AS OS
JOIN PagamentosOrdensServico AS POS ON OS.id = POS.idOrdemServico
JOIN Pagamentos AS P ON P.id=POS.idPagamento
JOIN FormasPagamento AS FP ON FP.id = P.idFormaPagamento
JOIN Clientes AS C ON C.id = FP.idCliente;

-- Ordens de serviço por Veículo
SELECT V.modelo, OS.valor,S.nome As Serviço,E.id AS Equipe,OS._status As status FROM OrdensServicos AS OS
JOIN Veiculos AS V ON OS.idVeiculo = V.id
JOIN Servicos AS S ON OS.idServico = S.id
JOIN Equipes AS E ON E.id = OS.idEquipe
ORDER BY OS._status;

-- Serviços Por Cliente
SELECT count(*) Numero_Serviços, C.nome AS Cliente, SUM(OS.valor) AS Total FROM OrdensServicos AS OS
JOIN Clientes AS C ON C.id = OS.idCliente
GROUP BY C.nome;

-- Funcionários/Equipes por Função
SELECT FC.nome AS EquipeFunção, F.nome,F.cargo FROM Equipes AS E
JOIN EquipeFuncionarios AS EF ON E.id = EF.idEquipe
JOIN Funcionarios AS F ON EF.idFuncionario = F.id
JOIN Funcao AS FC ON E.idFuncao = FC.id


-- Serviços Não Pagos ou Pendentes
SELECT C.nome, P._status AS Estado FROM Pagamentos AS P
JOIN FormasPagamento AS FP ON FP.id = P.idFormaPagamento
JOIN Clientes AS C ON FP.idCliente = C.id
WHERE P._status != TRUE;