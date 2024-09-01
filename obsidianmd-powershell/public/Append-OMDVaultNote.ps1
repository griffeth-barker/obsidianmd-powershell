<#
 .Synopsis
  Appends content to an existing note in your Obsidian vault.

 .Description
  Appends (adds) the specified content to the end of an existing note in your Obsidian vault.

 .Parameter Name
  A string containing the name of the note to which you'd like to append content.
  
 .Parameter Relative Path
  A string containing the relative path to the directory in your vault containing the note to which you'd like to append content.
  
 .Parameter Full Path
  A string containing the full path to the directory containing the note to which you'd like to append content.
  
 .Parameter Content
  A string containing the content you'd like to append to the end of the specified note.

 .Example
  Append-OMDVaultNote -Name 'How to create a new note' -Content 'This is some content to append to the end of the note.'

  Searches for notes in your Obsidian vault whose file name or full path name contain the word 'Linux'.
#>

function Append-OMDVaultNote {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,
    [Parameter(Mandatory = $false)]
    [string]$RelativePath,
    [Parameter(Mandatory = $false)]
    [string]$FullPath,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string]$Content
  )

  # Sanitize the Name string
  if ($Name -like "*.md") {
    $Name = $Name.TrimEnd(".md")
  }

  # Add content to the note
  Add-Content -Path "$env:OMDVaultPath\$RelativePath\$($Name).md" -Value $Content -Force

}

# Export-ModuleMember -Function Append-OMDVaultNote