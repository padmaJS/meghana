defmodule MeghanTest do
  use ExUnit.Case
  doctest Meghan

  test "greets the world" do
    assert Meghan.hello() == :world
  end
end
