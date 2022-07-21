defmodule ElectionTest do
  use ExUnit.Case
  doctest Election

  setup do
    %{election: %Election{}}
  end

  test "updating election name from a command", ctx do
    command = "name Will Farrel"
    election = Election.update(ctx.election, command)
    assert election == %Election{name: "Will Farrel"}
  end

  test "adding a new candidate from a command", ctx do
    command = "add Alisson Primo"
    election = Election.update(ctx.election, command)

  end

  test "voting for a candidate from a command", ctx do

  end

  test "invalid command", ctx do

  end

  test "quiting the app" do

  end

end
