defmodule RDF.Graph do
    require Record
    Record.defrecord :graph, [prefixes: [], triples: []]

    def query(target, %{}) do
      IO.inspect target
      graph(target, :triples)
    end

    # This builds an index, but it's not clear that it's actually helpful to have off the bat
    def by_subject_and_predicate(triple_list) do
      # This ends up reversing the order of the list, nbd, but noteable.
      by_subject = Enum.group_by(triple_list, fn(triple) -> elem(triple, 0) end )
      # TODO could this be done lazily?
      Map.new(by_subject, fn({subject, triple_list}) ->
                            { subject, by_predicate(triple_list) }
                          end
             )
    end

    defp by_predicate(triple_list) do
      by_predicate = Enum.group_by(triple_list, fn(triple) -> elem(triple, 1) end )
      Map.new(by_predicate, fn({predicate, triple_list}) ->
                              { predicate, collect_objects(triple_list) }
                            end
             )
    end

    defp collect_objects(triple_list) do
      MapSet.new(triple_list, fn(triple) -> elem(triple, 2) end )
    end
end
