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
	--constraints
	--PK
	--The clustered key was created to search data faster, data will be found faster when is searched by actividad_cod_fk or fecha_hora
	Constraint PK_Clase Primary Key clustered (actividad_cod_fk, fecha_hora),
	--FK
	Constraint FK_actividad_clase Foreign key (actividad_cod_fk)
	References actividades(actividad_cod)
)
Go