<#
 .Synopsis
  Appends content to an existing note in your Obsidian vault.

 .Description
  Appends (adds) the specified content to the end of an existing note in your Obsidian vault.

 .Parameter Name
  A string containing the name of the note to which you'd like to append content.
  
 .Parameter RelativePath
  A string containing the relative path to the directory in your vault containing the note to which you'd like to append content.
  
 .Parameter FullPath
  A string containing the full path to the directory containing the note to which you'd like to append content.
  
 .Parameter Content
  A string containing the content you'd like to append to the end of the specified note.
 .Example
  Append-OMDVaultNote -Name 'How to create a new note' -Content 'This is some content to append to the end of the note.'

  Appends 'This is some content to append to the end of the note.' to the 'How to create a new note' note in the top-level directory of your Obsidian vault.

 .Example
  Append-OMDVaultNote -Name 'How to create a new note' -Content 'This is some content to append to the end of the note.' -RelativePath 'daily_notes\september'

  Appends 'This is some content to append to the end of the note.' to the 'How to create a new note' note in the 'daily_notes\september' directory of your Obsidian vault.
 
  .Example
  Append-OMDVaultNote -Name 'How to create a new note' -Content 'This is some content to append to the end of the note.' -FullPath 'C:\Users\john.smith\Documents\Obsidian\daily_notes\september'

  Appends 'This is some content to append to the end of the note.' to the 'How to create a new note' note at the specified path inside your Obsidian vault.

 .Example
  Append-OMDVaultNote -Name 'How to create a new note' -Content 'This is some content to append to the end of the note.' -FullPath 'C:\Users\john.smith\Documents\Obsidian\daily_notes\september'

  Appends 'This is some content to append to the end of the note.' to the 'How to create a new note' note in the top-level directory of your Obsidian vault.
#>

function Append-OMDVaultNoteContent {
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

# Export-ModuleMember -Function Append-OMDVaultNoteContent