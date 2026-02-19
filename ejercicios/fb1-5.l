%{
#include <stdlib.h>
#include "fb1-5.tab.h"
%}

%%
"//".*                { return EOL; }

0[xX][0-9a-fA-F]+      { yylval = (int)strtol(yytext, NULL, 0);  return NUMBER; }
[0-9]+                 { yylval = (int)strtol(yytext, NULL, 10); return NUMBER; }

"+"                    { return ADD; }
"-"                    { return SUB; }
"*"                    { return MUL; }
"/"                    { return DIV; }
"|"                    { return ABS; }

"&"                    { return AND; }
"OR"                   { return OR; }

\n                     { return EOL; }
[ \t]+                 { /* ignore whitespace */ }

.                      { return yytext[0]; }
%%

