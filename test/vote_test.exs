defmodule VoteTest do
  use ExUnit.Case
  doctest Vote

  test "greets the world" do
    assert Vote.hello() == :world
  end
end
