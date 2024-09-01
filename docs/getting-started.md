# Getting Started

## Installation Methods
Presently, the module's `.zip` archive can manually downloaded and imported into your PowerShell session.

```PowerShell
Invoke-WebRequest -Uri "https://github.com/gbarker/obsidianmd-powershell/archive/refs/tags/v0.1.0.zip" -OutFile "$env:USERPROFILE\Downloads\obsidianmd-powershell-0.1.0.zip"

Expand-Archive -Path "$env:USERPROFILE\Downloads\obsidianmd-powershell-0.1.0.zip" -DestinationPath "$env:USERPROFILE\Documents\WindowsPowerShell\Modules\obsidianmd-powershell"
```

At the first release of the module, it will be published to the PowerShell Gallery for easier installation.

## Importing the Module
Once you've obtained the module, you can import it into your PowerShell session:

```PowerShell
Import-Module obsidianmd-powershell
```

## Next Steps
Check out Interacting with your Vault.