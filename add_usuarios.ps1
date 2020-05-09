#Eduardo Da Silva Yanes
#Script para crear usuarios

Import-Module activedirectory

#Ruta del fichero CSV con los datos de los usuarios  
$ADUsers = Import-csv C:\Users\Administrador\ScriptsPS\usuarios2.csv

foreach ($User in $ADUsers)
{

    #Guardamos los datos		
	$Username 	= $User.username
	$Password 	= $User.password
	$Firstname 	= $User.firstname
	$Lastname 	= $User.lastname
	$OU 		= $User.ou 

    #Comprobamos si existe el usuario ya
	if (Get-ADUser -F {SamAccountName -eq $Username})
	{
		 #Si existe, obviamente no lo creamos. Anunciamos la situacion
		 Write-Warning "Ya existe una cuenta con el nombre $Username"
	}
	else
	{
		
        #Creamos el usuario
		New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@asxt04.local" `
            -Name "$Firstname $Lastname" `
            -GivenName $Firstname `
            -Surname $Lastname `
            -Enabled $True `
            -DisplayName "$Lastname, $Firstname" `
            -Path $OU `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force) -ChangePasswordAtLogon $False
            
	}
}
