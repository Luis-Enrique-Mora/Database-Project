---Creamos la base de datos
Drop database if exists SuperStarGymServer

Use Master
GO
Create Database SuperStarGymServer
On Primary
(NAME = 'SuperStarGymServer_Data',
FILENAME='C:\SQLData\SuperStarGymServer_Data.Mdf',
SIZE = 1Gb,
MAXSIZE = 2Gb,
FILEGROWTH = 200Mb)
Log On 
(NAME = 'SuperStarGymServer_Log',
FILENAME='C:\SQLLog\SuperStarGymServer_Log.Ldf',
SIZE = 500Mb,
MAXSIZE = 1500Mb,
FILEGROWTH = 100Mb)
GO

--Creamos 5 grupos de archivos
ALTER DATABASE SuperStarGymServer
ADD FILEGROUP Actividades
GO
ALTER DATABASE SuperStarGymServer
ADD FILEGROUP Clases
GO
ALTER DATABASE SuperStarGymServer
ADD FILEGROUP Clase_de_Alumnos
GO
ALTER DATABASE SuperStarGymServer
ADD FILEGROUP Personas
GO
ALTER DATABASE SuperStarGymServer
ADD FILEGROUP Historial
GO

--Añadimos los archivos de datos
Use Master
GO
ALTER DATABASE SuperStarGymServer
ADD FILE
(NAME = 'Act01_Data',
FILENAME = 'C:\SQLData\Act01_Data.ndf',
SIZE = 500MB,
MAXSIZE = 1GB,
FILEGROWTH = 50MB)
TO FILEGROUP Actividades
GO
ALTER DATABASE SuperStarGymServer
ADD FILE
(NAME = 'Clas01_Data',
FILENAME = 'C:\SQLData\Clas01_Data.ndf',
SIZE = 500MB,
MAXSIZE = 1GB,
FILEGROWTH = 50MB)
TO FILEGROUP Clases
GO
ALTER DATABASE SuperStarGymServer
ADD FILE
(NAME = 'Clas_Alum01_Data',
FILENAME = 'C:\SQLData\Clas_Alum01_Data.ndf',
SIZE = 500MB,
MAXSIZE = 1GB,
FILEGROWTH = 50MB)
TO FILEGROUP Clase_de_Alumnos
GO
ALTER DATABASE SuperStarGymServer
ADD FILE
(NAME = 'Per01_Data',
FILENAME = 'C:\SQLData\Per01_Data.ndf',
SIZE = 500MB,
MAXSIZE = 1GB,
FILEGROWTH = 50MB)
TO FILEGROUP Personas
GO
ALTER DATABASE SuperStarGymServer
ADD FILE
(NAME = 'Histo01_Data',
FILENAME = 'C:\SQLData\Histo01_Data.ndf',
SIZE = 500MB,
MAXSIZE = 1GB,
FILEGROWTH = 50MB)
TO FILEGROUP Historial
GO

sp_helpdb SuperStarGymServer
---------------------------------------------
Use SuperStarGymServer
Go
Create table actividades
(
	actividad_cod int Identity (1,1) not null,
	nombre_actividad Varchar(50) not null,
	descripcion varchar(255),
	--Constraints
	--PK
	Constraint PK_actividad Primary Key(actividad_Cod)
)
ON Actividades
Go

---------------------------------------------
Use SuperStarGymServer
Go
Create Table personas
(
	persona_id int Identity (1,1),
	cedula Varchar(25) unique not null,
	nombre Varchar(50) not null,
	apellido1 Varchar(25) not null,
	apellido2 Varchar(25) not null,
	fecha_naci Date not null,
	direccion Varchar(200),
	--Constraints
	--PK
	Constraint PK_persona Primary Key Clustered (persona_id)
)
ON Personas
Go

-------------------------------------------------------------
Use SuperStarGymServer
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

--------------------------------------------------------------
Use SuperStarGymServer
Go
Create Table usuarios
(
	usuario_id int Identity(1,1),
	persona_fk int not null,
	contrasena_usuario varchar(50) not null,
	--Constraints
	--PK
	Constraint PK_usuario Primary Key clustered (usuario_id),
	--FK
	Constraint FK_persona_usuario Foreign Key (persona_fk) References personas (persona_id)
)
ON Personas
Go

----------------------------------------------------------------------------------
use SuperStarGymServer
Go
Create Table salas
(
	sala_id int Identity(1,1) not null,
	nombre_sala varchar(20),
	--Constraints
	--PK
	Constraint PK_sala Primary Key (sala_id)
)
ON Clase_de_Alumnos
GO

--------------------------------------------------------------------------------
Use SuperStarGymServer
Go
CREATE table clases
(
	limite_inscripcion int not null,
	total_alumnos int not null,
	precio money not null,
	sala_fk int not null,
	fecha_hora DateTime not null,
	actividad_cod_fk int not null,
	--constraints
	--PK
	--The clustered key was created to search data faster, data will be found faster when is searched by actividad_cod_fk or fecha_hora
	Constraint PK_Clase Primary Key clustered (actividad_cod_fk, fecha_hora),
	--FK
	Constraint FK_actividad_clase Foreign key (actividad_cod_fk) References actividades(actividad_cod),
	Constraint FK_sala_clase Foreign Key (sala_fk) References salas(sala_id)
)
ON Clases
Go

-------------------------------------------------------------------------------
Use SuperStarGymServer
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

-------------------------------------------------------------------------------
Use SuperStarGymServer
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
---------------------------------------------------------------------
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
on clases_de_alumnos
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
on clases_de_alumnos
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
on clases_de_alumnos
After delete
as
begin
set nocount on;
insert into Historial_Triggers(Fecha, Descripcion) select sysdatetime(),'Se eliminaron datos en Clase De Alumno'
from deleted
end
print 'Se eliminaron datos en Clase De Alumno exitosamente'
go

-------------------------------------------------------------------------------
Use SuperStarGymServer
Go
--crea el procedimiento almacenado login_usuario
Create Proc login_usuario( @cedula Varchar(25), @contrasena Varchar(50) )
--usa la variable @status para dar un resultado de 1 o 0, en caso de que la contraseña esté correcta retornará un 1 en caso contrario retornará un 0
As
	Declare @status int
	-- si los algunos de los 2 campos está vacío retornará 0 y un mensaje
	If((@cedula = '') or (@contrasena = ''))
		
		Begin
			Print 'No puede iniciar sesión si no ingresa sus credenciales'
			set @status = 0
			Select @status
			Return
		End
	Else
		--si los datos son correctos retorna un 1 de caso contrario retorna 0
		Begin
			If Exists(Select cedula, contrasena_usuario from usuarios u Inner Join personas p On p.persona_id = u.persona_fk Where cedula = @cedula and contrasena_usuario = @contrasena)	
				set @status = 1
			Else
				set @status = 0

			Select @status	
		End
		
Go
--forma correcta de ejectutar el procedimiento almacenado se le pasa como parámetros cedula y contraña en forma de varchar
--exec login_usuario '1', '1'

------------------------------------------------------- INSERTAR ------------------------------------------------------------------------
----- Insertar clases -----
Use SuperStarGymServer
GO
CREATE PROC SP_InsertClases (@limite_inscripcion int, @total_alumnos int, @precio money, @sala_fk int, @fecha_hora DateTime, @actividad_cod_fk int)
AS
if((@limite_inscripcion = '') or (@precio = '') or (@sala_fk = '') or (@fecha_hora = '') or (@actividad_cod_fk = ''))
    begin 
       print 'No se permiten campos nulos'
       return
    end
else
    -- Verifica si ya hay una clase con el mismo codigo de actividad y fecha --
	if exists (select fecha_hora from clases where CAST(fecha_hora As date) = CAST(@fecha_hora As date) and actividad_cod_fk = @actividad_cod_fk)
	   begin
	      print 'Ya hay una clase agendada con el mismo codigo de actividad y fecha, por favor verificar.'
          return
	   end
	else
	   begin
	      -- Verifica si existe la sala y actividad en sus tablas respectivas
	      if exists (select T1.actividad_cod from actividades as T1 INNER JOIN salas as T2 ON T1.actividad_cod = @actividad_cod_fk and T2.sala_id = @sala_fk)
	         begin
	            insert into clases (limite_inscripcion, total_alumnos, precio, sala_fk, fecha_hora, actividad_cod_fk)
                values (@limite_inscripcion, @total_alumnos, @precio, @sala_fk, @fecha_hora, @actividad_cod_fk)
	         end
	      else
	         begin
			    print 'No existe un codigo de actividad o sala iguales a los ingresados, por favor verificar.'
                return
             end
	   end
GO

----- Insertar clases_de_alumnos -----
Use SuperStarGymServer
GO
CREATE PROC SP_InsertClasesDeAlumnos (@alumno_fk int, @clas_fecha_fk DateTime, @activi_cod_clas_fk int)
AS
if((@alumno_fk = '') or (@clas_fecha_fk = '') or (@activi_cod_clas_fk = ''))
    begin 
       print 'No se permiten campos nulos'
       return
    end
else
    -- Verifica si ya hay una clase de alumno con el mismo codigo de actividad, fecha y alumno --
	if exists (select clase_alumno_id from clases_de_alumnos where alumno_fk = @alumno_fk and clas_fecha_fk = @clas_fecha_fk and activi_cod_clas_fk = @activi_cod_clas_fk)
	   begin
	      print 'Un Alumno no se puede incribir mas de una vez en la misma actividad y fecha, por favor verificar.'
          return
	   end
	else
	   begin
	      -- Verifica si existe la fecha, actividad y alumno en sus tablas respectivas
	      if exists (select T1.alumno_id from alumnos as T1 INNER JOIN clases as T2 ON T1.alumno_id = @alumno_fk and T2.fecha_hora = @clas_fecha_fk and T2.actividad_cod_fk = @activi_cod_clas_fk)
	         begin
			    DECLARE @limite int=0, @total int=0
                SELECT @limite =  [limite_inscripcion] FROM clases WHERE actividad_cod_fk = @activi_cod_clas_fk and fecha_hora = @clas_fecha_fk
				SELECT @total =  [total_alumnos] FROM clases WHERE actividad_cod_fk = @activi_cod_clas_fk and fecha_hora = @clas_fecha_fk
				if(@total < @limite)
				   begin
				      insert into clases_de_alumnos (alumno_fk, clas_fecha_fk, activi_cod_clas_fk)
                      values (@alumno_fk, @clas_fecha_fk, @activi_cod_clas_fk)
				      -- Para terminar aumenta el numero de total de alumnos en clases
				      update clases set total_alumnos = (total_alumnos + 1) where actividad_cod_fk = @activi_cod_clas_fk and fecha_hora = @clas_fecha_fk
				   end
				else
				   begin
				      print 'Ya no hay espacio disponible en esta clase.'
                      return
				   end
	         end
	      else
	         begin
			    print 'No existe un id de alumno, codigo de actividad o fecha iguales a los ingresados, por favor verificar.'
                return
	         end
	   end
GO

----- Insertar salas -----
Use SuperStarGymServer
GO
CREATE PROC SP_InsertSalas (@nombre_sala varchar(20))
AS
if((@nombre_sala = ''))
    begin 
       print 'No se permiten campos nulos'
       return
    end
else
	if exists (select sala_id from salas where nombre_sala = @nombre_sala)
	   begin
	      print 'Ya hay una Sala con ese nombre, por favor verificar.'
          return
	   end
	else
	   begin
	      insert into salas (nombre_sala)
          values (@nombre_sala)
       end
GO

----- Insertar actividades -----
Use SuperStarGymServer
GO
CREATE PROC SP_InsertActividades (@nombre_actividad Varchar(50), @descripcion varchar(255))
AS
if((@nombre_actividad = '') or (@descripcion = ''))
    begin 
       print 'No se permiten campos nulos'
       return
    end
else
	if exists (select actividad_cod from actividades where nombre_actividad = @nombre_actividad)
	   begin
	      print 'Ya hay una Actividad con ese nombre, por favor verificar.'
          return
	   end
	else
	   begin
	      insert into actividades(nombre_actividad, descripcion)
          values (@nombre_actividad, @descripcion)
       end
GO

----- Insertar alumno -----
Use SuperStarGymServer
GO
CREATE PROC SP_InsertAlumnos (@persona_fk int)
AS
if((@persona_fk = ''))
    begin 
       print 'No se permiten campos nulos'
       return
    end
else
    if exists (select persona_fk from alumnos where persona_fk = @persona_fk)
	   begin
	      print 'Ya hay un alumno con los datos ingresados'
          return
	   end
	else
	   begin
	      if exists (select cedula from personas where persona_id = @persona_fk)
	      begin
	         insert into alumnos (persona_fk)
             values (@persona_fk)
	      end
	   else
	      begin
	         print 'No se ha encontrado el id de la persona ingresada, por favor verificar.'
             return
          end
	   end
GO

----- Insertar persona -----
Use SuperStarGymServer
GO
CREATE PROC SP_InsertPersona (@cedula varchar(25), @nombre varchar(50), @apellido1 varchar(25), 
                            @apellido2 varchar(25), @fecha_naci Date, @direccion varchar(200))
AS
if((@cedula = '') or (@nombre = '') or (@apellido1 = '') or (@apellido2 = '') or (@fecha_naci = '') or (@direccion = ''))
    begin 
       print 'No se permiten campos nulos'
       return
    end
else
	if exists (select cedula from personas where cedula = @cedula)
	   begin
	      print 'Ya hay una persona con la Cedula: ' + convert(varchar(12), @cedula) + ', por favor verificar.'
          return
	   end
	else
	   begin
		  insert into personas (cedula, nombre, apellido1, apellido2, fecha_naci, direccion)
          values (@cedula, @nombre, @apellido1, @apellido2, @fecha_naci, @direccion)
       end
GO

----- Insertar usuarios -----
Use SuperStarGymServer
GO
CREATE PROC SP_InsertUsuarios (@persona_fk int, @contrasena_usuario varchar(50))
AS
if((@persona_fk = '') or (@contrasena_usuario = ''))
    begin 
       print 'No se permiten campos nulos'
       return
    end
else
    if exists (select persona_fk from usuarios where persona_fk = @persona_fk)
	   begin
	      print 'Ya hay un usuario con esos datos'
          return
	   end
	else
	   begin
	      if exists (select cedula from personas where persona_id = @persona_fk)
	         begin
	            insert into usuarios (persona_fk, contrasena_usuario)
                values (@persona_fk, @contrasena_usuario)
	         end
	      else
	         begin
	            print 'No se ha encontrado el id de la persona ingresada, por favor verificar.'
                return
             end
	   end
GO
--------------------------- EXEC INSERTAR ------------------------------

-- @cedula varchar(25), @nombre varchar(50), @apellido1 varchar(25), @apellido2 varchar(25), @fecha_naci Date, @direccion varchar(200)
use SuperStarGymServer
go
exec SP_InsertPersona '504200533','Keivin','Toruño','Jiménez','1998/02/11','San Martin'

-- @nombre_actividad Varchar(50), @descripcion varchar(255)
use SuperStarGymServer
go
exec SP_InsertActividades 'Natacion','Nadar'

-- @nombre_sala varchar(20)
use SuperStarGymServer
go
exec SP_InsertSalas '002'

-- @persona_fk int, @contrasena_usuario varchar(50)
use SuperStarGymServer
go
exec SP_InsertUsuarios '1', 'root'

-- @persona_fk int
use SuperStarGymServer
go
exec SP_InsertAlumnos '2'

-- @limite_inscripcion int, @total_alumnos int, @precio money, @sala_fk int, @fecha_hora DateTime, @actividad_cod_fk int
use SuperStarGymServer
go
exec SP_InsertClases '5','0','11','1','2016-10-26 10:11:00','1'

-- @alumno_fk int, @clas_fecha_fk DateTime, @activi_cod_clas_fk int
use SuperStarGymServer
go
exec SP_InsertClasesDeAlumnos '4','2016-10-23 10:10:00','1'


------------------------------------------------------- MODIFICAR ------------------------------------------------------------------------
----- Modificar clase de alumno -----
Use SuperStarGymServer
GO
CREATE PROC SP_ModificarClasesDeAlumnos (@clase_alumno_id int, @alumno_fk int, @clas_fecha_fk DateTime, @activi_cod_clas_fk int)
AS
if((@clase_alumno_id = '') or (@alumno_fk = '') or (@clas_fecha_fk = '') or (@activi_cod_clas_fk = ''))
    begin 
       print 'No se permiten campos nulos'
       return
    end
else
   --- Verifica si ya hay una clase de alumno con el mismo codigo de actividad, fecha y alumno --
	if exists (select clase_alumno_id from clases_de_alumnos where alumno_fk = @alumno_fk and clas_fecha_fk = @clas_fecha_fk and activi_cod_clas_fk = @activi_cod_clas_fk)
	   begin
	      -- Verifica si existe la fecha, actividad y alumno en sus tablas respectivas
	      if exists (select T1.alumno_id from alumnos as T1 INNER JOIN clases as T2 ON T1.alumno_id = @alumno_fk and T2.fecha_hora = @clas_fecha_fk and T2.actividad_cod_fk = @activi_cod_clas_fk)
	         begin
				UPDATE clases_de_alumnos set alumno_fk = @alumno_fk, clas_fecha_fk = @clas_fecha_fk, activi_cod_clas_fk = @activi_cod_clas_fk where clase_alumno_id = @clase_alumno_id	
	         end
	      else
	         begin
			    print 'No existe un id de alumno, codigo de actividad o fecha iguales a los ingresados, por favor verificar.'
                return
	         end
	   end
	else
	   begin
	      print 'No hay una clase agendada con el mismo codigo de actividad y fecha ingresados, por favor verificar.'
          return
	   end
GO


----- Modificar clases -----
Use SuperStarGymServer
GO
CREATE PROC SP_ModificarClases (@limite_inscripcion int, @salas_fk int, @precio money, @fecha_hora DateTime, @actividad_cod_fk int)
AS
if((@limite_inscripcion = '') or (@salas_fk = '') or (@precio = '') or (@fecha_hora = '') or (@actividad_cod_fk = ''))
    begin
       print 'No se permiten campos nulos'
       return
    end
else
   -------- Busca un datos con la fecha y codigo de actividad ingresados ----------
   if exists (select fecha_hora from clases where fecha_hora = @fecha_hora and actividad_cod_fk = @actividad_cod_fk)
	  begin
	    -------- Busca la actividad y sala en sus respectivas salas ----------
	     if exists (select T1.actividad_cod from actividades as T1 INNER JOIN salas as T2 ON T1.actividad_cod = @actividad_cod_fk and T2.sala_id = @salas_fk)
	         begin
	            UPDATE clases set limite_inscripcion = @limite_inscripcion, sala_fk = @salas_fk, precio=@precio where fecha_hora = @fecha_hora and actividad_cod_fk = @actividad_cod_fk	  
	         end
	      else
	         begin
			    print 'No existe un codigo de actividad o sala iguales a los ingresados, por favor verificar.'
                return
             end
	     end
   else
	  begin
	     print 'No se ha encontrado una clase con la fecha y codigo de actividad ingresados'
         return
	  end
GO 

----- Modificar Salas -----
Use SuperStarGymServer
GO
CREATE PROC SP_ModificarSalas (@sala_id int, @nombre_sala varchar(50))
AS
if((@sala_id = '') or (@nombre_sala = ''))
    begin 
       print 'No se permiten campos nulos'
       return
    end
else
    begin
	   if exists (select sala_id from salas where sala_id = @sala_id)
	      begin
	         UPDATE salas set nombre_sala=@nombre_sala where sala_id=@sala_id
	      end
	   else
	      begin
	         print 'No hay una sala con el ID ingresado.'
             return
          end
	end
GO

----- Modificar Actividades -----
Use SuperStarGymServer
GO
CREATE PROC SP_ModificarActividades (@actividad_cod int, @nombre_actividad varchar(50), @descripcion varchar(200))
AS
if((@actividad_cod = '') or (@nombre_actividad = '') or (@descripcion = ''))
    begin 
       print 'No se permiten campos nulos'
       return
    end
else
    begin
	   if exists (select actividad_cod from actividades where actividad_cod = @actividad_cod)
	      begin
	         UPDATE actividades set nombre_actividad = @nombre_actividad, descripcion = @descripcion where actividad_cod = @actividad_cod
	      end
	   else
	      begin
	         print 'No hay una actividad con el ID ingresado.'
             return
          end
	end
GO

----- Modificar Personas -----
Use SuperStarGymServer
GO
CREATE PROC SP_ModificarPersonas (@persona_id int, @nombre varchar(20), @apellido1 varchar(20), @apellido2 varchar(20),
                                  @fecha_naci Date, @direccion Varchar(200))
AS
if((@persona_id = '') or (@nombre = '') or (@apellido1 = '') or (@apellido2 = '') or (@fecha_naci = '') or (@direccion = ''))
    begin 
       print 'No se permiten campos nulos'
       return
    end
else
    begin
	   if exists (select persona_id from personas where persona_id = @persona_id)
	      begin
	         UPDATE personas set nombre = @nombre, apellido1 = @apellido1, apellido2 = @apellido2, 
			        fecha_naci = @fecha_naci, direccion = @direccion where persona_id = @persona_id
	      end
	   else
	      begin
	         print 'No hay una persona con el ID ingresado.'
             return
          end
	end
GO

----- Modificar Usuarios -----
Use SuperStarGymServer
GO
CREATE PROC SP_ModificarUsuarios (@usuario_id int, @contrasena_usuario varchar(50))
AS
if((@usuario_id = '') or (@contrasena_usuario = ''))
    begin 
       print 'No se permiten campos nulos'
       return
    end
else
    begin
	   if exists (select usuario_id from usuarios where usuario_id = @usuario_id)
	      begin
	         UPDATE usuarios set contrasena_usuario = @contrasena_usuario where usuario_id = @usuario_id
	      end
	   else
	      begin
	         print 'No hay un usuarios con el ID ingresado.'
             return
          end
	end
GO
--------------------------- EXEC MODIFICAR ------------------------------
-- @persona_id int, @nombre varchar(20), @apellido1 varchar(20), @apellido2 varchar(20), @fecha_naci Date, @direccion Varchar(200)
exec SP_ModificarPersonas '504200533','Keivin','Toruño','Jiménez','1998/02/11','San Martin'

-- @actividad_cod int, @nombre_actividad varchar(50), @descripcion varchar(200)
exec SP_ModificarActividades '1','Zumba','Cardio'

-- @sala_id int, @nombre_sala varchar(50)
exec SP_ModificarSalas '1','001'

-- @limite_inscripcion int, @salas_fk int, @precio money, @fecha_hora DateTime, @actividad_cod_fk int
exec SP_ModificarClases '1','11','1','2016-10-23 10:10:00','1'

-- @clase_alumno_id int, @alumno_fk int, @clas_fecha_fk DateTime, @activi_cod_clas_fk int
exec SP_ModificarClasesDeAlumnos '1','1','2016-10-23 10:10:00','1'

------------------------------------------------------- LISTADO --------------------------------------------------------------------------
----- Listar clases -----
Use SuperStarGymServer
GO
CREATE PROC SP_ListadoClases
AS
select limite_inscripcion, total_alumnos, precio, sala_fk, fecha_hora, actividad_cod_fk  from clases
GO

----- Listar clases_de_alumnos -----
Use SuperStarGymServer
GO
CREATE PROC SP_Listadoclases_de_alumnos
AS
select clase_alumno_id, alumno_fk, clas_fecha_fk, activi_cod_clas_fk  from clases_de_alumnos
GO

----- Listar Salas -----
Use SuperStarGymServer
GO
CREATE PROC SP_ListadoSalas
AS
select sala_id, nombre_sala  from salas
GO

----- Listar Actividades -----
Use SuperStarGymServer
GO
CREATE PROC SP_ListadoActividades
AS
select actividad_cod, nombre_actividad, descripcion  from actividades
GO

----- Listar alumnos -----
Use SuperStarGymServer
GO
CREATE PROC SP_Listadoalumnos
AS
select alumno_Id, persona_fk  from alumnos
GO

EXEC SP_Listadoalumnos
GO
----- Listar personas -----
Use SuperStarGymServer
GO
CREATE PROC SP_ListadoPersonas
AS
select persona_Id, cedula, nombre, apellido1, apellido2, fecha_naci, direccion  from personas
GO

----- Listar usuarios -----

Use SuperStarGymServer
GO
CREATE PROC SP_Listadousuarios
AS
select usuario_Id, persona_fk, contrasena_usuario  from usuarios
GO

------------------------------------------------------- EXECUTE LISTAR -------------------------------------------------------------------------
Execute SP_ListadoClases 

Exec SP_Listadoclases_de_alumnos

Exec SP_ListadoSalas

Exec SP_ListadoActividades

Exec SP_Listadoalumnos

Exec SP_ListadoPersonas

Exec SP_Listadousuarios
------------------------------------------------------- BUSCAR -------------------------------------------------------------------------
-- Buscar Usuarios -----
Use SuperStarGymServer
GO
Create PROC SP_BuscarUsuarios(@usuario_Id int)
AS
 IF (@usuario_Id = '')
  BEGIN
   PRINT 'NO SE PUEDEN INGRESAR VALORES NULOS'
 END
   ELSE
  BEGIN
   if exists(select usuario_id from usuarios where usuario_id = @usuario_Id)
 begin
  select contrasena_usuario, persona_fk FROM usuarios where usuario_id=@usuario_Id
 END
  else
    begin
      print 'No se Encontro el Id del Usuario'
      return 
    END
 END
GO

----- Buscar Personas -----
Use SuperStarGymServer
GO
CREATE PROC SP_BuscarPersonas(@Personas_id int)
AS
IF(@Personas_id = '')
 BEGIN
  PRINT 'NO SE PUEDEN INGRESAR VALORES NULOS'
 END
   ELSE
  BEGIN
 if exists(select persona_id from personas where persona_id = @Personas_id)
   begin
 select cedula,nombre,apellido1,apellido2,fecha_naci,direccion FROM personas where persona_id=@Personas_id
END
  ELSE
    begin
      print 'No se Encontro el Id de la Persona'
      return 
    END
 END
GO

----- Buscar Alumnos -----
Use SuperStarGymServer
GO
CREATE PROC SP_BuscarAlumnos(@Alumnos_id int)
AS
IF(@Alumnos_id = '')
   BEGIN
  PRINT 'NO SE PUEDEN INGRESAR VALORES NULOS'
   END
  ELSE
  BEGIN
 if exists(select alumno_id from alumnos where alumno_id = @Alumnos_id)
  begin
    select persona_fk FROM alumnos where alumno_id=@Alumnos_id
 END
   ELSE 
   BEGIN
      PRINT 'No se Encontro el Id del Alumno'
    RETURN
   END
 END
GO

----- Buscar Clase_de_alumnos -----
Use SuperStarGymServer
GO
Create PROC SP_BuscarClase_de_alumnos(@clase_alumno_id int)
AS
IF (@clase_alumno_id ='')
  BEGIN 
   PRINT 'NO SE PUEDEN INGRESAR VALORES NULOS'
END
  ELSE
  BEGIN
   if exists(select clase_alumno_id from clase_de_alumnos where clase_alumno_id=@clase_alumno_id)
 BEGIN
   select alumno_fk,clas_fecha_fk,activi_cod_clas_fk FROM clase_de_alumnos where clase_alumno_id=@clase_alumno_id
  END
   else
    begin
      print 'No se Encontro el Id de la Clase del Alumno'
      return 
    END
 END
GO

----- Buscar Clases -----
Use SuperStarGymServer
GO
CREATE PROC SP_BuscarClases(@fecha_hora Datetime, @actividad_cod_fk int)
AS
IF((@actividad_cod_fk ='') or (@fecha_hora =''))
    BEGIN 
    PRINT 'NO SE PUEDEN INGRESAR VALORES NULOS'
 END
     ELSE
 BEGIN
   if exists(select fecha_hora, actividad_cod_fk from clases where fecha_hora=@fecha_hora and actividad_cod_fk=@actividad_cod_fk)
  BEGIN
   select limite_inscripcion,total_alumnos,sala_fk,precio FROM clases where fecha_hora=@fecha_hora and actividad_cod_fk=@actividad_cod_fk
END
else
    begin
      print 'No se Encontro la Clase Solicitada'
      return 
    END
 END
GO

----- Buscar Actividades -----
Use SuperStarGymServer
GO
CREATE PROC SP_BuscarActividades(@Actividad_Cod int)
AS
IF(@Actividad_Cod ='')
  BEGIN
    PRINT 'NO SE PUEDEN INGRESAR VALORES NULOS'
   END
    ELSE
 BEGIN
   if exists(select actividad_Cod from actividades where actividad_Cod = @Actividad_Cod)
    begin
    select nombre_actividad,descripcion FROM actividades where actividad_Cod=@Actividad_Cod
   END
 else
    begin
      print 'No se Encontro el Id de la actividad'
      return 
    END
 END
GO

------------------------------------------------------- EXECUTE BUSCAR -------------------------------------------------------------------------
Execute SP_BuscarUsuarios ''   

Exec SP_BuscarPersonas ''

Exec SP_BuscarAlumnos ''

Exec SP_BuscarClase_de_alumnos ''

Exec SP_BuscarClases '',''

Exec SP_BuscarActividades ''
------------------------------------------------------- ELIMINAR -------------------------------------------------------------------------
----- Elimnar usuarios -----

Use SuperStarGymServer
GO
CREATE PROC SP_Eliminarusuarios(@usuario_Id int)
AS
if ((@usuario_Id = ''))
  begin
     print 'No se permiten campos nulos.'
     return
  end
else
   begin
      if exists(select usuario_Id from usuarios where usuario_id = @usuario_Id)
	     begin
		    DELETE FROM usuarios where usuario_Id = @usuario_Id
		 end
	  else
	     begin
		    print 'No se encontró el usuario a eliminar.'
            return
		 end
   end
GO

----- Elimnar personas -----
Use SuperStarGymServer
GO
CREATE PROC SP_EliminarPersonas(@persona_id int)
AS
if ((@persona_id = ''))
  begin
     print 'No se permiten campos nulos.'
     return
  end
else
   begin
      if exists(select persona_id from personas where persona_id = @persona_id)
	     begin
		    DELETE FROM personas where persona_id = @persona_id
		 end
	  else
	     begin
		    print 'No se encontró la persona a eliminar.'
            return
		 end
   end
GO

----- Elimnar Alumnos -----
Use SuperStarGymServer
GO
CREATE PROC SP_EliminarAlumnos(@alumno_id int)
AS
if ((@alumno_id = ''))
  begin
     print 'No se permiten campos nulos.'
     return
  end
else
   begin
   ------- Verifica si exciste el alumno --------
      if exists(select alumno_id from alumnos where alumno_id = @alumno_id)
	     begin
		    -- variables a utilizar
		    DECLARE @fechahora datetime = 0, @actividadcod int = 0, @totalalumnos int = 0, @filas int = 0, @iterador int = 0
			--- Se cuentan las filas donde se encuentre el alumno en clases de alumnos
			SELECT @filas =  @@ROWCOUNT FROM clases_de_alumnos WHERE alumno_fk = @alumno_id
			--- recorre la tabla clases de alumnos y resta uno en total de alumnos donde se encuentre el mismo id de alumno a eliminar
			WHILE (@iterador <= @filas)
               BEGIN
			      -- se guardan fechahora y actividad
			      SELECT @fechahora =  [clas_fecha_fk] FROM clases_de_alumnos WHERE alumno_fk = @alumno_id
		          SELECT @actividadcod =  [activi_cod_clas_fk] FROM clases_de_alumnos WHERE alumno_fk = @alumno_id
				  -- se guarda el total de alumnos actual
				  SELECT @totalalumnos =  [total_alumnos] FROM clases WHERE fecha_hora = @fechahora and actividad_cod_fk = @actividadcod
				  -- se resta uno al total de alumnos actual
				  set @totalalumnos = @totalalumnos - 1

				  -- se actualiza el nuevo numero de alumnos
				  update clases set total_alumnos = @totalalumnos where fecha_hora = @fechahora and actividad_cod_fk = @actividadcod
				  -- se incrementa el iterador

				  delete from clases_de_alumnos where alumno_fk = @alumno_id and clas_fecha_fk = @fechahora and activi_cod_clas_fk = @actividadcod
				  set @iterador = @iterador + 1
               END
			--- toma el id de persona 
			DECLARE @idpersona int = 0
			SELECT @idpersona =  [persona_fk] FROM alumnos WHERE alumno_id = @alumno_id

			--- elimina al alumno y a sus datos en persona
		    DELETE FROM alumnos where alumno_id = @alumno_id
			DELETE from personas where persona_id = @idpersona
		 end
	  else
	     begin
		    print 'No se encontró al alumno a eliminar.'
            return
		 end
   end
GO

----- Elimnar Clase_de_alumnos -----
Use SuperStarGymServer
GO
CREATE PROC SP_EliminarClase_de_alumnos(@clase_alumno_id int)
AS
if ((@clase_alumno_id = ''))
  begin
     print 'No se permiten campos nulos.'
     return
  end
else
   begin
      if exists(select clase_alumno_id from clases_de_alumnos where clase_alumno_id = @clase_alumno_id)
	     begin
		    DELETE FROM clases_de_alumnos where clase_alumno_id = @clase_alumno_id
		 end
	  else
	     begin
		    print 'No se encontró la clase de alumno a eliminar.'
            return
		 end
   end
GO

----- Elimnar Clase -----
Use SuperStarGymServer
GO
CREATE PROC SP_EliminarClase(@fecha_hora datetime, @actividad_cod_fk int)
AS
if ((@fecha_hora = '') or (@actividad_cod_fk = ''))
  begin
     print 'No se permiten campos nulos.'
     return
  end
else
   begin
      if exists(select limite_inscripcion from clases where fecha_hora = @fecha_hora and actividad_cod_fk = @actividad_cod_fk)
	     begin
		    if exists(select clase_alumno_id from clases_de_alumnos where clas_fecha_fk = @fecha_hora and activi_cod_clas_fk = @actividad_cod_fk)
			   begin
			      print 'Esta clase está siendo utilizada y no puede ser eliminada.'
                  return
			   end
			else
			   begin
			      DELETE FROM clases where fecha_hora = @fecha_hora and actividad_cod_fk = @actividad_cod_fk
			   end
		 end
	  else
	     begin
		    print 'No se encontró la clase a eliminar.'
            return
		 end
   end
GO

----- Elimnar Salas -----
Use SuperStarGymServer
GO
CREATE PROC SP_EliminarSala(@sala_id int)
AS
if ((@sala_id = ''))
  begin
     print 'No se permiten campos nulos.'
     return
  end
else
   begin
      if exists(select sala_id from salas where sala_id = @sala_id)
	     begin
		    if exists(select limite_inscripcion from clases where sala_fk = @sala_id )
			   begin
			      print 'Esta sala está siendo utilizada y no puede ser eliminada.'
                  return
			   end
			else
			   begin
			      DELETE FROM salas where sala_id = @sala_id
			   end
		 end
	  else
	     begin
		    print 'No se encontró la sala a eliminar.'
            return
		 end
   end
GO

----- Elimnar Actividades -----
Use SuperStarGymServer
GO
CREATE PROC SP_EliminarActividades(@actividad_cod int)
AS
if ((@actividad_cod = ''))
  begin
     print 'No se permiten campos nulos.'
     return
  end
else
   begin
      if exists(select actividad_cod from actividades where actividad_cod = @actividad_cod)
	     begin
		    if exists(select limite_inscripcion from clases where actividad_cod_fk = @actividad_cod )
			   begin
			      print 'Esta actividad está siendo utilizada y no puede ser eliminada.'
                  return
			   end
			else
			   begin
			      DELETE FROM actividades where actividad_cod = @actividad_cod
			   end
		 end
	  else
	     begin
		    print 'No se encontró la actividad a eliminar.'
            return
		 end
   end
GO

------------------------------------------------------- EXECUTE ELIMINAR -------------------------------------------------------------------------
Execute SP_Eliminarusuarios ''   

Exec SP_EliminarPersonas ''

Exec SP_EliminarAlumnos ''

Exec SP_EliminarClase_de_alumnos ''

Exec SP_EliminarClase '',''

Exec SP_EliminarActividades ''

----------------------- BACKUP ----------------
Use SuperStarGymServer
Go
create proc full_backup
As
	Begin
		Backup database SuperStarGymServer
		to disk = 'C:\DBBackUp\Backup_super_star_gym.bak'
		With name ='Gym Full backup',
		Description = 'full back up de la base de datos SuperStarGymServer'
	End
Go



Use SuperStarGymServer
Go
create proc differential_backup
As
	Begin
		Backup database SuperStarGymServer
		to disk = 'C:\DBBackUp\Backup_super_star_gym.bak'
		With name ='Gym differential backup',
		Description = 'differential back up de la base de datos SuperStarGymServer',
		Differential
	End
Go

Use master
Go
create proc restore_database
As
	Begin
		Restore database SuperStarGymServer
		From disk = 'C:\DBBackUp\Backup_super_star_gym.bak'
		With file = 1, NoRecovery

		Restore database SuperStarGymServer
		From disk = 'C:\DBBackUp\Backup_super_star_gym.bak'
		With file = 2, Recovery
	End
Go

EXEC full_backup

Exec differential_backup
