Use SuperStarGym
Go

Drop Table if exists [dbo].Clases
Go

Create table Clases
(
	limite_inscripcion int not null,
	total_alumnos int not null,
	fecha_hora DateTime not null,
	Actividad_Cod_fk int not null,
	Constraint PK_Clase Primary Key (Actividad_cod_fk, fecha_hora),
	Constraint FK_Actividad_Clase Foreign key (Actividad_Cod_fk)
	References Actividades(Actividad_Cod)
)
Go