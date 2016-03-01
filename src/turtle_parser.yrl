Nonterminals
  turtleDoc statement directive triples predicateObjectList objectList
  verb subject predicate object literal RDFLiteral BooleanLiteral
  blankNodePropertyList prefixID iri PrefixedName .

Terminals
  a typedef comma colon semicolon p_leader pn_chars uriref string eoln
  l_bracket r_bracket true false langtag.

Rootsymbol
  turtleDoc.

turtleDoc ->
  statement turtleDoc : ['$1'|'$2'] .
turtleDoc ->
  statement : ['$1'] .

statement ->
  triples eoln : '$1' .
statement ->
  directive : '$1' .

directive ->
  prefixID : '$1' .

triples ->
  subject predicateObjectList : {subject, '$1', '$2'} .

predicateObjectList ->
  verb objectList semicolon predicateObjectList : [{predicateObjectList, '$1', '$2'}|'$4'] .
predicateObjectList ->
  verb objectList: {predicateObjectList, '$1', '$2'} .

objectList ->
  object comma objectList : ['$1'|'$3'].
objectList ->
  object : ['$1'].

verb ->
  predicate : '$1'.
verb ->
  a : { prefixed, "rdf", "type" } .

subject -> iri : '$1'.

predicate -> iri : '$1'.

object ->
  iri : '$1' .
object ->
  literal : '$1' .
object ->
  blankNodePropertyList : '$1' .

literal ->
  RDFLiteral : '$1' .
literal ->
  BooleanLiteral : '$1' .

blankNodePropertyList ->
  l_bracket predicateObjectList r_bracket : { bnode, '$2' } .

RDFLiteral ->
  string langtag: {literal, extract_token('$1'), extract_token('$2') } .
RDFLiteral ->
  string : {literal, extract_token('$1') } .
RDFLiteral ->
  string typedef iri : {literal, extract_token('$1'), '$3' } .

BooleanLiteral ->
  true : true .
BooleanLiteral ->
  false : false .

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

makeObjectList(Verb, List) ->
  lists:map(fun(X) -> { Verb, X } end, List) .

make_triples(Subject, List) ->
  { triples, lists:map(fun(X) -> { Subject, X } end, List) } .

prefixed_name(Prefix, Postfix) -> { prefixed, Prefix, Postfix } .
