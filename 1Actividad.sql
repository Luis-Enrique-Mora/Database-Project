Use SuperStarGymServer
Go

Drop Table if Exists [dbo].actividades
Go

Create table actividades
(
	actividad_cod int Identity (1,1) not null,
	nombre_actividad Varchar(50) not null,
	descripcion varchar(255),
	--Constraints
	--PK
	Constraint PK_actividad Primary Key(actividad_Cod)
)
ON Actividades
Go