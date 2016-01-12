defmodule RDF do
  def parse_ntriples(content) do
    {:ok, tokens, _} = content |> String.to_char_list |> :ntriples.string
    IO.puts inspect tokens
    {:ok, result } = :ntriples_parser.parse(tokens)
    IO.puts inspect result
  end
end
