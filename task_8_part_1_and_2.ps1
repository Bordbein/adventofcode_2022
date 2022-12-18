#------------------------------Notes------------------------------------#
# Task 8, Part 1 and 2
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

$folderRoot = Split-Path $MyInvocation.MyCommand.Source
$taskInput = Get-Content -Path (Join-Path $folderRoot "inputs\input_8.txt")

$inputLength = $taskInput.Length
$inputWidth = $taskInput[0].Length

$horizontalArray = New-Object string[] $inputLength
$verticalArray = New-Object string[] $inputWidth

$lineNr = 0
$howManyVisible = 0
$highestScenicScore = 0

foreach($line in $taskInput) {
    #------------------------------Notes------------------------------------#
    # Fill two arrays, one with the vertical numbers and one with
    # the horizontal numbers
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
    
    $horizontalArray[$lineNr] = $line

    $charNr = 0
    foreach($char in $line.ToCharArray()) {
        $verticalArray[$charNr] += [string] $char
        $charNr++
    }
    $lineNr++
}

for($rowNr=0;$rowNr -lt $inputLength;$rowNr++) {

    :colLoop for($colNr=0;$colNr -lt $inputWidth;$colNr++){
        #------------------------------Notes------------------------------------#
        # Check every column of every row against the two arrays we created 
        # earlier. Start with eliminating the outer rows/columns.
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
        
        if($rowNr -eq 0) {
            $howManyVisible++
            continue colLoop
        }

        if($rowNr -eq ($inputLength - 1)) {
            $howManyVisible++
            continue colLoop
        }

        if($colNr -eq 0) {
            $howManyVisible++
            continue colLoop
        }

        if($colNr -eq ($inputWidth - 1)) {
            $howManyVisible++
            continue colLoop
        }

        $arrWest = $horizontalArray[$rowNr][0..($colNr - 1)]
        $arrEast = $horizontalArray[$rowNr][($colNr + 1)..$inputWidth]
        $arrNorth = $verticalArray[$colNr][0..($rowNr - 1)]
        $arrSouth = $verticalArray[$colNr][($rowNr + 1)..$inputLength]

        [System.Array]::Reverse($arrWest)
        [System.Array]::Reverse($arrNorth)

        $checkArrays = @(
            #------------------------------Notes------------------------------------#
            # Ranges of numbers to the left or right of our current position
            #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

            ,$arrWest
            ,$arrEast
            ,$arrNorth
            ,$arrSouth
        )

        $visibilityArray = @()
        $multiplyList = @()

        foreach($checkArray in $checkArrays) {
            #------------------------------Notes------------------------------------#
            # Check the current number against the ranges.
            #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

            $treeVisible = $true
            $multiplyBy = 0

            foreach($nr in $checkArray) {
                $multiplyBy++

                if($nr -ge $horizontalArray[$rowNr][$colNr]) {
                    $treeVisible = $false
                    break
                }
            }

            $visibilityArray += $treeVisible
            $multiplyList += $multiplyBy
        }
        
        $scenicScore = 1

        foreach($nr in $multiplyList) {
            $scenicScore *= $nr
        }

        if($scenicScore -gt $highestScenicScore) {
            $highestScenicScore = $scenicScore
        }

        foreach($visibility in $visibilityArray) {
            if($visibility) {
                $howManyVisible++
                continue colLoop
            }
        }
        
    }
}

Write-Host ('Task 8, Part 1: {0}' -f $howManyVisible)
Write-Host ('Task 8, Part 2: {0}' -f $highestScenicScore)