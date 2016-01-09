# To make the :ntriples module do the following:
# iex> :leex.file('ntriples.xrl')
# iex> c("ntriples.erl")

filename = List.first(System.argv)
if filename == nil do
  IO.puts "Usage: elixir parser.exs <filename>"
  exit(1)
end

contents = case File.read(filename) do
  {:ok, contents} ->
    contents
  {:error, reason} ->
    IO.puts "Error: #{reason}"
    exit(1)
end

{:ok, tokens, _} = contents |> String.to_char_list |> :ntriples.string
IO.puts inspect tokens
{:ok, result } = :ntriples_parser.parse(tokens)
IO.puts inspect result
