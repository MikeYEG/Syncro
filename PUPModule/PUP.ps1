<#
    .SYNOPSIS
        Evergreen script to initiate the module
#>
[CmdletBinding(SupportsShouldProcess = $False)]
param ()

#region Get public and private function definition files
$publicRoot = Join-Path -Path $PSScriptRoot -ChildPath "Public"
$privateRoot = Join-Path -Path $PSScriptRoot -ChildPath "Private"
$Public = @( Get-ChildItem -Path (Join-Path $publicRoot "*.ps1"))
$Private = @( Get-ChildItem -Path (Join-Path $privateRoot "*.ps1"))

# Dot source the files
ForEach ($import in @($Public + $Private)) {
    Try {
        . $import.FullName
    }
    Catch {
        Write-Error -Message "Failed to import function $($import.FullName): $_"
    }
}

# Export the public modules and aliases
#Export-ModuleMember -Function $public.Basename -Alias *
#endregion

# Get module strings
# $script:resourceStrings = Get-ModuleResource