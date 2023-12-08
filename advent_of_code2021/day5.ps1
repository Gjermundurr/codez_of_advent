$content = Get-Content -Path '.\sample.txt'
$grid = @()
for ($x=0; $x -le 9; $x++) {
    for ($y=0; $y -le 9; $y++) {
        $grid += [pscustomobject]@{
            pos = ($x,$y)
            hit = 0
        }
    }
}

foreach ($line in $content) {
    $l = $line.Split(' ')
    $pos1 = $l[0].split(',')
    $pos2 = $l[2].Split(',')
    diff
    [double]$pos1
    write-host $pos1 ":" $pos2
    
}



# take input:
# calculate line (ex: 7.7 -> 7.9 = 7.7-7.8-7.9)
# find obj = 7.7 | obj.Hit++