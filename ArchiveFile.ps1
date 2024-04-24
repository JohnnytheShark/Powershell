# This function is created from reading PracticalAutomation with PowerShell
# The purpose of the function is to showcase good practices, and to archive files based on being older than a certain point. 


Function Set-ArchiveFilePath{
[CmdletBinding()]
[OutputType([string])]
param(
[Parameter(Mandatory=$true)]
[string]$ZipPath,
[Parameter(Mandatory=$true)]
[string]$ZipPrefix,
[Parameter(Mandatory=$true)]
[datetime]$Date
)
if(-not (Test_Path -Path $ZipPath){
    New-Item -Path $ZipPath -ItemType Directory | Out-Null
    Write-Verbose "Created folder '$ZipPath'"
}
$timeString = $Date.ToString('yyyyMMdd')
$ZipName = "$($ZipPrefix)$($timeString).zip"
if (Test-Path -Path $ZipPath){
    throw "The file '$ZipFile' already exists"
}
$ZipFile
}