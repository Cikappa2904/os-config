param([Parameter(Mandatory=$true)] $JSONFile,[Parameter(Mandatory=$true)] $AHKPath, [Switch]$NoWinget)
$username = $env:UserName

#Installare software con Winget
if ($No -eq $false)
{
    $JSONContent = Get-Content $JSONFile | ConvertFrom-Json

    For ($i=0; $i -le $JSONContent.programs.count; $i++)
    {
        write-Host "Installing " -NoNewLine
        write-Host $JSONContent.programs[$i].name "`n"
        winget install $JSONContent.programs[$i].name
        write-Host "`n"
    }
}


#Disattivare Windows Shift S (perchè poi lo metto con ShareX)
Set-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -name "DisabledHotkeys" -value "S"

#Disattivare ricerca online
#New-Item -path "HKCU:\Software\Policies\Microsoft\Windows" -Name Explorer 
#Set-ItemProperty -path HKCU:\Software\Policies\Microsoft\Windows\Explorer -name "DisableSearchBoxSuggestions" -value 1

# Attivare estensioni file (vuole un riavvio perchè boh)
Set-ItemProperty -path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -name "HideFileExt" -value "0"

# Mettere "Questo PC" come default in Esplora File
Set-ItemProperty -path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -name "LaunchTo" -value 1

# Attivare la clipboard history
Set-ItemProperty -path HKCU:\Software\Microsoft\Clipboard -name "EnableClipboardHistory" -value "1"

# Mouse snapping sui bottoni default (Ci vuole un logout e su VMware non va perchè boh)
Set-ItemProperty -path "HKCU:\Control Panel\Mouse" -name "SnapToDefaultButton" -value "1"

# #Cambiare colori
# Set-ItemProperty -path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -name "ColorPrevalence" -value "1" 
# Set-ItemProperty -path HKCU:\Software\Microsoft\Windows\DWM -name "ColorPrevalence" -value "1" 
# Set-ItemProperty -path HKCU:\Software\Microsoft\Windows\DWM -name "AccentColor" -value "ffd5eb34" 
# Set-ItemProperty -path HKCU:\Software\Microsoft\Windows\DWM -name "ColorizationColor" -value "c4680081" 
#     #Uso AccentColorizer per mostrare il colore in zone dove normalmente non verrebbe mostrato
# curl -o "C:\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\AccentColorizer-x64.exe" "https://github.com/krlvm/AccentColorizer/releases/download/v1.1.12/AccentColorizer-x64.exe" 

# Impostare tema scuro
#Set-ItemProperty -path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -name "SystemUsesLightTheme" -value "0" 
#Set-ItemProperty -path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -name "AppsUseLightTheme" -value "0" 





# #Attivare conferma eliminazione cestino
# Set-ItemProperty -path HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -name "ConfirmFileDelete" -value "1"


# #Copiare hotkey di ShareX
# curl -o "C:\Users\$username\Documents\ShareX\HotkeysConfig.json" "https://gist.githubusercontent.com/Cikappa2904/ae4b75a7ffac3c0ff0e330bd2d58fd42/raw/3268c4655a1bf6f1334bfdcd35c2751b74920680/HotkeysConfig.json"
 
# #disattivare ibernazione
# powercfg.exe /hibernate off

# #Impostare gli script di AHK all'avvio (https://stackoverflow.com/questions/9701840/how-to-create-a-shortcut-using-powershell)


# $WshShell = New-Object -comObject WScript.Shell
# $Shortcut = $WshShell.CreateShortcut("C:\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\premiere shortcut.lnk")
# $Shortcut.TargetPath = "$AHKPath\premiere shortcut.ahk"
# $Shortcut.Save()

# $WshShell = New-Object -comObject WScript.Shell
# $Shortcut = $WshShell.CreateShortcut("C:\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\windows shortcut.lnk")
# $Shortcut.TargetPath = "$AHKPath\windows shortcut.ahk"
# $Shortcut.Save()


# #Installare vari font
# $temp = $env:TEMP 

# curl -o "$temp\CascadiaCode.otf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/CascadiaCode/Regular/complete/Caskaydia%20Cove%20Regular%20Nerd%20Font%20Complete.otf
# Copy-Item "$temp\CascadiaCode.otf" "C:\Windows\Temp\Font"
# Remove-Item "$temp\CascadiaCode.otf"

# curl -o "$temp\FiraCode.ttf" https://1drv.ms/u/s!AroVog_hHY2ngqc8s_n_znpCZ-BSrA?e=E67dIy
# Copy-Item "$temp\FiraCode.ttf" "C:\Windows\Temp\Font"
# Remove-Item "$temp\FiraCode.ttf"

# curl -o "$temp\bebasneue.zip" https://dl.dafont.com/dl/?f=bebas_neue
# mkdir "$temp\BebasNeue"
# Expand-Archive -LiteralPath "$temp\bebasneue.zip" -DestinationPath "$temp\BebasNeue"
# Copy-Item "$temp\BebasNeue\BebasNeue-Regular.ttf" "C:\Windows\Temp\Font"
# Remove-Item "$temp\BebasNeue"

# curl -o "$temp\coolvetica.zip" https://dl.dafont.com/dl/?f=coolvetica
# mkdir "$temp\coolvetica"
# Expand-Archive -LiteralPath "$temp\coolvetica.zip" -DestinationPath "$temp\coolvetica"
# Copy-Item "$temp\coolvetica\coolvetica rg.otf" "C:\Windows\Temp\Font"
# Remove-Item "$temp\coolvetica"


# # Impostare tema di oh-my-posh
# mkdir "C:\Users\$username\Documents\oh-my-posh"
# curl -o "C:\Users\$username\Documents\oh-my-posh\ohmyposh-theme.json" https://gist.github.com/Cikappa2904/47d4bac30688696984f785a0ac0aed80
# oh-my-posh --init --shell pwsh --config C:\Users\$username\Documents\oh-my-posh\ohmyposh-theme.json | Invoke-Expression
