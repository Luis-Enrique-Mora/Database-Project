Use SuperStarGymServer
Go

Drop Table if Exists alumnos
Go

Create Table alumnos
(
	alumno_id int Identity(1,1) not null,
	persona_fk int not null,
	--Constraints
	--PK
	Constraint PK_alumno Primary Key (alumno_id),
	--FK
	Constraint FK_persona_alumno Foreign Key (persona_fk) references personas (persona_id)
)
ON Personas
Go

