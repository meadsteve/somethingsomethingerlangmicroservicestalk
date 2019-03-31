defmodule SomeServer do
  use GenServer

  def start_link(state \\ :starting_state, opts \\ []) do
    IO.write("SomeServer is starting up\n")
    GenServer.start_link(__MODULE__, state, opts)
  end

  #### SERVER CALLBACKS
  def init(state) do
    {:ok, state}
  end

  def handle_call(:hello, _from, state) do
    {:reply, :waves_back, state}
  end

  def handle_call(:whats_your_state, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:new_state, new_state}, _state) do
    {:noreply, new_state}
  end

  def handle_cast(:kill, state) do
    Process.exit(self(), :kill)
    {:noreply, state}
  end

end