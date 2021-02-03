# grafana-prometheus-weather
 - metrics http://grafana-prometheus-weather.westeurope.cloudapp.azure.com:9091/metrics
 - prometheus http://grafana-prometheus-weather.westeurope.cloudapp.azure.com:9090
 - grafana http://grafana-prometheus-weather.westeurope.cloudapp.azure.com
```user/password: openweather123```

1. Clone this repo to New GitLab project.
2. Create free Azure account https://azure.microsoft.com/
3. install config utility ```az``` from https://docs.microsoft.com/ru-ru/cli/azure/install-azure-cli
4. You need to create an Azure service principal to deploy Azure VM with Terraform and GitLab.
    ```
    az login
    az ad sp create-for-rbac --name "terraform" --role Contributor --scopes /subscriptions/YOU_SUBSCRIPTION_ID --sdk-auth
    ```
5. Create Terraform backend
  ```
  az group create -g terraform -l northcentralus
  az storage account create -n tfacc -g terraform -l northcentralus --sku Standard_LRS
  az storage container create -n terraform-state --account-name tfacc
  ```
6. You need to create free account and token from openweathermap.org
    save API key

7. Open gitlab projecct. 
   Paste variables to Settings >> CI/CD >> Variables
   ```
   ARM_ACCESS_KEY: From Azure config below
   ARM_CLIENT_ID: From Azure config below
   ARM_CLIENT_SECRET: From Azure config below
   ARM_SUBSCRIPTION_ID: From Azure config below
   ARM_TENANT_ID: From Azure config below
   OW_APIKEY: OpenWeather API key from openweathermap.org
   TF_VAR_DEFAULT_SSHKEY: Your Public SSH key, if you want connect to VM avter deploy.
   TF_VAR_GITLAB_RUNNER_TOKEN: Gitlab runner install token. from GItLab Project Settings >> CI/CD >> Runners
    ```
8.  Edit some variables in gitlab-ci.yml, if you want.

9. Deploy
10. Enjoy http://grafana-prometheus-weather.westeurope.cloudapp.azure.com
11. Destroy. CI/CD >> Pipelines >>  Chose latest job and run Destroy stage
