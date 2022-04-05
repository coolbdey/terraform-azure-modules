

### Module resources
---

* https://docs.microsoft.com/en-us/azure/app-service/overview-vnet-integration
  All subnets nets to be disconnected manually, if subnets addresses needs to be changed
  It is reconmended to have at least /26 for webfarms (app service and function app) 

### Module info
---

* `enforce_private_link_endpoint_network_policies` Network policies, like network security groups (NSG), are not supported for Private Link Endpoints or Private Link Services. In order to deploy a Private Link Endpoint on a given subnet, you must set the enforce_private_link_endpoint_network_policies attribute to true. This setting is only applicable for the Private Link Endpoint, for all other resources in the subnet access is controlled based via the Network Security Group which can be configured using the azurerm_subnet_network_security_group_association resource.
* `enforce_private_link_service_network_policies` In order to deploy a Private Link Service on a given subnet, you must set the enforce_private_link_service_network_policies attribute to true. This setting is only applicable for the Private Link Service, for all other resources in the subnet access is controlled based on the Network Security Group which can be configured using the azurerm_subnet_network_security_group_association resource.

### service delegation
---

Valid service delegation names ar:
az network vnet subnet list-available-delegations --query "[*].name" -o tsv

Microsoft.Web.serverFarms
Microsoft.ContainerInstance.containerGroups
Microsoft.Netapp.volumes
Microsoft.HardwareSecurityModules.dedicatedHSMs
Microsoft.ServiceFabricMesh.networks
Microsoft.Logic.integrationServiceEnvironments
Microsoft.Batch.batchAccounts
Microsoft.Sql.managedInstances
Microsoft.Web.hostingEnvironments
Microsoft.BareMetal.CrayServers
Microsoft.Databricks.workspaces
Microsoft.BareMetal.AzureVMware
Microsoft.StreamAnalytics.streamingJobs
Microsoft.DBforPostgreSQL.serversv2
Microsoft.AzureCosmosDB.clusters
Microsoft.MachineLearningServices.workspaces
Microsoft.DBforPostgreSQL.singleServers
Microsoft.DBforPostgreSQL.flexibleServers
Microsoft.DBforMySQL.serversv2
Microsoft.DBforMySQL.flexibleServers
Microsoft.ApiManagement.service
Microsoft.Synapse.workspaces
Microsoft.PowerPlatform.vnetaccesslinks
Microsoft.Network.dnsResolvers
Microsoft.Kusto.clusters
Microsoft.DelegatedNetwork.controller
Microsoft.ContainerService.managedClusters
Microsoft.PowerPlatform.enterprisePolicies
Microsoft.StoragePool.diskPools
Microsoft.DocumentDB.cassandraClusters
Microsoft.Apollo.npu
Microsoft.AVS.PrivateClouds
Microsoft.Orbital.orbitalGateways
Microsoft.Singularity.accounts.jobs
Microsoft.Singularity.accounts.models
Microsoft.AISupercomputer.accounts.jobs
Microsoft.AISupercomputer.accounts.models
Microsoft.LabServices.labplans
Microsoft.Fidalgo.networkSettings
NGINX.NGINXPLUS.nginxDeployments

