$regPath = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
function UninstallApplication {
param($FolderPath, $App, $version)
$currentversion = Get-ItemProperty $regPath | Where-Object DisplayName -like $App | Select-Object DisplayVersion -First 1
$currentversion = $currentversion.psobject.properties | Select-Object -Property value
$currentversion = $currentversion[0].Value.Substring(0,4)
if ($currentversion -eq $version){
Write-Output "Expected Version is already installed and does not need to be uninstalled."
}
else{
Write-Output "Uninstalling version to make room for version to be installed"
$uninstall = Get-ItemProperty $regPath | Where-Object DisplayName -like $App | Select-Object -ExpandProperty UninstallString -First 1 -ErrorAction SilentlyContinue
foreach ($program in $uninstall){
    $splitter = $program -split " "
    if ($splitter.length -gt 1) {
        if($splitter -eq "MsiExec.exe"){
            #$arguments = (($splitter -split ' ')[1] -replace '/I','/X') + ' /q'
            #Start-Process $splitter[0] -ArgumentList $arguments -Wait
            #shutdown /r
        }else{
            $program
            cmd /c $program /silent
        }
    }

}
}
}

UninstallApplication $regPath "*SAP*" 7.40
