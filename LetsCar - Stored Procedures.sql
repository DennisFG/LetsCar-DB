-- STORED PROCEDURES

	-- 1. tabela Carro

			-- a) Inser��o

CREATE PROCEDURE InserirCarro
	@Marca VARCHAR(100),
	@Modelo VARCHAR(100),
	@Ano INT,
	@Cor VARCHAR(100),
	@Preco INT
AS   
	INSERT INTO Carro(Marca, Modelo, Ano, Cor, Preco)
		VALUES (@Marca, @Modelo, @Ano, @Cor, @Preco)
GO

			-- b) Exclus�o

CREATE PROCEDURE ExcluirCarro
	@ID INT
AS   
	DELETE FROM Carro WHERE ID = @ID;
GO

			-- c) Edi��o

CREATE PROCEDURE EditarPreco
	@ID INT,
	@Preco INT
AS   
	UPDATE Carro
		SET Preco = @Preco
		WHERE ID = @ID
GO

			-- d) Sele��o

				-- 1) Vizualiza��o geral dos carros dispon�veis

CREATE PROCEDURE FiltrarCarros
	@Marca VARCHAR(100),
	@Modelo VARCHAR(100),
	@Ano INT,
	@Cor VARCHAR(100),
	@PrecoMin INT,
	@PrecoMax INT
AS
	SELECT *
		FROM Carro
		WHERE Marca = @Marca AND Modelo = @Modelo AND Ano = @Ano AND Cor = @Cor AND Preco BETWEEN @PrecoMin AND @PrecoMax
GO
		
				-- 2) Vizualiza��o de todos os adicionais de determinado carro (ap�s achar o ID do na PROCEDURE anterior) PENDENTE

CREATE PROCEDURE VerDetalhes
	@ID INT
AS
	SELECT Equipamento.NomeEquipamento
		FROM Carro
			INNER JOIN Adicionais
				ON Adicionais.FK_Carro = Carro.ID
			INNER JOIN Equipamento
				ON Equipamento.ID = Adicionais.FK_Equipamento
		WHERE Carro.ID = @ID
GO

	-- 2. tabela ModalidadePagamento

		-- a) Inser��o

CREATE PROCEDURE InserirModalidadePagamento
	@FK_Carro INT,
	@Modalidade VARCHAR(100)
AS   
	INSERT INTO ModalidadePagamento(FK_Carro, Modalidade)
		VALUES (@FK_Carro, @Modalidade)
GO

		-- b) Exclus�o

CREATE PROCEDURE ExcluirModalidadePagamento
	@ID INT
AS   
	DELETE FROM ModalidadePagamento WHERE ID = @ID;
GO

		-- c) Edi��o

CREATE PROCEDURE EditarModalidadePagamento
	@ID INT,
	@Modalidade VARCHAR(100)
AS   
	UPDATE ModalidadePagamento
		SET Modalidade = @Modalidade
		WHERE ID = @ID
GO

		-- d) Sele��o
			
			-- 1) Visualizar formas de pagamento para determinado carro

CREATE PROCEDURE FormasPagamento
	@ID_Carro INT
AS
	SELECT *
		FROM ModalidadePagamento
		WHERE FK_Carro = @ID_Carro
GO

	-- 3. tabela Equipamento

		-- a) Inser��o

CREATE PROCEDURE InserirEquipamento
	@NomeEquipamento VARCHAR(100)
AS   
	INSERT INTO Equipamento (NomeEquipamento)
		VALUES (@NomeEquipamento)
GO

		-- b) Exclus�o

CREATE PROCEDURE ExcluirEquipamento
	@ID INT
AS   
	DELETE FROM Equipamento WHERE ID = @ID;
GO

		-- c) Edi��o

CREATE PROCEDURE EditarEquipamento
	@ID INT,
	@Equipamento VARCHAR(100)
AS   
	UPDATE Equipamento
		SET NomeEquipamento = @Equipamento
		WHERE ID = @ID
GO

		-- d) Sele��o
			
			-- 1) Visualizar todos os equipamentos

CREATE PROCEDURE VerTodosEquipamentos
AS
	SELECT *
		FROM Equipamento
GO

	-- 4. tabela Adicionais

		-- a) Inser��o

CREATE PROCEDURE InserirAdicional
	@IdCarro INT,
	@IdEquipamento INT
AS   
	INSERT INTO Adicionais(FK_Carro, FK_Equipamento)
		VALUES (@IdCarro, @IdEquipamento)
GO

		-- b) Exclus�o

CREATE PROCEDURE ExcluirAdicional
	@ID INT
AS   
	DELETE FROM Adicionais WHERE ID = @ID;
GO

		-- c) Edi��o

CREATE PROCEDURE EditarAdicional
	@ID INT,
	@IdCarro INT,
	@IdEquipamento INT
AS   
	UPDATE Adicionais
		SET FK_Carro = @IdCarro, FK_Equipamento = @IdEquipamento
		WHERE ID = @ID
GO

		-- d) Sele��o
			
			-- 1) Visualizar todos os adicionais de determinado carro

CREATE PROCEDURE VerAdicionais
	@IdCarro INT
AS
	SELECT Carro.ID AS IdCarro, Equipamento.NomeEquipamento
		FROM Adicionais
			INNER JOIN Carro
				ON Carro.ID = Adicionais.FK_Carro
			INNER JOIN Equipamento
				ON Equipamento.ID = Adicionais.FK_Equipamento
		WHERE Carro.ID = @IdCarro
GO

	-- 5. tabela Cliente

		-- a) Inser��o

CREATE PROCEDURE InserirCliente
	@CPF INT,
	@OutrosDados VARCHAR(200)
AS   
	INSERT INTO Cliente(CPF, OutrosDados)
		VALUES (@CPF, @OutrosDados)
GO

		-- b) Exclus�o

CREATE PROCEDURE ExcluirCliente
	@ID INT
AS   
	DELETE FROM Cliente WHERE ID = @ID;
GO

		-- c) Edi��o

CREATE PROCEDURE EditarCliente
	@ID INT,
	@OutrosDados VARCHAR(200)
AS   
	UPDATE Cliente
		SET OutrosDados = @OutrosDados
		WHERE ID = @ID
GO

		-- d) Sele��o
			
			-- 1) Visualizar todos os clientes cadastrados

CREATE PROCEDURE ClientesCadastrados
AS
	SELECT *
		FROM Cliente
GO

	-- 6. tabela Usuario

		-- a) Inser��o

CREATE PROCEDURE InserirUsuario
	@IdCliente INT,
	@Nome VARCHAR(200),
	@TelContato VARCHAR(20),
	@EmailContato VARCHAR(200)
AS   
	INSERT INTO Usuario(FK_Cliente, Nome, TelContato, EmailContato)
		VALUES (@IdCliente, @Nome, @TelContato, @EmailContato)
GO

		-- b) Exclus�o

CREATE PROCEDURE ExcluirUsuario
	@ID INT
AS   
	DELETE FROM Usuario WHERE ID = @ID;
GO

		-- c) Edi��o

CREATE PROCEDURE EditarUsuario
	@ID INT,
	@IdCliente INT,
	@Nome VARCHAR(200),
	@TelContato VARCHAR(20),
	@EmailContato VARCHAR(200)
AS   
	UPDATE Usuario
		SET FK_Cliente = @IdCliente, Nome = @Nome, TelContato = @TelContato, EmailContato = @EmailContato
		WHERE ID = @ID
GO

		-- d) Sele��o
			
			-- 1) Visualizar todos os usu�rios e, se forem clientes, seus outros dados

CREATE PROCEDURE VerUsuarios
AS
	SELECT Usuario.ID AS IdUsuario, Nome, TelContato, EmailContato, Cliente.ID AS IdCliente, CPF, OutrosDados
		FROM Usuario
		LEFT JOIN Cliente
				ON Cliente.ID = Usuario.FK_Cliente
GO

	-- 7. tabela CarrosComentados

		-- a) Inser��o

CREATE PROCEDURE InserirComentario
	@IdCarro INT,
	@IdUsuario INT,
	@Comentario VARCHAR(1000)
AS   
	INSERT INTO CarrosComentados(FK_Carro,FK_Usuario,Comentario)
		VALUES (@IdCarro, @IdUsuario, @Comentario)
GO

		-- b) Exclus�o

CREATE PROCEDURE ExcluirComentario
	@ID INT
AS   
	DELETE FROM CarrosComentados WHERE ID = @ID;
GO

		-- c) Edi��o

CREATE PROCEDURE EditarComentario
	@ID INT,
	@Comentario VARCHAR(1000)
AS   
	UPDATE CarrosComentados
		SET Comentario = @Comentario
		WHERE ID = @ID
GO

		-- d) Sele��o
			
			-- 1) Visualizar todos os coment�rios, o nome do usu�rio que comentou e o carro a que se refere

CREATE PROCEDURE VerComentarios
AS
	SELECT CarrosComentados.ID AS IdComentario, Usuario.ID AS IdUsuario, Usuario.Nome, Carro.Id AS IdCarro, Comentario
		FROM CarrosComentados
		INNER JOIN Usuario
				ON Usuario.ID = CarrosComentados.FK_Usuario
		INNER JOIN Carro
				ON Carro.ID = CarrosComentados.FK_Carro
GO

			-- 2) Visualizar quantida de coment�rios por carro

CREATE PROCEDURE ContarComentarios
AS
	SELECT FK_Carro, COUNT(CarrosComentados.Comentario)
		FROM CarrosComentados
		GROUP BY FK_Carro
GO

	-- 8. tabela CarrosFavoritados

		-- a) Inser��o

CREATE PROCEDURE Favoritar
	@IdCarro INT,
	@IdCliente INT
AS   
	INSERT INTO CarrosFavoritados(FK_Carro, FK_Cliente)
		VALUES (@IdCarro, @IdCliente)
GO

		-- b) Exclus�o

CREATE PROCEDURE Desfavoritar
	@ID INT
AS   
	DELETE FROM CarrosFavoritados WHERE ID = @ID;
GO

		-- c) Edi��o
			
			-- N�o � o caso, eu acho :D

		-- d) Sele��o
			
			-- 1) Visualizar todos os carros favoritados por determinado usu�rio

CREATE PROCEDURE VerFavoritados
	@IdCliente INT
AS
	SELECT FK_Carro AS IdCarro
		FROM CarrosFavoritados
		INNER JOIN Cliente
				ON Cliente.ID = CarrosFavoritados.FK_Cliente
		WHERE Cliente.ID = @IdCliente
GO