# calculate the most efficient crab position.
$content = (get-content '.\sample7.txt').Split(',')
$values = @()
foreach ($n in $content) {
    $values += [int]$n
}
$total = 0
foreach ($v in $values) {
    $total += $v
}
$total
# find the total range.
# calcualte the average

