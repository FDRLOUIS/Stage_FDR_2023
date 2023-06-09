#Récupération de la date pour créer le mdp
$jour = (get-date).day
$mois = Get-Date -Format MMMM
$annee = (get-date).Year
      $TextInfo = (Get-Culture).TextInfo
$Mois=$TextInfo.ToTitleCase($mois)

#Récupération des informations du compte à créer
"Nom : "
$Nom=Read-Host
$NomSansEspace=$Nom -replace " ",""

""
"Prénom : "



$Prenom=Read-Host


#Si la date n'a qu'un chiffre, on ajoute un 0
if ($jour -le 9){
$mdp="0"+"$jour"+"$mois"+"$annee"+"!"
}

else {
$mdp="$jour"+"$mois"+"$annee"+"!"
}

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
    "1) Chantilly"
    "2) Mecs Les Talents"
    "3) Deux Marie"
    "4) Foyer Logement"
    "5) HDJ"
    "6) Ilots Bebes"
    "7) La Guette"
    "8) Meaux"
    "9) Montreuil"
    "10) Mrg"
    "11) Nogent"
    "12) Répit"
    "13) Siege"
    "14) Uss"
    "15) Ussd"
    ""

    $Site=Read-Host


    switch ($Site)
    {
        1 {$Site="Chantilly"}
        1 {$Check=1}
        2 {$Site="Cor-sje"}
        2 {$Check=1}
        3 {$Site="Deux Marie"}
        3 {$Check=1}
        4 {$Site="Foyer Logement"}
        4 {$Check=1}
        5 {$Site="HDJ"}
        5 {$Check=1}
        6 {$Site="Ilot Bebes"}
        6 {$Check=1}
        7 {$Site="La Guette"}
        7 {$Check=1}
        8 {$Site="Meaux"}
        8 {$Check=1}
        9 {$Site="Montreuil"}
        9 {$Check=1}
        10 {$Site="MRG"}
        10 {$Check=1}
        11 {$Site="Nogent"}
        11 {$Check=1}
        12 {$Site="Répit"}
        12 {$Check=1}
        13 {$Site="Siege"}
        13 {$Check=1}
        14 {$Site="USS"}
        14 {$Check=1}
        15 {$Site="Ussd"}
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
