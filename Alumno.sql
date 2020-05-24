Use SuperStarGym
Go

Drop Table if Exists [dbo].alumnos
Go

Create Table alumnos
(
	alumno_id int Identity (1,1),
	cedula Varchar(25) unique not null,
	nombre Varchar(50) not null,
	apellido1 Varchar(25) not null,
	apellido2 Varchar(25) not null,
	edad int not null,
	direccion Varchar(200),
	Constraint PK_alumno Primary Key (alumno_id)
)
Go

/*Create Clustered Index Alumno_Nombre_Apellido1_idx
On Alumnos(Nombre, Apellido1)*/
