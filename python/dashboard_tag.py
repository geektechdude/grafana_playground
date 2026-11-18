import json
import os
import requests
from dotenv import load_dotenv, dotenv_values

load_dotenv()

AUTH = "Bearer "+os.getenv("AUTH_TOKEN")
api_url = os.getenv("GRAFANA_ADDRESS")+"/apis/dashboard.grafana.app/v2/namespaces/default/dashboards"
headers = {"accept": "application/json", "Authorization":AUTH}

response = requests.get(api_url, headers=headers)
response_content = response.json()

dashboards_untagged_count = 0
dashboards_terraform_managed_count = 0
dashboards_terraform_managed = []
dashboards_unmanaged = []

for item in response_content["items"]:
	if item.get("kind") == "Dashboard":
	    dashboard_name = item.get("metadata", {}).get("name")
	    dashboard_tags = item.get("spec",{}).get("tags", [])
	if dashboard_tags == []:
	    dashboards_untagged_count +=1
	    dashboards_unmanaged.append(dashboard_name)
	if "TERRAFORM-MANAGED" in dashboard_tags:
	    dashboards_terraform_managed_count +=1
	    dashboards_terraform_managed.append(dashboard_name)

print("Untagged Count:" + str(dashboards_untagged_count))
print("Managed Count:" + str(dashboards_terraform_managed_count))
print("Terraform Managed: " + str(dashboards_terraform_managed))
print("Unmanaged: " + str(dashboards_unmanaged))
