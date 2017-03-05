defmodule RDF.JsonldParser do
  alias RDF.IRI
  alias RDF.Literal
  import IRI
  import Literal

  def parse(content) do
    json = Poison.decode!(content)
    {special, terms} = Map.split(json, ["@context", "@id", "@type"])
    %{ "@id" => id,
       "@context" => context,
       "@type" => type } = special

    # TODO need to add type.
    list = Enum.map(terms, &build_triple(&1, id, context))
    {:ok, list ++ build_type(id, context, type) }
  end

  def build_type(id, context, type) do
    [{iri(resource: id),
      iri(resource: "http://www.w3.org/1999/02/22-rdf-syntax-ns#type"),
      iri(resource: Map.get(context, type))}]
  end

  def build_triple({term, value}, id, context) do
    case Map.get(context, term) do
      %{ "@id" => predicate, "@type" => "@id" } ->
        { iri(resource: id), iri(resource: predicate), iri(resource: value) }
      predicate ->
        { iri(resource: id), iri(resource: predicate), literal(value: value) }
    end
  end
end
