<#
 .Synopsis
 Gets notes from your Obsidian vault.

 .Description
 Searches your Obsidian vault for notes matching your specified search criteria.

 .Parameter SearchTerm
 A string containing your search term. This is not case sensitive. The search will be performed by enumerating the contents
 of your Obsidian vault and searching for the specified term in the file name or full path name; this will behave as if you
 hade a * wildcard on either side of your search term.

 .Example
  Get-OMDVaultNote -SearchTerm 'Linux'

  Searches for notes in your Obsidian vault whose file name or full path name contain the word 'Linux'.
#>

function Get-OMDVaultNote {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$SearchTerm
  )

  try {
    $ResultsDatatable = New-Object System.Data.DataTable
    [void]$ResultsDatatable.Columns.Add("Index", [Int32])
    [void]$ResultsDatatable.Columns.Add("Title", [String])
    [void]$ResultsDatatable.Columns.Add("Path", [String]) ## TODO: Change this to relative path instead of full path.

    $Results = Get-ChildItem -Path $env:OMDVaultPath -Recurse -File | Where-Object { $_.Name -like "*$SearchTerm*" -or $_.FullName -like "*$SearchTerm*" -and $_.Extension -eq ".md" }
    
    foreach ($Result in $Results) {
      $Index++
      [void]$ResultsDatatable.Rows.Add($Index, $Result.Name, $Result.FullName)
    }

    return [PSCustomObject]$ResultsDatatable
  }
  catch {
    Write-Error $_.Exception.Message
  }
}