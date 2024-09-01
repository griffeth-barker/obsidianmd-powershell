<#
 .Synopsis
  Removes any declared path to your Obsidian vault.

 .Description
  Sets the $env:OMDVaultPath environment variable to $null.

  .Parameter Reload
  A switch that will reload the current user's PowerShell profile to make the $env:OMDVaultPath variable available.

 .Example
   Remove-OMDVaultPath

   Removes any declared path to your Obsidian vault.
#>

function Remove-OMDVaultPath {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $false)]
    [switch]$Reload
  )

  try {
    # Remove the OMDVaultPath environment variable
    $Content = Get-Content -Path $profile | Where-Object { $_ -notlike '$env:OMDVaultPath*' }
    Set-Content -Path $profile -Value $Content -Force

    # Reload the current user's PowerShell profile if specified
    if ($Reload) {
      . $profile
    }
  }
  catch {
    Write-Error $_.Exception.Message
  }
}

Export-ModuleMember -Function Remove-OMDVaultPath