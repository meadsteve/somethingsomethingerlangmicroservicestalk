defmodule Spawn do
  def run() do
    spawn(fn -> IO.write "hello from process one\n" end)
    spawn(fn -> IO.write "hello from process two\n" end)
  end
end