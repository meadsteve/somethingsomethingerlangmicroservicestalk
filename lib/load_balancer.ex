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