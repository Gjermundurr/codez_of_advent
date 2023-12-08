
# read puzzle
#$file = Get-Content -Path .\files\sample8.txt
$file = Get-Content -Path c:\files\devops\adventofcode2022\files\puzzle8.txt
$arr = New-Object 'Object[,]' $file.Count,$file.Length



        # translate to array
for ($i = 0;$i -lt $file.Length;$i++) {

    for ($j = 0;$j -lt $file.Length;$j++) {

        $arr[$i,$j] = [PSCustomObject]@{
            Tree = [System.Int32]::Parse($file[$i][$j])
            Visible = $true
            View = $null
        }
    }
}




# translate to array
for ( $i = 0 ; $i -lt $file.Count ; $i++ ) {

    for ( $j = 0 ; $j -lt $file.Length ; $j++) {

        $tree = $arr[$i,$j]
        $x = ($j + 1)
        $c = 0
        $sum = @()

        do {
            
            $top = $arr[$i,$x].Tree

            if ($top -ne $null) {
            
                $x += 1

            }

        }while ($top -le $tree.Tree) {

        $sum += $c

        }
    }
}


<#
$i = 10
$j = 10


            1,3
            2,3
3,0 3,1 3,2 3,3 3,4 3,5 3,6
            4,3
            5,3
            6,3
#>



for ( $i = 0 ; $i -lt $file.Count ; $i++ ) {

    :nextTree for ( $j = 0 ; $j -lt $file.Length ; $j++) {
        
        #write-host -f Green "J:$j - I:$i"
        $current = $arr[$j,$i]

        if ($arr[$j,$i].Visible -eq $true) {
            
            continue # tree is visible
        }
        
        $arr[$j,$i].Visible = $true
        $top = 0 # highest tree
        
        # BEGIN VERTICAL CHECK HERE
        :vLoop for ($v = 0 ; $v -lt $file.Length ; $v++) {
            #write-host -f Yellow "V:$v - I:$i"
            $check = $arr[$v,$i].Tree

            if ($check -gt $top) {
                
                $top = $check
            }

            if ($v -eq $j -and $arr[$j,$i].Visible -eq $true) {
                
                #$top = 0
                #$arr[$j,$i].Visible = $true
                break # tree is visible
            }

            if ($v -gt $j -and $top -ge $current.Tree) {
                # bottom side check

                $arr[$j,$i].Visible = $false
                break
            }

            if ($v -lt $j -and $top -ge $current.Tree) {
                # Upper side is False, skip to bottom side.
                $v = $j
                $top = 0
            }
        }
    }
}

# 1050
# 1535
# 1391 FUUUUUUUUUUCK THIS
$sumVisibleXXX = 0

for ($i = 0;$i -lt $file.Length; $i++) {

    for ($j = 0;$j -lt $file.Length;$j++) {
        
        $tree = $arr[$i,$j].tree
        
        if ($arr[$i,$j].Visible -eq $true) {
            
            write-host -f Green "$tree" -NoNewline
            $sumVisibleXXX++
        }
        else {
             write-host -f red "$tree" -NoNewline
        }
    }
    write-host "" 
}




$arr