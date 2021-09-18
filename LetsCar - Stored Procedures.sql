-- STORED PROCEDURES

	-- 1. tabela Carro

			-- a) Inserção

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

			-- b) Exclusão

CREATE PROCEDURE ExcluirCarro
	@ID INT
AS   
	DELETE FROM Carro WHERE ID = @ID;
GO

			-- c) Edição

CREATE PROCEDURE EditarPreco
	@ID INT,
	@Preco INT
AS   
	UPDATE Carro
		SET Preco = @Preco
		WHERE ID = @ID
GO

			-- d) Seleção

				-- 1) Vizualização geral dos carros disponíveis

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
		
				-- 2) Vizualização de todos os adicionais de determinado carro (após achar o ID do na PROCEDURE anterior) PENDENTE

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

		-- a) Inserção

CREATE PROCEDURE InserirModalidadePagamento
	@FK_Carro INT,
	@Modalidade VARCHAR(100)
AS   
	INSERT INTO ModalidadePagamento(FK_Carro, Modalidade)
		VALUES (@FK_Carro, @Modalidade)
GO

		-- b) Exclusão

CREATE PROCEDURE ExcluirModalidadePagamento
	@ID INT
AS   
	DELETE FROM ModalidadePagamento WHERE ID = @ID;
GO

		-- c) Edição

CREATE PROCEDURE EditarModalidadePagamento
	@ID INT,
	@Modalidade VARCHAR(100)
AS   
	UPDATE ModalidadePagamento
		SET Modalidade = @Modalidade
		WHERE ID = @ID
GO

		-- d) Seleção
			
			-- 1) Visualizar formas de pagamento para determinado carro

CREATE PROCEDURE FormasPagamento
	@ID_Carro INT
AS
	SELECT *
		FROM ModalidadePagamento
		WHERE FK_Carro = @ID_Carro
GO

	-- 3. tabela Equipamento

		-- a) Inserção

CREATE PROCEDURE InserirEquipamento
	@NomeEquipamento VARCHAR(100)
AS   
	INSERT INTO Equipamento (NomeEquipamento)
		VALUES (@NomeEquipamento)
GO

		-- b) Exclusão

CREATE PROCEDURE ExcluirEquipamento
	@ID INT
AS   
	DELETE FROM Equipamento WHERE ID = @ID;
GO

		-- c) Edição

CREATE PROCEDURE EditarEquipamento
	@ID INT,
	@Equipamento VARCHAR(100)
AS   
	UPDATE Equipamento
		SET NomeEquipamento = @Equipamento
		WHERE ID = @ID
GO

		-- d) Seleção
			
			-- 1) Visualizar todos os equipamentos

CREATE PROCEDURE VerTodosEquipamentos
AS
	SELECT *
		FROM Equipamento
GO

	-- 4. tabela Adicionais

		-- a) Inserção

CREATE PROCEDURE InserirAdicional
	@IdCarro INT,
	@IdEquipamento INT
AS   
	INSERT INTO Adicionais(FK_Carro, FK_Equipamento)
		VALUES (@IdCarro, @IdEquipamento)
GO

		-- b) Exclusão

CREATE PROCEDURE ExcluirAdicional
	@ID INT
AS   
	DELETE FROM Adicionais WHERE ID = @ID;
GO

		-- c) Edição

CREATE PROCEDURE EditarAdicional
	@ID INT,
	@IdCarro INT,
	@IdEquipamento INT
AS   
	UPDATE Adicionais
		SET FK_Carro = @IdCarro, FK_Equipamento = @IdEquipamento
		WHERE ID = @ID
GO

		-- d) Seleção
			
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

		-- a) Inserção

CREATE PROCEDURE InserirCliente
	@CPF INT,
	@OutrosDados VARCHAR(200)
AS   
	INSERT INTO Cliente(CPF, OutrosDados)
		VALUES (@CPF, @OutrosDados)
GO

		-- b) Exclusão

CREATE PROCEDURE ExcluirCliente
	@ID INT
AS   
	DELETE FROM Cliente WHERE ID = @ID;
GO

		-- c) Edição

CREATE PROCEDURE EditarCliente
	@ID INT,
	@OutrosDados VARCHAR(200)
AS   
	UPDATE Cliente
		SET OutrosDados = @OutrosDados
		WHERE ID = @ID
GO

		-- d) Seleção
			
			-- 1) Visualizar todos os clientes cadastrados

CREATE PROCEDURE ClientesCadastrados
AS
	SELECT *
		FROM Cliente
GO

	-- 6. tabela Usuario

		-- a) Inserção

CREATE PROCEDURE InserirUsuario
	@IdCliente INT,
	@Nome VARCHAR(200),
	@TelContato VARCHAR(20),
	@EmailContato VARCHAR(200)
AS   
	INSERT INTO Usuario(FK_Cliente, Nome, TelContato, EmailContato)
		VALUES (@IdCliente, @Nome, @TelContato, @EmailContato)
GO

		-- b) Exclusão

CREATE PROCEDURE ExcluirUsuario
	@ID INT
AS   
	DELETE FROM Usuario WHERE ID = @ID;
GO

		-- c) Edição

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

		-- d) Seleção
			
			-- 1) Visualizar todos os usuários e, se forem clientes, seus outros dados

CREATE PROCEDURE VerUsuarios
AS
	SELECT Usuario.ID AS IdUsuario, Nome, TelContato, EmailContato, Cliente.ID AS IdCliente, CPF, OutrosDados
		FROM Usuario
		LEFT JOIN Cliente
				ON Cliente.ID = Usuario.FK_Cliente
GO

	-- 7. tabela CarrosComentados

		-- a) Inserção

CREATE PROCEDURE InserirComentario
	@IdCarro INT,
	@IdUsuario INT,
	@Comentario VARCHAR(1000)
AS   
	INSERT INTO CarrosComentados(FK_Carro,FK_Usuario,Comentario)
		VALUES (@IdCarro, @IdUsuario, @Comentario)
GO

		-- b) Exclusão

CREATE PROCEDURE ExcluirComentario
	@ID INT
AS   
	DELETE FROM CarrosComentados WHERE ID = @ID;
GO

		-- c) Edição

CREATE PROCEDURE EditarComentario
	@ID INT,
	@Comentario VARCHAR(1000)
AS   
	UPDATE CarrosComentados
		SET Comentario = @Comentario
		WHERE ID = @ID
GO

		-- d) Seleção
			
			-- 1) Visualizar todos os comentários, o nome do usuário que comentou e o carro a que se refere

CREATE PROCEDURE VerComentarios
AS
	SELECT CarrosComentados.ID AS IdComentario, Usuario.ID AS IdUsuario, Usuario.Nome, Carro.Id AS IdCarro, Comentario
		FROM CarrosComentados
		INNER JOIN Usuario
				ON Usuario.ID = CarrosComentados.FK_Usuario
		INNER JOIN Carro
				ON Carro.ID = CarrosComentados.FK_Carro
GO

			-- 2) Visualizar quantida de comentários por carro

CREATE PROCEDURE ContarComentarios
AS
	SELECT FK_Carro, COUNT(CarrosComentados.Comentario)
		FROM CarrosComentados
		GROUP BY FK_Carro
GO

	-- 8. tabela CarrosFavoritados

		-- a) Inserção

CREATE PROCEDURE Favoritar
	@IdCarro INT,
	@IdCliente INT
AS   
	INSERT INTO CarrosFavoritados(FK_Carro, FK_Cliente)
		VALUES (@IdCarro, @IdCliente)
GO

		-- b) Exclusão

CREATE PROCEDURE Desfavoritar
	@ID INT
AS   
	DELETE FROM CarrosFavoritados WHERE ID = @ID;
GO

		-- c) Edição
			
			-- Não é o caso, eu acho :D

		-- d) Seleção
			
			-- 1) Visualizar todos os carros favoritados por determinado usuário

CREATE PROCEDURE VerFavoritados
	@IdCliente INT
AS
	SELECT FK_Carro AS IdCarro
		FROM CarrosFavoritados
		INNER JOIN Cliente
				ON Cliente.ID = CarrosFavoritados.FK_Cliente
		WHERE Cliente.ID = @IdCliente
GO