#Récupération des informations du compte à créer
"Nom : "
$Nom=Read-Host
$NomSansEspace=$Nom -replace " ",""

""
"Prénom : "



$Prenom=Read-Host




$mdp="bleu"

$mdpSecure= ConvertTo-SecureString $mdp -AsPlainText -Force
#credential = New-Object System.Management.Automation.PSCredential ('$Initial$Initial2$NomSansEspace', $mdpSecure)


$Initial= @($Prenom -split '')[1]
$Initial2="" #Permet d'éviter d'avoir les initiales de la personne d'avant
if ($Prenom -match " ") {
    $index = $Prenom.IndexOf(" ") + 1
    $Initial2 = $Prenom[$index]
    }


$Check=0

While ($Check -ne 1){
    "Saissisez le numéro du site où l'on doit lier le compte :"
    ""
    "1) XXXX"
    "2)  XXXX"
    "3)  XXXX"
    "4)  XXXX"
    "5)  XXXX"
    "6)  XXXX"
    "7)  XXXX"
    "8)  XXXX"
    "9)  XXXX"
    "10)  XXXX"
    "11)  XXXX"
    "12)  XXXX"
    "13)  XXXX"
    "14)  XXXX"
    "15)  XXXX"
    ""

    $Site=Read-Host


    switch ($Site)
    {
        1 {$Site=" XXXX"}
        1 {$Check=1}
        2 {$Site=" XXXX"}
        2 {$Check=1}
        3 {$Site=" XXXX"}
        3 {$Check=1}
        4 {$Site=" XXXX"}
        4 {$Check=1}
        5 {$Site="HDJ"}
        5 {$Check=1}
        6 {$Site=" XXXX"}
        6 {$Check=1}
        7 {$Site=" XXXX"}
        7 {$Check=1}
        8 {$Site=" XXXX"}
        8 {$Check=1}
        9 {$Site=" XXXX"}
        9 {$Check=1}
        10 {$Site=" XXXX"}
        10 {$Check=1}
        11 {$Site=" XXXX"}
        11 {$Check=1}
        12 {$Site=" XXXX"}
        12 {$Check=1}
        13 {$Site=" XXXX"}
        13 {$Check=1}
        14 {$Site=" XXXX"}
        14 {$Check=1}
        15 {$Site=" XXXX"}
        15 {$Check=1}
    
    }
    
}

    ""
    "Site sélectionné : $site"
    ""

#Création du compte
New-RemoteMailbox -Name "$Nom $Prenom" -SamAccountName $Initial$Initial2$NomSansEspace -LastName "$Nom" -FirstName "$Prenom" -alias  $Initial$Initial2"."$NomSansEspace -RemoteRoutingAddress $Initial$Initial2"."$NomSansEspace@fdrot.onmicrosoft.com -OnPremisesOrganizationalUnit "OU=Utilisateurs,OU=$Site,OU=Site_Global,DC=rothschild,DC=org" -UserPrincipalName $Initial$Initial2"."$NomSansEspace@rothschild.org -Password $mdpSecure -ResetPasswordOnNextLogon $true

#Création du fichier Log
$Log = "Nom : $Nom, Prénom : $Prenom, Site: $Site, Identifiant : $Initial$Initial2$NomSansEspace, Mail : $Initial$Initial2.$NomSansEspace@fdrot.onmicrosoft.com" | Out-File  -FilePath C:\PS_Script\LOG_User\"log_$jour$mois$annee".txt -Append

#Suppression des log vieux de plus de 30 jours
Get-ChildItem –Path "C:\PS_Script\LOG_User\" -Recurse -Filter "log_*.txt" | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-30))} | Remove-Item
