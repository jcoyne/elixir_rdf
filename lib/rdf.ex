defmodule RDF do
  require Record
  Record.defrecord :graph, [prefixes: [], subjects: %{}]

  def parse_ntriples(content) do
    {:ok, tokens, _} = content |> String.to_char_list |> :ntriples.string
    :ntriples_parser.parse(tokens)
  end

  def parse_turtle(content) do
    {:ok, tokens, _} = content |> String.to_char_list |> :turtle.string
    :turtle_parser.parse(tokens)
  end

  def parsers, do: %{ "ttl" => &RDF.parse_turtle/1, "nt" => &RDF.parse_ntriples/1 }

  def main(argv) do
    {:ok, result} = argv |> parse_args |> process
    IO.puts inspect result
  end

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
    load(filename)
  end

  def load(filename) do
    case find_parser(filename) do
      {:ok, parser} ->
        parse(filename, parser)
      {:error, reason} ->
        IO.puts "Error: #{reason}"
        exit({:shutdown, 1})
    end
  end

  def find_parser(filename) do
    suffix = List.last String.split(filename, ~r{\.})
    cond do
      Enum.member?(["nt", "ttl"], suffix) ->
        {:ok, parsers[suffix]}
      true ->
        {:error, "No parser found for #{suffix}"}
    end
  end

  def parse(filename, parser) do
    contents = load_content(filename)
    {:ok, triple_list} = parser.(contents)
    graph = { :subject, by_subject_and_predicate(triple_list) }
    {:ok, graph}
  end

  def by_subject_and_predicate(triple_list) do
    # This ends up reversing the order of the list, nbd, but noteable.
    by_subject = Enum.group_by(triple_list, fn(triple) -> elem(triple, 0) end )
    # TODO could this be done lazily?
    Map.new(by_subject, fn({subject, triple_list}) ->
                          { subject, by_predicate(triple_list) }
                        end
           )
  end

  def by_predicate(triple_list) do
    by_predicate = Enum.group_by(triple_list, fn(triple) -> elem(triple, 1) end )
    Map.new(by_predicate, fn({predicate, triple_list}) ->
                            { predicate, collect_objects(triple_list) }
                          end
           )
  end

  def collect_objects(triple_list) do
    MapSet.new(triple_list, fn(triple) -> elem(triple, 2) end )
  end

  def load_content(filename) do
    case File.read(filename) do
      {:ok, contents} ->
        contents
      {:error, reason} ->
        IO.puts "Error: #{reason}"
        exit({:shutdown, 1})
    end
  end

end
