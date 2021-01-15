# Constance

A personal desktop network monitor. This library uses patterns functional core and boundary layer.

## Installing

- Install dependencies with `mix deps.get`
- Install Node.js dependencies with `npm install` inside the `assets` directory
- Run `iex -S mix` or `mix phx.server`
- Setup Constance by running Setup REST API endpoint to configure API Keys, notifications and email addresses.
```
wget --quiet \
  --method POST \
  --header 'Content-Type: application/json' \
  --body-data '{"slack_apikey": "SOME_KEY","sendgrid_apikey": "SOME_KEY","notifications_enabled": "true", "email_notifications_enabled": "false","slack_notifications_enabled": "true","email_from_address": "SOME_EMAIL_ADDRESS","email_to_address": "SOME_EMAIL_ADDRESS" }' \
  --output-document \
  - http://localhost:4000/api/monitors
```
- A Slack channel called constance-app-alerts is required for Slack notifications
- Save a Monitor by making a POST request to http://localhost:4000/api/monitors

```
wget --quiet \
  --method POST \
  --header 'Content-Type: application/json' \
  --body-data '{"name": "Sample Site","type": "httpv1","interval": "15","url": "http://www.github.com" }' \
  --output-document \
  - http://localhost:4000/api/monitors
```

## Running in Development

```
iex -S mix 

```
