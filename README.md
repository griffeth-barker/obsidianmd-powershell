# obsidianmd-powershell
A basic and unofficial PowerShell module for interacting with your Obsidian notes.

## Introduction
obsidianmd-powershell is a basic and unofficial PowerShell module desinged to allow you to interact with your Obsidian vault and Markdown notes. The module interacts with your vault at the filesystem level, rather than the application level, and therefore uses a lot of inbuild PowerShell functionality rather than the Obsidian developers' API. 

Obsidian prides itself on you maintaining ownership of your vault's contents, and that its entirely workable even without Obsidian since the core of your vault is really just Markdown files in filesystem directories. Given this premise, I felt it was important to maintain that spirit and put together a simple module to enable people to work with their notes in a way that doesn't directly rely on the Obsidian client in case it ever ceases to exist (which we all hope never happens).

## Installation
This module will be available on the PowerShell Gallery at its first release. Until then, you can download the `.zip` archive of the module from GitHub and manually import it into your PowerShell session.

## Getting Started
To get started with obsidianmd-powershell, head over to the [wiki](https://github.com/griffeth-barker/obsidianmd-powershell/wiki/Getting-Started).