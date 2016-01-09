Nonterminals lines triple.
Terminals uriref string eoln.
Rootsymbol lines.

lines -> triple : ['$1'].
lines -> triple lines : ['$1'|'$2'].

triple -> uriref uriref uriref eoln : { extract_token('$1'), extract_token('$2'), extract_token('$3') }.
triple -> uriref uriref string eoln : { extract_token('$1'), extract_token('$2'), extract_token('$3') }.

Erlang code.

extract_token({_Token, _Line, Value}) -> Value.
