extension radius
extension radiusResources

@description('The Radius environment ID, injected by rad deploy.')
param environment string

resource app 'Applications.Core/applications@2023-10-01-preview' = {
  name: 'adaptive-apps'
  properties: {
    environment: environment
  }
}

resource backendIdentity 'Radius.Resources/workloadIdentities@2025-08-01-preview' = {
  name: 'backend-identity'
  properties: {
    environment: environment
    application: app.id
    // Same input as the trading app. AKS uses the backend override from the recipe registration.
    serviceAccountName: 'default'
  }
}
