import os
import requests
from dotenv import load_dotenv, dotenv_values

load_dotenv()

AUTH = "Bearer "+os.getenv("AUTH_TOKEN")
api_url = os.getenv("GRAFANA_ADDRESS")+"/apis/dashboard.grafana.app/v1/namespaces/default/dashboards"
headers = {"accept": "application/json", "Authorization":AUTH}

response = requests.get(api_url, headers=headers)

print(response.text)
