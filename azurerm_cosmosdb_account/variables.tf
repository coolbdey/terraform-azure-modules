variable "name" {}
variable "rg_name" {}
variable "offer_type" {
  type        = string
  description = "(Required) Specifies the Offer Type to use for this CosmosDB Account - currently this can only be set to Standard"
  default     = "Standard"
}
variable "failover_location" {
  type    = string
  default = "westeurope"
}

variable "kind" {
  type        = string
  description = "(Optional) Specifies the Kind of CosmosDB to create - possible values are GlobalDocumentDB and MongoDB. Defaults to MongoDB. Changing this forces a new resource to be created"
  default     = "MongoDB"
}
variable "capabilities" {
  type        = list(string)
  description = "(Required) The capability to enable - Possible values are GlobalDocumentDB , AllowSelfServeUpgradeToMongo36, DisableRateLimitingResponses, EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableMongo, EnableTable, EnableServerless, MongoDBv3.4 and mongoEnableDocLevelTTL."
  default     = ["EnableMongo", "MongoDBv3.4", "AllowSelfServeUpgradeToMongo36"]
}
variable "consistency_level" {
  type        = string
  description = "(Required) The Consistency Level to use for this CosmosDB Account - can be either BoundedStaleness, Eventual, Session, Strong or ConsistentPrefix."
  default     = "BoundedStaleness"
}

variable "public_enabled" {
  type    = bool
  default = false
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}