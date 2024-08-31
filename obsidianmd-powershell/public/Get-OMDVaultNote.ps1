<#
 .Synopsis
 Gets notes from your Obsidian vault.

 .Description
 Searches your Obsidian vault for notes matching your specified search criteria.

 .Parameter SearchTerm
 ##TODO: Add help for -SearchTerm

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
    [void]$ResultsDatatable.Columns.Add("Path", [String])

    $Results = Get-ChildItem -Path $env:OMDVaultPath -Recurse -File | Where-Object { $_.Name -like "*$SearchTerm*" -or $_.FullName -like "*$SearchTerm*" }
    
    foreach ($Result in $Results) {
      $Index++
      [void]$ResultsDatatable.Rows.Add($Index, $Result.Name, $Result.FullName)
    }

    return $ResultsDatatable
  }
  catch {
    Write-Error $_.Exception.Message
  }
}

# Export-ModuleMember -Function Get-OMDVaultNote