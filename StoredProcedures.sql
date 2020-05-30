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
	            insert into clases_de_alumnos (alumno_fk, clas_fecha_fk, activi_cod_clas_fk)
                values (@alumno_fk, @clas_fecha_fk, @activi_cod_clas_fk)
				-- Para terminar aumenta el numero de total de alumnos en clases
				update clases set total_alumnos = (total_alumnos + 1) where actividad_cod_fk = @activi_cod_clas_fk and fecha_hora = @clas_fecha_fk
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
