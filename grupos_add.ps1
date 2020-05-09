#Eduardo Da Silva Yanes
#Script para crear grupo e introducir los usuarios
Import-Module activedirectory

$ErrorActionPreference="silentlycontinue" #Silenciar los errores de la busqueda

$ADUsers = Import-csv C:\Users\Administrador\ScriptsPS\ugrupos.csv

foreach ($User in $ADUsers)
{
    $Grupo    = $User.group
    $Username = $User.username

    $Existe = Get-ADGroup -Identity $Grupo #Comprobamos si el grupo existe

    #Si no existe lo creamos
    if ($Existe -eq $NULL)
    {
        Write-Warning "El grupo $Grupo no existe. Este sera creado"
        New-ADGroup -name $Grupo -GroupScope Global -GroupCategory Security -Path "OU=Aislados,DC=asxt04,DC=local"
    }
       
    Add-ADGroupMember -Identity $Grupo -Members $Username

}