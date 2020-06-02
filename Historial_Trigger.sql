Use SuperStarGymServer
Go

Drop Table if Exists [dbo].Historial_Triggers
Go
Create table Historial_Triggers
(
	Historial_Id int Identity (1,1),
	Fecha datetime not null,
	Descripcion Varchar(50) not null,
	Constraint PK_Historial_Trigger Primary Key (Historial_Id)
)
ON Historial
Go

---TRIGGER INSERT---
Use SuperStarGymServer
Go
create trigger TR_usuarios_insert
on usuarios
After insert
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se insertaron datos en Usuarios'
from inserted
end
print 'Se insertaron datos en Usuarios exitosamente'
go

Use SuperStarGymServer
Go
create trigger TR_personas_insert
on personas
After insert
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se insertaron datos en Personas'
from inserted
end
print 'Se insertaron datos en Personas exitosamente'
go

Use SuperStarGymServer
Go
create trigger TR_salas_insert
on salas
After insert
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se insertaron datos en Salas'
from inserted
end
print 'Se insertaron datos en Salas exitosamente'
go

Use SuperStarGymServer
Go
create trigger TR_alumnos_insert
on alumnos
After insert
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se insertaron datos en Alumnos'
from inserted
end
print 'Se insertaron datos en Alumnos exitosamente'
go

Use SuperStarGymServer
Go
create trigger TR_clases_insert
on clases
After insert
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se insertaron datos en Clases'
from inserted
end
print 'Se insertaron datos en Clases exitosamente'
go

Use SuperStarGymServer
Go
create trigger TR_actividades_insert
on actividades
After insert
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se insertaron datos en Actividades'
from inserted
end
print 'Se insertaron datos en Actividades exitosamente'
go

Use SuperStarGymServer
Go
create trigger TR_clase_de_alumno_insert
on clase_de_alumnos
After insert
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se insertaron datos en Clase De Alumno'
from inserted
end
print 'Se insertaron datos en Clase De Alumno exitosamente'
go

---TRIGGER UPDATE---
Use SuperStarGymServer
Go
create trigger TR_usuarios_update
on usuarios
After update
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se actualizaron datos en Usuarios'
end
print 'Se actualizaron datos en Usuarios exitosamente'
go

Use SuperStarGymServer
Go
create trigger TR_personas_update
on personas
After update
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se actualizaron datos en Personas'
end
print 'Se actualizaron datos en Personas exitosamente'
go

Use SuperStarGymServer
Go
create trigger TR_salas_update
on salas
After update
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se actualizaron datos en Salas'
end
print 'Se actualizaron datos en Salas exitosamente'
go

Use SuperStarGymServer
Go
create trigger TR_alumnos_update
on alumnos
After update
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se actualizaron datos en Alumnos'
end
print 'Se actualizaron datos en Alumnos exitosamente'
go

Use SuperStarGymServer
Go
create trigger TR_clases_update
on clases
After update
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se actualizaron datos en Clases'
end
print 'Se actualizaron datos en Clases exitosamente'
go

Use SuperStarGymServer
Go
create trigger TR_actividades_update
on actividades
After update
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se actualizaron datos en Actividades'
end
print 'Se actualizaron datos en Actividades exitosamente'
go

Use SuperStarGymServer
Go
create trigger TR_clase_de_alumno_update
on clase_de_alumno
After update
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se actualizaron datos en Clase De Alumno'
end
print 'Se actualizaron datos en Clase De Alumno exitosamente'
go

---TRIGGER DELETE---
Use SuperStarGymServer
Go
create trigger TR_usuarios_delete
on usuarios
After delete
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se eliminaron datos en Usuarios'
from deleted
end
print 'Se eliminaron datos en Usuarios exitosamente'
go

Use SuperStarGymServer
Go
create trigger TR_personas_delete
on personas
After delete
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se eliminaron datos en Personas'
from deleted
end
print 'Se eliminaron datos en Personas exitosamente'
go

Use SuperStarGymServer
Go
create trigger TR_salas_delete
on salas
After delete
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se eliminaron datos en Salas'
from deleted
end
print 'Se eliminaron datos en Salas exitosamente'
go

Use SuperStarGymServer
Go
create trigger TR_alumnos_delete
on alumnos
After delete
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se eliminaron datos en Alumnos'
from deleted
end
print 'Se eliminaron datos en Alumnos exitosamente'
go

Use SuperStarGymServer
Go
create trigger TR_clases_delete
on clases
After delete
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se eliminaron datos en Clases'
from deleted
end
print 'Se eliminaron datos en Clases exitosamente'
go

Use SuperStarGymServer
Go
create trigger TR_actividades_delete
on actividades
After delete
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se eliminaron datos en Actividades'
from deleted
end
print 'Se eliminaron datos en Actividades exitosamente'
go

Use SuperStarGymServer
Go
create trigger TR_clase_de_alumno_delete
on clase_de_alumno
After delete
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se eliminaron datos en Clase De Alumno'
from deleted
end
print 'Se eliminaron datos en Clase De Alumno exitosamente'
go