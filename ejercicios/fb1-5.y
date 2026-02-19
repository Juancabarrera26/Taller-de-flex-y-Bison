/* Chapter 1 exercises: calculator with empty lines, AND/OR, decimal+hex output */
%{
#include <stdio.h>

int yylex(void);
int yyerror(char *s);
%}

/* declare tokens */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token AND OR
%token EOL

/* precedence (lowest to highest) */
%left OR
%left AND
%left ADD SUB
%left MUL DIV
%right ABS

%%

calclist:
      /* nothing */
    | calclist EOL                { /* empty line or comment-only line */ }
    | calclist exp EOL            { printf("= %d (0x%X)\n", $2, (unsigned)$2); }
    ;

exp:
      factor
    | exp ADD factor              { $$ = $1 + $3; }
    | exp SUB factor              { $$ = $1 - $3; }
    | exp AND factor              { $$ = $1 & $3; }
    | exp OR  factor              { $$ = $1 | $3; }
    ;

factor:
      term
    | factor MUL term             { $$ = $1 * $3; }
    | factor DIV term             { $$ = $1 / $3; }
    ;

term:
      NUMBER
    | ABS term                    { $$ = $2 >= 0 ? $2 : -$2; }
    ;

%%

int main(int argc, char **argv)
{
    yyparse();
    return 0;
}

int yyerror(char *s)
{
    fprintf(stderr, "error: %s\n", s);
    return 0;
}

