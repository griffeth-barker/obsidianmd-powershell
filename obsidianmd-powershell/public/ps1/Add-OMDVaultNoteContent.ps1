<#
 .Synopsis
  Adds content to an existing note in your Obsidian vault.

 .Description
  Adds (adds) the specified content to the end of an existing note in your Obsidian vault.

 .Parameter Name
  A string containing the name of the note to which you'd like to Add content.
  
 .Parameter RelativePath
  A string containing the relative path to the directory in your vault containing the note to which you'd like to Add content.
  
 .Parameter FullPath
  A string containing the full path to the directory containing the note to which you'd like to Add content.
  
 .Parameter Content
  A string containing the content you'd like to Add to the end of the specified note.
 .Example
  Add-OMDVaultNote -Name 'How to create a new note' -Content 'This is some content to Add to the end of the note.'

  Adds 'This is some content to Add to the end of the note.' to the 'How to create a new note' note in the top-level directory of your Obsidian vault.

 .Example
  Add-OMDVaultNote -Name 'How to create a new note' -Content 'This is some content to Add to the end of the note.' -RelativePath 'daily_notes\september'

  Adds 'This is some content to Add to the end of the note.' to the 'How to create a new note' note in the 'daily_notes\september' directory of your Obsidian vault.
 
  .Example
  Add-OMDVaultNote -Name 'How to create a new note' -Content 'This is some content to Add to the end of the note.' -FullPath 'C:\Users\john.smith\Documents\Obsidian\daily_notes\september'

  Adds 'This is some content to Add to the end of the note.' to the 'How to create a new note' note at the specified path inside your Obsidian vault.

 .Example
  Add-OMDVaultNote -Name 'How to create a new note' -Content 'This is some content to Add to the end of the note.' -FullPath 'C:\Users\john.smith\Documents\Obsidian\daily_notes\september'

  Adds 'This is some content to Add to the end of the note.' to the 'How to create a new note' note in the top-level directory of your Obsidian vault.
#>

function Add-OMDVaultNoteContent {
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