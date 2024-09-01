<#
 .Synopsis
  Declares the path to your Obsidian vault.

 .Description
  Sets the $env:OMDVaultPath environment variable to the specified path.

 .Parameter Path
  A string containing the fully qualified path to the top-level directory of your Obsidian vault, ending with a backslash. 
  This can be a local path or a UNC path.

  .Parameter Reload
  A switch that will reload the current user's PowerShell profile to make the $env:OMDVaultPath variable available.

  .Parameter Force
  A switch that will force the creation of the directory for the vault if it does not exist.

 .Example
   Set-OMDVaultPath -Path "C:\Users\john.smith\Documents\Obsidian\"

   Sets the path to a local directory.

 .Example
   Set-OMDVaultPath -Path "\\server\share\Obsidian\"

  Sets the Path to a network share.
#>

function Set-OMDVaultPath {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Path,
    [Parameter(Mandatory = $false)]
    [switch]$Force,
    [Parameter(Mandatory = $false)]
    [switch]$Reload
  )

  try {
    # Ensure the path ends with a backslash
    if ($Path -notlike "*\") {
      $Path = $Path + "\"
    }

    # Force creation of the directory if it doesn't exist
    if ($Force) {
      New-Item -Path $Path -ItemType Directory -Force | Out-Null
    }

    # Ensure current user's PowerShell profile exists
    if (-not (Test-Path $profile)) {
      New-Item -Path $profile -ItemType File | Out-Null
    }

    if ((Get-Content -Path $profile | Select-String -Simple '$env:OMDVaultPath').Count -eq 0) {
      # Set the OMDVaultPath environment variable
      $Variable = '$env:OMDVaultPath'
      Add-Content -Path "$($profile)" -Value ("$Variable" + "=" + "'" + $Path + "'") -Force

      # Reload the current user's PowerShell profile if specified
      if ($Reload) {
        . $profile
      }
    }
    else {
      Write-Error 'The $env:OMDVaultPath variable already exists in your PowerShell profile; please remove it with Remove-OMDVaultPath then retry.'
    }
  }
  catch {
    Write-Error $_.Exception.Message
  }
}

Export-ModuleMember -Function 'Set-OMDVaultPath'