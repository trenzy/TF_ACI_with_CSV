### Terraform with CSV example

This example shows how you can use Terraform with data in a Comma-separated Values (CSV) file. This plan uses the 
[**csvdecode**](https://developer.hashicorp.com/terraform/language/functions/csvdecode) function to read in data from the CSV file. It also uses [**locals**](https://developer.hashicorp.com/terraform/language/values/locals) which assigns a name to an expression or value. Probably didn't need to separate it out and could have included it in one of the other .tf files.

We then use the **for_each** meta-argument in each resource to read in and leverage the data read from the CSV file.

In this example, we're just reading in data for Multiple Tenants, VRFs, etc and configuring them. I will post an example in which we can use this to provision multiple ports within an EPG.

This was tested on Terraform version 1.5.5 and ACI provider 2.10.1.