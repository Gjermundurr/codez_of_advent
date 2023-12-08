#$data = get-content -path C:\temp\sample.txt
$data = get-content -path C:\temp\puzzle.txt

#$data = $data | select -first 9

$totalsum = 0

$y = 2
for ($x=0; $x -le ($data.count - 3);$x+=3) {

    $dddata = $data[$x..$y]
    $y += 3



    $s1 = $dddata[0]
    $s2 = $dddata[1]
    $s3 = $dddata[2]

    #$s1 = $sack.Substring(0,$sack.Length / 2)
    #$s2 = $sack.Substring($sack.Length / 2)



    :lsearch foreach ($l in ($s1 -split "")) {
        
        if ($l -eq "") {
            continue lsearch
        }

        if ((($s2 -split '') -ccontains $l) -and (($s3 -split '') -ccontains $l)) {

            $val = $l
            break
        }
    }



    [array]$UPPERCASE = 65..90 | %{[char]$_}
    [array]$lowercase = 97..122 | %{[char]$_}

    $index = 0

    if ($val -cin $UPPERCASE) {

        foreach ($alpha in $UPPERCASE) {

            $index++
            #write-host "$alpha : $index"
            if ($alpha -eq $val) {
                $index += 26
                break

            }
        }
    }
    else {

        foreach ($alpha in $lowercase) {
            
            $index++
            #write-host "$alpha : $index"
            if ($alpha -eq $val) {

                break
            }
        }
    }
    write-host "val: $val - ind: $index"
    $totalsum += $index
    Write-Host $x
}

write-host -f green "Answer: $totalsum" 

# Answer part one: 7691
# second part guess: 2560