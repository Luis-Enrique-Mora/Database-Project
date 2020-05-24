Use SuperStarGym
Go

Drop Table if Exists [dbo].clases
Go

Create table clases
(
	limite_inscripcion int not null,
	total_alumnos int not null,
	fecha_hora DateTime not null,
	actividad_cod_fk int not null,
	Constraint PK_Clase Primary Key (actividad_cod_fk, fecha_hora),
	Constraint FK_actividad_clase Foreign key (actividad_cod_fk)
	References actividades(actividad_cod)
)
Go