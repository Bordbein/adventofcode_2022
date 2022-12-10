#------------------------------Notes------------------------------------#
# Task 6, Part 2
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

$folderRoot = Split-Path $MyInvocation.MyCommand.Source
$taskInput = Get-Content -Path (Join-Path $folderRoot "inputs\input_6.txt")

$indicator = 0

for($i=0;$i -lt ($taskInput.Length - 3);$i++) {
    
    $checkString = $taskInput.Substring($i, 14)
    $checkChars = $checkString.ToCharArray()

    $nrOfUnique = ($checkChars | Select-Object -Unique).Count
    
    if($nrOfUnique -eq 14) {
        $indicator = $i + 14
        break
    }
}

Write-Host ('Task 6, Part 2: {0}' -f $indicator)