$folderRoot = Split-Path $MyInvocation.MyCommand.Source
$taskInput = Get-Content -Path (Join-Path $folderRoot "inputs\input_5.txt")

$theLines = ($taskInput -split "`r`n")

$caseArray = @()

foreach($line in ($theLines | select -First 1)) {
    $lineChars = $line.ToCharArray()

    Write-Host ('Line: {0}' -f $line)

    $count = 1
    foreach($char in $lineChars) {
        Write-Host ('Char {0}: {1}' -f $count, $char)

        $count++
    }
}