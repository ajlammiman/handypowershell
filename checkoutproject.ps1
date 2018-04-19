$repoPath = https://github.com/ajlammiman/


function SetUpNewReactProject($folderName) 
{
    $repo = https://github.com/ajlammiman/reactprojectbase.git
    $path = C:\inetpub\wwwroot\$folderName

    GitCheckoutRepo($repo, $path)
}


function SetUpNewConsoleProject($folderName) 
{
   $repo = $repoPath + '/basicconsoleproject.git'
   $path = C:\inetpub\wwwroot\$folderName

    GitCheckoutRepo($repo, $path)
}

function GitCheckoutRepo($repo, $path)
{
    git clone $repo $path
}


SetUpNewConsoleProject consoleTest

