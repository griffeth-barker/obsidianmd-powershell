# obsidianmd-powershell Module


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

    $Results = Get-ChildItem -Path $env:OMDVaultPath -Recurse -File | Where-Object { $_.Name -like "*$SearchTerm*" -or $_.FullName -like "*$SearchTerm*" -and $_.Extension -eq ".md" }
    
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

function Get-OMDVaultPath {
  try {
    Test-Path -Path $env:OMDVaultPath -ErrorAction Stop | Out-Null
    return $env:OMDVaultPath
  }
  catch {
    Write-Error 'The $env:OMDVaultPath variable is not set. You can set it using Set-OMDVaultPath.'
  }
}

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

Export-ModuleMember -Function 'Add-OMDVaultNoteContent', 'Get-OMDVaultNote', 'Get-OMDVaultNoteContent', 'Get-OMDVaultPath', 'New-OMDVaultNote', 'Remove-OMDVaultNote', 'Remove-OMDVaultPath', 'Set-OMDVaultPath'