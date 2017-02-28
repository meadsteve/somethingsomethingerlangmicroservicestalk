defmodule SpawnALot do
  def run() do
    1..10_000
    |> Enum.map(fn n -> spawn(fn -> IO.write "hello from process #{n}\n" end) end)
  end
end