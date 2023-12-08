
# read puzzle
#$file = Get-Content -Path .\files\sample8.txt
$file = Get-Content -Path .\files\puzzle8.txt
$arr = New-Object 'Object[,]' $file.Count,$file.Length



        # translate to array
for ($i = 0;$i -lt $file.Length;$i++) {

    for ($j = 0;$j -lt $file.Length;$j++) {

        $arr[$i,$j] = [PSCustomObject]@{
            Tree = [System.Int32]::Parse($file[$i][$j])
            Visible = $true
        }
    }
}

# translate to array
for ( $i = 0 ; $i -lt $file.Count ; $i++ ) {

    :nextTree for ( $j = 0 ; $j -lt $file.Length ; $j++) {

        $current = $arr[$i,$j]
       
        $top = 0 # highest tree

        :hLoop for ($h = 0 ; $h -lt $file.Length ; $h++) {

            # check horizontal visibility of current trees
            $check = $arr[$i,$h].Tree

            if ($check -gt $top) {
                
                $top = $check
            }

            if ($h -eq $j -and $arr[$i,$j].Visible -eq $true) {
                
                break # tree is visible
            }

            if ($h -gt $j -and $top -ge $current.Tree) {
                
                $arr[$i,$j].Visible = $false
                break # H check failed, goto V check
            }

            if ($h -lt $j -and $top -ge $current.Tree) {
                # left side is False, skip to right side.
                $h = $j
                $top = 0
            }
        }
    }
}


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


