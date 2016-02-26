Definitions.

DOT        = \.
WHITESPACE = [\s\t\n\r]
URIREF     = <[^>]*>
STRING     = \".*\"
PRE_DEF    = @prefix
PN_CHARS   = [A-Za-z]*
COLON      = :
SEMICOLON  = ;
L_BRACKET  = \[
R_BRACKET  = \]

Rules.

{PRE_DEF}                        : {token, {p_leader, TokenLine}}.
{PN_CHARS}                       : {token, {pn_chars, TokenLine, TokenChars}}.
{L_BRACKET}                      : {token, {l_bracket, TokenLine}}.
{R_BRACKET}                      : {token, {r_bracket, TokenLine}}.
{COLON}                          : {token, {colon, TokenLine}}.
{SEMICOLON}                      : {token, {semicolon, TokenLine}}.
{WHITESPACE}*{DOT}{WHITESPACE}*  : {token, {eoln, TokenLine}}.
{URIREF}                         : {token, {uriref, TokenLine, TokenChars}}.
{STRING}                         : {token, {string, TokenLine, TokenChars}}.
{DOT}                            : {token, {'.', TokenLine}}.
{WHITESPACE}+                    : skip_token.


Erlang code.

