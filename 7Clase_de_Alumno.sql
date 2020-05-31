Use SuperStarGymServer
Go

Drop Table if Exists clases_de_alumnos
Go

Create Table clases_de_alumnos
(
	clase_alumno_id Int Identity(1,1),
	alumno_fk Int not null,
	clas_fecha_fk DateTime not null,
	activi_cod_clas_fk Int not null,
	Constraint PK_clase_de_alumno Primary Key (clase_alumno_id),
	Constraint FK_alumno Foreign Key (alumno_fk) References alumnos(alumno_id),
	Constraint FK_clase Foreign Key (activi_cod_clas_fk, clas_fecha_fk) References clases(actividad_cod_fk, fecha_hora)
)
ON Clase_de_Alumnos
Go