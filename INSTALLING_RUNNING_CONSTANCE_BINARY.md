## Installing & Running Constance binary

- Download a Constance Release
- Extract Linux or MacOS download
- Run Constance from command line via `./constance`
- By default Constance is not configured and must be setup
- Setup Constance by running Setup REST API endpoint to configure API Keys, notifications and email addresses.
```
wget --quiet \
  --method POST \
  --header 'Content-Type: application/json' \
  --body-data '{"scheduler_interval": "5", "slack_apikey": "SOME_KEY","sendgrid_apikey": "SOME_KEY","notifications_enabled": "true", "email_notifications_enabled": "false","slack_notifications_enabled": "true","email_from_address": "SOME_EMAIL_ADDRESS","email_to_address": "SOME_EMAIL_ADDRESS" }' \
  --output-document \
  - http://localhost:4000/api/setup
```
- Determine the scheduler interval you would like and then stop Constance. Constance isn't able to see the new scheduler_interval value until after a restart
- Start Constance again via `./constance`
- If you would like to enable Slack Integration:
- Create a Slack bot user and capture the slack api key 
- Create a Slack channel called constance-app-alerts
- Save a Monitor by making a POST request to http://localhost:4000/api/monitors
```
wget --quiet \
  --method POST \
  --header 'Content-Type: application/json' \
  --body-data '{"name": "Sample Site","type": "httpv1","interval": "15","url": "http://www.github.com" }' \
  --output-document \
  - http://localhost:4000/api/monitors
```