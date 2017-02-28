defmodule Messages do

  def send() do
    send self(), {:text_message, "Hello me!"}
  end

  def read() do

    receive do
      {:text_message, message} -> IO.write("Got the message: #{message}\n")
    after
      500 -> IO.write ("No messages waiting\n'")
    end

  end
end