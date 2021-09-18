DELETE FROM <tabela> WHERE <condi��o>;

SELECT* FROM Carro;
SELECT* FROM ModalidadePagamento;
SELECT* FROM Equipamento;
SELECT* FROM Adicionais;
SELECT* FROM Cliente;
SELECT* FROM Usuario;
SELECT* FROM CarrosComentados;
SELECT* FROM CarrosFavoritados;

EXEC InserirCarro 'GM', 'Cruze', 2014, 'Branco', 30000;
EXEC ExcluirCarro 1;
EXEC EditarPreco 1, 30000;
EXEC FiltrarCarros 'GM','Cruze', 2014, 'Branco',27000,31000;
EXEC VerDetalhes 2;

EXEC InserirModalidadePagamento 2, 'Cart�o';
EXEC ExcluirModalidadePagamento 2;
EXEC EditarModalidadePagamento 1, 'Cart�o 12x';
EXEC FormasPagamento 1;

EXEC InserirEquipamento 'Dire��o el�trica';
EXEC ExcluirEquipamento 3;
EXEC EditarEquipamento 4, 'Super Dire��o El�trica';
EXEC VerTodosEquipamentos;

EXEC InserirAdicional 1, 4;
EXEC ExcluirAdicional 1;
EXEC EditarAdicional 1, 2, 1;
EXEC VerAdicionais 1;

EXEC InserirCliente 22222,NULL;
EXEC ExcluirCliente 2;
EXEC EditarCliente 3, 'moro em marte';
EXEC ClientesCadastrados;

EXEC InserirUsuario NULL, 'Renato', '44 44444444', 'renato@nuvem.com';
EXEC ExcluirUsuario 2;
EXEC EditarUsuario 1, 3, 'Joz�','55 555555555','Joz�@nuvem.com';
EXEC VerUsuarios;

EXEC InserirComentario 2, 3, 'Carro feio, me enganei';
EXEC ExcluirComentario 4;
EXEC EditarComentario 5, 'Corrigindo, carro � mais ou menos';
EXEC VerComentarios;
EXEC ContarComentarios;

EXEC Favoritar 3, 3;
EXEC Desfavoritar 2;
EXEC VerFavoritados 3;



SELECT CarrosComentados.ID AS IdComentario, Usuario.ID AS IdUsuario, Usuario.Nome, Carro.Id AS IdCarro, Comentario
		FROM CarrosComentados
		INNER JOIN Usuario
				ON Usuario.ID = CarrosComentados.FK_Usuario
		INNER JOIN Carro
				ON Carro.ID = CarrosComentados.FK_Carro