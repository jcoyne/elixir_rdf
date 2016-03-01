defmodule RDFTest do
  use ExUnit.Case
  doctest RDF

  test "load ttl" do
    {:ok, graph} = RDF.load("samples/sample5.ttl")
    assert length(graph) == 5
  end
end
