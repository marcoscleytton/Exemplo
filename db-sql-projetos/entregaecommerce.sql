create database entregaecommerce;

use entregaecommerce;

create table cliente(
cliente_id int auto_increment primary key,
nome varchar(10),
minit char(2),
lastname varchar(10),
email varchar(25),
CPF char (11) null null unique,
endereço varchar(30)
);

create table produto(
produto_id int auto_increment primary key,
nome varchar(50),
estoque int default 0,
preço float,
avaliação float default 0
);

create table pedido(
pedido_id int auto_increment primary key,
data_pedido date,
valortotal_pedido float,
constraint fk_clientepedido foreign key (cliente_id) references cliente (cliente_id)
);

create table itempedido(
item_id int auto_increment primary key,
pedido_id int,
quantidade int default 0,
constraint fk_itemcliente foreign key (pedido_id) references pedido (pedido_id),
constraint fk_itemproduto foreign key (produto_id) references produto (produto_id)
);

create table pagamento(
pagamento_id int auto_increment primary key,
pedido_id int,
forma_pagamento enum('Pix','Boleto','Cartão') not null,
constraint fk_pagamentopedido foreign key (pedido_id) references pedido (pedido_id),
constraint fk_valortotal_Pedido foreign key (valortotal_pedido) references pedido(idpedido)
);

create table entrega(
entrega_id int auto_increment primary key,
pedido_id int,
codigo_rastreio char(13),
status_entrega enum('Cancelado','Confirmado','Em Processamento') default 'Em Pocessamento',
constraint fk_entrega foreign key (pedido_id) references pedido (pedido_id)
);

create table fornecedor(
idfornecedor int auto_increment primary key,
razãosocial varchar(45),
CNPJ char(15),
contato char(11) not null,
constraint unique_fornecedor unique(CNPJ)
);

create table vendedor(
idvendedor int auto_increment primary key,
razãosocial varchar (45) not null,
localidadevendedor varchar(255),
nomefantasia varchar(45),
CNPJ char(15),
CPF char(11),
contatovendedor char(11),
constraint unique_CNPJ_vendedor unique(CNPJ),
constraint unique_CPF_vendedor unique(CPF)
);

create table produtosvendedor(
idprodutosvendedor int,
idproduto int,
quantidades int default 1 ,
primary key (idprodutosvendedor, idproduto),
constraint fk_produtos_vendedor foreign key (idprodutosvendedor) references vendedor(idvendedor),
constraint fk_produtos foreign key(idproduto) references produto(idproduto)
);

-- Quantos pedidos foram feitos por cada cliente?
SELECT c.nome AS cliente, COUNT(p.pedido_id) AS total_pedidos
FROM Cliente c
LEFT JOIN Pedido p ON c.cliente_id = p.cliente_id
GROUP BY c.nome;

-- Algum vendedor também é fornecedor?
SELECT DISTINCT v.nome AS vendedor_fornecedor
FROM Cliente v
INNER JOIN Fornecedor f ON v.cliente_id = f.cliente_id;

-- Relação de produtos fornecedores e estoques?
SELECT p.nome AS produto, f.nome AS fornecedor, p.estoque
FROM Produto p
INNER JOIN FornecedorProduto fp ON p.produto_id = fp.produto_id
INNER JOIN Fornecedor f ON fp.fornecedor_id = f.fornecedor_id;

-- Relação de nomes dos fornecedores e nomes dos produtos?
SELECT f.nome AS fornecedor, GROUP_CONCAT(p.nome) AS produtos
FROM Fornecedor f
INNER JOIN FornecedorProduto fp ON f.fornecedor_id = fp.fornecedor_id
INNER JOIN Produto p ON fp.produto_id = p.produto_id
GROUP BY f.nome;
