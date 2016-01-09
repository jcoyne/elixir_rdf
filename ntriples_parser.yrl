Nonterminals lines line triple.
Terminals uriref string eoln.
Rootsymbol lines.

lines -> line : ['$1'].
lines -> line lines : ['$1'|'$2'].

line -> triple : ['$1'].
line -> eoln : [].

triple -> uriref uriref uriref eoln : { extract_token('$1'), extract_token('$2'), extract_token('$3') }.
triple -> uriref uriref string eoln : { extract_token('$1'), extract_token('$2'), extract_token('$3') }.

Erlang code.

extract_token({_Token, _Line, Value}) -> Value.
