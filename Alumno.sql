Use SuperStarGym
Go

Drop Table if Exists [dbo].Alumnos
Go

Create Table Alumnos
(
	Alumno_Id int Identity (1,1),
	Cedula Varchar(25) unique not null,
	Nombre Varchar(50) not null,
	Apellido1 Varchar(25) not null,
	Apellido2 Varchar(25) not null,
	Edad int not null,
	Direccion Varchar(200),
	Constraint PK_Alumno Primary Key (Alumno_Id)
)
Go

/*Create Clustered Index Alumno_Nombre_Apellido1_idx
On Alumnos(Nombre, Apellido1)*/
