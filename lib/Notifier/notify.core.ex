# Functional Core
# A Notify libary that is developed as a functional core. 
# 
# Design
# The Notify library uses sendgrid and slack
# If a notification for sendgrid or slack is enabled (stored in Settings) then the notification method is used
# There is a fail safe in monitor.scheduler.ex to turn off all notifications from being sent
#
# This library could be enhanced to be a gen_server that would get all the Settings below in an init method, then store
# them in state and then pass the setting down to this core library as values rather than going to the db each time this 
# library is called. Its an embedded sqlite db and we don't have alot of load so for now this will work.
# This concept is a huge learning. Leaving this perf issues is a learning point and serves to show this learning. 
# Not going to the db each time you want some value and getting this from a genserver state doesn't seem like a big deal
# but what if this notification library is called 10,000 times a second? In this case getting these values from a state
# in a genserver is going to be more performing then going to the db each time.
# Usage
# Notify.Core.send_notification "uri http", "up"
# Notify.Core.send_notification "uri http", "down"
defmodule Notify.Core do
    def send_notification(monitor,status) do
        message = "Constance Notification - #{monitor} is #{status}"
        slack_api_key = Setting.Core.get_by_key("slack_api_key")

        is_slack_enabled = Setting.Core.get_by_key("slack_notifications_enabled")
        if is_slack_enabled.value == "true" do 
            IO.puts "slack is enabled" <> message
            Slack.Web.Chat.post_message("constance-app-alerts",message,%{token: slack_api_key.value})
        end
        is_email_enabled = Setting.Core.get_by_key("email_notifications_enabled")
        if is_email_enabled.value == "true" do
            from_email = Setting.Core.get_by_key("email_from_address").value
            to_email = Setting.Core.get_by_key("email_to_address").value
            SendGrid.Email.build() |> 
            SendGrid.Email.add_to(to_email) |> 
            SendGrid.Email.put_from(from_email) |> 
            SendGrid.Email.put_subject(message) |> 
            SendGrid.Email.put_text("Hello,\n\nPlease note the #{monitor} monitor is #{status}. \n\n Thank You,\n\n Constance\n\n") |> 
            SendGrid.Mail.send()
        end
    end
end