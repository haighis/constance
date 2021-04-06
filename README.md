# Constance

A personal desktop network monitor. This library uses patterns functional core and boundary layer.

## Installing

- Setup a postgres database server
- Install dependencies with `mix deps.get`
- Install Node.js dependencies with `npm install` inside the `assets` directory
- Run `mix ecto.create mix ecto.migrate` 
- Run `mix run priv/repo/seeds.exs`
- Run `iex -S mix phx.server` or `mix phx.server`
- By default Constance has default empty settings
- Download Constance Postman Collection for all Setup/Monitors/Settings API Resources
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

## Running in Development

```
iex -S mix phx.server

```

## Building a self executing Release and running a Release

```sh
export MIX_ENV=prod
mix setup
mix release
./constance
```
