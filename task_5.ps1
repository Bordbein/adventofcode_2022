$folderRoot = Split-Path $MyInvocation.MyCommand.Source
$taskInput = Get-Content -Path (Join-Path $folderRoot "inputs\input_5.txt")

$theLines = ($taskInput -split "`r`n")

$arrayWidth = ($theLines[0].Length + 1) / 4

$caseArray = New-Object string[] $arrayWidth


foreach($line in $theLines) {

    if($line -match '\[') {
        $lineChars = $line.ToCharArray()

        $charLoc = 0

        for($i=1;$i -lt $lineChars.Length; $i = $i + 4) {
            if($lineChars[$i] -match '[A-Z]') {
                $caseArray[$charLoc] += $lineChars[$i]
            }
            
            $charLoc++
        }
    }

    if($line -match 'move') { 
        $rules = $line.Split(' ')

        $nrOfCases = ([int]([string]$rules[1]))
        $fromStack = ([int]([string]$rules[3]) - 1)
        $toStack = ([int]([string]$rules[5]) - 1)

        $fromString = $caseArray[$fromStack]
        $toString = $caseArray[$toStack]

        $moveString = $fromString.Substring(0,$nrOfCases)

        $newFromString = $fromString.Substring($nrOfCases,($fromString.Length - $nrOfCases))

        $toStringChar = $toString.ToCharArray()
        [array]::Reverse($toStringChar)

        $newToStringChar = $toStringChar + $moveString.ToCharArray()
        [array]::Reverse($newToStringChar)

        $caseArray[$fromStack] = $newFromString
        $caseArray[$toStack] = [string](-join $newToStringChar)
    }
}

$topCases = [string]::Empty

foreach($stack in $caseArray) {
    $topCases += $stack.Substring(0,1)
}

Write-Host ('Task 4, part 1: {0}' -f $topCases)