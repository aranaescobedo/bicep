param location string = resourceGroup().location

@description('Subnet name')
param snetName string = 'vnet-batch-test-we'

@description('Virtual network name')
param vnetName string = 'vnet-batch-test-we-01'

resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes:[
        '10.1.0.0/22'
      ]
    }
  }
}

// Commenting out the 'batchSize' line to resolve the deployment conflict error message.
//@batchSize(1)
resource snet 'Microsoft.Network/virtualNetworks/subnets@2023-04-01' = [for i in range(0,4): {
  parent: vnet
  name: '${snetName}-0${i}'
  properties: {
    addressPrefix: '10.1.${i}.0/24'
  }
}]
