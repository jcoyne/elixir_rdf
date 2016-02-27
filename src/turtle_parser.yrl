Nonterminals
  turtleDoc statement directive triples predicateObjectList objectList
  verb subject predicate object literal blankNodePropertyList prefixID
  iri PrefixedName .

Terminals
  colon semicolon p_leader pn_chars uriref string eoln l_bracket r_bracket.

Rootsymbol
  turtleDoc.

turtleDoc ->
  turtleDoc statement : ['$1'|'$2'] .
turtleDoc ->
  statement : ['$1'] .

statement ->
  triples eoln : '$1' .
statement ->
  directive : '$1' .

directive ->
  prefixID : '$1' .

triples ->
  subject predicateObjectList : make_triples('$1', '$2') .

predicateObjectList ->
  predicateObjectList semicolon verb objectList: ['$3'|makeObjectList('$3', '$4') ] .
predicateObjectList ->
  verb objectList: makeObjectList('$1', '$2') .

objectList ->
  object : ['$1'].

verb -> predicate : '$1'.

subject -> iri : '$1'.

predicate -> iri : '$1'.

object ->
  iri : '$1' .
object ->
  literal : '$1' .
object ->
  blankNodePropertyList : '$1' .

literal -> string : extract_token('$1') .

blankNodePropertyList ->
  l_bracket predicateObjectList r_bracket : { bnode, '$1' } .

prefixID ->
  p_leader pn_chars colon uriref eoln : { prefix, extract_token('$2'), extract_token('$4') } .

iri ->
  PrefixedName : '$1'.
iri ->
  uriref : extract_token('$1') .

PrefixedName ->
  pn_chars colon pn_chars : prefixed_name(extract_token('$1'), extract_token('$3')).

Erlang code.

extract_token({_Token, _Line, Value}) -> Value.

makeObjectList(Verb, List) -> lists:map(fun(X) -> { Verb, X } end, List) .
make_triples(Subject, List) -> { triples, lists:map(fun(X) -> { Subject, X } end, List) } .

prefixed_name(Prefix, Postfix) -> { prefixed, Prefix, Postfix } .
