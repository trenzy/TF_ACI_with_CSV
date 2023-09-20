locals {
  # Load in data to be used as a list with csvdecode. test then uses a for
  # for loop to read in the data from the csv file that can be used by
  # the different Terraform Resources.

  tenant_csv = csvdecode(file("./local.csv"))
  test       = { for r in local.tenant_csv : r.tenant => r }
}
