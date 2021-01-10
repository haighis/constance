# Functional Core
# A Notify libary that is developed as a functional core. 
# 
# Design
# The Notify library uses sendgrid
#
# Usage
# Notify.Core.send_notification "uri http", "up"
# Notify.Core.send_notification "uri http", "down"
defmodule Notify.Core do
    
    @from "haighis@gmail.com"
    def send_notification(monitor,status) do
        # TODO add/get to/from/body from configuration db table
        SendGrid.Email.build() |> 
        SendGrid.Email.add_to("haighis@gmail.com") |> 
        SendGrid.Email.put_from("jhaigh@versosys.com") |> 
        SendGrid.Email.put_subject("Constance Notification - #{monitor} is #{status}") |> 
        SendGrid.Email.put_text("Hello,\n\nPlease note the #{monitor} monitor is #{status}. \n\n Thank You,\n\n Constance Team\n\n") |> 
        SendGrid.Mail.send()
    end
end