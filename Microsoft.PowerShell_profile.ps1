oh-my-posh init --config "C:/Users/leona/.config/ohmyposh/zen.toml" pwsh | Invoke-Expression
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1

Set-Alias -Name z -Value __zoxide_z -Option AllScope -Scope Global -Force
Set-Alias -Name zi -Value __zoxide_zi -Option AllScope -Scope Global -Force

function ListDir {
	[alias('ls')]
	param(
		[string]$Path
	)
	
	eza  -al --color --icons --group-directories-first
}

function ListDirs {
	[alias('ld')]
	param(
		[string]$Path
	)
	
	eza -alD --color=always --icons=always
}

function ListFiles {
	[alias('lf')]
	param(
		[string]$Path
	)
	
	eza -alf --color --icons
}

function ListDirTree {
	[alias('lt')]
	param(
		[string]$Path
	)
	
	eza -aT --level=2 --color --icons --group-directories-first
}