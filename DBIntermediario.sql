-- Criação e uso do Banco
create database LojaRoupa;
use LojaRoupa;

-- Criação das tabelas
create table ProdutoCategoria (
	idCategoria int primary key not null identity,
	nome varchar(100) not null,
	descricao varchar(100) not null
);

create table ProdutoMarca (
	idMarca int primary key not null identity,
	nome varchar(30) not null
);

create table Produto (
	idProduto int primary key not null identity,
	idMarca int not null,
	foreign key (idMarca) references ProdutoMarca(idMarca),
	idcategoria int not null,
	foreign key (idCategoria) references ProdutoCategoria(idCategoria),
	nome varchar(100) not null,
	descricao varchar(500) not null,
	cor varchar(35) not null,
	valorCusto decimal(10,2) not null,
	valorVenda decimal(10,2) not null,
	tamanho varchar(5) not null,
	imagem varchar(250) not null
);

create table ProdutoEstoque (
	idEstoque int primary key not null identity,
	idProduto int not null,
	foreign key (idProduto) references Produto(idProduto) on delete cascade,
	quantidade int not null
);

create table Cliente (
	idCliente int primary key not null identity,
	titulo varchar(20) not null,
	primeiroNome varchar(30) not null,
	meioInicial varchar(30) null,
	ultimoNome varchar(30) not null,
	telefone varchar(20) not null,
	email varchar(100) not null
);

-- Inserção dos dados
insert into ProdutoCategoria(nome, descricao) values
('Roupas', 'Camisas, calças, vestidos e muito mais.'),
('Acessórios', 'Cintos, bolsas, chapéus...'),
('Calçados', 'Tênis, sapatos chinelos...');

insert into ProdutoMarca(nome) values
('Nike'),
('Adidas'),
('Hering'),
('Gucci'),
('Prada');

insert into Produto(idMarca, idCategoria, nome, descricao, cor, valorCusto, valorVenda, tamanho, imagem) values
(1, 1, 'Camiseta Esportiva Nike', 'Camiseta leve, ideal para treinos.', 'Azul', 45.00, 89.90, 'M', 'camiseta_nike.png'),
(2, 1, 'Jaqueta Adidas', 'Jaqueta corta-vento confortável.', 'Preta', 120.00, 249.90, 'G', 'jaqueta_adidas.png'),
(3, 1, 'Camisa Polo Hering', 'Camisa polo casual de algodão.', 'Branca', 35.00, 69.90, 'M', 'camisa_polo_hering.png'),
(3, 1, 'Calça Jeans Hering', 'Calça jeans tradicional com tecido resistente.', 'Azul Escuro', 70.00, 139.90, 'G', 'calca_jeans_hering.png'),
(4, 2, 'Cinto de Couro Gucci', 'Cinto de couro com fivela dourada', 'Marrom', 350.00, 599.90, 'U', 'cinto_gucci.png'),
(5, 2, 'Bolsa de Ombro Prada', 'Bolsa de ombro em couro', 'Preta', 1200.00, 1999.90, 'U', 'bolsa_prada.png'),
(1, 2, 'Boné Nike Air', 'Boné esportivo com logo bordado', 'Branco', 60.00, 129.90, 'U', 'bone_nike.png'),
(2, 2, 'Mochila Adidas Sport', 'Mochila esportiva com 3 compartimentos', 'Azul', 90.00, 179.90, 'U', 'mochila_adidas.png'),
(1, 3, 'Tênis Nike Air Zoom', 'Tênis esportivo confortável, ideal para corrida', 'Branco', 250.00, 399.90, '42', 'tenis_nike_airzoom.png'),
(2, 3, 'Tênis Adidas Ultraboost', 'Tênis com tecnologia de amortecimento, ideal para treino', 'Preto', 300.00, 499.90, '41', 'tenis_adidas_ultraboost.png'),
(4, 3, 'Tênis Gucci Ace Branco', 'Tênis de couro branco com listras verde e vermelha características da marca. Confortável e estiloso, ideal para uso casual.', 'Branco', 900.00, 1799.90, '42', 'tenis_gucci_ace_branco.png'),
(5, 3, 'Tênis Prada Cloudbust Thunder', 'Tênis esportivo com design moderno e solado robusto, oferecendo conforto e estilo urbano.', 'Preto', 1000.00, 1999.90, '41', 'tenis_prada_cloudbust_thunder_preto.png');


insert into ProdutoEstoque(idProduto, quantidade) values
(1, 50),
(2, 30),
(3, 60),
(4, 40),
(5, 25),
(6, 15),
(7, 70),
(8, 45),
(9, 35),
(10, 30),
(11, 10),
(12, 8);

insert into Cliente(titulo, primeiroNome, meioInicial, ultimoNome, telefone, email) values
('Sra.', 'Ana', 'Lívia', 'Borges', '(14) 91234-5678', 'bgs.ana08@email.com'),
('Sr.', 'Diego', null, 'Junior', '(14) 99465-9764', 'dfsntsjunior@gmail.com'),
('Sr.', 'David', 'Luiz', 'dos Santos', '(14) 99758-9770', 'david.luiz@gmail.com'),
('Prof.','José', 'Antônio', 'Gallo Junior', '(14) 99389-9529', 'gallo.junior@gmail.com'),
('Prof.','Márcio', null, 'de Moraes', '(14) 99487-9548', 'marcio.moraes@gmail.com');

-- ATIVIDADES DO DESAFIO BANCO DE DADOS INTERMEDIÁRIO:

-- 1) Recuperar informações sobre produtos e suas categorias, incluindo nome, categoria e quantidade de estoque do produto
select 	p.nome as "Nome do Produto",
		c.nome as "Categoria",
		e.quantidade as "Quantidade em Estoque"
from Produto p
inner join produtoCategoria c on p.idCategoria = c.idCategoria
inner join produtoEstoque e on p.idProduto = e.idProduto;

-- 2) Excluir todos os produtos da categoria "Roupa"
delete from Produto
where idCategoria =
(
	select idCategoria from ProdutoCategoria
	where nome = 'Roupas'
);

-- 3) Recuperar lista de nomes completos
select 
    case
        when meioInicial is not null then concat(titulo, ' ', primeiroNome, ' ', meioInicial, ' ', ultimoNome)
        else concat(titulo, ' ', primeiroNome, ' ', ultimoNome)
    end as NomeCompleto
from Cliente;