Function PermissionsTransfer{
#FilePath is the first folder or item
#User is the given user you want to add permissions for
#FilePathTransfer is the new folder
Param($FilePath,$User,$FilePathTransfer)
$ACL = (Get-Acl -Path $FilePath).Access | Where-Object {$_.IdentityReference -eq $User}
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($ACL[0].IdentityReference,$ACL[0].FileSystemRights,$ACL[0].AccessControlType)
$newFile = Get-Acl -Path $FilePathTransfer
$newFile.SetAccessRule($AccessRule)
$newFile | Set-Acl -Path $FilePathTransfer 
(Get-Acl -path $FilePathTransfer).Access |Format-Table
}

PermissionsTransfer "FolderPath" "DOMAIN\USER" "NEWFolder/FIlePath"
