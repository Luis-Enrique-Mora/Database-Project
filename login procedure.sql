Use SuperStarGymServer
Go
--Borra y vuelve a crear el procedimiento almacenado
Drop proc if Exists login_usuario
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

