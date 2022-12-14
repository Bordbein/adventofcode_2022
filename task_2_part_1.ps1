#------------------------------Notes------------------------------------#
# Task 2, Part 1
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

$folderRoot = Split-Path $MyInvocation.MyCommand.Source
$taskInput = Get-Content -Path (Join-Path $folderRoot "inputs\input_2.txt")

$scoreLost = 0
$scoreDraw = 3
$scoreWin = 6

$moveList = @(
    [PSCustomObject] @{
        name = 'rock'
        me = 'X'
        opp = 'A'
        score = 1
        win = 'C'
    },
    [PSCustomObject] @{
        name = 'paper'
        me = 'Y'
        opp = 'B'
        score = 2
        win = 'A'
    },
    [PSCustomObject] @{
        name = 'scissors'
        me = 'Z'
        opp = 'C'
        score = 3
        win = 'B'
    }
)

$perfectStrat = 0

foreach($line in ($taskInput -split "`r`n")) {
    
    $oppMove = $moveList | where {$_.opp -eq $line.Split(' ')[0]}
    $meMove = $moveList | where {$_.me -eq $line.Split(' ')[1]}

    $perfectStrat += $meMove.score
    
    if($meMove.me -eq $oppMove.me) {
        $perfectStrat += $scoreDraw
    } else {
        if($meMove.win -eq $oppMove.opp) {
            $perfectStrat += $scoreWin
        } else {
            $perfectStrat += $scoreLost
        }
    }
}

Write-Host ('Task 2, Part 1: {0}' -f $perfectStrat)