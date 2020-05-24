Use SuperStarGym
Go

Drop Table if Exists [dbo].actividades
Go

Create table actividades
(
	Actividad_Cod int Identity (1,1) not null,
	Nombre_Actividad Varchar(50) not null,
	Descripcion varchar(255),
	Constraint PK_Actividad Primary Key(Actividad_Cod)
)
Go