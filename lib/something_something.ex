defmodule Spawn do
  def run() do
    spawn_link(fn -> IO.write "hello from process one\n" end)
    spawn_link(fn -> IO.write "hello from process two\n" end)
  end
end

defmodule Messages do

  def send() do
    send self(), {:text_message, "Hello me!"}
  end

  def read() do

    receive do
      {:text_message, message} -> IO.write("Got the message: #{message}\n")
    after
      100 -> IO.write ("No messages waiting\n'")
    end

  end
end

defmodule Worker do

  def start(name) do
    Process.register(self(), name)
    work(name)
  end

  defp work(name) do
    receive do
      payload -> IO.write("Worker #{name} got the work: #{payload}\n")
    end
    work(name)
  end
end

defmodule LoadBalancer do

  def start_link() do
    spawn_link(LoadBalancer, :init, [])
  end

  def init do
    spawn_link(Worker, :start, [:worker_one])
    spawn_link(Worker, :start, [:worker_two])
    listen(:worker_one)
  end

  defp listen(:worker_one) do
    receive do
      message -> send :worker_one, message
    end
    listen(:worker_two)
  end

  defp listen(:worker_two) do
    receive do
      message -> send :worker_two, message
    end
    listen(:worker_one)
  end


end