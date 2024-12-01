USE ecommerce;

# SHOW TABLES;
#
# -- User Info
# DESC Perfis;
# DESC Contatos;
# DESC Enderecos;
# DESC FormasPagamentos;
#
# -- Product Info
# DESC Produtos;
# DESC Estoque;
# DESC ProdutosPrecos;
#
# -- Sells Info
# DESC Pedidos;
# DESC PedidoItens;
# DESC Entregas;
# DESC EntregaItens;


SELECT p.*, e.*, c.*, f.*
FROM Perfis p
LEFT JOIN Enderecos e ON p.id = e.idPerfil
LEFT JOIN Contatos c ON p.id = c.idPerfil
LEFT JOIN FormasPagamentos f ON p.id = f.idPerfil
ORDER BY e.estado;



