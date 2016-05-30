defmodule TestIo do
  def default(drv, msg) do
    IO.puts(drv, msg)
  end

  def direct(drv, msg) do
    send(drv, {:io_request, self(), self(), {:put_chars, :unicode, msg}})
    :ok
  end
end
