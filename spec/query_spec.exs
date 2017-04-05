defmodule QuerySpec do
  use ESpec
  import RDF.IRI

  before do
    graph = RDF.load("samples/sample.json")
    {:shared, graph: graph} #saves {:key, :value} to `shared`
  end

  let :result, do: RDF.Graph.query(shared.graph, query())

  context "query matching everything" do
    let :query, do: %{}
    it do: expect(Enum.count(result())).to eq(3)
  end

  context "query by subject" do
    context "with a match" do
      let :query, do: %{subject: iri(resource: "http://me.example.com")}

      it do: expect(Enum.count(result())).to eq(3)
    end

    context "with no match" do
      let :query, do: %{subject: iri(resource: "http://me.com")}

      it do: expect(Enum.count(result())).to eq(0)
    end
  end

  context "query by predicate" do
    let :query, do: %{predicate: RDF.type()}

    it do: expect(Enum.count(result())).to eq(1)
  end

  context "query by predicate and object" do
    context "with a match" do
      let :query, do: %{predicate: RDF.type(), object: iri(resource: "http://xmlns.com/foaf/0.1/Person")}

      it do: expect(Enum.count(result())).to eq(1)
    end

    context "with no match" do
      let :query, do: %{predicate: RDF.type(), object: iri(resource: "http://xmlns.com/foaf/0.1/Group")}

      it do: expect(Enum.count(result())).to eq(0)
    end
  end
end
