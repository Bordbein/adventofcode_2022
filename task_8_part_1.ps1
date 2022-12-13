#------------------------------Notes------------------------------------#
# Task 8, Part 1
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

$folderRoot = Split-Path $MyInvocation.MyCommand.Source
$taskInput = Get-Content -Path (Join-Path $folderRoot "inputs\input_8.txt")

$inputLength = $taskInput.Length
$inputWidth = $taskInput[0].Length

$horizontalArray = New-Object string[] $inputLength
$verticalArray = New-Object string[] $inputWidth

$lineNr = 0
$howManyVisible = 0

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

        $checkArrays = @(
            #------------------------------Notes------------------------------------#
            # Ranges of numbers to the left or right of our current position
            #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

            ,$horizontalArray[$rowNr][0..($colNr - 1)]                #west
            ,$horizontalArray[$rowNr][($colNr + 1)..($inputWidth -1)] #east
            ,$verticalArray[$colNr][0..($rowNr - 1)]                  #north
            ,$verticalArray[$colNr][($rowNr + 1)..($inputWidth -1)]   #south
        )

        foreach($checkArray in $checkArrays) {
            #------------------------------Notes------------------------------------#
            # Check the current number against the ranges.
            #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

            $hiddenFromDirection = $checkArray | where {$_ -ge $horizontalArray[$rowNr][$colNr]}

            if(-not $hiddenFromDirection) {
                $howManyVisible++
                continue colLoop
            }
        }
    }
}

Write-Host ('Task 8, Part 1: {0}' -f $howManyVisible)