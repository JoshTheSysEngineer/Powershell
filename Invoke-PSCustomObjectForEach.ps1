Function Invoke-PSCustomObjectForEach {
    <#
    .SYNOPSIS
        A sugar function to handle iterating over a PSCustomObject
    .DESCRIPTION
        This function provides a wrapper to iterate over a PSCustomObject.
        It removes the eye irration of $PSCustomObject.PSObject.Properties | ForEach-Object {} each time you need to iterate over a PSCustomObject
    .EXAMPLE
        $test = [PSCustomObject]@{
            A = 'AA'
            B = 'BB'
            C = 'CC'
            D = 'DD'
        }
        Invoke-PSCustomObjectForEach -PSCustomObject $Test -ScriptBlock {
            Write-output "Found $($_.Name)"
        }

        Invoke-PSCustomObjectForEach -Object $Test -ScriptBlock {
            Write-output "Found $($_.Name)"
        }

        Invoke-PSCustomObjectForEach -Scriptblock {
            Write-output "Found $($_.Name)"
        } $test

        ipscofe {
            Write-output "Found $($_.Name)"
        } $test

        $test | ipscofe {
            Write-output "Found $($_.Name)"
        }

        $Test | Foreach-PSCustom {
            Write-output "Found $($_.Name)"
        }
    #>
    [alias("ipscofe", "Foreach-PSCustom")]
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory, 
            ValueFromPipeline,
            Helpmessage = "Input a PSCustomObject", 
            Position = 1
        )]
        [Alias("Object", "InputObject")]
        [PSCustomObject]
        $PSCustomObject,
        [Parameter(
            Mandatory, 
            Helpmessage = "Input a ScriptBlock", 
            Position = 0)]
        [Alias("Script", "Code")]
        [ScriptBlock]
        $ScriptBlock
    )
    process {
        $PSCustomObject.PSObject.Properties | ForEach-Object $ScriptBlock
    }
}
