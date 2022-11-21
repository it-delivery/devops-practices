$RandomString1 = [System.Guid]::NewGuid().ToString()
$RandomString2 = [System.Guid]::NewGuid().ToString()


$exportedVisible = "##vso[task.setvariable variable=RandomString1]$RandomString1"
Write-Output -InputObject $exportedVisible

$exportedHidden = "##vso[task.setvariable variable=RandomString2;issecret=true]$RandomString2"
Write-Output -InputObject $exportedHidden