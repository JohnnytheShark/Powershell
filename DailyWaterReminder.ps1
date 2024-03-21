$wshell = New-Object -ComObject Wscript.Shell

# Set the reminder interval in minutes
$reminderInterval = 30

# Loop indefinitely
while ($true) {
    # Wait for the specified interval
    Start-Sleep -Seconds ($reminderInterval * 60)
    
    # Display the reminder popup
    $output = $wshell.Popup("Time to drink water💧", 0, "Drink Water Reminder", 0x4)
    
    # If the user clicks "No" (button 7), the script will stop reminding
    if ($output -eq 7) {
        exit
    }
}
