
$ErrorActionPreference = 'STOP'
#$file = get-content -path C:\temp\sample.txt
$file = get-content -path C:\Files\Devops\AdventOfCode2022\files\puzzle7.txt

$system = @{}
$sys = '$system'
$HashTable = " = @{}"
$contentTable = @{}
$currentDir = ''
$contents = @()
$bind = ''

$ln = '$ cd a'



foreach ($ln in ($file)) {

    write-host "$ln"

    if ($ln -match '^\$ cd (\.{2}|\w+|\/)$') { # entering directory

        if ($Matches[1] -eq '..') {

            $sys = $sys.Remove($sys.LastIndexOf('[')) #-replace ("['$currentDir']"),''
            $currentDir = $sys.Substring($sys.LastIndexOf('[')).Replace('[','').Replace("'",'').Replace(']','')

            continue # return to previous dir
        }
        $currentDir = ('dir:{0}' -f $Matches[1])

        $sys += ("['{0}']" -f $currentDir)
        Invoke-Expression ("$sys {0}" -f $HashTable)

        $contentTable[$currentDir] = @()

        continue # next command

    }

    if ($ln -match '^\$ ls$') {
        
        continue
    }
        
    if ($ln -notmatch 'dir') { # sort only files - we dont give a fk about Dirs
        
        $contents = $contentTable[$currentDir]
        
        $size = $ln.split(' ')[0]
        $filename = ('file:{0}' -f $ln.split(' ')[1])

        [array]$contents += "'$filename'=$size"
        
        $items = ($contents -join ';')
        
        Invoke-Expression ("{0}{1}" -f $sys, " = @{$items}")

        $contentTable[$currentDir] = $contents
    }
}

function Add-FolderSize {
    
    param (
        $object
    )
    
    if ($object.gettype().name -eq 'Hashtable') {
    
        $count = 0

        foreach ($item in $object.GetEnumerator()) {
            
            if ($item.value.gettype().name -eq 'int32') {
                
                $count += $item.value

            }
            elseif ($item.value.gettype().name -eq 'Hashtable') {

                $count += Add-FolderSize -object $item.value
            }
        }

        return $count
    }
}

function Loop-Maddafakka {

    param(
        $object
    )

    if ($object.gettype().name -eq 'Hashtable') {

        foreach ($item in $object.GetEnumerator()) {
            
            if ($item.value.gettype().name -eq 'Hashtable') {

                $sum =  Add-FolderSize -object $item.value
                [pscustomobject]@{
                    Dir = $item.Name
                    Size = $sum
                }
                
                Loop-maddafakka -object $item.value
            }
        }
        return
    }
}

$result = Loop-maddafakka -object $system

$ans = 0
# first answer # 
$result | ForEach-Object {

    if ($_.size -le 100000) {
        
        $ans += $_.size
    }
}

$currentSize = $result[0].size
$requiredSize =   30000000
$filesystemSize = 70000000


$result | Sort-Object -Property Size | ForEach-Object {

    if (($currentSize + $requiredSize - $_.Size) -le $filesystemSize) {

        write-host -f green ("answer: {0}" -f $_.size)
        break
    }
}