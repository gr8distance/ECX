defmodule EntityTest do
  use ExUnit.Case
  doctest Entity

  test "greets the world" do
    assert Entity.hello() == :world
  end
end
