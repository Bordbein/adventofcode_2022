#------------------------------Notes------------------------------------#
# Task 7, Part 1
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

$folderRoot = Split-Path $MyInvocation.MyCommand.Source
$taskInput = Get-Content -Path (Join-Path $folderRoot "inputs\input_7.txt")

$allFolders = @()
$parentArray = @()

$currentLevel = 0

foreach($line in $taskInput) {

    if($line -match '^\$ cd ((\w+$)|(\/$))') {
        #------------------------------Notes------------------------------------#
        # Add the folder to a list of all folders, and also a temporary
        # parent array which at all times will contain only the parents of
        # the current folder and the current folder itself in the last index.
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

        $customFolder = [PSCustomObject] @{
            name = ('{0}/{1}' -f $parentArray[$currentLevel - 1].name, ($line.Split(' ')[2]))
            size = 0
        }

        $parentArray += $customFolder
        $allFolders += $customFolder
        $currentLevel++
    }

    if($line -match '^\d+') {
        #------------------------------Notes------------------------------------#
        # Add the size of this folder to all the folders in the parent array
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

        foreach($fold in $parentArray) {
            $fold.size += ([int]$line.Split(' ')[0])
        }
    }

    if($line -match '^\$ cd \.\.$') { 
        #------------------------------Notes------------------------------------#
        # Removing the last entries in the parent array when we go up
        # in the structure
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

        $currentLevel--
        $parentArray = $parentArray[0..($currentLevel - 1)]
    }
}

$spaceNeeded = 30000000 - (70000000 - $allFolders[0].size)

foreach($fold in $allFolders) {
    Add-Member -InputObject $fold -MemberType NoteProperty -Name diff -Value ([int]($fold.size - $spaceNeeded))
}

$theSmallestFolder = $allFolders | Where-Object {$_.diff -gt 0} | Sort-Object diff | Select-Object -First 1 | Select-Object -ExpandProperty size

Write-Host ('Task 7, Part 2: {0}' -f $theSmallestFolder)