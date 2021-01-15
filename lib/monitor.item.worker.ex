defmodule MonitorItemWorker do
  use GenServer

  def start_link([name, url]) do
    GenServer.start_link(__MODULE__, [name, url])
  end

  def init([name, url]) do
    send(self(), :deploy_student_repo)
    {:ok,
      %{
        name: name, url: url
      }
    }
  end

  def handle_info(:deploy_student_repo, state) do
    case Http.Check.Core.process_by_url(state.url) do
      :ok ->
          GenServer.cast(self(), {:success})
      :error ->
          GenServer.cast(self(), {:failure})
          #IO.puts "we did not succeed"
    end
    {:noreply, state}
  end

  def success(student_repo_worker_pid, student_repo) do
    GenServer.cast(student_repo_worker_pid, {:success, student_repo})
  end

  def failure(student_repo_worker_pid, error) do
    GenServer.cast(student_repo_worker_pid, {:failure, error})
  end

  def handle_cast({:success}, state) do
    #IO.puts "in am in sucess message" <> state.name
    # TODO store a success entry in status success history table
    #Notify.Core.send_notification state.name, "up"
    {:stop, :done, state}
  end

  def handle_cast({:failure}, state) do
    # TODO store a failure entry in status failure history table
    #IO.puts "in am in failure message" <> state.name
    Notify.Core.send_notification state.name, "down"
    {:stop, :done, state}
  end

  def terminate(reason, state) do
      :ok
  end
end