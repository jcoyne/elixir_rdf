# To make the :ntriples module do the following:
# iex> :leex.file('ntriples.xrl')
# iex> c("ntriples.erl")

{:ok, tokens, _} = :ntriples.string('<http://foo.bar> <http://bar.gz> <http://foo.com>')
IO.puts inspect tokens
