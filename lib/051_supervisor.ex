defmodule ExampleSupervisor do

  def start(state \\ :starting_state) do
    # Import helpers for defining supervisors
    import Supervisor.Spec

    children = [
      worker(SomeServer, [[state], [name: :micro_service]])
    ]

    {:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)

    Supervisor.count_children(pid)
  end

end