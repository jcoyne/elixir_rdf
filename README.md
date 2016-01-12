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


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

1. Add elixir_rdf to your list of dependencies in `mix.exs`:

       def deps do
         [{:elixir_rdf, "~> 0.0.1"}]
       end

2. Ensure elixir_rdf is started before your application:

        def application do
          [applications: [:elixir_rdf]]
        end

