defmodule Spawn do
  def run() do
    spawn(fn -> IO.write "hello from process one (id: #{inspect self()})\n" end)
    spawn(fn -> IO.write "hello from process two (id: #{inspect self()})\n" end)
  end
end