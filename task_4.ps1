$folderRoot = Split-Path $MyInvocation.MyCommand.Source
$taskInput = Get-Content -Path (Join-Path $folderRoot "inputs\input_4.txt")

$theLines = ($taskInput -split "`r`n")
$numberOfSectionsInSections = 0
$numberofOverlapping = 0

foreach($line in $theLines) {
    $sections = @()

    $splitLine = $line.Split(',')

    $sections += ,(($splitLine[0].Split('-')[0])..($splitLine[0].Split('-')[1]))
    $sections += ,(($splitLine[1].Split('-')[0])..($splitLine[1].Split('-')[1]))

    $largerSection = 1
    $smallerSection = 0

    if(($sections[0] | Measure-Object -Sum).Sum -gt ($sections[1] | Measure-Object -Sum).Sum) {
        $largerSection = 0
        $smallerSection = 1
    }

    if(($sections[$smallerSection][0] -ge $sections[$largerSection][0]) -and ($sections[$largerSection][-1] -ge $sections[$smallerSection][-1])) {
        $numberOfSectionsInSections++
    }
}

Write-Host ('Task 4, part 1: {0}' -f $numberOfSectionsInSections)



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