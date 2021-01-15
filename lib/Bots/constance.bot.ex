# This bot is not complete and is for learning
# defmodule ConstanceBot do
#   use Slack

#   def handle_event(message = %{type: "message"}, slack, state) do
#     if message.text == "Hi" do
#       send_message("Hello to you too!", message.channel, slack)
#     end

#     {:ok, state}
#   end
#   def handle_event(_, _, state), do: {:ok, state}
# end
# {:ok, server} = Cache.Server.start_link("test",5)
# Cache.Server.put server, "1", "test"
# Cache.Server.get server, "1"
# Cache.Server.stop server
# Start GenServer by Name 
# Cache.Server.start_link(cache_name: "test", cache_capacity: 5, name: :mycache)
# GenServer.cast(:mycache,{:put, 1,1})
# GenServer.call(:mycache,{:get, 1}) 
# Slack.Bot.start_link(ConstanceBot, [], "", name: :bot) 
#{:ok, server} = Slack.Bot.start_link(ConstanceBot, [], "", name: :bot) 
# {:ok, server} = Slack.Bot.start_link(ConstanceBot, [], "", name: :bot) 
# GenServer.cast(:bot,{:message, "test","general"})
# GenServer.call(:bot,{:message, "test","general"})
defmodule ConstanceBot do
  use Slack

    def start_link(opts) do
        IO.puts "in in start link for bot"
        name = opts[:name]
        GenServer.start_link(__MODULE__, [], name: name) 
    end

    def init(init_arg) do
      {:ok, init_arg}
    end

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    send_message("I got a !", message.channel, slack)
    {:ok, state}
  end
  def handle_event(_, _, state), do: {:ok, state}

    
    def send(pid, text, channel), do: GenServer.cast(pid, {:send_message, text, channel})
    #def put(pid, key,value), do: GenServer.cast(pid, {:put, key, value})

   def handle_cast({:send_message, text, channel},slack,state) do
        IO.puts "i am in in send message"
        send_message(text, channel, slack)
        {:noreply, state}
    end 

  def handle_info({:message, text, channel}, slack, state) do
    IO.puts "Sending your message, captain!"

    send_message(text, channel, slack)

    {:ok, state}
  end

  def handle_info(_, _, state), do: {:ok, state}
end
