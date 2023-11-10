function Get-IPsFromFile {
    <#
    .SYNOPSIS
        Extracts IP Addresses from a specified file
    .DESCRIPTION
        This function extracts IP Addresses from a specificed file, can ignore a list of IP Addresses, and return the lines the IP Address was found.
    .PARAMETER Path
        Location of file to extract IP Addresses from
    .PARAMETER IgnoreIP
        An IP or list of IP Addresses to ignore
    .PARAMETER GetLines
        Returns the lines the IP Addresses were found
    .EXAMPLE
        Get-IPsFromFile -Path C:\File.log
        Get-IPsFromFile -Path C:\File.log -IgnoreIP 192.168.1.1, 192.168.1.0
        Get-IPsFromFile -Path C:\File.log -GetLines
        Get-IPsFromFile -Path C:\File.log -IgnoreIP 192.168.1.1 -GetLines
    #>
    
    
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory)]
        [ValidateScript({Test-Path $_})]
        [System.String[]]$Path,
        [Parameter()]
        [ValidateScript({[System.Text.RegularExpressions.Regex]::Match($_, "\d{1,3}(\.\d{1,3}){3}").Success})]
        [System.String[]]$IgnoreIP,
        [Parameter()]
        [System.Management.Automation.SwitchParameter]$GetLines
    )
    
    begin {
        $FileLines = Get-Content $Path
        $Results = @()
    }
    
    process {
        Foreach($Line in $FileLines) {
            $IP = $IPMatch = $null
            $IP = ($Line  |  Select-String -Pattern "\d{1,3}(\.\d{1,3}){3}" -AllMatches)
            $IP.Matches.Value | Foreach-Object {
                $IPMatch = New-Object PSObject -Property @{
                    IPAddress = $_
                }
                $Results += $IPMatch
            }
        }
    }
    
    end {
        $UniqueIPList = $Results | Select-Object IPAddress -Unique | Where-Object IPAddress -notin $IgnoreIP
        Write-Output "=== Unique IP List for $Path ==="
        Write-Output $UniqueIPList

        if(-not $GetLines) {return}

        Foreach($Result in $UniqueIPList) {
            [System.Environment]::NewLine
            Write-output "=== Lines for $($Result.IPAddress) ==="
            ($FileLines | Select-String $Result.IPAddress).Line
            [System.Environment]::NewLine
        }
    }
}
