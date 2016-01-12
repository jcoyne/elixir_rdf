Definitions.

DOT        = \.
WHITESPACE = [\s\t\n\r]
URIREF     = <[^>]*>
STRING     = \".*\"

Rules.

{WHITESPACE}*{DOT}{WHITESPACE}*  : {token, {eoln, TokenLine}}.
{URIREF}                         : {token, {uriref, TokenLine, TokenChars}}.
{STRING}                         : {token, {string, TokenLine, TokenChars}}.
{DOT}                            : {token, {'.', TokenLine}}.
{WHITESPACE}+                    : skip_token.


Erlang code.
