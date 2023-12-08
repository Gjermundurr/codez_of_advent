class Bingo {
    # Properties
    [string] $File
    [array] $numbers
    [array] $boards
    [string] $items
    [array] $Finished

    # OVERLOAD CONSTRUCTOR
    Bingo([string]$FilePath) {
        $this.File = $filePath
    }

    # METHOD
    [void] ProcessData() {
        $content = Get-Content $This.File | Out-String
        $nl = [System.Environment]::NewLine
        $string = ($content -split "$nl$nl")
        
        # CREATE NUM ARRAY
        $string[0] -split ',' | ForEach-Object {$This.numbers += [int]$_}

        # LOOP ALL BOARDS
        for ($i=1; $i -lt $string.count; $i++) {
            $board = $string[$i]
            $b = $board -split '\s+'
            $sqr = @()
            # CREATE HIT/VAL ARRAY OF EACH SQAURE
            foreach ($n in $b) {
                if ($n -eq "") {
                    continue
                } else {
                    $sqr += [PSCustomObject]@{
                        Value = [int]$n
                        Hit = $false
                        }
                    }
            }
            
            $This.boards += [PSCustomObject]@{
                BoardID = $i
                Squares = $sqr
                Finished = $false
                Display = $null
                Rank = $null
            }
        }
    }
    [string] Display($board) {
        $disp = ""
        $count = 0
        foreach ($sqr in $board.Squares) {
            if ($count -eq 5) {
                $disp += "`n"
                $count = 0
            }
            if ($sqr.value -match "^\d$") {
                $count++
                if ($sqr.Hit -eq $true) {
                    $disp += "[$($sqr.value)] "
                } else {
                    $disp += "$($sqr.value)  "
                }
            }
            if ($sqr.value -match "^\d\d$") {
                $count++
                if ($sqr.Hit -eq $true) {
                    $disp += "[$($sqr.value)]"
                } else {
                    $disp += "$($sqr.value) "
                }
            }
        }
        return $disp
    }

    [array] Play() {
        $rank = 1
        for ($n=0; $n -lt $This.numbers.Length; $n++) {
            $CurrentN = $This.numbers[$n]
            :bloop foreach ($board in $This.boards) {
                if ($board.Finished -eq $true) {
                    continue
                }
                #write-host $This.Display($board) "`n"
                $sqr = $board.Squares | Where-Object {$_.value -eq $CurrentN}
                if ($sqr) {
                    $sqr.Hit = $true
                }
            
                # HORIZONTAL CHECK
                $xi = 0
                $xstop = 4
                $increment = 0
                $winningNums = @()
                :rowX for ($r=0; $r -le 4; $r++) {
                    :X1 for ($xi = 0 + $increment; $xi -le ($xstop+$increment); $xi++) {
                        if ($board.Squares[$xi].Hit -eq $true) {
                            $winningNums += $board.Squares[$xi]
                            if ($winningNums.Count -eq 5) {
                                write-host "WINNER WINNER CHICKEN DINNER! BoardID: " $board.BoardID
                                $board | add-member -NotePropertyName WinNumb -NotePropertyValue $currentN
                                $board | add-member -NotePropertyName Bingo -NotePropertyValue $winningNums
                                write-host $This.Display($board)
                                $board.finished = $true
                                $board.rank = $rank++
                                continue bloop
                            }
                        } else {
                            $increment++
                            $winningNums = @()
                            break x1
                        }
                    }
                }
            
                # VERTICAL CHECK
                $yi = 0
                $ystop = 20
                $increment = 0
                $winningNums = @()
                :rowY for ($r=0; $r -le 4; $r++) {
                    :y1 for ($yi= 0 + $increment; $yi -le $ystop+$increment; $yi+=5) {
                        if ($board.Squares[$yi].Hit -eq $true) {
                            $winningNums += $board.Squares[$yi]

                            if ($winningNums.Count -eq 5) {
                                write-host "WINNER WINNER CHICKEN DINNER! BoardID: " $board.BoardID
                                $board | add-member -NotePropertyName WinNumb -NotePropertyValue $currentN
                                $board | add-member -NotePropertyName Bingo -NotePropertyValue $winningNums
                                write-host $This.Display($board)
                                $board.finished = $true
                                $board.rank = $rank++
                                continue bloop
                            }
                        } else {
                            $increment++
                            $winningNums = @()
                            break y1
                        }
                    }
                }
            }
        }
        return "Exiting."
    }

    [string] Answer($board) {
        $emptySUM = 0
        $This.Display($board)
        foreach ($sqr in $board.squares) {
            if ($sqr.Hit -eq $false) {
                write-host $sqr.value "+"
                $emptySUM += $sqr.value
            }
        }
        write-host "SUM EMPTY: " $emptySUM
        write-host "WinNumb: " $board.winNumb
        $answer = $emptySUM * $board.winNumb
        return $answer
    }
}
# 'c:\scripts\adventofcode2021\test.txt'
$Bingo = [Bingo]::new('c:\scripts\adventofcode2021\test.txt')
$Bingo.ProcessData()
$bingo.Play()
$loser = $bingo.boards | Where-Object {$_.rank -eq 100}
$bingo.Display($loser)
$bingo.Answer($loser)

