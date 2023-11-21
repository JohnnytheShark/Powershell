$sapGUIPath = "C:\Program Files (x86)\SAP\FrontEnd\SAPgui\saplogon.exe"
function InstallApplication {
param($FolderPath)
if (Test-Path $FolderPath) {
       Write-Output "SAP GUI is installed."
       $desktopPath = "$env:USERPROFILE\Desktop"
       $msiPath = Join-Path $desktopPath -ChildPath "SAP\SAPGUI7.4.msi"
       $msiPath
   } else {
       Write-Output "SAP GUI is not installed."
       $desktopPath = "$env:USERPROFILE\Desktop"
       $msiPath = Join-Path $desktopPath -ChildPath "SAP\SAPGUI7.4.msi"
        if (Test-Path $msiPath) {
            Write-Output "The file exists."
            $logFile = Join-Path $desktopPath -ChildPath "SAP\InstallationLog.txt"
            $MSIArguments = @(
            "/i"
            ('"{0}"' -f $msiPath)
            "/qn"
            "/L*v"
            $logFile
            )
            Start-Process "msiexec.exe" -ArgumentList $MSIArguments -Wait -NoNewWindow
        } else {
            Write-Output "The file does not exist."

        }
   }

}

InstallApplication $sapGUIPath
