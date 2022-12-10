#------------------------------Notes------------------------------------#
# Task 5, Part 1
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

$folderRoot = Split-Path $MyInvocation.MyCommand.Source
$taskInput = Get-Content -Path (Join-Path $folderRoot "inputs\input_5.txt")

$theLines = ($taskInput -split "`r`n")

$arrayWidth = ($theLines[0].Length + 1) / 4

$caseArray = New-Object string[] $arrayWidth

foreach($line in $theLines) {

    if($line -match '\[') {
        #------------------------------Notes------------------------------------#
        # Parse the lines containing stacks of cases in to strings
        # and put them in the caseArray. The strings will be reversed.
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

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
        #------------------------------Notes------------------------------------#
        # Here we create a substring of the source stack.
        # Then reverse the destination stack string, append
        # the source substring and reverse destination stack string 
        # once more after.
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

        $rules = $line.Split(' ')

        $nrOfCases = ([int]([string]$rules[1]))
        $fromStack = ([int]([string]$rules[3]) - 1)
        $toStack = ([int]([string]$rules[5]) - 1)

        $fromString = $caseArray[$fromStack]
        $toString = $caseArray[$toStack]

        $moveString = $fromString.Substring(0,$nrOfCases)
        $moveStringChars = $moveString.ToCharArray()

        if($nrOfCases -gt 1) {
            #------------------------------Notes------------------------------------#
            # If multiple cases we reverse the substring of the source stack aswell.
            #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

            [array]::Reverse($moveStringChars)
        }

        $newFromString = $fromString.Substring($nrOfCases,($fromString.Length - $nrOfCases))

        $toStringChar = $toString.ToCharArray()
        [array]::Reverse($toStringChar)

        $newToStringChar = $toStringChar + $moveStringChars
        [array]::Reverse($newToStringChar)

        $caseArray[$fromStack] = $newFromString
        $caseArray[$toStack] = [string](-join $newToStringChar)
    }
}

$topCases = [string]::Empty

foreach($stack in $caseArray) {
    #------------------------------Notes------------------------------------#
    # Since the strings are reversed, the top case will be the first letter
    # in each string.
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

    $topCases += $stack.Substring(0,1)
}

Write-Host ('Task 5, Part 2: {0}' -f $topCases)