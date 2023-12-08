# advent of code: day 9

$file = Get-Content -Path C:\files\Devops\AdventOfCode2022\files\sample9.txt
#$file = Get-Content -Path C:\files\Devops\AdventOfCode2022\files\puzzle9.txt

$instructions = @()
$file.split('´n´l') | ForEach-Object {

    $ln = $_ -split ' '
    $instructions += [pscustomobject]@{
        
        dir = $ln[0]
        val = [System.Int32]::Parse($ln[1])
    }
}

$instructions

# create array board
$pos = New-Object 'Object[,]' 200,200

$Head = [pscustomobject]@{
    X = 100
    Y = 100
}
$Tail = [pscustomobject]@{
    X = 100
    Y = 100
}


foreach ($in in $instructions) {

    $pos[$Tail.X,$Tail.Y] = '#'


    for ($mv = 0; $mv -lt $in.val; $mv++) {
        
        if ($in.dir -eq 'R') {
            $Head.X += 1
        }
        if ($in.dir -eq 'L') {
            $Head.X -= 1
        }
        if ($in.dir -eq 'U') {
            $Head.Y += 1
        }
        if ($in.dir -eq 'D') {
            $Head.Y -= 1
        }


        # check Tail position relative to Head
        if ($Head.X -)

    }

    
}



