defmodule Spawn do
  def run() do
    spawn(fn -> IO.write "hello from process one\n" end)
    spawn(fn -> IO.write "hello from process two\n" end)
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