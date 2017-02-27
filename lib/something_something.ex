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
    worker_one = spawn_link(Worker, :start, [:worker_one])
    worker_two = spawn_link(Worker, :start, [:worker_two])
    listen(worker_one, worker_two)
  end

  defp listen(worker, next_worker) do
    receive do
      message -> send worker, message
    end
    listen(next_worker, worker)
  end


end