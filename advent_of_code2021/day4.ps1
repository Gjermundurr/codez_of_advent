
function ProcessData {
    # FILTER AND PROCESS INPUT FILE.
    param (
        $path = '.\sample.txt'
    )
    $string = Get-Content $path | Out-String
    $nl = [System.Environment]::NewLine
    $items = ($string -split "$nl$nl")
    return $items
}
function processBoards {
    # CREATE BOARD OBJECTS
    param (
        $items
    )

    for ($i=1; $i -lt $items.count; $i++) {
        $currentB = $items[$i]
        $split = $currentB -split '\s+'
        $sqr =  @()
        # $testDisp = @()
        # foreach ($qqq in $split) {
        #     $testDisp += [int]$qqq
        
        foreach ($n in $split) {
            $sqr += [PSCustomObject]@{
                Value = [int]$n
                Hit = $False
            }
        }

        $disp = @(
                $sqr[0..4],
                $sqr[5..9],
                $sqr[10..14],
                $sqr[15..19],
                $sqr[20..24]
        )

        [pscustomobject]@{
            BoardID = $i
            Finished = $False
            Squares = $sqr
            Display = $disp
        }
    }
}
function PlayBingo {
    # PLAY GAME
    param (
        $boards,
        $nums 
    )

    for ($n = 0; $n -lt $nums.length; $n++) {   # loop numbers with $i
        $currentNum = $nums[$n]
        write-host "current num: " $nums[$n]
        foreach ($board in $boards) {
            write-host "BOARD: " $board.display
            # find square matching num and set to true
            $square = $board.Squares | where-object -property value -eq $nums[$n]
            if ($null -ne $square.value) {
                $square.Hit = $true
            }

            $winningNums = @()
            $streak = 0
            $xi = 0
            $xstop = 4
            $noFound = $xstop
            # HORIZONTAL CHECK
            for ($xi;$xi -le $xstop; $xi++) {
                if ($board.Squares[$xi].Hit -eq $true) {
                    $winningNums += ,$board.Squares[$xi]
                    $streak++
                    if ($streak -eq 5) {
                        write-host "WINNER WINNER CHICKEN DINNER!" $board.BoardID
                        $board | add-member -NotePropertyName WinNumb -NotePropertyValue $currentNum
                        $board | add-member -NotePropertyName Bingo -NotePropertyValue $winningNums
                        return $board
                        break
                    }
                } else {
                    $winningNums = @()
                    $streak = 0
                    if ($noFound -eq 24) {
                        break
                    }
                    $xi += 5
                    $xstop += 5
                }
            }

            $streak = 0
            $yi = 0
            $ystop = 20

            for ($yi; $yi -le $ystop; $yi+=5) {
                if ($board.Squares[$yi].Hit -eq $true) {
                    $winningNums += ,$board.Squares[$yi]
                    $streak++
                    if ($streak -eq 5) {
                        write-host "WINNER WINNER CHICKEN DINNER!" $board.BoardID
                        $board | add-member -NotePropertyName WinNumb -NotePropertyValue $currentNum
                        $board | add-member -NotePropertyName Bingo -NotePropertyValue $winningNums
                        return $board
                        break
                    }
                } else {
                    $streak = 0
                    $winningNums = @()
                    if ($noFound -eq 24) {
                        break
                    }
                    $yi += 1
                    $ystop += 1
                }
            }
        }
    }
}

function CalculateAnswer {
    param (
        $board
    )
    $winNumb = $calc[1]
    $kkk = 0
    $calc[0] | % {$kkk += $_.value}
    $ans = $kkk * $winNumb
    return $ans

}


# $data = ProcessData('C:\scripts\adventofcode2021\test.txt')
$data = ProcessData
$data | get-member
$nums = $data[0] -split ','
$boards = processBoards($data)
$ret = PlayBingo -boards $boards -nums $nums
$ret
#CalculateAnswer -board $ret

