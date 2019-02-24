# Git Helpers

PowerShell Helper scripts to manage git repositories.

## Getting Started

* Copy the files
* Open Command Line or PowerShell (*Window + X, A*)
* If you opened Command Prompt, then type *powershell* in order to use PowerShell commands
* Navigate to the scripts directory <br />`cd your_directory`
* Type <br />`Import-Module .\GitHelper.psm1`
* Now you can use the methods from your PowerShell session

### Adding Script to Profile [Optional]

* Enable execution policy using PowerShell Admin <br /> `Set-ExecutionPolicy Unrestricted`
* Navigate to the profile path <br />`cd (Split-Path -parent $PROFILE)`
* Open the location in Explorer <br />`ii .`
* Create the user profile if it does not exist <br />`If (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force }`
* Import the module in the PowerShell profile <br />`Import-Module -Path script_directory -ErrorAction SilentlyContinue`

# Examples

## Clean-RemoteOrigin Example
Prune Remote origin branches.
<details>
   <summary>Prune remote origin branches</summary>
   <p>Clean-RemoteOrigin -Path 'C:\git\PowerShell\EnvironmentVariables\'</p>
</details>
<details>
   <summary>Prune remote origin branches for repository environment variable `Dev.Repository_***EnvironmentVariables***.Path`</summary>
   <p>Clean-RemoteOrigin -Repository 'EnvironmentVariables'</p>
</details>

## Pull-Latest Example
Performs a git pull for the current directory and its submodules. Also makes sure that none of the submodules are detached at a specific commit.
<details>
   <summary>Pull Latest by path</summary>
   <p>Pull-Latest -Path "C:\git\PowerShell\EnvironmentVariables\"</p>
</details>
<details>
   <summary>Pull Latest by repository name</summary>
   <p>Pull-Latest -Repository 'EnvironmentVariables'</p>
</details>

## Import-Repository Example
Clones the repositories that match the specified pattern.
<details>
   <summary>Import all repositories defined as environment variables (pattern Dev.Repository_*.Name)</summary>
   <p>Import-Repositories</p>
</details>
<details>
   <summary>Import specific repository defined as environment variables</summary>
   <p>Import-Repositories -pattern "Dev.Repository_EnvironmentVariables.Name"</p>
</details>

## Clone-Repository Example
Clones repository by url and path and pulls latest files and submodules.
<details>
   <summary>Clone repository to current directory</summary>
   <p>Clone-Repository -Url 'https://github.com/jhonnyelhelou91/EnvironmentVariables.git'</p>
</details>
<details>
   <summary>Clone repository to custom directory</summary>
   <p>Clone-Repository -Url 'https://github.com/jhonnyelhelou91/EnvironmentVariables.git' -Path 'C:\git\PowerShell\EnvironmentVariables\'</p>
</details>
