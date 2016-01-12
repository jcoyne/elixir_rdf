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
[{'<http://www.w3.org/2001/sw/RDFCore/ntriples/>', '<http://purl.org/dc/elements/1.1/creator>', '"Dave Beckett"'}, {'<http://www.w3.org/2001/sw/RDFCore/ntriples/>', '<http://purl.org/dc/elements/1.1/creator>', '"Art Barstow"'}, {'<http://www.w3.org/2001/sw/RDFCore/ntriples/>', '<http://purl.org/dc/elements/1.1/publisher>', '<http://www.w3.org/>'}]
```
