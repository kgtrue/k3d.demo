import radius as radius

@description('The Radius Application ID. Injected automatically by the rad CLI.')
param application string

resource demo 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'demo'
  properties: {
    application: application
    container: {
      image: 'demo-rancher-registry:62701/demo-api-first:latest'
      ports: {
        web: {
          containerPort: 80
        }
      }
    }
  }
}
