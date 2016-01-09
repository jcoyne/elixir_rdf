# A rudimentary parser for NTriples RDF

## To run:

```
elixir parser.exs sample.nt
```

Presently, it's just going to spit out a list of tokens.


## To build

```
iex> :leex.file('ntriples.xrl')
iex> c("ntriples.erl")

iex> :yecc.file('ntriples_parser.yrl')
iex> c("ntriples_parser.erl")
```

This creates `ntriples.beam` and `ntriples_parser.beam`
