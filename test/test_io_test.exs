defmodule TestIoTest do
  use ExUnit.Case
  require Logger
  doctest TestIo

  setup_all do
    william = String.split(File.read!("priv/pg100.txt"), "\n")
    {:ok, william: william}
  end

  test "default", context do
    william = context[:william]
    drv = Process.group_leader
    Enum.each(william, fn line ->
      spawn(fn ->
        TestIo.default(drv, line)
      end)
    end)
  end

  test "direct", context do
    william = context[:william]
    drv = Process.group_leader
    Enum.each(william, fn line ->
      spawn(fn ->
        TestIo.direct(drv, line <> "\n")
      end)
    end)
  end

  test "logger", context do
    william = context[:william]
    Enum.each(william, fn line ->
      spawn(fn ->
        Logger.debug(line <> "\n")
      end)
    end)
  end
end
