defmodule RDFTest do
  use ExUnit.Case
  doctest RDF

  test "load ttl" do
    {:ok, graph} = RDF.load("samples/sample5.ttl")
    assert length(Map.keys(graph)) == 2
    assert length(graph.prefixes) == 2
    IO.inspect(graph.prefixes)
    assert elem(List.first(graph.prefixes), 0) == 'frbr'
    assert length(graph.subjects) == 3
    IO.inspect(graph.subjects)
  end
end
