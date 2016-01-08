Definitions.

URI        = (([^<:/?#]+):)?(//([^</?#>]*))?([^<?#>]*)(\?([^#>]*))?(#(.*))?
WHITESPACE = [\s\t\n\r]

Rules.

<             : {token, {'<',  TokenLine}}.
>             : {token, {'>',  TokenLine}}.
{URI}         : {token, {uri, TokenLine, TokenChars}}.
{WHITESPACE}+ : skip_token.


Erlang code.
