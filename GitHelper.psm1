$ErrorActionPreference = "Stop"
function Clean-RemoteOrigin {
Param(
    [string]
    $path,
    [string]
    $repository
);
	If (![string]:IsNullOrEmpty($repository))
	{
		$path = (Get-Item "Env:Dev.Repository_$repository.Path").Value;
	}
	
    cd $path
    git remote prune origin
}

function Pull-Latest {
Param(
    [string]
    $path,
    [string]
    $repository
);
	If (![string]:IsNullOrEmpty($repository))
	{
		$path = (Get-Item "Env:Dev.Repository_$repository.Path").Value;
	}

    cd $path
    git pull
    git submodule init
    git submodule update --recursive

    $lines = Get-Content ".gitmodules"
    foreach ($line in $lines) {
        If ($line.Substring(0, 11) -eq  "[submodule ") {
            Write-Host $line
        }
        ElseIf ($line.Substring(0, 11) -eq  "path = ") {
            $sub_path = ($line).Substring(7);
            cd $sub_path
        }
        ElseIf ($line.Substring(0, 9) -eq  "branch = ") {
            $sub_branch = ($line).Substring(9);
            git checkout $sub_branch
            git pull
        }
    }
}

function Import-Repository {
Param(
	[string]
	$pattern = "Env:Dev.Repository_*.Name"
);

	$repositories = Get-Item $pattern;
	Foreach ($repository in $repositories) {
		If ($repository.Name -like '*.Name') {
			$name = $repository.Value;
			$url = (Get-Item "Env:Dev.Repository_$name.RemoteUrl").Value;
			$path = (Get-Item "Env:Dev.Repository_$name.Path").Value;
			
			Clone-Repository -Path $path -url $url;
		}
	}
}

function Clone-Repository {
Param (
    [Parameter(Mandatory=$false)]
	[string]
	$path = '.',
    [Parameter(Mandatory=$true)]
	[string]
	$url
);

    If(!(Test-Path $path))
    {
        New-Item -ItemType Directory -Force -Path $path
        git clone $url $path
    }
    ElseIf (-not(Test-Path "$path\*") -Or ((Get-ChildItem $path | Measure-Object).Count -eq 0))
    {
        git clone $url $path;
    }
    Else
    {
        Write-Host "Directory $path already exists"
    }
	
	$submodules = git config --file .gitmodules --name-only --get-regexp path;

	If (-not([string]::IsNullOrEmpty($submodules))) {
		git submodule init
		git submodule update
	}
}


export-modulemember -function Clean-RemoteOrigin
export-modulemember -function Pull-Latest
export-modulemember -function Import-Repository
export-modulemember -function Clone-Repository
