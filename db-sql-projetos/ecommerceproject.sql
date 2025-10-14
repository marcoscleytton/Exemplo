create database ecommerce;

use ecommerce;

create table cliente(
idcliente int auto_increment primary key,
Fname varchar (10),
Minit char (3),
Lname varchar(20),
CPF char(11) not null,
constraint unique_cpf_cliente unique (CPF),
endereço varchar(30)
);

create table produto(
idproduto int auto_increment primary key,
nomeproduto varchar (10),
classificacão_kids bool,
categoria enum ('Eletronico', 'Vestimento', 'Brinquedo', 'Alimento', 'Bebidas', 'Moveis') not null,
avaliação float default 0,
dimensão varchar (10)
);

create table pedido(
idpedido int auto_increment primary key,
idPedidocliente int,
pedidoStatus enum('Cancelado','Confirmado','Em Processamento'),
descriçãopedido varchar(255),
frete float default 10,
boleto bool default false,
valortotal_pedido float
);

create table pagamento(
idcliente int,
idpagamento int primary key ,
tipo_Pagamento enum('Pix','Boleto','Cartão') not null,
Valor float
);

create table estoque(
idestoque int auto_increment primary key,
localidade varchar(45),
quantidade int default 0 
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

