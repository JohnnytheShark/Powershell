function AssetRetirementsFileCheck {
$Folder =  'Directory'
$FileCount = (Get-ChildItem $Folder | Measure-Object).Count
If ($FileCount -ge 1){
    $WriteTimes = Get-ChildItem $Folder | Select-Object LastWriteTime -First 1
    $FileName = Get-ChildItem $Folder | Select-Object Name -First 1
    Write-Host ($WriteTimes)[0]

    $ol = New-Object -ComObject Outlook.Application
    $mail = $ol.CreateItem(0)
    $mail.Subject = "An Attachment is ready"
    $mail.HTMLBody = "<html><head></head><body>Attached is a file for your review</body></html>" 
    $File = $Folder+"\"+$FileName.psobject.properties.value
    Write-Host $File
    $mail.Attachments.Add($File)
    $mail.save()

    $inspector = $mail.GetInspector
    $inspector.Display()


    return $FileName
    
}
else{ return "No Files found in this Directory"} 
}
AssetRetirementsFileCheck 
