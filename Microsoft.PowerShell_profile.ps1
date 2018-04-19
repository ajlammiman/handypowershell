$repoPath = "https://github.com/ajlammiman/"
Import-Module posh-git

set-location C:\inetpub\wwwroot

function SetUpNewReactProject($folderName) 
{
    $repo = $repoPath + "/reactprojectbase.git"
    $path = "C:\inetpub\wwwroot\" + $folderName

    GitCheckoutRepo($repo, $path)
}


function SetUpNewConsoleProject($folderName) 
{
   $repo = $repoPath + 'basicconsoleproject.git'
   $path = 'C:\inetpub\wwwroot\' + $folderName

    GitCheckoutRepo($repo, $path)
}

function GitCheckoutRepo($repo, $path)
{
    git clone $repo $path
}



