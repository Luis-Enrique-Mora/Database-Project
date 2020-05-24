Use SuperStarGym
Go

Create Table Clase_De_Alumno
(
	Clase_Alumno_Id Int Identity(1,1),
	Alumno_fk Int not null,
	Clase_fk Int not null,
	Constraint PK_Clase_De_Alumno Primary Key (Clase_Alumno_Id),
	Constraint FK_Alumno Foreign Key (Alumno_fk) References Alumnos (Alumno_Id),
	Constraint FK_Clase Foreign Key (Clase_fk) References Clases(PK_Clase)
)