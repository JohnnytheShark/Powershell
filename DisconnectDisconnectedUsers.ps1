<# 
Written By: Jonathan Orellana orellanajonathan7@gmail.com
Last Updated: 10/25/2022
Purpose: The purpose behind the script is to check users logged on the production server to see if any users have a status of "Disconnected"
it will then logoff the users that are in that status. 
Schedule: Daily 8:00am on task scheduler. 
#>



# Function used to logoff disconnected users
Function Disconnect-DisconnectedUsers {
# The function first queries the users on the server then trims the lines and selects everything but the headers
# From there we replace all lines that are null with a , to ensure that are delimiters worked correctly.
# Then we turned it into a comma delimited once nulls were taken care of. 
# Then we convert from a string to an object giving it headers Username, Sessionname, ID, State, IdleTime, and LogonTime
# We only select the necessary data, ID, UserName, and State
# We select the users that have a state of Disc or something to the like of disconnected
# We then write their names to host line replacing ">" that was left earlier and logoff the users that are in the status of disconnected.
quser|Select-Object -skip 1 `
| ForEach-Object {$_.Trim() -replace '\s{20,}',',,'} `
| ForEach-Object {$_ -replace "\s{2,}", ","}`
| ConvertFrom-String -Delimiter "," -PropertyNames UserName, Sessionname,ID,State,IdleTime,LogonTime `
| Select-Object ID,State,UserName `
| Where-Object {$_.State -like '*Disc*'} `
| ForEach-Object {
$User = $_.UserName.Replace(">","")
Write-Host $User
logoff $_.ID}
}

#We call the function here
Disconnect-DisconnectedUsers
