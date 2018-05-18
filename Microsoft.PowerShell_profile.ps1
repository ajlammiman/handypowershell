$repoPath = 'ssh://git@github.com/ajlammiman/'
$rootPath = 'C:\inetpub\wwwroot\'
$token = ''
Import-Module posh-git
Set-Alias ssh-agent "$env:ProgramFiles\git\usr\bin\ssh-agent.exe"
Set-Alias ssh-add "$env:ProgramFiles\git\usr\bin\ssh-add.exe"
Start-SshAgent -Quiet

set-location C:\inetpub\wwwroot

function SetUpNewReactProject($folderName, $newRepoName) 
{
    $repoReact = 'reactprojectbase'
    $path = $rootPath  + $folderName

    GitRecreateRepo($repoReact, $path)
}


function SetUpNewConsoleProject([string]$folderName, [string]$newRepoName)
{
   $repoConsole = 'basicconsoleproject'
   $path = 'C:\inetpub\wwwroot\' + $folderName
   
    GitRecreateRepo -oldRepo $repoConsole -path $path -newRepoName $newRepoName
}

function GitCreateNewRemoteRepo($repoName, $token)
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

function GitRecreateRepo([string]$oldRepo, [string]$newRepoName)
{
    $oldRepoGit = $oldRepo + '.git'
    $oldRepoAddress = $repoPath + $oldRepoGit
    $newRepoLoc = $repoPath + $newRepoName + '.git'
    $newRepoFolder = $rootPath + $newRepoName 
  
    git clone --bare $oldRepoAddress
    cd $oldRepoGit

    GitCreateNewRemoteRepo -repoName $newRepoName -token $token
    
    git push --mirror $newRepoLoc
    cd ..
    git rm -rf $oldRepoGit
    cd $rootPath
    New-Item -Path $newRepoFolder -ItemType directory
    git init 
    git clone $newRepoLoc
    cd $newRepoFolder
}

#GitRecreateRepo 'basicconsoleproject' 'C:\inetpub\wwwroot\' 'DummyRepo2'



