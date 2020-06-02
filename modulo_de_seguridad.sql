
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

Use SuperStarGymServer
Go
create proc log_backup
As
	Begin
		Backup Log SuperStarGymServer
		to disk = 'C:\DBBackUp\Backup_super_star_gym.bak'
		With 
		name ='Gym log backup',
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