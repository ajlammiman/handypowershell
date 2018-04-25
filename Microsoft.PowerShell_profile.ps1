$repoPath = 'https://github.com/ajlammiman/'
$rootPath = 'C:\inetpub\wwwroot\'
$token = ''
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

function GitCreateNewRepo($repoName, $token)
{
    $Base64Token = [System.Convert]::ToBase64String([char[]]$token);

    $Headers = @{
        Authorization = 'Basic {0}' -f $Base64Token;
    };   
    
    $Body = @{
        name = $repoName;
    } | ConvertTo-Json;

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-RestMethod -Headers $Headers -Uri https://api.github.com/user/repos -Body $Body -Method Post
}

function GitRecreateRepo($oldRepo, $newRepoName)
{
    git clone --bar $repoPath + $oldRepo + '.git'
    cd $oldRepo + '.git'

    GitCreateNewRepo($repoName, $token)

    git push --mirror $repoPath + $newRepoName
    cd ..
    rm -rf $oldRepo + '.git'
}



GitRecreateRepo 'basicconsoleproject' 'TestRepo'

