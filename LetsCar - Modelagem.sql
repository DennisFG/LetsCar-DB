CREATE DATABASE LetsCar
GO

USE LetsCar;

CREATE TABLE Carro
(
	ID INT IDENTITY NOT NULL,
	Marca VARCHAR(100) NOT NULL,
	Modelo VARCHAR(100) NOT NULL,
	Ano INT NOT NULL,
	Cor VARCHAR(100) NOT NULL,
	Preco INT NOT NULL,
	PRIMARY KEY(ID)
);

CREATE TABLE ModalidadePagamento
(
	ID INT IDENTITY NOT NULL,
	FK_Carro INT NOT NULL,
	Modalidade VARCHAR(100) NOT NULL,
	CONSTRAINT FK_ModalidadePagamento_Carro FOREIGN KEY (FK_Carro) REFERENCES Carro(ID),
	PRIMARY KEY(ID)
);

CREATE TABLE Equipamento
(
	ID INT IDENTITY NOT NULL,
	NomeEquipamento VARCHAR(100) NOT NULL,
	PRIMARY KEY(ID)
);

CREATE TABLE Adicionais
(
	ID INT IDENTITY NOT NULL,
	FK_Carro INT NOT NULL,
	FK_Equipamento INT NOT NULL,
	CONSTRAINT FK_Adicionais_Carro FOREIGN KEY (FK_Carro) REFERENCES Carro(ID),
	CONSTRAINT FK_Adicionais_Equipamento FOREIGN KEY (FK_Equipamento) REFERENCES Equipamento(ID),
	PRIMARY KEY(ID)
);

CREATE TABLE Cliente
(
	ID INT IDENTITY NOT NULL,
	CPF INT NOT NULL,
	OutrosDados VARCHAR(200),
	PRIMARY KEY(ID)
);

CREATE TABLE Usuario
(
	ID INT IDENTITY NOT NULL,
	FK_Cliente INT,
	Nome VARCHAR(200) NOT NULL,
	TelContato VARCHAR(20) NOT NULL,
	EmailContato VARCHAR(200) NOT NULL,
	PRIMARY KEY(ID)
);

CREATE TABLE CarrosComentados
(
	ID INT IDENTITY NOT NULL,
	FK_Carro INT NOT NULL,
	FK_Usuario INT NOT NULL,
	Comentario VARCHAR(1000) NOT NULL,
	CONSTRAINT FK_CarrosComentados_Carro FOREIGN KEY (FK_Carro) REFERENCES Carro(ID),
	CONSTRAINT FK_CarrosComentados_Usuario FOREIGN KEY (FK_Usuario) REFERENCES Usuario(ID),
	PRIMARY KEY(ID)
);

CREATE TABLE CarrosFavoritados
(
	ID INT IDENTITY NOT NULL,
	FK_Carro INT NOT NULL,
	FK_Cliente INT NOT NULL,
	CONSTRAINT FK_CarrosFavoritados_Carro FOREIGN KEY (FK_Carro) REFERENCES Carro(ID),
	CONSTRAINT FK_CarrosFavoritados_Cliente FOREIGN KEY (FK_Cliente) REFERENCES Cliente(ID),
	PRIMARY KEY(ID)
);