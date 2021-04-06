SqliteMonitor.Repo.insert(%SqliteMonitor.Model.Setting{key: "scheduler_interval", value: "5"}) # Run scheduler every 5 minutes
SqliteMonitor.Repo.insert(%SqliteMonitor.Model.Setting{key: "slack_apikey", value: ""}) # empty slack api key
SqliteMonitor.Repo.insert(%SqliteMonitor.Model.Setting{key: "sendgrid_apikey", value: ""}) # empty sendgrid api key
SqliteMonitor.Repo.insert(%SqliteMonitor.Model.Setting{key: "slack_notifications_enabled", value: "false"}) # slack notifications are disabled by default
SqliteMonitor.Repo.insert(%SqliteMonitor.Model.Setting{key: "notifications_enabled", value: "false"}) # all notifications are disabled by default. This also disables the scheduler from running.
SqliteMonitor.Repo.insert(%SqliteMonitor.Model.Setting{key: "email_from_address", value: ""}) # empty sendgrid email from address
SqliteMonitor.Repo.insert(%SqliteMonitor.Model.Setting{key: "email_to_address", value: ""}) # empty sendgrid email to address
