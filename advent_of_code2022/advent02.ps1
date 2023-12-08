# Points
# A,X = Rock (1)
# B,Y = Paper (2)
# C,Z = Sicor (3)
#
# Loss (0)
# Draw (3)
# Winning (6)

#$data = Get-Content -path c:\temp\sample.txt
$data = Get-Content -path c:\temp\puzzle.txt

function playRPS {

    param(
        $p1,
        $p2,
        $SCOREBOARD = 0
    )

    $playbook = @(
        [pscustomobject]@{
            'def' = 'Rock'
            'Hand' = 'AX'
            'Win' = 'CZ'
            'Loss' = 'BY'
            'Points' = 1
        },
        [pscustomobject]@{
            'def' = 'Paper'
            'Hand' = 'BY'
            'Win' = 'AX'
            'Loss' = 'CZ'
            'Points' = 2
        },
        [pscustomobject]@{
            'def' = 'Scissor'
            'hand' = 'CZ'
            'Win' = 'BY'
            'Loss' = 'AX'
            'Points' = 3
        }
    )

    $player1 = $playbook | where {$_.hand -match $p1}
    #$You = $playbook | where {$_.hand -match $p2}

    ### PART TWO ### 

    $cheatcodes = @{}
    $cheatcodes.X = 'Loss'
    $cheatcodes.Y = 'Draw'
    $cheatcodes.Z = 'Win'


    if ($cheatcodes.item($p2) -eq 'Loss') {
        $You = $playbook | where {$_.hand -match $player1.Win}
    }
    elseif ($cheatcodes.item($p2) -eq 'Draw') {
        $You = $playbook | where {$_.hand -match $player1.Hand}
    }
    elseif ($cheatcodes.item($p2) -eq 'Win') {
        $You = $playbook | where {$_.hand -match $player1.Loss}
    }


    if ($player1.hand -in $you.win) {
        # You won.
        $SCOREBOARD += ($You.Points + 6)
        #write-host "WIN"
    }
    elseif ($player1.hand -eq $you.Hand) {
        # its a draw.
        $SCOREBOARD += ($You.Points + 3)
        #write-host "DRAW"
    }
    else {
        # you lost.
        $SCOREBOARD += ($You.Points)
        #write-host "LOSS" 
    }
    
    return $SCOREBOARD
}

# BEGIN ROCK, PAPER, SICORS !!
$score = 0

foreach($n in $data) {

    $p1 = $n.split(' ')[0]
    $p2 = $n.split(' ')[1]

    $Score += (playRPS -p1 $p1 -p2 $p2)

}

Write-host -f green ("Final Score: {0}" -f $score)


# first guess: 10853
# Final Score: 11873
# part two: 12014