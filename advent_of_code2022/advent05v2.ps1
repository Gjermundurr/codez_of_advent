
$ErrorActionPreference = 'stop'

#$path = 'c:\temp\sample.txt'
$path = 'C:\files\Devops\AdventOfCode2022\files\puzzle5.txt'

$file = get-content -path $path
$stackHeight = 8 # max height of stack
$rows = 9 # Nr of rows
$indent = 4
$rownr = 1
$x = 1
$y = 0
$supply = @{}


for ($i = 1;$i -le $rows;$i++) {

    $v = $null
    [string]$stack = ''

    while ([string]$v -notmatch '\d') {

        $v = $file[$y][$x]
        
        if ([string]$v -notmatch '\s' -and [string]$v -notmatch '\d') {

            $stack += $file[$y][$x]
        }

        if ([string]$v -match '\d') {

            break
        }

        $y++
    }

    # Reverse string
    $stackRev = $stack.ToCharArray()
    [array]::Reverse($stackRev)

    # add to supply table
    $supply[$i] = ($stackRev -join '')
    $x += $indent
    $y = 0
}

function Show-TableX {

    param (
        $supply,
        $rows
    )
    $nums = ''

    # Add X
    $maxHeight = ($supply.Values.length | Sort-Object -Descending)[0]
    for ($x = 1; $x -le $rows ;$x++) {
        $supply[$x] += '-' * ($maxHeight - $supply[$x].Length)
    }
    
    for ($hh = $maxHeight - 1; $hh -ge 0; $hh--) {

        $printRow = '' # null string for each row

        for ($rr = 1; $rr -lt $rows+1; $rr++) {
        
            if ($supply[$rr][$hh] -eq '-') {
            
                $printRow += '[ ] '
            }
            else {
            
                $printRow += '[{0}] ' -f $supply[$rr][$hh]
            }
        }

        write-host $printRow
    }

    # print table row numbers
    $TableNums = ''
    1..$rows | ForEach-Object {
        $TableNums += "($_) "
    }
    write-host -f Green "$TableNums"

    # remove Xs
    for ($x=1;$x -lt $rows+1; $x++) {
        $supply[$x] = $supply[$x] -replace '-',''
    }
}


# filter commands from file
$instructions = Select-String -Path $path -Pattern '^move \d{1,2} from \d to \d'

foreach ($inst in $instructions.matches) {
    
    # Match string by Groups
    $inst.value -match '^move (\d{1,2}) from (\d) to (\d)$' | Out-Null
    
    # index positions of operations
    $Nrofmoves = $Matches[1] -as [int]
    $fromStack = $Matches[2] -as [int]
    $toStack = $Matches[3] -as [int]

    write-host -f yellow ("{0}" -f $Matches[0])

    # find boxes
    $boxes = $supply[$fromStack].substring($supply[$fromStack].length - $Nrofmoves)
    
    # reverse box order
    #$boxesRev = $boxes.ToCharArray()
    #[array]::Reverse($boxesRev)

    # apply boxes to new stack
    $supply[$toStack] += $boxes # $boxesRev -join ''

    # remove boxes from orig stack
    $supply[$fromStack] = $supply[$fromStack].remove($supply[$fromStack].Length - ($boxes.Length),$boxes.Length)
    
    Show-TableX -supply $supply -rows $rows
}

$answ = ''
foreach ($r in ($supply.GetEnumerator() | sort name)) {
    $answ += '[{0}]' -f $r.Value[-1]
}

# Final answer
write-host -f green $answ

# first try: [P][][V][][][N][F][C][]
# second try: [L][H][Z][N][][S][G][V][]
# fuck regex ...

write-host -f Yellow "RUMPENISSE"