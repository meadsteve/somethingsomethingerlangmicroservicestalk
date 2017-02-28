defmodule BetterWorker do

  def start(name) do
    work(name)
  end

  defp work(name) do
    receive do
      :corrupt_payload -> Process.exit(self(), :kill)
      payload -> IO.write("Worker `#{name}` got the work: #{payload}\n")
    end
    work(name)
  end
end

defmodule BetterLoadBalancer do

  def start_link() do
    spawn_link(BetterLoadBalancer, :init, [])
  end

  def init do
    {worker_one, _ref} = spawn_monitor(BetterWorker, :start, ["worker one"])
    {worker_two, _ref} = spawn_monitor(BetterWorker, :start, ["worker two"])
    listen(worker_one, worker_two)
  end

  defp listen(worker, other_worker) do
    receive do
      {:DOWN, _, :process, ^worker, _} ->
        IO.inspect("One of the workers has stopped")
        listen(other_worker, start_new_worker())
      {:DOWN, _, :process, ^other_worker, _} ->
        IO.inspect("One of the workers has stopped")
        listen(worker, start_new_worker())
      message ->
        send worker, message
        listen(other_worker, worker)
    end
  end

  defp start_new_worker() do
    {worker, _ref} = spawn_monitor(BetterWorker, :start, ["some restated worker"])
    worker
  end


end