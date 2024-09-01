<#
 .Synopsis
  Removes the specified note from your Obsidian vault.

 .Description
  Removes the specified note from your Obsidian vault.

 .Parameter Name
  A string containing the name of the note you'd like to remove.

 .Parameter RelativePath
  A string containing the relative path to the directory in your vault containing the note you'd like to remove.

 .Parameter Name
  A string containing the full path to the directory containing the note you'd like to remove.

 .Example
  Remove-OMDVaultNote -Name 'How to create a new note'

  Removes the specified note from the top-level directory of your Obsidian vault.

 .Example
  Remove-OMDVaultNote -Name 'How to create a new note' -RelativePath 'daily_notes\september'

  Removes the note named 'How to create a new note' from the 'daily_notes\september' directory of your Obsidian vault.

 .Example
  Remove-OMDVaultNote -Name 'How to create a new note' -FullPath 'C:\Users\john.smith\Documents\Obsidian\daily_notes\september'

  Removes the 'How to create a new note' note from the 'C:\Users\john.smith\Documents\Obsidian\daily_notes\september' directory.
#>

function Remove-OMDVaultNote {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,
    [Parameter(Mandatory = $false)]
    [string]$RelativePath,
    [Parameter(Mandatory = $false)]
    [string]$FullPath
  )

  try {
    # Sanitize the Name string
    if ($Name -like "*.md") {
      $Name = $Name.TrimEnd(".md")
    }

    # Remove note using relative path if specified
    if ($RelativePath) {
      # Sanitize the RelativePath string
      if ($RelativePath -like "*\") {
        $RelativePath = $RelativePath.TrimEnd("\")
      }
      Remove-Item -Path "$env:OMDVaultPath\$RelativePath\$($Name).md" -Force | Out-Null
    }
    
    # Remove note using full path if specified
    if ($FullPath) {
      Remove-Item -Path "$FullPath\$($Name).md" -Force | Out-Null
    }

    # Otherwise remove note in top-level directory of vault
    else {
      Remove-Item -Path "$env:OMDVaultPath\$($Name).md" -Force | Out-Null
    }
  }
  catch {
    Write-Error $_.Exception.Message
  }
}

Export-ModuleMember -Function Remove-OMDVaultNote