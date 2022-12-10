#------------------------------Notes------------------------------------#
# Task 1, Part 1
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

$partOne = $lists | Sort-Object -Descending | Select-Object -First 1

Write-Host ('Task 1, Part 1: {0}' -f $partOne)