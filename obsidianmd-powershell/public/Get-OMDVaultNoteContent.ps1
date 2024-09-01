<#
 .Synopsis
  Gets the content of the specified note from your Obsidian vault.

 .Description
  Gets the content of the specified note from your Obsidian vault.

 .Parameter Name
  A string containing the name of the note of which you'd like to get the content.

 .Parameter RelativePath
  A string containing the relative path to the directory in your vault containing the note of which you'd like to get the content.

 .Parameter Name
  A string containing the full path to the directory containing the note of which you'd like to get the content.

 .Example
  Get-OMDVaultNoteContent -Name 'How to create a new note' -RelativePath 'daily_notes\september'

  Gets the content of the note called 'How to create a new note' in the 'daily_notes\september' directory of your Obsidian vault.

 .Example
  Get-OMDVaultNoteContent -Name 'How to create a new note' -FullPath 'C:\Users\john.smith\Documents\Obsidian\daily_notes\september'

  Gets the content of the 'How to create a new note' note from the 'C:\Users\john.smith\Documents\Obsidian\daily_notes\september' directory.

 .Example
  Get-OMDVaultNoteContent -Name 'How to create a new note'

  Gets the content of the 'How to create a new note' note from the top-level directory of your Obsidian vault.
#>

function Get-OMDVaultNoteContent {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,
    [Parameter(Mandatory = $false)]
    [string]$RelativePath,
    [Parameter(Mandatory = $false)]
    [string]$FullPath,
    [Parameter(Mandatory = $false)]
    [switch]$OutBrowser
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
      if ($OutBrowser) {
        Show-Markdown -Path "$env:OMDVaultPath\$RelativePath\$($Name).md" -UseBrowser
      }
      if (-not $OutBrowser) {
        Show-Markdown -Path "$env:OMDVaultPath\$RelativePath\$($Name).md"
      }
    }
    if ($FullPath) {
      # Sanitize the FullPath string
      if ($FullPath -like "*\") {
        $FullPath = $FullPath.TrimEnd("\")
      }
      if ($OutBrowser) {
        Show-Markdown -Path "$FullPath\$($Name).md" -UseBrowser
      }
      if (-not $OutBrowser) {
        Show-Markdown -Path "$FullPath\$($Name).md"
      }
    }

    # Otherwise get content of the specified note in the top-level directory of the vault
    if (-not $RelativePath -and -not $FullPath) {
      Show-Markdown -Path "$env:OMDVaultPath\$($Name).md"
    }
  }
  catch {
    Write-Error $_.Exception.Message
  }

}

# Export-ModuleMember -Function Remove-OMDVaultNote