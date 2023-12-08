
$ErrorActionPreference = 'STOP'
$file = get-content -path C:\Files\Devops\AdventOfCode2022\files\puzzle7.txt

$system = @{}
$sys = '$system'
$HashTable = " = @{}"
$contentTable = @{}
$currentDir = ''
$contents = @()
$bind = ''

#$rootDir = New-Item -ItemType Directory -Path C:\Temp -Name advent07 -Force
Set-Location -Path $rootDir.FullName

foreach ($ln in ($file)) {

    write-host "$ln"

    if ($ln -match '^\$ cd (\.{2}|\w|\/)$') { # entering directory

        $Mtch = $Matches[1]

        if ($Mtch -match '/') {

            $Mtch = 'root'
        }

        if ($Mtch -eq '..') {

            cd ..
            
            continue # return to previous dir
        }

        # create new directory

        $newDir = New-Item -ItemType Directory -Name $Mtch
        Set-Location $newDir.FullName

        continue # next command

    }

    if ($ln -match '^\$ ls$') {
        
        continue
    }
        
    if ($ln -notmatch 'dir') { # create new file - set size as value
        
        $size = $ln.split(' ')[0]
        $filename = $ln.split(' ')[1]

        New-item -ItemType File -Name $filename -Value $size
        
    }
}
Get-ChildItem -File
$currentPath

$dirs = Get-ChildItem $pwd -Directory

if ($dirs[0]) {

    cd $dirs[0]
}
else {

    $files = Get-ChildItem -File

    $files | ForEach-Object {
    
        
        [int]$value = Get-Content $_
    }
}

$folderSum


New-RandomFile -FileSize 29116

29116 / 8

1024 / 8