[CmdletBinding()]
param (
    [Parameter()]
    $APIUrl
)

Describe "API Tests" {

    BeforeDiscovery {
        $script:BaseUri = $APIUrl
        $script:Headers = @{
            'Content-Type'    = 'application/json'
        }
    }

    Context "Function is warmed up" {
        BeforeAll{
            $response = (Invoke-WebRequest -Method Get -Uri $BaseUri -Headers $Headers -UseBasicParsing).Content
        }
        It "Should return a 200" {
            $response = Invoke-WebRequest -Uri $APIUrl
            $response.StatusCode | Should -Be 200
        }
    }

    Context "Correct response" {
        BeforeAll{
            $Content = (Invoke-WebRequest -Method Post -Uri ($BaseUri + "/api/function1") -Headers $Headers -UseBasicParsing).Content
        }
        It "Should return a valid response" {
            $Content | Should -NotBeNullOrEmpty
        }
    }
}