function Copy-FileWithProgress {
    param (
        [string]$From,
        [string]$To
    )

    $file = [IO.File]::OpenRead($From)
    $toFile = [IO.File]::OpenWrite($To)

    Write-Progress -Activity "Copying file" -Status "$From -> $To" -PercentComplete 0

    try {
        $buffer = New-Object byte[] 4096
        $total = 0
        $count = 0
        do {
            $count = $file.Read($buffer, 0, $buffer.Length)
            $toFile.Write($buffer, 0, $count)
            $total += $count
            if ($total % 1MB -eq 0) {
                Write-Progress -Activity "Copying file" -Status "$From -> $To" -PercentComplete (($total * 100) / $file.Length)
            }
        } while ($count -gt 0)
    } finally {
        $file.Dispose()
        $toFile.Dispose()
        Write-Progress -Activity "Copying file" -Status "Ready" -Completed
    }
}
