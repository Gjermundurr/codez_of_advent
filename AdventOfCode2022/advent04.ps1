#$data = get-content -path c:\temp\sample.txt
$data = get-content -path c:\temp\puzzle.txt # | select -first 50
$count = 0
foreach ($ln in $data) {

    $p1 = ($ln -split ',')[0] -replace '-','..'
    $p2 = ($ln -split ',')[1] -replace '-','..'
    
    Invoke-Expression $p1 | ForEach-Object {
        
        if ($_ -in (Invoke-Expression $p2)) {
            
            write-host -f red $ln
            $count++
            continue
        }
    }
    
    write-host $ln
}
write-host "Final ans: $count"
# guess part two: 124
