$repoPath = 'https://github.com/ajlammiman/'
$rootPath = 'C:\inetpub\wwwroot\'
Import-Module posh-git

set-location C:\inetpub\wwwroot

function SetUpNewReactProject($folderName, $newRepoName) 
{
    $repo = 'reactprojectbase'
    $path = $rootPath  + $folderName

    GitRecreateRepo($repo, $path)
}


function SetUpNewConsoleProject($folderName, $newRepoName) 
{
   $repo = 'basicconsoleproject'
   $path = 'C:\inetpub\wwwroot\' + $folderName

    GitRecreateRepo($repo, $path, $newRepoName)
}

function GitRecreateRepo($oldRepo, $path, $newRepoName)
{
    git clone --bar $repoPath + $oldRepo + '.git'
    cd $oldRepo + '.git'
    git push --mirror $repoPath + $newRepoName
    cd ..
    rm -rf $oldRepo + '.git'
}



