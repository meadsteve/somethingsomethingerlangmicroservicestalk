defmodule SpawnALot do
  def run() do
    1..10_000 |> Enum.map(fn n -> spawn(fn ->
      :timer.sleep(:rand.uniform(100))
      IO.write "hello from process #{n}\n" end)
    end)
    :ok
  end
end