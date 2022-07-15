defmodule Election do
  defstruct(
    name: "Mayor",
    candidates: [
      Candidate.new(1, "Alisson Primo"),
      Candidate.new(2, "Hellen Primo")
    ],
    next_id: 3
  )
end
