function Get-MembersOfGroup {
    param($FolderPath)
    $Identities = (get-acl ($FolderPath)).access | Sort-Object IdentityReference
    $data = @()
    ForEach ($identity in $Identities){
    try {
        $Members = Get-ADGroupMember -Identity $identity.IdentityReference.ToString().replace("NSCORP\","")
        $MembersString = $Members.name -join ", "
        $data += [pscustomobject]@{Identity=$identity.IdentityReference.ToString();Member=$MembersString}
        }
    catch{
        "Unable to Get Members for"+$identity
    }
    }
    $data | Export-CSV 'Permissions.csv'
}
Get-MembersOfGroup 'FolderPath'
