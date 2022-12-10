#------------------------------Notes------------------------------------#
# Task 4, Part 2
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

$folderRoot = Split-Path $MyInvocation.MyCommand.Source
$taskInput = Get-Content -Path (Join-Path $folderRoot "inputs\input_4.txt")

$theLines = ($taskInput -split "`r`n")
$numberofOverlapping = 0

:lineLoop foreach($line in $theLines) {
    $sections = @()

    $splitLine = $line.Split(',')

    $sections += ,(($splitLine[0].Split('-')[0])..($splitLine[0].Split('-')[1]))
    $sections += ,(($splitLine[1].Split('-')[0])..($splitLine[1].Split('-')[1]))

    foreach($number in $sections[0]) {
        if($number -in $sections[1]){
            $numberofOverlapping++
            continue lineLoop
        }
    }
}

Write-Host ('Task 4, part 2: {0}' -f $numberofOverlapping)