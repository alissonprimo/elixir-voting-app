defmodule Election do
  defstruct(
    name: "Mayor",
    candidates: [
      Candidate.new(1, "Alisson Primo"),
      Candidate.new(2, "Hellen Primo")
    ],
    next_id: 3
  )

  def update(election, cmd) when is_binary(cmd) do
    update(election, String.split(cmd, " ", trim: true))
  end

  def update(election, ["n" <> _ | args]) do
    name = Enum.join(args, " ")
    %{election | name: name}
  end

  def update(election, ["a" <> _ | args]) do
    name = Enum.join(args, " ")
    candidate = Candidate.new(election.next_id, name)
    candidates = [candidate | election.candidates]
    %{election | candidates: candidates, next_id: election.next_id + 1}
  end

  def update(election, ["v" <> _ | args]), do: update(election, Integer.parse(List.to_string(args)))

  def update(election, {id, _}) do
    candidates = Enum.map(election.candidates, fn candidate -> maybe_increment_votes(candidate, id == candidate.id) end)
    %{election | candidates: candidates}
  end

  def update(election, _errors), do: election

  defp maybe_increment_votes(candidate, _increment_vote = true) do
    %{candidate | votes: candidate.votes + 1}
  end

  defp maybe_increment_votes(candidate, _increment_vote = false), do: candidate

  def view(election) do
    [
      view_header(election),
      view_body(election),
      view_footer()
    ]
  end

  defp view_header(election) do
    [
      "Election for: #{election.name}\n",
      "id\tvotes\tname\n",
      "------------------------------\n"
    ]
  end

  defp view_body(election) do
    candidates = Enum.sort(election.candidates, &(&1.votes >= &2.votes))
    Enum.map(candidates, fn candidate -> "#{candidate.id}\t#{candidate.votes}\t#{candidate.name}\n" end)
  end

  defp view_footer do
    "\ncommands: (n)ame <election>, (a)dd <candidate>, (v)ote <id>, (q)uit\n"
  end

end
