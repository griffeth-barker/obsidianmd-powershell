# obsidianmd-powershell
A basic and unofficial PowerShell module for interacting with your Obsidian vault and the notes therein.

## Introduction
obsidianmd-powershell is a basic and unofficial PowerShell module desinged to allow for easier interactions with your Obsidian vault and its notes. The module interacts with your vault at the filesystem level, rather than the application level, and therefore uses a lot of inbuild PowerShell functionality rather than the Obsidian developers API. Obsidian prides itself on you maintaining ownership of your vault's contents, and that its entirely workable even without Obsidian since the core of your vault is really just Markdown files in filesystem directories. Given this premise, I felt it was important to maintain that spirit and put together a simple module to enable people to more easily work with their vaults and the contents therein in a way that doesn't directly rely on the Obsidian client.

## Installation
To install this module, use the below command to download the repository or if you prefer, use Git to clone the repository.
```PowerShell
Invoke-WebRequest -Uri "" -OutFile "$($env:userprofile\Downloads\obsidianmd-powershell.zip"
```

Once you've obtained the module, install the module and import it:
```PowerShell
Install-Module -Name "obsidianmd-powershell" -Repository "c:\path\to\downloaded\repo"
Import-Module -Name "obsidianmd-powershell"
```

## Getting Started
