Nonterminals lines triples predicateObjectList objectList subject predicate object verb iri PrefixedName prefix.
Terminals colon semicolon p_leader pn_chars uriref string eoln.
Rootsymbol lines.

lines -> triples : ['$1'].
lines -> prefix lines : ['$1'|'$2'].
lines -> triples lines : ['$1'|'$2'].

objectList -> object : ['$1'].
verb -> predicate : '$1'.
predicate -> iri : '$1'.
predicateObjectList -> verb objectList semicolon : makeObjectList('$1', '$2').
triples -> subject predicateObjectList : make_triples('$1', '$2').
subject -> iri : '$1'.
object -> string : extract_token('$1') .
prefix -> p_leader pn_chars colon uriref eoln : { prefix, extract_token('$2'), extract_token('$4') } .
PrefixedName -> pn_chars colon pn_chars : prefixed_name(extract_token('$1'), extract_token('$3')).
iri -> PrefixedName : '$1'.
iri -> uriref : extract_token('$1') .

Erlang code.

extract_token({_Token, _Line, Value}) -> Value.

makeObjectList(Verb, List) -> lists:map(fun(X) -> { Verb, X } end, List) .
make_triples(Subject, List) -> { triples, lists:map(fun(X) -> { Subject, X } end, List) } .

prefixed_name(Prefix, Postfix) -> { prefixed, Prefix, Postfix } .
