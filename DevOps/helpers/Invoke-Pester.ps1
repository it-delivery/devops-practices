# Invoke-Pester.ps1 

[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [string]$Url = $ENV:URL,

    [Parameter(Mandatory = $false)]
    [string]$TestResultsPath = $ENV:BUILD_SOURCESDIRECTORY
)


Write-Verbose -Message ('Testing of "{0}" URL has started' -f $Url) -Verbose

Get-ChildItem env: | fl

$testScriptsPath = Join-Path -Path $TestResultsPath -ChildPath 'DevOps/tests'
$testResultsFile = Join-Path -Path $TestResultsPath -ChildPath 'TestResults.Pester.xml'

$PesterVersion = '5.3.3'

If (-Not(Get-Module Pester -ListAvailable | Where-Object { $_.Version -eq $PesterVersion })) {
    Install-Module -Name Pester -Scope CurrentUser -Force -RequiredVersion $PesterVersion -SkipPublisherCheck -Repository PSGallery | Out-Null
}
Remove-Module -Name Pester -Force -ErrorAction SilentlyContinue | Out-Null
Import-Module -Name Pester -RequiredVersion $PesterVersion -Force | Out-Null


if (Test-Path $testScriptsPath) {

    $PesterContainer = New-PesterContainer -Path "$testScriptsPath/api.tests.ps1" -Data @{
        Url = $Url
    }

    $PesterConfiguration = [PesterConfiguration]@{
        Default    = @{
            Output = 'Detailed'
        }
        Run        = @{
            Container = $PesterContainer
            Exit      = $true
        }
        TestResult = @{
            Enabled      = $true
            OutputPath   = $testResultsFile
            OutputFormat = 'NUnitXml'
        }
    }

    Invoke-Pester -Configuration $PesterConfiguration | Out-Null
}
else {
    Write-Verbose -Message ('No testpath "{0}" found.' -f $testScriptsPath) -Verbose
}	