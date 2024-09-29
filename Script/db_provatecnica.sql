--Nome do banco "db_provatecnica"

CREATE TABLE tb_clientes (
	Id SERIAL CONSTRAINT pk_id_clientes PRIMARY KEY,
 	Cpf varchar(20) UNIQUE NOT NULL,	
 	Nome varchar(100) UNIQUE NOT NULL,
 	Cep varchar(10) NULL,
 	Logradouro varchar(100) NULL,
 	Numero varchar(10) NULL,
 	Complemento varchar(100) NULL,
 	Bairro varchar(60) NULL,
 	Cidade varchar(100) NULL,
 	Ibge_cidade varchar(7) NULL,
 	Sigla_uf varchar(2) NULL
);

CREATE TABLE tb_contatos (
	Id_Contato SERIAL CONSTRAINT pk_id_contato PRIMARY KEY,
	Nome varchar(50) NOT NULL,
	Data_nasc varchar(10) NULL,
	Idade integer NULL,
	Telefone varchar(15) NULL,
	Id_Cliente integer NOT NULL,
	FOREIGN KEY (Id_Cliente) REFERENCES tb_clientes (Id) ON DELETE 
	CASCADE
);	

CREATE TABLE tb_credores (
	Id SERIAL CONSTRAINT pk_id_credores PRIMARY KEY,
 	Cpf_Cnpj varchar(20) UNIQUE NOT NULL,	
 	Nome varchar(100) UNIQUE NOT NULL, 	
 	Cep varchar(10) NULL,
 	Logradouro varchar(100) NULL,
 	Numero varchar(10) NULL,
 	Complemento varchar(100) NULL,
 	Bairro varchar(60) NULL,
 	Cidade varchar(100) NULL,
 	Ibge_cidade varchar(7) NULL,
 	Sigla_uf varchar(2) NULL
);

CREATE TABLE tb_tipopgto (
	Id	SERIAL CONSTRAINT pk_id_tipopgto PRIMARY KEY,
 	Tipopgto varchar(50) UNIQUE NOT NULL	
);

CREATE TABLE tb_parcelas (
	Id_Parcelas SERIAL CONSTRAINT pk_id_parcelas PRIMARY KEY,
	id_tipo_pgto integer NOT NULL, 
	id_Credor integer NOT NULL,
	id_Cliente integer NOT NULL,
	Valor_total varchar(15),
	Dt_Primeira_parcela varchar(10),
	Vl_Primeira_Parcela varchar(15),
	Dt_Segunda_parcela varchar(10),
	Vl_Segunda_Parcela varchar(15),
	Dt_Terceira_parcela varchar(10),
	Vl_Terceira_Parcela varchar(15),
	Dt_Quarta_parcela varchar(10),
	Vl_Quarta_Parcela varchar(15),
	status integer,
	FOREIGN KEY (id_tipo_pgto) REFERENCES tb_tipopgto (Id) ON DELETE
	CASCADE,
	FOREIGN KEY (Id_Credor) REFERENCES tb_credores (Id) ON DELETE
	CASCADE,
	FOREIGN KEY (Id_Cliente) REFERENCES tb_clientes (Id) ON DELETE
	CASCADE
);