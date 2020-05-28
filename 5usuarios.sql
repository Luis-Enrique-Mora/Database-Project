Use SuperStarGymServer
Go

Drop Table if Exists [dbo].usuarios
Go

Create Table usuarios
(
	usuario_id int Identity(1,1),
	persona_fk int not null,
	contrasena_usuario varchar(50) not null,
	--Constraints
	--PK
	Constraint PK_usuario Primary Key clustered (usuario_id),
	--FK
	Constraint FK_persona_usuario Foreign Key (persona_fk) References personas (persona_id)
)
Go