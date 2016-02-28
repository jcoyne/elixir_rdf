# A rudimentary parser for NTriples RDF

## To build

```
$ mix escript.build
```

## To run:

```
./elixir_rdf sample.nt
```

Presently, it's just going to spit out a list of triples.

```
[{'<http://www.w3.org/2001/sw/RDFCore/ntriples/>', '<http://purl.org/dc/elements/1.1/creator>', '"Dave Beckett"'},
{'<http://www.w3.org/2001/sw/RDFCore/ntriples/>', '<http://purl.org/dc/elements/1.1/creator>', '"Art Barstow"'},
{'<http://www.w3.org/2001/sw/RDFCore/ntriples/>', '<http://purl.org/dc/elements/1.1/publisher>', '<http://www.w3.org/>'}]
```


## Developing the turtle parser

```
iex> :leex.file('src/turtle')
{:ok, 'src/turtle.erl'}

iex> c("src/turtle.erl")
[:turtle]

iex> :yecc.file('src/turtle_parser.yrl')
{:ok, 'src/turtle_parser.erl'}

iex> c("src/turtle_parser.erl")
[:turtle_parser]

iex> {:ok, source} = File.read('basic.ttl')
{:ok,
 "@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .\n@prefix dc: <http://purl.org/dc/elements/1.1/> .\n@prefix ex: <http://example.org/stuff/1.0/> .\n"}

iex> {:ok, tokens, _} = source |> String.to_char_list |> :turtle.string
{:ok,
 [{:"@prefix", 1}, {:pn_chars, 1, 'rdf'}, {:colon, 1},
  {:uriref, 1, '<http://www.w3.org/1999/02/22-rdf-syntax-ns#>'}, {:eoln, 1},
  {:"@prefix", 2}, {:pn_chars, 2, 'dc'}, {:colon, 2},
  {:uriref, 2, '<http://purl.org/dc/elements/1.1/>'}, {:eoln, 2},
  {:"@prefix", 3}, {:pn_chars, 3, 'ex'}, {:colon, 3},
  {:uriref, 3, '<http://example.org/stuff/1.0/>'}, {:eoln, 3}], 4}

iex> :turtle_parser.parse(tokens)
```

{:ok, source} = File.read('sample3.ttl')
{:ok, tokens, _} = source |> String.to_char_list |> :turtle.string
