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

dashboards_tagged = 0
dashboards_untagged = 0
dashboards_terraform_managed = 0

for item in response_content["items"]:
	if item.get("kind") == "Dashboard":
	    dashboard_name = item.get("metadata", {}).get("name")
	    dashboard_tags = item.get("spec",{}).get("tags", [])
	if dashboard_tags == []:
	    dashboards_untagged +=1
	if "TERRAFORM-MANAGED" in dashboard_tags:
	    dashboards_terraform_managed +=1
	    dashboards_tagged +=1
	else:
	    dashboards_tagged +=1

print("Tagged:" + str(dashboards_tagged))
print("Untagged:" + str(dashboards_untagged))
print("Managed:" + str(dashboards_terraform_managed))
