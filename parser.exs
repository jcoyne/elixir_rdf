# To make the :ntriples module do the following:
# iex> :leex.file('ntriples.xrl')
# iex> c("ntriples.erl")

filename = List.first(System.argv)
if filename == nil do
  IO.puts "Usage: elixir parser.exs <filename>"
  exit({:shutdown, 1})
end

contents = case File.read(filename) do
  {:ok, contents} ->
    contents
  {:error, reason} ->
    IO.puts "Error: #{reason}"
    exit(:normal)
end

Code.eval_file('lib/elixir_rdf.ex')

IO.puts inspect RDF.parse_ntriples(contents)
