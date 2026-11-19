extension radius
extension radiusResources

@description('The Radius environment ID, injected by rad deploy.')
param environment string

@description('Application name for the broker test.')
param applicationName string = 'event-grid-mqtt-smoke'

resource app 'Applications.Core/applications@2023-10-01-preview' = {
  name: applicationName
  properties: {
    environment: environment
  }
}

resource broker 'Radius.Resources/mqttBrokers@2025-08-01-preview' = {
  name: '${applicationName}-broker'
  properties: {
    environment: environment
    application: app.id
  }
}

output mqtt object = {
  host: broker.properties.host
  port: broker.properties.port
  protocol: broker.properties.protocol
  wsPort: broker.properties.wsPort
  wsProtocol: broker.properties.wsProtocol
  authMethod: broker.properties.authMethod
  tokenAudience: broker.properties.tokenAudience
  resourceId: broker.properties.resourceId
}
