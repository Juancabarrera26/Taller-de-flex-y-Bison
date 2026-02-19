%{
#include <stdlib.h>
#include "fb1-5.tab.h"
%}

%%
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
"+"         { return ADD; }
"-"         { return SUB; }
"*"         { return MUL; }
"/"         { return DIV; }
"|"         { return ABS; }
\n          { return EOL; }
[ \t]       { /* ignore whitespace */ }
.           { return yytext[0]; }
%%
