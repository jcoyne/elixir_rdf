defmodule RDF do
  def parse_ntriples(content) do
    {:ok, tokens, _} = content |> String.to_char_list |> :ntriples.string
    IO.puts inspect tokens
    {:ok, result } = :ntriples_parser.parse(tokens)
    IO.puts inspect result
  end

  def main(argv), do: argv |> parse_args |> process

  def parse_args([]) do
    :help
  end

  # Returns a filename
  def parse_args(args) do
    List.first(args)
  end

  def process(:help) do
    IO.puts "Usage: elixir parser.exs <filename>"
    exit({:shutdown, 1})
  end

  def process(filename) do
    case File.read(filename) do
      {:ok, contents} ->
        IO.puts inspect parse_ntriples(contents)
      {:error, reason} ->
        IO.puts "Error: #{reason}"
        exit({:shutdown, 1})
    end
  end

end
