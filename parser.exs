# To make the :ntriples module do the following:
# iex> :leex.file('ntriples.xrl')
# iex> c("ntriples.erl")

[filename] = System.argv
contents = case File.read(filename) do
  {:ok, contents} ->
    contents
  {:error, reason} ->
    IO.puts "Error: #{reason}"
    exit(1)
end

{:ok, tokens, _} = :ntriples.string(to_char_list contents)
IO.puts inspect tokens
