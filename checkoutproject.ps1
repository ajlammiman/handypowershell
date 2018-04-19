$repoPath = https://github.com/ajlammiman/

function SetUpNewReactProject($folderName) 
{
    git clone https://github.com/ajlammiman/reactprojectbase.git C:\inetpub\wwwroot\$folderName
    cd C:\inetpub\wwwroot\$folderName
    npm install
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

