# Load necessary assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Folder Picker and Script Runner'
$form.Size = New-Object System.Drawing.Size(400, 200)
$form.StartPosition = 'CenterScreen'

# Function to open the folder dialog and get the selected folder
function OpenFolderDialog {
    $FolderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $FolderBrowserDialog.Description = "Select a folder"
    $FolderBrowserDialog.RootFolder = [Environment+SpecialFolder]::Desktop
    $FolderBrowserDialog.ShowDialog() | Out-Null
    return $FolderBrowserDialog.SelectedPath # Returns the folder path
}

# Function to get and export the permissions for the selected folder to a dynamically named CSV file
function GetAndExportPermissions {
    $selectedFolder = OpenFolderDialog
    if ($selectedFolder) {
        # Get the permissions for the selected folder
        $acl = Get-Acl -Path $selectedFolder
        $permissions = $acl.Access | ForEach-Object {
            [PSCustomObject]@{
                'Identity' = $_.IdentityReference
                'Permissions' = $_.FileSystemRights
                'Inherited' = $_.IsInherited
            }
        }
        
        # Dynamically generate the CSV file path based on the selected folder's name
        $folderName = [System.IO.Path]::GetFileName($selectedFolder)
        $csvFilePath = "C:\temp\$folderName-permissions.csv"
        
        # Export the permissions to the dynamically named CSV file
        $permissions | Export-Csv -Path $csvFilePath -NoTypeInformation
        
        # Optionally, display a message to the user
        [System.Windows.Forms.MessageBox]::Show("Permissions exported to $csvFilePath", "Export Complete", 0, [System.Windows.Forms.MessageBoxIcon]::Information)
    }
}

# Button to get and export the permissions
$getPermissionsButton = New-Object System.Windows.Forms.Button
$getPermissionsButton.Location = New-Object System.Drawing.Point(10, 50)
$getPermissionsButton.Size = New-Object System.Drawing.Size(100, 30)
$getPermissionsButton.Text = 'Get Permissions'
$getPermissionsButton.Add_Click({ GetAndExportPermissions })
$form.Controls.Add($getPermissionsButton)

# Show the form
$form.ShowDialog()
