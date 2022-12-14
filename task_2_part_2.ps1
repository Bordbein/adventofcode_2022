#------------------------------Notes------------------------------------#
# Task 2, Part 2
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
        alt = 'lose'
    },
    [PSCustomObject] @{
        name = 'paper'
        me = 'Y'
        opp = 'B'
        score = 2
        win = 'A'
        alt = 'draw'
    },
    [PSCustomObject] @{
        name = 'scissors'
        me = 'Z'
        opp = 'C'
        score = 3
        win = 'B'
        alt = 'win'
    }
)

$alternateStrat = 0

foreach($line in ($taskInput -split "`r`n")) {

    $oppMove = $moveList | where {$_.opp -eq $line.Split(' ')[0]}
    $meMove = $moveList | where {$_.me -eq $line.Split(' ')[1]}

    if($meMove.alt -eq 'lose') {
        $altMove = $moveList | where {$_.opp -eq $oppMove.win}
        $alternateStrat += $scoreLost
    }

    if($meMove.alt -eq 'win') {
        $altMove = $moveList | where {$_.win -eq $oppMove.opp}
        $alternateStrat += $scoreWin
    }

    if($meMove.alt -eq 'draw') {
        $altMove = $moveList | where {$_.opp -eq $oppMove.opp}
        $alternateStrat += $scoreDraw
    }

    $alternateStrat += $altMove.score
}

Write-Host ('Task 2, Part 2: {0}' -f $alternateStrat)