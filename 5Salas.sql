use SuperStarGymServer
Go
Drop table if Exists salas
Go
Create Table salas
(
	sala_id int Identity(1,1) not null,
	nombre_sala varchar(20),
	--Constraints
	--PK
	Constraint PK_sala Primary Key (sala_id)
)
ON Clases
GO
