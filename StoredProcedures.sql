--Procedimientos Almacenados


-- Insertar en clases --
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
    select limite_inscripcion, total_alumnos, precio, sala_fk, fecha_hora, actividad_cod_fk from clases where fecha_hora = @fecha_hora and actividad_cod_fk = @actividad_cod_fk
	if (@@ROWCOUNT = 0)
	   begin
	      insert into clases (limite_inscripcion, total_alumnos, precio, sala_fk, fecha_hora, actividad_cod_fk)
          values (@limite_inscripcion, @total_alumnos, @precio, @sala_fk, @fecha_hora, @actividad_cod_fk)
	   end
	else
	   begin
          print 'Ya hay una clase agendada con el mismo codigo de actividad y fecha, por favor verificar.'
          return
       end
GO

-- Insertar en clases_de_alumnos (FALTA)
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
-- FALTA --------------------
    select alumno_id, persona_fk from alumnos where alumno_id = @alumno_fk
	if (@@ROWCOUNT = 0)
	   begin
	      print 'El id de alumno ingresado es inexistente, por favor verificar.'
          return
	   end
	else
	   select actividad_cod, nombre_actividad, descripcion from actividades where actividad_cod = @activi_cod_clas_fk
	   if (@@ROWCOUNT = 0)
	      begin
		     print 'El codigo de actividad ingresado es inexistente, por favor verificar.'
             return
		  end
	   else
	     begin
		    insert into clases_de_alumnos (alumno_fk, clas_fecha_fk, activi_cod_clas_fk)
            values (@alumno_fk, @clas_fecha_fk, @activi_cod_clas_fk)
		 end
GO

-- Insertar en persona
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
    select cedula, nombre, apellido1, apellido2, fecha_naci, direccion from personas where cedula = @cedula
	if (@@ROWCOUNT = 0)
	   begin
	      insert into personas (cedula, nombre, apellido1, apellido2, fecha_naci, direccion)
          values (@cedula, @nombre, @apellido1, @apellido2, @fecha_naci, @direccion)
	   end
	else
	   begin
		  print 'Ya hay una persona con la Cedula: ' + convert(varchar(12), @cedula) + ', por favor verificar.'
          return
       end
GO