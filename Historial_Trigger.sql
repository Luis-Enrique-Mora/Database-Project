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
Go

---TRIGGER INSERT---
Use SuperStarGymServer
Go
create trigger TR_alumnos_insert
on Alumnos
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
on Clases
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
on Actividades
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
on Clase_De_Alumno
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
create trigger TR_alumnos_update
on Alumnos
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
on Clases
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
on Actividades
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
on Clase_De_Alumno
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
create trigger TR_alumnos_delete
on Alumnos
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
on Clases
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
on Actividades
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
on Clase_De_Alumno
After delete
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se eliminaron datos en Clase De Alumno'
from deleted
end
print 'Se eliminaron datos en Clase De Alumno exitosamente'
go