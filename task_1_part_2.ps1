#------------------------------Notes------------------------------------#
# Task 1, Part 2
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

$folderRoot = Split-Path $MyInvocation.MyCommand.Source
$taskInput = Get-Content -Path (Join-Path $folderRoot "inputs\input_1.txt")

$lists = @()
$startNumber = 0

foreach($line in ($taskInput -split "`r`n")) {
    $nr = [int]$line

    if($nr -gt 0) {
        $startNumber += $nr
    } else {
        $lists += $startNumber
        $startNumber = 0
    }
}

$partTwo = $lists | Sort-Object -Descending | Select-Object -First 3 | Measure-Object -Sum | select -ExpandProperty Sum

Write-Host ('Task 1, Part 2: {0}' -f $partTwo)