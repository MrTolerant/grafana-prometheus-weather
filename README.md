# grafana-prometheus-weather

<h2>Fully automated</h2>

 Deploy from Gitlab CI:
  - Create a virtual machine in Azure with Terraform
  - Cloud init script configures the virtual machine and installs: docker, docker-compose, gitlab runner.
  - Deploy docker compose through the created gitlab runner in cloud-init

Urls:
 - metrics `http://<TF_VAR_VM_DOMAIN_NAME>.<TF_VAR_LOCATION>.cloudapp.azure.com:9091/metrics`
 - prometheus `http://<TF_VAR_VM_DOMAIN_NAME>.<TF_VAR_LOCATION>.cloudapp.azure.com:9090`
 - grafana `http://<TF_VAR_VM_DOMAIN_NAME>.<TF_VAR_LOCATION>.cloudapp.azure.com`
```user/password: openweather123```

1. Clone this repo to New GitLab project.
2. Create free Azure account https://azure.microsoft.com/
3. Install Azure config utility ```az``` from https://docs.microsoft.com/ru-ru/cli/azure/install-azure-cli
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
6. You need to create OpenWeather free account at https://openweathermap.org/. And get API token from https://home.openweathermap.org/api_keys

7. Open gitlab projecct.
   Paste variables to Settings >> CI/CD >> Variables
   ```
   ARM_ACCESS_KEY: From Azure config abowe
   ARM_CLIENT_ID: From Azure config abowe
   ARM_CLIENT_SECRET: From Azure config abowe
   ARM_SUBSCRIPTION_ID: From Azure config abowe
   ARM_TENANT_ID: From Azure config abowe
   OW_APIKEY: OpenWeather API key from openweathermap.org
   TF_VAR_DEFAULT_SSHKEY: Your Public SSH key, if you want connect to VM after deploy.
   TF_VAR_GITLAB_RUNNER_TOKEN: Gitlab runner install token. from GItLab Project Settings >> CI/CD >> Runners
    ```
8.  Edit some variables in gitlab-ci.yml, if you want.
  ```
    TF_VAR_VM_DOMAIN_NAME: grafana-prometheus-weather // You Azure VM domain name
    TF_VAR_VM_NAME: TestVM    // Azure VM name
    TF_VAR_VM_ADMIN: azure-admin  // Azure VM admin login name
    TF_VAR_LOCATION: West Europe  // VM Location
    OW_CITY: Tallin       // City for scrapping weather
    OW_DEGREES_UNIT: C  // Degrees unit. C(elsius), F(ahrenheit)
  ```
9. Deploy
10. Enjoy `http://<TF_VAR_VM_DOMAIN_NAME>.<TF_VAR_LOCATION>.cloudapp.azure.com`
    example: http://grafana-prometheus-weather.westeurope.cloudapp.azure.com/
11. Destroy. CI/CD >> Pipelines >>  Chose latest job and run Destroy stage

Repository structure:
```
.
├── README.md
├── docker
│   ├── docker-compose.yml
│   ├── grafana
│   │   ├── grafana.ini
│   │   └── provisioning
│   │       ├── dashboards
│   │       │   ├── dashboard.yml
│   │       │   └── open_weather_map.json
│   │       └── datasources
│   │           └── datasource.yml
│   └── prometheus
│       └── prometheus.yml
└── terraform
    ├── cloudinit.yml
    ├── main.tf
    ├── outputs.tf
    ├── providers.tf
    ├── variables.tf
    └── vm.tf

```
