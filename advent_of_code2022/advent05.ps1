
#$path = 'c:\temp\sample.txt'
$path = 'c:\temp\puzzle.txt'

$file = get-content -path $path

$rows = 9
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

            $stack += $data[$y][$x]
            #write-host "val: $v"
        }
        
        $y++
    }

    # Reverse string

    $stackRev = $stack.ToCharArray()
    [array]::Reverse($stackRev)
    $supply."$i" = $stackRev -join ''

    $x += $indent
    $y = 0
}

# filter commands from file
$instructions = Select-String -Path $path -Pattern '^move \d from \d to \d'

foreach ($inst in $instructions.matches) {

    $opr = ($inst.value -replace '[^0-9]') -split ''



    # index positions of operations
    $Nrofmoves = [int]($opr[1])
    $fromIndex = [int]($opr[2])
    $toIndex = [int]($opr[3])

    for ($nr = 0; $nr -lt $Nrofmoves; $nr++) {

        $box = $supply."$fromIndex"[-1] # get last box

        $supply."$fromIndex" = $supply."$fromIndex" -replace $box, '' # remove last box from original stack

        $supply."$toIndex" += $box # add box to new stack
    
    }
}

$supply.GetEnumerator() | sort name