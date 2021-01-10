# Constance

A desktop network monitor.

## Installing

- Install dependencies with `mix deps.get`

## Running 

```
iex -S mix 
```

## Running GenServer

```
iex -S mix 
```

## Running Phoenix server

- Install Node.js dependencies with `npm install` inside the `assets` directory
- Start Phoenix endpoint with `mix phx.server`
- Save a key/value by making a POST request to http://localhost:4000/api/keyvalues
```
wget --quiet \
  --method POST \
  --header 'Content-Type: application/json' \
  --body-data '{"key": "2","value": "kelton"}' \
  --output-document \
  - http://localhost:4000/api/keyvalues
```

- Get a value for key by making a GET request to http://localhost:4000/api/keyvalues

```
wget --quiet \
  --method GET \
  --header 'Content-Type: application/json' \
  --output-document \
  - http://localhost:4000/api/keyvalues/2
```

## Running Unit Tests

`mix test`