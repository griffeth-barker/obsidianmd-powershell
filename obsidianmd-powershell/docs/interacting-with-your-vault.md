# Interacting with your Vault

## Set-OMDVaultPath
The `Set-OMDVaultPath` cmdlet allows you to declare the path to your Obsidian vault.

This the cmdlet is a function that checks your current PowerShell profile for the existence of the `$env:OMDVaultPath` variable. If it does not exist, it will create it using the fully qualified path you specify; this path can be a local path or a UNC path to a network share.

### Parameters
`-Path` : A string containing the fully qualified path to the top-level directory of your Obsidian vault, ending with a backslash.
`-Reload` : A switch that will reload the current user's PowerShell profile to make the $env:OMDVaultPath variable available.
`-Force` : A switch that will force the creation of the directory for the vault if it does not exist.

### Examples
Setting the vault path to a local directory
```PowerShell
Set-OMDVaultPath -Path "C:\Users\john.smith\Documents\Obsidian\"
```

Setting the vault path to a UNC path
```PowerShell
Set-OMDVaultPath -Path "\\server\share\Obsidian\"
```

## Get-OMDVaultPath
The `Get-OMDVaultPath` cmdlet allows you to declare the path to your Obsidian vault.

This the cmdlet returns the path to your Obsidian vault as set by the `Set-OMDVaultPath` cmdlet.

This is accomplished by checking if `$env:OMDVaultPath` is set, and if so, returning its value.

### Parameters
There are no parameters for this cmdlet.

### Examples
Setting the vault path to a local directory
```PowerShell
Get-OMDVaultPath
```

## Remove-OMDVaultPath
The `Remove-OMDVaultPath` cmdlet allows you to remove the `$env:OMDVaultPath` variable from your PowerShell profile.

This is accomplished by getting the `$profile` in your PowerShell session and selecting all of its content *except* for the line that contains the `$env:OMDVaultPath` variable, and then writing the modified content back to the `$profile`.

### Parameters
`-Reload` : A switch that will reload the current user's PowerShell profile to make the $env:OMDVaultPath variable available.

### Examples
Remove the declared path to your Obsidian vault
```PowerShell
Remove-OMDVaultPath
```

Remove the declared path to your Obsidian vault and reload the current user's PowerShell profile
```PowerShell
Remove-OMDVaultPath -Reload
```