 
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Ozq%dgLRosQOmZ!nqQ0hzAHcqDe4FNumXMAzzv3mr@n0SISZk0';  
Go

Use Master  
Go  
create Certificate BackupEncriptCert  
   With Subject = 'Backup Encryption Certificate';  
Go

Use SuperStarGymServer
Go
create proc full_backup
As
	Begin
		Backup database SuperStarGymServer
		to disk = 'C:\DBBackUp\Backup_super_star_gym.bak'
		With name ='Gym Full backup',
		Compression,
		Encryption (Algorithm = AES_256, Server CERTIFICATE = BackupEncriptCert),
		STATS = 10,
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
		Compression,
		Encryption (Algorithm = AES_256, Server CERTIFICATE = BackupEncriptCert),
		STATS = 10,
		Description = 'differential back up de la base de datos SuperStarGymServer',
		Differential
	End
Go

Use SuperStarGymServer
Go
create proc log_backup
As
	Begin
		Backup Log SuperStarGymServer
		to disk = 'C:\DBBackUp\Backup_super_star_gym.bak'
		With 
		name ='Gym log backup',
		Compression,
		Encryption (Algorithm = AES_256, Server CERTIFICATE = BackupEncriptCert),
		STATS = 10,
		Description = 'log back up de la base de datos SuperStarGymServer'
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
		With file = 2, NoRecovery

		Restore database SuperStarGymServer
		From disk = 'C:\DBBackUp\Backup_super_star_gym.bak'
		With file = 3, Recovery
	End
Go