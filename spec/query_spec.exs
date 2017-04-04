defmodule QuerySpec do
  use ESpec


  before do
    graph = RDF.load("samples/sample.json")
    {:shared, graph: graph} #saves {:key, :value} to `shared`
  end

  context "query by predicate" do
    let :query, do: RDF.Graph.query(shared.graph, %{})

    it do: expect(Enum.count(query())).to eq(3)
  end
end
