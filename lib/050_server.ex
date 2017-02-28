defmodule SomeServer do
  use GenServer

  def start_link(state, opts \\ []) do
    IO.write("SomeServer is starting up\n")
    GenServer.start_link(__MODULE__, state, opts)
  end

  #### SERVER SIDE
  def handle_call(:hello, _from, state) do
    {:reply, :waves_back, state}
  end

  def handle_cast(:kill, state) do
    Process.exit(self(), :kill)
    {:noreply, state}
  end

end