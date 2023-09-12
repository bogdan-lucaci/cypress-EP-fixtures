param (
    [Parameter(Mandatory=$true)]
    [string]$server,

    [Parameter(Mandatory=$true)]
    [string]$user,    

    [Parameter(Mandatory=$true)]
    [string]$password,

    [Parameter(Mandatory=$true)]
    [string]$serviceName
)

$pwd = convertto-securestring "$password" -asplaintext -force

$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist "$user",$pwd

Invoke-Command -ComputerName "$server" -Credential $cred -ScriptBlock { Restart-Service -Name $Using:serviceName }