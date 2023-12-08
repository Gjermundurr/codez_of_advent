$stream = Get-Content -Path C:\Temp\puzzle.txt

$limit = 14
$marker =  $stream.Substring(0,$limit)

for ($i = $marker.Length;$i -lt $stream.Length;$i++) {
    
    
    if ($marker.Length -eq $limit -and ($marker.ToCharArray() | Sort-Object -Unique).count -eq $limit) {
        
        Write-Host -f green "Marker found : $i"
        return
    }

    $marker = $marker.Substring(1) + $stream[$i]
}