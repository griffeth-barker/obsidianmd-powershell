<#
 .Synopsis
 Gets the declared path to your Obsidian vault.

 .Description
 Gets the vaule of the $env:OMDVaultPath environment variable.

 .Example
 Get-OMDVaultPath

 Gets the declared path to your Obsidian vault.
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

Export-ModuleMember -Function Get-OMDVaultPath