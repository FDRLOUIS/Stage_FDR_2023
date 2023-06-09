﻿
if(Test-Path -Path "C:\Temp\tmp_sym.txt"){


        $contenu=Get-content -Path "C:\Temp\tmp_sym.txt" 

        if($contenu -eq "1"){
  
    net use O: /delete
    'Installation du disque O:'
    net use O: "\\XXXX\d$\XXXX\XXXX\XXXX\Symantec Endpoint Protection version 14.3.1169.0100 - Français"


    O:
    "Lancement de l'installation de symantec"
    $id = (Get-process ./setup.exe).id
    ./setup.exe

    net use O: /delete

    'Installation terminée'

    'set-executionpolicy restricted'

    $text = '2' | Out-file -FilePath C:\Temp\tmp_sym.txt

}



elseif($contenu -eq "2"){
    echo "Installation déjà effectuer !"

}
        }



else{
                
                'La désinstallation de SEP va commencer...'
                $logiciel = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq "Symantec Endpoint Protection" }
                
                'Désinstallation en cours...'
                
                $logiciel.Uninstall()
                'Désinstallation de SEP terminé'


                $text = '1' | Out-file -FilePath C:\Temp\tmp_sym.txt

                'Redémarrage en cours'
                restart-computer


}
