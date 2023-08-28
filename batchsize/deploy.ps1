param(
    [Parameter(Mandatory = $true)]
    [string]
    $location,
    [Parameter(Mandatory = $true)]
    [string]
    $rsgName,
    [Parameter(Mandatory = $true)]
    [string]
    $subscriptionName
)

$getRootDir = git rev-parse --show-toplevel
Set-Location $getRootDir/bicep/batchSize

az login
az account set --name $subscriptionName

az group create `
    --location $location `
    --name $rsgName

az deployment group create --resource-group $rsgName --template-file .\main.bicep -c
