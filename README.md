# grafana-prometheus-weather
http://grafana-prometheus-weather.westeurope.cloudapp.azure.com:9091/metrics
http://grafana-prometheus-weather.westeurope.cloudapp.azure.com:9090
http://grafana-prometheus-weather.westeurope.cloudapp.azure.com:3000

1. You need to create an Azure service principal to run Terraform in GitHub Actions.
    ```
    az login
    az ad sp create-for-rbac --name "terraform" --role Contributor --scopes /subscriptions/YOU_SUBSCRIPTION_ID --sdk-auth
    ```
    save creds
2. Create Terraform backend
  ```
  az group create -g terraform -l northcentralus
  az storage account create -n tfacc -g terraform -l northcentralus --sku Standard_LRS
  az storage container create -n terraform-state --account-name tfacc
  ```
3. You need to create free account and token from openweathermap.org
    save API key
