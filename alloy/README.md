[alloy](https://grafana.com/docs/alloy/latest/) bundles collectors together in one application.

This directory is made up of:

```
config.alloy
docker-compose.yml
```
At a minimum, edit config.alloy and replace LOKI_IP and LOKI_PORT with the IP address and port number of your Loki instance.

The docker-compose.yml can be brought up in a detached state using the command:

```
docker compose up -d
```
It will then read configuration from the config.alloy file. 
