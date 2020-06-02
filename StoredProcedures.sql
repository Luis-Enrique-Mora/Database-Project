--Procedimientos Almacenados


------------------------------------------------------- INSERTAR ------------------------------------------------------------------------

----- Insertar clases -----
Use SuperStarGymServer
GO
CREATE PROC SP_InsertClases (@limite_inscripcion int, @total_alumnos int, @precio Decimal, @sala_fk int, @fecha_hora DateTime, @actividad_cod_fk int)
AS
if((@limite_inscripcion = '') or (@total_alumnos = '') or (@precio = '') or (@sala_fk = '') or (@fecha_hora = '') or (@actividad_cod_fk = ''))
    begin 
       print 'No se permiten campos nulos'
       return
    end
else
-- Verifica si ya hay una clase con el mismo codigo de actividad y fecha --
	if exists (select fecha_hora from clases where fecha_hora = @fecha_hora and actividad_cod_fk = @actividad_cod_fk)
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
	if exists (select clase_alumno_id from clase_de_alumnos where alumno_fk = @alumno_fk and fecha_hora = @fecha_hora and actividad_cod_fk = @actividad_cod_fk)
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
	      insert into alumnos (persona_fk)
          values (@persona_fk)
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
	if exists (select cedula from personas where persona_fk = @persona_fk)
	   begin
	      insert into alumnos (persona_fk)
          values (@persona_fk)
	   end
	else
	   begin
	      print 'No se ha encontrado el id de la persona ingresada, por favor verificar.'
          return
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
	if exists (select cedula from personas where persona_fk = @persona_fk)
	   begin
	      insert into usuarios (persona_fk, contrasena_usuario)
          values (@persona_fk, @contrasena_usuario)
	   end
	else
	   begin
	      print 'No se ha encontrado el id de la persona ingresada, por favor verificar.'
          return
       end
GO

------------------------------------------------------- MODIFICAR ------------------------------------------------------------------------
----- Modificar clases -----
Use SuperStarGymServer
GO
CREATE PROC SP_ModificarClases (@precio Decimal, @fecha_hora DateTime,@actividad_cod_fk int)
AS
UPDATE clases set precio=@precio where fecha_hora=@fecha_hora and actividad_cod_fk=@actividad_cod_fk
GO 

EXEC SP_ModificarClases '2000','22/02/2020','2'
GO

----- Modificar Salas -----
Use SuperStarGymServer
GO
CREATE PROC SP_ModificarSalas (@sala_id int,@nombre_sala varchar(50))
AS
UPDATE salas set nombre_sala=@nombre_sala where sala_id=@sala_id
GO 

EXEC SP_ModificarSalas '',''
GO
----- Modificar Actividades -----
Use SuperStarGymServer
GO
CREATE PROC SP_ModificarActivades (@actividad_cod int,@nombre_actividad varchar(50),@descripcion varchar(200))
AS
UPDATE actividades set nombre_actividad=@nombre_actividad, descripcion=@descripcion where actividad_cod=@actividad_cod
GO 

EXEC SP_ModificarActivades 'Zumba','Cardio','1'
GO

----- Modificar Personas -----
Use SuperStarGymServer
GO
CREATE PROC SP_ModificarPersonas (@persona_id int,@nombre varchar(20),@apellido1 varchar(20),@apellido2 varchar(20),@fecha_naci Date,@direccion Varchar(200))
AS
UPDATE personas set nombre=@nombre,apellido1=@apellido1,apellido2=@apellido2,fecha_naci=@fecha_naci,direccion=@direccion where persona_id=@persona_id
GO 

EXEC SP_ModificarPersonas 'Juan','Rodriguez','Ramirez','1999/02/21','San jose','1'
GO

----- Modificar Usuarios -----
Use SuperStarGymServer
GO
CREATE PROC SP_ModificarUsuarios (@usuario_id int,@contrasena_usuario varchar(50))
AS
UPDATE usuarios set contrasena_usuario=@contrasena_usuario where usuario_id=@usuario_id
GO 

EXEC SP_ModificarUsuarios 'sakjhdadhasoud','1'
GO
------------------------------------------------------- LISTADO --------------------------------------------------------------------------
----- Listar clases -----
Use SuperStarGymServer
GO
CREATE PROC SP_ListadoClases
AS
select limite_inscripcion, total_alumnos, precio, sala_fk, fecha_hora, actividad_cod_fk  from clases
GO

EXEC SP_ListadoClases
GO

----- Listar clases_de_alumnos -----
Use SuperStarGymServer
GO
CREATE PROC SP_Listadoclases_de_alumnos
AS
select clase_alumno_id, alumno_fk, clas_fecha_fk, activi_cod_clas_fk  from clases_de_alumnos
GO

EXEC SP_Listadoclases_de_alumnos
GO

----- Listar Salas -----
Use SuperStarGymServer
GO
CREATE PROC SP_ListadoSalas
AS
select sala_id, nombre_sala   from salas
GO

EXEC SP_ListadoSalas
GO

----- Listar Actividades -----
Use SuperStarGymServer
GO
CREATE PROC SP_ListadoActividades
AS
select actividad_cod, nombre_actividad, descripcion  from actividades
GO

EXEC SP_ListadoActividades
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

EXEC SP_ListadoPersonas
GO
----- Listar usuarios -----

Use SuperStarGymServer
GO
CREATE PROC SP_Listadousuarios
AS
select usuario_Id, persona_fk, contrasena_usuario  from usuarios
GO

EXEC SP_Listadousuarios
GO
------------------------------------------------------- ELIMINAR -------------------------------------------------------------------------
----- Elimnar usuarios -----

Use SuperStarGymServer
GO
CREATE PROC SP_Eliminarusuarios(@usuario_Id int)
AS
DELETE FROM usuarios where usuario_Id=@usuario_Id
GO

EXEC SP_Eliminarusuarios '1'
GO
----- Elimnar personas -----
Use SuperStarGymServer
GO
CREATE PROC SP_EliminarPersonas(@persona_Id int)
AS
DELETE FROM personas where persona_Id=@persona_Id
GO

EXEC SP_EliminarPersonas '1'
GO
----- Elimnar Alumnos -----
Use SuperStarGymServer
GO
CREATE PROC SP_EliminarAlumnos(@alumno_Id int)
AS
DELETE FROM alumnos where alumno_Id=@alumno_Id
GO

EXEC SP_EliminarAlumnos '1'
GO
----- Elimnar Clase_de_alumnos -----
Use SuperStarGymServer
GO
CREATE PROC SP_EliminarClase_de_alumnos(@clase_alumno_id int)
AS
DELETE FROM clase_de_alumnos where clase_alumno_id=@clase_alumno_id
GO

EXEC SP_EliminarAlumnos '1'
GO
----- Elimnar Salas -----
Use SuperStarGymServer
GO
CREATE PROC SP_EliminarSala(@sala_id int)
AS
DELETE FROM salas where sala_id=@sala_id
GO

EXEC SP_EliminarSala ''
GO

----- Elimnar Actividades -----
Use SuperStarGymServer
GO
CREATE PROC SP_EliminarActividades(@actividad_cod int)
AS
DELETE FROM actividades where actividad_cod=@actividad_cod
GO

EXEC SP_EliminarActividades ''
GO


------------------------------------------------------- BUSCAR ID ------------------------------------------------------------------------
----- Buscar Usuarios -----

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
 
EXEC SP_BuscarUsuarios '1'
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

EXEC SP_BuscarPersonas ''
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

EXEC SP_BuscarAlumnos ''
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

EXEC SP_BuscarClase_de_alumnos '1'
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
   select limite_inscripcion,total_alumnos,salas_fk,precio FROM clases where fecha_hora=@fecha_hora and actividad_cod_fk=@actividad_cod_fk
END
else
	begin
	  print 'No se Encontro la Clase Solicitada'
	  return 
    END
 END
GO

EXEC SP_BuscarClases '',''
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

EXEC SP_BuscarActividades ''
GO

----- Buscar Salas -----

Use SuperStarGymServer
GO
Create PROC SP_BuscarSalas(@sala_id int)
AS
IF (@sala_id = '')
  BEGIN
   PRINT 'NO SE PUEDEN INGRESAR VALORES NULOS'
  END
ELSE
 Begin
   if exists(select sala_id from salas where sala_id = @sala_id)
   begin
	select nombre_sala FROM salas where sala_id=@sala_id
   END
	else
	begin
	  print 'No se Encontro el Id de la Sala'
	  return 
    END
 END
GO

EXEC SP_BuscarSalas ''
GO
