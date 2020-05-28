Use SuperStarGymServer
Go

Drop Table if Exists [dbo].personas
Go

Create Table personas
(
	persona_id int Identity (1,1),
	cedula Varchar(25) unique not null,
	nombre Varchar(50) not null,
	apellido1 Varchar(25) not null,
	apellido2 Varchar(25) not null,
	fecha_naci Date not null,
	direccion Varchar(200),
	--Constraints
	--PK
	Constraint PK_persona Primary Key Clustered (persona_id)
)
Go