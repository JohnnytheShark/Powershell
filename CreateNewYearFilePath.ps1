$NetworkFilePath = 'FilePath'

Function CreateControlTotalsDirectory{
#This script is used to create Directories for the new year 
Param($FilePath)
$Year = Get-Date -Format yyyy
$NewYear = [int]$Year + 1
$NewDirectory = [string]$NewYear +" - SAP"
$NewFolderPath = $FilePath + "\" + $NewDirectory
If (Test-Path -Path $NewFolderPath){
echo "Path already exists"
}
else
{
MKDIR $NewFolderPath
CD $NewFolderPath
MKDIR "Subdirectory "
MKDIR "Subdirectory 2"
MKDIR "Subdirectory 3"
}

}

CreatesDirectory $NetworkFilePath
