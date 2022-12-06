$folderRoot = Split-Path $MyInvocation.MyCommand.Source
$taskInput = Get-Content -Path (Join-Path $folderRoot "inputs\input_3.txt")

$chars = @()
$prio = 0

$chars += ([char]'a'..[char]'z')
$chars += ([char]'A'..[char]'Z')

foreach($line in ($taskInput -split "`r`n")) {
    $lineMid = $line.Length / 2
    $lineRest = $line.Length - $lineMid
    $firstComp = $line.Substring(0, $lineMid)
    $secComp = $line.Substring(($lineMid), $lineRest)

    $matchingLetters = @()

    foreach($letter in $firstComp.ToCharArray()) {
        if($secComp -cmatch $letter) {
            $matchingLetters += $letter
        }
    }

    $theMatchingLetters = $matchingLetters | select -Unique

    foreach($matLetter in $theMatchingLetters) {
        $prio += ($chars.IndexOf([int]([byte][char]$matLetter)) + 1)
    }
}

Write-Host ('Task 3, part 1: {0}' -f $prio)