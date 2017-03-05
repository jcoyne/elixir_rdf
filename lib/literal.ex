defmodule RDF.Literal do
  require Record
  Record.defrecord :literal, [value: "", lang: nil]
end
