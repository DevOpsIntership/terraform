rg="test"
SqlServerName = "adkwolekdbterraform"
SqlDbName = "mydb"
sku = "S0"

FirewallRules = [ {
  end_ip_address = "89.151.39.134"
  name = "Rule1"
  start_ip_address = "89.151.39.134"
},
{
  end_ip_address = "89.151.39.135"
  name = "Rule2"
  start_ip_address = "89.151.39.135"
}
 ]

monthly_retention = "P1W"
yearly_retention = "P1W"
weekly_retention = "P1W"
week_of_year =1

retention_days = 7


AppServiePlanName = "MyPlanTerraformTest"
AppServiceName = "MyAppTerraformTest"
tier = "P1v2"
worker = 2
dockerimage = "docker/getting-started"

Storage = "terraformadam980220"
account_tier = "Standard"
account_replication_type = "LRS"
container_name = "backup"