defmodule Election do
  defstruct(
    name: "Mayor",
    candidates: [
      Candidate.new(1, "Alisson Primo"),
      Candidate.new(2, "Hellen Primo")
    ],
    next_id: 3
  )

  def view(election) do
    [
      view_header(),
      view_body(election),
      view_footer()
    ]
  end

  defp view_header do
    [
      "id\tvotes\tname\n",
      "------------------------------\n"
    ]
  end

  defp view_body(election) do
    Enum.map(election.candidates, fn candidate -> "#{candidate.id}\t#{candidate.votes}\t#{candidate.name}\n" end)
  end

  defp view_footer do
    "\ncommands: (n)ame <election>, (a)dd <candidate>, (v)ote <id>, (q)uit\n"
  end


end
