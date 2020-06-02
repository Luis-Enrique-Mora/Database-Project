---Creamos la base de datos

Use Master
GO
Create Database SuperStarGymServer
On Primary
(NAME = 'SuperStarGymServer_Data',
FILENAME='C:\SQLData\SuperStarGymServer_Data.Mdf',
SIZE = 500mb,
MAXSIZE = 1Gb,
FILEGROWTH = 100Mb)
Log On 
(NAME = 'SuperStarGymServer_Log',
FILENAME='C:\SQLLog\SuperStarGymServer_Log.Ldf',
SIZE = 100Mb,
MAXSIZE = 500Mb,
FILEGROWTH = 20Mb)
GO

--Creamos los grupos de archivos
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
ADD FILEGROUP Alumnos
GO
ALTER DATABASE SuperStarGymServer
ADD FILEGROUP Personas
GO
ALTER DATABASE SuperStarGymServer
ADD FILEGROUP Usuarios
GO
ALTER DATABASE SuperStarGymServer
ADD FILEGROUP Salas
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
(NAME = 'Alum01_Data',
FILENAME = 'C:\SQLData\Alum01_Data.ndf',
SIZE = 500MB,
MAXSIZE = 1GB,
FILEGROWTH = 50MB)
TO FILEGROUP Alumnos
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
(NAME = 'Usua01_Data',
FILENAME = 'C:\SQLData\Usua01_Data.ndf',
SIZE = 500MB,
MAXSIZE = 1GB,
FILEGROWTH = 50MB)
TO FILEGROUP Usuarios
GO
ALTER DATABASE SuperStarGymServer
ADD FILE
(NAME = 'Sala01_Data',
FILENAME = 'C:\SQLData\Sala01_Data.ndf',
SIZE = 500MB,
MAXSIZE = 1GB,
FILEGROWTH = 50MB)
TO FILEGROUP Salas
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