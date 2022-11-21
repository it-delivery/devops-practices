$RandomString1 = [System.Guid]::NewGuid().ToString()
$RandomString2 = [System.Guid]::NewGuid().ToString()
$RandomString3 = [System.Guid]::NewGuid().ToString()
$RandomString4 = [System.Guid]::NewGuid().ToString()


$exportedVisibleNonOutput = "##vso[task.setvariable variable=RandomString1]$RandomString1"
Write-Output -InputObject $exportedVisibleNonOutput

$exportedHiddenNonOutput = "##vso[task.setvariable variable=RandomString2;issecret=true]$RandomString2"
Write-Output -InputObject $exportedHiddenNonOutput

$exportedVisibleOutput = "##vso[task.setvariable variable=RandomString3;isOutput=true]$RandomString3"
Write-Output -InputObject $exportedVisibleOutput

$exportedHiddenOutput = "##vso[task.setvariable variable=RandomString4;issecret=true;isOutput=true]$RandomString4"
Write-Output -InputObject $exportedHiddenOutput