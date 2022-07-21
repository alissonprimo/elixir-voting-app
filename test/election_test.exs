defmodule ElectionTest do
  use ExUnit.Case
  doctest Election

  setup do
    %{
      election: %Election{},
      election_with_candidates: %Election{
        name: "Prefeitura de Fortaleza",
        candidates: [
          %Candidate{id: 1, name: "Roberto Cláudio", votes: 0},
          %Candidate{id: 2, name: "Luiziane Lins", votes: 0},
        ],
        next_id: 3
      }
    }
  end

  test "updating election name from a command", ctx do
    command = "name Prefeitura de Fortaleza"
    election = Election.update(ctx.election, command)
    assert election == %Election{name: "Prefeitura de Fortaleza"}
  end

  test "adding a new candidate from a command", ctx do
    command = "add Alisson Primo"
    election = Election.update(ctx.election, command)
    candidates = election.candidates

    candidate = Enum.find(candidates, fn x -> x.name == "Alisson Primo" end)
    assert candidate.name == "Alisson Primo"

  end

  test "voting for a candidate from a command", ctx do
    command = "vote 1"

    votes_before_command =
      ctx.election_with_candidates.candidates
      |> Enum.find(&(&1.id == 1))
      |> (&(&1.votes)).()

    election = Election.update(ctx.election_with_candidates, command)

    votes_after_command =
      election.candidates
      |> Enum.find(fn candidate -> candidate.id == 1 end)
      |> (&(&1.votes)).()

    assert votes_before_command + 1 == votes_after_command

  end

  test "invalid command", ctx do
    cmd = "invalid command"
    election = Election.update(ctx.election, cmd)
    assert election == {:invalid_command, ctx.election}
  end

  test "quitting the app", ctx do
    command = "quit"
    election = Election.update(ctx.election, command)
    assert election == :quit
  end

end
