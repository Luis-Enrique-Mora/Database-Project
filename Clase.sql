Use SuperStarGym
Go

Drop Table if exists [dbo].Clase
Go

Create table Clase
(
	limite_inscripcion int not null,
	total_alumnos int not null,
	fecha_hora DateTime not null,
	Actividad_Cod_fk int not null,
	Constraint PK_Clase Primary Key (Actividad_cod, fecha_hora),
	Constraint FK_Actividad_Clase Foreign key (Actividad_Cod_fk)
	References Actividad(Actividad_Cod)
)
Go