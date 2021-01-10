# Usage: %Monitor.Http{uri: "http://www.news.com"}
# Poison.encode!(%Monitor.Http{uri: "Devin Torres"})
# Poison.decode!(~s({"uri": "Devin Torres"}), as: %Monitor.Http{})
defmodule Monitor.Http do
    #@enforce_keys [:uri]
    @derive [Poison.Encoder]
    defstruct [:uri]
end