param([Parameter(Mandatory=$true)] $JSONFile,[Parameter()] $AHKPath, [Switch]$NoWinget)
$username = $env:UserName

#Installare software con Winget
if ($NoWinget -eq $false)
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
New-Item -path "HKCU:\Software\Policies\Microsoft\Windows" -Name Explorer 
Set-ItemProperty -path HKCU:\Software\Policies\Microsoft\Windows\Explorer -name "DisableSearchBoxSuggestions" -value 1

# Attivare estensioni file (vuole un riavvio perchè boh)
Set-ItemProperty -path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -name "HideFileExt" -value "0"

# Mettere "Questo PC" come default in Esplora File
Set-ItemProperty -path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -name "LaunchTo" -value 1

# Attivare la clipboard history
Set-ItemProperty -path HKCU:\Software\Microsoft\Clipboard -name "EnableClipboardHistory" -value "1"

# Mouse snapping sui bottoni default (Ci vuole un logout e su VMware non va perchè boh)
Set-ItemProperty -path "HKCU:\Control Panel\Mouse" -name "SnapToDefaultButton" -value "1"

# Attivare conferma eliminazione cestino
New-Item -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies" -Name Explorer 
Set-ItemProperty -path HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -name "ConfirmFileDelete" -value 1

#disattivare ibernazione
powercfg.exe /hibernate off

#Disattivare Precisione puntatore
Set-ItemProperty -path "HKCU:\Control Panel\Mouse" -name "MouseSpeed" -value 0
Set-ItemProperty -path "HKCU:\Control Panel\Mouse" -name "MouseThreshold1" -value 0
Set-ItemProperty -path "HKCU:\Control Panel\Mouse" -name "MouseThreshold2" -value 0

$temp = $env:TEMP 
#Cambiare colori 
curl.exe -o $temp "https://github.com/Cikappa2904/os-config/blob/main/windows/configurating/rosso.deskthemepack"
"$temp\rosso.deskthemepack"
 
#Uso AccentColorizer per mostrare il colore in zone dove normalmente non verrebbe mostrato
curl.exe -o "C:\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\AccentColorizer-x64.exe" "https://github.com/krlvm/AccentColorizer/releases/download/v1.1.12/AccentColorizer-x64.exe" 

# Impostare tema scuro
Set-ItemProperty -path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -name "SystemUsesLightTheme" -value "0" 
Set-ItemProperty -path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -name "AppsUseLightTheme" -value "0" 

#Copiare hotkey di ShareX
Remove-Item "C:\Users\$username\Documents\ShareX" -Recurse
curl.exe -o $temp\ShareX.zip "https://raw.githubusercontent.com/Cikappa2904/os-config/main/windows/configurating/ShareX.zip?token=GHSAT0AAAAAABXQIGU2YMZQQBL6RKODTBUIYYUZ5KQ"
Expand-Archive $temp\ShareX.zip -DestinationPath "C:\Users\$username\Documents"
Remove-Item $temp\ShareX.zip

# #Impostare gli script di AHK all'avvio (https://stackoverflow.com/questions/9701840/how-to-create-a-shortcut-using-powershell)

if ($AHKPath)
{
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("C:\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\premiere shortcut.lnk")
    $Shortcut.TargetPath = "$AHKPath\premiere shortcut.ahk"
    $Shortcut.Save()
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("C:\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\windows shortcut.lnk")
    $Shortcut.TargetPath = "$AHKPath\windows shortcut.ahk"
    $Shortcut.Save()

}


#Installare vari font


curl -o "$temp\CaskaydiaCove.otf" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/CascadiaCode/Regular/complete/Caskaydia%20Cove%20Nerd%20Font%20Complete%20Windows%20Compatible%20Regular.otf"
Copy-Item "$temp\CaskaydiaCove.otf" "C:\Windows\Temp\Font"
Remove-Item "$temp\CaskaydiaCove.otf"
curl -o "$temp\FiraCode.ttf" "https://1drv.ms/u/s!AroVog_hHY2ngqc8s_n_znpCZ-BSrA?e=E67dIy"
Copy-Item "$temp\FiraCode.ttf" "C:\Windows\Temp\Font"
Remove-Item "$temp\FiraCode.ttf"
curl -o "$temp\bebasneue.zip" "https://dl.dafont.com/dl/?f=bebas_neue"
mkdir "$temp\BebasNeue"
Expand-Archive -LiteralPath "$temp\bebasneue.zip" -DestinationPath "$temp\BebasNeue"
Copy-Item "$temp\BebasNeue\BebasNeue-Regular.ttf" "C:\Windows\Temp\Font"
Remove-Item "$temp\BebasNeue"
curl -o "$temp\coolvetica.zip" "https://dl.dafont.com/dl/?f=coolvetica"
mkdir "$temp\coolvetica"
Expand-Archive -LiteralPath "$temp\coolvetica.zip" -DestinationPath "$temp\coolvetica"
Copy-Item "$temp\coolvetica\coolvetica rg.otf" "C:\Windows\Temp\Font"
Remove-Item "$temp\coolvetica"


# Impostare tema di oh-my-posh
# mkdir "C:\Users\$username\Documents\oh-my-posh"
# curl -o "C:\Users\$username\Documents\oh-my-posh\ohmyposh-theme.json" https://gist.github.com/Cikappa2904/47d4bac30688696984f785a0ac0aed80"
# oh-my-posh --init --shell pwsh --config C:\Users\$username\Documents\oh-my-posh\ohmyposh-theme.json | Invoke-Expression
