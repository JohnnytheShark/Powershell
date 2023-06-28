<# 
Written By: Jonathan Orellana
Last Updated: 6/28/2023
Purpose: The purpose behind the script is to return members of an AD Group, if AD Group is not found it will print out stating it was unable to get members.
#>
function Get-MembersOfGroup {
# Get's the identities for a folder (basically the groups)
# Creates an array to host the information
# For loop through the indentities to find the members of each group
# Transforms the object into a joined list
# Adds it to array
# Exports as a CSV
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
