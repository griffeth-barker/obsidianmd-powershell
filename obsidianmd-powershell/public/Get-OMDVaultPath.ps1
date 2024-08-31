<#
 .Synopsis
 Gets the declared path to your Obsidian vault.

 .Description
 Gets the vaule of the $env:OMDVaultPath environment variable.

 .Parameter Reload
 A switch that will reload the current user's PowerShell profile to make the $env:OMDVaultPath variable available.

 .Example
 Remove-OMDVaultPath

 Removes any declared path to your Obsidian vault.
#>

function Get-OMDVaultPath {
  try {
    Test-Path -Path $env:OMDVaultPath -ErrorAction Stop | Out-Null
    return $env:OMDVaultPath
  }
  catch {
    Write-Error 'The $env:OMDVaultPath variable is not set. You can set it using Set-OMDVaultPath.'
  }
}

# Export-ModuleMember -Function Get-OMDVaultPath