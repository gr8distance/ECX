defmodule EcxTest do
  use ExUnit.Case
  doctest Ecx

  test "greets the world" do
    assert Ecx.hello() == :world
  end
end
