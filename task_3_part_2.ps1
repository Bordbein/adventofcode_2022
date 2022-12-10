#------------------------------Notes------------------------------------#
# Task 3, Part 1
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

$folderRoot = Split-Path $MyInvocation.MyCommand.Source
$taskInput = Get-Content -Path (Join-Path $folderRoot "inputs\input_3.txt")

$chars = @()
$prioPartTwo = 0

$chars += ([char]'a'..[char]'z')
$chars += ([char]'A'..[char]'Z')

$theLines = ($taskInput -split "`r`n")

for($i=0;$i -lt $theLines.Length;$i = ($i + 3)) {
    
    $checkLine = $theLines[$i]

    $matchingLetters = @()

    foreach($letter in $checkLine.ToCharArray()) {
        if(($theLines[$i+1] -cmatch $letter) -and ($theLines[$i+2] -cmatch $letter) ) {
            $matchingLetters += $letter
        }
    }

    $theMatchingLetters = $matchingLetters | select -Unique

    foreach($matLetter in $theMatchingLetters) {
        $prioPartTwo += ($chars.IndexOf([int]([byte][char]$matLetter)) + 1)
    }
}

Write-Host ('Task 3, Part 2: {0}' -f $prioPartTwo)