param (
    [Parameter(Mandatory)]
    [Alias("GitUser")]
    [string]${Git user name},
    
    [Parameter(Mandatory)]
    [Alias("GitPass")]
    [string]${Git token}

    # [Parameter(Mandatory)]
    # [Alias("ExternalIp")]
    # [string]${Your external IP}
)

$GitUser = ${Git user name}
$GitPass = ${Git token}

$ExternalIpRequest = Invoke-WebRequest -URI http://myexternalip.com/raw
$ExternalIp = $ExternalIpRequest.Content

# docker build . -t ep-fixtures-img `
#     --build-context localrepository=../../_GIT_DigitalPayments/APM.Automation.CypressEP/ `
#     --build-arg="user=$GitUser" `
#     --build-arg="pass=$GitPass" `
#     --build-arg="ip=$ExternalIp"
docker build . -t ep-fixtures-img `
    --build-arg="user=$GitUser" `
    --build-arg="pass=$GitPass" `
    --build-arg="ip=$ExternalIp"