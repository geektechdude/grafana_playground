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

for item in response_content["items"]:
	if item.get("kind") == "Dashboard":
	    dashboard_name = item.get("metadata", {}).get("name")
	    dashboard_tags = item.get("spec",{}).get("tags", [])
	    print(dashboard_name)
	    print(dashboard_tags)
