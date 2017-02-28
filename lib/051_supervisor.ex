defmodule ExampleSupervisor do

  def start() do
    # Import helpers for defining supervisors
    import Supervisor.Spec

    children = [
      worker(SomeServer, [[:state], [name: MicroService]])
    ]

    {:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)

    Supervisor.count_children(pid)
  end

end