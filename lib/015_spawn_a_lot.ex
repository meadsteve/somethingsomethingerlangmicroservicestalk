defmodule SpawnALot do
  def run() do
    1..10_000 |> Enum.map(fn n -> spawn(fn ->
      :timer.sleep(:rand.uniform(100))
      IO.write "hello from process #{n}\n"
      n
    end) end)
    :ok
  end
end






defmodule HideTheDetails do
  def run() do
    stream = 1..100 |> Task.async_stream(fn n ->
      :timer.sleep(:rand.uniform(100))
      IO.write "hello from process #{n}\n"
      n
    end, max_concurrency: 10)

    Enum.reduce(stream, 0, fn {:ok, n}, total -> total + n end)
  end
end