<#
 .Synopsis
 Creates a new note in your Obsidian vault.

 .Description
 Creates a new Markdown file with your specified name within your Obsidian vault.

 .Parameter Name
 A string containing the desired name of the new note.

 .Parameter RelativePath
A string containing the relative path to where you'd like the note created. If not specified, the new note will be
created in the top-level directory of your Obsidian vault.

 .Parameter FullPath
A string containing the fully qualified path to where you'd like the note created. If not specified, the new note will be
created in the top-level directory of your Obsidian vault.

 .Example
  New-OMDVaultNote -Name 'How to create a new note'
  Creates a new note named 'How to create a new note' in the top-level directory of your Obsidian vault.
 .Example
  New-OMDVaultNote -Name 'How to create a new note' -RelativePath 'daily_notes\september'
  Creates a new note named 'How to create a new note' in the How to create a new note directory of your Obsidian vault.
 .Example
  New-OMDVaultNote -Name 'How to create a new note' -FullPath 'C:\Users\john.smith\Documents\Obsidian\daily_notes\september'
#>

function New-OMDVaultNote {
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

    # Create new note using relative path if specified
    if ($RelativePath) {
      # Sanitize the RelativePath string
      if ($RelativePath -like "*\") {
        $RelativePath = $RelativePath.TrimEnd("\")
      }
      New-Item -Path "$env:OMDVaultPath\$RelativePath" -Name "$($Name).md" -ItemType File | Out-Null
    }
    
    # Create new note using full path if specified
    if ($FullPath) {
      New-Item -Path $FullPath -Name "$($Name).md" -ItemType File | Out-Null
    }

    # Otherwise create new note in top-level directory of vault
    else {
      New-Item -Path $env:OMDVaultPath -Name "$($Name).md" -ItemType File | Out-Null
    }
  }
  catch {
    Write-Error $_.Exception.Message
  }
}