Use SuperStarGym
Go

Create Table Clase_De_Alumno
(
	Clase_Alumno_Id Int Identity(1,1),
	Alumno_fk Int not null,
	Clas_Fecha_fk DateTime not null,
	Activi_Cod_clas_fk Int not null,
	Constraint PK_Clase_De_Alumno Primary Key (Clase_Alumno_Id),
	Constraint FK_Alumno Foreign Key (Alumno_fk) References Alumnos(Alumno_Id),
	Constraint FK_Clase Foreign Key (Activi_Cod_clas_fk, Clas_Fecha_fk) References Clases(Actividad_cod_fk, fecha_hora)
)
Go